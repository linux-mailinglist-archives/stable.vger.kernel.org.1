Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635B6FA964
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjEHKuZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjEHKt4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724982D7B9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:49:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB2D362910
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED44C433EF;
        Mon,  8 May 2023 10:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542982;
        bh=Xdq6WHE3RMmxZGTNIrc9fX9lJQcBS0AbCx8tF2rpevg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPqmUkla91RYYBwvroHGdRPYpokAaBgv27jcvw9b8zBOZwViM5YALke4O4v7BzFGw
         6OXkPi10x5/ar+s7MqvDabn8jqkWOt9EJUBqYjm3lX1otBEv4wN9436MjXbYotv1Nc
         iH2d9EFh/HrTMidcEbVPpNm+Zhz2WRLCAWj/trGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.2 612/663] parisc: Ensure page alignment in flush functions
Date:   Mon,  8 May 2023 11:47:18 +0200
Message-Id: <20230508094449.542505327@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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


