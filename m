Return-Path: <stable+bounces-78527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7598BEE3
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4371C21F7C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59C1991A3;
	Tue,  1 Oct 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vqiKpmHF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60E2AF17
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791453; cv=none; b=YE6vYCDqQ694xkQGojbS1vqEPUA8lMb0awp+w2WWgXaLTvhyS//FA5eyL715SbrtpvJ3j+G/oLFJ20ml0rsn/FapNNpTSZ6nARselMWxERY3pMH9O7s8n0vA4i0bM77n+f8HTTeSaj8rJ96TfwQpZq4G91lwzZgF9OqmRskccoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791453; c=relaxed/simple;
	bh=Kilvgay/knL7/6eAKDpyUo7lNwlHQBmJCzTMYOPQ8Mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XC+jHz+LXhq92vQN1Xbbw8y/vZpvpWWcIxocbgleEJXp5W5lKl8/y9G+IfWR1IqpaeWoX2KBjWfz7Xqqx59bkLqINagt6M5RggtwCVJAqhpHfp1IMWpwu1ai4gUZPvTmNT5dNFEBUMnxe1Dn5uaG/wfWYjYIwOhv0lKdwfp36Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vqiKpmHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0A7C4CEC6;
	Tue,  1 Oct 2024 14:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791453;
	bh=Kilvgay/knL7/6eAKDpyUo7lNwlHQBmJCzTMYOPQ8Mc=;
	h=Subject:To:Cc:From:Date:From;
	b=vqiKpmHFzidaNcYlHyXwy8XhrQcGWra1B4kewatHCmd418VkBhkkldixVFnMzWzFx
	 gPrdmhf47v3mvtg8kNuF7gQOAkQmgrOGS5kcPbucdMs2LNWYNGjBjZfYd7jr6/07hq
	 PkyoZchpD42mT81mi1GMDzNBIUzVV0treBc9PBso=
Subject: FAILED: patch "[PATCH] ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,michael@amarulasolutions.com,shawnguo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:04:10 +0200
Message-ID: <2024100110-profane-wriggle-076a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1b0e32753d8550908dff8982410357b5114be78c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100110-profane-wriggle-076a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


