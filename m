Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BFB775D20
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjHILeK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjHILeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CB51BFE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13EA563486
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE3DC433C7;
        Wed,  9 Aug 2023 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580847;
        bh=9X6dGSt48HQhRg93b1piqbxRQPQyjkj9oKRBXmYNEcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xl5jcJX/jzeBaaHBZT5kji5m4A0ZRsiSzoKapG4OHiRqQykJQGkDxlPfuD0ONNhqW
         UpsheBqDjClPWq6NOLXRNKuyxQcbJnZ8snVSfDOCTPtWAukAvACvZB4kVlVCpBVWd9
         Hxd0/9WjaQA8NyYNfbGppOMJuFOmIFkHCPchkup4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 016/201] fs: dlm: interrupt posix locks only when process is killed
Date:   Wed,  9 Aug 2023 12:40:18 +0200
Message-ID: <20230809103644.359053178@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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



