Return-Path: <stable+bounces-15984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228583E632
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE11F22A41
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923C56466;
	Fri, 26 Jan 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHCjw0P1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE2F1C294
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310419; cv=none; b=Sho4z1ImS7gagorf0eFSpQAkDD1OlE+LKQVoxg0xP83KiTv5lW/rexZmgkQioZ3GiGtOBpDSUb/UOt2LYJqI8ikJ+00oKLk0dPTNg7UNpFvPvLVQ1WdjURdEJJd+KTEpOPZ/ei3dn/2dNW4WyvvRQABEUAuQyZH/2xc/vjwlGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310419; c=relaxed/simple;
	bh=ky+QlPa/I2GfTOf18QSA1TWjKQXUFjzjmHv01C9+Slc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dCagXLtlDiD3fgplSU8qt4OhsgVjmLINPdegc6xiJKIr3eV7ezQdydJOSIHhXLMnmNRRPIknME4qCvGPTTcG01mhvt45lMpQPhq7F7nb1fnjKPkAYU9mScqqAhObfnlzbak/lTWy+jq6e8JdTgehTNOm5ztlMM1qLDu1jIGbt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHCjw0P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF70C433A6;
	Fri, 26 Jan 2024 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310418;
	bh=ky+QlPa/I2GfTOf18QSA1TWjKQXUFjzjmHv01C9+Slc=;
	h=Subject:To:Cc:From:Date:From;
	b=CHCjw0P1Bm/qPaSkesKxHO7/IN7kaBFmxdTtJoaANQr07gFuQEkdSMo92o/eAAvTM
	 8QNjsPE3e2EyC1LBuKqXVqGa08z8Bvl5blHE53xmz6iXbS8ZgaK6dpVlyXDWVTp972
	 N6JGz0tGJazsIg7InO1R+EC/fudZBp/Yk43EoloE=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm6375: fix USB wakeup interrupt types" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:06:57 -0800
Message-ID: <2024012657-magician-flatworm-8577@gregkh>
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
git cherry-pick -x 41952be6661b20f56c2c5b06c431880dd975b747
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012657-magician-flatworm-8577@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

41952be6661b ("arm64: dts: qcom: sm6375: fix USB wakeup interrupt types")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41952be6661b20f56c2c5b06c431880dd975b747 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 20 Nov 2023 17:43:29 +0100
Subject: [PATCH] arm64: dts: qcom: sm6375: fix USB wakeup interrupt types

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Fixes: 59d34ca97f91 ("arm64: dts: qcom: Add initial device tree for SM6375")
Cc: stable@vger.kernel.org      # 6.2
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231120164331.8116-10-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 2fba0e7ea4e6..331bd98dbfde 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1405,8 +1405,8 @@ usb_1: usb@4ef8800 {
 
 			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 93 IRQ_TYPE_EDGE_BOTH>,
+				     <GIC_SPI 94 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",


