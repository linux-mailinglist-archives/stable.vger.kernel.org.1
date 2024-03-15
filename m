Return-Path: <stable+bounces-28288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84887D670
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4DC1F2367C
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 22:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874E54907;
	Fri, 15 Mar 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlZDZbxU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8954F84
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710540306; cv=none; b=GUIfwQxh8uqSmubU4Hzx5rU4MDoi4GhO8vZzkkKqzlY+MeeBBnUnn7dmzmPFvtBz8hyujNE0iRsAKl4ta71giZMTYDeI04QFpLkJCej4OTYCormxTldvH/oE/4d9CYPO38vSlV/V3ZGZxWiClLDdi6l0kVm8FQpSjZPnnMcL/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710540306; c=relaxed/simple;
	bh=9jUMzJ3nVVPbJqvFuatnf0lydOAmoeWh2WICjhZWHII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BfpvSbBM3gH0q6qvFZHaHTY5lMjr5xVVo3LMYQ+PP904hNFtvt84wUvkQU4WlnEBYc4eS8ZzIynAjtvUHBO17XK9Cw3smIFvHoVrPcY9JARVcczB/HaiwG5Jnd2NuiUx3jefAIGvenpS+ZOGu67doFB25r6TQ1afW+mjLiFxhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlZDZbxU; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so2169601b3a.2
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710540303; x=1711145103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qpkZmm6FLsHzBHeHcS2L4zYHetQVYtlWgdLUtLPlgU=;
        b=nlZDZbxUdkLdfOq+9Kw/4ZY4yQazJKNhIuG4QDbMKRD8pa3WNWvhcA73UO6OUYGvTh
         l5TZwdDleyZ/O10ICGMefvxG/sLMN9YM1Se/oHuhrY5FflkkkJxpjP8Etd/5sJs9Ej5N
         urB89lj8igXOUoH8KH9gEFiamRGyhg+T7j7CV2QOvywAGpSiFVdZS3Zzxkk5O6t7bs6j
         le/OljuOlcSGgEAmjwvUwXj5247ADlimDj9mYRwFgkGSREouY9qhxD000jcniy+xFB+K
         V5umQ5FNWwtzgP+sjKqHSQoc037VAqcSOx4/gUtAq59h8cdF6fb3rz1CLc9e7epumyEz
         jekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710540303; x=1711145103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qpkZmm6FLsHzBHeHcS2L4zYHetQVYtlWgdLUtLPlgU=;
        b=YH6iQIZC7+hrO8prLW0NOmCHG4razIAh6/y+owNmkvoY6Evez8Dh4dkHU918jH7qfJ
         TiKtNVe5/h3cFklt4lVgfNTIXoXW5jFMY3mzygPjRowRt5QSyGHaDByap+paNyoOTpEU
         XxNol7juoC28r9IjPeCZuxpvVFE0NJNneBfz7ubEItiWbr1ASYDHVcAGxbKYYWoR6Ao8
         WxFrlM7En8/yWT1b23TICemM/Dal16cSG1s3m7Bt1qP5Od1bE1w95n0wRydhwYT76bmV
         ghHCTX36NPAsJojxZFAtLc5LEz3htMAmbnxr6yAqjvukkP3NwiRIKAxFs5L03dS3RIvw
         7MpQ==
X-Gm-Message-State: AOJu0YyxeU49XDwqhp3J97gyZCjPQR7iiaPTC/AENPNiblgW2JTvYnjS
	povHVgnzJPUDDSQsu333Oyegz7ArSI2lAdktTD+R9PhUAmjsQROnScR9DynVMMc=
X-Google-Smtp-Source: AGHT+IEY95XsMYRveN/qLNtTNLY9hjrCcadGZfXG7B1Aa3SSqBNra7kRlrtR6Jba6i5W7duXSmZTIw==
X-Received: by 2002:a05:6a00:21cf:b0:6e6:42ef:ed1b with SMTP id t15-20020a056a0021cf00b006e642efed1bmr5408693pfj.31.1710540301780;
        Fri, 15 Mar 2024 15:05:01 -0700 (PDT)
Received: from google.com ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id t27-20020a62d15b000000b006e6c0895b95sm4024326pfl.7.2024.03.15.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:05:01 -0700 (PDT)
From: Max Nguyen <hphyperxdev@gmail.com>
To: stable@vger.kernel.org
Cc: Max Nguyen <hphyperxdev@gmail.com>,
	Chris Toledanes <chris.toledanes@hp.com>,
	Carl Ng <carl.ng@hp.com>,
	Max Nguyen <maxwell.nguyen@hp.com>
Subject: [PATCH 2/2] Add additional HyperX IDs to xpad.c on LTS v6.6
Date: Fri, 15 Mar 2024 15:03:15 -0700
Message-Id: <20240315220314.38850-1-hphyperxdev@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add additional HyperX IDs to xpad_device and xpad_table

Add to LTS version 6.6

Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
Reviewed-by: Carl Ng <carl.ng@hp.com>
Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
---
 drivers/input/joystick/xpad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d0bb3edfd0a0..c11af4441cf2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -130,7 +130,12 @@ static const struct xpad_device {
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x038D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wired */
+	{ 0x03f0, 0x048D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wireless */
 	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
+	{ 0x03f0, 0x07A0, "HyperX Clutch Gladiate RGB", 0, XTYPE_XBOXONE },
+	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },		/* v2 */
+	{ 0x03f0, 0x09B4, "HyperX Clutch Tanto", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
@@ -463,6 +468,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
+	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One controllers */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft Xbox 360 controllers */
-- 
2.39.3


