Return-Path: <stable+bounces-121735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEDA59B93
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EC9188BB71
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3423370F;
	Mon, 10 Mar 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="z/VNY1BF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DC237713
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625259; cv=none; b=rHrs4G4zOVnLreuSHFrfSq29+zTTZ1Ogm9RVCgaQznTJqm7YJy/+Y7qhe8eoYYijHYKbbHvdMcZcKeP+Veen8OJHf18uDAMDFjXa4DIOb83TuhT5VdvBUMQ84YVs1DsiBEsSS6WEegbopy4FbvFI8/dqzU6dUkEorFhc5pPs52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625259; c=relaxed/simple;
	bh=HqST2w0lX/kCIU/Zf25TPgyVO9kmpfi8S3Gqnw/AiLM=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=YFPrOorlmyN7oKMQU75lSRX+serNSP5ZkImfoeQHYanK6rO9NLF6OM7t9dWCpHLxksXuUrEaj/VuKO6X+MwcRKm8+PVlJRUzMf2GyQ6js6yV47KNQEldopjv0/UMcrrtOFJfK86mJnGp/9s92vTQ38g1ZJD/XFViReJPo7Ez+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=z/VNY1BF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f679788fd1so34601067b3.2
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741625256; x=1742230056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P5TQgCM5WaqI8gM8gs7vrrrxXctXmbTbBQ+Boc6KU8=;
        b=z/VNY1BFlB7xrQZnw9Jxm3NJGvIRyJxU1JoQzSqdLddye5Unc0AG7+GDJHksz0ojCf
         eaQOvbHh/0d7EhG6LHpjH2c0dN97ZahSlKh9XH4NovryZ5gfoNge4S7D5adHsspOmiNj
         lssCsSWF92MNr3Bqyqj28JE35AUjk6XldVkGrrHY91JRGwgP4MXOSSimd6KRH2KJ0o6v
         NhrKy4Org7ag4+T0sHHJY3+rjEh/FSU65Vt91niDWnI+daLiquGJNXAJ5l5eLk+tFZgS
         z8VDVZmwUqLcR2aWJ2zy6dXxJ4+t4KQCGfXgh+n7oyIOZ+N8jxKy4o/pY22lx5dk/OHj
         dodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625256; x=1742230056;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P5TQgCM5WaqI8gM8gs7vrrrxXctXmbTbBQ+Boc6KU8=;
        b=KZugoCHZd3KzLU7RY4XXvG9XnyawC7abfg9vzvfb/R21/zv7sw9QC4bUrO2pSuKP94
         LtN38XxwtRd9h/63STwFNsclkFSeLTkpwOxOrxIOxyoMwTKcHWgvXAzqDncU9jiI61h4
         ewN5DXg8rdy0UrxBql+tDFmqgtZQZJJ+dJuEfgXpA3GpR+2eNeailIwq7cCF65lZLEpm
         WBz7ztNsT+Teul9Tlk3RGv/wYtlPBskROM+zoLgKxgjzhN8336q6t2RY+HQWimuozHtL
         MtCD+qWijOt/uLioR1OfGW01h0SrT93aYBEv4PocrNdZ7pz3HrVATeaJDQUYWdJFE6AP
         vxrw==
X-Forwarded-Encrypted: i=1; AJvYcCWF1HCX5HBSLOe6p4DGDEUUmh+4ElH5PARN5tgnDaZfZLftKziTbBrnKjm5jzdnj+hAGd0wHTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeKbFMESPnkyW1b0mStr3DfxGYU4I1x2/gM5PmzXOlsjGP8zu
	nJQvRcalB4PjCTPwWvtrr6hu7yhIdI7PcQ66YMZ+RaCHxFEiWSRKownuXdnUza45WtExAWLNTvQ
	Xjjh14UzvCGkOQsqMl5q5WCY+q3LKvolvw4J/eM5nPkz2Y+hHA7o=
X-Gm-Gg: ASbGncs415VtRLQBw8uS3WjLGeJTvS78H6JLnK1hfMjJnIlJ5phD+4dT60QsFOn92ll
	PuGAfifHwgJUfQTxhUONEt5r6pYhDYC5IuqR/CPAwJ5j5vjYX/e8hoHmUfKZAvmpyX6M3AHWdUJ
	yJABCdUpunAg7Y3+0sbSjXAssIb1r2rFFqHnAeH2keFuJVNjNpWdlYljEAesM=
X-Google-Smtp-Source: AGHT+IGUaxGAAI6f0jI5vMwub7uZyG28IT+P91yfIgk9a/1a8i5HqXDDQ9zNromX9M454wDQTuhbqo2GokOAuFjRSeI=
X-Received: by 2002:a05:690c:6c0f:b0:6fd:4660:1541 with SMTP id
 00721157ae682-6ff09199f78mr9151727b3.5.1741625256670; Mon, 10 Mar 2025
 09:47:36 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 12:47:35 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Mar 2025 12:47:35 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Mar 2025 12:47:35 -0400
X-Gm-Features: AQ5f1JrAbuEq84u-tXUFdUgWbOtqDYuZiRU3cehNPpLaQNXyCmdXEC-sip48nV8
Message-ID: <CACo-S-2XC91dM-DoBqjox_ug6WQh26ZErENfSLh6XnXSiv4fQQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) +arch/x86/events/amd/../perf_event.h:855:21:
 error: invalid output...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 +arch/x86/events/amd/../perf_event.h:855:21: error: invalid output
size for constraint '=q' in arch/x86/events/amd/core.o
(arch/x86/events/amd/core.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:d36536187d181e0823b2aa631ebf9936dd657c55
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  888d41479bea1f83b835311f71a91f5e08f6c4d7


Log excerpt:
=====================================================
In file included from arch/x86/events/amd/core.c:12:
+arch/x86/events/amd/../perf_event.h:855:21: error: invalid output
size for constraint '=q'
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
  446 |         raw_cpu_read(pcp);
         \
      |         ^
./include/linux/percpu-defs.h:420:28:.. note: expanded from macro 'raw_cpu_read'
  420 | #define raw_cpu_read(pcp)
__pcpu_size_call_return(raw_cpu_read_, pcp)
      |                                         ^
./include/linux/percpu-defs.h:323:23: note: expanded from macro
'__pcpu_size_call_return'
  323 |         case 4: pscr_ret__ = stem##4(variable); break;
         \
      |                              ^
<scratch space>:85:1: note: expanded from here
   85 | raw_cpu_read_4
      | ^
./arch/x86/include/asm/percpu.h:396:30: note: expanded from macro
'raw_cpu_read_4'
  396 | #define raw_cpu_read_4(pcp)             percpu_from_op(, "mov", pcp)
      |                                         ^
./arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
  189 |                     : "=q" (pfo_ret__)                  \
      |                             ^
....+.  HDRTEST usr/include/sound/sof/tokens.h
.  AR      init/built-in.a
..........6 errors generated.
....+.....
=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67ceff2318018371957eaf29


#kernelci issue maestro:d36536187d181e0823b2aa631ebf9936dd657c55

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

