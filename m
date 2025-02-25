Return-Path: <stable+bounces-119474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4FA43C84
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9601705E5
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0E26770C;
	Tue, 25 Feb 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SQFfGtrq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ADD267B76
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481165; cv=none; b=IiiRxdULt3HeHLAZC6hZiQK1dI59UiJ0YeiBhSuzYDZuZ6REZgYaXpMFxwiolaVsCSCErFlRmXpgyqMY9lRelUKkng/gn4R/fBPYUcZ4mOLNet7eNaS4C2+gTHjI2tQItRCIffV/aU8s+E7yHGzhA5zCbvZrroIyxvGt7hQ3QFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481165; c=relaxed/simple;
	bh=LfDfyXvE/k/3wAGzTHexcKD+CL/7mAcO9M0iYyr9AMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdC+mBKPEB6E7vqEzoU+sijqryx+Ibvuq1wLCDahfw0p400Ole5Dd5Pcgc75PvDJKO978dlDKe2cBlc7jERvokD1Qe4qmiQzcTR4YomOyCkJ6drQ+Oiryb+S09ELnC3lam6ZjaZ3d0yTvGXFJNRTsZAxW5DFlnFbovXZFR04ODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SQFfGtrq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so51597635e9.1
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481162; x=1741085962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvjAeJYy02UXwEIBH2Mapc2zFP4oPiRLlb+kj3I0bAc=;
        b=SQFfGtrqStETV0emOtuM5j6SAPam0pIRGci1TVIYL/ZilkOaLL/AvIJUjp3j9/h6St
         BUVRTOoXi8K+sfWfAqzjZ4OSrti9af3657dYNjbAVMeaBIon5lIQJUDsMffMTDdw3yWw
         SLN+EKHmWuXtIxZ1QMsHgeqMQYWeIMB9LWNk6AShlFfDzQE19FS9/MpX3m+MSNTvibrE
         AgK6uirXm20xX12yPsaLMJlMFFkh5yU3l4H7hclPUa7zwQaxJ1TNBJoxH9/xg890mrT+
         rDsUbtIz+q66ljha1zLXONPjJa6qx4A7Chinr2cZJ2MPa98oJoKuqixIk3kPbmX7kbpU
         ny3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481162; x=1741085962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvjAeJYy02UXwEIBH2Mapc2zFP4oPiRLlb+kj3I0bAc=;
        b=hB4VwCTZ0EdjLdHQF0QeLCL6lFvUIdsgnk+gJZlZCGNuSWwjEUXROkgFJYRIEEB4qz
         iAAKVZ7OVYGGigKCQGIoMlYfBM7bWuVcLBxXmHVt8pt/XUjsNjH4BcXwL5bEKZ+5D/rs
         iXWNc2VNm8VVEmrytqOE2eGW9mPpuH6U1eaY+qVsBV1NBiU3geHZTB5GUx/z6fao0gSN
         F9k/0xITe0gxmSg5NjDaLWTZYE4d9rSKAOhy21DkSrlW1dUmHWkhkVJUtt/WcJld3GH2
         M2X3K+bl8xm/js8oE86PAkiJH9AeAbwc/RFYlvNZy2kcJlCU0iQ446LBa/rxFswObngz
         MxVw==
X-Forwarded-Encrypted: i=1; AJvYcCWgRVgbSL5a5AQnBDKWMkz4OX4pTkWCogfKbmHb+fiHWCwnGGZWdufyINLR7MXSU0T6cSLTwXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwT91e/KagkbXk2KzMC4QfRMEUI42rDAkfNwqP16ILMOJ8gxb
	Vn4BhDQiOha4z0GBA2vzNk0l9fcRKfi760ogHxiJKaxjsc8LzhKR/n9jUMQt7CM=
X-Gm-Gg: ASbGncscnMGCLOzsdgc2Xe29++2v2NguWj/JqG6GTxhJr3+lbI/HQwCuviN7NxKeczn
	hmLycyd7NybO2ob3gdcEWrqcydhWNx1NbN43anVLwXnEeEmt4jO/5MA35lOT6txfrW5+zJ6btB2
	7aeQXPZY8uMHq2EPCbfQioVqSQWxD7Hq4jM7/Iggo+8Wm/r2uxgWnV8s/cx9p9rKjqUpNuNuHkC
	xkMg+ltGahdBlfIdQge2TMpFrs4j8bIVOkbM7yiG6dRT+Y9SasWY6tVfbEfhwrWyNe1eWd2PGi1
	8tHDyHUVU1csms569213SuNF/sP2yx9IbN9vc0IHVSWFNFhnXEMf0QI=
X-Google-Smtp-Source: AGHT+IHJusFfOvPLQ/wSNXmqs3trKdVlwIwzvO0DcaifSitYECfthSTp3FPUoDPwRVwIMqUgzX4gfA==
X-Received: by 2002:a05:600c:4592:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-439aebe4a26mr165557195e9.30.1740481161783;
        Tue, 25 Feb 2025 02:59:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm12588815e9.0.2025.02.25.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:59:21 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH v2 5/5] phy: renesas: rcar-gen3-usb2: Set timing registers only once
Date: Tue, 25 Feb 2025 12:59:07 +0200
Message-ID: <20250225105907.845347-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 21cf14ea3437..a89621d3f94b 100644
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


