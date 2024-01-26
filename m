Return-Path: <stable+bounces-15980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC5E83E62E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B0A1F250F4
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB30B5644F;
	Fri, 26 Jan 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dZN21JP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97B55E57
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310335; cv=none; b=aJPBclmfO5gL1Z6BKPrkMospiwZbDrQHkomqjVfIcArksNuaMG6lGcsLPyFv5z92AnB+KTM+eRkwzZ/CeppLvoio/jmThECqqfybCFmQVcYt8tZGQL2Z+im0Zz1f9OJSKk6NxSXi3+R//Kmi6uce1ShRdMQbVn98esUomqWNaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310335; c=relaxed/simple;
	bh=idRs0O2g6hyYPVaPgVBvJ+jZUSKPwtavyra8wPI6dhQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kxyTc0P7kgABK06YIEoGvWsUDZvzLqr0SBbCOnH1Olk2kIX1cAGXWk2gPkjmHWM7Cu5LGOuRPfpZGKhXKn1xu3ARw5t4DUhK1fuSV9mybFyz60F+JruZ2IxEjRR5tCQ3q/X3VhbYXcBKYcxH7kMuE/m8MLPR4AewGO59jm2ZtlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dZN21JP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0554BC433F1;
	Fri, 26 Jan 2024 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706310335;
	bh=idRs0O2g6hyYPVaPgVBvJ+jZUSKPwtavyra8wPI6dhQ=;
	h=Subject:To:Cc:From:Date:From;
	b=dZN21JP4HbRqm4/fGzvZxZx/aQ5zyteedGE8avrCXcqDBFeVluQVCBvb3fzIA15lb
	 O8mhSZtjBMYQ7BrY8JcMIjhKbwMS9LrekW+xTp0cC5JsgGDe/e5ibwn533zLXonOPB
	 nvCYHwNStjt0PUs2jSYdjML4EYAb3yZc0wmGpE04=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm8150: fix USB SS wakeup" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,jonathan@marek.ca,konrad.dybcio@linaro.org,quic_jackp@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:05:34 -0800
Message-ID: <2024012633-companion-trousers-6310@gregkh>
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
git cherry-pick -x cc4e1da491b84ca05339a19893884cda78f74aef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012633-companion-trousers-6310@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

cc4e1da491b8 ("arm64: dts: qcom: sm8150: fix USB SS wakeup")
134de5e83177 ("arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts")
54524b6987d1 ("arm64: dts: qcom: sm8150: fix USB wakeup interrupt types")
0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc4e1da491b84ca05339a19893884cda78f74aef Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 13 Dec 2023 18:34:03 +0100
Subject: [PATCH] arm64: dts: qcom: sm8150: fix USB SS wakeup

The USB SS PHY interrupts need to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states.

Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
Cc: stable@vger.kernel.org      # 5.10
Cc: Jack Pham <quic_jackp@quicinc.com>
Cc: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231213173403.29544-6-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 7f67d7d0cfff..81454442624e 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3548,7 +3548,7 @@ usb_1: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
@@ -3601,7 +3601,7 @@ usb_2: usb@a8f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 7 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",


