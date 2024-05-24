Return-Path: <stable+bounces-46018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F38CDEF9
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 02:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12D81C21390
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 00:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683944430;
	Fri, 24 May 2024 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvaNuc5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E214C99;
	Fri, 24 May 2024 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716511471; cv=none; b=WafY8SKb0i1FnLy8Ui91FuzxV8v8wXgan89Fd5Lc1fi/mL3nZuEYf8PBT71xdkxXwuPT5DWg4GYyFx9W85Nc+1Nc3dKDmuPXaTyXjAJgtYnr6ilIpefssRuIj5iIigwZRAasyG/ACRKq782DwozuybTvmolwBKM0N2i9ozbAY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716511471; c=relaxed/simple;
	bh=IEBRAiGiSIuPPxCV+SjW0MMvxGR/UP/23ouD481D0+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiqoww36+iNaJDAWrsR0KLZa5KxhATLI0RDGxI37dD6K7kpeti1meiW/gO9L3MsJJf0PVBLYJRL6GxtR0z3xx+RK5lsu8UoNPI9NStlKVNqH7lEoqYSzy6giuFVZ3I7FwHavn5BP7xsSQ6kVVlUcD2s9fkbKPNpRZxpm9skcDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvaNuc5Q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35503846fc5so150100f8f.3;
        Thu, 23 May 2024 17:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716511468; x=1717116268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrUpC+iVM4M6Bp1+nCo25lQK7eOBGK+qm/qUXPfjAc8=;
        b=TvaNuc5QnFJlD2JZCHPUzmbnvDxgePIIXDmi9zVeZs0X+UHcsaBuhF7gcRfLWtKMvE
         rrmXhVL2asdqe0P1Kt6+w9Mh859twtQKT1aYEbyiU6LrcBv74R57/OSBvcD9ABO6/f1i
         S95j642eB+Cq5xBt8wdpo3Zb4cn+dtNJMCz/wTvcDW8hqHCWNownd5ebX0k+XKsFYdrT
         mlVkssT0K0XRUb9QPnzeCk/a3zOwwLzGa07qiAtayfz825pAEr7fS3OAxAMwgG8orlGI
         YT2rbr1r4IoeUtkS8Ew0ccwdUXZ7pIhfTuIE7ga2SRW8uh/M0RltolLgrm6g99+4DNoN
         LWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716511468; x=1717116268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrUpC+iVM4M6Bp1+nCo25lQK7eOBGK+qm/qUXPfjAc8=;
        b=JPcTU7YWCcSq4NnLRi5irN8G7c0Rvv2MwSwem2P8d4Dan073bhI9WJnEDEhNDEwS0P
         KiKmZ1KYy3MJjdAklbGBXMuvjc56tBPnfJlaZDwRW2cvjquxI+fycCDWMJByM/X4iPin
         LTcb6csg6GhTk28wYq3rQrTjCMwdlIOmmiZ/ciA9UYx/k6/bDFbRGx6qZMZutVxpXek2
         0pmXJpUWGI1QP2BCELjbnWKvd+n0eUWvkRNEl7/j9SNjuw08sGOx98nVq5dgyXEvLySG
         4UCdX869y4ZZ6zUSywjf6tFzTHFjG+G7fYmt6hHDt35wYLCjtNh1wG5RS7VISkiBo8E4
         YCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv7WIy3ym+USjs2Fl8F0OSD8ot30SXl3zpYid/H12JhVJBuQlxL8iPER76bce0AXbc7Yeqhf38tnDm+MjqJLiHAFNT7RMy
X-Gm-Message-State: AOJu0YzhGdtl/GJ3pFWenufLNBAYuGhb3ySF+HMVkg8hHj56ys0Yz3i3
	QLBsaBklCWkUH31NLGlzZXCVM3QZexrHoCt2y8In9aIVl7K2n4eFk2P+u4Uy
X-Google-Smtp-Source: AGHT+IEEtWS8nh+6AH44AR7vnAeTgthgx0z0XqEZFQ+37Gd7PAH/8hE380XNrN7dM7hJ9G9nx3VFRA==
X-Received: by 2002:a05:600c:1d25:b0:419:f241:6336 with SMTP id 5b1f17b1804b1-421089f9e0bmr5130665e9.1.1716511467476;
        Thu, 23 May 2024 17:44:27 -0700 (PDT)
Received: from amezin-laptop.home.arpa ([2a01:5a8:441:c1bb:3be:e18a:7acf:52e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210897c6bbsm5770335e9.27.2024.05.23.17.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 17:44:27 -0700 (PDT)
From: Aleksandr Mezin <mezin.alexander@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksandr Mezin <mezin.alexander@gmail.com>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] hwmon: (nzxt-smart2) Add support for device 1e71:2020
Date: Fri, 24 May 2024 03:39:58 +0300
Message-ID: <20240524004040.121044-1-mezin.alexander@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cd58922f-711e-4125-8214-57e1f83f6777@roeck-us.net>
References: <cd58922f-711e-4125-8214-57e1f83f6777@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for device with USB ID 1e71:2020.

Fan speed control reported to be working with existing userspace (hidraw)
software, so I assume it's compatible. Fan channel count is the same.
No known differences from already supported devices, at least regarding
fan speed control and initialization.

Discovered in liquidctl project:

https://github.com/liquidctl/liquidctl/pull/702

Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
Cc: stable@vger.kernel.org  # v6.1+
---
v2: Improved the description, changed the subject to include device id
(previous subject was "hwmon: (nzxt-smart2) add another USB ID").

 drivers/hwmon/nzxt-smart2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 7aa586eb74be..df6fa72a6b59 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -799,6 +799,7 @@ static const struct hid_device_id nzxt_smart2_hid_id_table[] = {
 	{ HID_USB_DEVICE(0x1e71, 0x2010) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x2011) }, /* NZXT RGB & Fan Controller (6 RGB) */
 	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller (6 RGB) */
+	{ HID_USB_DEVICE(0x1e71, 0x2020) }, /* NZXT RGB & Fan Controller (6 RGB) */
 	{},
 };
 
-- 
2.45.1


