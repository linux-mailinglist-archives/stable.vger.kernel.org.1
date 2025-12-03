Return-Path: <stable+bounces-198176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB7C9E50A
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 09:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAC83A4442
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B42D7384;
	Wed,  3 Dec 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nL/66nl6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD122BE621
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752142; cv=none; b=siabYdzIFdyIsdSfuLEcgzGub0MeArzMz1QbV1R0KiO08Ef/OtKxEPulWGCNDN3kVorHjJ7pGMBEznr2zKYIr/Gjgac+hKqfPCCoc9XOK3oTVGzk/RkZHuBO9vlgZ0laQB1bhpbpGUriwNobC/6Da6xu8giS6smYKXV+y7+WGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752142; c=relaxed/simple;
	bh=KRjf6rI6QeytErOhTZc6Hqc8yif5VI8/8ZIpds2a6M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBHMUo2DiO9sFYephoPIhm0VH8FODB2MIX4gh1PCwL0d6sRwlYchLQqsvovSrMFKjkjXYuFZ5+rByVaqbsT7cWrZFaidKHi4STd+NCyuFARPBxgALrTSm5xnb79wyAnbZd54BZpZGNzud3oqLlplaaPZ2FJf06IFKlcDsdbDdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nL/66nl6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5942b58ac81so3741695e87.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 00:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764752138; x=1765356938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woHXwxvxfwFTv0q/SqwVCTAjIUDR9jdYwm8dKIe3Yl4=;
        b=nL/66nl6Eo1iAwyzy1bN5vCPXgxbn5AKL0d+N0TobH598vXYk/lCGHpXemuKlCiRVE
         Oym1V5T1VktChhfnfNAgk/IXDJel76XomfDUGu9xGbe2sb/XomFsKBKackAnwiZDvTw4
         Pjp2mbX+I3wsoBlwVUAliWFfO/rFKKfttW6Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752138; x=1765356938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=woHXwxvxfwFTv0q/SqwVCTAjIUDR9jdYwm8dKIe3Yl4=;
        b=rlTmLfTeEpy6yzg3Y0W69YHDdmGtysK5i4c4QGgpuXmSX2GvszjD1y88tPHGaCKYWp
         R9lyFS5RaD6r3+KyCQ75JTpiGmDz9gkYkiTgPUEt8ThKykHtCI+LqmH+/ThuS18HMpas
         5RLbnYSFvMoPmUxlHSXFR6V5ewS4jegw0w5PIzRX6PBk0j3UyteONBHuT0qg4mZQDowb
         wufHuoIpeeGBRX3EFtGXoGUkE8U4Za+5rTNdit8bRJqLofhAOMS/h96TPVfE/dGpprim
         8BjUo2pA1RKjWDQNaQLaL8tOAhb2+OHBuLCfNv+3En2+lM+j9FXZmOFh5hh4vUfrSr7l
         UA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVwYWWH7G9OIdjCdksPieP0dqHY6EP9BG630iK9anFlkaEFxRpK+j+T8uul/My5IoqD3uokNjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SSc/mFop4AoRYPP4q+b0ak0zrHXfg0VjbXnzEPf8RghjWxgR
	3PBZ1dh+OGg8FYZx2P5MSm9lnnfQhZIanyja8IvCoaE1M3lHPb+GKiJ7tef7HFHkUQ==
X-Gm-Gg: ASbGnctv14D4yM9mvp3t/SpsDt40nptzAMDAcD1YCys7VD2cZkzvFpvUat1erLBevTC
	DvCcN0q7M9pVqsD6brMp6kfQaIepCLjp8lBiK9Hnt5v1uj55aHaHz2b+n7uBgs1T3R3LaAY/gQU
	2Vs4Fdiw9IF3JTSDJubIZDuR26uR8LJlR37G4z3lsc0kyOf7KWVj2SvjrpYXrgQvs0QV2N02E2g
	8e0amVaq4+4BBnj1gZ4VJECur/C7gZXAOUOZsdM1vm4KLpD75NZBB5jt8yVy1Z8uO5zFQ4RlJjI
	HwlxQYoTD+Zjs/jPTpWXqf/bcA6Tgs/YIGjekMoRdIajnAHMr91nHFLLclkZY5Q+fyK64Mo5PT/
	FIy1VEQHxTem0pSI1uT4Li9JFMZO6UO2yFtaYFy1u45yv5Q/apvXzx3xkPzuocDX9GBI4KU8/r6
	imeHbnUj7QHK7H1BHp5ATxIhj07opcuttJKeqkBjID2khAcqu1tHgvODtrnUGAawtvsQKv49djE
	ncESTOWFy7vnkFFB1g=
X-Google-Smtp-Source: AGHT+IFTKSoVv7lOSXtd9iPwhZeRSNLFxYSPOIOsHgyo/230WEcBofLQ8T4STXRlBe4/0ZQCEDG4nw==
X-Received: by 2002:a05:6512:b8c:b0:577:2d9:59f1 with SMTP id 2adb3069b0e04-597d3f37650mr683682e87.19.1764752138351;
        Wed, 03 Dec 2025 00:55:38 -0800 (PST)
Received: from ribalda.c.googlers.com (165.173.228.35.bc.googleusercontent.com. [35.228.173.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bfa43f3esm5315377e87.47.2025.12.03.00.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 00:55:37 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 03 Dec 2025 08:55:34 +0000
Subject: [PATCH 1/3] media: uapi: c3-isp: Fix documentation warning
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-warnings-6-19-v1-1-25308e136bca@chromium.org>
References: <20251203-warnings-6-19-v1-0-25308e136bca@chromium.org>
In-Reply-To: <20251203-warnings-6-19-v1-0-25308e136bca@chromium.org>
To: Keke Li <keke.li@amlogic.com>, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Building htmldocs generates a warning:

WARNING: include/uapi/linux/media/amlogic/c3-isp-config.h:199
error: Cannot parse struct or union!

Which correctly highlights that the c3_isp_params_block_header symbol
is wrongly documented as a struct while it's a plain #define instead.

Fix this by removing the 'struct' identifier from the documentation of
the c3_isp_params_block_header symbol.

[ribalda: Add Closes:]

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251127131425.4b5b6644@canb.auug.org.au/
Fixes: 45662082855c ("media: uapi: Convert Amlogic C3 to V4L2 extensible params")
Cc: stable@vger.kernel.org
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/uapi/linux/media/amlogic/c3-isp-config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/media/amlogic/c3-isp-config.h b/include/uapi/linux/media/amlogic/c3-isp-config.h
index 0a3c1cc55ccbbad12f18037d65f32ec9ca1a4ec0..92db5dcdda181cb31665e230cc56b443fa37a0be 100644
--- a/include/uapi/linux/media/amlogic/c3-isp-config.h
+++ b/include/uapi/linux/media/amlogic/c3-isp-config.h
@@ -186,7 +186,7 @@ enum c3_isp_params_block_type {
 #define C3_ISP_PARAMS_BLOCK_FL_ENABLE	V4L2_ISP_PARAMS_FL_BLOCK_ENABLE
 
 /**
- * struct c3_isp_params_block_header - C3 ISP parameter block header
+ * c3_isp_params_block_header - C3 ISP parameter block header
  *
  * This structure represents the common part of all the ISP configuration
  * blocks and is identical to :c:type:`v4l2_isp_params_block_header`.

-- 
2.52.0.158.g65b55ccf14-goog


