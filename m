Return-Path: <stable+bounces-64474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2E941E36
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00892B29F04
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE491A76B2;
	Tue, 30 Jul 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvo3miRx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CA1A76A1;
	Tue, 30 Jul 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360241; cv=none; b=jhyoDe2OKzer+BzDiiAqrrnQfQh6jQGTyo4QrpiB94eH2JvVRKXUy3kF6rBzTcitMdZWE3Wx7FptC4Z5qlBM1x3Uvh/50pOrY+fiqivHREI6vrquLQEfoM+J3h6nTKjFhdLtyfOYvscfXCd9ClO1psSp9tS1yLGqBFvuU8faXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360241; c=relaxed/simple;
	bh=nnNHPhRLHoDq9hRuvjXAhk6aKc7TB+GOWTqjs9EGX/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9hTqsA6uh1Fs6ykHhLjSaQzZFLu1264bPhsA0gcnuWuJCPHAfX3Xe9ZqtndD9B7Zod1sOix3+JSSelZMFpZI/R7ZJmkxIlRml9wmIbKrvK7x3ZT7YOolePYDUnsrL2zQ2rVRRDkDjHSXQStlZ6UQgUKjveuPRLWk86tL9BiM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvo3miRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932FFC32782;
	Tue, 30 Jul 2024 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360241;
	bh=nnNHPhRLHoDq9hRuvjXAhk6aKc7TB+GOWTqjs9EGX/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvo3miRxYHSe9NIf2jFexYAbskB9rVq986+ovvgL9wVpirRuMH/rUISdWSb7jzLWk
	 7O+iH+BPDJGvck8eeXLPxW4U60rDZqGFdDqGbe4ma10ERoM2bBg8N3tOntNWcnh8FB
	 pzxQ5bqxzUs0K1SEDydnUmCILTLdFaKTV4hYyvXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Slark Xiao <slark_xiao@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.10 640/809] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio
Date: Tue, 30 Jul 2024 17:48:36 +0200
Message-ID: <20240730151750.132393990@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit 840b7a5edf88fe678c60dee88a135647c0ea4375 upstream.

Rockchip platforms use 'GPIO_ACTIVE_HIGH' flag in the devicetree definition
for ep_gpio. This means, whatever the logical value set by the driver for
the ep_gpio, physical line will output the same logic level.

For instance,

  gpiod_set_value_cansleep(rockchip->ep_gpio, 0); --> Level low
  gpiod_set_value_cansleep(rockchip->ep_gpio, 1); --> Level high

But while requesting the ep_gpio, GPIOD_OUT_HIGH flag is currently used.
Now, this also causes the physical line to output 'high' creating trouble
for endpoint devices during host reboot.

When host reboot happens, the ep_gpio will initially output 'low' due to
the GPIO getting reset to its POR value. Then during host controller probe,
it will output 'high' due to GPIOD_OUT_HIGH flag. Then during
rockchip_pcie_host_init_port(), it will first output 'low' and then 'high'
indicating the completion of controller initialization.

On the endpoint side, each output 'low' of ep_gpio is accounted for PERST#
assert and 'high' for PERST# deassert. With the above mentioned flow during
host reboot, endpoint will witness below state changes for PERST#:

  (1) PERST# assert - GPIO POR state
  (2) PERST# deassert - GPIOD_OUT_HIGH while requesting GPIO
  (3) PERST# assert - rockchip_pcie_host_init_port()
  (4) PERST# deassert - rockchip_pcie_host_init_port()

Now the time interval between (2) and (3) is very short as both happen
during the driver probe(), and this results in a race in the endpoint.
Because, before completing the PERST# deassertion in (2), endpoint got
another PERST# assert in (3).

A proper way to fix this issue is to change the GPIOD_OUT_HIGH flag in (2)
to GPIOD_OUT_LOW. Because the usual convention is to request the GPIO with
a state corresponding to its 'initial/default' value and let the driver
change the state of the GPIO when required.

As per that, the ep_gpio should be requested with GPIOD_OUT_LOW as it
corresponds to the POR value of '0' (PERST# assert in the endpoint). Then
the driver can change the state of the ep_gpio later in
rockchip_pcie_host_init_port() as per the initialization sequence.

This fixes the firmware crash issue in Qcom based modems connected to
Rockpro64 based board.

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Closes: https://lore.kernel.org/mhi/20240402045647.GG2933@thinkpad/
Link: https://lore.kernel.org/linux-pci/20240416-pci-rockchip-perst-fix-v1-1-4800b1d4d954@linaro.org
Reported-by: Slark Xiao <slark_xiao@163.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org	# v4.9
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pcie-rockchip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -121,7 +121,7 @@ int rockchip_pcie_parse_dt(struct rockch
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
-							    GPIOD_OUT_HIGH);
+							    GPIOD_OUT_LOW);
 		if (IS_ERR(rockchip->ep_gpio))
 			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
 					     "failed to get ep GPIO\n");



