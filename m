Return-Path: <stable+bounces-78531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7198BEE9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36171F23B94
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55351C3F1F;
	Tue,  1 Oct 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVVVaYNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6F1C6889
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791465; cv=none; b=qPmGCna9LpEB9Lx5JpRFuYTrYwvAFyMmHVL8U+gNKCY2OCNDaqsuwqP3TV1EPyA6tqykk3+6hIy5jCyYwrDK5t3dnXsq4BfJLc4WmpAfkFmGGmoc0KsWFaY/YRlN75iMDaZ2bJbjCRSkQP5Ul8pHp8UAnGwM3Tr05cCRyEpchhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791465; c=relaxed/simple;
	bh=6ZlZIBwZDL695LrpQ3s6pv1Surc060LPov9SS6jBpDU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jfUv5AELM1eb3aeI1lk4VfkX0OGPq3B2EhIkQ1Q+uiSVkUK1BIRhqvLynGAEe6tBg3UVdswzv24/NK49q23tePhp4UzJvWIoJXPOiSiUs59GJfiBiDkG5Jj6jxgk5Gyw2+8DCh6cqUBdaAXlO9D9hHmPeJSdeYZBzwI9rw9pJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVVVaYNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95061C4CEC6;
	Tue,  1 Oct 2024 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791465;
	bh=6ZlZIBwZDL695LrpQ3s6pv1Surc060LPov9SS6jBpDU=;
	h=Subject:To:Cc:From:Date:From;
	b=tVVVaYNOr1PM6uTJjuw3vLtBBG8LbT8/9TyZ79zaQzKjm2KIJoliMJkH/ojwRO2te
	 9hZmkvCeCMeRFbcMP82tEPNZfkjjIZvSsLU781yxX6EadsPDMCrQAa3a45S4qW+8yl
	 z8p4Od+XQJIQCAauBQwlOUlcK9/h+/djo9BgpyO0=
Subject: FAILED: patch "[PATCH] ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp" failed to apply to 4.19-stable tree
To: krzysztof.kozlowski@linaro.org,michael@amarulasolutions.com,shawnguo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:04:13 +0200
Message-ID: <2024100113-satchel-circulate-81a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1b0e32753d8550908dff8982410357b5114be78c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100113-satchel-circulate-81a1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


