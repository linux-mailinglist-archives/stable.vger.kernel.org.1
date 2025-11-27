Return-Path: <stable+bounces-197510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E347EC8F6B6
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD1D3B16A1
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87F337B9E;
	Thu, 27 Nov 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="clsmRiOm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806C3375D1
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259148; cv=none; b=ke0H0oODqV2gmdJ2sFvvEoBt5Fdv+D+dAl63WVP0O56QrjKhVMv/fWO4HcOuL8rRsKkaElVbsMV3OK+eGhQ7rnexsldmza7BzF1+nppIKkn1ZET199HMN84EXnVcYng+VG8llh4UGdzjQFiEs/G5dZZq7T89FA/MOq2VCiJaEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259148; c=relaxed/simple;
	bh=MeVJTDRqvix+fjpFfN8qVq5tgECkcOd6ZQmgrol0Li0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Kb81YpkrxgDr95uXQZA/6/eK66iMqcVM3JwBoM/lMr/3oteeirEjo6NPLUA9IFSbocBIFQkhEPO7kYhi71vgjKUkmhGyrRNSB2a9lpRVvIrPegsooJ1qLohnh1WtJRV+MF4SPZX3K64lJTGha6+IJbM4XRqAKKOuuOFmGc3Us2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=clsmRiOm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so1184446b3a.0
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 07:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764259146; x=1764863946; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/o3ib3A95R0MnlS/jlAhMyOQzuBN0skjKPjxzMlfKY=;
        b=clsmRiOmJbkgy3FQPK3nQBjADzg6lQr2EDWLBKFvVfC10rDgEZCCRB/n7o7i46GKz8
         fEzuz7WPmbf0TA8mIJzB9NJggWk+z/Ct/dLifEqYb29RkwGwSX14YjGVqHq21XQBUKdi
         GV7aVE/pFJ1TW0UNHLiOvR3EQqKp9b4fOLGNqUCs0ZZ9pAP/mFnNqdYxSFt9W5Ii/ije
         TtfYycM2rbq3gkAGVAdJeTpxO1nWEekTTswbFdzkFK7qFiBgWe7Vj7spq3rgFCDP24GG
         6Khk8/kYGMdPcY5EHDDWyf7CJNxNSl9uXZN4ihsGn+M/TzTMYT586tS+cesPgL76KE1b
         eaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259146; x=1764863946;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/o3ib3A95R0MnlS/jlAhMyOQzuBN0skjKPjxzMlfKY=;
        b=i23HNjKDSWhYSCgKcluUhsVxgUJ3/e32nmIBmKEjP/yxR9CN79ypEVkKWk/bkQnpj+
         ybgV/w9G8TLtB5Qoww3AIzx6qz4TMCdRE9zfD37fodSEV066Zl9vjJ9gaPEXuf00NMsr
         kdFcK37R9AWqdstyZBXzsepBAuCmIASiojsasoSSo7V7F/7shvgyG2HwJH0loJzjdQpj
         6ZCW4L70mBc9PFynempB5zw22lQ187EjRgsU0/Ivl6t6ka+11AVlFLTfHsyar2S8QbDw
         1XYYxojF/ELDxaVsVID6VQgzI+ARho2ROb6rL/7y3/jakDMewwQ7Xn1tnolPBNcVxqtj
         1h9g==
X-Forwarded-Encrypted: i=1; AJvYcCUU2QGBwgUqJIzddQhlDdTH5BgIUyMm5Ap1maJhSGLeNhD2e+TvXIXHyCnfaS8jeTnAEN6CzLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGawD5aDTVt3pPyLw0uKaqDQDXlbyyDYKP7HSGSWBqpbqc8bMN
	daoobbGk/vGOl9LzPw6XuIdV+wR+9Iw5zETgBi7SE6YlYe9tRJJiihPJWdmhN+d6hro=
X-Gm-Gg: ASbGnctwwnhYX5LAQeTTPblYXNWsSSCIk2qQFXxwTTFR7GNR5SM/GFqBl0i2SC3TIb2
	3BRTMixMdQoc1xNY0tax6P/ScohM+PCwGBGNWd4LkymOlDSwuT4vT3Xt9U5Bi72kXDyODNI0bNZ
	xacLGPAm7AGGniUt0y8am52Qns2aDuEnEQ79SfgndXfcKqqL3hTFQ+CSl1lJRX2/g0k4oi5EgzF
	z+cbUyKrsClv1QUd3NdHLi8ccmcd2wNMuB+5GD5YugIlhEPxW7+r3JAip9mqtTy3oOQwvnftdYS
	4JhLFkhRXoe56fguxpvu47YgMQF9QK3DlW2uF8wiAWBXzp3eB8kPAnrOYMjCO1IFTq1zUPkJ1Vs
	pmxH1lJBQeAUUXgDfLb3D05m6TXvT8sfuGsmVGQNGQ/VkAhGO+BRTyMJq8h5gO0A+bvw3itdfU/
	jE/v0B
X-Google-Smtp-Source: AGHT+IEAObwOcoc6zJgHKWkkYn3eSwV59uItS1hxvFRoVdpnmhsj4BFGwgv2vc8As+5mnrFEqSb61g==
X-Received: by 2002:a05:7022:2390:b0:11b:2de8:6271 with SMTP id a92af1059eb24-11c9d8635bcmr20156208c88.39.1764259146304;
        Thu, 27 Nov 2025 07:59:06 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm7834694c88.4.2025.11.27.07.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:59:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) GCC does not allow
 variable
 declarations in for loop initializers ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 27 Nov 2025 15:59:05 -0000
Message-ID: <176425914524.933.12037386521228740196@1ece3ece63ba>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 GCC does not allow variable declarations in for loop initializers before C99 [-Wgcc-compat] in mm/mempool.o (mm/mempool.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:edfc0791be4ae7547a2a17054e9cd0317c106f20
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  92a27d160c829ca1d8dd3be92e8e8669620d66d5


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
mm/mempool.c:68:8: warning: GCC does not allow variable declarations in for loop initializers before C99 [-Wgcc-compat]
   68 |                 for (int i = 0; i < (1 << order); i++) {
      |                      ^
mm/mempool.c:70:17: error: implicit declaration of function 'kmap_local_page' [-Werror,-Wimplicit-function-declaration]
   70 |                         void *addr = kmap_local_page(page + i);
      |                                      ^
mm/mempool.c:70:17: note: did you mean 'kmap_to_page'?
./include/linux/highmem.h:124:14: note: 'kmap_to_page' declared here
  124 | struct page *kmap_to_page(void *addr);
      |              ^
mm/mempool.c:70:10: error: incompatible integer to pointer conversion initializing 'void *' with an expression of type 'int' [-Wint-conversion]
   70 |                         void *addr = kmap_local_page(page + i);
      |                               ^      ~~~~~~~~~~~~~~~~~~~~~~~~~
mm/mempool.c:73:4: error: implicit declaration of function 'kunmap_local' [-Werror,-Wimplicit-function-declaration]
   73 |                         kunmap_local(addr);
      |                         ^
mm/mempool.c:101:8: warning: GCC does not allow variable declarations in for loop initializers before C99 [-Wgcc-compat]
  101 |                 for (int i = 0; i < (1 << order); i++) {
      |                      ^
mm/mempool.c:103:17: error: implicit declaration of function 'kmap_local_page' [-Werror,-Wimplicit-function-declaration]
  103 |                         void *addr = kmap_local_page(page + i);
      |                                      ^
mm/mempool.c:103:10: error: incompatible integer to pointer conversion initializing 'void *' with an expression of type 'int' [-Wint-conversion]
  103 |                         void *addr = kmap_local_page(page + i);
      |                               ^      ~~~~~~~~~~~~~~~~~~~~~~~~~
mm/mempool.c:106:4: error: implicit declaration of function 'kunmap_local' [-Werror,-Wimplicit-function-declaration]
  106 |                         kunmap_local(addr);
      |                         ^
  CC      fs/notify/fanotify/fanotify.o
2 warnings and 6 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm-allmodconfig-69286cb5f5b8743b1f65f372/.config
- dashboard: https://d.kernelci.org/build/maestro:69286cb5f5b8743b1f65f372

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-69286ceff5b8743b1f65f3b6/.config
- dashboard: https://d.kernelci.org/build/maestro:69286ceff5b8743b1f65f3b6


#kernelci issue maestro:edfc0791be4ae7547a2a17054e9cd0317c106f20

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

