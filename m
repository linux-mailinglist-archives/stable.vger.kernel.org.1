Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2140275CEE2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjGUQZ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjGUQZH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:25:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1C4208
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D42C61D5A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E87C433C7;
        Fri, 21 Jul 2023 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956484;
        bh=C3RdR2XEuWOvbQrdSOWYkKE/nVhDmZ0TCTRIvZXsCME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIXVAGkmJ6MUeCE1pQ6tNzoE3gXuXUcNn+AdTc+9wsI+MRC1NP6Bg1+5qfaUbWh4l
         Afkbdgq15nreLuPUOynHIivCP9XpaDDcSjyNVuJWlVjxYePSSrqns/F9/WWWuyC87q
         2wbYC3++v/mVEqGL8kxmaA+UCLzSLG1hXfmsIG0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 6.4 191/292] fs: dlm: clear pending bit when queue was empty
Date:   Fri, 21 Jul 2023 18:05:00 +0200
Message-ID: <20230721160537.097117968@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Alexander Aring <aahringo@redhat.com>

commit 7a931477bff1c7548aa8492bccf600f5f29452b1 upstream.

This patch clears the DLM_IFL_CB_PENDING_BIT flag which will be set when
there is callback work queued when there was no callback to dequeue. It
is a buggy case and should never happen, that's why there is a
WARN_ON(). However if the case happens we are prepared to somehow
recover from it.

Cc: stable@vger.kernel.org
Fixes: 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.41.0



