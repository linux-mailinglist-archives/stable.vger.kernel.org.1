Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB737D34E6
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjJWLnm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjJWLnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:43:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9468410D9
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:43:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D626AC433B8;
        Mon, 23 Oct 2023 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061400;
        bh=zlxlxWA7JkjYzxqIc6S63rO3HVlESyq6xM7KKuasTsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhHgZWpFIEn+4T6pMyJ672DdfXvsW5OukrrwcjTlhe5lUHsCVJO3BZmqtP6BX/TB1
         075doe9iUbu+h2TO9+N+VLRphsMnMd2A5otT/YfhIxyfMHqCQ/WEKUlMXb2+AGjMO9
         fQfWRZM4sp89p+p8+RpRGuwQs8YKion5KBKtGqPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Whitney <enwlinux@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5.10 008/202] quota: Fix slow quotaoff
Date:   Mon, 23 Oct 2023 12:55:15 +0200
Message-ID: <20231023104826.834760260@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 869b6ea1609f655a43251bf41757aa44e5350a8f upstream.

Eric has reported that commit dabc8b207566 ("quota: fix dqput() to
follow the guarantees dquot_srcu should provide") heavily increases
runtime of generic/270 xfstest for ext4 in nojournal mode. The reason
for this is that ext4 in nojournal mode leaves dquots dirty until the last
dqput() and thus the cleanup done in quota_release_workfn() has to write
them all. Due to the way quota_release_workfn() is written this results
in synchronize_srcu() call for each dirty dquot which makes the dquot
cleanup when turning quotas off extremely slow.

To be able to avoid synchronize_srcu() for each dirty dquot we need to
rework how we track dquots to be cleaned up. Instead of keeping the last
dquot reference while it is on releasing_dquots list, we drop it right
away and mark the dquot with new DQ_RELEASING_B bit instead. This way we
can we can remove dquot from releasing_dquots list when new reference to
it is acquired and thus there's no need to call synchronize_srcu() each
time we drop dq_list_lock.

References: https://lore.kernel.org/all/ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64
Reported-by: Eric Whitney <enwlinux@gmail.com>
Fixes: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/quota/dquot.c         |   66 +++++++++++++++++++++++++++--------------------
 include/linux/quota.h    |    4 ++
 include/linux/quotaops.h |    2 -
 3 files changed, 43 insertions(+), 29 deletions(-)

--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -233,19 +233,18 @@ static void put_quota_format(struct quot
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
- * When the last reference of a dquot will be dropped, the dquot will be
- * added to releasing_dquots. We'd then queue work item which would call
+ * When the last reference of a dquot is dropped, the dquot is added to
+ * releasing_dquots. We'll then queue work item which will call
  * synchronize_srcu() and after that perform the final cleanup of all the
- * dquots on the list. Both releasing_dquots and free_dquots use the
- * dq_free list_head in the dquot struct. When a dquot is removed from
- * releasing_dquots, a reference count is always subtracted, and if
- * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ * dquots on the list. Each cleaned up dquot is moved to free_dquots list.
+ * Both releasing_dquots and free_dquots use the dq_free list_head in the dquot
+ * struct.
  *
- * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
- * and this list is searched whenever we need an available dquot.  Dquots are
- * removed from the list as soon as they are used again, and
- * dqstats.free_dquots gives the number of dquots on the list. When
- * dquot is invalidated it's completely released from memory.
+ * Unused and cleaned up dquots are in the free_dquots list and this list is
+ * searched whenever we need an available dquot. Dquots are removed from the
+ * list as soon as they are used again and dqstats.free_dquots gives the number
+ * of dquots on the list. When dquot is invalidated it's completely released
+ * from memory.
  *
  * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
  * dirtied, and this list is searched when writing dirty dquots back to
@@ -323,6 +322,7 @@ static inline void put_dquot_last(struct
 static inline void put_releasing_dquots(struct dquot *dquot)
 {
 	list_add_tail(&dquot->dq_free, &releasing_dquots);
+	set_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void remove_free_dquot(struct dquot *dquot)
@@ -330,8 +330,10 @@ static inline void remove_free_dquot(str
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	if (!atomic_read(&dquot->dq_count))
+	if (!test_bit(DQ_RELEASING_B, &dquot->dq_flags))
 		dqstats_dec(DQST_FREE_DQUOTS);
+	else
+		clear_bit(DQ_RELEASING_B, &dquot->dq_flags);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -583,12 +585,6 @@ restart:
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			/* dquot in releasing_dquots, flush and retry */
-			if (!list_empty(&dquot->dq_free)) {
-				spin_unlock(&dq_list_lock);
-				goto restart;
-			}
-
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -608,6 +604,15 @@ restart:
 			goto restart;
 		}
 		/*
+		 * The last user already dropped its reference but dquot didn't
+		 * get fully cleaned up yet. Restart the scan which flushes the
+		 * work cleaning up released dquots.
+		 */
+		if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+			spin_unlock(&dq_list_lock);
+			goto restart;
+		}
+		/*
 		 * Quota now has no users and it has been written on last
 		 * dqput()
 		 */
@@ -698,6 +703,13 @@ int dquot_writeback_dquots(struct super_
 						 dq_dirty);
 
 			WARN_ON(!dquot_active(dquot));
+			/* If the dquot is releasing we should not touch it */
+			if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
+				spin_unlock(&dq_list_lock);
+				flush_delayed_work(&quota_release_work);
+				spin_lock(&dq_list_lock);
+				continue;
+			}
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
@@ -811,18 +823,18 @@ static void quota_release_workfn(struct
 	/* Exchange the list head to avoid livelock. */
 	list_replace_init(&releasing_dquots, &rls_head);
 	spin_unlock(&dq_list_lock);
+	synchronize_srcu(&dquot_srcu);
 
 restart:
-	synchronize_srcu(&dquot_srcu);
 	spin_lock(&dq_list_lock);
 	while (!list_empty(&rls_head)) {
 		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
-		/* Dquot got used again? */
-		if (atomic_read(&dquot->dq_count) > 1) {
-			remove_free_dquot(dquot);
-			atomic_dec(&dquot->dq_count);
-			continue;
-		}
+		WARN_ON_ONCE(atomic_read(&dquot->dq_count));
+		/*
+		 * Note that DQ_RELEASING_B protects us from racing with
+		 * invalidate_dquots() calls so we are safe to work with the
+		 * dquot even after we drop dq_list_lock.
+		 */
 		if (dquot_dirty(dquot)) {
 			spin_unlock(&dq_list_lock);
 			/* Commit dquot before releasing */
@@ -836,7 +848,6 @@ restart:
 		}
 		/* Dquot is inactive and clean, now move it to free list */
 		remove_free_dquot(dquot);
-		atomic_dec(&dquot->dq_count);
 		put_dquot_last(dquot);
 	}
 	spin_unlock(&dq_list_lock);
@@ -877,6 +888,7 @@ void dqput(struct dquot *dquot)
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
 	put_releasing_dquots(dquot);
+	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
 	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
@@ -965,7 +977,7 @@ we_slept:
 		dqstats_inc(DQST_LOOKUPS);
 	}
 	/* Wait for dq_lock - after this we know that either dquot_release() is
-	 * already finished or it will be canceled due to dq_count > 1 test */
+	 * already finished or it will be canceled due to dq_count > 0 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
 	if (!dquot_active(dquot)) {
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -285,7 +285,9 @@ static inline void dqstats_dec(unsigned
 #define DQ_FAKE_B	3	/* no limits only usage */
 #define DQ_READ_B	4	/* dquot was read into memory */
 #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
-#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
+#define DQ_RELEASING_B	6	/* dquot is in releasing_dquots list waiting
+				 * to be cleaned up */
+#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
 				 * for the mask of entries set via SETQUOTA\
 				 * quotactl. They are set under dq_data_lock\
 				 * and the quota format handling dquot can\
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -56,7 +56,7 @@ static inline bool dquot_is_busy(struct
 {
 	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
 		return true;
-	if (atomic_read(&dquot->dq_count) > 1)
+	if (atomic_read(&dquot->dq_count) > 0)
 		return true;
 	return false;
 }


