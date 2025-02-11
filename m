Return-Path: <stable+bounces-114925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E751A30EF8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF35A7A20B5
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7F2505AC;
	Tue, 11 Feb 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="HTO7b7tv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B532250C14
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286054; cv=none; b=rLH6yOUTNEPfhKu6QzJb38xuW+DjIKH60g3L7UyLzm7mLW87xBaFYFeZmniR9Fj38svW9h1Y0Wuek+ZUUWlzQ6sU5DVwB0DksZRUhel3uwTS8Kt2M5gEpEmSTaIGjdvm2pTYzzJOGa6c798420jLw9WrM+839ZkESrb/LGgT+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286054; c=relaxed/simple;
	bh=uJrn8mri/mYrtEMUT5S5SGUcgQK1UyQITmUNsdpZ/GY=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dd8arYAfWthNGuBkSmRt5tPZ5lpL5jK95YRO58BDAky07xC7OFKAP0Ug3IT1skljhlVHV/tO9nysADFfZljGt1lk/KQJASx13oNWemDAQDRdoV4enTE9NsrNy+miM2Z1M1ImBHiiTmyp6kuwSTw8pKLSDYzFg8YXNRBrNFOxjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=HTO7b7tv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7d583d2afso250389666b.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 07:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1739286050; x=1739890850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5DL9DQnnc8aWdWAlr+eWkaFQCZ0JnubKcQGnF1dL9k=;
        b=HTO7b7tvRwriH2qGDs9KYhcf5UYqqgtrSTTaL3wobXxXNNxgWCGl8L1N2KuI36BJ6n
         YzOG/Gn7k330RW+ApCODhAOVJzcf4li7LtK2rZjx4fCm4JV/e5BM5LPCnkcaoxVekWL4
         vtM2rY+R07T5fXV48+r6KW8lLLycPbLqLecS/SbI+GuYchIosW09FoEBQ6brM0j0Tykx
         1qjvR5y0TGyHwZlqzq+YFuI5dJy3t+KPx/rZkoa0U/dG6zLesm+s5pk5r+COn+Zf8uFa
         R5EjTeABNvd8sIWOEoknSgDKd4r1+TedXQk96ZITGTt1Y3NJXP62iSvkeaVtcHCk/5rs
         HEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286050; x=1739890850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5DL9DQnnc8aWdWAlr+eWkaFQCZ0JnubKcQGnF1dL9k=;
        b=Kb4Wd1fHY+PPdTj+58x21gSNACqQALK3HdVZQAK/LdwowrTv/9gTIGD3L7OV912ZrG
         ncrGx+EeHdLCDQY08dfzZl/ObJEu4FTse46FMAa0Ydpr+I0HBYKIx2VoHyQZ23aNfD0E
         75rb5u3iRgEWFTY30SjDT+m8VlJ+rRohOwtVV+mvhrbiLoGOfVIpAx6HKsDSpNntXL/N
         rp29h/w2cBah+IW794O3XvH1sth5aoj17HRYUTk9d0YPU3lg22BF4BDHJ+SKY6LtdjP2
         GviAqDRwrb0azfpk7ApbYVenyEyYLVYrPh+zcMmQIShOLit0Jb8hnbvN9HASLsrwo7wN
         akDg==
X-Gm-Message-State: AOJu0YxCAFBhOF75Z4XUVEIMdvRpxN8ID2KyeftwJyIUVoOOZ5+8d+wX
	ge+bc9Gl3LucfPuhiKsPzRTu1M/flrN0Knb4xgwcU1PHEUYbYyushKpDTfkEFwoW+33VTaa2FCw
	ST3dmpXJMDCkROC8wUPHcKArNbgRvWyQ7TCAqee8LflcFznAadOg=
X-Gm-Gg: ASbGnctbt0SXgfDf29+CyDiOCGG1QYTulztGSl02rCUsxaN60vh6RZe5NrGI+aTA9de
	akxaEQa0o/8wYr9dE8h2aGV3ORDEVXVAvJPb+jEC6vqhDPSfgnySBCBKYKZ+hZa6VFZja3WO1YQ
	0PpXq2rdeiYzkG/3Q4wRpkSb2BLQam/Q==
X-Google-Smtp-Source: AGHT+IHwXbo0RJwD5vV4an1/KDsxLB835Zgj4fYhhnfuhWtjtM5rG9JGtoRKb+1r3zUZM/ciPbLsxK+WgtWhsuSSkIs=
X-Received: by 2002:a17:907:c302:b0:ab6:c726:2843 with SMTP id
 a640c23a62f3a-ab7db59a996mr358394866b.22.1739286046970; Tue, 11 Feb 2025
 07:00:46 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:00:44 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:00:44 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Tue, 11 Feb 2025 07:00:44 -0800
X-Gm-Features: AWEUYZkbrIv1wry5qFI2WIfTMZSp1Ht-3EmHZqQLAdhxR-LUBEL-RuDiHj-F3hs
Message-ID: <CACo-S-3n-a1by6=xXStL5mK8Q==Zy+3SVPr04-YpHpuKGwyKFA@mail.gmail.com>
Subject: =?UTF-8?Q?stable=2Drc=2Flinux=2D5=2E4=2Ey=3A_new_build_regression=3A_implici?=
	=?UTF-8?Q?t_declaration_of_function_=E2=80=98drm=5Fconnector=5Fhelper=5Fh=2E=2E=2E?=
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 implicit declaration of function
=E2=80=98drm_connector_helper_hpd_irq_event=E2=80=99; did you mean
=E2=80=98drm_helper_hpd_irq_event=E2=80=99? [-Werror=3Dimplicit-function-de=
claration] in
drivers/gpu/drm/rockchip/cdn-dp-core.o
(drivers/gpu/drm/rockchip/cdn-dp-core.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://dashboard.kernelci.org/issue/maestro:15d7ea9fd5f2bedae=
85bc45a4267a66024d1b429
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  16f808b001a697126972a39c8a2600c33a616ebf


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/gpu/drm/rockchip/cdn-dp-core.c:981:9: error: implicit
declaration of function =E2=80=98drm_connector_helper_hpd_irq_event=E2=80=
=99; did you
mean =E2=80=98drm_helper_hpd_irq_event=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  981 |         drm_connector_helper_hpd_irq_event(&dp->connector);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         drm_helper_hpd_irq_event
  CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/dma/gv100.o
  CC [M]  drivers/gpu/drm/sun4i/sun4i_tv.o
  CC [M]  drivers/gpu/drm/tegra/gem.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/dma/user.o
cc1: some warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (arm64):
- compiler: gcc-12
- dashboard: https://dashboard.kernelci.org/build/maestro:67ab2fcbb27a1f56c=
c37e008


#kernelci issue maestro:15d7ea9fd5f2bedae85bc45a4267a66024d1b429

Reported-by: kernelci.org bot <bot@kernelci.org>


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

