Return-Path: <stable+bounces-154545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D600ADDA0A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709D819E3A4D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1DF2FA639;
	Tue, 17 Jun 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GBU38bcn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865922FA622
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179549; cv=none; b=XPD/nVyPMnd2rPkuIFlcW2+MjIsB+YXBbj4m5863ZC/F4+Mts2ugmUXmfHfpSboBgzVuSgAL7AX14p/Xu+KzRr1B+WZosXgPFAo5vkYHjJ53o0lMdpZWeZTkDAksun7UIYZ2bTR1jU8vsgJbZBqU99f/uuGOXlkJeVLEJr7W3C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179549; c=relaxed/simple;
	bh=PDcXFNOiTkRIhr7LSSHHdhniXrVOXbl3Rs7W2pVlvC0=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=sEiZ7cwkIx1/3ZivzGqQjs2sLHexjl1ytXR6vV1yVXKc5cpXEnTGup5BrJ3ut/H5vNjmxJeQifgeh7YyAEnmOGCzr/UHHYlIn+4a16L28a+jkAjK8D6nC/+zkGhR51UW1TiUR/XfBg8yKwRsFr+3L8nax1ypivqEuO3RNDHKLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=GBU38bcn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81f8679957so5344877276.2
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750179546; x=1750784346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIF+oQy1pEUFkmtjHrEnoBsNnG+SZy5UQiEkhkZzgGA=;
        b=GBU38bcnmCk+x44rK+K/q1yJmcNhaS9Ny8pVRr+ZTKEZa0u8suVHFaWI/7e8VdVYch
         vTgNGRgRTeuj53nmWTgvU6y3dP4LRakwd8gnNZdjKWpYIN/2lav0R4him4ZGsxj8Hvyn
         5/U6drL+JyjYnZ8s9738jH3MCXZDaCBSqpc6HxYuVtTouaKUugnwVGmesu90Ufqo0htJ
         vFYZRXJj7Nz3II4DHcMT/BBfplTLhTTGZlo8U4ADLEKVFR0eOIw6yu4gsYDfBne5hvvT
         UtHY/0y8/79ScaFhhjb9gPaETtsP1Zm0g2MVzaiECZQvqk6wGE4QEPQJpv30XMBKCrq8
         qcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179546; x=1750784346;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIF+oQy1pEUFkmtjHrEnoBsNnG+SZy5UQiEkhkZzgGA=;
        b=hBKYsYEPZjdExB/WhHK7rFbHMLi+YL2VkotZBU9y8CwbBw4VD1sjfmL+l7UhQVpzm+
         Lh38s9cQcGJ5c3/MNbZ7w/GKAMZNm9Qh8iXEYadKoPaNDN1RDrFiAhFgsw/qUnTHmQtl
         BJT9Hj+racVIb6jlAzz5b4bU41ERc2f3ph4jNPUYSlGV/+tWdFsY4e04OcrvF6KdXzZi
         rnsRPq5FUTH+a1fnMYVo/ZxMC6bmjgOVB/zCjGFXDtudlq9gAet0nb1RcpmoP7rVAkIb
         OEjEMCrlI+esON4mzKybkSApj31VOtUGRw3BVQOhG5PxtnsMuZ4ND7rXldXVmzG9HYxB
         St6w==
X-Forwarded-Encrypted: i=1; AJvYcCWHhyVBbvdyYaBIxceTWB6VhE8Ya/mURXw/u9W7P/sCtUw/52eMxrJiSbFxG0g796Ua137Owzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhw7YYKxAi5FnbV3Vfj6Y4XtBjtairV3uMWJCpFqCjkYXw6f6
	TUnHjgymtFqfp9w/BQxqqhuIYHSQZW5FhpXm03gWXh57RQfQhKnS6Oz6VBQpO4alYeeHQqdX02k
	ify+eGCgORB8F2hzgOy2Iuca+cPABnYp3ZaOiawB/rQLksEhaeUqe
X-Gm-Gg: ASbGnctJc1ow0GoOKPQDb+rpcq2zukt9/cj0TeX6PbCOElQ7wxpzJON4kDyWyxunZbl
	WemJJb0i53Pxt6FlnmSdgC6fF3V46yoYZMR5C6DtbEltRv8u6tXjOd1lCRbXBLD7SZIINbLpYp2
	Ce8p2xQK+nqpmi6fTFPapkpD2maHdiX2UdyuFEn4NMWw==
X-Google-Smtp-Source: AGHT+IEad9wO2dsyLD6BhLWYIECPEChvfindf+D3FSw7yOEsh+iufs31ivkk+n1TVRqAgdeerHubWAKTq3B3Xt4h/sg=
X-Received: by 2002:a05:6902:4609:b0:e7d:d037:c78b with SMTP id
 3f1490d57ef6-e822ac5d23amr19025154276.15.1750179546394; Tue, 17 Jun 2025
 09:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jun 2025 12:59:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 17 Jun 2025 12:59:04 -0400
X-Gm-Features: AX0GCFv--fQuXSqf4xPcGDTT-f8_gdIAOo85nAe3vZisQd3smmPIVoUEvKX1aBM
Message-ID: <CACo-S-0=4AyyPc=WKjWvGyzFBXJr4xMXjsyZ0D=mays1cuv8-w@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) in drivers/firmware/qcom_scm-32.o
 (scripts/Makefile.build:262) [lo...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 in drivers/firmware/qcom_scm-32.o (scripts/Makefile.build:262)
[logspec:kbuild,kbuild.compiler]
---

- dashboard: https://d.kernelci.org/i/maestro:04c1ce2921a16b59c7329a6026c59ea7942ef691
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  e2f5a2e75b315706dd2d1d50a4313e5785eb189d


Log excerpt:
=====================================================
  CC      drivers/firmware/qcom_scm-32.o
  CC      drivers/firmware/trusted_foundations.o
  CC      drivers/clk/qcom/clk-regmap.o
  CC      drivers/gpio/gpio-pl061.o
  CC      kernel/resource.o
  CC      kernel/sysctl.o
/tmp/ccsKkK07.s: Assembler messages:
/tmp/ccsKkK07.s:45: Error: selected processor does not support `smc
#0' in ARM mode
/tmp/ccsKkK07.s:94: Error: selected processor does not support `smc
#0' in ARM mode
/tmp/ccsKkK07.s:160: Error: selected processor does not support `smc
#0' in ARM mode
/tmp/ccsKkK07.s:296: Error: selected processor does not support `smc
#0' in ARM mode

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:685191a35c2cf25042b9bb4f

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:685191ab5c2cf25042b9bb56


#kernelci issue maestro:04c1ce2921a16b59c7329a6026c59ea7942ef691

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

