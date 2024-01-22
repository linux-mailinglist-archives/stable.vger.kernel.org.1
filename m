Return-Path: <stable+bounces-13921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA27837EC1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E901F2A8D0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535913B7A3;
	Tue, 23 Jan 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uCDE5q3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A91272D0;
	Tue, 23 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970762; cv=none; b=arNuw9G1IKTgdxio12+ZFJ6h7lO0MMVyFzzH5O40cFvkAS8Awt/axCYmY4Ja1tgJ3sZ4rXIMOJ6DoZ9SHIw2UzR9D7xhFiB3GQbmcCWir1Obqz00dOeQsJ97+V4BeDYZ3r5eJj6NLwIlWDkRhZCOqdkVly1e1jjLHSuYSoRf5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970762; c=relaxed/simple;
	bh=l2VXDe56ZmOOEjcaSLcTZiawdAYih2JXr9Y7eOkSlL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxn3UmUeSLKyznFDFDpD9PnemUxSWUc8RM0/ZJ3/wFlYr3yZUY340L9Y0uRVxZ5vB/nTjqIAAxCwaoH4jhFejEjZAPVLDEScMNrIE3VQSZnbHc2is5YKp9aKiw8U7E3t41AA7Abq993Vx/3R7bhFogerS0xKSr9olBUQ0KaIVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uCDE5q3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9236C43143;
	Tue, 23 Jan 2024 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970762;
	bh=l2VXDe56ZmOOEjcaSLcTZiawdAYih2JXr9Y7eOkSlL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCDE5q3n0YbN7OVKbu3HSQLTDiAedHccB1p2U/dtc+8CPfKm6efeJZxbFKKqHGREO
	 6CpysY6xE+1badoSOLGT618ePcjiK9pIYgxRrNakxXGWg8zUC6l/4S8ZzUuCcP+srp
	 DQJmp9iAAkGBeb2TvOr5b9ChFbaz2gp2MpUhri6s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/417] arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types
Date: Mon, 22 Jan 2024 15:54:33 -0800
Message-ID: <20240122235755.337820241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 24f8aba9a7c77c7e9d814a5754798e8346c7dd28 ]

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Note that only triggering on rising edges can be used to detect resume
events but not disconnect events.

Fixes: bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231120164331.8116-6-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index fd1a451e1ba2..8a23250d5951 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3392,8 +3392,8 @@ usb_2: usb@8cf8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 12 IRQ_TYPE_EDGE_RISING>,
-					      <&pdc 13 IRQ_TYPE_EDGE_RISING>;
+					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq";
-- 
2.43.0




