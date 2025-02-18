Return-Path: <stable+bounces-116818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5FA3A7B2
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0321416F225
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C2421B9F1;
	Tue, 18 Feb 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="C5EjMEwm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738B17A2E5
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907298; cv=none; b=ZsQCBvxAXAuvLyhM1ACt/KWCvJyB57g1nQJ5F+Ga0jjIPKiUcr/R7aldTt4FL7h0x9lfWUmGDOWoucwKHFmTRjiWabWBNoTwj0nXlFtzAqd81nCwXbaU4n/mdtB42HUxuR+6D5WsorIorkcVLYqFSCGbC9PcwGUJdlUpJq06zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907298; c=relaxed/simple;
	bh=aSnKWuwIDeJVzr78ynxAWFnAF7N60NVPuqhb6yWf2po=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fd9snA/jdYbOI89pACE8XOoFC0Xlw4enQOQR7n+21FdD9aPguLsZj63+KpvfVojGljmY80BWkunoym3F/WkbXxXy6/jzbJWCGqTb/vfUSKomixmPgnSnYpJleO5l4GAbDDXOUcjscDHdBZau7vYJxVdRcxrzxllicyW5fZvGGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=C5EjMEwm; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fb2a6360efso39525827b3.0
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739907295; x=1740512095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QMO9fnfeYAEK60I2Pc4/gD0XR0ztMUUnH2Phzie79GI=;
        b=C5EjMEwm9S/hlyW6CuY5otgRMnEA3f3DP30BUTBU0JnTP4TwpuxaOjHlCTDdUrwHNY
         xX0z2vs/tFTdpt4tLL8XngEkOXX18JVcZ9i383qHnaVCRfQq7YLa3iiMAsupyxTWyMwr
         YuK75SPr+BfAl8RQirbv9OYyIaL5KjxE2zDv/zEhucs7EkClv6NUgTel9UOu1m8G34po
         Owixppon5zopO7ELahZbkRPqhMox2ia4Y0TSzzCmGVND1BysBRD1wt0YY9GGQ1zYaq+n
         du6VozaRqqhUJVZyYnGFLV4Vfak5o6cyAKf1pew6Bmm9BhYj5fJ/VzSvCKrRCZYw71yP
         YNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907295; x=1740512095;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMO9fnfeYAEK60I2Pc4/gD0XR0ztMUUnH2Phzie79GI=;
        b=doHOlTX4sVxJClKfU/4KzShkgGQFmyupwNK/fDyaduB0tjMIy4v0LENkIZEsi0zS8K
         McDX0Ong6DO8AiPq9jacQm7F7UgSl3oYr1uN8Y3HnKlog+YTy6Z+R02ECIfyjD4mZaMR
         wDeNd4AeF000S+pVIZfPOSDVLttGkV4/pE0XiZNm9oZ5w1PyIMpmRjA0ir/BDTGcW529
         +WAv1ksWxPa1A/P9puXgMdbDvndC0H0Rc+bfEaVRkpan5TAch32Yzbcv1YiaDRpXO1O/
         Se/Zstrv/yEClviRRO9nkI8UDs9TsX/wuMbJCkc2BwvIvlkFDln5JQsMwU2HeqyGBx/j
         8CFA==
X-Forwarded-Encrypted: i=1; AJvYcCVFYRD99O+yFY78sw5ebsfK4MtcPkI8n15+ZgfjdjdjeS0gSA7Kmd6PmMQhpDGH9+d0DF4I+6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44wMitmNQaYisYJOG3T8FtINhHQqj0xQwqscDM71NWe+85aVy
	MnPA/CY4U9EkxAZ4K8Smqiop3O0shJ2pcjbfHkhHic3QkK61WddNR5xOb9+GFdt7mOgv/J9ovvw
	B85FswP1BSa/Ru4HRJIAPPGjR8NQxYTgK3dhbGg==
X-Gm-Gg: ASbGncvyG0YyMvD1nlvPO3aKg8hdVeFk/s4Ef8356E1Ps3lvMqieYDSFX4OxQfh5xLC
	Lg8rdKjLYy4xOO3ELmam/C+A+EimCehJr5cTTW4AE8ZAEw4mwktOONHCjJSvMCqVUV8XPm+zvbE
	KN0fhPzFqF9Vicx0K1G5cXu/rka+Tsmw==
X-Google-Smtp-Source: AGHT+IG4MPcJMOe6hHCGWDTV693WmfAKtS/Tqiua/gO7aoQ3GNg9ddHtDPpFFb2ruEm48W976zLkIXjFyJiQTSTYIz0=
X-Received: by 2002:a05:690c:6bca:b0:6fb:9146:44f5 with SMTP id
 00721157ae682-6fb91464580mr43065277b3.20.1739907295047; Tue, 18 Feb 2025
 11:34:55 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 11:34:54 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 11:34:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 18 Feb 2025 11:34:54 -0800
X-Gm-Features: AWEUYZnenvNOrBOBX2wgbIKk9-f-cvL8BuiKABjjuKLhgwAo-FQQqKuAaOwZ4kU
Message-ID: <CACo-S-0GJM637Ftv==YeUxMh1swfP35tWgMa-3FwaAb9beRTiQ@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) stack frame size (2488)
 exceeds limit (2048) in 'dml31_ModeSupport...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 stack frame size (2488) exceeds limit (2048) in
'dml31_ModeSupportAndSystemConfigurationFull'
[-Werror,-Wframe-larger-than] in
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.o
(drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:bd2798b6baf3af3d8f6fcf670eac9f5235e8b3a6
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c703a7b9b55f8b3d701c14cd8d841ead509baa08


Log excerpt:
=====================================================
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3795:6:
error: stack frame size (2488) exceeds limit (2048) in
'dml31_ModeSupportAndSystemConfigurationFull'
[-Werror,-Wframe-larger-than]
 3795 | void dml31_ModeSupportAndSystemConfigurationFull(struct
display_mode_lib *mode_lib)
      |      ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67b4a3dc50b59caecce1cb05


#kernelci issue maestro:bd2798b6baf3af3d8f6fcf670eac9f5235e8b3a6

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

