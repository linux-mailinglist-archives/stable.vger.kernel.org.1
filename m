Return-Path: <stable+bounces-191572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CBFC18A99
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37AA44ED12D
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F030F950;
	Wed, 29 Oct 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDQCTVCm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B630E0FB
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722303; cv=none; b=qm+103w/hh49LqdWqTlz5KpILWy4GwJJpm/7KY04SfStOAaZwrksQ9JMAstdSR8rX/RNZHbG8cLqr5P4UHuCZs3kBMIsfx+ICvvpnGGFxfDdIawcNpjBj1M3/1Uvgmtxq4/k6o1RmQNTzZAew2b8MA+I/1c/PqqiP8pzBkczb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722303; c=relaxed/simple;
	bh=ecmgWyt/r3NhyI7KAZNK27WV0ALYJNBfyBVF8Ko8M+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9+Uqgc8REsDpAuzFqhRrdvDcwWSi7O80XFlpqJbuftUKO9Od+Gfl5h7LUuve/z+pOLoz1lDFGHTRwHLE5KExuD4vSAXQXgpCeVqC1ha3vic7etcoT2H5jd2nQRX2eR+v5yuugA4UmbHPVVqyQnDGE0upUhmSR+e3E+NyPLjgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDQCTVCm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a2852819a8so4890649b3a.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761722301; x=1762327101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKR2JIltJZH3d6vVv5ttIX5RgDXhzdjyF6WPgCyyT+Q=;
        b=MDQCTVCmZeJ+qqaZ3RDqhw0rJGyAPPzPOsQXY+GTWdKptbSIQnSNaAcqvagcs91cA5
         S3kqfgIyz9hgulz0BoDJ2R6wYWkaXzQNam7P2v4EPqxmeNs0C/NDMP419yrNM3uiX3Oj
         v2A9KC+iPw7lbUwh9ZP40im5OTS9/GLjSz6WDsVJOSSIVFuvD2e4u6bR5Ukf0MeAuhgF
         n7Ta0Hoj4SVLN9KPPUKPb9asuHUmdfosWCzpQ1p0CmHaaGgPLQA3LNHUyiiNe/9o1KJH
         qdtodEORxdJGsge8V0zEdf2ug+1D+OjI6z1IPCu7m8WeJ8XquQ67a0AvP9VZHYJh3Bcz
         kLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761722301; x=1762327101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKR2JIltJZH3d6vVv5ttIX5RgDXhzdjyF6WPgCyyT+Q=;
        b=rfl+QgF9PU4ANKfmfNL68LRICtrHN6dYWTZ0N9CShRxTYFL8ROl9euDTQ6h9IHsFEo
         gh4VpGEUpqDx5/63xNDHkkhB/kKl4UMGeVWnvEB/QXV0hwoxZbPFuhgzu0xWE3evkfRx
         OH2HrE6YVOXg2UXzjGM9+EPABysiTAI3yiW4jBaQMwfS8HJF0HhkoZM27joKtPQFVTNi
         r6Ico8fmY0/RlhPBRaBbGlxC4gLvUM6NvsDWg0y8csPCrG254X/o1gPlAEl79nt2HVt5
         hj4Yyx5uLH0mf0EV16ugxjcVHajxxGQC8daJdjxSw5sjAao0ioA0kWBv4YwPiilFfoHS
         EhjA==
X-Forwarded-Encrypted: i=1; AJvYcCU2nALjyAxdr+GBiS+hPMoW4meYX9nQezhz0j8PJG04LA10TAqhQOSCwXjpMYZAGKS378zVYZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtCOPiOFPJi+K952ZSMBEJ3HwMvYdVj4GB1agVpZWPZdneh/6
	Y53M6T/gX/QkXB7eRsSwnqPFo6cX9/f8f3H9k4e1+1Ln/niLiEf75j5r
X-Gm-Gg: ASbGncsQxfvDP7Pqbi5f93T8MKTPbZQUbfjMPV9uJq39X+4lTv5Q6P6D9yRGfl1fKxK
	9AimpoiM+ad+G/zDwgXQGNHGz4NDEvd9F+94iydX1HpnhWzx5KyHyzyGhJ7gra25z8LjvqsnmmH
	OUnm8t05ORR5pzRfYwBDUEqV0ut0nlkrg+kbUqhD8bjuGOuKygYgvyYhm2XcwKA9yGraq66XfNM
	Q20WxQT/qAisYs5/xdRy8eoT5VvuJZcy6UNwjoegiFkvZGUIOv93ZoISAVJ1dJqJLhN1ERaLEyr
	hy0WvQ12NN7FdOeN5zUr/is+dkJTIz3HCSmtwwBPHHI96gG1ac3sbTiMwEsQb2/O5u+f1ws5Ekx
	7MhHw9V0nUVlUs7VUSLTETktJxcEfc+an0g2Qbn18dXboJr5EVdCawsKmILuEXE0lCAQUuwshRy
	V6dCMncYcARxfCgqmooF5o6g==
X-Google-Smtp-Source: AGHT+IGsSohj8ZyfRUklbkOshcfGyTov32rF3rhJPbt86LKk5fmrvTuOuT8071qzdtGvIsEZK/0xXw==
X-Received: by 2002:a05:6a20:3ca6:b0:342:44f3:d1bc with SMTP id adf61e73a8af0-34653146b2amr2346432637.35.1761722301330;
        Wed, 29 Oct 2025 00:18:21 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41407a0fasm13910908b3a.54.2025.10.29.00.18.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Oct 2025 00:18:20 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Niranjan H Y <niranjan.hy@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shuming Fan <shumingf@realtek.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: sdw_utils: fix device reference leak in is_sdca_endpoint_present()
Date: Wed, 29 Oct 2025 15:17:58 +0800
Message-Id: <20251029071804.8425-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus_find_device_by_name() function returns a device pointer with an
incremented reference count, but the original code was missing put_device()
calls in some return paths, leading to reference count leaks.

Fix this by ensuring put_device() is called before function exit after
  bus_find_device_by_name() succeeds

This follows the same pattern used elsewhere in the kernel where
bus_find_device_by_name() is properly paired with put_device().

Found via static analysis and code review.

Fixes: 4f8ef33dd44a ("ASoC: soc_sdw_utils: skip the endpoint that doesn't present")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 270c66b90228..ea594f84f11a 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -1278,7 +1278,7 @@ static int is_sdca_endpoint_present(struct device *dev,
 	struct sdw_slave *slave;
 	struct device *sdw_dev;
 	const char *sdw_codec_name;
-	int i;
+	int ret, i;
 
 	dlc = kzalloc(sizeof(*dlc), GFP_KERNEL);
 	if (!dlc)
@@ -1308,13 +1308,16 @@ static int is_sdca_endpoint_present(struct device *dev,
 	}
 
 	slave = dev_to_sdw_dev(sdw_dev);
-	if (!slave)
-		return -EINVAL;
+	if (!slave) {
+		ret = -EINVAL;
+		goto put_device;
+	}
 
 	/* Make sure BIOS provides SDCA properties */
 	if (!slave->sdca_data.interface_revision) {
 		dev_warn(&slave->dev, "SDCA properties not found in the BIOS\n");
-		return 1;
+		ret = 1;
+		goto put_device;
 	}
 
 	for (i = 0; i < slave->sdca_data.num_functions; i++) {
@@ -1323,7 +1326,8 @@ static int is_sdca_endpoint_present(struct device *dev,
 		if (dai_type == dai_info->dai_type) {
 			dev_dbg(&slave->dev, "DAI type %d sdca function %s found\n",
 				dai_type, slave->sdca_data.function[i].name);
-			return 1;
+			ret = 1;
+			goto put_device;
 		}
 	}
 
@@ -1331,7 +1335,11 @@ static int is_sdca_endpoint_present(struct device *dev,
 		"SDCA device function for DAI type %d not supported, skip endpoint\n",
 		dai_info->dai_type);
 
-	return 0;
+	ret = 0;
+
+put_device:
+	put_device(sdw_dev);
+	return ret;
 }
 
 int asoc_sdw_parse_sdw_endpoints(struct snd_soc_card *card,
-- 
2.39.5 (Apple Git-154)


