Return-Path: <stable+bounces-63232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA17941828
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB8AB29AE5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450A1A619B;
	Tue, 30 Jul 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fM+1TSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46918B47F;
	Tue, 30 Jul 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356155; cv=none; b=olnLiZiX6Gd0W+uFk35zbrSJjAZTjvby9MJ8vFEbMIvO68zTF5QimgOy+5WtqJl8Nz0yivagyUcQVr5tkWuIHipCkgXRFWZ+w6luxXCMrLj8DQfe/pTvvrJfc0Lkghbc2dudjY+9CqusNp2Yw4vHZZdOM4AcCH3zm12cIKTYE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356155; c=relaxed/simple;
	bh=+b5Pq+UgA2MkHFsSCEoQ5F1u6kiQa8ehSDESoa/LwPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6wgg90LiNQeBEebb9/jJJesdA7uFz0ZMFlKENw8F2tKzFtnqoSzi4+b9iIDb40Fk8dMXd8p4Vw1mhYFBkw/+xCQxh6nrJnFAl/+PQ6rfjz37+F4X36TCjKqaaA7Cm9byZBU6McqDTSkUXXHe0omD/R6Q7U6GXzX8YmAr8bMFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fM+1TSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420EFC4AF0A;
	Tue, 30 Jul 2024 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356154;
	bh=+b5Pq+UgA2MkHFsSCEoQ5F1u6kiQa8ehSDESoa/LwPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1fM+1TSkDLYK4so4A/0FL88my07sHsgcix7aya7f58ar48ilxzeWaoBqu5C6pOGeV
	 6BaMO8+CRzvOhD/NsqMLoOS/LQXxJIZUECjkgJ14G/g84V4DHz+DqYSImFA+uH42/z
	 qSyri34dXTIlcHl/TOKd2zcJCvIODFqClVD6YGrA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 117/809] arm64: dts: renesas: r8a779a0: Add missing hypervisor virtual timer IRQ
Date: Tue, 30 Jul 2024 17:39:53 +0200
Message-ID: <20240730151729.241617019@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6fca24a07e1de664c3d0b280043302e0387726df ]

Add the missing fifth interrupt to the device node that represents the
ARM architected timer.  While at it, add an interrupt-names property for
clarity,

Fixes: 834c310f541839b6 ("arm64: dts: renesas: Add Renesas R8A779A0 SoC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/671416fb31e3992101c32fe7e46147fe4cd623ae.1718890849.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
index cfa70b441e329..d76347001cc13 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
@@ -2919,6 +2919,9 @@ timer {
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




