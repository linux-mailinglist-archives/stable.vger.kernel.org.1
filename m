Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE476FA3BA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjEHJvZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjEHJvL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F923A38
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C2A9621C3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F17C433EF;
        Mon,  8 May 2023 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539463;
        bh=+ELJTY/izH7HXwQ+yIPWW8mOB7KjdjcR4QQ3qwuwqw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=przja7YorBar38xDqUshhz0Ju/ATfztd8M8BavPT+McFXJvzESp/xUbxMXSJzHWQ5
         VHQTq9vX4xoA6BQk1MjVD7u2Xyy5hDDGfcz/l6rLqpkPU4EX4J18MC0FZsn5JwPMGX
         +vfhyr3SW4b1g40gGMpJUCNjBxO+d4NGh9xDSYBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 6.1 025/611] PCI: kirin: Select REGMAP_MMIO
Date:   Mon,  8 May 2023 11:37:47 +0200
Message-Id: <20230508094422.545875268@linuxfoundation.org>
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
@@ -294,6 +294,7 @@ config PCI_MESON
 	default m if ARCH_MESON
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select REGMAP_MMIO
 	help
 	  Say Y here if you want to enable PCI controller support on Amlogic
 	  SoCs. The PCI controller on Amlogic is based on DesignWare hardware


