Return-Path: <stable+bounces-114715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34216A2F988
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AF8188ADB6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 19:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BC2505CF;
	Mon, 10 Feb 2025 19:52:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399632505B7
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217159; cv=none; b=EpnYEWRnGlX5fs+FNgLfbho+F0rPqqR/EEkMxnESrs/56nwmQPQquq58zvl5utp9Mb5ccT4Ufanx83tj7JTnrIrK3TTMbIaQd7rDqYFg07yVfk+XYKagDE9kwxCvK4ABPW3nA9HUBS7w5NXtDCw7Nh3BodbrrLVb6VkD4F0G5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217159; c=relaxed/simple;
	bh=Ng7BdaWtbpkCMN7dI5Syl7yo/1EBlgNXraQwfxjmfMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6t/aeJQtrX4cZx2ZTe7rSEYHOtYZAqT0qNkSD4zoW3O0H8Sr17ylECoKQudSPy3nMFB+VHOQogEB38Fc0wPSklSQsrF7jhTmgh+zuQGiK56x01EHeHEW9cq6xWO8C9GEkLZGwjnArDIbek7Fj8cZRO4lWN/Iyr3KnRGIdZvXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C86591477;
	Mon, 10 Feb 2025 11:52:57 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA34C3F58B;
	Mon, 10 Feb 2025 11:52:32 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	eauger@redhat.com,
	eric.auger@redhat.com,
	fweimer@redhat.com,
	jeremy.linton@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com,
	stable@vger.kernel.org,
	tabba@google.com,
	wilco.dijkstra@arm.com,
	will@kernel.org
Subject: [PATCH v3 0/8] KVM: arm64: FPSIMD/SVE/SME fixes
Date: Mon, 10 Feb 2025 19:52:18 +0000
Message-Id: <20250210195226.1215254-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix some issues with the way KVM manages FPSIMD/SVE/SME
state. The series supersedes my earlier attempt at fixing the host SVE
state corruption issue:

  https://lore.kernel.org/linux-arm-kernel/20250121100026.3974971-1-mark.rutland@arm.com/

Patch 1 addresses the host SVE state corruption issue by always saving
and unbinding the host state when loading a vCPU, as discussed on the
earlier patch:

  https://lore.kernel.org/linux-arm-kernel/Z4--YuG5SWrP_pW7@J2N7QTR9R3/
  https://lore.kernel.org/linux-arm-kernel/86plkful48.wl-maz@kernel.org/

Patches 2 to 4 remove code made redundant by patch 1. These probably
warrant backporting along with patch 1 as there is some historical
brokenness in the code they remove.

Patches 5 to 7 are preparatory refactoring for patch 8, and are not
intended to have any functional impact.

Patch 8 addresses some mismanagement of ZCR_EL{1,2} which can result in
the host VMM unexpectedly receiving a SIGKILL. To fix this, we eagerly
switch ZCR_EL{1,2} at guest<->host transitions, as discussed on another
series:

  https://lore.kernel.org/linux-arm-kernel/Z4pAMaEYvdLpmbg2@J2N7QTR9R3/
  https://lore.kernel.org/linux-arm-kernel/86o6zzukwr.wl-maz@kernel.org/
  https://lore.kernel.org/linux-arm-kernel/Z5Dc-WMu2azhTuMn@J2N7QTR9R3/

The end result is that KVM loses ~100 lines of code, and becomes a bit
simpler to reason about.

I've pushed these patches to the arm64-kvm-fpsimd-fixes-20250210 tag on my
kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

The (unstable) arm64/kvm/fpsimd-fixes branch in that repo contains the
fixes plus additional debug patches I've used for testing. I've given
this some basic testing on a virtual platform, booting a host and a
guest with and without constraining the guest's max SVE VL, with:

* kvm_arm.mode=vhe
* kvm_arm.mode=nvhe
* kvm_arm.mode=protected (IIUC this will default to hVHE)

Since v1 [1]:
* Address some additional compiler warnings in patch 7
* Use ZCR_EL1 alias in VHE code
* Fold in Tested-by and Reviewed-by tags
* Fix typos

Since v2 [2]:
* Ensure context synchronization in patch 8
* Fold in Tested-by and Reviewed-by tags
* Fix typos

[1] https://lore.kernel.org/linux-arm-kernel/20250204152100.705610-1-mark.rutland@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20250206141102.954688-1-mark.rutland@arm.com/

Mark.

Mark Rutland (8):
  KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
  KVM: arm64: Remove host FPSIMD saving for non-protected KVM
  KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
  KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
  KVM: arm64: Refactor CPTR trap deactivation
  KVM: arm64: Refactor exit handlers
  KVM: arm64: Mark some header functions as inline
  KVM: arm64: Eagerly switch ZCR_EL{1,2}

 arch/arm64/include/asm/kvm_emulate.h    |  42 --------
 arch/arm64/include/asm/kvm_host.h       |  22 +---
 arch/arm64/kernel/fpsimd.c              |  25 -----
 arch/arm64/kvm/arm.c                    |   8 --
 arch/arm64/kvm/fpsimd.c                 | 100 ++----------------
 arch/arm64/kvm/hyp/entry.S              |   5 +
 arch/arm64/kvm/hyp/include/hyp/switch.h | 133 +++++++++++++++++-------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  15 ++-
 arch/arm64/kvm/hyp/nvhe/switch.c        |  91 ++++++++--------
 arch/arm64/kvm/hyp/vhe/switch.c         |  33 +++---
 10 files changed, 187 insertions(+), 287 deletions(-)

-- 
2.30.2


