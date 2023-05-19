Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8100709B38
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjESPWQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjESPWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 11:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517881AC
        for <stable@vger.kernel.org>; Fri, 19 May 2023 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684509692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNY2NyL7yNeknDb3IM5QwvitC6u5LqIzCAFRVhDoV5M=;
        b=eTapndUu79Ig+jBZrfiTiNHjY12JrOsXA6VaDMOgBcszDZEdtihM5b4rC0U7RrvjnvdC4C
        fqeWpMcURYnmZsjkTX8/x9oVI45XAsNiDe+beI9IWEchp/R5J0j5RRqN5ZjHH46vU7/B+Q
        xAmYDUT5j0qRQlqN45Ycl2lU0tKimUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-7Syp--2eMlCN0zPaXvbYLw-1; Fri, 19 May 2023 11:21:31 -0400
X-MC-Unique: 7Syp--2eMlCN0zPaXvbYLw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1FBB85A5A8
        for <stable@vger.kernel.org>; Fri, 19 May 2023 15:21:30 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A64294F2DDE;
        Fri, 19 May 2023 15:21:30 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, agruenba@redhat.com,
        stable@vger.kernel.org, aahringo@redhat.com
Subject: [PATCH v6.4-rc2 4/5] fs: dlm: make F_SETLK not killable
Date:   Fri, 19 May 2023 11:21:27 -0400
Message-Id: <20230519152128.65272-4-aahringo@redhat.com>
In-Reply-To: <20230519152128.65272-1-aahringo@redhat.com>
References: <20230519152128.65272-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch changes that only F_SETLKW will be killable. As the man page
of fcntl() states out that F_SETLKW is the only one interruptible cmd as
I supposed it can block an unknown amount of time when it hits
contention. We use killable for the same reason just that the process
isn't alive anymore.

The command F_SETLK is a trylock command, a result can be expected very
close as the operation was send to the user space like unlock or get
operations which uses wait_event() only.

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 31bc601ee3d8..c9e1d5f54194 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -155,25 +155,29 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	send_op(op);
 
-	rv = wait_event_killable(recv_wq, (op->done != 0));
-	if (rv == -ERESTARTSYS) {
-		spin_lock(&ops_lock);
-		/* recheck under ops_lock if we got a done != 0,
-		 * if so this interrupt case should be ignored
-		 */
-		if (op->done != 0) {
+	if (op->info.wait) {
+		rv = wait_event_killable(recv_wq, (op->done != 0));
+		if (rv == -ERESTARTSYS) {
+			spin_lock(&ops_lock);
+			/* recheck under ops_lock if we got a done != 0,
+			 * if so this interrupt case should be ignored
+			 */
+			if (op->done != 0) {
+				spin_unlock(&ops_lock);
+				goto do_lock_wait;
+			}
+			list_del(&op->list);
 			spin_unlock(&ops_lock);
-			goto do_lock_wait;
-		}
-		list_del(&op->list);
-		spin_unlock(&ops_lock);
 
-		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
-			  __func__, ls->ls_global_id,
-			  (unsigned long long)number, op->info.pid);
-		do_unlock_close(&op->info);
-		dlm_release_plock_op(op);
-		goto out;
+			log_debug(ls, "%s: wait interrupted %x %llx pid %d",
+				  __func__, ls->ls_global_id,
+				  (unsigned long long)number, op->info.pid);
+			do_unlock_close(&op->info);
+			dlm_release_plock_op(op);
+			goto out;
+		}
+	} else {
+		wait_event(recv_wq, (op->done != 0));
 	}
 
 do_lock_wait:
-- 
2.31.1

