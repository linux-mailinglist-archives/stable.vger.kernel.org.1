Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BE76AD08
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHAJZf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjHAJZT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09AF4221
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B96561505
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7866C433C9;
        Tue,  1 Aug 2023 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881841;
        bh=bv2PSAVRbGg+3oRSYoBHnwRRW2OdEbYtYDgnpivWkmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8/H1pj9MctG11HN7pma7liAjFDD9ty2TjYL4CDKPK4R4Bchoo4/Yq0mR9Fn9i+9P
         WA1n/xSTAZIAZ8pIYtCDOu0onMty6ya65LFF9kfujkAi66aWZ+CNNLHcnSk+icW2ZX
         7ihxc7Nx5hzdm4bbz5hDMtCH09ZiNIWhQvaC08Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/155] dlm: cleanup plock_op vs plock_xop
Date:   Tue,  1 Aug 2023 11:18:51 +0200
Message-ID: <20230801091910.890162885@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit bcbb4ba6c9ba81e6975b642a2cade68044cd8a66 ]

Lately the different casting between plock_op and plock_xop and list
holders which was involved showed some issues which were hard to see.
This patch removes the "plock_xop" structure and introduces a
"struct plock_async_data". This structure will be set in "struct plock_op"
in case of asynchronous lock handling as the original "plock_xop" was
made for. There is no need anymore to cast pointers around for
additional fields in case of asynchronous lock handling.  As disadvantage
another allocation was introduces but only needed in the asynchronous
case which is currently only used in combination with nfs lockd.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 59e45c758ca1 ("fs: dlm: interrupt posix locks only when process is killed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 77 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index edce0b25cd90e..e70e23eca03ec 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -19,20 +19,20 @@ static struct list_head recv_list;
 static wait_queue_head_t send_wq;
 static wait_queue_head_t recv_wq;
 
-struct plock_op {
-	struct list_head list;
-	int done;
-	struct dlm_plock_info info;
-	int (*callback)(struct file_lock *fl, int result);
-};
-
-struct plock_xop {
-	struct plock_op xop;
+struct plock_async_data {
 	void *fl;
 	void *file;
 	struct file_lock flc;
+	int (*callback)(struct file_lock *fl, int result);
 };
 
+struct plock_op {
+	struct list_head list;
+	int done;
+	struct dlm_plock_info info;
+	/* if set indicates async handling */
+	struct plock_async_data *data;
+};
 
 static inline void set_version(struct dlm_plock_info *info)
 {
@@ -58,6 +58,12 @@ static int check_version(struct dlm_plock_info *info)
 	return 0;
 }
 
+static void dlm_release_plock_op(struct plock_op *op)
+{
+	kfree(op->data);
+	kfree(op);
+}
+
 static void send_op(struct plock_op *op)
 {
 	set_version(&op->info);
@@ -101,22 +107,21 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
 int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		   int cmd, struct file_lock *fl)
 {
+	struct plock_async_data *op_data;
 	struct dlm_ls *ls;
 	struct plock_op *op;
-	struct plock_xop *xop;
 	int rv;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
 		return -EINVAL;
 
-	xop = kzalloc(sizeof(*xop), GFP_NOFS);
-	if (!xop) {
+	op = kzalloc(sizeof(*op), GFP_NOFS);
+	if (!op) {
 		rv = -ENOMEM;
 		goto out;
 	}
 
-	op = &xop->xop;
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
 	op->info.pid		= fl->fl_pid;
 	op->info.ex		= (fl->fl_type == F_WRLCK);
@@ -125,22 +130,32 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
+	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
+		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
+		if (!op_data) {
+			dlm_release_plock_op(op);
+			rv = -ENOMEM;
+			goto out;
+		}
+
 		/* fl_owner is lockd which doesn't distinguish
 		   processes on the nfs client */
 		op->info.owner	= (__u64) fl->fl_pid;
-		op->callback	= fl->fl_lmops->lm_grant;
-		locks_init_lock(&xop->flc);
-		locks_copy_lock(&xop->flc, fl);
-		xop->fl		= fl;
-		xop->file	= file;
+		op_data->callback = fl->fl_lmops->lm_grant;
+		locks_init_lock(&op_data->flc);
+		locks_copy_lock(&op_data->flc, fl);
+		op_data->fl		= fl;
+		op_data->file	= file;
+
+		op->data = op_data;
 	} else {
 		op->info.owner	= (__u64)(long) fl->fl_owner;
 	}
 
 	send_op(op);
 
-	if (!op->callback) {
+	if (!op->data) {
 		rv = wait_event_interruptible(recv_wq, (op->done != 0));
 		if (rv == -ERESTARTSYS) {
 			log_debug(ls, "dlm_posix_lock: wait killed %llx",
@@ -148,7 +163,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 			spin_lock(&ops_lock);
 			list_del(&op->list);
 			spin_unlock(&ops_lock);
-			kfree(xop);
+			dlm_release_plock_op(op);
 			do_unlock_close(ls, number, file, fl);
 			goto out;
 		}
@@ -173,7 +188,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 				  (unsigned long long)number);
 	}
 
-	kfree(xop);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -183,11 +198,11 @@ EXPORT_SYMBOL_GPL(dlm_posix_lock);
 /* Returns failure iff a successful lock operation should be canceled */
 static int dlm_plock_callback(struct plock_op *op)
 {
+	struct plock_async_data *op_data = op->data;
 	struct file *file;
 	struct file_lock *fl;
 	struct file_lock *flc;
 	int (*notify)(struct file_lock *fl, int result) = NULL;
-	struct plock_xop *xop = (struct plock_xop *)op;
 	int rv = 0;
 
 	spin_lock(&ops_lock);
@@ -199,10 +214,10 @@ static int dlm_plock_callback(struct plock_op *op)
 	spin_unlock(&ops_lock);
 
 	/* check if the following 2 are still valid or make a copy */
-	file = xop->file;
-	flc = &xop->flc;
-	fl = xop->fl;
-	notify = op->callback;
+	file = op_data->file;
+	flc = &op_data->flc;
+	fl = op_data->fl;
+	notify = op_data->callback;
 
 	if (op->info.rv) {
 		notify(fl, op->info.rv);
@@ -233,7 +248,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 out:
-	kfree(xop);
+	dlm_release_plock_op(op);
 	return rv;
 }
 
@@ -303,7 +318,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 
 out_free:
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	fl->fl_flags = fl_flags;
@@ -371,7 +386,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		rv = 0;
 	}
 
-	kfree(op);
+	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
 	return rv;
@@ -407,7 +422,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	   (the process did not make an unlock call). */
 
 	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
-		kfree(op);
+		dlm_release_plock_op(op);
 
 	if (copy_to_user(u, &info, sizeof(info)))
 		return -EFAULT;
@@ -439,7 +454,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		    op->info.owner == info.owner) {
 			list_del_init(&op->list);
 			memcpy(&op->info, &info, sizeof(info));
-			if (op->callback)
+			if (op->data)
 				do_callback = 1;
 			else
 				op->done = 1;
-- 
2.39.2



