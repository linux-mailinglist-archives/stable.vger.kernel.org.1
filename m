Return-Path: <stable+bounces-146340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7523EAC3D3E
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBC77AA037
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056421F4722;
	Mon, 26 May 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsMSj1PU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF91F3FF4
	for <stable@vger.kernel.org>; Mon, 26 May 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252836; cv=none; b=sV9il/QoJM+s+qvSjEQ1QOvmpdEwDM5X9nW6kgBpunFMYbax72nUsqe7g0JrSwTOMhe0qYxdwlEFYhTzkGj4Kx445R1vrfw18757RvvZrv7eou9hi9oFmtGDQfQv3u4Cnqd2zkIjATM3XRfF+iXZCxPmmzlVaPwcsawaNWnGdkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252836; c=relaxed/simple;
	bh=mT/EMNtSwpdKAfwY6okQuII7UuVyMAXDJYDo9/I1RAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKIU9tw1tk5fLbNJ41dgFw5jcfbF9tBhJiN8qA/xBoZgEFj1rWJqHKFEYazQYbqOUhIUjDxpqjuFZzmWvzL/He68UvlwbURTu8WMpRfhUmbvznS/DRDFfcRDqdAifsJcYbb+aOmk2IOZnCErSCIiv7KFnKdtbbviiJ68MKaVmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WsMSj1PU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5faaa717cfbso303977a12.0
        for <stable@vger.kernel.org>; Mon, 26 May 2025 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748252833; x=1748857633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf98aVEPRnEWwXE+rikHvFZrdzzyYrcXz6WwCds+ve0=;
        b=WsMSj1PUuH74yBrzXjSFpGhwG2yF0SY8AJ126a7w1me0zeLOL5xaQDK2yUFOg30H5j
         mM17ryX/TlFiC7BiyKtMs7Xmt0XNGaysSN6ToXyi4p0s8XGwE1bNcpt+qxLqyhx9+zZE
         R3I1WUznQTE6mlkHShw0HkUjCiqj0KG5rkQkYZOmmvVOhd6A7bsYAKjQtmA1XfsqR1ek
         5ovKaj9U5nWV70EOr4+1Hb/2ajNNwcQ9S6GbbkaCqUtpRPxi8ku3kRNPbvn4H8Rxcog2
         OCpC/hJ8hOlaptz66nbwEPANwLYnab8Ribaj5BO7Qrln2LmagrfQkgSxV/O8B/g/30aF
         5lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252833; x=1748857633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf98aVEPRnEWwXE+rikHvFZrdzzyYrcXz6WwCds+ve0=;
        b=fELsRRJmlJi3PC6xlFb0vdUqkimVEJ0uDpabQ7oL5KtdDDCb0bJpXqXsQ9ZK/LvK16
         5JvPQ/9rfde4RT7z+Iy7KI2BNe54iNzYRPxiB2CiO5PjS3+cM/HFBN2mZbcpymBWsYI9
         6gxSgAECpaH7UyBVsaDmfnbTLC1TJzsmkuJThCBZgmgfSNQ+NsbxT3/NJQ/WcIOpLeAt
         aIg9gdcVt7NKUZS3GvL2ziW/K2gX5eEGHhzQjE9hgE2m1VcM1b/Zp2g0bq7MpjuYWH/B
         gv4Gt18LDf/F0crPt8cglrYpQH+yN/syu3OwYJVehB+iexCZwVAwfYMjOJ+MVk3ReWK5
         Gtpg==
X-Forwarded-Encrypted: i=1; AJvYcCV5kD0n8TusU6MT/Bohqd9XLBZyJvWROJsn26PZpt7bQqj4iXlfjWUFxJquxLPhbyoRipP9vKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6thDZdvF5grXMHiMFswdsm2YWf6SCXXmaSOHyIxyIEsUrbLZY
	Rf2b0UQJIjvPvvSyGc6o2J9WRk4LYbFxUa9xN4cYB8fuZPI+zi38mPFILRqmBwTPzi7QJJsYjDa
	z7os5
X-Gm-Gg: ASbGncvC0T/ffw/MA6kYUnueEYn/4jzsvfs7fJydlPcHlWhR18C3zzrTDffq+EBPpYr
	+8XQEc2nZUYEVSq8owasK1+MnsXIgEZESJzyaJJVfCIe2C8d7ekb78xGmNV4S3RMNNJFCdAWLdf
	WI0QPD5h3asfFkNH3sCXAuxIH8mJtNg4CND0+fLy8Aq+oxCl/bywMWqJD98jaswNxla5ZghE0jC
	X4No+wg6d29eBuO2Elce41vrqm4YQ3x24IDNJyWo739kQrVg9DoOm6x8g/X1ONv5WF25YOGQkHa
	C6CbRfY2iTg01Sbt++Oh0rvhEmCGMReJ/TRKYyk8ZYoij8BBPFVnFnQWXt+SAvMerQA1Zgw=
X-Google-Smtp-Source: AGHT+IFQ/yOEW6qFlSR6tl4VswK3VUmEUrQUe/Qse8CIDzE90hh/Y0WqsQgHDIHFf+lTQEEGJWMcWw==
X-Received: by 2002:a05:6402:26c3:b0:601:abc4:1b44 with SMTP id 4fb4d7f45d1cf-602d9df6cedmr2589786a12.4.1748252832752;
        Mon, 26 May 2025 02:47:12 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6049d482cc7sm1486427a12.19.2025.05.26.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:47:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 May 2025 11:47:02 +0200
Subject: [PATCH 2/3] ASoC: codecs: wcd937x: Drop unused buck_supply
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-2-0b8a2993b7d3@linaro.org>
References: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-0-0b8a2993b7d3@linaro.org>
In-Reply-To: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-0-0b8a2993b7d3@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vinod Koul <vkoul@kernel.org>, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=996;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mT/EMNtSwpdKAfwY6okQuII7UuVyMAXDJYDo9/I1RAw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNDiahh7YsUBAm8Iu89FMVlZwn3xet93APz5h0
 3uJi60zcxKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDQ4mgAKCRDBN2bmhouD
 1+fUD/981M4YfExEo4SwrDuA7PVrVCLEGQOILs/9VATrukI3ZP0GscQGTIPCQY9Zcx5WlwnfTDb
 tnejUOcxqApFXlwuzbuepvNtVlRyRqF6jvdO3D5DtAZHuW59VB4atNkVhLAPn9JLh+O9DTQJZpl
 BI6AnEYCTqwuQkVk+e6JqWC24GNeN9TSmSW4izZfzoQYU475omw9dQ5CuWU2BpMDsqAo7+73lc5
 2S759DiwR764pmXfakow15a6gLPjPtllS6DXQe17NKHD5NTuR//X0Xjj3JDBQM6/FKmr2fHFL26
 YXvWHOMcm+nCJZrjniXILk7Wp2zjFJ0RVufnPlKM0nlMg2w7R+mSX7eNyHMvjGp1F4XPVEjjFo0
 rGZFNef/g+6uUEcwgwPj6johBCnCLEf0DgcIEXmNMDSllQtr1KtWVhHX4TzgBZB/5qC1UnXcvv3
 XfO1iq2mA9Gd95SaL3edLoPl/sZyjgZFr0h9aMJIfB084y/8H9zZGnupVP0iWD21wrxmY1XJIvT
 lNinP/AEW/bwPtqAFuKc07u8lbqfpVkqseimONoPZBFpBHJXah5Z7C/DzjZzI2f39jD3I30/3WO
 62WMeue++WBVUvLJAwH8VUeVDJQmqtk+HMSiwECH6a56t0tVpNgzTZqe4/AL73BdzWyL5R0r//h
 TUjsAnDn0MQgA0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Last user of wcd937x_priv->buck_supply was removed in
commit 216d04139a6d ("ASoC: codecs: wcd937x: Remove separate handling
for vdd-buck supply").

Fixes: 216d04139a6d ("ASoC: codecs: wcd937x: Remove separate handling for vdd-buck supply")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 3b1a1518e7647366b4de0e90828b8d97b82c5bd5..a3a4b1f53e88e7ade13455387a65de736b1f0bec 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -91,7 +91,6 @@ struct wcd937x_priv {
 	struct regmap_irq_chip *wcd_regmap_irq_chip;
 	struct regmap_irq_chip_data *irq_chip;
 	struct regulator_bulk_data supplies[WCD937X_MAX_BULK_SUPPLY];
-	struct regulator *buck_supply;
 	struct snd_soc_jack *jack;
 	unsigned long status_mask;
 	s32 micb_ref[WCD937X_MAX_MICBIAS];

-- 
2.45.2


