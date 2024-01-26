Return-Path: <stable+bounces-15971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38EE83E5C9
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AE6B21BCA
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CE2557D;
	Fri, 26 Jan 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmGddm1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3325565
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309107; cv=none; b=MPNxwxBN3B4mPVrNOKd+6TT4JpI1YaPB0DePizOb0WPG2Mf+/d4tr5ZtZHJXlFwnIUsROypjOvVIEGzWa/GA61VVqD94ahNLifPaHKxSJVJFzF+opIazVDxG2GONlYBwGehOE7vJWOdhHosVuOFHAIjjzIkPQA8drUn4w8SF2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309107; c=relaxed/simple;
	bh=D4P/Cwwq5CdPp0OkIpSHz9ustopsmcpzLyejdVJcCeo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TP6CB7LbRwcbfi23Q8+hO3PTgoa/vHoADYYphOxoQ+utqJ8smBcx5Lbb/2NcmDvZmVGcSKVhVAv4gU36OLXjgpgT6TzX3QUk00cAmLEMkdCB16ISdoQ4TqzPA8DVfNKSudk7xkodT16InXkqdKvyCKDWZwEcEed3mh/SLSd5U04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmGddm1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF67C43399;
	Fri, 26 Jan 2024 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309106;
	bh=D4P/Cwwq5CdPp0OkIpSHz9ustopsmcpzLyejdVJcCeo=;
	h=Subject:To:Cc:From:Date:From;
	b=jmGddm1fXbjEIyDwKEag72DR2EqCG/HDNmJZWLLS2LhdjrXEUgao5uonMkae9aIqP
	 eIIqHmXAtgK7Qa1FL+mIUAChaIE8KN25Xl1F/5XGXG64G4xN9tXF0nlxQeDtIxUghm
	 +zeixX1egPId4AKL6SPyueSGyGriq641f+1gm/mo=
Subject: FAILED: patch "[PATCH] ARM: dts: samsung: exynos4210-i9100: Unconditionally enable" failed to apply to 5.15-stable tree
To: paul@crapouillou.net,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:45:05 -0800
Message-ID: <2024012605-dangling-sprout-0d8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 84228d5e29dbc7a6be51e221000e1d122125826c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012605-dangling-sprout-0d8a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


