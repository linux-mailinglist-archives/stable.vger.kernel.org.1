Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7476AD0A
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjHAJZl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjHAJZX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7324236
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE5E614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDC7C433C8;
        Tue,  1 Aug 2023 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881846;
        bh=9X6dGSt48HQhRg93b1piqbxRQPQyjkj9oKRBXmYNEcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/jlGCZg3Ytjfxvpg1THAO8Wa5sbTkDfdz3sMrQlW/suJQzDXPWjmPjkwQb5TW4X2
         9JsO5x8yp8UAMcR8GWfCxK+qlUZx//AR21s0ccfeK94jexmjkjTvcf2tuWe3uxw56p
         suH1pHNeabZiU5GlU+XnurpnXiwjsFjG4Bhdh10A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 021/155] fs: dlm: interrupt posix locks only when process is killed
Date:   Tue,  1 Aug 2023 11:18:53 +0200
Message-ID: <20230801091910.957711298@linuxfoundation.org>
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

[ Upstream commit 59e45c758ca1b9893ac923dd63536da946ac333b ]

If a posix lock request is waiting for a result from user space
(dlm_controld), do not let it be interrupted unless the process
is killed. This reverts commit a6b1533e9a57 ("dlm: make posix locks
interruptible"). The problem with the interruptible change is
that all locks were cleared on any signal interrupt. If a signal
was received that did not terminate the process, the process
could continue running after all its dlm posix locks had been
cleared. A future patch will add cancelation to allow proper
interruption.

Cc: stable@vger.kernel.org
Fixes: a6b1533e9a57 ("dlm: make posix locks interruptible")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 01fb7d8c0bca5..f3482e936cc25 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -159,7 +159,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	send_op(op);
 
-	rv = wait_event_interruptible(recv_wq, (op->done != 0));
+	rv = wait_event_killable(recv_wq, (op->done != 0));
 	if (rv == -ERESTARTSYS) {
 		log_debug(ls, "%s: wait killed %llx", __func__,
 			  (unsigned long long)number);
-- 
2.39.2



