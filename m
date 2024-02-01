Return-Path: <stable+bounces-17561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C1844FEF
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 04:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20D41C23201
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 03:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57F3AC08;
	Thu,  1 Feb 2024 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llQNsKzR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980221E896
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 03:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759683; cv=none; b=eU+JUqPS2jxj4DwuWIJpgsxuqF9yr9aV3ngXwP7/mnPfuIBcFiOWZEDEAX/N/rwnZ5/zK+RifwdA8BzITiInP8qy7DosCotD/UJMRgLoKz0xxYv3D9uVlkPBjtNcN4wnM2xoWdHtSUfVJYUz+n0IPZKbZVAVUDGewTph3OLBNz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759683; c=relaxed/simple;
	bh=VGUSm4CZhwKKkpBnPZtQtSN+GyWVlyJesZRnLE/yTnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vc+y5MMB3ZGI8f7kKQBrmXibufdDWPrMOaNh2qN8xrwzjJTuRTSML8HPVIIQTu3IR7sGf8xB+QCxOLKBS6xrZtENVesMsAM7yhJPsk31btQ7VEk+ouaCLLzI83xnIwoMyCM6WzTu1/r8Ld3QBQzOUrSZDejIdPdQbdbK3J/6vY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llQNsKzR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso150585a12.0
        for <stable@vger.kernel.org>; Wed, 31 Jan 2024 19:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706759681; x=1707364481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsyGJwyu2FyCSNt9BYOicG4oc98Z7BiQVxUgywTaCuE=;
        b=llQNsKzRieJap4YBkTWZkPCIe/LM4SdDZTN11I8qqVtX2rxhR9vhfdw8TpEyL3awrd
         NpgIeKK248FDcqwLYMnPsnbv8IQ/Ww523sBzZEDomltv6+nQ+EsJV5g/9VyD9zgnohRT
         93vhXFCVDj087SmsUpf0CFmCgB0Sg1HwKESZZt1vNuJzxUfR//h4dtkNwMpsmNSTn6+A
         0gTmV8aWZ8zd295XBlUp48ejFfdRO4Cye2nESqe0wRExCW/h0arIxNgL2dteoZ5Aahnn
         udfnuH2PTX7Zd0oMjVfIijcq4c1f59mphhU1ikyAehXKo4kPBxi843xJPD/lrImkdznm
         fo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759681; x=1707364481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsyGJwyu2FyCSNt9BYOicG4oc98Z7BiQVxUgywTaCuE=;
        b=Oy1OXoKAGdgAIS/X01i3qiCtOFXGBAwGs7R3IMkTBEgpnNYh4dUyuT8QFm9ulmvO13
         4PWMt5RE6p3msAvV7pN62SQlU52bJ8MKUpRUq2H7N5279m2Q4pkdfOSLNTiFAerEClLr
         VIFLiezNUvdHBLAM737Mjwr9SiIo2au0sgFLXiDEqm8ok0sYiiruN+Bsy/B5M4BN5XJl
         DLGK2B7O6pi0BP87ECx5zyPK1q8gN6S8BnHxqLaohXL/Qe5YLj9ovsWG4WwFrb/3XrMp
         T7738aenpdOfYF/GGPidCqNjLWQ+xEx9USytWKgKWIZ12tMBz77BKPYGLUtGN1eL4qE8
         B+gQ==
X-Forwarded-Encrypted: i=0; AJvYcCUCnrBqpcIfO/fiihUDFApG/3pg8mOvHJ2Ovh15hDcxURiB0Bh+lW7psZ6zxSTBNr98/Eb/5cBolDgEY0hEbn4hA2jhBtcP
X-Gm-Message-State: AOJu0YzsUhjj2lX/uEqk+zhzx9FvhpZV6hdoJYgZD91qbUjtw2OlZGRg
	eUaKXpjkFn7SqUjnNCAEH/84rFHkX3dnmjn/TGPp8ps1avF+q+Tx
X-Google-Smtp-Source: AGHT+IE0qskZGq18BKrBPepnnbFE50SISfMbOSlnB0BpZhg+fE4NIz0ESxO6RQJ415ILIve3RqZ74w==
X-Received: by 2002:a62:cf02:0:b0:6dd:c870:2f7c with SMTP id b2-20020a62cf02000000b006ddc8702f7cmr3767501pfg.2.1706759680779;
        Wed, 31 Jan 2024 19:54:40 -0800 (PST)
Received: from Rongo.. ([153.246.18.34])
        by smtp.gmail.com with ESMTPSA id fn17-20020a056a002fd100b006dd84763ce3sm10704271pfb.169.2024.01.31.19.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:54:40 -0800 (PST)
From: "Tobita, Tatsunosuke" <tatsunosuke.wacom@gmail.com>
To: tatsunosuke.tobita@wacom.com
Cc: Jason Gerecke <killertofu@gmail.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: wacom: generic: Avoid reporting a serial of '0' to userspace
Date: Thu,  1 Feb 2024 12:54:33 +0900
Message-Id: <20240201035433.4489-1-tatsunosuke.wacom@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gerecke <killertofu@gmail.com>

The xf86-input-wacom driver does not treat '0' as a valid serial number
and will drop any input report which contains an MSC_SERIAL = 0 event.
The kernel driver already takes care to avoid sending any MSC_SERIAL
event if the value of serial[0] == 0 (which is the case for devices
that don't actually report a serial number), but this is not quite
sufficient. Only the lower 32 bits of the serial get reported to
userspace, so if this portion of the serial is zero then there can still
be problems.

This commit allows the driver to report either the lower 32 bits if they
are non-zero or the upper 32 bits otherwise.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Fixes: f85c9dc678a5 ("HID: wacom: generic: Support tool ID and additional tool types")
CC: stable@vger.kernel.org # v4.10
---
 4.5/wacom_wac.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/4.5/wacom_wac.c b/4.5/wacom_wac.c
index b38094f..5a95891 100644
--- a/4.5/wacom_wac.c
+++ b/4.5/wacom_wac.c
@@ -2601,7 +2601,14 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 				wacom_wac->hid_data.tipswitch);
 		input_report_key(input, wacom_wac->tool[0], sense);
 		if (wacom_wac->serial[0]) {
-			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
+			/*
+			 * xf86-input-wacom does not accept a serial number
+			 * of '0'. Report the low 32 bits if possible, but
+			 * if they are zero, report the upper ones instead.
+			 */
+			__u32 serial_lo = wacom_wac->serial[0] & 0xFFFFFFFFu;
+			__u32 serial_hi = wacom_wac->serial[0] >> 32;
+			input_event(input, EV_MSC, MSC_SERIAL, serial_lo ? serial_lo : serial_hi);
 			input_report_abs(input, ABS_MISC, sense ? id : 0);
 		}
 
-- 
2.43.0


