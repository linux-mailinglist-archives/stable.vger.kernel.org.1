Return-Path: <stable+bounces-183299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556DBB7A2B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61CE94EC5FA
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C912C21D4;
	Fri,  3 Oct 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0tOTuiPE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711B26E706
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510748; cv=none; b=q3+S1TdKipupipvkfPDXEYIRBV9Q4sjaErCDwQIDEdPW1vOn7xI8eQUPAxKVuwHhhN91J58/mNhQS0uLXt6Q4hS6W0+1m+m3aL8zlewM/7qOnaQ146SmD156vYKXuWj4gVpQtnNEaP0UJyVGNMUarxPitbmUmIq9D0fGyQaCn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510748; c=relaxed/simple;
	bh=qN88UNW+Zvp7fI0g+q45ph+xQERUi8+EWblZrRIyMZQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=d/mSoiKjDqRQfYBsfBHiHijh0lVfDTQ105OEDMoxoJOfb1ks/WCHhmqoOK1udwDFq3p1K4epVFZOA/8wticPQ2y757HaB/G8ePX18YlnGheKHT92UaCoGORAAovFEVnz/znWxEX5j/4DbSUACKbmPxUukMvdqAO6iLE6cZOJFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0tOTuiPE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2680cf68265so18354515ad.2
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1759510745; x=1760115545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWa56QJ63YV8qd/PV5qaFs9n0mrt68Fr5yauXNrBRm4=;
        b=0tOTuiPEgsVM0xrubm0qW9kSzSUoEPawviyFWwNgzrfhV3XA/0gdWmYWoeHhLgjCH6
         OhUo6nrpWX2DjqwwUROuBXVEhcKYR+P0yVldKCPw7T0UfL2XGM3Om6yTL+CMkxhwbMxp
         bAJPR2and+ydFsEYNOhhvhysfu68JPFePyEFITwKCJDvALnDyq1H46/m4jeL7AJgvFvL
         G0fFQac6dykztZEVMHTqJwhEXDNifw+r0ffYWcMltL8V3bfAzhFqentRoyHUNzJ087C4
         MmTrGJwb6IHGM0xVmmEndnsWLf8TI9T7uFM8MXLUA7x6fsIU6haczwKrTnPAOxe/UKAl
         TIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510745; x=1760115545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWa56QJ63YV8qd/PV5qaFs9n0mrt68Fr5yauXNrBRm4=;
        b=HRYMBvBMx0atXRjMr4ucjRFR1uz1kO+ujFDaQi52wL6yPpE6/GFzHTUegtB/R7lonz
         IZSMSjEZ511WQ/Nse6gMd6vzeviz438/rWnaCBqZOAqS3DJqYwVJ3KCfs4NTCKpoZYzc
         O64JLltpZ6lnUflEcXEU5nST0Lq7haGAOgpCQYpayi9dyMv+/yOa4Obvgy4PLfdYJ1ax
         rWF0Yp9ThTzvR4aan9kkvL9ojIBx81+k5MmRvKty+5Tgt5DRCoMrdA9MyX0xw7f0IJZd
         oiFuLNtHAQf/5BAKa9T70Xg6TYneWjdpOzKh0G97Ze2lCzhFbncMMdkED1X8aJ9D675x
         xpcg==
X-Forwarded-Encrypted: i=1; AJvYcCXjdHgiya/q1DruMza1m/fNhhKAFGhETFgNW5vwzZR7evUsaqy2Z4FQhVkQfV2XqDx/opxaH0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI66K22kkesFdT5drybb1BV9w9va66UqzMFRcMt9jN2UVzMCBc
	4w9ENNh5wTk3bc7aCrJZxSVoI4Ty8dI0ZhWuuoKBbXSosSZaMh+32aKqjNlEpYHCprE5d3FyV2W
	NQgSvDBQ=
X-Gm-Gg: ASbGncvES5QsFUM+lL9JD/r7Enw3C5sTRn/apt9CGxeUxFs45CJeaVmCZ+qvCmdNMZM
	KcHEGDlG7Iwo4u7SzBczkM0FfqBJfowSI+bdEa5ASgGv++Hrmom2hKYWAEInPzo1yQ9Fgygwki4
	5spjpYQDRx2cEQ7EyJ/SLC9/CM5nj8UicFr4CM6AXqmQd4A9BOjCgEy9sNOpX4yEjT8pRBmDpid
	0OmSvwSuOL3uWNMHsKJQtWzm7bjBFzXFIS8xd3qv2xcVrxx8SHhmFIqlXpbCUwWWXuR5aTs1D+7
	Q5FjogGJSmzXDsL8Y+rpLFUnBV/pniZyU+zGBivI68V/9x5ZBMQk6jNxjusjgSYUbByEbJCu3Dl
	abRFIjvEz5r4Aj++xzI4YZF0aarvjE6FAMA8AwAPn
X-Google-Smtp-Source: AGHT+IFxvqULGwLzaC1vY6Bri+0Rl0k3g2SicfytaznK8ltRfpLFIfDAdUe2GWqvENp/NR4setuAhg==
X-Received: by 2002:a17:902:e5d0:b0:282:2c52:5094 with SMTP id d9443c01a7336-28e9a61abb2mr41359015ad.37.1759510744668;
        Fri, 03 Oct 2025 09:59:04 -0700 (PDT)
Received: from c325b7c58cb6 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d00csm8706133a91.6.2025.10.03.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:59:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjQueTogKGJ1aWxkKSAuL2Fy?=
 =?utf-8?b?Y2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5Lmg6ODU6NTA6IGVycm9yOiDigJhL?=
 =?utf-8?b?QVNBTl9TSEFET1dfU0NBTC4uLg==?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 03 Oct 2025 16:59:03 -0000
Message-ID: <175951074325.374.10838912080762882041@c325b7c58cb6>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 ./arch/arm64/include/asm/memory.h:85:50: error: ‘KASAN_SHADOW_SCALE_SHIFT’ undeclared (first use in this function) in arch/arm64/kernel/vdso32/vgettimeofday.o (arch/arm64/kernel/vdso32/Makefile:166) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:35fc997ccf1864d670c66eb7815463e470fe1fa9
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2c0548712531f8b879edccf67949a8e5abe4e5e4



Log excerpt:
=====================================================
  CC32    arch/arm64/kernel/vdso32/vgettimeofday.o
  AS32    arch/arm64/kernel/vdso32/sigreturn.o
  HOSTCC  arch/arm64/kernel/vdso32/../../../arm/vdso/vdsomunge
In file included from ./arch/arm64/include/asm/thread_info.h:17,
                 from ./include/linux/thread_info.h:39,
                 from ./arch/arm64/include/asm/preempt.h:5,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from /tmp/kci/linux/lib/vdso/gettimeofday.c:7,
                 from <command-line>:
./arch/arm64/include/asm/memory.h: In function ‘kaslr_offset’:
./arch/arm64/include/asm/memory.h:85:50: error: ‘KASAN_SHADOW_SCALE_SHIFT’ undeclared (first use in this function)
   85 | #define KASAN_SHADOW_END        ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
      |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:50:34: note: in expansion of macro ‘KASAN_SHADOW_END’
   50 | #define BPF_JIT_REGION_START    (KASAN_SHADOW_END)
      |                                  ^~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:52:34: note: in expansion of macro ‘BPF_JIT_REGION_START’
   52 | #define BPF_JIT_REGION_END      (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
      |                                  ^~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:54:34: note: in expansion of macro ‘BPF_JIT_REGION_END’
   54 | #define MODULES_VADDR           (BPF_JIT_REGION_END)
      |                                  ^~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:53:34: note: in expansion of macro ‘MODULES_VADDR’
   53 | #define MODULES_END             (MODULES_VADDR + MODULES_VSIZE)
      |                                  ^~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:49:34: note: in expansion of macro ‘MODULES_END’
   49 | #define KIMAGE_VADDR            (MODULES_END)
      |                                  ^~~~~~~~~~~
./arch/arm64/include/asm/memory.h:193:31: note: in expansion of macro ‘KIMAGE_VADDR’
  193 |         return kimage_vaddr - KIMAGE_VADDR;
      |                               ^~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:85:50: note: each undeclared identifier is reported only once for each function it appears in
   85 | #define KASAN_SHADOW_END        ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
      |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:50:34: note: in expansion of macro ‘KASAN_SHADOW_END’
   50 | #define BPF_JIT_REGION_START    (KASAN_SHADOW_END)
      |                                  ^~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:52:34: note: in expansion of macro ‘BPF_JIT_REGION_START’
   52 | #define BPF_JIT_REGION_END      (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
      |                                  ^~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:54:34: note: in expansion of macro ‘BPF_JIT_REGION_END’
   54 | #define MODULES_VADDR           (BPF_JIT_REGION_END)
      |                                  ^~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:53:34: note: in expansion of macro ‘MODULES_VADDR’
   53 | #define MODULES_END             (MODULES_VADDR + MODULES_VSIZE)
      |                                  ^~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:49:34: note: in expansion of macro ‘MODULES_END’
   49 | #define KIMAGE_VADDR            (MODULES_END)
      |                                  ^~~~~~~~~~~
./arch/arm64/include/asm/memory.h:193:31: note: in expansion of macro ‘KIMAGE_VADDR’
  193 |         return kimage_vaddr - KIMAGE_VADDR;
      |                               ^~~~~~~~~~~~
./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
./arch/arm64/include/asm/memory.h:238:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  238 |         u64 __addr = (u64)addr & ~__tag_shifted(0xff);
      |                      ^
In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8,
                 from ./arch/arm64/include/asm/processor.h:34,
                 from ./arch/arm64/include/asm/elf.h:118,
                 from ./include/linux/elf.h:5,
                 from ./include/linux/elfnote.h:62,
                 from arch/arm64/kernel/vdso32/note.c:11:
./arch/arm64/include/asm/memory.h: In function ‘kaslr_offset’:
./arch/arm64/include/asm/memory.h:85:50: error: ‘KASAN_SHADOW_SCALE_SHIFT’ undeclared (first use in this function)
   85 | #define KASAN_SHADOW_END        ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
      |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:50:34: note: in expansion of macro ‘KASAN_SHADOW_END’
   50 | #define BPF_JIT_REGION_START    (KASAN_SHADOW_END)
      |                                  ^~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:52:34: note: in expansion of macro ‘BPF_JIT_REGION_START’
   52 | #define BPF_JIT_REGION_END      (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
      |                                  ^~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:54:34: note: in expansion of macro ‘BPF_JIT_REGION_END’
   54 | #define MODULES_VADDR           (BPF_JIT_REGION_END)
      |                                  ^~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:53:34: note: in expansion of macro ‘MODULES_VADDR’
   53 | #define MODULES_END             (MODULES_VADDR + MODULES_VSIZE)
      |                                  ^~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:49:34: note: in expansion of macro ‘MODULES_END’
   49 | #define KIMAGE_VADDR            (MODULES_END)
      |                                  ^~~~~~~~~~~
./arch/arm64/include/asm/memory.h:193:31: note: in expansion of macro ‘KIMAGE_VADDR’
  193 |         return kimage_vaddr - KIMAGE_VADDR;
      |                               ^~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:85:50: note: each undeclared identifier is reported only once for each function it appears in
   85 | #define KASAN_SHADOW_END        ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT)) \
      |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:50:34: note: in expansion of macro ‘KASAN_SHADOW_END’
   50 | #define BPF_JIT_REGION_START    (KASAN_SHADOW_END)
      |                                  ^~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:52:34: note: in expansion of macro ‘BPF_JIT_REGION_START’
   52 | #define BPF_JIT_REGION_END      (BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
      |                                  ^~~~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:54:34: note: in expansion of macro ‘BPF_JIT_REGION_END’
   54 | #define MODULES_VADDR           (BPF_JIT_REGION_END)
      |                                  ^~~~~~~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:53:34: note: in expansion of macro ‘MODULES_VADDR’
   53 | #define MODULES_END             (MODULES_VADDR + MODULES_VSIZE)
      |                                  ^~~~~~~~~~~~~
./arch/arm64/include/asm/memory.h:49:34: note: in expansion of macro ‘MODULES_END’
   49 | #define KIMAGE_VADDR            (MODULES_END)
      |                                  ^~~~~~~~~~~
./arch/arm64/include/asm/memory.h:193:31: note: in expansion of macro ‘KIMAGE_VADDR’
  193 |         return kimage_vaddr - KIMAGE_VADDR;
      |                               ^~~~~~~~~~~~
./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
./arch/arm64/include/asm/memory.h:238:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  238 |         u64 __addr = (u64)addr & ~__tag_shifted(0xff);
      |                      ^

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68dffa7e841b167e8d3e0d0c


#kernelci issue maestro:35fc997ccf1864d670c66eb7815463e470fe1fa9

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

