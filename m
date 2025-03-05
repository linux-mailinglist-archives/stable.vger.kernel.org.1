Return-Path: <stable+bounces-121103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E24A50BCA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280997AA858
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A29193073;
	Wed,  5 Mar 2025 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="jQrHHIYS"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC1252905
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203935; cv=none; b=g29ty9KWTVFZ4iZpOV180UJkIhewxhWnEcndcISgzn9p093dfWvq0/JdbaeeodGbXmqguFmsH7CdLtltxMfEg5NevmahYGy5yFof8jfV+CtPhstXoXwEaQ4InXl2hvmMFPIqEgjTc3CbQflIvKhJrsSGcVlj1gmTeQFEHPCtoXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203935; c=relaxed/simple;
	bh=L0/NjBYMyAAX+J8A+8If5WNs/P2T9ayc35922aAeR8k=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=LwyN2p+5WMzyb5ix+b/FmNiNdqAtm/Je9wXSGYMczXgJnH01L2gyJ5pkiYpu/Gy9TCtEWH2TDNePjfbr8G6b4Q5z/L+mwyDoZ4ihHgzgp4VfKDcP5tBG8Qf3thEEA4l/5MzdGtCtPK/mVJ8O+ldLFM4x0lcVkz40oQ788Pj+13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=jQrHHIYS; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so1149078276.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 11:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741203933; x=1741808733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcPmB2MecRuBv7aPCPDvLHkCBR6SaAXrKKkXG8zDI0A=;
        b=jQrHHIYSdElEVGFfrPvUpj6hjriCEAL2t28jBXI09QZzlP3VHkgPa7JwXex8wQx1EX
         R4xlfKfb2ACwHnb24qd4yu/Pzm+KidoeUElUZjZXXY6cLsasS86TuIJLUWEM1ji1BxZp
         x9GDQEJ+crcUSEJq4L8D7wJr5D5z4q4u3hTqLCTvFqlP96OkS/0chJVqIXIV9pefF9o6
         slxtG/9WJLwqZflsAOp4XSwR38hzQQtSlN6kyQl7nmfKyVgIsG8Z3bH5lu4iYeTSfA9d
         s6qKI6WH/MU/Oi6BDHTrCaHw4WEu2T19JHUnCm2VDuuJSUeHabB9tPNbPYAHwbNv2Cm1
         srIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203933; x=1741808733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcPmB2MecRuBv7aPCPDvLHkCBR6SaAXrKKkXG8zDI0A=;
        b=TEHc1d0G6vJnhKEm/ffZt+8lZyBpJl9fec1JHNBZVuHKu4gmsYTKplySvBFMfmLh+z
         IpnsADx+phrc9+wg8GK1KNyBWgHIiu2VXwzuavcdqDbXABUADMgx5kKMN0gGplLz65MK
         S+YrZljrJIRFOUIDKtrZh94unaBraA8AqgIIL1A7SBGI/ZUw97cnLEQ1LmkPhe9Gq1qx
         L+m/+rH1r04q4O0qNJZE7QHG5na8U6WzlfDEahzTONuZlTaJQuvwwTzrwV1ykmAqblhb
         lYVaTM00ehjL4A4EShJP0lPMLL7nzTuoCoRr1dKoAc0EdUTupTOkqWGFgIalEijvcbqS
         fDkA==
X-Forwarded-Encrypted: i=1; AJvYcCVDzdUYH0clIMLzxDQOBUbfwzBfWhPtDjM2RxYI2s+TGbiJ6oMx6uNH6U80EaZwABg4GjJ7/Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIEvHhx8lMkaLZd4Qeo4AWOJiHUbhmg5ouaU+DPmdbn49xiMnm
	tk5CvX89GNyJFe4YaSh9a33SK8AnEdqQlYZ2ptu3WDZy+1VerYEZrkIpEWXe3F2Lut6SLuThrKs
	bM4W/U3X97trCReunAsPFuLKiJCY64JXPUuYvdQ==
X-Gm-Gg: ASbGnctlIggNmDlV64dfxQyzPzTq1vj3LSDwatotHm0rMsK9JjrQZsqqdGNh3sA+j/h
	arC7o+Ubqy31DU/dSBH00sS7fEdtNMBkxntgyyX+dBfC0yai6yX/rgCswEOqwOKsoyW2l0co0nv
	gnCwLEb9p8KUr7slAG/LB4/vL6ZjINu53308lAaLGYa6lIY//ZvBqF1+mMJlc=
X-Google-Smtp-Source: AGHT+IFBjKRQeQxGVbhDcXlSHKUlj49aLb0/YTGp+3sXlyZrJUGDJx8XfDHOm1i8AhfC9A9Hn0+e/I3capGYTqUqjDw=
X-Received: by 2002:a05:6902:260b:b0:e60:e14a:df93 with SMTP id
 3f1490d57ef6-e634795297bmr923254276.10.1741203932720; Wed, 05 Mar 2025
 11:45:32 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 11:45:29 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 11:45:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Wed, 5 Mar 2025 11:45:29 -0800
X-Gm-Features: AQ5f1JrKQALfG8DO2AJdLktlNYAzUSdA4hDWwL7UBWO97GhTIwSE048PwZRExwg
Message-ID: <CACo-S-2dn81k6AiwwBqrEiAj+i_eRviH6mrEyrrw0F-ccMbxgQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCkg4oCYc3o=?=
	=?UTF-8?B?4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIA==?=
	=?UTF-8?B?4oCYczjigJk/IGkuLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 =E2=80=98sz=E2=80=99 undeclared (first use in this function); did you mean=
 =E2=80=98s8=E2=80=99? in
arch/arm64/mm/hugetlbpage.o (arch/arm64/mm/hugetlbpage.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:6e4ee7f7604c92f861d1cb98d=
9b4e90c99eb5508
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  43639cc57b2273fce42874dd7f6e0b872f4984c5


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/arm64/mm/hugetlbpage.c:386:35: error: =E2=80=98sz=E2=80=99 undeclared =
(first use
in this function); did you mean =E2=80=98s8=E2=80=99?
  386 |         ncontig =3D num_contig_ptes(sz, &pgsize);
      |                                   ^~
      |                                   s8
arch/arm64/mm/hugetlbpage.c:386:35: note: each undeclared identifier
is reported only once for each function it appears in

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67c89f6118018371956c856c


#kernelci issue maestro:6e4ee7f7604c92f861d1cb98d9b4e90c99eb5508

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

