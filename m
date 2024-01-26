Return-Path: <stable+bounces-15976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CC083E5D1
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956691F2455F
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8F250F8;
	Fri, 26 Jan 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zBu+st0Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742A1DA2E
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309286; cv=none; b=o/1gPkpeCK+Ele3BJRZ0Z7gp4Y674DzmkeCluWTJbsGdW1boLMI64gm4djVJwrHErYfWhzM6DrNY9dapp/+K3DZJNqZNENHLGLK+6byN7rHhUKOg5BjpbN+tZvcsvz+LXIsGSs4oOV3xJLq8rVisUwjJPeJpkm1QC/KEx0MAAg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309286; c=relaxed/simple;
	bh=1X3ghktSrVTA8Gulbzb8vHBVX3KGglMjP9H0qf0Dwgo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N5k9MIfYgNLRBypLfppMZ0hipotvab5RwlKA8an/FYqpSBGXUPY+SEHFVZAjNndcpDX+3bn3jayN8L687KpEKYWsRoz1TMcl35Y8IqxRyDLGsxGmVidUfnp2P0VdiDdyJaSDTXPBbj1/hIGL7Idz7tjJ+XYECy0+LAsx6yToN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zBu+st0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD17C43390;
	Fri, 26 Jan 2024 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706309286;
	bh=1X3ghktSrVTA8Gulbzb8vHBVX3KGglMjP9H0qf0Dwgo=;
	h=Subject:To:Cc:From:Date:From;
	b=zBu+st0YwF/DG/JAIHU3XWMd5tEZosx8+e7JHac83NMwrW11CxtYZdats9aZNeX3v
	 gVNubzXRUrtQzEDpNzg8i3WtBvhhXD2BThhlCeIvY1ZkJDoaT2hZTnLbOVrmMZExlT
	 16NB9jRMfiUdpiUbolQGH3xWG/6LPEH/vZMPER8o=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm8150: fix USB wakeup interrupt types" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,jonathan@marek.ca,quic_jackp@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:48:05 -0800
Message-ID: <2024012605-aspirin-landmine-596a@gregkh>
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
git cherry-pick -x 54524b6987d1fffe64cbf3dded1b2fa6b903edf9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012605-aspirin-landmine-596a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

54524b6987d1 ("arm64: dts: qcom: sm8150: fix USB wakeup interrupt types")
0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 54524b6987d1fffe64cbf3dded1b2fa6b903edf9 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 20 Nov 2023 17:43:30 +0100
Subject: [PATCH] arm64: dts: qcom: sm8150: fix USB wakeup interrupt types

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
Cc: stable@vger.kernel.org      # 5.10
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Jack Pham <quic_jackp@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Jack Pham <quic_jackp@quicinc.com>
Link: https://lore.kernel.org/r/20231120164331.8116-11-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index fb7fd96ea61d..2ce07910dd13 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3560,8 +3560,8 @@ usb_1: usb@a6f8800 {
 
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
@@ -3613,8 +3613,8 @@ usb_2: usb@a8f8800 {
 
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 


