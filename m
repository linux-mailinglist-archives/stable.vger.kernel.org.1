Return-Path: <stable+bounces-120228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF49A4DB54
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DBD1885D94
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91161FFC69;
	Tue,  4 Mar 2025 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ln4U+5r1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46891FF614
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085321; cv=none; b=X4VBuNwd0TuNvwgP0RAEiyqiN5oznmyCP2gyLuFfH/+tWCPIgbQlUT4gNf9CYmITNv8V2VhYamUKLBmdt8CBbDdDWXr6PdoanbP9sTlwT+Cjse2RPfEA8zFQj99XFYtHvTgKgYtuVTcFXEnI22jPOG8HJOHcxTL1v6TiVvq4QH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085321; c=relaxed/simple;
	bh=I6PmJhaf+aDIQD4WTRn8AyrjnmESJma46JRl4n8p0BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhTsS/H1dwMLUPCZTmR89iz0zjXbRwUaXA4mjl/VxEJcubxy2A9qQuIe9QpQXEAKp/7hjt3GTDNKMDas00Va5LEJiUmsW57lSJB687wlCJ6y6uGO4nlWYmAjA4ofG4cw3i89sF4FhSUvDHpd+Amjeny0bwE+mBP6Ay9tT/vjSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ln4U+5r1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390dd3403fdso4672488f8f.0
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 02:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741085318; x=1741690118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRJcEJEBuJZ+hz1ZoBW1GVvB+QH/3DoA+Rqlp4VSk8w=;
        b=ln4U+5r1D3226VagtWkAcV3mGJR+j4qgIL1B0dkhPxTeW77W9PYCxvhyEKnRdpeB9O
         fNsojDTyhvOTyt08zjPaUC/+oLV2Pin6sh5hd6kmVfCFDPjRXHgxUb6/+Vyq66mxACcD
         LiGv75szu/T2HuRfNIFKSpJaAIhNapwn3W5UwDTI0BdCrKUMOucKCiLqPe6rFDxvlxr+
         OeASgB6U/gcCGt50SLlyrr8K5iIVdN1rRK55moFtqYLX8v0A8X/jGHFaQiFdo8FcUNS/
         wBfP2k3HEyf8zyDp0LX4eQ1bmG69xQaQkPc743SLEYIFA40N+sG80Z/FHPDM392Fi6nF
         sxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085318; x=1741690118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRJcEJEBuJZ+hz1ZoBW1GVvB+QH/3DoA+Rqlp4VSk8w=;
        b=P9huIarbXBXpD2Hskxvfi1KGLDl0LN6n0BsTy/j7VpRUV3CWcKlrfBJvcsNeyOqlJG
         NS2eHYYD2cBSQXFJDG423IccUBJrACs7PGnkKOVpSE0B8IozuPuyzPbCu7ViMB8jfR7B
         zzZwLhYCcVU8H4G1nY0fC4ydwy7VunOglbFZxYGx/XwoiOBxJvs++jt7h0COBWgYsdDC
         /tJhoQAeeqcYg6XsnP3a/O7Ax0z4yFBAXm3TCr++bF3qH6yF6FPoOGUUtwQuaIXE2vzl
         2N5m9QN0jwWvx+6U5Xxy9HH4dH0asK9AzEaA02tQ7IbDeyK7VXhljfzOwsThghUe1hcg
         ka8A==
X-Forwarded-Encrypted: i=1; AJvYcCXH4lUg/DlZq+Th9vdlmpccKbq9qtOvBcdzRBLtRuSmfDKYhS7MjLtn2ZpXcryrICB1wvkq7JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNdPKzMNzSvx0Z7+jxkkncum5SIxW+o11zM28Z/6DDRW5dl5c
	E5jSDtG0BQsPyi64+DFawVlRvuB97eGTpYmSOy6eGO5/K86BZ4JmAQZv3M6BO2M=
X-Gm-Gg: ASbGncsSdFPPUlJILAGL6OLTTMgE4zXCzJLKbiRRiCeSP7ZDeX+rvodBIMf9GoxR1tf
	Q7c7vMh82NtMNZh2WCJGHCvHhd0kg2KqLZY11rFMdwVxplRFvSKs96eRtP+pwVvc5h24+ffxrzj
	kNtGcBCwSUpduc6dXgxrapp4Y528FjSBNjIpJ6mU8scSQVz/rZyzP4ZlmA2jYdDpHWb58HXtJcx
	NHWmhVQP9MspaIUlACF//U4LqL21NP2X7oEe9mrxLfpYh5EoPA9t1fxLdmDJeZ9ju9ASZS8g3BQ
	KdSr0Hm1OxUsxijnQ9cYTZJfzfKRRsHnwCBuNJaXIU9MWt+AyxyZ1l9G/mhnCXqtmaU31PbedX0
	=
X-Google-Smtp-Source: AGHT+IEzaPdRtNq5d8BIcB9aEy7PlrR49uga/gnA14JhmXxnbu44C93t/ZWbPsbG+sIUeIrfE2/bgQ==
X-Received: by 2002:a05:6000:4404:b0:390:eb46:1894 with SMTP id ffacd0b85a97d-390ec9bb93emr10799958f8f.21.1741085317876;
        Tue, 04 Mar 2025 02:48:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a38sm17445161f8f.75.2025.03.04.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:48:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 5/5] phy: renesas: rcar-gen3-usb2: Set timing registers only once
Date: Tue,  4 Mar 2025 12:48:26 +0200
Message-ID: <20250304104826.4173394-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

phy-rcar-gen3-usb2 driver exports 4 PHYs. The timing registers are common
to all PHYs. There is no need to set them every time a PHY is initialized.
Set timing register only when the 1st PHY is initialized.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- collected tags

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index c663910d6163..617962a51e81 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -467,8 +467,11 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
 	writel(val, usb2_base + USB2_INT_ENABLE);
-	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
-	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+
+	if (!rcar_gen3_is_any_rphy_initialized(channel)) {
+		writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
+		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+	}
 
 	/* Initialize otg part (only if we initialize a PHY with IRQs). */
 	if (rphy->int_enable_bits)
-- 
2.43.0


