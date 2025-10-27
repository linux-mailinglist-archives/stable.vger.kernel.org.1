Return-Path: <stable+bounces-190015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF0C0ED33
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7535718837C7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11A3019A3;
	Mon, 27 Oct 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9P7A7SE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69D2EDD76
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577505; cv=none; b=dWVWAPJ4JtKxjnpW27grf6JxLYegSs//N9IojJ9nKAzHC5cAzvaOh/XnmkHbH4XqDQsbbt6lf6jym0Z1JKpN6Xh4thn+xTrJFmrNckympts/ZCobzzMQzRoh4XBo1QL1UXtLX1okcgtEYWUN7dfM0ggThZUig6OPS+1wX+CXsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577505; c=relaxed/simple;
	bh=T6j5pJIXxBFsaGqyk9NT2RfkOVr+/me2qdWz0yBnXMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSpRBImkuJrpIFh+dG5YqP1MEONJDL1+Gcsh4juUp97Pj0cXkfuOc2SL1r8Xm34Ex3DxK3Tsg/mFlt9b8SzslO0kUemWlqojmleBFDr9GfSP7ObYnkl6q3a5qCk6B87Gn79voHGFPUe/kAHmOshn2/BJNu62yo9/k1vR0DE+/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9P7A7SE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so6362332b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577503; x=1762182303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTupaOgzH6gbHMiWqxU5N/avQRrB+TsM9DGFdEjR8ho=;
        b=G9P7A7SE0cYKcuVk8MuBwcRcI74Kjl6yzR2cI8MhocDmNulu+Blaqelp6KgoHbWxwd
         t9rYTdRhIHyK6aOGUHGhOMHNx5T6Y81wndqXyjJzh1/UqPAI7Iuy6LRwc5sVvCgrrcYT
         Gq0Z9o7x61LaU28+avucYFU3C66Y2Mo165wSpT4RflfEKbZbc1iwyk8d+42cjp0YEJNB
         fI2UEMxUNKqvCoVDCBaKZ/61wftDhyd8sDtxcHtxBcv4OsBpIHjtW7fl35QzaJ51PVvk
         qg/4MpzUX3zBaHBRB7GESPKtRHWZyAB271XnUW2zuBEnJbtccpKBDJCzW4UTvxIzLKmt
         hsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577503; x=1762182303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTupaOgzH6gbHMiWqxU5N/avQRrB+TsM9DGFdEjR8ho=;
        b=ZugW41Tih98+oL/tl7gQcVrnOM5Gtuw8ziM0AyqO3ZVOFDZUOko9ssqn45YyZehSgG
         kGI4eanGavvXJFBLAQO6Ma1dEBHDsbn3SJ1AjLEZNrNhUa2w8SiYW0YgMQ/+vGYFJGtc
         JF/8fJQI7AwaBNrJAJcuiojvxtaRxbSGWPB3a0FLrbq8qyHFFkw2MNMLbntLEqMRTYe0
         PbNf70gD7LhBbS9H3BoaraFV9SH8QHDy5MZtFopujhr+4OXMUSNJCFKTTPodNS4E00mk
         In96K4sBTjSmqcJx8UE95cQFXcv7MjJRIqb+LBYMYpd4wD2bk10BKLAOtIcWmSCLW4FB
         5neQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8H8X/4JYKJB1f/R7X7/i4zjjE6GZzAJAg+7cBEY2zlAfx1tJckCji848PGQtC2RssQwP7Dv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsfEo1ixJDyq3KmckSffi4H136wxj3HJkSoh/bbO8Kqa/Z/+o
	zDrKPKK6laCEbSP+MRGwRtl0mF+0GV5IlZKrjY5FqLfvkEAyvB/97T4Q
X-Gm-Gg: ASbGncv2DmSMSkmSPXzc9dX1iWgHFEFPb6R8s0gUcsT5bNqkrYLgjuWmILWOBPMw52P
	+mvK/qsvkeZr0Uy7+20a/xW5RqwOuPy+65dj4EmbmVDv/sbCBvhoBjjc3exCDNWzjqhdcI3vuJa
	+oQdXk/rBlD/3ENVqB8xF/bqhwZWRZy2w+WtOaRqHG1wZHfRCJwMJgWdpKzEIQQCup07i8hkfAk
	BM41F71wRtDSS7AcP7leNClPwNxtXw0k32YC8SCGbt4cIsf32x4R4bAqjCopEmKeIHjpENV1Yi8
	T0ve5Ul9Y8GOuXdiUWwa6q7kLRrwpvidv/679YZ7uFOikVLSbs0778aDBXBDkwFOmb+5feWhzEf
	ucG+Xx6PDhGXNg6PlVta4CI96aeEwA7SWZ0wRwsEOLNUC7KNCnrHYwTXMPUqpoLtsAwe19OEDbC
	UsIWXBps5QaCu4mGeHcfvYBBmT9PFAKxFW
X-Google-Smtp-Source: AGHT+IHo5ASx3suVa6f8wqaFBDyQtbbs8qUYAB4N9R32si782j8k4P1cTG8u6ANyizohrN8+sMLTeg==
X-Received: by 2002:a17:902:eccc:b0:27e:f07c:8413 with SMTP id d9443c01a7336-294cb378960mr2882435ad.9.1761577502931;
        Mon, 27 Oct 2025 08:05:02 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d273a2sm84808825ad.60.2025.10.27.08.05.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:05:02 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: nforce2: fix reference count leak in nforce2
Date: Mon, 27 Oct 2025 23:04:45 +0800
Message-Id: <20251027150447.58433-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two reference count leaks in this driver:

1. In nforce2_fsb_read(): pci_get_subsys() increases the reference count
   of the PCI device, but pci_dev_put() is never called to release it,
   thus leaking the reference.

2. In nforce2_detect_chipset(): pci_get_subsys() gets a reference to the
   nforce2_dev which is stored in a global variable, but the reference
   is never released when the module is unloaded.

Fix both by:
- Adding pci_dev_put(nforce2_sub5) in nforce2_fsb_read() after reading
  the configuration.
- Adding pci_dev_put(nforce2_dev) in nforce2_exit() to release the
  global device reference.

Found via static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index fedad1081973..fbbbe501cf2d 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -145,6 +145,8 @@ static unsigned int nforce2_fsb_read(int bootfsb)
 	pci_read_config_dword(nforce2_sub5, NFORCE2_BOOTFSB, &fsb);
 	fsb /= 1000000;
 
+	pci_dev_put(nforce2_sub5);
+
 	/* Check if PLL register is already set */
 	pci_read_config_byte(nforce2_dev, NFORCE2_PLLENABLE, (u8 *)&temp);
 
@@ -426,6 +428,7 @@ static int __init nforce2_init(void)
 static void __exit nforce2_exit(void)
 {
 	cpufreq_unregister_driver(&nforce2_driver);
+	pci_dev_put(nforce2_dev);
 }
 
 module_init(nforce2_init);
-- 
2.39.5 (Apple Git-154)


