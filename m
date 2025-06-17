Return-Path: <stable+bounces-154544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12649ADDA29
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD78119E2F35
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A12E2FA638;
	Tue, 17 Jun 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1daOrA9R"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A9CA4B
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179549; cv=none; b=DyqlJaW7JLuGgdyfgV6womsO9qOe1tF2urxiCzoigpz8RRwF5FejZwjNrGqchLECeGLGqbVcATbBSD5Hnrnec7tOjP14RNeGGeU/XoUh9QCBCvt1jK9hw/Zd8na1L9C+g+JhAY5SoidEH9Qo3DtmKZjjf1pYTfRDEjF8lUWhAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179549; c=relaxed/simple;
	bh=s5xYxxyun7WtAcOu1vLwX7DczHMIFgx7kjHNNUNcUmg=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=iGNvfkF81yZnMWuR3lAr0kvzSsdXW5ixikwZVBwP6YyQEZHM7gOphPdc/ff2snhJI4GJ5E/LvtpXchUzP1lch+x5TDUIioYy2qMmmNW0BoCaf1w3qh87GiOZVW7IgEO5nrf5UwZMjNsFx6JcuKO5YgPbgpRQZZkzk7kC9M669ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1daOrA9R; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e81826d5b72so5851522276.3
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750179546; x=1750784346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uexDCWuquhLHKN20Lhn4Fvzwd8WslUrZXSAQzL0ZJ8c=;
        b=1daOrA9R7BB7SMMNrn+qW/ZorTONSjEzJKNBS58e7IwGwrT3Fvy2rRzXPRWrRXT2uE
         FKEUjvOvIKqTSnNIY3dyaOENLHu1Jc2h53CUGccPocHtN/H0O5AfeA7/sSChjr9dWX/r
         6eH3xW9KCYQVCtggkJfugn0SM0XBadJ5KA+lQQDH8Ty4oCp2od+GZ/C1FAhJvRWXpnhG
         REg3GlZFL5idBpSEQUo1Ox8kBjHbAiMxVHiI2GrZ9pdVqbEzkM+Q7dVnqkmBvmRiMhG0
         qO3wVg+NhnSQj2AUTxS6tHgldXfRtIUdu+0mW7NnsbkcNzuVxGz9QT4jE3opTVr/8rM8
         rqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179546; x=1750784346;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uexDCWuquhLHKN20Lhn4Fvzwd8WslUrZXSAQzL0ZJ8c=;
        b=eC/anbJu3LP7KMDvABp8SuqvJB2T+1xfOSFG/S8lv6ex4emcuAK8t0N1IVLZ7FMOvy
         ap6uatpw4JiOFCAJP43lfDx8pjH2IAr+PlHKGtzAhlBw9EtdQK8/pkX8XveuFxAWjtyz
         qdEv2Jc2tuR5J7DSGv+NjD75QHV+6NED+CV2GSpEiiZBLF7ksdVC/9MVzP4+mTQr7lf4
         Yvpd3q1a94nPS6t3ll9yk2v3JYsp0B2Q4LzI/D3oF7ergh2vTcaOR0pwL9BAfhFkgFJA
         uuZSRoqsJo+Jfk6GAsjTfFViebicohVLCxrRa7otizfpqApjZn2hB9oBAml1Bj81Jn9J
         YpzA==
X-Forwarded-Encrypted: i=1; AJvYcCXhVxS4pKU5ZKZ6jYVvIo0vErxQAjgmeTvV83JDCicvb2ppGiaoRtjWfXP9tgcLAdmyMndScdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UvkeMNdH5r+sp/F/rELejnDOWxuyAXL8eprS8L6lfmH7RV5L
	J29KEj6xcCNSCjFPo5MlO0N2gyRb4VFQu1uGXnXd//NX0ZDCUJb4BO0wwkuLCimuCI3hkOAzLpD
	9AD58TlgqeZTwwUrNgBhR/STRq5svAXdWsb3PoXe6Ww==
X-Gm-Gg: ASbGncsOEHJLvG/cNq4PlRNugCgrCFinLaS6cd42+q0Isl/2XFKDQAe8ybbaDAiIgxE
	Qj9JIeGsb91OymgtRN1PU/XiWQkhtrvc2P3hygmuK6ghw2khXAugsQi+DM9TLaRaAAN3vuwDOJd
	e4mVPBVB4ov3IxhfFPsK5KgBFU25aLS5Lix/hAkenzSc4esiPkCcih
X-Google-Smtp-Source: AGHT+IFGvRQJJga/7UpsS7S9aZ/9qZFPicZQIpk3y9xR1nYtTmGcTGcdDmfpHriPljn++lTGgo+Dc02V7wSFg/fJ9NM=
X-Received: by 2002:a05:6902:108d:b0:e82:17a1:5c15 with SMTP id
 3f1490d57ef6-e822abe063fmr20582322276.10.1750179546265; Tue, 17 Jun 2025
 09:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jun 2025 12:59:03 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 17 Jun 2025 12:59:03 -0400
X-Gm-Features: AX0GCFuEaczQ08U4pW0R0C-3EHJaQEYpD_NUNvkQvYvC-RSH0sk9uVt4lIju0Vc
Message-ID: <CACo-S-1iCvQxH9tnM8tKNYooaWaDPukVOvGTXvciHHGV7kwZaA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) integer literal is too
 large to be represented in type 'long', int...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 integer literal is too large to be represented in type 'long',
interpreting as 'unsigned long' per C89; this literal will have type
'long long' in C99 onwards [-Werror,-Wc99-compat] in
drivers/gpu/drm/meson/meson_vclk.o
(drivers/gpu/drm/meson/meson_vclk.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:ae3b0334acd91200d6ced325a381bafac2d46493
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  d99cd6f3a570e2f93e8f966b8ca772ef3da54fe2


Log excerpt:
=====================================================
drivers/gpu/drm/meson/meson_vclk.c:399:15: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  399 |                 .pll_freq = 2970000000,
      |                             ^
drivers/gpu/drm/meson/meson_vclk.c:411:15: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  411 |                 .pll_freq = 2970000000,
      |                             ^
drivers/gpu/drm/meson/meson_vclk.c:423:15: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  423 |                 .pll_freq = 2970000000,
      |                             ^
drivers/gpu/drm/meson/meson_vclk.c:436:15: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  436 |                 .phy_freq = 2970000000,
      |                             ^
drivers/gpu/drm/meson/meson_vclk.c:460:15: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  460 |                 .phy_freq = 2970000000,
      |                             ^
  CC [M]  net/dccp/feat.o
drivers/gpu/drm/meson/meson_vclk.c:850:8: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  850 |                 case 2970000000:
      |                      ^
drivers/gpu/drm/meson/meson_vclk.c:868:8: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  868 |                 case 2970000000:
      |                      ^
drivers/gpu/drm/meson/meson_vclk.c:885:8: error: integer literal is
too large to be represented in type 'long', interpreting as 'unsigned
long' per C89; this literal will have type 'long long' in C99 onwards
[-Werror,-Wc99-compat]
  885 |                 case 2970000000:
      |                      ^
8 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:685192b15c2cf25042b9bc2e


#kernelci issue maestro:ae3b0334acd91200d6ced325a381bafac2d46493

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

