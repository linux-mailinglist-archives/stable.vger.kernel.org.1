Return-Path: <stable+bounces-125573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D0A693C3
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3191B65ED5
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997BD1DC9B4;
	Wed, 19 Mar 2025 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGrx0gRJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618921D61B9
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398235; cv=none; b=r+OSUlGNG2FwwHm2oFZONYGOqq+mgsAHpjt14px85ztPfqpkqnS5Njy5E/zIoIFRBq6wRfzQIUDsQMpYifp7MSY9dihHuCf7YCZ1v7ZBHlQ07v8Mhr7XWVF4Q45XK/+6/Bs4Otmg0hSDmlX42aKHNzYhhUeGKDgDVaIdbZ7z7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398235; c=relaxed/simple;
	bh=kk2fMHoWjrLcXHxUi5sF6uFu10/CFkKdnFWw4ZC84VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRqYFbcDm46rAJ8q0fM7IgYNL/SV1P6PtKf3caMQZ1urfK0h6Sk1AqRWwfel9X+/hCMNd26mypX5Xlz6Ov63WIcXyeBw0wT7PvbQqfjQzMMtBsC9wLNymsTSr8XKLu5bu5i2qjeEgNJNf2rlNl6eLGHf4ZLMYBP3/NijnZQcwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGrx0gRJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso46485345e9.2
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742398231; x=1743003031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbRxaKlUuHAcCVOLOqHWcjXZo8Uzm/9NfQH6A8RUPPo=;
        b=xGrx0gRJusIhma5VwQDItBNyzSTMtmptBA8xPYrb28W7TR2ZYo0mbPYs12AepDsAhp
         ISLezKhUmrO5uGm83hdb0B0s8j2Gl+xj39kEz2dtdvxw3hNk57NEX6odtEZOFB8nWCWz
         PQgOQGetJYjMe1wD1uHbTCVe766Mo9KHxYDxLBw0rKAFMhJhX8ALPTtGBVzMQ2d9lnEU
         RB9lktxZiCnwWAdmBUkpB23mU0TY7s+Lof3onNcqD62XaEEd39biXjgQ1JcuVVw3VU08
         B1GLvhNKmaf8BUJ9OmH1ArxAe42Y3FbrbPWIdFwTEI/RFhbaExt9qioGNY/R/d4zQ2Py
         ppDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398231; x=1743003031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbRxaKlUuHAcCVOLOqHWcjXZo8Uzm/9NfQH6A8RUPPo=;
        b=jbB/52/7Dlssnju2RWsI5MyP2ISRj1US7YtioiHEdv0TlYwTqUJta2WedhlbIYAzXd
         sM/DIDesO5RefLDqVzZFRPt8QnkCswSTGudGzRlm/zBUOuJRaZ3OgOYsCc45KaRzdT5E
         /wlzEOsV9ws/2zqqzDg3khWlgyPT14O2mklfywxvKs94DYKCLQFPu9NIerRAMGrdj8xa
         UoBKVxr+77zqn+/kOe1DPIcjN6xswd+Av60EFeh3jVOsP9B4mwVbPedkVq1iRiPm4vl3
         CGZAFA4uRl36L4VeyGMJ2zq56h5BUtCH/fzurJFKEYt2M2CbEQ7kcWzeV12rAftAlVBX
         X6kA==
X-Forwarded-Encrypted: i=1; AJvYcCUxeDy9W1vOl5qadE+xPnhVpIWqjz0la3qRcEBzI+tiDID6D3O8/lt59JY+okjBWUG0+5NE0ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZzEaOWD05fAHCmnoKjxAhPPM84M43bvQJKtaB0GcI3rCPKrv
	bOJnq6AaXPv7kf3zFiBhFeTY0ffxtyolI4NzM0ro6zW7J0TY5sZ3wk36Zotk48w=
X-Gm-Gg: ASbGncsFOaQ8egbCntGZ1j9iUTw/8Ke3VwTRRFPh7h608wO2e3IhaRj+s3lXdkUN5s3
	WQIMfcshW//0dfeGO96uleWtSYl4phNNyEAEQaYCBfP5GpIJ1tGQhBCoEzGahYT8EVKRRuHLav+
	sWSMs19x1a6isbTbOXnGwyRHQZwNFue8bnfR+C9BaQx3ifKlZ2vFEU2iesL3ZWnbyKV6TxORCVT
	rS/k3qZvhMC7DSRfaEh/oIBmcs/88BoGDb54XHyrNxLYgtXOVWOgemn5O84ZPimOp9qo5e9pSCm
	b5PR97MlQ78qzhQITg73qquTczxJpwon2grDLgPpU77vJCAzBFnRJoDHuCnK3uzcCymB0AgXNt1
	C
X-Google-Smtp-Source: AGHT+IELKtB9DSmyHJ5USLUFwjbcpHPlTWl70nzCTJQEQMbPy4AR/0qWpG/lQtpCuf9vNJ/yfeJDGw==
X-Received: by 2002:a05:600c:1d18:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43d4875087cmr10638485e9.10.1742398231440;
        Wed, 19 Mar 2025 08:30:31 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([212.105.145.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdaca8sm22590635e9.28.2025.03.19.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:30:30 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 19 Mar 2025 15:30:19 +0000
Subject: [PATCH v2 2/7] scsi: ufs: exynos: move ufs shareability value to
 drvdata
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-exynos-ufs-stability-fixes-v2-2-96722cc2ba1b@linaro.org>
References: <20250319-exynos-ufs-stability-fixes-v2-0-96722cc2ba1b@linaro.org>
In-Reply-To: <20250319-exynos-ufs-stability-fixes-v2-0-96722cc2ba1b@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanho Park <chanho61.park@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Eric Biggers <ebiggers@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
 willmcvicker@google.com, kernel-team@android.com, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3658;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=kk2fMHoWjrLcXHxUi5sF6uFu10/CFkKdnFWw4ZC84VE=;
 b=kA0DAAoBzui41gI0croByyZiAGfa4xDIJTsN0uisLZOrLYYCRsUsZ9bj4xzs6meMp1naqn+9m
 IkCMwQAAQoAHRYhBA78jm9VeHUNVrVJ/M7ouNYCNHK6BQJn2uMQAAoJEM7ouNYCNHK626MP/RX1
 hguCvwUaqq1KsdNef95QH4hzFhmOnCDMHgq6vkV/3KzUCesSc5/uIcRUjzonwsuY/X8Z6SuoDWl
 fRguDV0JgQjP9AQWyoPuorF6XLuZBGlFe1uoueH8WgK8A4nE445OeRNb9g5Qxs6vChRvbPZryVD
 x7Z3L5Kgdv+25WRmpp2NxMcUl26IywhKBGw0a69w43ERY315QLo539L0eUhdO2LrJl7Y52DShDl
 O/CgBENeYlvos96Z5QM6pqVw5h4aM2FQAHnK1B3ItnXZQNxP93ACgYNJX6Uub5Dm1ECCZuRyDig
 idFAShyOwK/LsU70tQQR97PRYlkGIqEMQiM0BGS/TtJ0+FZbKcEAuMdo9QRwVQEKizkIKQu1PSH
 hugssFgNx5yQDMOK2bj1JVCvYe/FuIAW3RdthgoO+15dBxjY9SXt9Dy+uT1opsf6E6l+SG1Qys+
 k/JeytF/wU98FfsW3cqStRGEyShGp82LwY+4yPog6OVxfU+0T0E85e59Jqpo1n/sytK6XVbWE8t
 2akSDrZTd7mNmrAgwjOQ1pDs3UVOSHayKeMYSYzNjdJCv64uWdalQfozeCwIHKAnepCiHK21+4i
 XbNhRMDt6YcpeoSfc/RYNE7XcRSqpA1rD+ib8NY8qYObuzk4sGVH1+K8HdvxDsADpHyGiJsJZ5/
 KC1Ax
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

gs101 IO coherency shareability bits differ from exynosauto SoC. To
support both SoCs move this info the SoC drvdata.

Currently both the value and mask are the same for both gs101 and
exynosauto, thus we use the same value.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Fixes: d11e0a318df8 ("scsi: ufs: exynos: Add support for Tensor gs101 SoC")
Cc: stable@vger.kernel.org
---
 drivers/ufs/host/ufs-exynos.c | 20 ++++++++++++++------
 drivers/ufs/host/ufs-exynos.h |  2 ++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 0c8c2e41e851cdbefc80a66d87273b7e8fcf9d4d..f393d42a659f821225e67e3e5d323478456ca3af 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -92,11 +92,16 @@
 				 UIC_TRANSPORT_NO_CONNECTION_RX |\
 				 UIC_TRANSPORT_BAD_TC)
 
-/* FSYS UFS Shareability */
-#define UFS_WR_SHARABLE		BIT(2)
-#define UFS_RD_SHARABLE		BIT(1)
-#define UFS_SHARABLE		(UFS_WR_SHARABLE | UFS_RD_SHARABLE)
-#define UFS_SHAREABILITY_OFFSET	0x710
+/* UFS Shareability */
+#define UFS_EXYNOSAUTO_WR_SHARABLE	BIT(2)
+#define UFS_EXYNOSAUTO_RD_SHARABLE	BIT(1)
+#define UFS_EXYNOSAUTO_SHARABLE		(UFS_EXYNOSAUTO_WR_SHARABLE | \
+					 UFS_EXYNOSAUTO_RD_SHARABLE)
+#define UFS_GS101_WR_SHARABLE		BIT(1)
+#define UFS_GS101_RD_SHARABLE		BIT(0)
+#define UFS_GS101_SHARABLE		(UFS_GS101_WR_SHARABLE | \
+					 UFS_GS101_RD_SHARABLE)
+#define UFS_SHAREABILITY_OFFSET		0x710
 
 /* Multi-host registers */
 #define MHCTRL			0xC4
@@ -210,7 +215,7 @@ static int exynos_ufs_shareability(struct exynos_ufs *ufs)
 	if (ufs->sysreg) {
 		return regmap_update_bits(ufs->sysreg,
 					  ufs->shareability_reg_offset,
-					  UFS_SHARABLE, UFS_SHARABLE);
+					  ufs->iocc_mask, ufs->iocc_mask);
 	}
 
 	return 0;
@@ -1174,6 +1179,7 @@ static int exynos_ufs_parse_dt(struct device *dev, struct exynos_ufs *ufs)
 		}
 	}
 
+	ufs->iocc_mask = ufs->drv_data->iocc_mask;
 	ufs->pclk_avail_min = PCLK_AVAIL_MIN;
 	ufs->pclk_avail_max = PCLK_AVAIL_MAX;
 
@@ -2035,6 +2041,7 @@ static const struct exynos_ufs_drv_data exynosauto_ufs_drvs = {
 	.opts			= EXYNOS_UFS_OPT_BROKEN_AUTO_CLK_CTRL |
 				  EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_BROKEN_RX_SEL_IDX,
+	.iocc_mask		= UFS_EXYNOSAUTO_SHARABLE,
 	.drv_init		= exynosauto_ufs_drv_init,
 	.post_hce_enable	= exynosauto_ufs_post_hce_enable,
 	.pre_link		= exynosauto_ufs_pre_link,
@@ -2136,6 +2143,7 @@ static const struct exynos_ufs_drv_data gs101_ufs_drvs = {
 	.opts			= EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR |
 				  EXYNOS_UFS_OPT_UFSPR_SECURE |
 				  EXYNOS_UFS_OPT_TIMER_TICK_SELECT,
+	.iocc_mask		= UFS_GS101_SHARABLE,
 	.drv_init		= gs101_ufs_drv_init,
 	.pre_link		= gs101_ufs_pre_link,
 	.post_link		= gs101_ufs_post_link,
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index aac5172761899a5dd8ad98f9ee34b1671dd27880..17696b3768debd641188b5089585b6d303de7451 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -181,6 +181,7 @@ struct exynos_ufs_drv_data {
 	struct exynos_ufs_uic_attr *uic_attr;
 	unsigned int quirks;
 	unsigned int opts;
+	u32 iocc_mask;
 	/* SoC's specific operations */
 	int (*drv_init)(struct exynos_ufs *ufs);
 	int (*pre_link)(struct exynos_ufs *ufs);
@@ -231,6 +232,7 @@ struct exynos_ufs {
 	const struct exynos_ufs_drv_data *drv_data;
 	struct regmap *sysreg;
 	u32 shareability_reg_offset;
+	u32 iocc_mask;
 
 	u32 opts;
 #define EXYNOS_UFS_OPT_HAS_APB_CLK_CTRL		BIT(0)

-- 
2.49.0.rc1.451.g8f38331e32-goog


