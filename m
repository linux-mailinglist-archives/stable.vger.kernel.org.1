Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613287ED0E2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbjKOT6K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbjKOT6K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:58:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB35B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:58:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5319C433C9;
        Wed, 15 Nov 2023 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078287;
        bh=DXgMzx1cMrXOrNn2sUtU4D0Mcpq/2elRdMURxKB48Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qicYnPjyVcRDplLEvFjy8vzAg01HuSWyiTpgkov3Jc1HyywTZxsH3O/bXce5EHAzb
         15BgcvFja/6yowo0IVCDvlygmzOx93Euqac2u7V/78kWO+PQkFtEQTAKB58CIqJAce
         Ew1ZuhDDhSxBfQtfYyL8+9xhgqJh9/Ltr9SbYDlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 229/379] sh: bios: Revive earlyprintk support
Date:   Wed, 15 Nov 2023 14:25:04 -0500
Message-ID: <20231115192658.670939341@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 553f7ac78fbb41b2c93ab9b9d78e42274d27daa9 ]

The SuperH BIOS earlyprintk code is protected by CONFIG_EARLY_PRINTK.
However, when this protection was added, it was missed that SuperH no
longer defines an EARLY_PRINTK config symbol since commit
e76fe57447e88916 ("sh: Remove old early serial console code V2"), so
BIOS earlyprintk can no longer be used.

Fix this by reviving the EARLY_PRINTK config symbol.

Fixes: d0380e6c3c0f6edb ("early_printk: consolidate random copies of identical code")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/c40972dfec3dcc6719808d5df388857360262878.1697708489.git.geert+renesas@glider.be
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/Kconfig.debug | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index c449e7c1b20ff..8bcd6c1431a95 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -22,6 +22,17 @@ config STACK_DEBUG
 	  every function call and will therefore incur a major
 	  performance hit. Most users should say N.
 
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on SH_STANDARD_BIOS
+	help
+	  Say Y here to redirect kernel printk messages to the serial port
+	  used by the SH-IPL bootloader, starting very early in the boot
+	  process and ending when the kernel's serial console is initialised.
+	  This option is only useful while porting the kernel to a new machine,
+	  when the kernel may crash or hang before the serial console is
+	  initialised.  If unsure, say N.
+
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
 	depends on DEBUG_KERNEL && (MMU || BROKEN) && !PAGE_SIZE_64KB
-- 
2.42.0



