Return-Path: <stable+bounces-200309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D35CABD91
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 03:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05353003061
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B32765D2;
	Mon,  8 Dec 2025 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ptbXfkjo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DF237713
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161028; cv=none; b=dOKfs+23TCqM28uc+OAi4pG/4W+EIVSvOLSBd3pbd24CGEYxwhTlmK/QXZxB5U9+Cl1E+LEv6mCHUnfuk/X+mVxW111tyTB9UlPExJYVlD+zHrW7Tkhts/HQ7ddwurX7v5R0EDXFP+evR8azRDlcaqp+kwPy0q91viRm+6V6sfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161028; c=relaxed/simple;
	bh=7uDSkqyExjwcNWQ/PLPeXvSEAw5FsqfxxnpUjZkSdjk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=NGjc9sZA2n9LubMs4/k8LH615ecKflSz+uZY0jYHrbPRqw9ygQekA1ZwpJMIubZjta/fvDvQvPflNORprarkoRuT1MSP0DoOTj2jditZtHIpAu22a54WqOujEpquEI+Mcz18HiBlJ96MN3SHPlkdp9jhApPXiszPnajfb2Dm+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ptbXfkjo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso3240930a12.3
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1765161024; x=1765765824; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfXmFf8CeOglbE80PF6aMc8p8AX7IZzZc/bX+BS++Ew=;
        b=ptbXfkjoQbWhQvdsNag49uj2epa7agPpbu9MfVM17MtsRJSzVhMLlFTIAG6b2EGQDd
         Aiv7FMZ+v+Hf/YfWByoYWKcwZ8xr3jlMvKblPu3eDK2TEu9X1mmZGd5IMB7DtB2SClbR
         Rqbp9otbkQrNSd3i050jnLsS85V+jCkmShXl9kWAypssxXpA9C0BvCSx8r5NVN/m4nv7
         jXTdqlNoQkNjFxfTgtyePkE/m0AtEMXFWeTx1hIDD0lO4V6uUpVpgwdaRhmC0x528CUv
         ydgcHfNKInaEUqk2aB1jzd/itqJTKkJ1m7/LqRU8R+UaIIOmoSjGj4IDUBf0rQYruS23
         9tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765161024; x=1765765824;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfXmFf8CeOglbE80PF6aMc8p8AX7IZzZc/bX+BS++Ew=;
        b=e8cd/jiCuNAKoaoRoP9DpoCcZSxAEOxFT8lxOZsR6DIfcnXdPIkVFrkfTKKJS6lPOp
         pTD8tRBj0O4S5U59z0rf9cv/4v1JgBvJxWcIkJqVNylT6nxnUX8PxMd4zC2KgS/M4vlZ
         OufdB5uIVsrceHJoGMPHT2ewH6FYI0Wq2PEuT63lSmZi4Y0BJwPBI3csifIhXoB78uyu
         a+uZBJkeaOq44GSeVY2Bs7R17CmlgT0m/n9iupwq2TY7UgnPY4nvjG/7hvf2yQWWGrWC
         UEXlIQHaTibyjtwTEHXN7Uk3unPZaSfQEZeKRxRVzJuE/L32N6wZrtIKue9BXz+cJsYX
         JrnA==
X-Gm-Message-State: AOJu0YztnbsRcFPWiQbhK4Tly03b6nJBn8i0K5Wz74dgsSLUbNnGZ6dF
	DPhgpsCPCVCSS+xhHKhYxUN7Zwg4i4bNkx1YHuc7CdCXfspY3X6L5oXbj7btzkQWyhg=
X-Gm-Gg: ASbGncsE/EY2mIBYndFPlyNngPDNAtoQUfBpjfzVNDfKPpUOSQ8zD/Q3zBjvFQe8Qjt
	JGdjc0mcuugngXSzV/4zuf58m/YDsH0jdwuTiNUJ03C4pTOgfUI79lYzqwSVK+IeDDmn9O2MYQE
	dS0s9hFSIb5wBNo+azY8K4gXai9y0+pdlJKOzz268LJvkj1C2j12uKUfKAQMWc6UBir1ZHQkRHI
	+lSb+LHyVs32qUPzXZGUIpv7oge4ZUsHWa09I8AYzOF0RemJts7rxydnIN/IujuY9tLsn8wWBwg
	olXAs52OwMZ6+IiO7uRerkB2RRB9+KCHqFSTHgaU2pOmSjDgT3pXKZTRGGW2m95lAAB1vDi5KJQ
	trfVV4kxSiD6ayRbe3pyFMVY2JBKXe15G5idnoFuhuc3TmN2ZvCD9+Jo8q7RB4O/iCs+Z5uEJMK
	lWNxlq
X-Google-Smtp-Source: AGHT+IF9rtk5xZmhjPneqWKkBQxQnShkcWMl2E9sc5lQa31/Z/sAhYnootQaGWwV7oPTS8kNylbKJg==
X-Received: by 2002:a05:7022:621:b0:119:e56b:957e with SMTP id a92af1059eb24-11e0315e298mr5322142c88.3.1765161023696;
        Sun, 07 Dec 2025 18:30:23 -0800 (PST)
Received: from 1ece3ece63ba ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm50629409c88.6.2025.12.07.18.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:30:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 dcbeffaf66d03968970d7d68ec7800032d00180e
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 08 Dec 2025 02:30:22 -0000
Message-ID: <176516102234.6076.10751788859481737203@1ece3ece63ba>





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/dcbeffaf66d03968970d7d68ec7800032d00180e/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: dcbeffaf66d03968970d7d68ec7800032d00180e
origin: maestro
test start time: 2025-12-06 22:05:24.548000+00:00

Builds:	   39 ✅    0 ❌    0 ⚠️
Boots: 	  193 ✅    0 ❌    0 ⚠️
Tests: 	12053 ✅  779 ❌ 3133 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: dell-latitude-5400-4305U-sarien
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq.suspend
      last run: https://d.kernelci.org/test/maestro:6934b9581ca5bf9d0fd66c53
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.suspend.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:6935156f1ca5bf9d0fd7d7ed
      history:  > ✅  > ❌  
            
Hardware: dell-latitude-5400-8665U-sarien
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq.suspend
      last run: https://d.kernelci.org/test/maestro:6934b9591ca5bf9d0fd66c56
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.suspend.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:6934c2821ca5bf9d0fd6a446
      history:  > ✅  > ❌  
            
Hardware: hp-x360-12b-ca0010nr-n4020-octopus
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:6934bc4b1ca5bf9d0fd68a11
      history:  > ✅  > ❌  
            
Hardware: meson-sm1-s905d3-libretech-cc
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.breakpoints
      last run: https://d.kernelci.org/test/maestro:6934b5901ca5bf9d0fd64a44
      history:  > ✅  > ❌  
            
Hardware: sun50i-h5-libretech-all-h3-cc
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.arm64
      last run: https://d.kernelci.org/test/maestro:6934b58e1ca5bf9d0fd64a2a
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8186-corsola-steelix-sku131072
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6934b7ac1ca5bf9d0fd65f2b
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:6934b4f81ca5bf9d0fd6480d
      history:  > ✅  > ❌  > ❌  > ✅  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

