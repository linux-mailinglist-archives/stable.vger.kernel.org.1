Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01087ECFD0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjKOTvC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjKOTvA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65FD1B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50462C433CA;
        Wed, 15 Nov 2023 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077855;
        bh=yFyXm4JAoncDZPkviO+11x7torsooitJrJapDV1z8Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eq5wXeI0FNeOfEm4zRCB1scPhFNIm0jKB0Vl1qx5kwFdBX7V73z9Xj3yaL3KUqRl3
         8Stk5P39Mm+mF2pMEhtpMlkXcQ1dVG0edj6YSFfoSgS/TdYimx7S+dg/tnvjGpeqxY
         9oZyMrDrT+C1EBnXvr6NqsvcxTzNVJ7z2o9Jpqhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Damien Le Moal <dlemoal@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 561/603] riscv: boot: Fix creation of loader.bin
Date:   Wed, 15 Nov 2023 14:18:26 -0500
Message-ID: <20231115191650.448121327@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 57a4542cb7c9baa1509c3366b57a08d75b212ead ]

When flashing loader.bin for K210 using kflash:

    [ERROR] This is an ELF file and cannot be programmed to flash directly: arch/riscv/boot/loader.bin

Before, loader.bin relied on "OBJCOPYFLAGS := -O binary" in the main
RISC-V Makefile to create a boot image with the right format.  With this
removed, the image is now created in the wrong (ELF) format.

Fix this by adding an explicit rule.

Fixes: 505b02957e74f0c5 ("riscv: Remove duplicate objcopy flag")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/1086025809583809538dfecaa899892218f44e7e.1698159066.git.geert+renesas@glider.be
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 22b13947bd131..8e7fc0edf21d3 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -17,6 +17,7 @@
 KCOV_INSTRUMENT := n
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+OBJCOPYFLAGS_loader.bin :=-O binary
 OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
 targets := Image Image.* loader loader.o loader.lds loader.bin
-- 
2.42.0



