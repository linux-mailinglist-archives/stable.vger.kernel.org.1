Return-Path: <stable+bounces-112063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D060FA26882
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD7916460E
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A5B663;
	Tue,  4 Feb 2025 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zjgCb1Jb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2209476
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628761; cv=none; b=OQCV+ljgl2O6tnUCOSu7sRY3wA53buCWd4vJxlMYqbUcGUCF2N2qatdDQVGCjJWaVzte372CtbzjGDBBhyIsSDy9Cl1vSFwZ/n6Tpre+UbShMwl5W3mModj4dcGrn0uh2IfG9g4M0fyYwHLGjEm+IzT8S6FrACWdFCLmAx6nz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628761; c=relaxed/simple;
	bh=//lsOYc9i/opDSxbdTzmef2sHYW9x2UzcTbmF6o6q90=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=QKSVVuuXbeoOX+bpYn7KM39dYnGa0qtB2baEf2ISLN6z3vBqDwfh/AXAJMXoGf2ql9s3IXHgkJ5mvqxN1TkskICXydwau14CIGdnt13+HeZjap9B+a6jeDJtySYpPM8/bQQZgKP9SlE7L3wQwcPbL+bUyM3SkDgNy30QYmcJe6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=zjgCb1Jb; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6ef7c9e9592so34660557b3.1
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 16:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738628758; x=1739233558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ZJUs8qNGZtg+pLTUvEqUEgZvWpUmqIhrobsNZ2rjA=;
        b=zjgCb1JbTx//GIj0k9uRDMuZIBH66a1fr9cgRFfERwHvlOv0hOt3sneJu6aJpexfpE
         ueCAQHENes4k2AJaA17rUD9LyHtRIY2Epow+3rSA17AEnY9o6YwnbCvo0EWLpVLV64c6
         TIqveaWJ9Zxb26s2TIVdVfpXk5fdr7fq/E/aIx+sB8e7cY3axEaY01+8mDlcK8WwtdZL
         VD2TqQEEgaeM2EHu2qTScx31974yDgls3GeIK+WgteC52qdFDKDsPlXZ5LgQHuB5ik+D
         yo40kgzHIOCAwSNseG0+jn7ujFQnk6OCHz0ZPLeSQ4h4hWcCM62hllPhVvnkRGF8qddq
         lJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628758; x=1739233558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1ZJUs8qNGZtg+pLTUvEqUEgZvWpUmqIhrobsNZ2rjA=;
        b=EuIu5MpXT+n8JkwN8ngvTY9A+bOvfZtcFedJJZA2RV+hxAWKZ+0D9JZ8VDWtFBavZ8
         zZ88KK0uozM1UFciBaklC49qgW3S4pV3jEDfQ0FRIDE3Eb1EsNf/mqzzfUdmGEisCPyh
         Kn1hGwIGJybTN1djyWPGcW/zf5U47643nB8hmKD0VjATHctAXJC/vUwq0Z73anSqm9qS
         i4MOGV5zXjYXgHvwBQ2nInNWqsKr6pLSuaSOUb2fX1oS3hfuDh1MR8xWShxx5+5wvTnE
         1mhBeYB2mnV+9vTUxFRm7izgtX4qyjQ/ZzwTNCH6I2t60nXrldgULgufdGap4PolA38J
         sdBw==
X-Gm-Message-State: AOJu0Yw3D6rbHpqJXg+yujl1FgshfNhxI948AZjFZ0ZMyoHtspUJk22J
	bSb9lu4Z/ivEa4kTtg6CVcRAS+ONeuwQI6w0sLKwvEgg5QzCDni6kJH8DXS+GdsLJasoRhDN55V
	JP/S3NC6uGqd67GDlFyLJW31XM5A6bPj/zqTg+iCz8S2DsGhjmVs2oN63
X-Gm-Gg: ASbGncuEyC8HrMLIiZxPPVNpw2KvniJ6m6WxkfhdyBnITWcSTCwfQe/ClwY0GVAY6Ck
	NFwBQ0y7CeqtNks0QwquNhDd63dv3HumaZJyMM8HJc8ZKrEUHGF76glxpAOF8gbFoTMzvWH2GUf
	oHtcsFOnTw/2D06zyOTg4v23IThGMGUw==
X-Google-Smtp-Source: AGHT+IF50WKuaHyNY207tFh9LJ01OdUtL0qyegWl8YWhjo4RiCeesTZRmEJB/Z6Lm5aLB0Dw21X7wigLnGNoPWB/b2k=
X-Received: by 2002:a05:690c:4d84:b0:6f9:79b2:ce02 with SMTP id
 00721157ae682-6f979b2f0f9mr4928717b3.35.1738628757929; Mon, 03 Feb 2025
 16:25:57 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:25:57 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:25:57 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Mon, 3 Feb 2025 16:25:57 -0800
X-Gm-Features: AWEUYZlztjSxtVY9BOaYH5jq001PosEFnuQoO746iWrxj9lqzP0BGcE0yAOoXvM
Message-ID: <CACo-S-3bdqOv5poCcm-9z=aGGODTPp77+A8st=9-LDjtps5xZg@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTUuMTAueTogbmV3IGJ1aWxkIHJlZ3Jlc3Npb246IGV4cGVjdA==?=
	=?UTF-8?B?ZWQg4oCYPeKAmSwg4oCYLOKAmSwg4oCYO+KAmSwg4oCYYXNt4oCZIG9yIOKAmF9fYXR0cmlidXRlX18=?=
	=?UTF-8?B?4oCZIGJlZm9yZSAuLi4=?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.10.y:

 expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =
=E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98__=
free=E2=80=99 in
drivers/soc/atmel/soc.o (drivers/soc/atmel/soc.c)
[logspec:kbuild,kbuild.compiler.error]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:066c=
374be95fc6671e95a97b08ffc502a95454b6
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=3Dmaestro:066c=
374be95fc6671e95a97b08ffc502a95454b6


Log excerpt:
drivers/soc/atmel/soc.c:278:32: error: expected =E2=80=98=3D=E2=80=99, =E2=
=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99
or =E2=80=98__attribute__=E2=80=99 before =E2=80=98__free=E2=80=99
  278 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                ^~~~~~
drivers/soc/atmel/soc.c:278:32: error: implicit declaration of
function =E2=80=98__free=E2=80=99; did you mean =E2=80=98kfree=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  278 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                ^~~~~~
      |                                kfree
drivers/soc/atmel/soc.c:278:39: error: =E2=80=98device_node=E2=80=99 undecl=
ared (first
use in this function)
  278 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                       ^~~~~~~~~~~
drivers/soc/atmel/soc.c:278:39: note: each undeclared identifier is
reported only once for each function it appears in
drivers/soc/atmel/soc.c:280:51: error: =E2=80=98np=E2=80=99 undeclared (fir=
st use in
this function); did you mean =E2=80=98nop=E2=80=99?
  280 |         if (!of_match_node(at91_soc_allowed_list, np))
      |                                                   ^~
      |                                                   nop
cc1: some warnings being treated as errors
  CC      drivers/virtio/virtio.o



# Builds where the incident occurred:

## multi_v7_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
1a51661a7bc87489b7be

## multi_v5_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
1a4d661a7bc87489b7bb

## multi_v7_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
1a45661a7bc87489b7b5


#kernelci issue maestro:066c374be95fc6671e95a97b08ffc502a95454b6


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

