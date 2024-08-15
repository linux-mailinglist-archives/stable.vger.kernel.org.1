Return-Path: <stable+bounces-68192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D7953113
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B49B2508A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC019EECF;
	Thu, 15 Aug 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ehhHmecn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D618D630;
	Thu, 15 Aug 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729785; cv=none; b=H3z3rlQDNeKWmJ2b/4Sqoym8frmW0PILGOSmgAlm9tD1M2+yBqSeg0jufvRsQThBlPDH9jjQQpWqh0aAzC6gYTR4mlW+i0P73BpbmDkMaazXfQh+VMNx0Myk11Udrysubw/myZc0dyBSF7A1By0LSwto8ZzDBG1eo5CHT5ergk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729785; c=relaxed/simple;
	bh=5ULIQtNMd6TI4UizeBtyHj58WecbFb7Au5Ngfit5LmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVx+LqVMflDlfX1KB6cNI2quokylCH9wvPEp2hwFlhcGWDdTofOQqwFcjw3DJKcf5k/PDAMDHCLhDDLjwATiiMdyxLnI0j4b0yE1UCPq5s8KgYfMrZQrBqqohcq5jR8How0WHk39epCVgQWM8FhWo5/paDyFcd7otXzhritw33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ehhHmecn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79786C32786;
	Thu, 15 Aug 2024 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729785;
	bh=5ULIQtNMd6TI4UizeBtyHj58WecbFb7Au5Ngfit5LmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehhHmecnLRgDZSAdIXQ5tr0q2eMbAmDNX6IPDO3sKFjgw7byTooxffc3OEKmZpv/w
	 9vzR2CJ99klavugGmzN+onikXczjtz67/NJRs6HCxyBxQ45LTCHDZc1qPDry8Sn0Ci
	 o5FQsQInoNRQh4K+fFwTnqWtNcrW40CsOti/G4pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko@sntech.de>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5.15 207/484] PCI: dw-rockchip: Fix initial PERST# GPIO value
Date: Thu, 15 Aug 2024 15:21:05 +0200
Message-ID: <20240815131949.409595755@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

commit 28b8d7793b8573563b3d45321376f36168d77b1e upstream.

PERST# is active low according to the PCIe specification.

However, the existing pcie-dw-rockchip.c driver does:

  gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);

when asserting + deasserting PERST#.

This is of course wrong, but because all the device trees for this
compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:

  $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
  $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*

The actual toggling of PERST# is correct, and we cannot change it anyway,
since that would break device tree compatibility.

However, this driver does request the GPIO to be initialized as
GPIOD_OUT_HIGH, which does cause a silly sequence where PERST# gets
toggled back and forth for no good reason.

Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW (which
for this driver means PERST# asserted).

This will avoid an unnecessary signal change where PERST# gets deasserted
(by devm_gpiod_get_optional()) and then gets asserted (by
rockchip_pcie_start_link()) just a few instructions later.

Before patch, debug prints on EP side, when booting RC:

  [  845.606810] pci: PERST# asserted by host!
  [  852.483985] pci: PERST# de-asserted by host!
  [  852.503041] pci: PERST# asserted by host!
  [  852.610318] pci: PERST# de-asserted by host!

After patch, debug prints on EP side, when booting RC:

  [  125.107921] pci: PERST# asserted by host!
  [  132.111429] pci: PERST# de-asserted by host!

This extra, very short, PERST# assertion + deassertion has been reported to
cause issues with certain WLAN controllers, e.g. RTL8822CE.

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Link: https://lore.kernel.org/linux-pci/20240417164227.398901-1-cassel@kernel.org
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: stable@vger.kernel.org	# v5.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -148,7 +148,7 @@ static int rockchip_pcie_resource_get(st
 		return PTR_ERR(rockchip->apb_base);
 
 	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
-						     GPIOD_OUT_HIGH);
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(rockchip->rst_gpio))
 		return PTR_ERR(rockchip->rst_gpio);
 



