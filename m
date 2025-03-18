Return-Path: <stable+bounces-124843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85330A679FA
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC98917D59D
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915E211479;
	Tue, 18 Mar 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="rMr832RQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32E211486
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316312; cv=none; b=kguO4KGZIng1X4jfNwdz4OIKOVN9N0c2svJMT0Zqtjvl8uinYsZz+1cWK46XcLVxcGjPbexterLQbLA1jp9jycIplYb7ra4Br6D7YYK8tb53XN75w8hzqSffl5CQWnrOkackTnu79GVxF1sGWRYYoAgVrbxOsbDN/hMmfA/55pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316312; c=relaxed/simple;
	bh=4pTkRWjc7YHthMdvqy8ZuVPShaPeSKOTHBe8noeDUZw=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=sqjPsqJgVR86TsC1yByoroT/0Xl6VMWXP9iNYt9wGWAVyFfwefjp5rSHudmOcfGqvgn/3Mk/pmWxZK4Mce8Z4iMeqA+Vf6ela5POFFQAAmPfEyWZZnIAPxMmrXBfbM0B+BwTVuZe1NYrF/4Igd6gJ86aWmFn3BURUDOobjHRgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=rMr832RQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fedf6aaed2so52415147b3.0
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742316309; x=1742921109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Grgi3IFLGamzGFwXWlL6Z7lbOWKXd5kIRsFQ2PCerwk=;
        b=rMr832RQFBB5AhnIhON46bJAs0n3yCCMKi0vzUxw+lTKP8Qd1NzXjF15dOrinzHtrf
         w8EE/FdvFEv3Uu6weKjW+frNCiGYwoDPcqM8/ZcBF8slPz8TkXWSqh9WyY/aHtGwKPH6
         KoVFvkhs6uBjxQ2Dwu7MP+ucDe6bGiLnZC3OmXqaf+toxVCkaUH6rGItPtvD/T3E0wmA
         rdQuCkSDBZuTqBWyhlvhLyXUu6AY+7MzWnDkOEacZGYiO5ZVfyh636N+lyBhEIuayr9F
         U1veOkjR7jDznCbjca7jQBIH8f3vSA5STOXNqStIwlN0qwb/x1MchaFSMDa/26keANih
         cwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316309; x=1742921109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grgi3IFLGamzGFwXWlL6Z7lbOWKXd5kIRsFQ2PCerwk=;
        b=r1F5EPS9zuLngLz0hSNA2mbPXQyGS94Owd5wC0eaCAv0Y4JlBksY49hfG0UZJh/TnF
         5w9kjlFsz6TcTeFVHXPLghSlz2DshIhD2bIUhPfsroDKbUQ9McpZjaYQcExk0D2zlDLR
         Zq2OihxCSDh3CyJbux+PJIOGQMseBxrEBzHrYxzm8N9AAfSh4ABawWx5RWJi13DmKM3t
         GhqWmfzp9T1ADCM2J5EPtO6py+oNAmoTLX8cMCNy4XLV/dmLwa7eA6Tvfq3b++bnxZNO
         319WM2Nd8NwMyNQAPdhRl4ra02r7BbVZexsWIO8DgJLJ1+7poWJtt+vVEzDSNIUz0y9a
         2Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCVd75R04m1/xbFGvK4bYNzEWnq9ak8kJIyHMTABJxDA8lPOkMYZQKbA4hXUnqpV260bpZtAqh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDJdGxN2X/P51ggfetoVJkPTLnRbwSgyST9hZ54G+VfofUlja
	oma6l+y0WpVbnr7v/47Vq6H1Uis6Kw0HMSf/4yje6WxJSkcqZblQKys4wbZI6dfccO2xXVbbqxh
	KX2oEgdaj9FvP2GqJ0w/Y5kbccQOU1tVsbIcs49Jbd7b2F25Zxds=
X-Gm-Gg: ASbGncsHTd0ZBbpPT0U5W7UPNiWWQxsWEwxmcYjCuOa6/CV92Anf1PO2xthBV+0d9dO
	UWGfiGiSrzufAcq7OYYMWdM0TzEeV5MqXJpK3D4O7ZSqcOe7mRYkbmvdWh2RCMmH/+HMLkD8Sed
	hCaOfLl6Q9f56MpJbqryyOzZrg5n5s251fYnfaXz4gAausNKyVHKaI8UfcZ7howt4xOBbT5A==
X-Google-Smtp-Source: AGHT+IGAl2KmvD22sIQ5Oot996yjk4zVJCKy1PIVKLDVLlTsORs+2lkT+LgMutG2eD2frW3tafA+SQV1PacgFNAU60M=
X-Received: by 2002:a05:690c:d89:b0:6f9:c487:2c26 with SMTP id
 00721157ae682-6fff852d98amr62384157b3.15.1742316309458; Tue, 18 Mar 2025
 09:45:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 09:45:08 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 09:45:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 09:45:08 -0700
X-Gm-Features: AQ5f1JrKo10wmx1_Be5fcapc5JEY3BYp68HGURi_tkr0XbDgjZaKxsjuaqLP_pc
Message-ID: <CACo-S-2id8EdJDOEXu3=DGcPUS-2opiFA__ZWf-z1utYebCfpg@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSDigJhmYl9jZQ==?=
	=?UTF-8?B?bnRlcl9sb2dv4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlv?=
	=?UTF-8?B?dSAuLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 =E2=80=98fb_center_logo=E2=80=99 undeclared (first use in this function); =
did you
mean =E2=80=98fb_prepare_logo=E2=80=99? in drivers/video/fbdev/core/fbcon.o
(drivers/video/fbdev/core/fbcon.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:e495b4ec34845e228a5f1639d0ec8=
05fdbb6e7c0
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  52baa369b052eae3278dda3062d63a3058eb9cfe


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/video/fbdev/core/fbcon.c:478:33: error: =E2=80=98fb_center_logo=E2=
=80=99
undeclared (first use in this function); did you mean
=E2=80=98fb_prepare_logo=E2=80=99?
  478 |                                 fb_center_logo =3D true;
      |                                 ^~~~~~~~~~~~~~
      |                                 fb_prepare_logo
drivers/video/fbdev/core/fbcon.c:478:33: note: each undeclared
identifier is reported only once for each function it appears in
  CC      fs/ubifs/budget.o
drivers/video/fbdev/core/fbcon.c:485:33: error: =E2=80=98fb_logo_count=E2=
=80=99
undeclared (first use in this function); did you mean =E2=80=98file_count=
=E2=80=99?
  485 |                                 fb_logo_count =3D
simple_strtol(options, &options, 0);
      |                                 ^~~~~~~~~~~~~
      |                                 file_count

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-6.6/arm64/chromiumos-mediatek.flavour.config+lab-setup+a=
rm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b4f28b1441c081c5566

## cros://chromeos-6.6/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-s=
etup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b5428b1441c081c558c

## cros://chromeos-6.6/x86_64/chromeos-intel-pineview.flavour.config+lab-se=
tup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b5928b1441c081c558f

## multi_v5_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b8f28b1441c081c5622

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b8028b1441c081c55fe

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67d98b8a28b1441c081c561f


#kernelci issue maestro:e495b4ec34845e228a5f1639d0ec805fdbb6e7c0

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

