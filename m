Return-Path: <stable+bounces-124207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED1A5EBF1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 07:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC77A3D8C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 06:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1E1FBCB3;
	Thu, 13 Mar 2025 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yxlUpcy5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4221FBCA0
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849080; cv=none; b=goqcQmDw2UYOs/5flwXIyMomzrkLHU1gGcvZTfTkj8NfU7iLW6c8YM8MNz7X9Yj2B449f8BKj7nqUICpK/aHLikisHu9N1eKsjzhACbVvbaPAUZxf+DYAFeoUvRIoynyfZHf85FSkeDKYzV7juTkO/40tve0Rhgv7ZkYR5+ydME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849080; c=relaxed/simple;
	bh=i+aS6230F9Pf7oru2l/exa62ii5VwUSG1UgYivlTBkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eFMRjHbhRdxtqbwqiLljYrOwQ+q0BX0OO6uoReHBdvMjOiTBFPuCGzs4ubiuAy/GCkplNb8pJdM8deG/UC2kakpBG2W1W3YtRO5m1quwe0xVK6/Q1d9God/VGzVtR/RzrSc0qcx/2cC4Eefx3emHVlQ0klORmMfBupbWdPWrcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=yxlUpcy5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223594b3c6dso10848425ad.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 23:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849077; x=1742453877; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzZ/OwKmmQbXUKB6Ig9nkspgT/x2zvQUcWtNQDAlXJ8=;
        b=yxlUpcy5tJiKgdl/Nm6aV/oPpYabNkPkYFarREDWohXAJPYE2KsyADGSvVZnj1IIXk
         3NllRgW7kPsugRoFW9SIXycNjwRbrKUH24zlU46o57tqKUr5h89y9s4qClMVsgpnsIFP
         z9CKHdEaqpGe6a2V9QDqSiuSWD3FhKPAbJMEm9m6MgwpPilEnwiYWarSX/+AuzR4LpJ0
         dws8nm0ex2PIB7A1Jq3WtKTIcp5o0imVSyQwMnTPKTKSfz6p5RXrfeNKfSZwoSyg1qUi
         vCxPgJEBBN5mbCe2ZCvrcMRnnuP8pQpSiyBTaus1OrGZG5imU9z8/THhs7JbvE7vncTl
         jNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849077; x=1742453877;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzZ/OwKmmQbXUKB6Ig9nkspgT/x2zvQUcWtNQDAlXJ8=;
        b=dtDSAzcJZxeqH01UxUWQgeu1WZ1QQAcyjWFFMf+SLcx9qStCv3NurfFfkP926dpROJ
         m9rfQo7HvLd9PMwxo2QYMJe2GUtNCBIGcl4K8qRQItFPnPgAg8u8LmvNv3L4ekDkH2zo
         AvgOJ4M4zYkUhySUHQPMrqDOawGrqmRsGBDgVfFrrnICFUHncMZgqdFOb8ed2b+NY1Er
         Rw2SZ2KeLW2SiCIA6IzC/d/FrLtg4Qq92rrJ3C+qOQrKPYrWLV45mlhj+3NG15eFYer+
         8NzDBwBYzro9N3aAhVlXmCR99kMEmKsIOO1BuwrzqyN1g5Xd2P+pa2qtJ5MZKncOt9aD
         VLRg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ubLHqfmBnaPoI5VcpoiZcAT8dn1oM2VYmFW5lWIPRz+qU6tqoFhlYxQgH1hYcLo/gl/+/XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Qc9cA4dWaS6tmM0Wz88J2vW1w24HoUTpJ52n8uBY0mbMtkj0
	+K2H0GWWL68s0ZX24e3SaYFupI/c7IchbSlYcfoKSQvbWBMWKXMdCDMMSEkrQUw=
X-Gm-Gg: ASbGnctlsS0B/eXxpOm1JS6ByRvfWcfmUCDHjcSIzs+TN4QMgUGP7lgCNG741dgaZhp
	KI2ZVzs075Ej7cFewxOz08ABYj+njdA7YEEPraMmAVRwoIkLJnnzkFzZob/VYT8EOewDo/PQ1tX
	kx+MKK+uGzMCmmiYu0Tzx2LKHKy53BONhGUwSjRbLxB2K/d4n+W46P0+/kuhJyE6SDLJwSjmBdm
	K+PDDwxg/zoIFnb2AIs51KTIBX9g96IX/2BRSqTGAcj/Ae3nOnGrruZ8P07UfQNac2gnhvB7ZHS
	X0j1QxAgrQPgtDBuCYVv7AlSDPl5QWiZZym2OyK90n9uXnTe
X-Google-Smtp-Source: AGHT+IFJys5eR6oUmPsgD0nQ7bgGFWSfRnMTkiQzEi9pZgL77FdSzGwIkj2Od2Zq73fxdD3yVQX53g==
X-Received: by 2002:a05:6a00:c95:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-736aab16545mr42898380b3a.24.1741849076765;
        Wed, 12 Mar 2025 23:57:56 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711694b2csm624169b3a.129.2025.03.12.23.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:57:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/7] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Date: Thu, 13 Mar 2025 15:57:41 +0900
Message-Id: <20250313-pmc-v4-0-2c976827118c@daynix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWB0mcC/2XNyw6DIBAF0F8xrEvDU6Wr/kfTBQ5QWfgINERj/
 Pei7ULT5b2Zc2dB0QZvI7oVCwo2+eiHPgdxKRC0un9Z7E3OiBEmCScMjx3gRhFdl9opIQHlyzF
 Y56d95fHMufXxPYR5H010a88+UUwxaOdUrYjiBu5Gz72frjB0aBtI7IiqL2KY4BI4r6SWjlrxh
 /gB0d8nnhERlIJupAFuTmhd1w9opBY6AQEAAA==
X-Change-ID: 20250302-pmc-b90a86af945c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-edae6

Prepare vPMC registers for user-initiated changes after first run. This
is important specifically for debugging Windows on QEMU with GDB; QEMU
tries to write back all visible registers when resuming the VM execution
with GDB, corrupting the PMU state. Windows always uses the PMU so this
can cause adverse effects on that particular OS.

This series also contains patch "KVM: arm64: PMU: Set raw values from
user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}", which reverts semantic
changes made for the mentioned registers in the past. It is necessary
to migrate the PMU state properly on Firecracker, QEMU, and crosvm.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Reverted changes for functions implementing ioctls in patch
  "KVM: arm64: PMU: Assume PMU presence in pmu-emul.c".
- Removed kvm_pmu_vcpu_reset().
- Reordered function calls in kvm_vcpu_reload_pmu() for better style.
- Link to v3: https://lore.kernel.org/r/20250312-pmc-v3-0-0411cab5dc3d@daynix.com

Changes in v3:
- Added patch "KVM: arm64: PMU: Assume PMU presence in pmu-emul.c".
- Added an explanation of this path series' motivation to each patch.
- Explained why userspace register writes and register reset should be
  covered in patch "KVM: arm64: PMU: Reload when user modifies
  registers".
- Marked patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}" for stable.
- Reoreded so that patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}" would come first.
- Added patch "KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after masking
  PMCNTENSET_EL0".
- Added patch "KVM: arm64: Reload PMCNTENSET_EL0".
- Link to v2: https://lore.kernel.org/r/20250307-pmc-v2-0-6c3375a5f1e4@daynix.com

Changes in v2:
- Changed to utilize KVM_REQ_RELOAD_PMU as suggested by Oliver Upton.
- Added patch "KVM: arm64: PMU: Reload when user modifies registers"
  to cover more registers.
- Added patch "KVM: arm64: PMU: Set raw values from user to
  PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}".
- Link to v1: https://lore.kernel.org/r/20250302-pmc-v1-1-caff989093dc@daynix.com

---
Akihiko Odaki (7):
      KVM: arm64: PMU: Set raw values from user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
      KVM: arm64: PMU: Assume PMU presence in pmu-emul.c
      KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
      KVM: arm64: PMU: Reload when user modifies registers
      KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after masking PMCNTENSET_EL0
      KVM: arm64: PMU: Reload PMCNTENSET_EL0
      KVM: arm64: PMU: Reload when resetting

 arch/arm64/kvm/arm.c      |  8 ++++---
 arch/arm64/kvm/pmu-emul.c | 60 ++++++++++++++---------------------------------
 arch/arm64/kvm/reset.c    |  3 ---
 arch/arm64/kvm/sys_regs.c | 53 +++++++++++++++++++++++------------------
 include/kvm/arm_pmu.h     |  3 +--
 5 files changed, 53 insertions(+), 74 deletions(-)
---
base-commit: da2f480cb24d39d480b1e235eda0dd2d01f8765b
change-id: 20250302-pmc-b90a86af945c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


