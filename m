Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A810878AB11
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjH1K1g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjH1K1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7488B132
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0033C63AEB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12404C433C8;
        Mon, 28 Aug 2023 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218421;
        bh=kczML/wluxw+zlNBGLcqEbjDir/J+vHGIPtYKlO+5hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ems3vWDUhvaKj8Cyo/v8yHUZfjWvXE6Fl+s8ErJmQ+ewGnOPtFYY5sjWZXWoJH100
         BhEA8StP8GlgJmu7mvEcJg1Ef9fKZv+8KyseXWkqyI3hlAXawvVq/wz3HZ+bFVE6DQ
         2Rm32xJrA+hGETqqdzKDb5Gg300aX68K351jV0Kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakob Koschel <jakobkoschel@gmail.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/129] dlm: replace usage of found with dedicated list iterator variable
Date:   Mon, 28 Aug 2023 12:12:55 +0200
Message-ID: <20230828101156.321032444@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit dc1acd5c94699389a9ed023e94dd860c846ea1f6 ]

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lock.c    | 53 +++++++++++++++++++++++-------------------------
 fs/dlm/plock.c   | 24 +++++++++++-----------
 fs/dlm/recover.c | 39 +++++++++++++++++------------------
 3 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index d4e204473e76b..0864481d8551c 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1858,7 +1858,7 @@ static void del_timeout(struct dlm_lkb *lkb)
 void dlm_scan_timeout(struct dlm_ls *ls)
 {
 	struct dlm_rsb *r;
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	int do_cancel, do_warn;
 	s64 wait_us;
 
@@ -1869,27 +1869,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
 		do_cancel = 0;
 		do_warn = 0;
 		mutex_lock(&ls->ls_timeout_mutex);
-		list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) {
+		list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list) {
 
 			wait_us = ktime_to_us(ktime_sub(ktime_get(),
-					      		lkb->lkb_timestamp));
+							iter->lkb_timestamp));
 
-			if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
-			    wait_us >= (lkb->lkb_timeout_cs * 10000))
+			if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
+			    wait_us >= (iter->lkb_timeout_cs * 10000))
 				do_cancel = 1;
 
-			if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
+			if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
 			    wait_us >= dlm_config.ci_timewarn_cs * 10000)
 				do_warn = 1;
 
 			if (!do_cancel && !do_warn)
 				continue;
-			hold_lkb(lkb);
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 		mutex_unlock(&ls->ls_timeout_mutex);
 
-		if (!do_cancel && !do_warn)
+		if (!lkb)
 			break;
 
 		r = lkb->lkb_resource;
@@ -5243,21 +5244,18 @@ void dlm_recover_waiters_pre(struct dlm_ls *ls)
 
 static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
-	struct dlm_lkb *lkb;
-	int found = 0;
+	struct dlm_lkb *lkb = NULL, *iter;
 
 	mutex_lock(&ls->ls_waiters_mutex);
-	list_for_each_entry(lkb, &ls->ls_waiters, lkb_wait_reply) {
-		if (lkb->lkb_flags & DLM_IFL_RESEND) {
-			hold_lkb(lkb);
-			found = 1;
+	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
+		if (iter->lkb_flags & DLM_IFL_RESEND) {
+			hold_lkb(iter);
+			lkb = iter;
 			break;
 		}
 	}
 	mutex_unlock(&ls->ls_waiters_mutex);
 
-	if (!found)
-		lkb = NULL;
 	return lkb;
 }
 
@@ -5916,37 +5914,36 @@ int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 		     int mode, uint32_t flags, void *name, unsigned int namelen,
 		     unsigned long timeout_cs, uint32_t *lkid)
 {
-	struct dlm_lkb *lkb;
+	struct dlm_lkb *lkb = NULL, *iter;
 	struct dlm_user_args *ua;
 	int found_other_mode = 0;
-	int found = 0;
 	int rv = 0;
 
 	mutex_lock(&ls->ls_orphans_mutex);
-	list_for_each_entry(lkb, &ls->ls_orphans, lkb_ownqueue) {
-		if (lkb->lkb_resource->res_length != namelen)
+	list_for_each_entry(iter, &ls->ls_orphans, lkb_ownqueue) {
+		if (iter->lkb_resource->res_length != namelen)
 			continue;
-		if (memcmp(lkb->lkb_resource->res_name, name, namelen))
+		if (memcmp(iter->lkb_resource->res_name, name, namelen))
 			continue;
-		if (lkb->lkb_grmode != mode) {
+		if (iter->lkb_grmode != mode) {
 			found_other_mode = 1;
 			continue;
 		}
 
-		found = 1;
-		list_del_init(&lkb->lkb_ownqueue);
-		lkb->lkb_flags &= ~DLM_IFL_ORPHAN;
-		*lkid = lkb->lkb_id;
+		lkb = iter;
+		list_del_init(&iter->lkb_ownqueue);
+		iter->lkb_flags &= ~DLM_IFL_ORPHAN;
+		*lkid = iter->lkb_id;
 		break;
 	}
 	mutex_unlock(&ls->ls_orphans_mutex);
 
-	if (!found && found_other_mode) {
+	if (!lkb && found_other_mode) {
 		rv = -EAGAIN;
 		goto out;
 	}
 
-	if (!found) {
+	if (!lkb) {
 		rv = -ENOENT;
 		goto out;
 	}
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 5f3643890f1e0..7e26e677c6b24 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -437,9 +437,9 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 			 loff_t *ppos)
 {
+	struct plock_op *op = NULL, *iter;
 	struct dlm_plock_info info;
-	struct plock_op *op;
-	int found = 0, do_callback = 0;
+	int do_callback = 0;
 
 	if (count != sizeof(info))
 		return -EINVAL;
@@ -451,23 +451,23 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		return -EINVAL;
 
 	spin_lock(&ops_lock);
-	list_for_each_entry(op, &recv_list, list) {
-		if (op->info.fsid == info.fsid &&
-		    op->info.number == info.number &&
-		    op->info.owner == info.owner) {
-			list_del_init(&op->list);
-			memcpy(&op->info, &info, sizeof(info));
-			if (op->data)
+	list_for_each_entry(iter, &recv_list, list) {
+		if (iter->info.fsid == info.fsid &&
+		    iter->info.number == info.number &&
+		    iter->info.owner == info.owner) {
+			list_del_init(&iter->list);
+			memcpy(&iter->info, &info, sizeof(info));
+			if (iter->data)
 				do_callback = 1;
 			else
-				op->done = 1;
-			found = 1;
+				iter->done = 1;
+			op = iter;
 			break;
 		}
 	}
 	spin_unlock(&ops_lock);
 
-	if (found) {
+	if (op) {
 		if (do_callback)
 			dlm_plock_callback(op);
 		else
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index ce2aa54ca2e24..98b710cc9cf30 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -734,10 +734,9 @@ void dlm_recovered_lock(struct dlm_rsb *r)
 
 static void recover_lvb(struct dlm_rsb *r)
 {
-	struct dlm_lkb *lkb, *high_lkb = NULL;
+	struct dlm_lkb *big_lkb = NULL, *iter, *high_lkb = NULL;
 	uint32_t high_seq = 0;
 	int lock_lvb_exists = 0;
-	int big_lock_exists = 0;
 	int lvblen = r->res_ls->ls_lvblen;
 
 	if (!rsb_flag(r, RSB_NEW_MASTER2) &&
@@ -753,37 +752,37 @@ static void recover_lvb(struct dlm_rsb *r)
 	/* we are the new master, so figure out if VALNOTVALID should
 	   be set, and set the rsb lvb from the best lkb available. */
 
-	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_grantqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			big_lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
-	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+	list_for_each_entry(iter, &r->res_convertqueue, lkb_statequeue) {
+		if (!(iter->lkb_exflags & DLM_LKF_VALBLK))
 			continue;
 
 		lock_lvb_exists = 1;
 
-		if (lkb->lkb_grmode > DLM_LOCK_CR) {
-			big_lock_exists = 1;
+		if (iter->lkb_grmode > DLM_LOCK_CR) {
+			big_lkb = iter;
 			goto setflag;
 		}
 
-		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
-			high_lkb = lkb;
-			high_seq = lkb->lkb_lvbseq;
+		if (((int)iter->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = iter;
+			high_seq = iter->lkb_lvbseq;
 		}
 	}
 
@@ -792,7 +791,7 @@ static void recover_lvb(struct dlm_rsb *r)
 		goto out;
 
 	/* lvb is invalidated if only NL/CR locks remain */
-	if (!big_lock_exists)
+	if (!big_lkb)
 		rsb_set_flag(r, RSB_VALNOTVALID);
 
 	if (!r->res_lvbptr) {
@@ -801,9 +800,9 @@ static void recover_lvb(struct dlm_rsb *r)
 			goto out;
 	}
 
-	if (big_lock_exists) {
-		r->res_lvbseq = lkb->lkb_lvbseq;
-		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, lvblen);
+	if (big_lkb) {
+		r->res_lvbseq = big_lkb->lkb_lvbseq;
+		memcpy(r->res_lvbptr, big_lkb->lkb_lvbptr, lvblen);
 	} else if (high_lkb) {
 		r->res_lvbseq = high_lkb->lkb_lvbseq;
 		memcpy(r->res_lvbptr, high_lkb->lkb_lvbptr, lvblen);
-- 
2.40.1



