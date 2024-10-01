Return-Path: <stable+bounces-78530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63898BEE8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34244284874
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF31C6881;
	Tue,  1 Oct 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IovDw8rx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9771C57BB
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791462; cv=none; b=Wgus8xGY/uDtqFvkWi2rgqbvr8BRihMetG2OLytXOs/FcZHwcarpfzgLxokjUq40SjtMU3OfKv/aVpBOowF0/P4vnqNMDl9mt77Otl+awScEhhNB0FASVn58u7AcVpxJI9EEJIK18/p7GirRoQtUq5MqioWzvrFL/RrgUscCHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791462; c=relaxed/simple;
	bh=vYTw22pCVoPzbvijtFg8iAjJFoBlX2D117SMT5niaNs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mdarVNOhLXMZ3G5k+Xc42OHuhfoSQAShHDbGpBI4IY6Z3vvz1HZc0kNlf+WAZMNrKLBSz0XG365f3L0zN1+5rPBjrCwugmwDudmIdAoyKaYIe6UVvWgDaEHsGdwvBE+ybnwGxc3/GO0+ZtOrljDRtsm8RSN70YdZoXEoVRMfuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IovDw8rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA69EC4CECD;
	Tue,  1 Oct 2024 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791462;
	bh=vYTw22pCVoPzbvijtFg8iAjJFoBlX2D117SMT5niaNs=;
	h=Subject:To:Cc:From:Date:From;
	b=IovDw8rxDqMtKCCXdw/3b/2+Vg5Sss5zNJqx3DRHCQXcOqS1+/AbRnTEQSegd2y4P
	 pg6UOoalJxboYjF8vmmSGQ/oUOS4MCeffw0mhXHOKwma7TQYBRct1XPIUJ3lZu/R9a
	 F6zDIlNbPhj2vV9ZdLJ7N3TLKIUbGv1Fo/blpCG0=
Subject: FAILED: patch "[PATCH] ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp" failed to apply to 5.10-stable tree
To: krzysztof.kozlowski@linaro.org,michael@amarulasolutions.com,shawnguo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:04:12 +0200
Message-ID: <2024100111-lilac-underarm-be95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1b0e32753d8550908dff8982410357b5114be78c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100111-lilac-underarm-be95@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

1b0e32753d85 ("ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b0e32753d8550908dff8982410357b5114be78c Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 31 Aug 2024 12:11:28 +0200
Subject: [PATCH] ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp
 pinctrl

The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
configuration was not applied.  Fixes dtbs_check warnings:

  imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pins' is a required property
  imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pin' does not match any of the regexes: 'pinctrl-[0-9]+'

Cc: stable@vger.kernel.org
Fixes: a58e4e608bc8 ("ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index cdbb8c435cd6..601d89b904cd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -365,7 +365,7 @@ MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
 	};
 
 	pinctrl_tsc: tscgrp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
 			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
 			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0


