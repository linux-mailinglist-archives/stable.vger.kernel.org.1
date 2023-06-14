Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E469F726DEA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjFGUqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjFGUqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C31BD3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8846D64694
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1F2C433D2;
        Wed,  7 Jun 2023 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170766;
        bh=auZR0VLZgU55HB/TB056KRVHfWp+WNnYe83xIggsiIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEN99TmCeNR96kqnwXGLKUYCd0ydFUmbbJR3Nw/46YSLn2FLs4ViciV1e9FDnommK
         09TRWSwW8vS3HFycoMwddzhg1GZoAlKuY3pXv6xkAqa8gaLqavaRPDvzSt/4sXzdID
         YP2zLdwf+fhisU/NHguBPVgharPSp+IYjy6yLh2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Per Forlin <per.forlin@axis.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 209/225] ksmbd: fix UAF issue from opinfo->conn
Date:   Wed,  7 Jun 2023 22:16:42 +0200
Message-ID: <20230607200921.199456853@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

commit 36322523dddb11107e9f7f528675a0dec2536103 upstream.

If opinfo->conn is another connection and while ksmbd send oplock break
request to cient on current connection, The connection for opinfo->conn
can be disconnect and conn could be freed. When sending oplock break
request, this ksmbd_conn can be used and cause user-after-free issue.
When getting opinfo from the list, ksmbd check connection is being
released. If it is not released, Increase ->r_count to wait that connection
is freed.

Cc: stable@vger.kernel.org
Reported-by: Per Forlin <per.forlin@axis.com>
Tested-by: Per Forlin <per.forlin@axis.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/oplock.c |   72 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 25 deletions(-)

--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -157,13 +157,42 @@ static struct oplock_info *opinfo_get_li
 	rcu_read_lock();
 	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
 					op_entry);
-	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
-		opinfo = NULL;
+	if (opinfo) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			opinfo = NULL;
+		else {
+			atomic_inc(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				atomic_dec(&opinfo->conn->r_count);
+				atomic_dec(&opinfo->refcount);
+				opinfo = NULL;
+			}
+		}
+	}
+
 	rcu_read_unlock();
 
 	return opinfo;
 }
 
+static void opinfo_conn_put(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn;
+
+	if (!opinfo)
+		return;
+
+	conn = opinfo->conn;
+	/*
+	 * Checking waitqueue to dropping pending requests on
+	 * disconnection. waitqueue_active is safe because it
+	 * uses atomic operation for condition.
+	 */
+	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
+		wake_up(&conn->r_count_q);
+	opinfo_put(opinfo);
+}
+
 void opinfo_put(struct oplock_info *opinfo)
 {
 	if (!atomic_dec_and_test(&opinfo->refcount))
@@ -666,13 +695,6 @@ static void __smb2_oplock_break_noti(str
 
 out:
 	ksmbd_free_work_struct(work);
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -706,7 +728,6 @@ static int smb2_oplock_break_noti(struct
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		INIT_WORK(&work->work, __smb2_oplock_break_noti);
 		ksmbd_queue_work(work);
@@ -776,13 +797,6 @@ static void __smb2_lease_break_noti(stru
 
 out:
 	ksmbd_free_work_struct(work);
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
 }
 
 /**
@@ -822,7 +836,6 @@ static int smb2_lease_break_noti(struct
 	work->conn = conn;
 	work->sess = opinfo->sess;
 
-	atomic_inc(&conn->r_count);
 	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
 		list_for_each_safe(tmp, t, &opinfo->interim_list) {
 			struct ksmbd_work *in_work;
@@ -1144,8 +1157,10 @@ int smb_grant_oplock(struct ksmbd_work *
 	}
 	prev_opinfo = opinfo_get_list(ci);
 	if (!prev_opinfo ||
-	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx))
+	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx)) {
+		opinfo_conn_put(prev_opinfo);
 		goto set_lev;
+	}
 	prev_op_has_lease = prev_opinfo->is_lease;
 	if (prev_op_has_lease)
 		prev_op_state = prev_opinfo->o_lease->state;
@@ -1153,19 +1168,19 @@ int smb_grant_oplock(struct ksmbd_work *
 	if (share_ret < 0 &&
 	    prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
 		err = share_ret;
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto err_out;
 	}
 
 	if (prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(prev_opinfo);
+		opinfo_conn_put(prev_opinfo);
 		goto op_break_not_needed;
 	}
 
 	list_add(&work->interim_entry, &prev_opinfo->interim_list);
 	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(prev_opinfo);
+	opinfo_conn_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
 	/* Check all oplock was freed by close */
@@ -1228,14 +1243,14 @@ static void smb_break_all_write_oplock(s
 		return;
 	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_put(brk_opinfo);
+		opinfo_conn_put(brk_opinfo);
 		return;
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
 	list_add(&work->interim_entry, &brk_opinfo->interim_list);
 	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_put(brk_opinfo);
+	opinfo_conn_put(brk_opinfo);
 }
 
 /**
@@ -1263,6 +1278,13 @@ void smb_break_all_levII_oplock(struct k
 	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
+
+		atomic_inc(&brk_op->conn->r_count);
+		if (ksmbd_conn_releasing(brk_op->conn)) {
+			atomic_dec(&brk_op->conn->r_count);
+			continue;
+		}
+
 		rcu_read_unlock();
 		if (brk_op->is_lease && (brk_op->o_lease->state &
 		    (~(SMB2_LEASE_READ_CACHING_LE |
@@ -1292,7 +1314,7 @@ void smb_break_all_levII_oplock(struct k
 		brk_op->open_trunc = is_trunc;
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
 next:
-		opinfo_put(brk_op);
+		opinfo_conn_put(brk_op);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();


