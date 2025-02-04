Return-Path: <stable+bounces-112064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32703A26887
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16E71886417
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AB9476;
	Tue,  4 Feb 2025 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vh6DXSHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBB35951
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628824; cv=none; b=XmQA/6ti8RUO9OTepJhq1HiOSqSTYLV+GsNeiRlSzKTqv0b+W3hZiByGSQrLGvM7wMu+xKk7lBrZjc3hLUKLBHvJNkKSDw4KEmsVm27e5MNKUJ7xdvsGpamvSrj4cCt2PLxmwzvqd05OmgTdh6KDJqWYBsG31Iv4fJpjzTD5VQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628824; c=relaxed/simple;
	bh=PTPVDAiLcftnb87ubXNILVGTBTzJaUe8cTdKN4Odcxk=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=n7kHzxPLohuVOIIoYN1sEcbc5biAHr355Mm8wAhhH0gyw59LZIpxzey3CzEH/Mlbjmbb8vJNIZF6Abq6mjU6vvO8BvpnfQVPmvkzljA+lRWI7e0/PM7UxHjzcWX/TbxqlAhHd/EGH+K3J080lo+8BZ9/Uh+SdbkY4B1i+j+UJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=vh6DXSHI; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6f88509dad2so33903967b3.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738628821; x=1739233621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bx7e4wgOOXX72jl0bpz1gEokk8TyxVSV7InquiC7AGE=;
        b=vh6DXSHIBLYrkw24RsQebIiBMvuciQeK1ztJbp9NXE7OBeUXiTC1PmIUeZQFFTOwx5
         mdcoz1TJGhwE+QE+EG1YQ8S/UWskPZIQYRhinsH2M1DtRN/vHkQXwzBc+0bqkpxwlRWx
         DhcIqT+RxPwvND0RLJLlk37Az0naAsUMkD+aX7aToa7vRmMkUrU3g5JIzH2D6WFLYapE
         rr+/jAjii/8Mkg57Q6m1tXFeviZnyq8Z5SflC7ZTACn5agwqUopJExh6B8l4iwvtxkAX
         XsAWj+7kaBCtGZo5vgduTU0m4NTZWWp37ISkxg0WiKOkVvYnI/jJQM0xcjvKzOEqJnEn
         XgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628821; x=1739233621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx7e4wgOOXX72jl0bpz1gEokk8TyxVSV7InquiC7AGE=;
        b=tToKpCDs6VN4cCfrQOUE2cym7osOkxyokavB1jv85IRH9bx837aDQKPSqwCJ6y4lWk
         9bOwjrpQ7y6mEjT7CfK9liCKr+fLY+Pv2CWqxqymPCypzVEQpYFbCyZQImo4Hg+xfPM2
         1YjhGfFrUcYXzvuBd3sU6cVQZnVGcRtTS/4Tlrg/lWi6nfV+rlIcczDFKqkvRmVAftEX
         l5rYjBWer5b24KIPF5xIR+28h1U+jhCivB0KPEYfsrgaCrjJrPKcZFG88j6oTK0ZUsZj
         0N/b7hjOFi19M7+UhiIk+XfwyXizbzefLCodIIUZHLL876PQWO2+cnJK4RgRswYtEMnj
         CGtA==
X-Gm-Message-State: AOJu0YxPadmn/Td7e7kouAyo1djP3DFV4T+sWLs86LepEcm9VqECIjXt
	xaMw/H4idWtk4geo9K1yTrxKa7ZYuoUJwpfHbKf8a/atbZUEM+jNQC69Yq2zo8GKqPIHjDM8D9O
	Fzwl3I9RBlGKjigBtx3TCK5xGpXpuTjif3tyKt8dVL90w8aMjyynUc9TC
X-Gm-Gg: ASbGncvYXMjG9KXAbFZPsRTPx8BwFzI9NWEE6Cbt4uZM1al6qiu2tOYjJldtkIbVRGY
	5G8GhA/3o5TjMqLgHW2BIo72jBC+jBcl+sdubsouPFz5+qvd1XPmBvB+iIrwM1QD2+UyHkksEwu
	ifVoiKoSJKamraHJuqV0SJyzvOJMHhsA==
X-Google-Smtp-Source: AGHT+IFsuoJoFvHZzlNtYKXmousT8np1yqW//t8QzXPISMdaYVmb4dkX5cTOdPWjVe5K10fP/Us7hMhifS9iYVQXjbA=
X-Received: by 2002:a05:690c:3685:b0:6f9:48c6:6a17 with SMTP id
 00721157ae682-6f948c66c19mr81418047b3.26.1738628821347; Mon, 03 Feb 2025
 16:27:01 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:27:00 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:27:00 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Mon, 3 Feb 2025 16:27:00 -0800
X-Gm-Features: AWEUYZkkk1PpPIVbz08f_TPEtEY5BgtSRtN8iy3WwvTmNCw0bZjbtAIdDdzWyxs
Message-ID: <CACo-S-1EmQkbiykZQYV4yvBZqVe0zNgm9pLYxu6E4bVAPCSrfQ@mail.gmail.com>
Subject: =?UTF-8?B?c3RhYmxlLXJjL2xpbnV4LTUuNC55OiBuZXcgYnVpbGQgcmVncmVzc2lvbjogZXhwZWN0ZQ==?=
	=?UTF-8?B?ZCDigJg94oCZLCDigJgs4oCZLCDigJg74oCZLCDigJhhc23igJkgb3Ig4oCYX19hdHRyaWJ1dGVfXw==?=
	=?UTF-8?B?4oCZIGJlZm9yZSAuLi4=?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.4.y:

 expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =
=E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98__=
free=E2=80=99 in
drivers/soc/atmel/soc.o (drivers/soc/atmel/soc.c)
[logspec:kbuild,kbuild.compiler.error]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:040d=
cc33328a47e528c393a656a52b340b4ccc8b
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=3Dmaestro:040d=
cc33328a47e528c393a656a52b340b4ccc8b


Log excerpt:
drivers/soc/atmel/soc.c:277:32: error: expected =E2=80=98=3D=E2=80=99, =E2=
=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99
or =E2=80=98__attribute__=E2=80=99 before =E2=80=98__free=E2=80=99
  277 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                ^~~~~~
drivers/soc/atmel/soc.c:277:32: error: implicit declaration of
function =E2=80=98__free=E2=80=99; did you mean =E2=80=98kzfree=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  277 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                ^~~~~~
      |                                kzfree
drivers/soc/atmel/soc.c:277:39: error: =E2=80=98device_node=E2=80=99 undecl=
ared (first
use in this function)
  277 |         struct device_node *np __free(device_node) =3D
of_find_node_by_path("/");
      |                                       ^~~~~~~~~~~
drivers/soc/atmel/soc.c:277:39: note: each undeclared identifier is
reported only once for each function it appears in
drivers/soc/atmel/soc.c:279:51: error: =E2=80=98np=E2=80=99 undeclared (fir=
st use in
this function); did you mean =E2=80=98nop=E2=80=99?
  279 |         if (!of_match_node(at91_soc_allowed_list, np))
      |                                                   ^~
      |                                                   nop
  CC      drivers/spi/spidev.o
cc1: some warnings being treated as errors



# Builds where the incident occurred:

## multi_v7_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
19e4661a7bc87489b6f5

## multi_v5_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
19e0661a7bc87489b6f2

## multi_v7_defconfig(gcc-12):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a1=
19d8661a7bc87489b4f0


#kernelci issue maestro:040dcc33328a47e528c393a656a52b340b4ccc8b


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

