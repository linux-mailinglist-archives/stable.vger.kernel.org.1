Return-Path: <stable+bounces-192886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F3C44CFA
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 03:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB103AF673
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0A23C506;
	Mon, 10 Nov 2025 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="hGitv89T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61D1DF26E
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743547; cv=none; b=P7o2N29VsZg4XDHI3zqoX+Ps0QI27qAYYmAjWwy/tGEv/SM+X9yklUwVVB471OAUGE5k7F0WbXzjx7fThPCYso40VwjK/ReeqkhjLqCSbv9WYjkXodyqhIKlunVRKwFR+cN78FjelQPhidKmkK2seChs5E6Mxhy3gRLjPenpi9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743547; c=relaxed/simple;
	bh=8Cbp4Gpi1Tu9lJ8KEfQHcm098IBPHdBVZfV1m/VbLQI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Ern+tSKOgIr7g8b6pQ1Nv1sWoE/SXZVAUNWWNyFaQviVL0OSqly0ZquCCpYvgWY7ojAnfehNcG41BzqyN9sBwwGhZ7+Mh828lzEYorGF/l72kEAu+gNRMA6Ry8VHDcQaVXc00kiqXWKJmQ2+6N2/BsqHn7++k55qslAYt7JfhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=hGitv89T; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so2020497a12.1
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762743546; x=1763348346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+kcF6NdYoN+ZReOioRNTq9YIJqrSO60zFX8HdX0Vm0=;
        b=hGitv89TXWKWpdb8/Vc3iIxp4l7yyXLTrGHhhJHOpqw06uzuUKxgn5S3s0nZ1ULY6i
         m1Rje4DoenWFXhdyddhOeVftYOlQGw1gf44dsbeFOme9vZb76lOGzmp54J9U3ZH35ZeV
         dt+WK5az0KUAQCgUXmcgYCMVcTAJkBsI9rb8DZ0yukK2z0o5sNtA0yG7PpdWtSUCV3hE
         +ch65jF/Mjs5wqHmzRBeBZa0j44u8g9GtEq8mQ5lD3uLx3RqY4ArCge1G196fEg6I9zt
         qkyin4JeJDQay6m3uqeSdq5B2AjQTZGlp+vNXrpXmBlkunFuPdWwkyYRLjSPbHfTqHFX
         km9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762743546; x=1763348346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+kcF6NdYoN+ZReOioRNTq9YIJqrSO60zFX8HdX0Vm0=;
        b=jEzdpxSlVNCqPz11ksgrkJmvlKRkm3mqtJydmQxJUagELbB1uXPHaNPlFJNwD6hOdC
         T431R4GgO09dbAo3bWx+BmKS4aHx1dmpGzd67udfHB5eEZUEAgUjdrJPUrkIN+CmNT3C
         HukZrcrF1fhyDUWL35OQ0fAT9D1GSMB52KHe/d7rIaIuad9doG/g4z+Yvp1tCMtPEia0
         sdk69WxM0vm8sxK3STSnCtUlsHQN2n8mn8m4uruEQTVUIVPKyTN9B9Fs70VS+FFA7d8e
         3RRvvZ5cicvbqjFluj7r73i/iRWIzRt3ZAaGvKA47nvFZB87xOv6R2GRYwF9xgC9ONgh
         kKOA==
X-Forwarded-Encrypted: i=1; AJvYcCWJQMZeyeKOahdJmcr7Z9OTKmwpG2bv7zkerwVWVSNnxTyysXqnXA5BsCzVfCdtUEUJuDZxIC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4SNxnu/8nlEUV7kHvRDixClHIRRR1y9pKXdEx/FZqA4NUHBx
	slxJM8hxWtSA3Gg1d2s+/6VIyGNVGWlGIj/7EV3PxsAUftyyXy5/G/HaUn2xRp5Gb4h4aDoA0lZ
	p77YX
X-Gm-Gg: ASbGnct9s+99TIOGokMTWKupwbbw9Xfl9LUM+ioKIhHgV7JyztBXZq02QE+3DNzZSey
	4EJKtLsLgsYrNSnqZQGiOcoqzi9cQZNUeu9GEr37A0ZinAzMjkcTDrMdEqvdyokCy9HNyxSpInI
	/mPdJXG4faAsjVO6Y0DG/5lKvdyvhMrn5MvzeucMPO0ycstDDSDSSTHQrxu0shqBv0wp6redpPs
	5a7xKUDQbksun96CW+O104S2Nh9b8yZOAErZx70Zk4DbKQHaTAASSuoiGuTFkWBpQikgGh7LciT
	X8A5F8e7Hg4ohtBytmj6tMl4coVp0O3FP3teFMLq/uP5nDOMSBHoGy5vpsQHRKCfy/0rUL/5ZUq
	MHLoPzf7lJ9zEgsKHBfwwMF8s/GZ5alt+prQMIkyfBUYtH0+vU17rx3IzTqTBwmIws7SSApI7k6
	q/G+8t
X-Google-Smtp-Source: AGHT+IEtEFvWcLO6E9GmCBdF7ZBWCA82Tdabn+lM4i6RpKroYtOEwhGKJygFSZ3BPy7FyP8Vl01SKA==
X-Received: by 2002:a05:6a20:3d82:b0:351:2c6e:6246 with SMTP id adf61e73a8af0-353a3d56f88mr9293427637.56.1762743545729;
        Sun, 09 Nov 2025 18:59:05 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901c39ea7sm11049805a12.29.2025.11.09.18.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 18:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkg4oCY?=
 =?utf-8?b?Y29uc3Qgc3RydWN0IHRlZ3JhX2Z1c2Vfc29j4oCZIGhhcyBubyBtZW1iZXIgbmFt?=
 =?utf-8?b?ZWQg4oCYY2VsbHPigJkgaW4gZHJpdmUuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Nov 2025 02:59:04 -0000
Message-ID: <176274354463.6253.3611595335613891041@efdf33580483>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 ‘const struct tegra_fuse_soc’ has no member named ‘cells’ in drivers/soc/tegra/fuse/fuse-tegra30.o (drivers/soc/tegra/fuse/fuse-tegra30.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:6abedb19b871dac4b61a07d88d90f7de4e602a72
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d459aad20d6c5313821adefc1671301ae1c27729



Log excerpt:
=====================================================
drivers/soc/tegra/fuse/fuse-tegra30.c:250:10: error: ‘const struct tegra_fuse_soc’ has no member named ‘cells’
  250 |         .cells = tegra114_fuse_cells,
      |          ^~~~~
drivers/soc/tegra/fuse/fuse-tegra30.c:250:18: error: initialization of ‘const struct attribute_group *’ from incompatible pointer type ‘const struct nvmem_cell_info *’ [-Werror=incompatible-pointer-types]
  250 |         .cells = tegra114_fuse_cells,
      |                  ^~~~~~~~~~~~~~~~~~~
drivers/soc/tegra/fuse/fuse-tegra30.c:250:18: note: (near initialization for ‘tegra114_fuse_soc.soc_attr_group’)
drivers/soc/tegra/fuse/fuse-tegra30.c:251:10: error: ‘const struct tegra_fuse_soc’ has no member named ‘num_cells’
  251 |         .num_cells = ARRAY_SIZE(tegra114_fuse_cells),
      |          ^~~~~~~~~
In file included from ./include/asm-generic/bug.h:20,
                 from ./arch/arm/include/asm/bug.h:60,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from ./include/linux/ratelimit.h:6,
                 from ./include/linux/dev_printk.h:16,
                 from ./include/linux/device.h:15,
                 from drivers/soc/tegra/fuse/fuse-tegra30.c:6:
./include/linux/kernel.h:49:25: warning: excess elements in struct initializer
   49 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      |                         ^
drivers/soc/tegra/fuse/fuse-tegra30.c:251:22: note: in expansion of macro ‘ARRAY_SIZE’
  251 |         .num_cells = ARRAY_SIZE(tegra114_fuse_cells),
      |                      ^~~~~~~~~~
./include/linux/kernel.h:49:25: note: (near initialization for ‘tegra114_fuse_soc’)
   49 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      |                         ^
drivers/soc/tegra/fuse/fuse-tegra30.c:251:22: note: in expansion of macro ‘ARRAY_SIZE’
  251 |         .num_cells = ARRAY_SIZE(tegra114_fuse_cells),
      |                      ^~~~~~~~~~
  CC      lib/kstrtox.o
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-arm-multi_v7_defconfig-69114b2df21f07610dda79ad/.config
- dashboard: https://d.kernelci.org/build/maestro:69114b2df21f07610dda79ad


#kernelci issue maestro:6abedb19b871dac4b61a07d88d90f7de4e602a72

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

