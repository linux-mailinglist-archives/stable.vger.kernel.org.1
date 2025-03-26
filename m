Return-Path: <stable+bounces-126764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C6A71C9B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76B71688B2
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEE1F7554;
	Wed, 26 Mar 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="PTEL4x+o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C811E4AE
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008347; cv=none; b=orqx4QB0FpO5O5xGy6iouxOuYN5X6jTJzWryOI5rHSMr5p3mN0KpKS5XkQRYP8fvwW6TTxvCVmB6bDJcKlKSFsawvhNOWlRaJba13lrCDsCSHmReaUwwwOZI9W8hopgFSJw5vuUUWGC5p4h8HBEFYydAbuCgvOKslRkJUEzbfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008347; c=relaxed/simple;
	bh=arQGwZVPrqbThb0yWEHXg8QkLpjhua1AljRyajPQaU0=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=e5SVuNxZnSdgLuCTvAB7+xnH/v4jgYlr2xzcE8NkLGwDO2cxu8lwVAutBzeCGCqBIP0GHknizlNzWSmTlhgomcqapBNmDuNN+24hpjR+NONHsjSd8+/KGjVbBUtnVFUby4cdxpW4GF18nbd3PEwkVaFzmw70pCaM1s+0UUtjxEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=PTEL4x+o; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff0c9d1761so827147b3.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1743008345; x=1743613145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y379J0tkPhPdZ2TRAbtAzwhfI8nL+5d4ifK0P3kvmzg=;
        b=PTEL4x+ojwt8UYhgHlmgoFB2RdWMfBgOiCuS6Cm/7biXEMPcNovXsNFxu3BJw6YlN6
         mVwW7CFI4HQnNRHHNHOAmGj71xjh12UYiVS0qDtHQrtHblRgibPP8a0b4SlECzBNud6z
         IUAOt0HSgRr40GmHOFBCWD8QFzGr4ZzZVYIYgFL5hnb/eHrxJNyfE6uC2DOr4mJLwYav
         WPq2dyPupiJi1wmy70FhG8FaJMaD0WxcZ3bHsSIqdDqi4QcV5EFuXgshaIZovTSA5sN8
         uqwgsbXRYZvbaNdPUTFxzjVsYenoKuxUeR0/2rNX+d+4dlTOGfxnz4TMZty9QAHfKCrJ
         qb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008345; x=1743613145;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y379J0tkPhPdZ2TRAbtAzwhfI8nL+5d4ifK0P3kvmzg=;
        b=hqdWbiqWDIJk9rKZNA+fDlJzwHdBJGjRKDyNkvJgTE8dD3CtzlwdNE3ynf/aR5Aar9
         9OKwaukPvz4ZxYwG8sUA/6LMkR1puufQx5VuZYzGdcrJUfF+g0yfeQi2Ptv2eLffc44G
         f3UZeDwHqthhlu2rqvooJY+Wyhs3JzVng/0h7+o0s542VxFK3e+ki4iftDdqsQYuMqY7
         fMWxIEsDYKM6HGAEw/vajD7FkT999iRxSeysJLgdUdDCmUWrezRg6KfnepFQWfh2JEO5
         2nP3cg/GXnrIq4oNDVlZfkHMk6W9cckGN4NAOuG/17WpT5+JBtHyuUYcwo86CCKEyjlL
         jIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4NcGABe+yrCho6ZL947/UBZgMD9zfGBZKjOtH035OObK0JSKTCa3sjNdp7oOqjTOg/aamfeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+k8xViH9u+WVX6AVloLbOw2jcMMfZHJgoBB9HZ64OBdos7bV4
	rHHWWBmLod5QLBBOJ+VJ1jIeyzDEVbEONVqmauII9FZfQGQfragTT++GtrrSch58Y80Ua2kNNa9
	MFrvu40kkiVWk45fd0qhBA/V01MFns6rRvvLBJQ==
X-Gm-Gg: ASbGncvUwrX7DJRDrf6JZEhunQD1V1iMHSD5drWwqQ54S+ez0kqzwnmk1Feo4Yap9j2
	M9DwojFrBcaDNStyAXRcWLEiznBJo3ifqLb7HH9ROyAYye+TRcIJxjS5VitjKan+ChrHrjzfEFI
	3tv6AmH27VDqxYDzZQUA/xiyVx25xz7blogMI=
X-Google-Smtp-Source: AGHT+IEl5uMhnAamdpWuSK0NjN7Ck+kfXmQfyQlpL3bPrXoItaHZcFEq11YZeZSARx83L9hUcR1CA/6r3+lz01izZw8=
X-Received: by 2002:a05:690c:6501:b0:6fd:4521:f9d7 with SMTP id
 00721157ae682-7022508f563mr3572827b3.24.1743008344647; Wed, 26 Mar 2025
 09:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Mar 2025 09:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Mar 2025 09:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Wed, 26 Mar 2025 09:59:03 -0700
X-Gm-Features: AQ5f1JqTOlOL-5GcPkw4PagyqdtZL2vYY0ow8gKLUZrz25VTIFhgWGeBM9NJrTw
Message-ID: <CACo-S-0iiF-VZStXMO54KgdmvAF=VtE-=6ijdpS-FhS_UYcewQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) stack frame size (2536)
 exceeds limit (2048) in 'dml314_ModeSuppor...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 stack frame size (2536) exceeds limit (2048) in
'dml314_ModeSupportAndSystemConfigurationFull'
[-Werror,-Wframe-larger-than] in
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.o
(drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:648fbfc56c50cbf6f8e1b118aecda05fbf80323c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f5ad54ef021f6fb63ac97b3dec5efa9cc1a2eb51


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:3890:6:
error: stack frame size (2536) exceeds limit (2048) in
'dml314_ModeSupportAndSystemConfigurationFull'
[-Werror,-Wframe-larger-than]
 3890 | void dml314_ModeSupportAndSystemConfigurationFull(struct
display_mode_lib *mode_lib)
      |      ^
  CC      drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_ipp.o
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67e4241067593f2aa035cf70


#kernelci issue maestro:648fbfc56c50cbf6f8e1b118aecda05fbf80323c

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

