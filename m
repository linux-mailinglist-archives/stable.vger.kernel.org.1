Return-Path: <stable+bounces-67872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A16952F85
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3AE1C209BE
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249D1AAE34;
	Thu, 15 Aug 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hCjkVZFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460A1A76BC;
	Thu, 15 Aug 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728787; cv=none; b=ktOYKsk+/BtDG/YG1+DzG71g9POchH27qxpLY/4Tnj0ISur+Iupy7YkyBopw658nqNdiNQKOCHnzEnfeEdnWuDiHAKCd3BX3PM5C+7gS7P6CHVrSgsuz8O0NkOGidZXTcZI5fFk/pU8ytv+0x4+9MO17BcdLj6Zl38pmv1mjLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728787; c=relaxed/simple;
	bh=d/oaxdFHOw1VAdWIW6ggiIlBeUWboaZuDHjdO2zh0hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VM7KOq0HrE86rv86eiIjG5brIH5lw83eHlpvxOKe8Uix1TlhuTByoBh1eCWWzW/OXANXULv13iAxjXc4Pq0TfGvZRV5oTBqyAbgxtjejoG9252CMQggDhBFsMmLmo6rC8WT9TgwvLx1YqA/iOg4n10mM1pIGCWrszbyAS34Ozm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hCjkVZFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6988AC4AF0E;
	Thu, 15 Aug 2024 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728786;
	bh=d/oaxdFHOw1VAdWIW6ggiIlBeUWboaZuDHjdO2zh0hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCjkVZFVSwzAHg+I5cccHvqt0xmxBz478jPzk0TFEEb0/mJt9tEm/1J4dBJ1NG0mE
	 fnEeCD8gaOU/iS+wn3vI22j6PluRxmeWn9ekTXKH4UEgpHX4b69K24LQd3F34t9Kzl
	 v2xH7T8FZD6v7YkPGppj/JUWl+K1bYHdyr3Uj2uI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Slark Xiao <slark_xiao@163.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/196] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio
Date: Thu, 15 Aug 2024 15:23:45 +0200
Message-ID: <20240815131856.211591874@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 840b7a5edf88fe678c60dee88a135647c0ea4375 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index c6d2f00acf890..6ab7ca0b9bf9e 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -121,7 +121,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
-							    GPIOD_OUT_HIGH);
+							    GPIOD_OUT_LOW);
 		if (IS_ERR(rockchip->ep_gpio))
 			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
 					     "failed to get ep GPIO\n");
-- 
2.43.0




