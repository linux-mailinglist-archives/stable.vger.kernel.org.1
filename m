Return-Path: <stable+bounces-145828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2453ABF420
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A437A86D2
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32049267B9B;
	Wed, 21 May 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqz9Zdas"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1D2641E2;
	Wed, 21 May 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829832; cv=none; b=MAJ0/0juz/mGx7/Cu1c8RPnm63NfI0Bs8+O/axluhtPrRda9Um2Iz5su+ASJ23UYeiE7wK0sOqFo2RDofzexiJSsog0/FxbhvpAehih0YxVZ5/5z5WHaAvKBB6s6/5AJbhIShpN17/fY0Mn59azs3DNFoLxwm8/8/x8FoKhcfdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829832; c=relaxed/simple;
	bh=/kMUfLx0poTwBYSMDoarOfIRNsldt97iczgCvvC6xP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPA3qxfHerVDZhnD2X2HW45H1Agw27yqAawi+d3RYc7XNaKukngw99gzX42SjW2eSVthv03kXwdI4XFhO6GNqd9JR854jsGVSdWUoT4/5FIkZPmlNdNUNxD1G0QY06DblLRzDVDPw3gux8+MkmadEPiS5/jPmF0Gg4S8ctpFsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mqz9Zdas; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so70460525e9.1;
        Wed, 21 May 2025 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747829828; x=1748434628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRam+fE/VU89y0aj77lDoghdmOHayQZt/SLAM/xjqow=;
        b=Mqz9ZdasdVvLpqzy0Cj5jh9HKvq6IQm8QwuDL5TqrjSH2lBmbjpnc3u7EctKSI7ch2
         5MUFiuJqAkNG3vGUAduuXwqJqFdh7VpKC86XTvY29zmCaEMcIHHKxNWL0tJv/FFk899Q
         0n49+UOWWa6z3YhI51uFrk4E30S9wN+sn/lT2GPlpm+703mnJrR9nuu/47hUSriNonMa
         jaFJl4PoHA6BOXeoE21LpNuf9uJKgz2NSExjNpfv81/C3FqgQADWqQ/luHdYpiKo+hur
         CB2HFsL/TyHRFXtD++8ocYS8Osc4olgo25XHo75lYBxyKIkTtv2W4myGQgluKYePtniF
         PndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747829828; x=1748434628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRam+fE/VU89y0aj77lDoghdmOHayQZt/SLAM/xjqow=;
        b=Fh4dUhB1dpoDwh7Zcr8xzzgMVpsnapuaH2/LmrPC+SklMelgXswaluZakv0tdHih1r
         v0Dnw6txMHZBkUy/LGLJPQiGKDVephj8k23N8xVIIVnjtKc3dr0JYOYIYDspUuGbSfcH
         /zaVgaNjMSLFmFHRzh10mQesPqFKaw+r4ej1QskRZnjUrbrl67OWxfwJbOlqd/Ih5Wyc
         /4NAC5I5Mofz2aiWBccZ55oQcAcu6wd0cnDWtGltpTD3UoGZCCk9HhuX1evzpPGSCMZe
         pWYptKvlDnccP6SWX42j/oDx0MFIoZxmEwRD4IJmnxDz1pSmA/JgV754bprymQrMWG7i
         9mLw==
X-Forwarded-Encrypted: i=1; AJvYcCVYbZvB38KThDXez4OrTYQcHr+0sM5+mkaNQNiiDF949j4a3Fmondm0N9KWgW2aE0HEE43vZvuLoeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zVAQYzm7Hd1fpc5Uqm00uuFpqe91NeMK26gXdDcxBPEHVYQ0
	QFS4AZjjI0dDLL2pFabIoPnYfHyBmLYWK4cm8tOy2neneNyGBe7cZSWI
X-Gm-Gg: ASbGncsfVRMkaOG5zSfWqy6rYEZL3Dgkb8m1L0gJLT6IC6FfYQNkND7FDgOxxB8W0N1
	QgVUSN4c1w4bvhxMcWhmvaIoF9eQBtZgBdCMO3i7UUJK3pv6FaoK6F08JUiAtNY5vWELlwtuOd/
	66gkmdm4WKWe/9a+oAUn9zZgERelc0Lguqm1wXf0G/j1ySsoVbGV1u8ZEMjtLih6QOR092CryBw
	EjU2XqVgRa3uxNpQHVuoXnBghMg6qwa2x9fokU0RIVpqfQawNK28onfA62vxbNdI924rAyLSj5l
	KVO8mjRwzitv1R+AKx9Q6/drGIk32P5hqXC3uuTDWK7737eMkV+8zgw1PeisMoZgVjNjZ1z2ClT
	VUEFXXC2thi4=
X-Google-Smtp-Source: AGHT+IEzMHiQy4kLbd1qaVdLnTN9romTOdAJ6htEpA53McvS7cppgcbTb/JCJ4mSXyxJg6ThT4djCA==
X-Received: by 2002:a05:600c:b94:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-442fe694699mr167390285e9.26.1747829828497;
        Wed, 21 May 2025 05:17:08 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0552esm66327845e9.11.2025.05.21.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:17:07 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org,
	guido.kiener@rohde-schwarz.com,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 1/2] usb: usbtmc: Fix read_stb function and get_stb ioctl
Date: Wed, 21 May 2025 14:16:55 +0200
Message-ID: <20250521121656.18174-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521121656.18174-1-dpenkler@gmail.com>
References: <20250521121656.18174-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usbtmc488_ioctl_read_stb function relied on a positive return from
usbtmc_get_stb to reset the srq condition in the driver. The
USBTMC_IOCTL_GET_STB case tested for a positive return to return the stb
to the user.

Commit: <cac01bd178d6> ("usb: usbtmc: Fix erroneous get_stb ioctl
error returns") changed the return value of usbtmc_get_stb to 0 on
success instead of returning the value of usb_control_msg which is
positive in the normal case. This change caused the function
usbtmc488_ioctl_read_stb and the USBTMC_IOCTL_GET_STB ioctl to no
longer function correctly.

Change the test in usbtmc488_ioctl_read_stb to test for failure
first and return the failure code immediately.
Change the test for the USBTMC_IOCTL_GET_STB ioctl to test for 0
instead of a positive value.

Fixes: cac01bd178d6 ("usb: usbtmc: Fix erroneous get_stb ioctl error returns")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/usb/class/usbtmc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 740d2d2b19fb..08511442a27f 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -563,14 +563,15 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 
 	rv = usbtmc_get_stb(file_data, &stb);
 
-	if (rv > 0) {
-		srq_asserted = atomic_xchg(&file_data->srq_asserted,
-					srq_asserted);
-		if (srq_asserted)
-			stb |= 0x40; /* Set RQS bit */
+	if (rv < 0)
+		return rv;
+
+	srq_asserted = atomic_xchg(&file_data->srq_asserted, srq_asserted);
+	if (srq_asserted)
+		stb |= 0x40; /* Set RQS bit */
+
+	rv = put_user(stb, (__u8 __user *)arg);
 
-		rv = put_user(stb, (__u8 __user *)arg);
-	}
 	return rv;
 
 }
@@ -2199,7 +2200,7 @@ static long usbtmc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case USBTMC_IOCTL_GET_STB:
 		retval = usbtmc_get_stb(file_data, &tmp_byte);
-		if (retval > 0)
+		if (!retval)
 			retval = put_user(tmp_byte, (__u8 __user *)arg);
 		break;
 
-- 
2.49.0


