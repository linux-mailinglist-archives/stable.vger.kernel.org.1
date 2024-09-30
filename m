Return-Path: <stable+bounces-78239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D38989F24
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948ED283E3C
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635118A6CD;
	Mon, 30 Sep 2024 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzRVfWC2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D418858E;
	Mon, 30 Sep 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691153; cv=none; b=hZ0YQVbNDgjoPa5tz81/9Csp/B06TMBILNXpArFS9sHZMqcryRNfZi5hw7PtN5FjAqR+RfvPLFkOdrZCAF5XPZBORFRsLWSxf9YXQjPPKC0T7/3BBJFPWiBYF/0Wiz0lellCiuFzYFmPZp9nU9YOqExg5TurogInioLVDhI1s00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691153; c=relaxed/simple;
	bh=AWRGwNAR8HQF5vgW2X9+dExB7v1O+jkA3G5ve2Rc66k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lrsoplaW8Z1fJZDXZuWY3QFpY7Sp5XS1KR6KrCWnlDeAqDQ7mhLcRMSju4nj7+9/a/JPXP1uFi2rmDmsPan5/0NSlQOk9EdwAcQ0Wy825OIJ+s7MLkDys38o+8pCYnLHHLDEtf0djvXUvHJyrpAktn78KL2L0UGiUYKWHFFkMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzRVfWC2; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20b9b35c7c7so1809235ad.1;
        Mon, 30 Sep 2024 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691151; x=1728295951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUsTgMCDlYF8NCO+DUyGQXMRDmDOC3gw5dVi9Tj9wRw=;
        b=gzRVfWC2ePcjjx2zcuxNiAjrUAqqGUIeMvJUg3Pmv+O9eMX8ADlDnPTSaYn4mWrl82
         Sb5JZrOXUw7a2js8m3GD+oV26KiPT8f5RIhOZSujGhN7YZaHyFwsIS9YHVSHO1x6M2HW
         XDvkm1eqZNJ1WhJsQ7dIyVv5Bd8yrRjJzWRyXJZh8GYGFSJIM35C4MZGrYFYcmeMkor5
         MEdJ7yXjEUFjMU2Pnm79aRnuBmB12chLABUlucSgP4Ca9RKdpogUf9GWkTBKuAlRQ/6h
         +Varl3hFwsQwdsAr2reMD4rfAmNRDdcSt+vxAHp39OOiKTH5tqy+8FugfGSZsBuvuXHJ
         X57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691151; x=1728295951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUsTgMCDlYF8NCO+DUyGQXMRDmDOC3gw5dVi9Tj9wRw=;
        b=xSPOLrF9D1eXnDwsxsQSmaWcm+jLKzobr/D/sV79+ZOK1fOmEt1c65Dyzzehk0xhFN
         Kzwc967k3u+m2C/wtuPqrGwsjkeZ1Szb25DndH4yY/RelT64VUNjHlvaqQwg6ypS1NNo
         qdrG8SHX+tk+dFUZ2Z/vC8qRuCvIYmnfnddcyOjdb/6TZHj2tWmmm1o9HduYA95kTdck
         K0IzoQeNNVhaVjJl5Ocf4g+X+vi/pwoaPNGD6qMnqBIOszsut54PoOIW2PxQG4PSWV0/
         NgxD0BFkPKI/SaISLG0bQXeO9PdVromEQy9DeWC/rzwhBR2Izkdi12Jcu///Ppozaujc
         f8mA==
X-Forwarded-Encrypted: i=1; AJvYcCUoYGrA8Ff4ug/ooX+rHFhemPcl5/OzxKPclwa0/yKq/LHm97HEDcmSGxGIt09VtpjPh1Ap4KZG@vger.kernel.org, AJvYcCWo/7rIxJ974gSmap2nXPqgHEnybpCil0fMH5tuLr1EeYoNU3VqmTEeYm6H/lvBlrsC34XfF0dpcSSrmfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKUkj9HD84OIWcX10ElgPpWzRIlGysT/peGGbAhPt/nDCHwDr
	aZLZQtVZIPHVXhmDrwU6OUTOP4QNNvJqE19otJ1vNzVsOUU9CEz6
X-Google-Smtp-Source: AGHT+IE+XkNU1MrrwGIggtxA53BM40AFHc4Ez/pr2u8o6EBbjl9eIRtRRkKENw2ss5jQQykE7/l9Hg==
X-Received: by 2002:a17:902:c40f:b0:205:76f3:fc2c with SMTP id d9443c01a7336-20b367ddf1dmr156177005ad.16.1727691151036;
        Mon, 30 Sep 2024 03:12:31 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e61b00sm51584855ad.275.2024.09.30.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:12:30 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: support.opensource@diasemi.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: Fix atomicity violation in snd_soc_component_get_drvdata()
Date: Mon, 30 Sep 2024 18:12:16 +0800
Message-Id: <20240930101216.23723-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An atomicity violation occurs when the validity of the variables 
da7219->clk_src and da7219->mclk_rate is being assessed. Since the entire 
assessment is not protected by a lock, the da7219 variable might still be 
in flux during the assessment, rendering this check invalid.

To fix this issue, we recommend adding a lock before the block 
if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq)) so that 
the legitimacy check for da7219->clk_src and da7219->mclk_rate is 
protected by the lock, ensuring the validity of the check.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 6d817c0e9fd7 ("ASoC: codecs: Add da7219 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 sound/soc/codecs/da7219.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 311ea7918b31..e2da3e317b5a 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1167,17 +1167,20 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
-	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq))
+	mutex_lock(&da7219->pll_lock);
+
+	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq)) {
+		mutex_unlock(&da7219->pll_lock);
 		return 0;
+	}
 
 	if ((freq < 2000000) || (freq > 54000000)) {
+		mutex_unlock(&da7219->pll_lock);
 		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
 	}
 
-	mutex_lock(&da7219->pll_lock);
-
 	switch (clk_id) {
 	case DA7219_CLKSRC_MCLK_SQR:
 		snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
-- 
2.34.1


