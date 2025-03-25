Return-Path: <stable+bounces-126627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD83A709EA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE22189DE37
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64869191F95;
	Tue, 25 Mar 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="3YxP0m2L"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F4E2E337C
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929148; cv=none; b=gzb0Jjx9n9i9LL6FbpIlzkxhrQL62snIBAgtysarQbb7/zlK0ge2JhYGVnywA3SQVnvjWPbsSsC36vc/91vxlScxw3upMKlUdpmhCFs4dnwjRUNPBUsehytE/Ooxf2Kha2izO5Db+a6eSYw+lhQ4U7l4VNeJMPCLaPwn7ZdaETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929148; c=relaxed/simple;
	bh=VnuhhSvN/At7FWMgh58AC8Qd/Q4W8GU13osVLGRSIMI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=R7H3FH2+i+c9ah5hVYOO/MxHjIhA8Jyp7h7xNYJqH9SNuRGuDtS5JJ+Xp0mhu3G/NJ9AMV5XzrQEl0LVzR8SoRC3JxXl8blKBIfiPxI9puhGuG2JicwJ0qhxfaMjbszhS189MFEgJh0gj3ShV/I0OpOqCCqdoTIOedWuUY6pCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=3YxP0m2L; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff0c9d1761so52241327b3.1
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742929145; x=1743533945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df78XenovYs5FXXSmNxh9W95E0qadF8I6Rm+w5s0ZlI=;
        b=3YxP0m2LSbsRk2MayRUdblLnJo8DHU6+z5DVC5Fdtd9Zbn0Xl07gDBC0zv2gQKGMyM
         8vZ+gIU+GrP6EMufX1UTb7WSqkg1IOm213LdE3rrWv3zQBAGQQ3jZeAsPZi+Ex7d8DGy
         j7/q4voOtyioxhGc1JtqtJ64WhBBNfu+e50pYR6e/iNTpLc94ACHDxDxGnB9bHpFgpT+
         GYLnEXXmmht1gVSeX6zpzv1ftuWLrdX9+dtuUQuj60J7Mlqul48TrbJLVfBk6UyVOZ2F
         YvtOFA/2Q3Cl+ZrYMT8tXfF2IOLoD3FGy+2YHI91N9MYnzELl+KtNL3s2glnXnUyjtSb
         cDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929145; x=1743533945;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=df78XenovYs5FXXSmNxh9W95E0qadF8I6Rm+w5s0ZlI=;
        b=ZZOYNJrCGgD0vRj4tylFKYG3kG4OERLLlbppxnYEg9yUCUC+f8E9Y9MlPMaCyJfeXH
         WUbeI62HLsiaC5DNF50oCL+yoush4YPKSj8tqeJ4h6J4SCw6x2k6YXOGkWUlNHNZYtas
         OV81nn7c7XJre/Gcg2Kiz1Yc3Jb97E3zwg62JmHI9NOhxsGBchPZJx5FZrJ7nR1y58gD
         wM6J/PYUoxbpYb/SjdgfJ2sWBwmIl/Ua1CNHObHx9M3CommTlbfc33tdSrAG8ztfobsZ
         wrPLWlbFE/F+Sd95Z+jxdFP5mDlRgY5gq9JmV3k53bO0tAw+Vpa6+A+O5Ke90EwGOzSb
         domA==
X-Forwarded-Encrypted: i=1; AJvYcCUhiLZty3pIg7kdjqc035vT0+BgGpYf9HOKoEq7+qrME22Lyt+6PpwkMgNZn/DBaZu40kqQlew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87dNTFIJZXb8AgE3kVruCEXr3WcU0x6FAiB8OPCVvkJRpX9xO
	O6jk69OeM1fqg7VwTsd1DVYl97PoyfjdBMFalHEdR04vacCS3dL71wm8rE32u8pZLv0VLq1allc
	Q1vyNTwvpb4nkpBCe/zDyEQP/3tewniWqqQey4qE2xaIipfug
X-Gm-Gg: ASbGncvLOHBt94pC1/CjbXQV7ioTmztP54pM+qtG+QGqhZ+2eLEJz/3i4ao4IY3wsuS
	MlH6jmodk6+6yJxMxuvp+1VK22AEmX1eJxfSulglCbwEKxQAuVGNzw/RBy2fecp/IbeW3/hFzRp
	4U0Gpoq6gToXbxDEmS+ybQpvzE8hqASNixSKs=
X-Google-Smtp-Source: AGHT+IFBrBisEkzSUuvTiYHmHjlWc+96zHVZ8u9LGf6EcyIhYaWygO6WAQJcv3ZOlfJ5wVm1ByeZKdNIdvqEDP5xO4I=
X-Received: by 2002:a05:690c:46c4:b0:6fd:485c:9dd4 with SMTP id
 00721157ae682-700bad00bf3mr240166817b3.32.1742929144741; Tue, 25 Mar 2025
 11:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Mar 2025 11:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Mar 2025 11:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Mar 2025 11:59:03 -0700
X-Gm-Features: AQ5f1JqFHLtAES1vh3sFXv-IKh4_wLHukZhWizk3KzgBTnenUFpdz7zif2s6PgA
Message-ID: <CACo-S-0veyTiK1fD1nuqJiUqXVR1Yg-z7QpvdxY29NaeC1uy1w@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) expanded from macro
 '__pcpu_size_call_return' in arch/x86/events/a...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 expanded from macro '__pcpu_size_call_return' in
arch/x86/events/amd/core.o (arch/x86/events/amd/core.c)
[logspec:kbuild,kbuild.compiler.note]
---

- dashboard: https://d.kernelci.org/i/maestro:bcd59a7f893e94db607d602a4745b60a688799ff
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  135d26f7f8b786c6469b8a12bd7f77eb5d96584b


Log excerpt:
=====================================================
./include/linux/percpu-defs.h:323:23In file included from
arch/x86/events/amd/core.c:12: note: expanded from macro
'__pcpu_size_call_return'
  323 |         case 4: pscr_ret__ = stem##4(variable); break;
         \
      |                              ^
<scratch space>:87:1: note: expanded from here
   87 | raw_cpu_read_4
      | ^
./arch/x86/include/asm/percpu.h:396:30: note: expanded from macro
'raw_cpu_read_4'
  396 | #define raw_cpu_read_4(pcp)             percpu_from_op(, "mov", pcp)
      |                                         ^
./arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
  189 |                     : "=q" (pfo:
_rarch/x86/events/amd/../perf_event.he:t838_:_21):           error:
     invalid output size for constraint '=q'\

      |                             ^
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
  446 |         raw_cpu_read(pcp);
         \
      |         ^
./include/linux/percpu-defs.h:420:28: note: expanded from macro 'raw_cpu_read'
  420 | #define raw_cpu_read(pcp)
__pcpu_size_call_return(raw_cpu_read_, pcp)
      |                                         ^
./include/linux/percpu-defs.h:322:23: note: expanded from macro
'__pcpu_size_call_return'
  322 |         case 2: pscr_ret__ = stem##2(variable); break;
         \
      |                              ^
<scratch space>:46:1: note: expanded from here
   46 | raw_cpu_read_2
      | ^
./arch/x86/include/asm/percpu.h:395:30: note: expanded from macro
'raw_cpu_read_2'
  395 | #define raw_cpu_read_2(pcp)             percpu_from_op(, "mov", pcp)
      |                                         ^
./arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
  189 |                     : "=q" (pfo_ret__)                  \
      |                             ^
In file included from arch/x86/events/amd/core.c:12:
arch/x86/events/amd/../perf_event.h:838:21: error: invalid output size
for constraint '=q'
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
  446 |         raw_cpu_read(pcp);
         \
      |         ^
./include/linux/percpu-defs.h:420:28: note: expanded from macro 'raw_cpu_read'
  420 | #define raw_cpu_read(pcp)
__pcpu_size_call_return(raw_cpu_read_, pcp)
      |                                         ^
./include/linux/percpu-defs.h:323:23: note: expanded from macro
'__pcpu_size_call_return'
  323 |         case 4: pscr_ret__ = stem##4(variable); break;
         \
      |                              ^
<scratch space>:55:1: note: expanded from here
   55 | raw_cpu_read_4
      | ^
./arch/x86/include/asm/percpu.h:396:30: note: expanded from macro
'raw_cpu_read_4'
  396 | #define raw_cpu_read_4(pcp)             percpu_from_op(, "mov", pcp)
      |                                         ^
./arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
  189 |                     : "=q" (pfo_ret__)                  \
      |                             ^
In file included from arch/x86/events/amd/core.c:12:
arch/x86/events/amd/../perf_event.h:855:21: error: invalid output size
for constraint '=q'
  855 |         u64 disable_mask =
__this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
      |                            ^
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
  446 |         raw_cpu_rea  HDRTEST usr/include/sound/asound.h
d(pcp);                                              \
      |         ^
./include/linux/percpu-defs.h:420:28: note: expanded from macro 'raw_cpu_read'
  420 | #define raw_cpu_read(pcp)
__pcpu_size_call_return(raw_cpu_read_, pcp)
      |                                         ^
./include/linux/percpu-defs.h:321:23: note: expanded from macro
'__pcpu_size_call_return'
  321 |         case 1: pscr_ret__ = stem##1(variable); break;
         \
      |                              ^
<scratch space>:67:1: note: expanded from here
   67 | raw_cpu_read_1
      | ^
./arch/x86/include/asm/percpu.h:394:30: note: expanded from macro
'raw_cpu_read_1'
  394 | #define raw_cpu_read_1(pcp)             percpu_from_op(, "mov", pcp)
      |                                         ^
./arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
  189 |                     : "=q" (pfo_ret__)                  \
      |                             ^
In file included from arch/x86/events/amd/core.c:12:
arch/x86/events/amd/../perf_event.h:855:21: error: invalid output size
for constraint '=q'
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
  446 |         raw_cpu_read(pcp);
         \
      |         ^
./include/linux/percpu-defs.h:420:28: note: expanded from macro 'raw_cpu_read'
  420 | #define raw_cpu_read(pcp)
__pcpu_size_call_return(raw_cpu_read_, pcp)
      |                                         ^
./include/linux/percpu-defs.h:322:23: note: expanded from macro
'__pcpu_size_call_return'
  322 |         case 2: pscr_ret__ = stem##2(variable); break;
         \
      |                              ^
<scratch space>:76:1: note: expanded from here
   76 | raw_cpu_read_2
      | ^
./arch/x86/include/asm/percpu.h:395:30: note: expanded from macro
'raw_cpu_read_2'
  395 | #define raw_cpu_read_2(pcp)             percpu_from_op(, "mov", pcp)
      |                                         ^
./arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
  189 |                     : "=q" (pfo_ret__)                  \
      |                             ^
In file included from arch/x86/events/amd/core.c:12:
arch/x86/events/amd/../perf_event.h:855:21: error: invalid output size
for constraint '=q'
./include/linux/percpu-defs.h:446:2: note: expanded from macro '__this_cpu_read'
  446 |         raw_cpu_read(pcp);
         \
      |         ^
./include/linux/percpu-defs.h:420:28: note: expanded from macro 'raw_cpu_read'
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
  AS      arch/x86/realmode/rm/header.o
6 errors generated.

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67e2a3df67593f2aa03189b7


#kernelci issue maestro:bcd59a7f893e94db607d602a4745b60a688799ff

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

