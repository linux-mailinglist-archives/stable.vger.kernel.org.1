Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E57A7EAC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjITMUN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbjITMTi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D0EC2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:19:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE693C433CD;
        Wed, 20 Sep 2023 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212372;
        bh=4cGNxmBP/hYhQ9gvxmRo9wFK5Hv9SFWIoPhKRp6mr9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTrmqRlcck73DR/ikwnLMQMuk0FL1icY4wyrAnO9RU/zcDjQ9jdmfjKi4Jpkz/8Kw
         KxgS5e7OyleqeW/Dg0UZOnwfAjsntLwUhEOGlk3EYP2EUvjLwuNjBsg1i9j/dBELlr
         MjY9JrUNELyI2wtYe+4xOzCNGl+yinpwSqNASm5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 252/273] PCI: dwc: Provide deinit callback for i.MX
Date:   Wed, 20 Sep 2023 13:31:32 +0200
Message-ID: <20230920112854.080617206@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit fc8b24c28bec19fc0621d108b9ee81ddfdedb25a ]

The i.MX integration for the DesignWare PCI controller has a _host_exit()
operation which undoes everything that the _host_init() operation does but
does not wire this up as the host_deinit callback for the core, or call it
in any path other than suspend. This means that if we ever unwind the
initial probe of the device, for example because it fails, the regulator
core complains that the regulators for the device were left enabled:

imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie: probe of 33800000.pcie failed with error -110
------------[ cut here ]------------
WARNING: CPU: 2 PID: 46 at drivers/regulator/core.c:2396 _regulator_put+0x110/0x128

Wire up the callback so that the core can clean up after itself.

Link: https://lore.kernel.org/r/20230731-pci-imx-regulator-cleanup-v2-1-fc8fa5c9893d@kernel.org
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3b2ceb5667289..c949d11f95507 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -642,6 +642,7 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_deinit = imx6_pcie_host_exit,
 };
 
 static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
-- 
2.40.1



