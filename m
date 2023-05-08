Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6636FA636
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjEHKRd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjEHKRY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D4D059
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B25C8624BF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39ADC433D2;
        Mon,  8 May 2023 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541035;
        bh=Xdq6WHE3RMmxZGTNIrc9fX9lJQcBS0AbCx8tF2rpevg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h89kGaje1uTjUS85Y+DkzVZZPKSdkSOLPSWlc1FupXmlMP1MWKt01L5mgA3seSXUK
         5HIj5vWcZLKgimZm0U6Qa5Hdtuqa7J3/AnEFdu+hLlgOlwuq2Z/jBt6QLITPzvUvtV
         wyl+s+nv84yWiS40hWvmk5OP5je+/4gTuUbbm7hE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 560/611] parisc: Ensure page alignment in flush functions
Date:   Mon,  8 May 2023 11:46:42 +0200
Message-Id: <20230508094440.183580728@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit d755bd2caeb47fd806e12399fe8b56798fa5d2cc upstream.

Matthew Wilcox noticed, that if ARCH_HAS_FLUSH_ON_KUNMAP is defined
(which is the case for PA-RISC), __kunmap_local() calls
kunmap_flush_on_unmap(), which may call the parisc flush functions with
a non-page-aligned address and thus the page might not be fully flushed.

This patch ensures that flush_kernel_dcache_page_asm() and
flush_kernel_dcache_page_asm() will always operate on page-aligned
addresses.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/pacache.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/parisc/kernel/pacache.S
+++ b/arch/parisc/kernel/pacache.S
@@ -889,6 +889,7 @@ ENDPROC_CFI(flush_icache_page_asm)
 ENTRY_CFI(flush_kernel_dcache_page_asm)
 88:	ldil		L%dcache_stride, %r1
 	ldw		R%dcache_stride(%r1), %r23
+	depi_safe	0, 31,PAGE_SHIFT, %r26	/* Clear any offset bits */
 
 #ifdef CONFIG_64BIT
 	depdi,z		1, 63-PAGE_SHIFT,1, %r25
@@ -925,6 +926,7 @@ ENDPROC_CFI(flush_kernel_dcache_page_asm
 ENTRY_CFI(purge_kernel_dcache_page_asm)
 88:	ldil		L%dcache_stride, %r1
 	ldw		R%dcache_stride(%r1), %r23
+	depi_safe	0, 31,PAGE_SHIFT, %r26	/* Clear any offset bits */
 
 #ifdef CONFIG_64BIT
 	depdi,z		1, 63-PAGE_SHIFT,1, %r25


