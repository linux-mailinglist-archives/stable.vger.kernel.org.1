Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD81374C3BB
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGILfj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjGILfi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8913D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670B860BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77874C433C7;
        Sun,  9 Jul 2023 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902536;
        bh=/UyJFN8YF2iwl/EKXJKmFOlG+TPPmgaKLa2LZEvvaHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsmgbxZAj9UIHToET3Gu+5z/iqREd7j9vCCdEclEFa1gUsu+95E10zgqrQnl6jW1O
         EKks8rOfcTqTMBrkrj0ng8WZj91ykVFDXzK49Gikgwzo4D3wiGaoqQByeadbSbngF2
         /BXH/G7PtCen346WFg18+QOj7A2I6BDuUUwMVY+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shunsuke Mie <mie@igel.co.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 394/431] PCI: endpoint: Fix a Kconfig prompt of vNTB driver
Date:   Sun,  9 Jul 2023 13:15:42 +0200
Message-ID: <20230709111500.409919626@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

[ Upstream commit 37587673cda963ec950e4983db5023802f9b5ff2 ]

vNTB driver and NTB driver have same Kconfig prompt. Changed to make it
distinguishable.

Link: https://lore.kernel.org/r/20230202103832.2038286-1-mie@igel.co.jp
Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 9fd5608868718..8efb6a869e7ce 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -27,7 +27,7 @@ config PCI_EPF_NTB
 	  If in doubt, say "N" to disable Endpoint NTB driver.
 
 config PCI_EPF_VNTB
-	tristate "PCI Endpoint NTB driver"
+	tristate "PCI Endpoint Virtual NTB driver"
 	depends on PCI_ENDPOINT
 	depends on NTB
 	select CONFIGFS_FS
-- 
2.39.2



