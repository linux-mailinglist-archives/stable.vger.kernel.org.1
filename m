Return-Path: <stable+bounces-154578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3AADDD83
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B593B956A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEE2E6D13;
	Tue, 17 Jun 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="qNexeBRB"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703C28C877
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193951; cv=none; b=fmQ3C9ObD8e+r20Xy8yOEBlOTgzbONBK3g5aE2lxs/cHCTv2MDqYC7s3cYFrH5zLET1MFAmdEVMfaiYF4mf24Kzpi7nWG+TwKJvvkV6rwwXcJdAb39hgqcDuX+0aRVBsU/NRu4Gu8TFKYzSdNHi7TlJG0x/dI/rwak20dEMTg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193951; c=relaxed/simple;
	bh=FjvbQDAu+oZzn8TW5EKJNuvj3CrTtpM9vnoGxAYgoOU=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=WKVazsWXnrWO2SRYDgQ6UEDDqb0nHAT/oIposidd7CGmzjU2qn6pXIiCwtJhwZiLk0n5xZ7eXBynb2PnrNUxSFxo8TGLuDRTSRiflWDJLoQBSZAvlIf3Wk3c78DqJh2OC1jpx8ksmEDI7tPvKQ639xr4Orh2Vracci3r0o+TMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=qNexeBRB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5995411276.1
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750193946; x=1750798746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vj0G2kNS4cHUit1jaFUJlZARvQl211K05ZaLMvscpuk=;
        b=qNexeBRBr5OO+IDWSyPasBR3do78ty2zERrA+Vp2oiZdFA2VyEwpXSFaIXsyVC6RKM
         DHjMvuJ+oUMl8oUsxnjgGElPUIhgb6s7K+Xm2ZnqwfMAAanRrwaATNgSQZByJ5nEqlRU
         MSb300eUik41nCOdbn7noBLWE7HC7n9tu2gpdBTcyVtbOvcfDbpx5T1ik9oNpF6HFahW
         j+6/VWqczJKNpcGe8QCI/vcf2SbO68Vyd0ObtENLlspp8dBP0SJ+JaBJ/zKb6yzNyyY6
         +yqRUxoAkKxlNue1TQw+SeZ/orWdSCDy/AwVBi7HH7Ck1qyP85F0is+k4stJ2+LSliVs
         7kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750193946; x=1750798746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj0G2kNS4cHUit1jaFUJlZARvQl211K05ZaLMvscpuk=;
        b=C6FrfamabkQXhgnplGFpmsP6EX8W7zAmxCe7W+1LOoL8T5u6+8RHkunWqfLse1hpwt
         dNz2x8jq05pMJiZmwR5Y5Z2WNqOujNcySNXvZ6HJPWLLzL0dgL80+YW8oCJJD+e402fK
         to16/EgEWTkr5PgrayifHVhEk34d7EqxkQDuFvVXsFkbATo1/8vz/DdnLYQS6X0AmoAd
         HNbLJvRmsXaxRj8rDQvtIwyGGDJyfQH0gYpsB3k7ZZP0aOxcxVM0ISc32AJcZYudYN0p
         57VURWuXKuLFR4E88fPKLaITurZGTKFAd/3ldfd7giySejwoSsTjlvBn3P2ygAUu8QXE
         +45g==
X-Forwarded-Encrypted: i=1; AJvYcCVr4GOT/kWjJtYdpcUq6HfTR7Yuzp3CvsquXXBnkQuTFzMp7h6RGPRiNK4KZhBE/qr5qnnqXfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eazy+hpRFF8amC6rN0yS1aJwAKwR3GzplaVSdS9KJqDOfbsR
	yKxZEYbbJMT92+YS/nNwAuiDQopYgN7kW1xhAxehR1CJU8Kv7tqj9KMicko0OcwURnekOs9I25+
	sA+xzZLoPjV6CGFa9MnoTIR1eYrvQD+saxW2oV04f9GtaMrVXkANc
X-Gm-Gg: ASbGncupNkL9L5Kvuw9zWhrvC/0tXLzOgWZZ6m8Gb7528eTUG1M610AmDyxWnHV77C1
	iSwLUz+POEn/k15Kfoy9Yfq0XN6wUarFzvn0abAQ6x0/bsZjqLHAmpQmr0qG05+AgS/lhRD2KUm
	eDYBDuahs7EZIQx18iKdkkZWwCCfejN6cPLLGJ7+SXQg==
X-Google-Smtp-Source: AGHT+IHwjmdGFRqpJF+Fk+o8ecsRhkQDsV6uX1joGi1mtLp4X6B0FU4Js1br9ZEFWp4tNXYEQcF0qdHoPMrdvNQAzVQ=
X-Received: by 2002:a05:6902:2208:b0:e7d:58d7:7167 with SMTP id
 3f1490d57ef6-e822ac7920emr20840832276.25.1750193946328; Tue, 17 Jun 2025
 13:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Jun 2025 16:59:04 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 17 Jun 2025 16:59:04 -0400
X-Gm-Features: AX0GCFujCE4HWVZMVY3H_wLLOHjSZyU4dW01VfyjcbXX2nghhR5kB2-nnkm45Gw
Message-ID: <CACo-S-2WfXc7zyAvEWk1efOFtf6V-8UTC38MmW5b=5Mjk2kG8g@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEyLnk6IChidWlsZCkg4oCYbHZ0cw==?=
	=?UTF-8?B?X2RlYnVnZnNfZXhpdOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rp?=
	=?UTF-8?B?b25dLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 =E2=80=98lvts_debugfs_exit=E2=80=99 defined but not used [-Werror=3Dunused=
-function] in
drivers/thermal/mediatek/lvts_thermal.o
(drivers/thermal/mediatek/lvts_thermal.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:fb8aae5340da55b6254442f085814=
7bf5f0b39dc
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  519e0647630e07972733e99a0dc82065a65736ea


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/thermal/mediatek/lvts_thermal.c:262:13: error:
=E2=80=98lvts_debugfs_exit=E2=80=99 defined but not used [-Werror=3Dunused-=
function]
  262 | static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
      |             ^~~~~~~~~~~~~~~~~
  CC [M]  drivers/watchdog/softdog.o
cc1: all warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-6.6/arm64/chromiumos-mediatek.flavour.config+lab-setup+a=
rm64-chromebook+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:685194ac5c2cf25042b9c1a8


#kernelci issue maestro:fb8aae5340da55b6254442f0858147bf5f0b39dc

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

