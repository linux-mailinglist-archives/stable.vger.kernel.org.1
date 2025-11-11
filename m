Return-Path: <stable+bounces-194430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE30C4B621
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 04:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1C8234DCE5
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 03:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493732E148;
	Tue, 11 Nov 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HuBg940T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A82FD67A
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833551; cv=none; b=twWrHzfpKDsop9TSYJ7yFPASUxCh4Dyhxm8Itg+pOorpTqmHq9/Jqv8qS4jcPJ3yLh3vJoYUk5iat6lM7oabGZW6JYq9rKAWWAvLyxF+HIB1YZ+VKbHryB8skGouWekZH6ChZ+A5u5RBQMtb8s9VWN+KFfrrSbku7np61MTZL6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833551; c=relaxed/simple;
	bh=d7zt3o0fBF6z6ShTsIJHtkmGWSkuGiwNwAa0lxT8sZA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=BnsF6q1RaGZ/dbZr6XV3eJDF8YlMxEeZJO1qp86fv5jukz/0qOGFbvAfsmT6m8YY1rWIBQRiUXVACq6B5cblrmP9E7w1zkv0Z2tdlG7Xg9iLzXXutX51hVK+lJf7jJ34jBtb0WVumPrrz6HAHWEf8+tm5o/d5d3L3is4L9udo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HuBg940T; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a9fb6fccabso3022142b3a.0
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 19:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762833548; x=1763438348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVq8XgnIawzQ6hyOOJg0ZOu49Gf2C7JiH6qxLrR20tU=;
        b=HuBg940TAcsPZN1vOAqwCUU0jUOQDtdDpgv6j/zTg0+Ys+wlqreJytZiCcMK9ZYv7x
         XYbBB8fBSdogeVahUeBGSZs0TycSRmxw6jCRubSpAaS3D1ThD+WF6ZAFSeVsup0THHEd
         TWUtjxcG/ym1Nw9kJlRryteBWUpi1F5FqO6kQ2ZaZNGW7jI1VELnlIsLMEIgz1g2Pbzo
         oOeHnBrRSC48TQiuu5nZTzLY3j234swUo5kkQTjY3pmyZyJHKjQrGiyLiI8Mn2sDE+yc
         ug8S66hCNufq1/oPZoJaBklJZD8PaN6APO2tJvecX8UadWCEAtcS6QA8Qe84fvGH98Si
         4FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833548; x=1763438348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVq8XgnIawzQ6hyOOJg0ZOu49Gf2C7JiH6qxLrR20tU=;
        b=Kno1OmhlTI56yYVdmYKs6j9x5fr62lIrd8eGhLz+IQ+WTi0TWm1CgSJ/Hi1H5BOiQj
         Nv5IHC/nNk84x0WWMZGxu6CoezHJOnaPJnT9SMh0shctHxGq1truKTGEoriT7rQzEfEF
         ACklX+uQ20pCRqVmsDBiO+c9oLYDkakPd5RkzptxB0j2+Afq+CVWj9HgIbqmB6var9YF
         BEgIevieRSAr2AnI6k1KFx2Q9d4vTwBTp0Ei0/f7m6lghKtNX3DoqQ1rJELru+0ELMYs
         kCe6CkzmFlJPWfuYnr0UdJn/BQRDzLnYbPWwqM+KBvIIoQ7WZWLSTfyH9hYKf7RgPhKU
         MsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7xMPo5YeqwQ2bx+iNhdAIRot78XcOp/xX1texFXyHxMrAwY1BA2GBUM7YayNsOePKDDjTBY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyOFN47zigpw8irOEdMJT8OpSngKCJeyfWMtTrukoZ08mdpe4
	IeFg9HCq7PDEcZz5YB/KUON252IlMIdwXMRK309wQtezPsVXWO9PzA5yzcYBFN3ng2Y=
X-Gm-Gg: ASbGnct3vZfZlYfBjcnhY9D480imc9v8tC17GaeQvYsp5nLXhp4EUurEL/EYPB4hZNY
	3LZH7opSu6yHpliPnx4d/Lm2NTEVgvZWPWC7oF9K0EdkBFQAx//czDs21kp1zfze00jtmuhyuWq
	LfTO4m+7Vr02D0zOAdpi1cwFspaMAnBwLNmfdE8foCRtRO8udI+FZO71DNyNX/lsHfISIaXSxh9
	N/4oRrlecDSjJslgPVEOodruvjK6+yXFgR1C4cFdbWxLbyrhwUd56q9W/TWhwc54uPlyFDXFL/z
	rYwvXAnE5ThBSjbR83t6qdL5sV0ldGUoDbWNXWqhm3CD0ezwMQcElkIGH9XxuYxpmon8i1Ohw61
	zCi0BuChShgXWssDfYJPRqoOFOVgWEdaeyT2JuSqna4thePEB2h65WX5Mrg/oVpSuFC814w==
X-Google-Smtp-Source: AGHT+IFoqF9ZsFyouRF7AcoNeKJ72tcSc0iERyssRBJhE+Bolo78A4YMgkOvy/CIBISmSdJj4Gqtpg==
X-Received: by 2002:a05:6a00:1910:b0:7aa:8397:7750 with SMTP id d2e1a72fcca58-7b225b6fc10mr13734061b3a.12.1762833547716;
        Mon, 10 Nov 2025 19:59:07 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd4edc3sm13553449b3a.66.2025.11.10.19.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 19:59:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29_passing?=
 =?utf-8?q?_argument_1_of_=E2=80=98linkmode=5Ffill=E2=80=99_makes_pointer_fr?=
 =?utf-8?q?om_integer_w=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 11 Nov 2025 03:59:06 -0000
Message-ID: <176283354647.6732.10598152842717227667@efdf33580483>





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Werror=int-conversion] in drivers/net/phy/phy_device.o (drivers/net/phy/phy_device.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5904322dbb62197106ccc331a9b38bcced1cdf30
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  44c21f603a9a2b315280fc66ec569fb726e51fac



Log excerpt:
=====================================================
drivers/net/phy/phy_device.c:3061:29: error: passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Werror=int-conversion]
 3061 |         linkmode_fill(phydev->eee_broken_modes);
      |                       ~~~~~~^~~~~~~~~~~~~~~~~~
      |                             |
      |                             u32 {aka unsigned int}
In file included from ./include/linux/mii.h:13,
                 from ./include/uapi/linux/mdio.h:15,
                 from ./include/linux/mdio.h:9,
                 from drivers/net/phy/phy_device.c:23:
./include/linux/linkmode.h:13:49: note: expected ‘long unsigned int *’ but argument is of type ‘u32’ {aka ‘unsigned int’}
   13 | static inline void linkmode_fill(unsigned long *dst)
      |                                  ~~~~~~~~~~~~~~~^~~
  CC      drivers/input/ff-core.o
  CC      drivers/net/phy/linkmode.o
  AR      drivers/input/touchscreen/built-in.a
  CC      drivers/input/touchscreen.o
  CC      drivers/input/ff-memless.o
  CC      drivers/rtc/nvmem.o
  CC      drivers/input/matrix-keymap.o
  CC      drivers/mtd/mtdchar.o
  CC      drivers/net/phy/phy_link_topology.o
  CC      drivers/input/vivaldi-fmap.o
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## cros://chromeos-6.12/arm64/chromiumos-mediatek.flavour.config+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-chromeos-mediatek-691292a32fd2377ea9956eb0/.config
- dashboard: https://d.kernelci.org/build/maestro:691292a32fd2377ea9956eb0

## cros://chromeos-6.12/arm64/chromiumos-qualcomm.flavour.config+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm64-chromeos-qualcomm-691292a82fd2377ea9956ed3/.config
- dashboard: https://d.kernelci.org/build/maestro:691292a82fd2377ea9956ed3

## cros://chromeos-6.12/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-chromeos-amd-691292ad2fd2377ea9956ed6/.config
- dashboard: https://d.kernelci.org/build/maestro:691292ad2fd2377ea9956ed6

## cros://chromeos-6.12/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-chromeos-intel-691292b32fd2377ea9956ee6/.config
- dashboard: https://d.kernelci.org/build/maestro:691292b32fd2377ea9956ee6

## defconfig+kcidebug+x86-board on (i386):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-kcidebug-691292932fd2377ea9956e4c/.config
- dashboard: https://d.kernelci.org/build/maestro:691292932fd2377ea9956e4c

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-x86-691292892fd2377ea9956e40/.config
- dashboard: https://d.kernelci.org/build/maestro:691292892fd2377ea9956e40


#kernelci issue maestro:5904322dbb62197106ccc331a9b38bcced1cdf30

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

