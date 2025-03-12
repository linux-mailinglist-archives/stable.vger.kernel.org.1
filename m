Return-Path: <stable+bounces-124146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F48A5DC0A
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D1D1799CD
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354AB241109;
	Wed, 12 Mar 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="f1an1AFg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893D1E3DE8
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780574; cv=none; b=bpbMJHbwv6avr2xso/kFxzSsulCFubnzhrRgpdUqpu9fAwPWTTk5nP+fF9VtcLGEQEP39dv58hNln3uRjnt4Qg4peQjFvfBSyAk2LErBikRJxKTpt6gq6uVkTaJPC/sdCSl8YdxcxES0a0Rwb5/BI4MiNaQJMqWZiBuTLobo1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780574; c=relaxed/simple;
	bh=cmBlq/kzr7m17+5OwAx9iOS7U0NNp08z+8zJN/RNvc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BvhVVAXfYwZ4xAIKoH/6HQPVI6My6UqBSYv62GqlL0lDgCEycgPyzK1zUUZZF+3K07z5/vIonKC+ASUADIlqlM5NJVExTeYBLNegURilqnSMRKvj8mckBmhPTZxVgC36R1nq2vUUrs9+QPDIVr6THa5QmTy/Y76oKgJWj08EV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=f1an1AFg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso35924985ad.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741780569; x=1742385369; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9IlyLC7A5fKrEe72gCHfs3e2o6+wpvRXjQlPG7kMic=;
        b=f1an1AFgdF9CKhQVxs8l5SOjf9oSrSObS5dKMvg2uJY9wuDSgr6XpSebF7A6NXzxaX
         1kl3ITiZCwQuhUG0wZrOAacOw6zobg1LtmYuWEX8DhodLcUEHR27w+Mki7BeSqIF+2un
         N7iKg9mDXn1R8G7O//JaA6nZOnoRSGQ3VqsDdDwOU9iF+CIXr5RtxlSlzD0tpEaoK5oN
         bASLAAA/4p71BeMGdIFJOCVm+d9hb/5MHBYhBSOEuEM2In6+SI4Y0JWh7GQxl8VXV5gQ
         wEYmz43f7KKlAkpI9ENnG8wPin1+Wh/dYTc3o85MQAOTnWlG0bYzGuWyzuHzacRncyQW
         FNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780569; x=1742385369;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9IlyLC7A5fKrEe72gCHfs3e2o6+wpvRXjQlPG7kMic=;
        b=pIYeis7jveD6K8MdLC1iUa0HqJ9LN3fYUPu4n0XINyW7nBGy6AGZ17HQXjuzdIltYi
         RWxrf7n/lvcpqJmWIhIFV4MvNvNDCX19W1H4BoxSjfkhfSB8WOvRrUmySHiWTRC+Ksom
         NaNwlXxM1y3hvakjUyWijn/BmFXeMv5ZWjZlzkE7jT70thTQwgkheIsIeTclP97+6RZB
         BFLafHMm1+N3DsVPkK+z+JV76/Zh8YoxyEvucBq/TGcJsEEN32558MapqP9l4nP6KRao
         xnnbAsVK04GGGqyyW9XyETNj8VAiuOHIBExE6yjgl0lthqG26RohYNuL12kLrt3GsL6y
         RJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUGeAPh8Ca/wQYzNlbJnxEU6JLha4Bp2OZAYmZxYl4yQE0oJnELl7V+L+voXHfp9la3UqidPew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCNCvrDMapA2nOOBgtvV9gQVZayawrmwIBcPUgH2+e1GmUEks
	T3BkkyMPzCFBK8LMfFR97akCacF/4CxE2hPu/3mQFt8uFqsnteCF1erQqVgj/Ag=
X-Gm-Gg: ASbGncvh+zcOgiZ+KgEY47daNeLPaS9MjAR8pQpKk1I8rLMiXQOz2x1XU8bXnnCt+jq
	CG1Y+woysxkcxFkT56RL9dkTcGN1xlSX4lr8bEGLAwkZUPGM1r8b+t3V4YqVgAtYFKvPNwd2Ech
	ky2W4x4DLmB03CAtdzf2LGfZTZErfITM/nyxW4mcS13kONJCpihkZdfQE1y9F5+eqSVv9C2+Tl2
	PvtKCmtWiXxR3sPSZpdtX0aVYoK2DvVdSQ3wFY+kT+sWtfzQivFPTLI8XOKZsyObUqiY+SdLi8S
	VUaG07FnMrn0hbM7tLHHnfr+OTbYz1rXnHLZSGXV7wVE9hRZ
X-Google-Smtp-Source: AGHT+IEZMl7qgOp/elCr4VXp7AlgwKiCuKen+kfThanblODxDmQAYt3d4nqftKdNx7NyuuUlrtd5xg==
X-Received: by 2002:a17:902:c94d:b0:223:5c33:56a8 with SMTP id d9443c01a7336-22428ab89ccmr358251575ad.35.1741780569502;
        Wed, 12 Mar 2025 04:56:09 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736a1f813d1sm11378575b3a.129.2025.03.12.04.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:56:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/6] KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
Date: Wed, 12 Mar 2025 20:55:54 +0900
Message-Id: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEp20WcC/1WMOw6DMBAFr4JcZyN/MOBUuUeUwlnssAUf2ZEFQ
 tw9hjShnKc3s7LoArnIbsXKgksUaRwyqEvBsLPD2wG1mZnkUnPFJUw9wstw21TWm1Ijy88pOE/
 zUXk8M3cUP2NYjmgS+3r2kwABaL03jeFGtXhv7TLQfMWxZ3sgyX+p/kkSOFSoVK2t9sKVJ2nbt
 i+40r9pzAAAAA==
X-Change-ID: 20250302-pmc-b90a86af945c
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
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
Akihiko Odaki (6):
      KVM: arm64: PMU: Set raw values from user to PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
      KVM: arm64: PMU: Assume PMU presence in pmu-emul.c
      KVM: arm64: PMU: Fix SET_ONE_REG for vPMC regs
      KVM: arm64: PMU: Reload when user modifies registers
      KVM: arm64: PMU: Call kvm_pmu_handle_pmcr() after masking PMCNTENSET_EL0
      KVM: arm64: Reload PMCNTENSET_EL0

 arch/arm64/kvm/arm.c      |  8 ++++---
 arch/arm64/kvm/guest.c    | 12 +++++++++++
 arch/arm64/kvm/pmu-emul.c | 54 ++++++++++++++++-------------------------------
 arch/arm64/kvm/sys_regs.c | 53 ++++++++++++++++++++++++++--------------------
 include/kvm/arm_pmu.h     |  1 +
 5 files changed, 66 insertions(+), 62 deletions(-)
---
base-commit: da2f480cb24d39d480b1e235eda0dd2d01f8765b
change-id: 20250302-pmc-b90a86af945c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


