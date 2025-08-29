Return-Path: <stable+bounces-176719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E8B3C051
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481BEB603FB
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393432A3E0;
	Fri, 29 Aug 2025 16:06:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A032A3CC;
	Fri, 29 Aug 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483573; cv=none; b=TkSfVcptulSPwpl3YXRyCgeKq8C77/7B1tF77W5EmD1Lc4JGjFi9RMYnquLtl2yhSdOQP8S0v3fn+JDLhdgGDRbetJurcmE3sRiZFSaeqDdWxmEGI9C/6JA1OP9pBPwBWGQ8PvRw2Lwax1r6+YSRN8ZG83ZZOYp8NAw8GUZfaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483573; c=relaxed/simple;
	bh=oG/RqtqKieHZimm7gXgRkzsfB19O/IOZeItoUrALDIM=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=FUzHxm+YbTfEptBwYi4PMbF5qlSZ0Iekd5N3+k8oIInRTvYimS0x5WlD6nohXDJXwZ+BjH/GYmW/7qvmMD+Fu5BjojzRySDIUh8O75U6LUCK3L2S/AaKfvHd9QOvWZ2ML084Dx5Vtr4e7Ry5omkWRD6NTJ+WmhZCRhQijFAJen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b694d5.dsl.pool.telekom.hu [::ffff:81.182.148.213])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D58.0000000068B1CFEC.0023A913; Fri, 29 Aug 2025 18:06:04 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda: tas2781: fix tas2563 EFI data endianness
Date: Fri, 29 Aug 2025 18:04:49 +0200
Message-ID: <20250829160450.66623-1-soyer@irl.hu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Before conversion to unify the calibration data management, the
tas2563_apply_calib() function performed the big endian conversion and
wrote the calibration data to the device. The writing is now done by the
common tasdev_load_calibrated_data() function, but without conversion.

Put the values into the calibration data buffer with the expected
endianness.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index e34b17f0c9b9..1eac751ab2a6 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -310,6 +310,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	struct cali_reg *r = &cd->cali_reg_array;
 	unsigned int offset = 0;
 	unsigned char *data;
+	__be32 bedata;
 	efi_status_t status;
 	unsigned int attr;
 	int ret, i, j, k;
@@ -351,6 +352,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 					i, j, status);
 				return -EINVAL;
 			}
+			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
+			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
 		}
 	}
-- 
2.51.0


