Return-Path: <stable+bounces-15970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D6583E5C7
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FC528237E
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B598250F4;
	Fri, 26 Jan 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vLG4dG9m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB91C294
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309106; cv=none; b=Mp9+mfv/QKRuQ82vjmUP9YGSxpsN5D0SSJO1TYNySSPoPkQKPWrV0ORfs6n/pWwRCC12viZzTl3rtS9+Kdxl4F7B71WN2yx09I+u5ObL6kguQ5C38muQIZpsAIMtizJriOOxFwTlpiQPQPkHDEFFng9rWT1j2TaEDqgZj5uCLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309106; c=relaxed/simple;
	bh=vojwAIx9FKHvtoP6j/4lIY3gpu8EuR/m0t2tX3Mrqgw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U3gVO/lj+9Dmo+wF+4cKvz0FY62JyiT134RmdWqIGrtsjGkd152xmtnQnFGSH4FqAawGCdNIURSAKf6kE98VwxxjlQ/qr8WGjBRyODhxYweOviQ7QYy1Mba8CB/WveUY6Ta+giCmf81+HqZ5+KZDRfvZTzBPqUcp5xwcBubXZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vLG4dG9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8E8C433F1;
	Fri, 26 Jan 2024 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309105;
	bh=vojwAIx9FKHvtoP6j/4lIY3gpu8EuR/m0t2tX3Mrqgw=;
	h=Subject:To:Cc:From:Date:From;
	b=vLG4dG9mBLQ9xdihktujKallPR4IRqk/Xw2TC9u5lpE6uEP8m3KJQ9Vc1HcJaZvwn
	 gCt1MMMH18GMsgwNiH/wWyOMvgmCd32WsZxLRkBZszUJYSUY64nMTUZNIbg1FW/rr+
	 xcYiEaHFJUWh916BiJWFvBGBvAGkqrkhkxhj+fCU=
Subject: FAILED: patch "[PATCH] ARM: dts: samsung: exynos4210-i9100: Unconditionally enable" failed to apply to 6.1-stable tree
To: paul@crapouillou.net,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:45:04 -0800
Message-ID: <2024012604-identify-helpline-73f8@gregkh>
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
git cherry-pick -x 84228d5e29dbc7a6be51e221000e1d122125826c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012604-identify-helpline-73f8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

84228d5e29db ("ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 84228d5e29dbc7a6be51e221000e1d122125826c Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Wed, 6 Dec 2023 23:15:54 +0100
Subject: [PATCH] ARM: dts: samsung: exynos4210-i9100: Unconditionally enable
 LDO12

The kernel hangs for a good 12 seconds without any info being printed to
dmesg, very early in the boot process, if this regulator is not enabled.

Force-enable it to work around this issue, until we know more about the
underlying problem.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
Cc: stable@vger.kernel.org # v5.8+
Link: https://lore.kernel.org/r/20231206221556.15348-2-paul@crapouillou.net
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index a9ec1f6c1dea..a076a1dfe41f 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -527,6 +527,14 @@ vtcam_reg: LDO12 {
 				regulator-name = "VT_CAM_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				/*
+				 * Force-enable this regulator; otherwise the
+				 * kernel hangs very early in the boot process
+				 * for about 12 seconds, without apparent
+				 * reason.
+				 */
+				regulator-always-on;
 			};
 
 			vcclcd_reg: LDO13 {


