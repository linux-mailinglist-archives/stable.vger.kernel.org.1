Return-Path: <stable+bounces-75730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20639974106
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9801C2547A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4182195FEF;
	Tue, 10 Sep 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l61a+BAc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CB1A2854
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990551; cv=none; b=OndYAG8C83umL9xJCMJhs2QRpzMrdWkPTm0HtQNmQoMZVlO4qFRAVIHNov1yeHEXEHFhuYDCVyUplCMuG2usKKfqAKiOewAY22UTU8E60Sx0ACxaXC7TLbi35FTFzjV8AvTQVgzDCib+0NX36gnYVcIp2oyasVblkHmQlRWG7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990551; c=relaxed/simple;
	bh=8r6/Z7cYCZt0C2pPNRt5red4H6C/cN0pEDVkXGwQVxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dydmhvpFvj2giy7daUKkbjmo9rYOdJ7/5fQr05Tl/Qe9WwtbNCXaDqB/SSpj00X7un+RYCZe7qwe/XibKp5HqFjhhEctiTFHBhs0NSdDyUKhQ3+zkTrSrPkaT8DKEVtdc+qGLG6ibzxWPW6j5LvrNQhd7BRL9mRoPZvQS53IW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l61a+BAc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718816be6cbso4099196b3a.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725990549; x=1726595349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjTGqVxL/lXZ4Xq5oA9wMyb/w66vC8I8vd+hq2N9dLc=;
        b=l61a+BAcMfl0ZI8RYMQZQ215fOi2LNlR9Zt0CXTonGtcLzgEhaLy4alvQa/3dLAmfp
         IKM1QFkrT4W8igkhrMb0dc4vx6z84RJu17nMk6qbNKIX1O27yVbaEBklvQwQrj9T6u45
         ins597PHcm3sldWKMslfHbU+1xR+0oZuMuzZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990549; x=1726595349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjTGqVxL/lXZ4Xq5oA9wMyb/w66vC8I8vd+hq2N9dLc=;
        b=iUdRoNzW9m8xSgOL4u8P7HjIesIKxk1QI2XSHWy/FheGW3t03o+OgPVflw2xxcfyLL
         QV8nrxvK3CvHETF/rd55FtYvTc0Ok6sJbFkFVoS5apoHeX9+1dWXoPETJ+l/IoF6vLsu
         b3RW3hQOBPwHUSJO86D+kM8G4u/WeGWbtoceCuSmFesufHXDXaGj0k7nfnY8OsKf+kYb
         DcR2tDvzgiZKixBkLb8G5c5Nbxb0uzLXmU4Di6L+o25pQGfaetL53ZkgFFVZ0BHAaojT
         ovtIHk0seuBANJbhSHwVAqEABlt+7xF1yIuzQRjklUWZ/gHtLjAuaxeZzYvHi7IPAiG9
         m8/g==
X-Forwarded-Encrypted: i=1; AJvYcCW8ei7zvylok9z8DjBaQQ2yVrxJBT745YBVRyUMO/k7NcxO5VG7HaFisIcXOn3CDSY5labCYX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcF0NcDvzOmqzgrTLEOG1J+RtwKXTTN72IbLD+tL14pvj0a9J
	LO2Wa+m9GKYJBIUq8vBkpK4JuI+0E9RCc/MDfLOMT8QFIJn+SPk0wJX/Gh6AVw==
X-Google-Smtp-Source: AGHT+IH7ewLbjt6vpK16Q9MSvs4t2UHHLsqVCiuJv68f8tihw1AECgjvOqgbtRKJbxklGND7j0FnJg==
X-Received: by 2002:a05:6a21:6481:b0:1cf:37bd:b553 with SMTP id adf61e73a8af0-1cf5e1ab920mr1717836637.46.1725990549167;
        Tue, 10 Sep 2024 10:49:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:a9f8:b780:a61c:6acb])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20710f3229esm51179035ad.268.2024.09.10.10.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:49:08 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:49:06 -0700
From: Brian Norris <briannorris@chromium.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Hugues Bruant <hugues.bruant@gmail.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [NOT A REGRESSION] firmware: framebuffer-coreboot: duplicate device
 name "simple-framebuffer.0"
Message-ID: <ZuCGkjoxKxpnhEh6@google.com>
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local>

(Tweaking subject; this indeed isn't related to the regression at all)

Hi,

On Mon, Sep 09, 2024 at 10:02:00AM +0200, Borislav Petkov wrote:
> Looking at your log, the first warn is in framebuffer_coreboot. Some mess in
> the sysfs platform devices registration.
> 
> Adding the relevant people for that:
> 
> Aug 20 20:29:36 luna kernel: sysfs: cannot create duplicate filename '/bus/platform/devices/simple-framebuffer.0'
> Aug 20 20:29:36 luna kernel: CPU: 5 PID: 571 Comm: (udev-worker) Tainted: G           OE      6.10.6-arch1-1 #1 703d152c24f1971e36f16e505405e456fc9e23f8
> Aug 20 20:29:36 luna kernel: Hardware name: Purism Librem 14/Librem 14, BIOS 4.14-Purism-1 06/18/2021
> Aug 20 20:29:36 luna kernel: Call Trace:
> Aug 20 20:29:36 luna kernel:  <TASK>
> Aug 20 20:29:36 luna kernel:  dump_stack_lvl+0x5d/0x80
> Aug 20 20:29:36 luna kernel:  sysfs_warn_dup.cold+0x17/0x23
> Aug 20 20:29:36 luna kernel:  sysfs_do_create_link_sd+0xcf/0xe0
> Aug 20 20:29:36 luna kernel:  bus_add_device+0x6b/0x130
> Aug 20 20:29:36 luna kernel:  device_add+0x3b3/0x870
> Aug 20 20:29:36 luna kernel:  platform_device_add+0xed/0x250
> Aug 20 20:29:36 luna kernel:  platform_device_register_full+0xbb/0x140
> Aug 20 20:29:36 luna kernel:  platform_device_register_resndata.constprop.0+0x54/0x80 [framebuffer_coreboot a587d2fc243ebaa0205c3badd33442a004d284e0]
> Aug 20 20:29:36 luna kernel:  framebuffer_probe+0x165/0x1b0 [framebuffer_coreboot a587d2fc243ebaa0205c3badd33442a004d284e0]
> Aug 20 20:29:36 luna kernel:  really_probe+0xdb/0x340
> Aug 20 20:29:36 luna kernel:  ? pm_runtime_barrier+0x54/0x90
> Aug 20 20:29:36 luna kernel:  ? __pfx___driver_attach+0x10/0x10
> Aug 20 20:29:36 luna kernel:  __driver_probe_device+0x78/0x110
> Aug 20 20:29:36 luna kernel:  driver_probe_device+0x1f/0xa0
> Aug 20 20:29:36 luna kernel:  __driver_attach+0xba/0x1c0
> Aug 20 20:29:36 luna kernel:  bus_for_each_dev+0x8c/0xe0
> Aug 20 20:29:36 luna kernel:  bus_add_driver+0x112/0x1f0
> Aug 20 20:29:36 luna kernel:  driver_register+0x72/0xd0
> Aug 20 20:29:36 luna kernel:  ? __pfx_framebuffer_driver_init+0x10/0x10 [framebuffer_coreboot a587d2fc243ebaa0205c3badd33442a004d284e0]
> Aug 20 20:29:36 luna kernel:  do_one_initcall+0x58/0x310
> Aug 20 20:29:36 luna kernel:  do_init_module+0x60/0x220
> Aug 20 20:29:36 luna kernel:  init_module_from_file+0x89/0xe0
> Aug 20 20:29:36 luna kernel:  idempotent_init_module+0x121/0x320
> Aug 20 20:29:36 luna kernel:  __x64_sys_finit_module+0x5e/0xb0
> Aug 20 20:29:36 luna kernel:  do_syscall_64+0x82/0x190
> Aug 20 20:29:36 luna kernel:  ? __do_sys_newfstatat+0x3c/0x80
> Aug 20 20:29:36 luna kernel:  ? syscall_exit_to_user_mode+0x72/0x200
> Aug 20 20:29:36 luna kernel:  ? do_syscall_64+0x8e/0x190
> Aug 20 20:29:36 luna kernel:  ? do_sys_openat2+0x9c/0xe0
> Aug 20 20:29:36 luna kernel:  ? syscall_exit_to_user_mode+0x72/0x200
> Aug 20 20:29:36 luna kernel:  ? do_syscall_64+0x8e/0x190
> Aug 20 20:29:36 luna kernel:  ? clear_bhb_loop+0x25/0x80
> Aug 20 20:29:36 luna kernel:  ? clear_bhb_loop+0x25/0x80
> Aug 20 20:29:36 luna kernel:  ? clear_bhb_loop+0x25/0x80
> Aug 20 20:29:36 luna kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Aug 20 20:29:36 luna kernel: RIP: 0033:0x7b1bee2f81fd

Looks like it might be a conflict with
drivers/firmware/sysfb_simplefb.c, which also uses the
"simple-framebuffer" name with a constant ID of 0. It's possible both
drivers should be switched to use PLATFORM_DEVID_AUTO? Or at least one
of them. Or they should use different base names.

I'm not really sure what the best option is (does anyone rely on or care
about the device naming?), and I don't actually use this driver. But
here's an untested diff to try if you'd really like. If you test it,
feel free to submit as a proper patch with my:

Signed-off-by: Brian Norris <briannorris@chromium.org>

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index daadd71d8ddd..3f1b8f664c3f 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -62,7 +62,8 @@ static int framebuffer_probe(struct coreboot_device *dev)
 		return -EINVAL;
 
 	pdev = platform_device_register_resndata(&dev->dev,
-						 "simple-framebuffer", 0,
+						 "simple-framebuffer",
+						 PLATFORM_DEVID_AUTO,
 						 &res, 1, &pdata,
 						 sizeof(pdata));
 	if (IS_ERR(pdev))

