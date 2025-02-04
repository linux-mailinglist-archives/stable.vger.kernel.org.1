Return-Path: <stable+bounces-112065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34924A2688B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C161881DDC
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275D9476;
	Tue,  4 Feb 2025 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="u6vr07Cl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DB22612
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628911; cv=none; b=HvbbfygCcR6KfkauC7iTGZs/Mqdc0mKo/SbIda+AywLglQzprzWOOgBZqZLlRjVrqtZLheppHgtwVXh7wvs47hZeLbgjVVqwyQhW36S3Dlz2ONl3JcK1Q2TGUkCJRJo9/xgO7a856U7DTLHjFRlyC3bxjvDm9GMDwaVEmYLI/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628911; c=relaxed/simple;
	bh=KDsJVEdTmE2MITK0ZWasjCjyoXYi031QoHHKV4r/fB4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=qTzNLTENdvrQzPZOmyRZNnIPCmsRs/zxGwXS3Uhsw4LyOcZGmhwmyMWH4qpMdLaKMzoHKL1f178bO1HSNwHPUwLzE4o/9YNDBRBbQf/cAgfS+167n0l+aOZKG7kaLSHy4LicvrJLAtan4tR8WCasMRlw09bvOQq7n/QfZQE8iig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=u6vr07Cl; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6f4434b5305so29217177b3.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 16:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738628908; x=1739233708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QBg9s+xYhZuKZwxwE0Iyt6QAsTw3RrZTOD91ZM1MEk=;
        b=u6vr07ClPxvcCsOwH0Qa0Q43fVEwwFVXgWA+/KeHZPUxqOlQvdwEaNXXbagtBTD744
         xQnCtmKzh4GXLCyFjF06jX9eePv8sHpgDR9KZzpdyuLiW+jG+v0GxfPQ8JC7hgYBPzVn
         7oJT3XFjHh1C6YlOQoGmch8Owk7GjnOZIaD0Shr+Vlz1bZnLYtUfD44EsdicvEbbWjpJ
         QlD2lGPwWaiSmGw2RmXUuXVEM3HSmFZAeUNc4vW2SrTIsA26+/rIxUXjRo61UJRs0kLj
         W5p1MtiD0lFxmCZC09V5z4ZYeqx19BKlig8nN6nvv8qkS/nVV0+7QH8/r7fChm7WOrTh
         6xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628908; x=1739233708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QBg9s+xYhZuKZwxwE0Iyt6QAsTw3RrZTOD91ZM1MEk=;
        b=DgKlpe4DWdhaGRuWzWfsIyVa52rbeRz/qxSrFwdB8h4Rp6dQvnxBt+c0U3XJAdw5EM
         KBcSVXRjLYAZEFofN3bozuQJSbzl3FSSL6zOMbgYLQrjLq9GNQAoT6SuhX8TsuPbtSVA
         Vg4cUBhnaMIrVYyid8FD5LbzQ/TThp3JJfz2GkutxRM0QMZbsSpiiWLPKbto1O83s2b/
         PpM0yQmK5oc4bL3AcICS6wOoPAfvpO8LlcE0SLioMTZQSXGY7Z60EedDIZ9IWkpNDwDw
         U/bdrH7gQ12OhPzuMf0VXrGXKYGNIcxDpaB4Owe5/LkraYXL1g+btmThAmJMVOkpkBvF
         IySw==
X-Gm-Message-State: AOJu0YwotVeTIslCJHDSvcUQPI1FEdqhK2oozvP3mEYnndtYQFT+r7Fx
	kPe6phHg7mK7W9+bhIXPJBfgzgM7WsrOR5KAfdDW08Fw9+I0cmm5K4E+THoNCU7k2ugcni8Fxmg
	e8lKyL5KXq8GunSSb3AnpMulwAZyOY72i3SODjp3QR76UZklPrIUVtPNl
X-Gm-Gg: ASbGnctvQVy/vr5X8z9v0Q28b3+khYMQKy9EMkV8TZIW72DHevR+2nmdYJVj7xTUgUM
	2Dd6ydI4v184NG6Kgg9ctw5WKTC+0IlK0BN4+yPlSw1skcJHWpWsfRt5C2l06z3J9LMDPI1uP3H
	LZR8gEwrHV/W99CkzR/lZjK5j8Qs5iUg==
X-Google-Smtp-Source: AGHT+IFT2fP45AmFipy/7cLS6LagRJqrh+vz6HUR3nN1StiBCpws/T1LSDf3eoG1fSc4SX7AQYmF9LFJuxjH2oU7/Wc=
X-Received: by 2002:a05:690c:6602:b0:6f6:d01c:af1f with SMTP id
 00721157ae682-6f7a834f0c8mr180608577b3.16.1738628908321; Mon, 03 Feb 2025
 16:28:28 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:28:27 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:28:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Mon, 3 Feb 2025 16:28:27 -0800
X-Gm-Features: AWEUYZkXPfEUCum2kHDJB4xGVNOoLAgPX3CU7EAjO15ZNqpf9AIGSMNnKBSxT1I
Message-ID: <CACo-S-0B4XyWw560r04rPjC6HwbuY1ZpSmYG1UmyJUTdV=nU_A@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTUuMTUueTogbmV3IGJ1aWxkIHJlZ3Jlc3Npb246IGV4cGVjdA==?=
	=?UTF-8?B?ZWQg4oCYPeKAmSwg4oCYLOKAmSwg4oCYO+KAmSwg4oCYYXNt4oCZIG9yIOKAmF9fYXR0cmlidXRlX18=?=
	=?UTF-8?B?4oCZIGJlZm9yZSAuLi4=?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.15.y:

 expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =
=E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98__=
free=E2=80=99 in
drivers/soc/atmel/soc.o (drivers/soc/atmel/soc.c)
[logspec:kbuild,kbuild.compiler.error]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:a7ec=
cc80a8c5d40b2934f6b5b061391e2da155c4
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=3Dmaestro:a7ec=
cc80a8c5d40b2934f6b5b061391e2da155c4


Log excerpt:
drivers/soc/atmel/soc.c:367:32: error: expected =E2=80=98=3D=E2=80=99, =E2=
=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99
or =E2=80=98__attribute__=E2=80=99 before =E2=80=98__free=E2=80=99
  367 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                ^~~~~~
drivers/soc/atmel/soc.c:367:32: error: implicit declaration of
function =E2=80=98__free=E2=80=99; did you mean =E2=80=98kfree=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  367 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                ^~~~~~
      |                                kfree
drivers/soc/atmel/soc.c:367:39: error: =E2=80=98device_node=E2=80=99 undecl=
ared (first
use in this function)
  367 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                       ^~~~~~~~~~~
drivers/soc/atmel/soc.c:367:39: note: each undeclared identifier is
reported only once for each function it appears in
drivers/soc/atmel/soc.c:369:51: error: =E2=80=98np=E2=80=99 undeclared (fir=
st use in
this function); did you mean =E2=80=98nop=E2=80=99?
  369 |         if (!of_match_node(at91_soc_allowed_list, np))
      |                                                   ^~
      |                                                   nop
  AR      drivers/clk/mmp/built-in.a
cc1: some warnings being treated as errors
  CC      lib/fdt_strerror.o



# Builds where the incident occurred:

## multi_v7_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
1ab8661a7bc87489ba81

## multi_v7_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
1ac5661a7bc87489ba8a

## multi_v5_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
1ac1661a7bc87489ba87


#kernelci issue maestro:a7eccc80a8c5d40b2934f6b5b061391e2da155c4


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

