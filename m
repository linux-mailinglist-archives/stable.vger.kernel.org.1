Return-Path: <stable+bounces-136952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E8FA9F908
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9765817A941
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA5296D31;
	Mon, 28 Apr 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Q3Pvaev6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E629615B
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866758; cv=none; b=Rc88ehtNsv7nBWUm8fZL7T/qhM2+XP1UXlVHpF/dhCUml0ytCsP5tczDAI/iBVVDfhiLk4BCw7KvNVZxkDUTQV1XXShLTZgldKaSmOTbDJ4ZifVyf+jV+H6M8Jge8MNLQkCL30foHsJRuSRK4VBIHLXte3AnNSJV9p0rINNa/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866758; c=relaxed/simple;
	bh=pC8gRIwhmnpfyEDzH1GwbSId+hqxugocArFsEUjyhnQ=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=SnzpGn+Z8JjgN3iqvELtmP4Watq2LXhRAbh84OrrP5sEuWeAbOt5+4C4Szb4EccvVy4xP3XZGE0Tw47RdqlCi8WAEsX45bErkl6J54asPqdRbB19QCYxHtVmNWQOLRz2+KK9HFZRxRdNUpQk+Xe+AslTQBZTMAlO+adgnvLvD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Q3Pvaev6; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e73120cc26fso3243632276.0
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866755; x=1746471555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SES9iHo0519iWs+rzt1yyxP/Hw9bQVkVPrkzGLZtTA0=;
        b=Q3Pvaev6Jvhzt/zfk6z1AW9U+bYT2VJceICgU7MwK3lJfVZlohLuPpO98zz3Au8Jab
         7FqHU4L0sMvTFZJHs8g/NGSueLK9i98p3BfGT6GFWYufSb6eOMIawu8t1+VB7ofEei5+
         w2s9JiWtkck5xNVqb90Aw1oiD8kW12+/CEV1ma2Ug+dgxirIv4FHrOKUPTecWnaSXY/e
         prFUs/Ddx39W1IosW1Gn3Hhw2OAjGNUeZ9/Zjry3bvv5V9fvxLrhWtM2xLSRlK7qDdeO
         YObuKpj+L0grzGp0Z/uDdQjlhkyKsj7zpczVtp2GrMFrji4aVs9+blWh/xlViWGhrVV+
         wQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866755; x=1746471555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SES9iHo0519iWs+rzt1yyxP/Hw9bQVkVPrkzGLZtTA0=;
        b=pTSpgnPFba91Hd/FYM7sdK4LEmN/iNIUYgE2X00D6PJsqTrnYAQdDLRTdPF3DuOnCv
         A6uX3cYYbVY4Uo6OR/2Xgl3T7IqEYLksa92PsnE5CnHfJbPN395MyLciiT7tSqnShUoS
         iJtzkNvUxQAEu5g5aiDO2cDb/o6BlUI8FNLNHcI+77PgsBmySop+BsiUNMVJUHT9UB4r
         wp18Uh+jxEpwKqxVzWz1CZIMBN/HZrUmEHj5DeiiTOELv11u+La+0UBhfkalZ9qKdi6s
         9If9iaSDIlkIRjepV2jJAMd0IFi1OKz6xj20xpq/kqVXCXEeAVa/i7YNQ467Nr47fz62
         YDwA==
X-Forwarded-Encrypted: i=1; AJvYcCXkRaq6htmsFTDV0UybEhZ/UCRDdUrXmkQ/CLJdBAnDo46qsL/ygHdKB09zb10/IxxuTFTwpDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiEIHnCPRNRcQcyCDuxyIQaoFoNduclqhpubqUVbgU2SycN7U
	v2yKtsQEiSY0CT9sK4e7KzjSP7HoMJnYQZ7FAyYVAiNsbD6S0tLLcflkfE3BJrZbacAKIEdsMSi
	/hdZLuDKxpm48GVm/h8+Zuqozoj/i1w+eFXjBEsrrSrHwu7SlmDc=
X-Gm-Gg: ASbGncvy7QlZxeB6ugh23f/NIKEj3rYOnddBvRXHSk0NQmLTYSTw8FE/qN/crxRpacy
	6/K0yZaDiae6jwBUrlkEmxmcCV34enV9D41qPwhjmilLVpxsLr8baVajxGtZEuNtAJCZzsnpK35
	x87asPQ7RE9ieIsY7zzBj5
X-Google-Smtp-Source: AGHT+IGAhCEOshwhGNjewTLDYrxh025YXeUZpyjqbtgx0Cik5BHcgEljKBsz7KKCoKsRMvx4wcT3L9mFhtSHT7MzjOY=
X-Received: by 2002:a05:6902:100a:b0:e72:69b1:c746 with SMTP id
 3f1490d57ef6-e73233b219fmr13776663276.26.1745866755047; Mon, 28 Apr 2025
 11:59:15 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:13 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:13 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:13 -0400
X-Gm-Features: ATxdqUGQo0Ul6fY3nFm4Q6KpSK8MmGUbRIbGMWtQZBubsF6TuJURBIbGU-00Bl8
Message-ID: <CACo-S-2yVbZCQS-FCTC98_2rDXmG1u96ey+n9LrU5HDwBh4Now@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjEwLnk6IChidWlsZCkgbGFiZWwg?=
	=?UTF-8?B?4oCYZXJyX3B1dOKAmSB1c2VkIGJ1dCBub3QgZGVmaW5lZCBpbiBkcml2ZXJzL3VzYi9jaGlwaWRlYS9j?=
	=?UTF-8?B?aV9oZC4uLg==?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 label =E2=80=98err_put=E2=80=99 used but not defined in
drivers/usb/chipidea/ci_hdrc_imx.o
(drivers/usb/chipidea/ci_hdrc_imx.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:8334bdc588cf39f59f780a79b56b0=
197445bb931
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  bcf9e2b721c5e719f339b23ddfb5b0a0c0727cc9


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/usb/chipidea/ci_hdrc_imx.c:402:33: error: label =E2=80=98err_put=E2=
=80=99 used
but not defined
  402 |                                 goto err_put;
      |                                 ^~~~

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v5_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:680fc04043948caad95c0d34


#kernelci issue maestro:8334bdc588cf39f59f780a79b56b0197445bb931

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

