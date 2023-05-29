Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FE715111
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjE2VqR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjE2VqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A7E8
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8RQeuQkxI5R0AMNkY/+q+IFSl/ylLlW7h2ErXHX50iw=;
        b=dMmzSstzemmjWckewLTssnIHHhvE6IiAKpSfZOcdng3TSty3pTKqxVEark5gbovaXMEZur
        yKEBcs9VUWiHUiAfGfxH+Ca6oX0hR5A+M4n4HV2lMm6+7egTH40j9dFXWd1cXaXtIGJhr4
        RXSufLfbH6M9zaCMzuxkqIAaFgI2FKg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-BO9ZbKSrMG-sGpIKCfkSiQ-1; Mon, 29 May 2023 17:44:43 -0400
X-MC-Unique: BO9ZbKSrMG-sGpIKCfkSiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9115185A792
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:43 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81A282166B2B;
        Mon, 29 May 2023 21:44:43 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 10/12] fs: dlm: handle lkb wait count as atomic_t
Date:   Mon, 29 May 2023 17:44:38 -0400
Message-Id: <20230529214440.2542721-10-aahringo@redhat.com>
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

Currently the lkb_wait_count is locked by the rsb lock and it should be
fine to handle lkb_wait_count as non atomic_t value. However for the
overall process of reducing locking this patch converts it to an
atomic_t value.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/dlm_internal.h |  2 +-
 fs/dlm/lock.c         | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 986a9d7b1f33..c8156770205e 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -246,7 +246,7 @@ struct dlm_lkb {
 	int8_t			lkb_highbast;	/* highest mode bast sent for */
 
 	int8_t			lkb_wait_type;	/* type of reply waiting for */
-	int8_t			lkb_wait_count;
+	atomic_t		lkb_wait_count;
 	int			lkb_wait_nodeid; /* for debugging */
 
 	struct list_head	lkb_statequeue;	/* rsb g/c/w list */
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index ede903246fa4..f511a9d7d416 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1407,6 +1407,7 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 {
 	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error = 0;
+	int wc;
 
 	mutex_lock(&ls->ls_waiters_mutex);
 
@@ -1428,20 +1429,17 @@ static int add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
 			error = -EBUSY;
 			goto out;
 		}
-		lkb->lkb_wait_count++;
+		wc = atomic_inc_return(&lkb->lkb_wait_count);
 		hold_lkb(lkb);
 
 		log_debug(ls, "addwait %x cur %d overlap %d count %d f %x",
-			  lkb->lkb_id, lkb->lkb_wait_type, mstype,
-			  lkb->lkb_wait_count, dlm_iflags_val(lkb));
+			  lkb->lkb_id, lkb->lkb_wait_type, mstype, wc,
+			  dlm_iflags_val(lkb));
 		goto out;
 	}
 
-	DLM_ASSERT(!lkb->lkb_wait_count,
-		   dlm_print_lkb(lkb);
-		   printk("wait_count %d\n", lkb->lkb_wait_count););
-
-	lkb->lkb_wait_count++;
+	wc = atomic_fetch_inc(&lkb->lkb_wait_count);
+	DLM_ASSERT(!wc, dlm_print_lkb(lkb); printk("wait_count %d\n", wc););
 	lkb->lkb_wait_type = mstype;
 	lkb->lkb_wait_nodeid = to_nodeid; /* for debugging */
 	hold_lkb(lkb);
@@ -1504,7 +1502,7 @@ static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
 		log_debug(ls, "remwait %x convert_reply zap overlap_cancel",
 			  lkb->lkb_id);
 		lkb->lkb_wait_type = 0;
-		lkb->lkb_wait_count--;
+		atomic_dec(&lkb->lkb_wait_count);
 		unhold_lkb(lkb);
 		goto out_del;
 	}
@@ -1531,16 +1529,15 @@ static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
 	if (overlap_done && lkb->lkb_wait_type) {
 		log_error(ls, "remwait error %x reply %d wait_type %d overlap",
 			  lkb->lkb_id, mstype, lkb->lkb_wait_type);
-		lkb->lkb_wait_count--;
+		atomic_dec(&lkb->lkb_wait_count);
 		unhold_lkb(lkb);
 		lkb->lkb_wait_type = 0;
 	}
 
-	DLM_ASSERT(lkb->lkb_wait_count, dlm_print_lkb(lkb););
+	DLM_ASSERT(atomic_read(&lkb->lkb_wait_count), dlm_print_lkb(lkb););
 
 	clear_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-	lkb->lkb_wait_count--;
-	if (!lkb->lkb_wait_count)
+	if (atomic_dec_and_test(&lkb->lkb_wait_count))
 		list_del_init(&lkb->lkb_wait_reply);
 	unhold_lkb(lkb);
 	return 0;
@@ -2669,7 +2666,7 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 			goto out;
 
 		/* lock not allowed if there's any op in progress */
-		if (lkb->lkb_wait_type || lkb->lkb_wait_count)
+		if (lkb->lkb_wait_type || atomic_read(&lkb->lkb_wait_count))
 			goto out;
 
 		if (is_overlap(lkb))
@@ -2731,7 +2728,7 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
 
 	/* normal unlock not allowed if there's any op in progress */
 	if (!(args->flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)) &&
-	    (lkb->lkb_wait_type || lkb->lkb_wait_count))
+	    (lkb->lkb_wait_type || atomic_read(&lkb->lkb_wait_count)))
 		goto out;
 
 	/* an lkb may be waiting for an rsb lookup to complete where the
@@ -5066,10 +5063,9 @@ int dlm_recover_waiters_post(struct dlm_ls *ls)
 		/* drop all wait_count references we still
 		 * hold a reference for this iteration.
 		 */
-		while (lkb->lkb_wait_count) {
-			lkb->lkb_wait_count--;
+		while (!atomic_dec_and_test(&lkb->lkb_wait_count))
 			unhold_lkb(lkb);
-		}
+
 		mutex_lock(&ls->ls_waiters_mutex);
 		list_del_init(&lkb->lkb_wait_reply);
 		mutex_unlock(&ls->ls_waiters_mutex);
-- 
2.31.1

