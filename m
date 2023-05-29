Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E003671510B
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjE2Vp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE2Vp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0BBDF
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kz9rMCVMS9Ex9oATSXlfrtAWzb4IMWhldZT8mcvtTrA=;
        b=aGZ2wp4gwk2ohTCP4M4FxhHyA6EM4EKIrdSplm5bMsxD+TWV1Fv59nuZYbhd8y+9zQAZkY
        56gECj4bss4NM8yiMwrAZbQO75WkkuhR0sT/B9LnMWBZwnqAeBDKrIKPwDoDx4xfmMMeBw
        oGobAezVnwixZDAVGiejMUBRhtnsIvQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-P_FI59QuP--wsoLh9kWHNA-1; Mon, 29 May 2023 17:44:43 -0400
X-MC-Unique: P_FI59QuP--wsoLh9kWHNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A8981C03DA3
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:43 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E69082166B2B;
        Mon, 29 May 2023 21:44:42 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 07/12] fs: dlm: move dlm_purge_lkb_callbacks to user module
Date:   Mon, 29 May 2023 17:44:35 -0400
Message-Id: <20230529214440.2542721-7-aahringo@redhat.com>
In-Reply-To: <20230529214440.2542721-1-aahringo@redhat.com>
References: <20230529214440.2542721-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch moves the dlm_purge_lkb_callbacks() function from ast to user
dlm module as it is only a function being used by dlm user
implementation. I got be hinted to hold specific locks regarding the
callback handling for dlm_purge_lkb_callbacks() but it was false
positive. It is confusing because ast dlm implementation uses a
different locking behaviour as user locks uses as DLM handles kernel and
user dlm locks differently. To avoid the confusing we move this function
to dlm user implementation.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c  | 17 -----------------
 fs/dlm/ast.h  |  1 -
 fs/dlm/user.c | 18 ++++++++++++++++++
 fs/dlm/user.h |  1 +
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index ff0ef4653535..1f2f70a1b824 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -36,23 +36,6 @@ void dlm_callback_set_last_ptr(struct dlm_callback **from,
 	*from = to;
 }
 
-void dlm_purge_lkb_callbacks(struct dlm_lkb *lkb)
-{
-	struct dlm_callback *cb, *safe;
-
-	list_for_each_entry_safe(cb, safe, &lkb->lkb_callbacks, list) {
-		list_del(&cb->list);
-		kref_put(&cb->ref, dlm_release_callback);
-	}
-
-	clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
-
-	/* invalidate */
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cast, NULL);
-	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, NULL);
-	lkb->lkb_last_bast_mode = -1;
-}
-
 int dlm_enqueue_lkb_callback(struct dlm_lkb *lkb, uint32_t flags, int mode,
 			     int status, uint32_t sbflags)
 {
diff --git a/fs/dlm/ast.h b/fs/dlm/ast.h
index 880b11882495..ce007892dc2d 100644
--- a/fs/dlm/ast.h
+++ b/fs/dlm/ast.h
@@ -26,7 +26,6 @@ void dlm_callback_set_last_ptr(struct dlm_callback **from,
 			       struct dlm_callback *to);
 
 void dlm_release_callback(struct kref *ref);
-void dlm_purge_lkb_callbacks(struct dlm_lkb *lkb);
 void dlm_callback_work(struct work_struct *work);
 int dlm_callback_start(struct dlm_ls *ls);
 void dlm_callback_stop(struct dlm_ls *ls);
diff --git a/fs/dlm/user.c b/fs/dlm/user.c
index d9c09fc0aba1..695e691b38b3 100644
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -145,6 +145,24 @@ static void compat_output(struct dlm_lock_result *res,
 }
 #endif
 
+/* should held proc->asts_spin lock */
+void dlm_purge_lkb_callbacks(struct dlm_lkb *lkb)
+{
+	struct dlm_callback *cb, *safe;
+
+	list_for_each_entry_safe(cb, safe, &lkb->lkb_callbacks, list) {
+		list_del(&cb->list);
+		kref_put(&cb->ref, dlm_release_callback);
+	}
+
+	clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
+
+	/* invalidate */
+	dlm_callback_set_last_ptr(&lkb->lkb_last_cast, NULL);
+	dlm_callback_set_last_ptr(&lkb->lkb_last_cb, NULL);
+	lkb->lkb_last_bast_mode = -1;
+}
+
 /* Figure out if this lock is at the end of its life and no longer
    available for the application to use.  The lkb still exists until
    the final ast is read.  A lock becomes EOL in three situations:
diff --git a/fs/dlm/user.h b/fs/dlm/user.h
index 33059452d79e..2caf8e6e24d5 100644
--- a/fs/dlm/user.h
+++ b/fs/dlm/user.h
@@ -6,6 +6,7 @@
 #ifndef __USER_DOT_H__
 #define __USER_DOT_H__
 
+void dlm_purge_lkb_callbacks(struct dlm_lkb *lkb);
 void dlm_user_add_ast(struct dlm_lkb *lkb, uint32_t flags, int mode,
 		      int status, uint32_t sbflags);
 int dlm_user_init(void);
-- 
2.31.1

