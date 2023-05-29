Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80171510D
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjE2Vpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjE2Vp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E1D9
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaalMx5t9L/479ORaQaZNvDA8YmlHp0+0hNnc67s3Xg=;
        b=CWHzJdZlVRuEeYKb15ZdT7lg84p8PsHMnk2WBlGC3lC6Xr0bKdF+FZte6OlKtwZ9oRD5E3
        4PczTLzcK4wtqPKZkxqweK08kam2gSfbqDICIjSeY2g82xt9a+L6dLRJqlDWKETfj2p0wo
        vR/iUK4lMnY7LQxMMbRDCxKMQPG80KQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-iemu7-3dPg-kyi9GxBNrTw-1; Mon, 29 May 2023 17:44:42 -0400
X-MC-Unique: iemu7-3dPg-kyi9GxBNrTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2122D185A78B
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:42 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE82F2166B2B;
        Mon, 29 May 2023 21:44:41 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 02/12] fs: dlm: clear pending bit when queue was empty
Date:   Mon, 29 May 2023 17:44:30 -0400
Message-Id: <20230529214440.2542721-2-aahringo@redhat.com>
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

This patch clears the DLM_IFL_CB_PENDING_BIT flag which will be set when
there is callback work queued when there was no callback to dequeue. It
is a buggy case and should never happen, that's why there is a
WARN_ON(). However if the case happens we are prepared to somehow
recover from it.

Cc: stable@vger.kernel.org
Fixes: 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/ast.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/ast.c b/fs/dlm/ast.c
index 700ff2e0515a..ff0ef4653535 100644
--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -181,10 +181,12 @@ void dlm_callback_work(struct work_struct *work)
 
 	spin_lock(&lkb->lkb_cb_lock);
 	rv = dlm_dequeue_lkb_callback(lkb, &cb);
-	spin_unlock(&lkb->lkb_cb_lock);
-
-	if (WARN_ON_ONCE(rv == DLM_DEQUEUE_CALLBACK_EMPTY))
+	if (WARN_ON_ONCE(rv == DLM_DEQUEUE_CALLBACK_EMPTY)) {
+		clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
+		spin_unlock(&lkb->lkb_cb_lock);
 		goto out;
+	}
+	spin_unlock(&lkb->lkb_cb_lock);
 
 	for (;;) {
 		castfn = lkb->lkb_astfn;
-- 
2.31.1

