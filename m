Return-Path: <stable+bounces-118750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA4EA41AE1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051D216C0F3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A529024A077;
	Mon, 24 Feb 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wk0lKfEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65299241669
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392816; cv=none; b=Uz6YK9rP8ng/GYolAvmlHDC2VHD5T7Xn6IyiY7ZbozJJz6aoy5hWMFLKzL85A362V2ju9o7huvE2hzaqUPfMIcoebL0sDXDQGLJFH2viRLCwZpllvtxC09EOsqfayFG8U56myVjtPodrGGTMTfqpz2fhlr/9QDoMjv1uuJXU9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392816; c=relaxed/simple;
	bh=r33iTZDDJUxs/85dJZ/C90jYywLaSCrfn/ikCYonfVw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UKdZeMaYpB2ttCK8SZ59vvl6yUyTcv0FYd8cd8xLlaxIRw/M76jUfpYRemyzxFGlJZt1tt2wTgWbnC/W28j/mSikYnvOcrMZI3NA4OtgZ5MUArthXuV+IUsC5cVi+L7uSkaYk7Bz9A0u2iItXvC43YxFmI0fsqatz0cIn+pA3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wk0lKfEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850E7C4CED6;
	Mon, 24 Feb 2025 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392815;
	bh=r33iTZDDJUxs/85dJZ/C90jYywLaSCrfn/ikCYonfVw=;
	h=Subject:To:Cc:From:Date:From;
	b=Wk0lKfEOOfCv+q1DoB16swN6+QSEx9VRWnb4MF3LYQghGTj8DY3sTnhoOoKPCpIi4
	 t8qeadfP2s6UB3qS9oiV0vXBzMWP+tMI+dJbm1BtoFDA1Q1AFHl4nD3Nrvzt1ipmqr
	 KYjg0Cq8Xmd8ld31Pt8BAlHeLYr12POy0VWjMPBw=
Subject: FAILED: patch "[PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl names for" failed to apply to 6.6-stable tree
To: eagle.alexander923@gmail.com,dsimic@manjaro.org,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:26:50 +0100
Message-ID: <2025022450-tarmac-submerge-26bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5c8f9a05336cf5cadbd57ad461621b386aadb762
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022450-tarmac-submerge-26bd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c8f9a05336cf5cadbd57ad461621b386aadb762 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <eagle.alexander923@gmail.com>
Date: Thu, 30 Jan 2025 08:38:49 +0300
Subject: [PATCH] arm64: dts: rockchip: Fix broken tsadc pinctrl names for
 rk3588

The tsadc driver does not handle pinctrl "gpio" and "otpout".
Let's use the correct pinctrl names "default" and "sleep".
Additionally, Alexey Charkov's testing [1] has established that
it is necessary for pinctrl state to reference the &tsadc_shut_org
configuration rather than &tsadc_shut for the driver to function correctly.

[1] https://lkml.org/lkml/2025/1/24/966

Fixes: 32641b8ab1a5 ("arm64: dts: rockchip: add rk3588 thermal sensor")
Cc: stable@vger.kernel.org
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
Link: https://lore.kernel.org/r/20250130053849.4902-1-eagle.alexander923@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 8cfa30837ce7..978de506d434 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2668,9 +2668,9 @@ tsadc: tsadc@fec00000 {
 		rockchip,hw-tshut-temp = <120000>;
 		rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
 		rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
-		pinctrl-0 = <&tsadc_gpio_func>;
-		pinctrl-1 = <&tsadc_shut>;
-		pinctrl-names = "gpio", "otpout";
+		pinctrl-0 = <&tsadc_shut_org>;
+		pinctrl-1 = <&tsadc_gpio_func>;
+		pinctrl-names = "default", "sleep";
 		#thermal-sensor-cells = <1>;
 		status = "disabled";
 	};


