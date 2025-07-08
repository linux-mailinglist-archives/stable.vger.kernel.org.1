Return-Path: <stable+bounces-161330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1FAFD5D6
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362C2583103
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23052E6D0D;
	Tue,  8 Jul 2025 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SVK4GYAZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456042E6D08
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997554; cv=none; b=T6kNO332qTIlxnWuIBZwRKk6E51lNSINH8fSgfTF3p2amHsf8NXDC/xSo4cU+bUf7hJJkbLhw2cJ/x3b+7e31b9RSmQm6MxSbPO3GQJxNKuykVwbr18Ik8uVkvGLwE2qay26dz5tGoifGKsfJQ+RT8KfzGtnjeArwuSzKUg7pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997554; c=relaxed/simple;
	bh=t1MZSjDP6vDyXF3dphNAN3CeZkrhpOTyRV2QY1xbFFw=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=UDym+n1oH4JwzTte14A5u8wWUF59c+5zFU8fdycGczQPX3FtrYFGe2twRZvzYqNMdYnsM/+s56OmQFjTzU4t+o4May/stTJA0iiRc6i77i+kkxH8uZgKnqNT4o3dHUAMLa+9FdgnHnEIJQZG83ZJZr8FwogXRF84sYfjBF0GBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=SVK4GYAZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so4318613276.3
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997552; x=1752602352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=em/P8jyoJusazo40SQL/Fi83LRVqdngWzYUHxpvDseU=;
        b=SVK4GYAZ8FU1cMepBEUXblHz4pA3N3YrOF098RJ8yiEOnxa2lgXflkl3BG1Pbn923d
         cop3eYI/dYPD7xt+vqvIDW1A0MlSaG52wEDZ9nzL/0yX7EK1yJvsGQUgY8Ev9ZWxJNM/
         LktJAzp5ayo/mgzhI4YQF5V5tBX9bux61AQA488VUrssKbnSbIyDcIq403I4UE4Hg/6I
         9AjRXmtu9KMQLlNhtwjiI4xbrxwyj1W8Ukbesw7JH4e3FaiRpQjbF0ksd8aKqoHsL8Id
         Il0Rji5U63cTtgS3l7FzcGKQeZVLOIJpGo21xu8Iiy/tSSELbSIBSH6x/uvTRtbP9e5h
         S/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997552; x=1752602352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em/P8jyoJusazo40SQL/Fi83LRVqdngWzYUHxpvDseU=;
        b=hgjVFR0T8Pe8N6IdlT+coFWch7W/oKeGciArlM78FVoC3AnRmWpFwaVEaE1Q8gs7Gj
         YPAqt1IhJHDPOqROZ177PYuygrYNTBRocY72M2zSWiNlEoeSxCDrRNhJkjGitMgqDEdw
         pZ04ulpZTCotkjvrVOKCR/CiFjE4JMuE1jm6U9FKxoJaG4nfhYSeBvFERiEx4h8w8b7q
         OH64KyTa1JkBN5B0TN1gC10sm6zKnDG55gcCgdLDNU+Ik6S/Hf54dy1bBNkC5QyoE9zg
         pXqABtBvunqsvsxDzQrRK88ubvxpR4lZYT64wNa5Ue/SDybitfLNNBO1uPee1TWNAJUs
         TKzw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4nxCKp6ctW55gchItGTYM1WRXIBt0b+/KLQB1VRGBHRgQjK0sXNpAy+nVz37rt4SnQ/Rqoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJtGeaMFPsphxZPbgRAYqM2yzMFcd/SBJ6wZ1GVeBbfmK9LlW
	iHrIWe3a8RcFmSN8aV40qoovFOPcUlh8rSSjrfJ8bUxRMl7Uy7Y8hOkzFXGP6Hbu9sSwLo+MgXC
	xk3LRaZRgNFgDrFM2Vo2I1ytH+io/lJV0DrZW5B9aU91lKCfGphKauRErAw==
X-Gm-Gg: ASbGncu1Gb9SOUbCCV7nKV9gipxFBUO9leLfHWP6rZFyFCWzcf2jWNzg7brpBHilU4i
	SY4ecwN5Q3KX+kgOnL61MHv9cVnGDftww/P2IJcIFvW5ZGjjlA9DA7Tc3DV+DjSmy0kV+PaWtep
	deh0wqhCg5cRNvmjTJ/x19L9zZJz4eoT/63L3YEqRUvA==
X-Google-Smtp-Source: AGHT+IGqxpalozm16Ukjr1bU2pkUw80pv7nLvmJ3Z9ZmCQG2B/P22kQSHQ/sgLfQI3mKtzLaVJUCkq+VNnGQ01rF2ic=
X-Received: by 2002:a05:690c:9c09:b0:70f:9fcd:2075 with SMTP id
 00721157ae682-71668c0e0ddmr233717017b3.3.1751997552249; Tue, 08 Jul 2025
 10:59:12 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 13:59:09 -0400
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 13:59:09 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 13:59:09 -0400
X-Gm-Features: Ac12FXyXgb7q5Gt24MgqyE2hz6ikXibVJxOQDZsv-MH0MMYWQ5yPuLqmcx4L0LM
Message-ID: <CACo-S-2iWPJeSF5rcdKUQkpV=gzxKFCETp6y4hGj47Pxq83qvQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSBpbml0aWFsaQ==?=
	=?UTF-8?B?emF0aW9uIG9mIOKAmGludCAoKikoc3RydWN0IGlvbW11X2RvbWFpbiAqLCBsb25nIHVuc2lnbmVkIGlu?=
	=?UTF-8?B?Li4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 initialization of =E2=80=98int (*)(struct iommu_domain *, long unsigned in=
t,
size_t)=E2=80=99 {aka =E2=80=98int (*)(struct iommu_domain *, long unsigned=
 int,
unsigned int)=E2=80=99} from incompatible pointer type =E2=80=98void (*)(st=
ruct
iommu_domain *, long unsigned int,  size_t)=E2=80=99 {aka =E2=80=98void (*)=
(struct
iommu_domain *, long unsigned int,  unsigned int)=E2=80=99}
[-Werror=3Dincompatible-pointer-types] in drivers/iommu/tegra-gart.o
(drivers/iommu/tegra-gart.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:09d85088a9b9d1ca7627ec9c7a3e1=
ea69a47f790
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  b5872ed076bddad62df34a0ff4cbe4bbdfe45a67



Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
drivers/iommu/tegra-gart.c:281:35: error: initialization of =E2=80=98int
(*)(struct iommu_domain *, long unsigned int,  size_t)=E2=80=99 {aka =E2=80=
=98int
(*)(struct iommu_domain *, long unsigned int,  unsigned int)=E2=80=99} from
incompatible pointer type =E2=80=98void (*)(struct iommu_domain *, long
unsigned int,  size_t)=E2=80=99 {aka =E2=80=98void (*)(struct iommu_domain =
*, long
unsigned int,  unsigned int)=E2=80=99} [-Werror=3Dincompatible-pointer-type=
s]
  281 |                 .iotlb_sync_map =3D gart_iommu_sync_map,
      |                                   ^~~~~~~~~~~~~~~~~~~
drivers/iommu/tegra-gart.c:281:35: note: (near initialization for
=E2=80=98(anonymous).iotlb_sync_map=E2=80=99)
  CC      drivers/gpu/host1x/hw/host1x05.o
  AR      drivers/tty/serial/8250/built-in.a
  CC      drivers/tty/serial/serial_core.o
cc1: some warnings being treated as errors

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d54c434612746bbb54a0f


#kernelci issue maestro:09d85088a9b9d1ca7627ec9c7a3e1ea69a47f790

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

