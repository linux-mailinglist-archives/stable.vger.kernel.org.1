Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459987A37C3
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbjIQTYs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbjIQTYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68ACDB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EB5C433C7;
        Sun, 17 Sep 2023 19:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978664;
        bh=oubHAuaGvHYGTFapGQM0uT2crPWSr2v2t7+3DHW6IFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JU4uAmxNlmbhycn8yME48ec2o9PM6Bcvh64U5dl27/x2wi/RZRSBn5lnsfTyeOEP1
         /1w9zmfCsZlkrrjxzg4XvyoBo6IeYchuGHsoCvy3NhsHxcodZHDVxNBEy91aXTrucn
         qjZET8f7++yuPmDxacttC1pD8qFsm4lsXBQpKrO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 125/406] quota: add new helper dquot_active()
Date:   Sun, 17 Sep 2023 21:09:39 +0200
Message-ID: <20230917191104.447463339@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 33bcfafc48cb186bc4bbcea247feaa396594229e ]

Add new helper function dquot_active() to make the code more concise.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230630110822.3881712-4-libaokun1@huawei.com>
Stable-dep-of: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/quota/dquot.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index bbe748bb9a0d5..202d97c2c5cb2 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -338,6 +338,11 @@ static void wait_on_dquot(struct dquot *dquot)
 	mutex_unlock(&dquot->dq_lock);
 }
 
+static inline int dquot_active(struct dquot *dquot)
+{
+	return test_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+}
+
 static inline int dquot_dirty(struct dquot *dquot)
 {
 	return test_bit(DQ_MOD_B, &dquot->dq_flags);
@@ -353,14 +358,14 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 {
 	int ret = 1;
 
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (!dquot_active(dquot))
 		return 0;
 
 	if (sb_dqopt(dquot->dq_sb)->flags & DQUOT_NOLIST_DIRTY)
 		return test_and_set_bit(DQ_MOD_B, &dquot->dq_flags);
 
 	/* If quota is dirty already, we don't have to acquire dq_list_lock */
-	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
+	if (dquot_dirty(dquot))
 		return 1;
 
 	spin_lock(&dq_list_lock);
@@ -442,7 +447,7 @@ int dquot_acquire(struct dquot *dquot)
 	smp_mb__before_atomic();
 	set_bit(DQ_READ_B, &dquot->dq_flags);
 	/* Instantiate dquot if needed */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && !dquot->dq_off) {
+	if (!dquot_active(dquot) && !dquot->dq_off) {
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 		/* Write the info if needed */
 		if (info_dirty(&dqopt->info[dquot->dq_id.type])) {
@@ -484,7 +489,7 @@ int dquot_commit(struct dquot *dquot)
 		goto out_lock;
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (dquot_active(dquot))
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 	else
 		ret = -EIO;
@@ -599,7 +604,7 @@ int dquot_scan_active(struct super_block *sb,
 
 	spin_lock(&dq_list_lock);
 	list_for_each_entry(dquot, &inuse_list, dq_inuse) {
-		if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+		if (!dquot_active(dquot))
 			continue;
 		if (dquot->dq_sb != sb)
 			continue;
@@ -614,7 +619,7 @@ int dquot_scan_active(struct super_block *sb,
 		 * outstanding call and recheck the DQ_ACTIVE_B after that.
 		 */
 		wait_on_dquot(dquot);
-		if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+		if (dquot_active(dquot)) {
 			ret = fn(dquot, priv);
 			if (ret < 0)
 				goto out;
@@ -665,7 +670,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			dquot = list_first_entry(&dirty, struct dquot,
 						 dq_dirty);
 
-			WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
+			WARN_ON(!dquot_active(dquot));
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
@@ -802,7 +807,7 @@ void dqput(struct dquot *dquot)
 		dquot_write_dquot(dquot);
 		goto we_slept;
 	}
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (dquot_active(dquot)) {
 		spin_unlock(&dq_list_lock);
 		dquot->dq_sb->dq_op->release_dquot(dquot);
 		goto we_slept;
@@ -903,7 +908,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * already finished or it will be canceled due to dq_count > 1 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (!dquot_active(dquot)) {
 		int err;
 
 		err = sb->dq_op->acquire_dquot(dquot);
-- 
2.40.1



