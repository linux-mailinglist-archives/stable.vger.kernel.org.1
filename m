Return-Path: <stable+bounces-112890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA143A28EE4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000921889B44
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC986348;
	Wed,  5 Feb 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCpHtXTZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28DA4A28;
	Wed,  5 Feb 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765100; cv=none; b=Te76Mvd0BT3FcjQfS0LOe0bMgHUpxAjZo2qBJkJybh7WvPIMr7TtodhGpcNjIk6EOqsxXNOnDVpTkY50Qj2Gk1XoKOaCFZ1OFeEHdT2oybzSq8+wZ6otRfXdx0zROGfE3UxaF+Y+5uwVPqs5e0PuYOSyi7HSfYnsWr5wX77Gk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765100; c=relaxed/simple;
	bh=29y330C9qF272twf62HYr/w5STOKDi0SJnlRvue6Cbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcWPr0aceJaXAvzD3A97xOatEf2msiFnpQeCGVq5n+rrSktC7Eui/F6810YU4vdakXFZz3dAFgfosgAWjwqdWzxpheon3bGKdSoGQ2pZp5Tznzl2VyIdSe7u9a2urk0Tg3PDL+qhTHu0uW0YvzKbPwz6/WGvBlhX4cA/Nj1kLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kCpHtXTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F58C4CED1;
	Wed,  5 Feb 2025 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765099;
	bh=29y330C9qF272twf62HYr/w5STOKDi0SJnlRvue6Cbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCpHtXTZM/iDlUSev/Gk0HWJcMlSDvbQcMWC27ZzXj8iaTvNYLzMNUQHAHfnIDoHh
	 15q1QxjRbv59y9TN8837ATaT/mg7hV+r1KUuVDcPXUw+T01C+jUNnmiCPDsuWkyU5j
	 uitny2YUBLWHeUfjjzNszXkLqYQikQVi02ZebtGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 232/393] arm64: dts: qcom: msm8996: Fix up USB3 interrupts
Date: Wed,  5 Feb 2025 14:42:31 +0100
Message-ID: <20250205134429.181834244@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 9cb9c9f4e1380da317a056afd26d66a835c5796c ]

Add the missing interrupt lines and fix qusb2_phy being an impostor
of hs_phy_irq.

This happens to also fix warnings such as:

usb@6af8800: interrupt-names: ['hs_phy_irq', 'ss_phy_irq'] is too short

Fixes: 4753492de9df ("arm64: dts: qcom: msm8996: Add usb3 interrupts")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20241129-topic-qcom_usb_dtb_fixup-v1-3-cba24120c058@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1f7cbb35886db..70ef8c83e7b9f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3046,9 +3046,14 @@
 			#size-cells = <1>;
 			ranges;
 
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupt-names = "pwr_event",
+					  "qusb2_phy",
+					  "hs_phy_irq",
+					  "ss_phy_irq";
 
 			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
-- 
2.39.5




