Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBBF77ABCE
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjHMVZ4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjHMVZz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A910EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FB0362969
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44BAC433C7;
        Sun, 13 Aug 2023 21:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961956;
        bh=HhPc/qRnSiqXehVjmzVMurXNDk8bdWXue1yFrR4kqs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NePE0XQ/7J1tWsxF667c/GZNRKfU7rMySGBTFRswv4W3UHgVSFxflFBoEJPO2/hLM
         vERqix1CP1Ke6uMOPpk47JGDbX5TaIJzDbqEbVO+bdiLrW6ZlE9jyEZyG98DtGjOZp
         IKmXiYgK60ZXUVgmz2E9Cb2l/uXFueoYZKJcdx+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.4 030/206] riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
Date:   Sun, 13 Aug 2023 23:16:40 +0200
Message-ID: <20230813211725.865896204@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandre Ghiti <alexghiti@rivosinc.com>

commit c3bcc65d4d2e8292c435322cbc34c318d06b8b6c upstream.

So that we do not end up mapping the whole linear mapping using 4K
pages, which is slow at boot time, and also very likely at runtime.

So make sure we align the start of DRAM on a PMD boundary.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reported-by: Song Shuai <suagrfillet@gmail.com>
Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Tested-by: Song Shuai <suagrfillet@gmail.com>
Link: https://lore.kernel.org/r/20230704121837.248976-1-alexghiti@rivosinc.com
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/mm/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9ce504737d18..ad845c3aa9b2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
 	phys_ram_end = memblock_end_of_DRAM();
+
+	/*
+	 * Make sure we align the start of the memory on a PMD boundary so that
+	 * at worst, we map the linear mapping with PMD mappings.
+	 */
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
-		phys_ram_base = memblock_start_of_DRAM();
+		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
 
 	/*
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
-- 
2.41.0



