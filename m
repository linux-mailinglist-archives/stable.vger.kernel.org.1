Return-Path: <stable+bounces-181857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F0BA7E41
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 05:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D92189A048
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 03:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626B217F29;
	Mon, 29 Sep 2025 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bstTTW7z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CD2116E0
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118268; cv=none; b=tw0WinPspVKbAVeasopTwzLmcd8VuDgJEbivqGiNwAZaDODy/4/fHdwwzv7k/g0LBLypzFlz16ddN0HTPZHQ//BYUPn749g18lJFYos8G9cP/atJCfUtY+9u1PsKtl5/T/s6b8HK4w40DSyvSEUKjlKiZYqRxH6ZfVinvAfyYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118268; c=relaxed/simple;
	bh=3VtC9QEP0FuA+LmC0pKml6zS0Q2JG89oocqVheWitC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/yBGFLK1fezLKkFVybIZzsC1O3wOtUydg8z19Mw5gFXWYdFUr/eF3jTVywC53TVFEp6P543smdpuwXBd7Kie067QaH7ttKxsjM5dL56KFd+Ck9BXpavGbDSftV6Z5M0xQ1Y1+bM7c1LZX9zWIefdfRITS3sZsHvsVQxo3UtlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bstTTW7z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f8986so40722245ad.3
        for <stable@vger.kernel.org>; Sun, 28 Sep 2025 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759118266; x=1759723066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjmlxuHBRkA7MQkbi2sgmbigWF/QBJ1NrSsTurPvM8g=;
        b=bstTTW7zDiIZ5+pMAln+EKATFQr8E2mitj3W9MURwwMwv+cYw+R+3mGXnmxcWRYayp
         BpSvO/0FW0uvMtYNwjgOozVcFMI12efUd3dhSP+kHZc8S8khp6R4A40iSpQ0EQGRYXDT
         AlHyBWwYf55Nbl0SkcZeODUIciuhKbt4/qsYnqYqtu76vTcP965y23zGyRQeYKV40H4L
         LCtgxFDaKf0Fq0+Ru2ag7lgAxGUWoYfIJ84/sdtYAlU71wot9U8SzLdDQt35gOmFsxIW
         DH08sOm+dlOSIE4wQc8AGmaWfNfM+6q6sH/lK2ck4kNnobnLL9NlBNQ3WnqWO9yWwAeo
         sn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759118266; x=1759723066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjmlxuHBRkA7MQkbi2sgmbigWF/QBJ1NrSsTurPvM8g=;
        b=mKL6bE12Hbh6mSeSdogJigqttfWka7PewxL+ejFWWZjGmU438E6/EbdETm3L2OhVWZ
         oPiBXKU5N4bDx8Eb9au18U9Ksjf6mH2Vrb6l3oePBaIqu4bJMy9SM6XYpleZ8fbn831q
         8e/EME+eXxHzWf5RZYmFFxpKmyva9lymMpoptwqlzLXLSLH5PgQPnRGKRf8yV1zZ+0NQ
         phA9NAWIfsBAKcVwE97jw6JNEIV85oVCpX2Lq6JpJ6vwmsq9BxLm6hOtidiuWuPwk96M
         XtdHCXa0vosEJell9HGQVjOElDhJXr4nvPOsELqI12wrM2q/lBhk8C8ncyZUP0WrrmKR
         0yDg==
X-Gm-Message-State: AOJu0YzEQx1LALnOf1lroVwfbAICyhOkH0xUFDuOgSRrqEWSylx4xAG8
	Ayy/5vhxCldwFcEcGlKtJ1wggjaNeMS5SXzCrLVql/QTmhxro2y72kwR
X-Gm-Gg: ASbGncvPGcIrG3dk3k81cqeHQYFXvkHBX3x3yIeC8nS+NwV+w8/GEGwUhgWFuNqHjcC
	VeqfQ3aoWdpKPSbvrbU/36IOszIll0GoS3YOPZcU5tNuvXvTjN4yxcKDMDcusf2F9CDq90qNBxC
	wcXcN0QHU47LuKKqSIY2XQJ4riP+rHuuSiXOGloiWKM0AQ67psaYFrIwaCLTivxmCWvS1CR/r5h
	3coiWU6B/8WCrsu+dYXwjZoPyNbUfSPy1OoCme9WtMieEp2CmTl9VWTYJnl7Fe5FzIIlFTq/7NI
	oCp/hGYr2ghPfRRfaDtM9XSodmxfPpGbZfIlUx2D7YfOz+gSnOcn75/7/JrhpnB7T9aSEGHdeH1
	bXOjjKFNbUwUBztn6UMBT4iZSBplzl6YGW11/DVaduc1HPVoQDlOr
X-Google-Smtp-Source: AGHT+IEevmpdboB62xMNk3yx0xvMyzzUFDH2WgA+11kq/sNZbkRfiu0LN6zS1LM8UlLyQ1moYU2XUA==
X-Received: by 2002:a17:902:fc4c:b0:27e:f005:7d0f with SMTP id d9443c01a7336-27ef005805amr111633965ad.44.1759118266240;
        Sun, 28 Sep 2025 20:57:46 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm116411945ad.9.2025.09.28.20.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 20:57:46 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: stable@vger.kernel.org,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1
Date: Mon, 29 Sep 2025 11:57:19 +0800
Message-ID: <20250929035719.6172-2-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929035719.6172-1-zenmchen@gmail.com>
References: <20250929035719.6172-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2001:3329 for D-Link AC13U rev. A1 which is a RTL8812CU-based
Wi-Fi adapter.

Compile tested only.

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Link to the Windows driver for D-Link AC13U rev. A1

https://support.dlink.com/ProductInfo.aspx?m=AC13U
---
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
index 324fd5c8b..755f76840 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
@@ -21,6 +21,8 @@ static const struct usb_device_id rtw_8822cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x13b1, 0x0043, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822c_hw_spec) }, /* Alpha - Alpha */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3329, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822c_hw_spec) }, /* D-Link AC13U rev. A1 */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822cu_id_table);
-- 
2.51.0


