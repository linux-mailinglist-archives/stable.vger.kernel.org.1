Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5213F6FA9B0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbjEHKyp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjEHKyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7C2DD68
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6886C61861
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB30C433EF;
        Mon,  8 May 2023 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543198;
        bh=TpRGYZLW1Jl7VW9lxL3nUp7pMtrtcivWllW2Mu7JdFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8dZgrviy/7zaPSl6LfOXBnMgB4I3Gu7WICpHmqs+qPokz9SH9JC5URsUTHlecRE8
         xgnTr/OxI8tldgCLf4EH8hbn6f8v8aYLy+Uw9o9qje516zfKtHlnEX83fu46AC9m08
         u8rbpfiixhlMSYtLw45HNEUoPd7X8Mx9B7oozmAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 6.3 004/694] PCI: kirin: Select REGMAP_MMIO
Date:   Mon,  8 May 2023 11:37:19 +0200
Message-Id: <20230508094432.769409153@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Josh Triplett <josh@joshtriplett.org>

commit 3a2776e8a0e156a61f5b59ae341d8fffc730b962 upstream.

pcie-kirin uses regmaps, and needs to pull them in; otherwise, with
CONFIG_PCIE_KIRIN=y and without CONFIG_REGMAP_MMIO pcie-kirin produces
a linker failure looking for __devm_regmap_init_mmio_clk().

Fixes: d19afe7be126 ("PCI: kirin: Use regmap for APB registers")
Link: https://lore.kernel.org/r/04636141da1d6d592174eefb56760511468d035d.1668410580.git.josh@joshtriplett.org
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
[lpieralisi@kernel.org: commit log and removed REGMAP select]
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -307,6 +307,7 @@ config PCIE_KIRIN
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI
 	select PCIE_DW_HOST
+	select REGMAP_MMIO
 	help
 	  Say Y here if you want PCIe controller support
 	  on HiSilicon Kirin series SoCs.


