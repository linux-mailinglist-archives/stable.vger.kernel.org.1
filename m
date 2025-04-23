Return-Path: <stable+bounces-136456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B2AA995E8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE381B64065
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99326561E;
	Wed, 23 Apr 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="0pjYZGjB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730E280A3A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427549; cv=none; b=UHuvAxDU6ZjPsX9EDmUWeZ1whBbPmhaaDJe0JEpxMDOtW6ARwi5uHAU9XmBGK8wDVZNcKKqDggZnANewVWAAbxA+sZ6qUnxnOd21IJgsb4VgeSRHuUKjmUvGGTEiShnHd0CG77M95wrp7O1BlNz4N8SDW3Mlp2o93djjuzdzDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427549; c=relaxed/simple;
	bh=3C/Paa1MQLmvs88+icj61iicrQxQgOtK0/sPfn2D8MI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=CYYMTH2O2tOaSIf48qdua+m5Y8IT4pvBmWc3Fdu0SGKR9C5Kiy87c+bgbTf1TikGrBZLQdQla0NnzZLGL034KUWYIHQPgriw5FSgloLfNuHGlJ2url/qDNqP6cZU8wP/UcMwPeIQnbib6DBRN1KCqSmYC9yEH+bQJK+UXdqk7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=0pjYZGjB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7082e46880eso1670907b3.1
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745427545; x=1746032345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeoNenHFQxf2rJjhRDI+VQigXWkAGBhYIdmir9wPZoM=;
        b=0pjYZGjBb9KiEu+9ZKLbNtYfrcaq+pVY61CLFYfHSLs46txNL0Uke42j2i3XlzlUMv
         pqluvVLi0Ij/Y/8UmDO94Nx6UDkx0iFaFklSSWWZU6YB5lUOH7G2VhR0n1uj5OyydYrX
         +N/Jb5IkioHeJmJKEvI+2zpsj/pxrjb4rFLm23UO7Lz3oiI/SQ/f94BPgHJnmBcaHtNm
         9yPNxkV160pR8KYddnxFK27ctSJ0VFgK768AZfpr8lF7bQl1Zoy6yF1ZfgRlkLrgRUvY
         hLoumR/B9VUBpWzLu7DW1t2WCqaLRESmdqDor1aju9v0iF4FdNoRR0C+7CIW2shKO6id
         5Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427545; x=1746032345;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeoNenHFQxf2rJjhRDI+VQigXWkAGBhYIdmir9wPZoM=;
        b=voBtwq1KuKxP4v7jI7yTDGjkCMlwfHwbhC8oCIyTeQEMb7pWyOLKGEsFpgjQfmRKrn
         urY/ETIWCuFiCZPWcux4katWae/49ri8ZMfNrU/svKF1gsU+JIh06RPoQ6eL4jjAj+QV
         lTIVbKtnIAgKTKsPBR9yaSCCXAq6/5tIJsL2b3dYYD7Dlpv4GZiroPn2Cb282hzE3CA7
         mBr9pHdEiqOW5UZPn6Yyl9IUBgzlD89cpTRDcQVsZtceecQAkkWpJeEXlnxsM0HnWlun
         foJ4C5kSJL9PP8dqy84+q5+eHeoJ5Qu1v2bNJ8MBMXBLx4oUZ8jcGpMKAoM8sExT3wpb
         +sNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWURoPhor4RGshFD+deYGrIDE7zslI+/yyWGNihtTGReYpCr8WmP5xyBqdctxR5Pf82l8TTi9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWVa6zmvgqFKIG5BduPqRCqts5BzD2iO3K4P0/QiG4+kCO+Mq
	n4pAa/yss8JdRB4z6ey/MWMNDmWuQvZkgQAq1bV9ytjN/k8zffCjnDQ/7qp33sCgkd+OsxqgHKT
	cGq94xKUYDyelIyR8XWrJR3N4VZmq+MTjRBiSJDrJIAfs7yf6r7M=
X-Gm-Gg: ASbGnctBAZ/+g3o48+6BpmoeGfgOO8o+SVT91dX7zZbn08Ez6YRey0J3sDzlv2zdzdP
	DFwZSi4cAWdV4W4YeFVvk+aAt2nBNVdSIT30dg+4BNTBVLIMlxb42Xa8c87PtitdiLtarIvgEhj
	aFOQyFchNryPIoEDhd6MDpqkx9UWBg+dQ=
X-Google-Smtp-Source: AGHT+IHzmtbWshY4kpROf0vgpONjEob9s6TJG2gR1CHVMzLp0MFcTvy9sABVz0Uxvhq9fLbeBLSnOwZ8rfzYudsgWDI=
X-Received: by 2002:a05:690c:ec8:b0:6fd:22fb:f21b with SMTP id
 00721157ae682-7083c4892e4mr5688037b3.18.1745427545375; Wed, 23 Apr 2025
 09:59:05 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 09:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 09:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Wed, 23 Apr 2025 09:59:04 -0700
X-Gm-Features: ATxdqUHYG2Hh0LIvRCHHjn1IpjVGP9mca90NynQOGb2InFJZmehizmj1VLOMjaY
Message-ID: <CACo-S-3O0Oob3EtXyPne=i0akBiCanX8GrJb3W9tOFXy7W-5JQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) variable 'is_redirect'
 is used uninitialized whenever 'if' conditi...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 variable 'is_redirect' is used uninitialized whenever 'if' condition
is true [-Werror,-Wsometimes-uninitialized] in net/sched/act_mirred.o
(net/sched/act_mirred.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:72f9cc14e764580fd20bda28956c2ddf82023571
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dd688b41d9038dbc86718bae12ed995d596c1de5


Log excerpt:
=====================================================
net/sched/act_mirred.c:264:6: error: variable 'is_redirect' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  264 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^
net/sched/act_mirred.c:331:6: note: uninitialized use occurs here
  331 |         if (is_redirect)
      |             ^~~~~~~~~~~
net/sched/act_mirred.c:264:2: note: remove the 'if' if its condition
is always false
  264 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  265 |                 net_notice_ratelimited("tc mirred to Houston:
device %s is down\n",
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  266 |                                        dev->name);
      |                                        ~~~~~~~~~~~
  267 |                 goto err_cant_do;
      |                 ~~~~~~~~~~~~~~~~~
  268 |         }
      |         ~
net/sched/act_mirred.c:264:6: error: variable 'is_redirect' is used
uninitialized whenever '||' condition is true
[-Werror,-Wsometimes-uninitialized]
  264 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
net/sched/act_mirred.c:331:6: note: uninitialized use occurs here
  331 |         if (is_redirect)
      |             ^~~~~~~~~~~
net/sched/act_mirred.c:264:6: note: remove the '||' if its condition
is always false
  264 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^
net/sched/act_mirred.c:259:6: error: variable 'is_redirect' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  259 |         if (unlikely(!dev)) {
      |             ^~~~~~~~~~~~~~
./include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
net/sched/act_mirred.c:331:6: note: uninitialized use occurs here
  331 |         if (is_redirect)
      |             ^~~~~~~~~~~
net/sched/act_mirred.c:259:2: note: remove the 'if' if its condition
is always false
  259 |         if (unlikely(!dev)) {
      |         ^~~~~~~~~~~~~~~~~~~~~
  260 |                 pr_notice_once("tc mirred: target device is gone\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  261 |                 goto err_cant_do;
      |                 ~~~~~~~~~~~~~~~~~
  262 |         }
      |         ~
net/sched/act_mirred.c:237:18: note: initialize the variable
'is_redirect' to silence this warning
  237 |         bool is_redirect;
      |                         ^
      |                          = 0
3 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6808fe8b43948caad9509059


#kernelci issue maestro:72f9cc14e764580fd20bda28956c2ddf82023571

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

