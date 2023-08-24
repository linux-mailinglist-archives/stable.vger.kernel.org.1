Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04C7879A2
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 22:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbjHXUws (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 16:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbjHXUwh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 16:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53FD1BD9
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692910309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zyieofru4f+L086lWgLRxUdew0QSr5yULNgleBFxyJw=;
        b=feSqlukaxJPiQEsHcovBgNqQZTrDI4DZAAAT25iQwRr+vlvp0jmvoY0Q8EIDtffMdMzK0a
        Op8IaBLunrblcjvAxXuN5uSIvgl+MEoBFHgjBlic/UGEqmLz8/MmMZDwCnJ9ttTVjRSxLH
        iPX7rX0/Yr6ynu2wbqrPtPDvpP56pxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-3d1FP4FeMjyy2Fzm855tGA-1; Thu, 24 Aug 2023 16:51:46 -0400
X-MC-Unique: 3d1FP4FeMjyy2Fzm855tGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D800785CCE0
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 20:51:45 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A839B40C2073;
        Thu, 24 Aug 2023 20:51:45 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org, bmarson@redhat.com
Subject: [PATCH dlm/next] dlm: fix plock lookup when using multiple lockspaces
Date:   Thu, 24 Aug 2023 16:51:42 -0400
Message-Id: <20230824205142.2732984-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch fixes an issues when concurrent fcntl() syscalls are
executing on two different gfs2 filesystems. Each gfs2 filesystem
creates an DLM lockspace, it seems that VFS only allows fcntl() syscalls
at one time on a per filesystem basis. However if there are two
filesystems and we executing fcntl() syscalls our lookup mechanism on the
global plock op list does not work anymore.

It can be reproduced with two mounted gfs2 filesystems using DLM
locking. Then call stress-ng --fcntl 32 on each mount point. The kernel
log will show several:

WARNING: CPU: 4 PID: 943 at fs/dlm/plock.c:574 dev_write+0x15c/0x590

because we have a sanity check if it's was really the meant original
plock op when dev_write() does a lookup. This patch adds just a
additional check for fsid to find the right plock op which is an
indicator that the recv_list should be on a per lockspace basis and not
globally defined. After this patch the sanity check never warned again
that the wrong plock op was being looked up.

Cc: stable@vger.kernel.org
Reported-by: Barry Marson <bmarson@redhat.com>
Fixes: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 00e1d802a81c..e6b4c1a21446 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -556,7 +556,8 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		op = plock_lookup_waiter(&info);
 	} else {
 		list_for_each_entry(iter, &recv_list, list) {
-			if (!iter->info.wait) {
+			if (!iter->info.wait &&
+			    iter->info.fsid == info.fsid) {
 				op = iter;
 				break;
 			}
@@ -568,8 +569,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		if (info.wait)
 			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
 		else
-			WARN_ON(op->info.fsid != info.fsid ||
-				op->info.number != info.number ||
+			WARN_ON(op->info.number != info.number ||
 				op->info.owner != info.owner ||
 				op->info.optype != info.optype);
 
-- 
2.31.1

