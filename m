Return-Path: <stable+bounces-45996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DAC8CDB7D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0245285E36
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B384DFC;
	Thu, 23 May 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0jBxOxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33407AD2C;
	Thu, 23 May 2024 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496790; cv=none; b=hP8UT9ET/mBCX3v5fFogLr58fgFbHx4ZrjiGI/r2C0srHR3rL9easV31sueJoHnV4b6wwE51r9wLc4FmUjciVUVf4oBXX60dAp4H2xF8lcqCA60VN2aXFtsGBiu2YGes4B4dKpjITZusHKEHBke8vVa80XVI5DW++IJeoVLGTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496790; c=relaxed/simple;
	bh=/eIiTFxPhrmmpK0I7WDgZJ2Q1utDSw0zsfw43UuSIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWhmCxRuXflnlVDiAFEEvZIL6eZveObGeHx1dR5qXgq2P03/LrZo8jHGx73BXAsOlqr+DDDJ9iTycs9e8mijiouhJ2rWfTKGxW+P2qfoD5zx5j5mOwkULoftgK1dVUCyMhBYNmikk7Uu5XAc5RqdPTvara4t0URGKI1v1OWtkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0jBxOxD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354f89a59b8so239027f8f.0;
        Thu, 23 May 2024 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716496787; x=1717101587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPpD/TWpKnOWsvVms0onhLIVHSe3gvae5ALvO/NecjA=;
        b=Z0jBxOxDh81EL14C1aaWZG0z0aG91drp/hD3xfuWFBgSWxM2LrUoDlTYVEn6CrttbT
         y1KYOv7JytJV5/hJi9spyFns/9o47b3rZ+meVZRVygbuToB2qHpjsmc2KSTZshlMZdvH
         fRQqWe7XYrZfScr0d6CKos+ozUj0cq4opzh9/dLKe3Yj4ucQkXg+COUlt9xxj1aLzNSS
         DaytQ8nZVSycIsqPuPwzl0vrkCCMj4gbWywQnptbfBiVx2Ktrpn2kjJNi4GyUK6lPwbE
         hm55OOMgQYWT9AturKwZ5v0CbKKHyuwrzulJkP8b2QAmI8c24MMgCPOqwPpWu9nhENbn
         UDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496787; x=1717101587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPpD/TWpKnOWsvVms0onhLIVHSe3gvae5ALvO/NecjA=;
        b=kYl8iOJnW3jEROmN2PCQyMHgA2CND1eieVTopAjUZywFhwQqME+fqB4OgUzhtE9zHz
         DwlseklHuuvPkGUU59Lzw5sTKVKTjuESm+ed3yBNXjCNrXVnPWRK0DeAnfFxYSbkqlls
         nM13C0Ywz5gItVOFiKEWAUcS8O4mUdaQXh+hM1+4vXbgeCLd7TOHrwfGC0FlJ9pd84lK
         ZzAP4VCKI/zZpA6ATT86ZuYlYRJggM1j1dRtCh4vOxcYJl+Nz4h22I/nJoV7f+OsA/Qc
         pnIJgFKisNZhTKZFxZ8xd4pOAgq+mjMM8bKDdOFL0Dpxbjnxo+1FMVq0qp2c2y5+d5Rg
         bThQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX0i7xb9+I+C86FVcUyowFtHH4SsM6SupFY6q0pAtX1fpbZNrJlMaK7p9+HIvsjx1NF83bM2s/eZ/hu0B4EwObCnlY4COb
X-Gm-Message-State: AOJu0YxN8zrBo6k6vM15Lzh+v3Y0LPDtjZgr0JKJ+YgFB7/KOWB+29uY
	EYl7xJeeGOJ7v58RxtU1FXbZI8411VN7jMWz/2xyrYHIkvUzBH/iYy0xf93m
X-Google-Smtp-Source: AGHT+IGb2JSGrieNkPORles9mfVVAFxu9Ji0Nsde9QMrZ1XDfmIGNsS8HTwcpJYQ9oNFfoGYvtapdA==
X-Received: by 2002:a05:600c:1c1c:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-4210897a179mr2075095e9.0.1716496786522;
        Thu, 23 May 2024 13:39:46 -0700 (PDT)
Received: from amezin-laptop.home.arpa ([2a01:5a8:441:c1bb:3be:e18a:7acf:52e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fadcabsm34153795e9.35.2024.05.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:39:46 -0700 (PDT)
From: Aleksandr Mezin <mezin.alexander@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksandr Mezin <mezin.alexander@gmail.com>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hwmon: (nzxt-smart2) add another USB ID
Date: Thu, 23 May 2024 23:31:03 +0300
Message-ID: <20240523203130.75681-1-mezin.alexander@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fan speed control reported to be working with existing userspace (hidraw)
software, so I assume it's compatible. Fan channel count is the same. No known
differences from already supported devices, at least regarding fan speed
control and initialization.

Discovered in liquidctl project:

https://github.com/liquidctl/liquidctl/pull/702

Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
Cc: stable@vger.kernel.org  # v6.1+
---
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


