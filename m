Return-Path: <stable+bounces-119486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6883A43E07
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6E17ED37
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E52676FD;
	Tue, 25 Feb 2025 11:44:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FA264A76
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483880; cv=none; b=AGf0BJj7na8287lZ73IEU/+R0OgetCR1fzqFA1muZAtkHWlwfAlsonIR7OYe0tpB9h6+lntZYODzd87bJt92gUA7YWZyyQiu4ZMWSjHNpSXO1TbrqaChiTTx/ifbwiMEUsbETvV3Rk/Mc6WOVCX8Krwa9xjtY0uTDi8St4LZfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483880; c=relaxed/simple;
	bh=xBZjyCskg+quH1xFd4Lix8BZWtKaoXLRdw1jrqaUxI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmVAeT+el2vzPnDOMyqQlTS+HxBSFVXr19MCGGF8CvCCTJFVggIaxVorf8ANkUIBmtuToqFr4XsKEXqiCrZiz8JVFe8ruUwtNSOytyW1fs5Xq7ecbaViXdIuA+se9mR/sbbbE2Fzju3rrA0t46qbcQgp7sCmC+8cDG4UVuo/fEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z2G3c57rSzJM7;
	Tue, 25 Feb 2025 12:44:28 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z2G3c14h7zQcd;
	Tue, 25 Feb 2025 12:44:28 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
To: stable@vger.kernel.org
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.6.y] arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck
Date: Tue, 25 Feb 2025 12:43:29 +0100
Message-ID: <20250225114329.885043-1-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025022438-automated-recycled-cc12@gregkh>
References: <2025022438-automated-recycled-cc12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

UART controllers without flow control seem to behave unstable
in case DMA is enabled. The issues were indicated in the message:
https://lore.kernel.org/linux-arm-kernel/CAMdYzYpXtMocCtCpZLU_xuWmOp2Ja_v0Aj0e6YFNRA-yV7u14g@mail.gmail.com/
In case of PX30-uQ7 Ringneck SoM, it was noticed that after couple
of hours of UART communication, the CPU stall was occurring,
leading to the system becoming unresponsive.
After disabling the DMA, extensive UART communication tests for
up to two weeks were performed, and no issues were further
observed.
The flow control pins for uart5 are not available on PX30-uQ7
Ringneck, as configured by pinctrl-0, so the DMA nodes were
removed on SoM dtsi.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Link: https://lore.kernel.org/r/20250121125604.3115235-3-lukasz.czechowski@thaumatec.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
(cherry picked from commit 5ae4dca718eacd0a56173a687a3736eb7e627c77)
[conflict resolution due to missing (cosmetic) backport of
 4eee627ea59304cdd66c5d4194ef13486a6c44fc]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index 5fcc5f32be2d7..2963d634baba9 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -367,6 +367,11 @@ &u2phy_host {
 	status = "okay";
 };
 
+&uart5 {
+	/delete-property/ dmas;
+	/delete-property/ dma-names;
+};
+
 /* Mule UCAN */
 &usb_host0_ehci {
 	status = "okay";

