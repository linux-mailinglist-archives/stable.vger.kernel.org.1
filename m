Return-Path: <stable+bounces-191102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38BC10EC8
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFB4C353125
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8631D389;
	Mon, 27 Oct 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sAfdAomX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C323EA92;
	Mon, 27 Oct 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593012; cv=none; b=dExbruJlef/EySdZwzjRynLhBZ8YdpJ+4hhfSjHCRNfnBku5gl4WG9H2Iqq2TWCxMiqo8VlVNDFzdz1BAfZzYCvOyZ+oHJzLpJ0V7Ih/EVFPICZLD7Z/LBi0JKeoQ1K53VP7gzfBRJHEapJ3AnXXmSar2wsZwujTV5VcV4Xifng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593012; c=relaxed/simple;
	bh=W0+he7Qhmw4PoK8Sd479LUq3Y6xhoFJNPgh6fLSvaR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFtYGQfHvR4cD897hr8/oWy/03PkZEIA+mv53i/1jINIvQK7PlXvPd1rXZzrElt3fVYNNWmg2iS+Wu+ZbUtYfIu/mlFyxPFO+XFg9S3siL/xiBddf1jgRNVZrdw8Q69dzGgJuiGJlt6DWa+23K77HNAfADDJdCTAUcQltvN5m6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sAfdAomX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05EFC4CEF1;
	Mon, 27 Oct 2025 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761593012;
	bh=W0+he7Qhmw4PoK8Sd479LUq3Y6xhoFJNPgh6fLSvaR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAfdAomXwQ5o8Qmeiq7XVMweNk5vzHInrbNgpqOVXKAwq9ypNG+FCWpR5sNvYiyET
	 UKN9L9/obm/8blzAe8l+jPK73csG8tXXG8j8LRK2J+O+Y2WJrW7MTJL0k3lV1Nyqsr
	 P9iCwaSK2NqbHUA3wpwW6v/L/8dukLrIU4BeLczI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 070/117] arm64: dts: broadcom: bcm2712: Add default GIC address cells
Date: Mon, 27 Oct 2025 19:36:36 +0100
Message-ID: <20251027183455.898569616@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 278b6cabf18bd804f956b98a2f1068717acdbfe3 ]

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  bcm2712.dtsi:494.4-497.31: Warning (interrupt_map): /axi/pcie@1000110000:interrupt-map:
    Missing property '#address-cells' in node /soc@107c000000/interrupt-controller@7fff9000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250822133407.312505-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Stable-dep-of: aa960b597600 ("arm64: dts: broadcom: bcm2712: Define VGIC interrupt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 447bfa060918c..0f38236501743 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -263,6 +263,7 @@
 			      <0x7fffc000 0x2000>,
 			      <0x7fffe000 0x2000>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 		};
 	};
-- 
2.51.0




