Return-Path: <stable+bounces-152448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB54EAD5D3C
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D51E7A6EFC
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C1221567;
	Wed, 11 Jun 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eL1Gr1eS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F522154F
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662942; cv=none; b=l1Xj0Sa/Y0zh1j5j6fXCO/E87BYazpcG85/v3TdI+3SdB8y1Pk+/Lwm0ubKTF1Esifi/7+szwEB+yM3kXErj6gvufulXl/ODwSMOZYU9psPqRlDTJgcOurm8aMqgPo14q2BnKHhCuFgmPidm6RRyyopmuJuy4UcXJHHVYZOBZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662942; c=relaxed/simple;
	bh=4aik/HjuwORwqm9maw8Ni19JnrvNyREbNYMPVz6sFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VK2oqTgOw+7LgaH76avXuxA6EkFNv4tEQLRhPNkDihZVa2IaQRSeWkh8bygLkwk+UCK7DDxNjc5eBEQqIP1RjwQyGOKTzzf8deZc5zMqHmEA0t/z7KmftT1veJIQsZeYWGaZHHUsXESSmG1rWRTlLLZp4dCO7SmH4u6eoUr08H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eL1Gr1eS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea35edc691so1252245fac.2
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749662939; x=1750267739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzQ1u3PFfk661ISVFP7ovkpOZlDsrxV5T4UKmsX9hyw=;
        b=eL1Gr1eSzIDGSl7oxvXIHWgN3RWh+qP7zmUcEnqf7vkQUdUWnxym6SkS/tuPyIes5U
         CAaQYoFbwh74crJ/RYpRxihMZlb0TPNy2h/mmlp7YRe8XsAxRxCiF1Ciw7T+ms1BSjWv
         0Ozbx2/1LPXFgPB/+lHafbxgAGCRtjVuVtKGHXXriMt6hv5jI8yL7yhaib1taWhO7pu0
         guoz7GU6MExqVFjWJFOBiW/vNizlLlGojAR6nSUJjEnjYp1ilLkYxV0R7zhw+P1nXice
         SBqqmqv84ehlxsg25fBMrB+PQ8okNtlio063eE+JJj1Q4ndZvZfQkbzZFInywACjBz5w
         tZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749662939; x=1750267739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzQ1u3PFfk661ISVFP7ovkpOZlDsrxV5T4UKmsX9hyw=;
        b=cY90ViWrgp6lfX+EtrFG2QaGQHrVSxhzCTX+0UpuXOhK7DmYs60JsMRy7vkwjjNWz2
         dIjGx7o+toS8MZbRhgRsbtz+U3ATfDiNjVsm+ljHetWVwOHopIRadLaT7YFSjHbS4+Gs
         4FHISNyhSi0sFYs4FeKPa6/8sfX0/+MvPut7mxyPDt3vmjzCphiXVjsIuEb/PgWwZSht
         4gLMZZNlhfAMdnfUeSq1T3Y/SfTPEDn+TGvOJX+sPjSV9C3A1u6r8sCYsoW2MG2enUoN
         7kF3Dxt44JxnIYPoNPXX+uPPT5RTXwrI7xeiaEydYmNFXKZTIsfGDHXmrcOGC0VI0YQ0
         7Wyg==
X-Gm-Message-State: AOJu0YykWSv5bnfVo0VQBHTkClDb8ykSKy4YtAoGL9CICXGNzkQ4DSrE
	/3KOYQiPwFeh87SbIQOnl32O+EizNsz023JratnHhfMMjhsazV7edBulu0MyKT+lpe/r/c11MvG
	p1pSR
X-Gm-Gg: ASbGncv9YI+HCMUuHUsbvhcabiuqVqAPTJW7YOqw4bSsGpOrYZ+HeebrXeb170GUeWb
	u6ls2dk1aR37D+DfR/YN3s4ImUcxMHANKwPC8c8vKcygtjzx5gs2e4+8cNi6LJLHRxxiUFpIIcH
	eL5K/U+PjsObNBuVPx1Fgrwy786vIrgZo6YAMcjsrSvww7OKj9fbNZITrQ9HjNEfaoNNAu0p1GU
	fRsfa6nsaUOoiWev9nMzA5ZrFpq5oFIovKQ1ezjj1dBuM5BuXQTfGXdRKFUtsJD+HedlyzbWhFN
	dzZgy9f4KO0bhIHJ4tZ4LBql2QR5lTKjVAggOEe8X9jBuF2lsdJLx19gJwpA3sqZPQ==
X-Google-Smtp-Source: AGHT+IGRDkcbWvHHBgNu1SnNLRmNfne+NUx+c47fY4iFz+0pJDeIwkpGH5M1Rz9vD/u81UPtqITs+A==
X-Received: by 2002:a05:6870:c6a4:b0:2e9:11da:f478 with SMTP id 586e51a60fabf-2eab43336f6mr176594fac.18.1749662938609;
        Wed, 11 Jun 2025 10:28:58 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea072e5f5bsm2929132fac.28.2025.06.11.10.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:28:57 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: stable@vger.kernel.org
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12.y] iio: dac: ad3552r: fix ad3541/2r ranges
Date: Wed, 11 Jun 2025 12:28:52 -0500
Message-ID: <20250611172852.821726-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025021010-antarctic-untried-a72b@gregkh>
References: <2025021010-antarctic-untried-a72b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
rev. C, table 38 (page 57).

The wrong ad354xr ranges was generating erroneous Vpp output.

In more details:
- fix wrong number of ranges, they are 5 ranges, not 6,
- remove non-existent 0-3V range,
- adjust order, since ad3552r_find_range() get a wrong index,
  producing a wrong Vpp as output.

Retested all the ranges on real hardware, EVALAD3542RFMCZ:

adi,output-range-microvolt (fdt):
<(000000) (2500000)>;   ok (Rfbx1, switch 10)
<(000000) (5000000)>;   ok (Rfbx1, switch 10)
<(000000) (10000000)>;  ok (Rfbx1, switch 10)
<(-5000000) (5000000)>; ok (Rfbx2, switch +/- 5)
<(-2500000) (7500000)>; ok (Rfbx2, switch -2.5/7.5)

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-1-2dac02f04638@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 1e758b613212b6964518a67939535910b5aee831)
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

I was going through some old emails and noticed that this had not been
addressed. The file had been split up in newer kernels so had to be
reworked to backport farther back.
---
 drivers/iio/dac/ad3552r.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 390d3fab2147..0b63ffc0b65f 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -170,25 +170,22 @@ static const s32 ad3552r_ch_ranges[][2] = {
 enum ad3542r_ch_output_range {
 	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
 	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__3V,
 	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__5V,
 	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
 	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
 };
 
 static const s32 ad3542r_ch_ranges[][2] = {
 	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
-	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= {0, 3000},
 	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
 	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000},
 	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= {-2500, 7500},
-	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000}
 };
 
 enum ad3552r_ch_gain_scaling {
-- 
2.43.0


