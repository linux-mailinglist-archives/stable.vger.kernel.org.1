Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC6746318
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGCS5k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGCS5g (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4349610C6
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AB661013
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE316C433C7;
        Mon,  3 Jul 2023 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410653;
        bh=4n4pT5+bLzUOZ5TQNEQEkoWfpzOrQFSwjHQTV0Ad5O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvtZ3EJqN9E0KcAt0XBV8YIX+k7ooJKYs0p0n/BKfF7NMMVhpWtRjEYNtqSsyVTCW
         28p+uj7A7Vh0LLLv2sltauitNLUfP9hYInfjw9ofuLdL0OcWIhQ4nG2xlzKsUnWf1l
         qvU4mfRy8/M9ZaS0dOZorjcesnOybfuMksuIElg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Borislav Petkov (AMD)" <bp@alien8.de>,
        stable@kernel.org
Subject: [PATCH 5.15 06/15] x86/microcode/AMD: Load late on both threads too
Date:   Mon,  3 Jul 2023 20:54:51 +0200
Message-ID: <20230703184519.070005889@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184518.896751186@linuxfoundation.org>
References: <20230703184518.896751186@linuxfoundation.org>
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
@@ -699,7 +699,7 @@ static enum ucode_state apply_microcode_
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}


