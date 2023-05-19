Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713C2709B33
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjESPWN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 11:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjESPWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 11:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4AE1B3
        for <stable@vger.kernel.org>; Fri, 19 May 2023 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684509692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7g2SlwmZsMIpaePyXv2DEvMeqaaTtKuTBvT27JxCIuA=;
        b=GWWaAedZYH5ovYO2QjuBQ+Fk059k/YUEFcV/Q5NduojTKKhqOLsW27kZPQkeZ8QJZtCtnw
        fqErnudlt2R+kynrD7JqpX/hTkecC0Ps5+lZQ+hTWX3T+0+5k4kuQLsoEqkXep9MKY6HGB
        x34NAB6Y5QR20ThRMOlqes/bHP9BxVk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-ISAsgIVsMWm6Tj_hnkAKpQ-1; Fri, 19 May 2023 11:21:31 -0400
X-MC-Unique: ISAsgIVsMWm6Tj_hnkAKpQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10DCB1C0150E
        for <stable@vger.kernel.org>; Fri, 19 May 2023 15:21:31 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9D7F4F2DE0;
        Fri, 19 May 2023 15:21:30 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, agruenba@redhat.com,
        stable@vger.kernel.org, aahringo@redhat.com
Subject: [PATCH v6.4-rc2 5/5] fs: dlm: avoid F_SETLKW plock op lookup collisions
Date:   Fri, 19 May 2023 11:21:28 -0400
Message-Id: <20230519152128.65272-5-aahringo@redhat.com>
In-Reply-To: <20230519152128.65272-1-aahringo@redhat.com>
References: <20230519152128.65272-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch fixes a possible plock op collisions when using F_SETLKW lock
requests and fsid, number and owner are not enough to identify a result
for a pending request. The ltp testcases [0] and [1] are examples when
this is not enough in case of using classic posix locks with threads and
open filedescriptor posix locks.

The idea to fix the issue here is to split recv_list, which contains
plock ops expecting a result from user space, into a F_SETLKW op
recv_setlkw_list and for all other commands recv_list. Due DLM user
space behavior e.g. dlm_controld a request and writing a result back can
only happen in an ordered way. That means a lookup and iterating over
the recv_list is not required. To place the right plock op as the first
entry of recv_list a change to list_move_tail() was made.

This behaviour is for F_SETLKW not possible as multiple waiters can be
get a result back in an random order. To avoid a collisions in cases
like [0] or [1] this patch adds more fields to compare the plock
operations as the lock request is the same. This is also being made in
NFS to find an result for an asynchronous F_SETLKW lock request [2][3]. We
still can't find the exact lock request for a specific result if the
lock request is the same, but if this is the case we don't care the
order how the identical lock requests get their result back to grant the
lock.

[0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testcases/kernel/syscalls/fcntl/fcntl40.c
[1] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testcases/kernel/syscalls/fcntl/fcntl41.c
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lockd/lockd.h?h=v6.4-rc1#n373
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/lockd/svclock.c?h=v6.4-rc1#n731

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index c9e1d5f54194..540a30a342f0 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -17,6 +17,7 @@
 static DEFINE_SPINLOCK(ops_lock);
 static LIST_HEAD(send_list);
 static LIST_HEAD(recv_list);
+static LIST_HEAD(recv_setlkw_list);
 static DECLARE_WAIT_QUEUE_HEAD(send_wq);
 static DECLARE_WAIT_QUEUE_HEAD(recv_wq);
 
@@ -392,10 +393,14 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	spin_lock(&ops_lock);
 	if (!list_empty(&send_list)) {
 		op = list_first_entry(&send_list, struct plock_op, list);
-		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
+		if (op->info.flags & DLM_PLOCK_FL_CLOSE) {
 			list_del(&op->list);
-		else
-			list_move(&op->list, &recv_list);
+		} else {
+			if (op->info.wait)
+				list_move(&op->list, &recv_setlkw_list);
+			else
+				list_move_tail(&op->list, &recv_list);
+		}
 		memcpy(&info, &op->info, sizeof(info));
 	}
 	spin_unlock(&ops_lock);
@@ -434,18 +439,34 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		return -EINVAL;
 
 	spin_lock(&ops_lock);
-	list_for_each_entry(iter, &recv_list, list) {
-		if (iter->info.fsid == info.fsid &&
-		    iter->info.number == info.number &&
-		    iter->info.owner == info.owner) {
-			list_del_init(&iter->list);
-			memcpy(&iter->info, &info, sizeof(info));
-			if (iter->data)
+	if (info.wait) {
+		list_for_each_entry(iter, &recv_setlkw_list, list) {
+			if (iter->info.fsid == info.fsid &&
+			    iter->info.number == info.number &&
+			    iter->info.owner == info.owner &&
+			    iter->info.pid == info.pid &&
+			    iter->info.start == info.start &&
+			    iter->info.end == info.end) {
+				list_del_init(&iter->list);
+				memcpy(&iter->info, &info, sizeof(info));
+				if (iter->data)
+					do_callback = 1;
+				else
+					iter->done = 1;
+				op = iter;
+				break;
+			}
+		}
+	} else {
+		op = list_first_entry_or_null(&recv_list, struct plock_op,
+					      list);
+		if (op) {
+			list_del_init(&op->list);
+			memcpy(&op->info, &info, sizeof(info));
+			if (op->data)
 				do_callback = 1;
 			else
-				iter->done = 1;
-			op = iter;
-			break;
+				op->done = 1;
 		}
 	}
 	spin_unlock(&ops_lock);
-- 
2.31.1

