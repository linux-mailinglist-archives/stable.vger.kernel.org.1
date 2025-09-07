Return-Path: <stable+bounces-178758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E4DB47FF3
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6198B1B225CB
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F027703A;
	Sun,  7 Sep 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTSo3rdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C64315A;
	Sun,  7 Sep 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277865; cv=none; b=Q/yqDDytV5okhkq9q1pEmsW2d4A65w/Hw4ZN+3v0RM3DfhH3FBJHCFODJK7qeqmvhAYjg3duiXaHCoicBJn98a6eCwzouLclokp45s9USzPY13w1oSpOmqss50Eg/UhvJ4LbehHu0toXrr8G8Z7vYDFdaaq5jQZRmY4LCgGmQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277865; c=relaxed/simple;
	bh=5kWwdsDAbedIDMGrh6EofqyqfCDMa9KHm5oT1FtjaiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXk9WUNfPv0C2IOXHuUxhpUaMYi8zffr+GR9lbqogeIw0ZtfffoJn6Wauar2+64B85MbTAgwP1ML3ndVvO6sE/41R9PQ3GbWPB1h4UBLnhVRPa02C6lybeVtDgoUXhYq4nGkq2cBY2JPRps/np6o3uuqX7B/B1iXJHbTWECmWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTSo3rdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E08C4CEF0;
	Sun,  7 Sep 2025 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277864;
	bh=5kWwdsDAbedIDMGrh6EofqyqfCDMa9KHm5oT1FtjaiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTSo3rdRtJReZX2RYo0rY6rZFcymbWu8YaBLxeBzc3cleVCvuvFn2GHyoUy72Cw62
	 pkU1CNXH4tMmIrN3nT1MRryXmXf2BpRQFSxif8Mxo6PX8FLXjBmnxA8rr+JG6OzfOb
	 6FWEJJ1GXSDp33kZO0EsjJgm8oPgeL6ho8VThM3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.16 146/183] ALSA: hda: tas2781: fix tas2563 EFI data endianness
Date: Sun,  7 Sep 2025 21:59:33 +0200
Message-ID: <20250907195619.278122973@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gergo Koteles <soyer@irl.hu>

commit e5a00dafc7e06ab1b20fd4c1535cfa9b9940061e upstream.

Before conversion to unify the calibration data management, the
tas2563_apply_calib() function performed the big endian conversion and
wrote the calibration data to the device. The writing is now done by the
common tasdev_load_calibrated_data() function, but without conversion.

Put the values into the calibration data buffer with the expected
endianness.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://patch.msgid.link/20250829160450.66623-1-soyer@irl.hu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/tas2781_hda_i2c.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -292,6 +292,7 @@ static int tas2563_save_calibration(stru
 	struct cali_reg *r = &cd->cali_reg_array;
 	unsigned int offset = 0;
 	unsigned char *data;
+	__be32 bedata;
 	efi_status_t status;
 	unsigned int attr;
 	int ret, i, j, k;
@@ -333,6 +334,8 @@ static int tas2563_save_calibration(stru
 					i, j, status);
 				return -EINVAL;
 			}
+			bedata = cpu_to_be32(*(uint32_t *)&data[offset]);
+			memcpy(&data[offset], &bedata, sizeof(bedata));
 			offset += TAS2563_CAL_DATA_SIZE;
 		}
 	}



