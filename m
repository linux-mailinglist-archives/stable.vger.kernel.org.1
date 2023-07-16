Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97B97555E4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGPUpp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjGPUpn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A2E4B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A62260EBC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ECFC433C7;
        Sun, 16 Jul 2023 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540341;
        bh=UW9/5vOJHzwJBGDXsmWoosJqZghUja5t51ejURmeGRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWBLa7hJXBhQWfMMLLTbq2Miu+z3CBk0jUj4bHuGSWNDx1JKy+7JGCK253eX++Dxy
         xWEtBrzJs0xcUTd2C5rYkYcEj+Y4/TNrlV6kll7flLUBmD2gBI1RzwABVOboT/LMaN
         SfmMaXUkBeLmnbiHIMHL8C77GRLpD0QS+J0EvVKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 329/591] PCI: endpoint: Fix Kconfig indent style
Date:   Sun, 16 Jul 2023 21:47:48 +0200
Message-ID: <20230716194932.406767891@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shunsuke Mie <mie@igel.co.jp>

[ Upstream commit 2759ddf7535d63381f9b9b1412e4c46e13ed773a ]

Change to follow the Kconfig style guide. This patch fixes to use tab
rather than space to indent, while help text is indented an additional
two spaces.

Link: https://lore.kernel.org/r/20220815025006.48167-1-mie@igel.co.jp
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Stable-dep-of: 37587673cda9 ("PCI: endpoint: Fix a Kconfig prompt of vNTB driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 295a033ee9a27..9fd5608868718 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -27,13 +27,13 @@ config PCI_EPF_NTB
 	  If in doubt, say "N" to disable Endpoint NTB driver.
 
 config PCI_EPF_VNTB
-        tristate "PCI Endpoint NTB driver"
-        depends on PCI_ENDPOINT
-        depends on NTB
-        select CONFIGFS_FS
-        help
-          Select this configuration option to enable the Non-Transparent
-          Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
-          between PCI Root Port and PCIe Endpoint.
+	tristate "PCI Endpoint NTB driver"
+	depends on PCI_ENDPOINT
+	depends on NTB
+	select CONFIGFS_FS
+	help
+	  Select this configuration option to enable the Non-Transparent
+	  Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
+	  between PCI Root Port and PCIe Endpoint.
 
-          If in doubt, say "N" to disable Endpoint NTB driver.
+	  If in doubt, say "N" to disable Endpoint NTB driver.
-- 
2.39.2



