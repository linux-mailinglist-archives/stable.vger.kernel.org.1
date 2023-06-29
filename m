Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC8742C48
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjF2SrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjF2SrC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86830DF
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6908B615C8
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEB2C433C0;
        Thu, 29 Jun 2023 18:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064418;
        bh=6M0ceHhK6SMdTkt5fWpVW5EomiEFxUY/oCA/cK1gMcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j92a4MeKBhUmysqJH3MGvmsnIwWPdpe4p7huQ8xezSnud3nva9pFMbtrIGc1dgn/a
         hMEC0lc70W+jJa6geeG9x4woYtYA3pnha1vaSoAYTl1BjyFgj0n9yakItNDWaS2R9T
         mPuFRPvn2nh3h8RrBSSa16Cfbn6r+wQFuaLU+Dh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Borislav Petkov (AMD)" <bp@alien8.de>,
        stable@kernel.org
Subject: [PATCH 6.3 03/29] x86/microcode/AMD: Load late on both threads too
Date:   Thu, 29 Jun 2023 20:43:33 +0200
Message-ID: <20230629184151.864698065@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
References: <20230629184151.705870770@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Borislav Petkov (AMD) <bp@alien8.de>

commit a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d upstream.

Do the same as early loading - load on both threads.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230605141332.25948-1-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/microcode/amd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -705,7 +705,7 @@ static enum ucode_state apply_microcode_
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}


