Return-Path: <stable+bounces-185896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94472BE2316
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BB83B4289
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583672FF14D;
	Thu, 16 Oct 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y3ilnjGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AE2E7647
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604067; cv=none; b=L2xzhkFInqad5wkraZHze7rPwQnv04IVx9c11QQjfKxNjrftmJky/TAbZH/f8iMn5b45vsWZiM3qZ7Sx+1dUuUimpKIXyIav9vEePGHg9W0eTbLmyQmAm+3rH3a3jADKz1cXFMD84J+iN0nSPIsrheduBi5JnQC5ktL1KPRSVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604067; c=relaxed/simple;
	bh=XlmzcnQwz6RLYkkZlhDEhuTO/sHf9UsoLvBKpg8KKqE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IWY5EmfLbBCVNDMzOkvmhgWPAHnSbBU6UmtNJzpSm7bRCswb1f6JqaxZn/eocZpD5hWmqlVaQh2jL81a/UhUjqgE7JgnTdKWnkgFugkLu0lnrSeDU7G+8uyOLLjDARpXFs2k9+RntV+26m7TeY6/jQkDAKLLb+oNWsXF4fMUZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y3ilnjGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225DEC4CEF1;
	Thu, 16 Oct 2025 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760604064;
	bh=XlmzcnQwz6RLYkkZlhDEhuTO/sHf9UsoLvBKpg8KKqE=;
	h=Subject:To:Cc:From:Date:From;
	b=Y3ilnjGHmOjvaep1PUNw4S6IujiYhnjrzry/7WyvMqtQx9m4q2deZK96SLUSa17YF
	 CS8RvNXN7BZJRw2S3tdQ7l+rDKxAo53WC4PiOPzktk7XYxmo0WGMyVYMJZ0XyyPwSF
	 WrNAsaIyJ09YGilWFzEyndGLSB+orslX/1HcWryM=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees" failed to apply to 5.10-stable tree
To: stephan.gerhold@linaro.org,andersson@kernel.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:40:53 +0200
Message-ID: <2025101653-armory-oxygen-af78@gregkh>
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
git cherry-pick -x 316294bb6695a43a9181973ecd4e6fb3e576a9f7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101653-armory-oxygen-af78@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 316294bb6695a43a9181973ecd4e6fb3e576a9f7 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 21 Aug 2025 10:15:09 +0200
Subject: [PATCH] arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees

Reading the hardware registers of the &slimbam on RB3 reveals that the BAM
supports only 23 pipes (channels) and supports 4 EEs instead of 2. This
hasn't caused problems so far since nothing is using the extra channels,
but attempting to use them would lead to crashes.

The bam_dma driver might warn in the future if the num-channels in the DT
are wrong, so correct the properties in the DT to avoid future regressions.

Cc: stable@vger.kernel.org
Fixes: 27ca1de07dc3 ("arm64: dts: qcom: sdm845: add slimbus nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250821-sdm845-slimbam-channels-v1-1-498f7d46b9ee@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 828b55cb6baf..02536114edb8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5396,11 +5396,11 @@ slimbam: dma-controller@17184000 {
 			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
-			num-channels = <31>;
+			num-channels = <23>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,num-ees = <2>;
+			qcom,num-ees = <4>;
 			iommus = <&apps_smmu 0x1806 0x0>;
 		};
 


