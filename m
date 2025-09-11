Return-Path: <stable+bounces-179315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B7B53EB7
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 00:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0C13BBDDB
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B662E3B11;
	Thu, 11 Sep 2025 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TePLdTuG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1F1EA7DD
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630000; cv=none; b=EAKbikE4hyByhHtuzhMXe8+wnHlBK+mLjbHf7hLar39hd2/hbVbMDl8jBh3KPFeEQ6Eo8Zc3sG2QX1ESvg7HXVUOtgO1Xm9dDYrprVemjryAuSjXTOfE4bPjuApNqraFp3eCryp+IVn2J0IiMW/1DUCLI4fT8F7UY2pWG5O1DMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630000; c=relaxed/simple;
	bh=tfwVIX/6aF8q+dXSD+qNcn/V3k9oPkh8n78oVHGeNbU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PmYY+qWVtZS9AhBSt0br4r6lpjBoXQPM7/PCQKwAKPxBzot+5YUI9xj62cTYlq0vo/pimOzra69/qnV/iJpOSRTLtvyUhiJF7tTIK9IhaFdgN9nqFX4zjB7WDnmFhO87fSANVzg50HnSDYWm8ofRAyjB/vVk2TKuj6j+L1njFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TePLdTuG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b48eabaef3so12473091cf.1
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757629997; x=1758234797; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O9RiA6yXEHDHT8h+ndmxEz5Ynac297GR1p7HFDs94Z0=;
        b=TePLdTuGEshyYmddTAszPfWzqDPyxccgfD32gSteopy+nYUsc+Cl4SRSgo+PzLiaxV
         h2Pjl7/Ofhdo/4AMtV5WH2EfX/Sdk2N0EEeCUXkplRw0HP+rUfErGTXckvtcW3WaPCal
         za2bsu5x00/6dgHQjkSnesL+Pc3UqW/TtJvN/CpGqYLPU9J9nqQVSWzaXKt3MjPi9Q9Y
         j31TGNZ/3WdKnGgKALldPjRhmIHOTRL230ZZIxUD1e/n0LyOpNdi28ZwJWAg4sanzOnx
         zATNaqdjho75dgYt1suTBFB+84aRdsSIA+od276gxyOfgYKvopgRfwa1gcY4CK6hFnHW
         YTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629997; x=1758234797;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9RiA6yXEHDHT8h+ndmxEz5Ynac297GR1p7HFDs94Z0=;
        b=gdqQPsF0qqsZidS/vGsMqPTcFwoUeHMwvthu6phzaBo64RxJiq2JCI3HEzYRYKbcG3
         904pwqV1am91go1izbK3GjEH81Oa3lmIx/HJqN9c9nEHGDPjQNK0FWZLKNVUiLRghv0e
         ntnC8DhOavOFABLZ4Hq5qy9BtWj1tqbZe323Hj3Afb7rLRu3q3vhRPMFs47am2Bmy49K
         UOjTeM7eJ0rROE9HuXWTVqZV/959DZpF3Tlu5ZYpc1pknGNVyaF/4efvIm2e9Ikh5wAA
         C5Tcx7HgMokM3JbT3GFWFBIz6PjGcBSclPXL0c5ScJBSuRwgZEMlbsFJYtVDSdM0hsfy
         U1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmupZYCLdUf7LQJlnNz5TDmEirwiQgMOinqvPtQypPM57UJ5N6U3AefZhiUMb6JrOmukYkxRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOQl1n/w+tn7wItOq4J0lv/qrAnyCPJao0zzl4DE//UYHaAy1
	GQR/SbOit/r8FXPi6xFRgFm6TsETcyBd8YgfvV5kzFA9qPqdg9Z4yzXQsCt6QnxSdHftDb7TyYM
	U24FAqLMbBwze2oQh2AbBhnOURmI2NQ==
X-Gm-Gg: ASbGncv60P9GIxH943p6lo+uRxvWitn/6ZQsnkgq0g0E0rCMIg6ETRzGfm9FNTLx28U
	qPdpKw1LpdytswwMVr+n0jhsf0iWRVs8yll1ZF8F40JTzu7FPdefgzT8yhKn/FVPvEz0caT2oaT
	JWHNcEYYrwCWVV4CYowa1Mw57u6o8OivjPyDAC9jiIa2aXgti0pypT+0o4cK0n1856RaWAYQppP
	Ob3Emi1dhDQysUz5W1YRRKBAeWI2W5ot+E2Xg==
X-Google-Smtp-Source: AGHT+IEnrDVO4+lV8w6iWfIZCxXDIuclhgzZoIttDg43rhxpZYOb0colikAb9y8fqVSyqkYQMbfLyxBIW6oIo8EZuZg=
X-Received: by 2002:ac8:5882:0:b0:4b6:33e6:bc04 with SMTP id
 d75a77b69052e-4b77d05a075mr10977771cf.60.1757629997478; Thu, 11 Sep 2025
 15:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick <morrownr@gmail.com>
Date: Thu, 11 Sep 2025 17:32:51 -0500
X-Gm-Features: Ac12FXygJeDcVZEzEZ6tNZ2GzztUR_Iy_WRSM8Yz3VrsyLOEDAY53SZuAkdFCf4
Message-ID: <CAFktD2fBPP_RQQ6OpL6NZy8rqn9jF=BCGOSiEMQNtw5c6MzwPg@mail.gmail.com>
Subject: [PATCH wireless-next] wifi: mt76: mt7921u: Add VID/PID for Netgear A7500
To: Autumn Dececco <autumndececco@gmail.com>, Felix Fietkau <nbd@nbd.name>, 
	linux-wireless <linux-wireless@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add VID/PID 0846/9065 for Netgear A7500.

Reported-by: Autumn Dececco <autumndececco@gmail.com>
Tested-by: Autumn Dececco <autumndececco@gmail.com>
Signed-off-by: Nick Morrow <morrownr@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index fe9751851ff7..100bdba32ba5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
  /* Netgear, Inc. [A8000,AXE3000] */
  { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+ /* Netgear, Inc. A7500 */
+ { USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9065, 0xff, 0xff, 0xff),
+ .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
  /* TP-Link TXE50UH */
  { USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
  .driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
-- 
2.47.3

