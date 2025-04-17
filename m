Return-Path: <stable+bounces-133044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7EA91AB6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A676D44169B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DC23C8A7;
	Thu, 17 Apr 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/R4NLGd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55355185B67
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889069; cv=none; b=d4SMmp/YE1Z87TRjOsFPq9gPCoegBUkhCaket9S+zrEH1mFvc2EGf8Op+kXDcuCVU6Mit+LuNQin9n6UP6NKUHySMIeF+gnmIYjQZK9L28ksTzSNbuMVhnySd57b7Wwxc1SdeDNETB3trjO3S7VkhUE7OYQ+N+H6CfHkBAboexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889069; c=relaxed/simple;
	bh=1xCWb95pqXx8Pj2FWEZN7Og0F3mHh7Uq+wF7V64mDQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rb17HiH9vbhpk+WeQiCMHrB3Fljt70qyyjlgPaCuL+ACvb6XqY5GGDQwnQcqGckRel7ceJt1cs5x0YIhZq9BtFnfvXZrLuv9vWgjQLMi8WaNc0bdDRa68loIZINRJx7umVlCPTQHbpeL5dLaOzC7/ZItJvFQJ8n8EZzYsVt2ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/R4NLGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AE3C4CEE4;
	Thu, 17 Apr 2025 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889068;
	bh=1xCWb95pqXx8Pj2FWEZN7Og0F3mHh7Uq+wF7V64mDQQ=;
	h=Subject:To:Cc:From:Date:From;
	b=V/R4NLGdmxgNvn3+V6OvkA+VlaYZmrlC1ay60HkvDIW8zOjnIvUmCDP08JbzOPWk0
	 vBycpbxBs7M0kL5JMcWRi2C4DkZdUqZeTlYtz5z1m4/QxGknd45Qd5xSMGsoggfibO
	 Egg/XEE3T+GlRk7tn0UMZDTtI+M1Wr0YtIM9fu3A=
Subject: FAILED: patch "[PATCH] arm64: tegra: Remove the Orin NX/Nano suspend key" failed to apply to 6.6-stable tree
To: nmalwade@nvidia.com,treding@nvidia.com,yijuh@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:09:44 +0200
Message-ID: <2025041744-garbage-kitten-5fb9@gregkh>
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
git cherry-pick -x bb8a3ad25f098b6ea9b1d0f522427b4ad53a7bba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041744-garbage-kitten-5fb9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb8a3ad25f098b6ea9b1d0f522427b4ad53a7bba Mon Sep 17 00:00:00 2001
From: Ninad Malwade <nmalwade@nvidia.com>
Date: Thu, 6 Feb 2025 22:40:34 +0000
Subject: [PATCH] arm64: tegra: Remove the Orin NX/Nano suspend key

As per the Orin Nano Dev Kit schematic, GPIO_G.02 is not available
on this device family. It should not be used at all on Orin NX/Nano.
Having this unused pin mapped as the suspend key can lead to
unpredictable behavior for low power modes.

Orin NX/Nano uses GPIO_EE.04 as both a "power" button and a "suspend"
button. However, we cannot have two gpio-keys mapped to the same
GPIO. Therefore remove the "suspend" key.

Cc: stable@vger.kernel.org
Fixes: e63472eda5ea ("arm64: tegra: Support Jetson Orin NX reference platform")
Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
Signed-off-by: Ivy Huang <yijuh@nvidia.com>
Link: https://lore.kernel.org/r/20250206224034.3691397-1-yijuh@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
index 19340d13f789..41821354bbda 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
@@ -227,13 +227,6 @@ key-power {
 			wakeup-event-action = <EV_ACT_ASSERTED>;
 			wakeup-source;
 		};
-
-		key-suspend {
-			label = "Suspend";
-			gpios = <&gpio TEGRA234_MAIN_GPIO(G, 2) GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
-			linux,code = <KEY_SLEEP>;
-		};
 	};
 
 	fan: pwm-fan {


