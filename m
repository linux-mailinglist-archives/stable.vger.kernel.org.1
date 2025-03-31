Return-Path: <stable+bounces-127065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87544A76817
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299531885091
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BE1E570A;
	Mon, 31 Mar 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY6wyoAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD821516E;
	Mon, 31 Mar 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431658; cv=none; b=fkC4CrNcqdPtHATPVYSyeh1KWAFu+8OqqHb6kb3K/dEF8xEeCRiohqphQLDpQnpfVzCx9kzJPgYoNg2HGcAxNOJMgvly3YbjRf5BGyp71oAkP2lDFthY5O4q3d8/oU5PIrWvvZdVY1evtZbKBcy+OUuQCZO03/mKQG8wEUC5/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431658; c=relaxed/simple;
	bh=Sod3UEvmQzflWu9AcZV6qGlMGbbHJP/efdLxBV3kV2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u401Ikkr7pCG+TWihMqu8burUcBU4oltNg2ojLPiS0s/OylnpzZWbuNiyHDrnHYFMxZP7yyGmCYp5VeIF/K+SUzvVVhR6CtCix59Sz4uLXYgetj2Sco0PtWmXbTbGUkHb6iOkOnpSnZWCoPFh12Ajy7edsB2SYx9rL6/hiGvYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY6wyoAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CEAC4CEE3;
	Mon, 31 Mar 2025 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431657;
	bh=Sod3UEvmQzflWu9AcZV6qGlMGbbHJP/efdLxBV3kV2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cY6wyoAY/YuBNrCCZB5nd49C+wp4blJL4InIVCIERZ41E3OBMYfrCBd779xNj/9m+
	 nCsFrDmJLbWvdYYi+F8fES2CJCoXU7Ys0zwAhWYWVJ5rEUHJIGBvagICItcgGZ/AKw
	 Act/DKNaZU+lQDu2AteBCfT9NTFBYTlw/qCOcoyXk5O5jjPSgjkK+pkPLlit+NCKAh
	 Q6an+BXybMm+IyvgdjYymWE3A/3M6hiuuyWnj44rWzssZJBCFvLnEIDR65RfruXHf+
	 SMBjIaH7dBmBiko9mgXzOBq5AnkKraewiSAmjdZB9Mk1GovGLPiOdJHejhLwBwZf0s
	 MPW3hPBs58ZFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 03/18] irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
Date: Mon, 31 Mar 2025 10:33:53 -0400
Message-Id: <20250331143409.1682789-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

[ Upstream commit 2d81e1bb625238d40a686ed909ff3e1abab7556a ]

Rockchip RK3566/RK3568 GIC600 integration has DDR addressing
limited to the first 32bit of physical address space. Rockchip
assigned Erratum ID #3568002 for this issue. Add driver quirk for
this Rockchip GIC Erratum.

Note, that the 0x0201743b GIC600 ID is not Rockchip-specific and is
common for many ARM GICv3 implementations. Hence, there is an extra
of_machine_is_compatible() check.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250216221634.364158-2-dmitry.osipenko@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          |  9 ++++++++
 drivers/irqchip/irq-gic-v3-its.c            | 23 ++++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index f074f6219f5c3..f968c13b46a78 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -284,6 +284,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588001    |
 +----------------+-----------------+-----------------+-----------------------------+
+| Rockchip       | RK3568          | #3568002        | ROCKCHIP_ERRATUM_3568002    |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4c..3e7483ad5276c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1302,6 +1302,15 @@ config NVIDIA_CARMEL_CNP_ERRATUM
 
 	  If unsure, say Y.
 
+config ROCKCHIP_ERRATUM_3568002
+	bool "Rockchip 3568002: GIC600 can not access physical addresses higher than 4GB"
+	default y
+	help
+	  The Rockchip RK3566 and RK3568 GIC600 SoC integrations have AXI
+	  addressing limited to the first 32bit of physical address space.
+
+	  If unsure, say Y.
+
 config ROCKCHIP_ERRATUM_3588001
 	bool "Rockchip 3588001: GIC600 can not support shareability attributes"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8c3ec5734f1ef..f30ed281882ff 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -205,13 +205,15 @@ static DEFINE_IDA(its_vpeid_ida);
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
 
+static gfp_t gfp_flags_quirk;
+
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp, order);
+	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
 
 	if (!page)
 		return NULL;
@@ -4887,6 +4889,17 @@ static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_rk3568002(void *data)
+{
+	if (!of_machine_is_compatible("rockchip,rk3566") &&
+	    !of_machine_is_compatible("rockchip,rk3568"))
+		return false;
+
+	gfp_flags_quirk |= GFP_DMA32;
+
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4954,6 +4967,14 @@ static const struct gic_quirk its_quirks[] = {
 		.property = "dma-noncoherent",
 		.init   = its_set_non_coherent,
 	},
+#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002
+	{
+		.desc   = "ITS: Rockchip erratum RK3568002",
+		.iidr   = 0x0201743b,
+		.mask   = 0xffffffff,
+		.init   = its_enable_rk3568002,
+	},
+#endif
 	{
 	}
 };
-- 
2.39.5


