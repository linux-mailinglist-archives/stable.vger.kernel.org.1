Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4047612C6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjGYLFf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjGYLFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193C526AA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D6F6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE60C433C7;
        Tue, 25 Jul 2023 11:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282980;
        bh=qdXlhvebIi2jX4eTPe3/M2pIAg4dku76+3qKD0GDnIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtOZaW2I9nz8CAjXOUNNg0+C9abXR447QTAsxiURyc3S7iMfipstCfxqUVQ4ks8ZA
         jBNTDPqYBk6vqXdXqcHhGhmAUvWIrFxSMpKKfO8dt7DfxejaaO2HZotTXGLpDp85KI
         SWowRycSLtTIt2DzWXs3dBSAKUcpkRJVzmTcQM98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kui-Feng Lee <kuifeng@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/183] bpf: Print a warning only if writing to unprivileged_bpf_disabled.
Date:   Tue, 25 Jul 2023 12:44:55 +0200
Message-ID: <20230725104510.376159921@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kui-Feng Lee <thinker.li@gmail.com>

[ Upstream commit fedf99200ab086c42a572fca1d7266b06cdc3e3f ]

Only print the warning message if you are writing to
"/proc/sys/kernel/unprivileged_bpf_disabled".

The kernel may print an annoying warning when you read
"/proc/sys/kernel/unprivileged_bpf_disabled" saying

  WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible
  via Spectre v2 BHB attacks!

However, this message is only meaningful when the feature is
disabled or enabled.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20230502181418.308479-1-kuifeng@meta.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8633ec4f92df3..0c44a716f0a24 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5289,7 +5289,8 @@ static int bpf_unpriv_handler(struct ctl_table *table, int write,
 		*(int *)table->data = unpriv_enable;
 	}
 
-	unpriv_ebpf_notify(unpriv_enable);
+	if (write)
+		unpriv_ebpf_notify(unpriv_enable);
 
 	return ret;
 }
-- 
2.39.2



