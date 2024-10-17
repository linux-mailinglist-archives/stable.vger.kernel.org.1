Return-Path: <stable+bounces-86601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C993E9A2162
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1461C20A80
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD81DC07D;
	Thu, 17 Oct 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGddNEgd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E711D365B;
	Thu, 17 Oct 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165500; cv=none; b=Gwij3zEKKeb5IR79bdaCSUu/J41ZCzimHidfbWa1AlPNWxNnTFkyBDB+/VHGg3JnKcXqa/fSeCkdNX5DVv/6MrHkLaTjmibxlF+qxfTENIyQdTBm30FxJiZZURmE24Y6nJK+AoqLcPXH9ylDDNUaFfVY99S31Befsc18bWwELvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165500; c=relaxed/simple;
	bh=BDrLAoYk78DuFKycHy6PJuwIencOiI6AZC8wRXXtIGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iZibZzM4T/WVMvmuoy/wosYlVlDvwe2KK97tTnTMq9US8W/pMTTjOEwQV/wV2ip3y3Dhni1dVJvf6hTliHHK2ZXKZVKUQHD/xFkZcPWEro6fp+Tpwo3xgX/UBOgxPFaxwEpYi5vHw65detkQOuTZAxRDweXpzpPPnVcR0EGh6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGddNEgd; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b13bf566c0so51393385a.3;
        Thu, 17 Oct 2024 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729165495; x=1729770295; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0gij7O8vtIgOEZIkJrRtW3eNqnKO7oPYnchc+vKsZQ=;
        b=aGddNEgd6GuMltMjXCIc6ocGr9nnDJrYe71ioNADiNZ1TsSSDPXJWU/ksuYokjNH6L
         v8dOh38JmvzsCtI1Td/9OqoOQZua0iMjWgC41iYfWd8cXMKoW62A9uEZ3LtbNkbvHPc5
         0U8PWsYZkz7eSLU7a+1zjfnAy3QltMvkkCE10gLkLxteZrojxPxRxseI2nqJ8F1UcqQv
         Fb5uCXiFZ0stP5dxFrrtsButsDbnzftnFMmozGD5zN9v95vOlpmHo4KDpo1kWaXp1YpS
         J8ugmCwmQUJGTAyLOOYk5BYQC3mQjHjpA0E+0A34GSC+r5tZ/F1DFucHEceuRz2yE7Mr
         +CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165495; x=1729770295;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0gij7O8vtIgOEZIkJrRtW3eNqnKO7oPYnchc+vKsZQ=;
        b=bz6corYZwEWfGeEgGff7c7V7Aivgf+UYNBv0+mglicOt8pXXeLagzNoMXz7fTQ9AAN
         cLSINDUUMvEPJfdYIY6J/N1SLB5ny1wB2fKEI3uAunSTQyY0AFn3M9NVHwF7pm+QKWxQ
         drLvuW0y8jw+lOOjLcZsAh9l+v8fwNUY2wQp3UBGpdPtauLRlF7Y4sRuKu1kkH9VkXbm
         927bA5Rt7qATaC8kk+Yq7AHjaRXrZ7KPjI/6ar8gxSnqNUdk93ChHhqdVGRJpLeovn8v
         3tgm3e2ZzzWw4sVKBP8SnBYqVzWZzpdyygsfiLGzjsb93q5WdSe9NRCcZ7m6Ch9leENl
         DzCA==
X-Forwarded-Encrypted: i=1; AJvYcCVxbh055QqCq7Bo+8zfq45CDRk+bPXqSHsH6W3P2iCC/XfQmo4TuoT+PLtlExHPU6tqMdSt9PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxraF4kEitXBFph7SpLeWpNfa1JkdVVSPiVQOM0mgReHrpVRqjw
	1cTVXdWTWIoGO/iZUnLFePQzlJyS3dILOCy4rPfZ8R9TgFeMyNWYsdq8MVMk
X-Google-Smtp-Source: AGHT+IGOVpfENdHUvZfa88a/CpAR85h9UtlEt/EralxbrJ/14qVsSERYblgWpbk6Mo4h+zBCPIX9fA==
X-Received: by 2002:a05:620a:4015:b0:7b1:4783:b7b1 with SMTP id af79cd13be357-7b14783b92bmr594140585a.64.1729165494986;
        Thu, 17 Oct 2024 04:44:54 -0700 (PDT)
Received: from localhost.localdomain ([4.15.194.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1540f9075sm14070185a.78.2024.10.17.04.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:44:54 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	quic_jjohnson@quicinc.com,
	dan.carpenter@linaro.org
Cc: avimalin@gmail.com,
	vimal.agrawal@sophos.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors
Date: Thu, 17 Oct 2024 11:43:29 +0000
Message-Id: <20241017114329.22351-2-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017114329.22351-1-vimal.agrawal@sophos.com>
References: <CALkUMdS3wEuSi5SGqsRKt3nSb4mHue1bJTJm8=QL3OLYU2GWig@mail.gmail.com>
 <20241017114329.22351-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

misc_minor_alloc was allocating id using ida for minor only in case of
MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
using ida_free causing a mismatch and following warn:
> > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > ida_free called for id=127 which is not allocated.
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
...
> > [<60941eb4>] ida_free+0x3e0/0x41f
> > [<605ac993>] misc_minor_free+0x3e/0xbc
> > [<605acb82>] misc_deregister+0x171/0x1b3

misc_minor_alloc is changed to allocate id from ida for all minors
falling in the range of dynamic/ misc dynamic minors

Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
Cc: stable@vger.kernel.org
---
v2: Added Fixes:
    added missed case for static minor in misc_minor_alloc
v3: removed kunit changes as that will be added as second patch in this two patch series

 drivers/char/misc.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..9d0cd3459b4f 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -63,16 +63,30 @@ static DEFINE_MUTEX(misc_mtx);
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);
 
-static int misc_minor_alloc(void)
+static int misc_minor_alloc(int minor)
 {
 	int ret = 0;
 
-	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-	if (ret >= 0) {
-		ret = DYNAMIC_MINORS - ret - 1;
-	} else {
-		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+	if (minor == MISC_DYNAMIC_MINOR) {
+		/* allocate free id */
+		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+		if (ret >= 0) {
+			ret = DYNAMIC_MINORS - ret - 1;
+		} else {
+			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
 				      MINORMASK, GFP_KERNEL);
+		}
+	} else {
+		/* specific minor, check if it is in dynamic or misc dynamic range  */
+		if (minor < DYNAMIC_MINORS) {
+			minor = DYNAMIC_MINORS - minor - 1;
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		} else if (minor > MISC_DYNAMIC_MINOR) {
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		} else {
+			/* case of non-dynamic minors, no need to allocate id */
+			ret = 0;
+		}
 	}
 	return ret;
 }
@@ -219,7 +233,7 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = misc_minor_alloc();
+		int i = misc_minor_alloc(misc->minor);
 
 		if (i < 0) {
 			err = -EBUSY;
@@ -228,6 +242,7 @@ int misc_register(struct miscdevice *misc)
 		misc->minor = i;
 	} else {
 		struct miscdevice *c;
+		int i;
 
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == misc->minor) {
@@ -235,6 +250,12 @@ int misc_register(struct miscdevice *misc)
 				goto out;
 			}
 		}
+
+		i = misc_minor_alloc(misc->minor);
+		if (i < 0) {
+			err = -EBUSY;
+			goto out;
+		}
 	}
 
 	dev = MKDEV(MISC_MAJOR, misc->minor);
-- 
2.17.1


