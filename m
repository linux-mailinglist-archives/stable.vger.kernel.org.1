Return-Path: <stable+bounces-62509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD693F4F7
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E51F205A8
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43198146D54;
	Mon, 29 Jul 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p6DUgxu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E2145B35
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255217; cv=none; b=UpTS9UK6n6p+K5sdz4dw3z5+qfqIc42mpmbrLC+jIrw1aWfp1nU5AI9vgj+fZI9kyysRDlGXe31YV2tblIiiLW+GO1XuHsl8KZv4D45NWdQhDcDz14dI+X0PmRzZJ4G0QwVy5udpG4ts+JVjk631mE6fGXXX5OBjqtvTgIOoNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255217; c=relaxed/simple;
	bh=WbYUsJqe7QkS8+7yZ7NBb2itLE2zrLSvG1TU+qRrZ2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IIus7s8prATSGLnwiUs90iCMxj6IqJz+6R/rA4JOOkjP/ii1hRgJ4f7YfuJOBA61bX5a/GYP8VuLP8bdJV4+wITvOls0/gVupDkbrLdIwH2JUqnIwGjXo8s5k3JDcxHbswA8cZMfGaTugl+Sf7bnux62c4futUZO4lUpcqddJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6DUgxu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E77DC32786;
	Mon, 29 Jul 2024 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722255216;
	bh=WbYUsJqe7QkS8+7yZ7NBb2itLE2zrLSvG1TU+qRrZ2g=;
	h=Subject:To:Cc:From:Date:From;
	b=p6DUgxu61P/uQV8giiQr45hPJ5zHexG2x9yxk0oGpa1BYh4awiQ9qfk4o7wV19yIv
	 /wv6ISP0GhaXJlTS1osHoN8SOxYTOi785gMXUeK3FW8mF2oP1BvOtTnx0eOuymuI2t
	 +h4ewGs/IMzI3DfcHRzK4Lyq5Iorw3aK7bYyjL6I=
Subject: FAILED: patch "[PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting" failed to apply to 4.19-stable tree
To: manivannan.sadhasivam@linaro.org,bhelgaas@google.com,cassel@kernel.org,kwilczynski@kernel.org,slark_xiao@163.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:13:25 +0200
Message-ID: <2024072924-yonder-factoid-6692@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 840b7a5edf88fe678c60dee88a135647c0ea4375
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072924-yonder-factoid-6692@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

840b7a5edf88 ("PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting ep_gpio")
58adbfb3ebec ("PCI: rockchip: Make 'ep-gpios' DT property optional")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 840b7a5edf88fe678c60dee88a135647c0ea4375 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 16 Apr 2024 11:12:35 +0530
Subject: [PATCH] PCI: rockchip: Use GPIOD_OUT_LOW flag while requesting
 ep_gpio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0ef2e622d36e..c07d7129f1c7 100644
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


