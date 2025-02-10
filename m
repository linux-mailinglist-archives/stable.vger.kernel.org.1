Return-Path: <stable+bounces-114630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF5BA2F08A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C64A188991B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A7236453;
	Mon, 10 Feb 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eSozCJzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EEF22258C
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199498; cv=none; b=Xh5nuDsRnd1utR4pI207dQG/QH3kM6q+HtFxQTt7e18L99Glzm4JC541JraTDcxHuolvURyE4Ot7PX1KUFaO6700nrHe/VyblhOHM1Ds3Jqp7gG1FhODV+4T+po5dfwrLlejGZi2GySoVnpkhQsHZdt8VB5d5w32xp69Rcssr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199498; c=relaxed/simple;
	bh=xA0MUrWM0Lq2ipYbwrmgXnwrp6FTR2HMVb0a5EEIrAs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GWxLsNEmNZckO1nxtUCOEPDR5/wfhMeXVQO9LJAPD9B2i6ezYnqBNrTbTFv6shbaVhp2ERzWItTfDrVAwiVoJKTIkzDgq/1Pzamgw5iv3xTXZmi/JIdNK9LdP72mDfLcrE2R3VtgplydKwkrMF+yblKEz9yXVSqCZuc5bfu7KAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eSozCJzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C45C4CED1;
	Mon, 10 Feb 2025 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199496;
	bh=xA0MUrWM0Lq2ipYbwrmgXnwrp6FTR2HMVb0a5EEIrAs=;
	h=Subject:To:Cc:From:Date:From;
	b=eSozCJzHnlkVG32FhFCw547d0384amhgLER1/MmPxFPCeryh8TOSGO2tIkPLzYheQ
	 /bht3AO7yvnsG49fOU+Kxg32eyQI3wQGjirNjL8s7AzCwkcF/KjKCEzW1o3ISAxzSq
	 7v59FKsepXkkErE9FnFVn7mDWyFPtr1KPfGRRSwE=
Subject: FAILED: patch "[PATCH] arm64: tegra: Fix typo in Tegra234 dce-fabric compatible" failed to apply to 6.1-stable tree
To: sumitg@nvidia.com,bgriffis@nvidia.com,jonathanh@nvidia.com,treding@nvidia.com,yijuh@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:58:13 +0100
Message-ID: <2025021013-rearrange-cavalry-69c3@gregkh>
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
git cherry-pick -x 604120fd9e9df50ee0e803d3c6e77a1f45d2c58e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021013-rearrange-cavalry-69c3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 604120fd9e9df50ee0e803d3c6e77a1f45d2c58e Mon Sep 17 00:00:00 2001
From: Sumit Gupta <sumitg@nvidia.com>
Date: Wed, 18 Dec 2024 00:07:36 +0000
Subject: [PATCH] arm64: tegra: Fix typo in Tegra234 dce-fabric compatible

The compatible string for the Tegra DCE fabric is currently defined as
'nvidia,tegra234-sce-fabric' but this is incorrect because this is the
compatible string for SCE fabric. Update the compatible for the DCE
fabric to correct the compatible string.

This compatible needs to be correct in order for the interconnect
to catch things such as improper data accesses.

Cc: stable@vger.kernel.org
Fixes: 302e154000ec ("arm64: tegra: Add node for CBB 2.0 on Tegra234")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Ivy Huang <yijuh@nvidia.com>
Reviewed-by: Brad Griffis <bgriffis@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20241218000737.1789569-2-yijuh@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 570331baa09e..62b9f1784030 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3995,7 +3995,7 @@ bpmp-fabric@d600000 {
 		};
 
 		dce-fabric@de00000 {
-			compatible = "nvidia,tegra234-sce-fabric";
+			compatible = "nvidia,tegra234-dce-fabric";
 			reg = <0x0 0xde00000 0x0 0x40000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
 			status = "okay";


