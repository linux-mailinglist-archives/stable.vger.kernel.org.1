Return-Path: <stable+bounces-63131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54883941780
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8693E1C23D53
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194218B470;
	Tue, 30 Jul 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CiNcXGUG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77C187FF2;
	Tue, 30 Jul 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355770; cv=none; b=VNOeMjRXGmeq94NwdcgRkDazDAW2lyS7FZrwPqnkCSj7Txtw6FqbNFLpaIZBMkWhux1ie8rAtukT3agJzi0TucdYF3cqgBUy/Od2koCDlHekbHRdtrFIMixy1rRCZRemJBd7LJpDH75FdLjvqW2cjgwOuZT0auKCmjn0ipoGCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355770; c=relaxed/simple;
	bh=53ssiMPPU2cwR9NnG0WYEN6f1SIJKsrtD8bW32q9wyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+QJ6XYi/UMORBka4s8SC8hQDtL4i00f1/vjFYZ4h74xQQfWiymWmvX+SVM5oqmYQxZN9pT0gIqrnJrk/k2XhVyiR4XlwjISg9SRfeHwqP5iJx8pwSYTnUDJq1+7qb7A9yn4XRZeyIgHW0JPD2GZASSGtSS4OlYxJIAE0dp79Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CiNcXGUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655FBC32782;
	Tue, 30 Jul 2024 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355770;
	bh=53ssiMPPU2cwR9NnG0WYEN6f1SIJKsrtD8bW32q9wyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiNcXGUGwXAujFiKX67XJBN6asf7aQk2pFUmfiwe5QDua4gJss9A1My8O6Hpsyxrw
	 WQOP4ICBL/GgSaK74kyFjzbcr2SmwR2GaC8rYwmL2L9NyRtynOQ7BgH68aZE5HSbJY
	 GXImV5BsOq4FCY9SmxybZtkkaCDPUEViZnhn+6qM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 088/568] arm64: dts: renesas: r9a07g054: Add missing hypervisor virtual timer IRQ
Date: Tue, 30 Jul 2024 17:43:15 +0200
Message-ID: <20240730151643.312315159@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 2918674704aad620215c41979a331021fe3f1ec4 ]

Add the missing fifth interrupt to the device node that represents the
ARM architected timer.  While at it, add an interrupt-names property for
clarity,

Fixes: 7c2b8198f4f321df ("arm64: dts: renesas: Add initial DTSI for RZ/V2L SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/834244e77e5f407ee6fab1ab5c10c98a8a933085.1718890849.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 0d327464d2baf..3f01b096cfb71 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1295,6 +1295,9 @@ timer {
 		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+				      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys",
+				  "hyp-virt";
 	};
 };
-- 
2.43.0




