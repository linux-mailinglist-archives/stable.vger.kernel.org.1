Return-Path: <stable+bounces-137348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50838AA12E2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1748177B6A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BF24E4BF;
	Tue, 29 Apr 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="swLGS846"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9F24DFF3;
	Tue, 29 Apr 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945799; cv=none; b=sj1qmkmN9HT0o6Wq7oMPpqJght0z0A3PlYdIz0Wmo5hRhOYAYHwVMWEe5LiIEwVkaz4VvRt2YFR7MOMgAggnDaCnYrp4a9eyLy7HkYsSFH2fpxUh5Ywo3vQMQy2nvuw/17AxPDPZMpk9Hyvb3Vc5lwGHESx7smU53HzVA5K53v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945799; c=relaxed/simple;
	bh=bbDIvewczexdM6hqaUxJSSRvreW66+maSpRECFMWniM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KywxcbMKXpkGB+l/fFX+fiRhhhTrchoAKS1Leefmn7M3UUmKB1Sahb9+zMGDVvX1k6cBQ6kG8hFsQXzPHHqaJClKbETwgug3QmNYTYGyAkeHmjOUN1rlUr5lza9teRvONE4Fm5DtdDS9mwsxHP7xH7bWxJQRKQVTSmSQ4PxjXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=swLGS846; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B08C4CEE9;
	Tue, 29 Apr 2025 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945799;
	bh=bbDIvewczexdM6hqaUxJSSRvreW66+maSpRECFMWniM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swLGS846nU8RS37Yi/9mcXX8tVJ4A1BlXIkdXp+0F2gjiX120+J4GPGV3OZEfm8AN
	 Vn5HgVexOeqht40JPOCXvvDhsLxEmH8tRvYVgWM9RGj/qhVQAmVyzlQlM8Xa3KfsdA
	 LuIDX2IugIp4HFOZa9kglUilo19ktBZw/nZw43WM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 024/311] irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
Date: Tue, 29 Apr 2025 18:37:41 +0200
Message-ID: <20250429161122.020047791@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0a9d6ef64e5e917f93db98935cd09bac38507ebf ]

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:

 - The TINT register base offset is 0x800 instead of zero.
 - The number of GPIO interrupts for TINT selection is 141 instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

Introduce struct rzv2h_hw_info to describe the SoC properties and refactor
the code by moving rzv2h_icu_init() into rzv2h_icu_init_common() and pass
the variable containing hw difference to support both these SoCs.

As a first step add t_offs to the new struct and replace the hardcoded
constants in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-8-biju.das.jz@bp.renesas.com
Stable-dep-of: 28e89cdac648 ("irqchip/renesas-rzv2h: Prevent TINT spurious interrupt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 46 +++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 6be38aa86f9b8..5fcc6ed4086cd 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -80,18 +80,28 @@
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 #define ICU_PB5_TINT				0x55
 
+/**
+ * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @t_offs:		TINT offset
+ */
+struct rzv2h_hw_info {
+	u16		t_offs;
+};
+
 /**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
  * @base:	Controller's base address
  * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @info:	Pointer to struct rzv2h_hw_info
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
 	const struct irq_chip		*irqchip;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
+	const struct rzv2h_hw_info	*info;
 };
 
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
@@ -111,7 +121,7 @@ static void rzv2h_icu_eoi(struct irq_data *d)
 			tintirq_nr = hw_irq - ICU_TINT_START;
 			bit = BIT(tintirq_nr);
 			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + ICU_TSCLR);
+				writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 		} else if (hw_irq >= ICU_IRQ_START) {
 			tintirq_nr = hw_irq - ICU_IRQ_START;
 			bit = BIT(tintirq_nr);
@@ -139,12 +149,12 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
 
 	guard(raw_spinlock)(&priv->lock);
-	tssr = readl_relaxed(priv->base + ICU_TSSR(k));
+	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
 		tssr |= ICU_TSSR_TIEN(tssel_n);
 	else
 		tssr &= ~ICU_TSSR_TIEN(tssel_n);
-	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
 
 static void rzv2h_icu_irq_disable(struct irq_data *d)
@@ -247,8 +257,8 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 	u32 bit = BIT(tint_nr);
 	int k = tint_nr / 16;
 
-	tsctr = readl_relaxed(priv->base + ICU_TSCTR);
-	titsr = readl_relaxed(priv->base + ICU_TITSR(k));
+	tsctr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSCTR);
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(k));
 	titsel = ICU_TITSR_TITSEL_GET(titsr, titsel_n);
 
 	/*
@@ -257,7 +267,7 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 	 */
 	if ((tsctr & bit) && ((titsel == ICU_TINT_EDGE_RISING) ||
 			      (titsel == ICU_TINT_EDGE_FALLING)))
-		writel_relaxed(bit, priv->base + ICU_TSCLR);
+		writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 }
 
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
@@ -308,21 +318,21 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 	guard(raw_spinlock)(&priv->lock);
 
-	tssr = readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
 	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n);
 
-	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
-	titsr = readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 	titsr &= ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |= ICU_TITSR_TITSEL_PREP(sense, titsel_n);
 
-	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+	writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 
 	rzv2h_clear_tint_int(priv, hwirq);
 
-	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
 	return 0;
 }
@@ -426,7 +436,8 @@ static void rzv2h_icu_put_device(void *data)
 	put_device(data);
 }
 
-static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
+static int rzv2h_icu_init_common(struct device_node *node, struct device_node *parent,
+				 const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
@@ -492,6 +503,8 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 		goto pm_put;
 	}
 
+	rzv2h_icu_data->info = hw_info;
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning, but it's a false
 	 * positive. We still need &pdev->dev after successfully returning from this function.
@@ -507,6 +520,15 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
+static const struct rzv2h_hw_info rzv2h_hw_params = {
+	.t_offs		= 0,
+};
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
-- 
2.39.5




