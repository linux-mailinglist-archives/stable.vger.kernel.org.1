Return-Path: <stable+bounces-114926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E08A30EFB
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2C11883135
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61641DFE11;
	Tue, 11 Feb 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ny1TuIRw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A03D69
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286061; cv=none; b=PJtvN1EQrEsH87/83+yxxn1Sw3UgtbWqrk0kx3SyG4yEXOsm4+6FOPSSV6ZkHfNeld/yObF3L5ECAzmQU390oaABpEq374mKukfbxTl/mhVFeUOPu/byVvdcP2/cqNVSs8h5NmwE/aTo8CFYNDwaco0l3ZlBjHxURbIWviBvRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286061; c=relaxed/simple;
	bh=pKdc7y35FYYNllndJlSKxsCtAy/PcFLSMfsLCFLDrMA=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=k6s/ArEIPOWLrErCrlIiGfS4AgzzyG38t38xbP6k7IyX3BuwBAsNbg8sl9w9HlRQ9bOG3Wavi/sPuAEywzFU6TK3lZOS3vlx+Pl/ygDO4ScKJgiEeVGSJN+jZNiqKiMb8fWo5J7wnmadnaWVyUY92xdNJItkZU30T8uPBBEDm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ny1TuIRw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de6e26db8eso5172028a12.2
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739286058; x=1739890858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+1uC+nn22ue4OI2Q+YL8Q+4lxLe6sk2S29PFDwCXrQA=;
        b=ny1TuIRwEcDjKo3MhHgN0tQWBWdP7cQ3X0jovExd/o0xsS/nDTELb8l4XAvfHPORcq
         ZqK1IvCnes8SpTE5JZZrlk4+SyR0muYcjTt6U2ePO+IWuPjI8uL99Sc0ge1vYlpBCnnf
         8T5LluQLSM/6023u1sdjmGQOm3srCT2STddGfJFP/LSPEhdMu0hsNFWVxpcmFT0FMpaT
         GDFrVPqgElc4TjrL2I88uD/7lVoQQQR3o93OVQiJTBRYqYtp4gT+hHgeu/QFeRI/ctSt
         D4TS/2m4uyrZNbdTSn2kfbfZcFqZQHBWwHGEeAbSa/7GpIDmmmobpuugf2Bri9bDab8H
         Gglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286058; x=1739890858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1uC+nn22ue4OI2Q+YL8Q+4lxLe6sk2S29PFDwCXrQA=;
        b=APkVmDT/LOhln8LG3au7yj6/0fNVI177NZqhegYcoMbhYdLZ6OHA/OhW29qWGrKKrI
         2VNBXbKKseq69KNHrTckg3MoJxvbMFcesIvTp+h2JpQfdSIBGQBNVVi6lGL3VWU9W9Uy
         QccOFL8GYWCY1n8fFIeZCLP2B4TzehfzTz18Hyuh1ltyCJY0tipolMLYVzlzPZvQjvsG
         SLgWkzxM2+wrelg3bmKZ7MabVJKjZ4XG+qjpXAqFeBUjdMeTC1b3zDWWMl/9J6fOhPs9
         j3L3+1nZ20P7Qbrxcg/PQckoM9DW2CrmB1A8/01Dtw2YLE1lZ3InwDo9sxpppCktcrwr
         QaqA==
X-Gm-Message-State: AOJu0Yxq33HnEMbc310fNRU3mjVv8bP495R/5/3rHbgKGjbQSUdU48bM
	RJyjQzSuKGEaHyg64p9D9NksS2WIzvtRgMl5tpeE9cmaiO0th6buakOJvMk9rGSYLSW4x9Lsf8h
	D8ClNxoXRhwNYSrDwEIWtPLVFo1McuuBgAzNwEA==
X-Gm-Gg: ASbGncuLFYIfHMUzDBykIPoVxEmoMGVCixlyE5M7VvCAgyB43asGY+5LWwBmjk/P/ES
	Xdq6ZazHl1IDN1fWtwr0UofyPYC0g/Knck9p6LIBBgJs/JHqvlJQvmYxhAbQxCup89Dq6fWwJaM
	fRU1zqK2pg0SVSZBilVTYkT6ALPU2RkA==
X-Google-Smtp-Source: AGHT+IFJVqBJfa3cr9qLsp1B1Q5bKOwcM8zYuXvZ9fMygvQI3w07LyP+FzZ8duD1psjP8V8HqzVyDKoM2hzlxvDGS5s=
X-Received: by 2002:a05:6402:2189:b0:5de:39fd:b2f5 with SMTP id
 4fb4d7f45d1cf-5de44fea40dmr16669580a12.1.1739286056491; Tue, 11 Feb 2025
 07:00:56 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:00:55 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:00:55 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 11 Feb 2025 07:00:55 -0800
X-Gm-Features: AWEUYZliL3EUPDqVy-hVXZl4QL263kAzctYaNX0_r-PDMBeDh66g4wL7xI6v3UU
Message-ID: <CACo-S-3xq+AdNLV74UGJzFSVar76c+_t6W1gCCw+4KjYx9xOgg@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTUuMTAueTogbmV3IGJ1aWxkIHJlZ3Jlc3Npb246IOKAmHN0cg==?=
	=?UTF-8?B?dWN0IGRybV9jb25uZWN0b3LigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhlbGRfbXV0ZXjigJkgaS4u?=
	=?UTF-8?B?Lg==?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 =E2=80=98struct drm_connector=E2=80=99 has no member named =E2=80=98eld_mu=
tex=E2=80=99 in
drivers/gpu/drm/sti/sti_hdmi.o (drivers/gpu/drm/sti/sti_hdmi.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://dashboard.kernelci.org/issue/maestro:fa367257079874773=
0c198595392890f2f99404c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  a12eb63b1d685a20c1abe34c84c383f0b7b829b5


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/gpu/drm/sti/sti_hdmi.c:1216:30: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1216 |         mutex_lock(&connector->eld_mutex);
      |                              ^~
drivers/gpu/drm/sti/sti_hdmi.c:1218:32: error: =E2=80=98struct drm_connecto=
r=E2=80=99
has no member named =E2=80=98eld_mutex=E2=80=99
 1218 |         mutex_unlock(&connector->eld_mutex);
      |                                ^~
  CC [M]  drivers/gpu/drm/msm/dp/dp_display.o

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://dashboard.kernelci.org/build/maestro:67ab302ab27a1f56c=
c37e05b


#kernelci issue maestro:fa3672570798747730c198595392890f2f99404c

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

