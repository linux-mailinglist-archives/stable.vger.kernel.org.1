Return-Path: <stable+bounces-112178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B716DA275AD
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01209164A44
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2021423C;
	Tue,  4 Feb 2025 15:21:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC3213E8B
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682471; cv=none; b=DQnZobtQxpwQdaccM8o1NrmmkMmgj/jjYRZikCHu8xfCMnIMZvNFhXj0EsbETfLiQlTMC42agGp6lpH131Rr6/xfwHt8FZhlYdDzOUKS8JpTrn9Hkje3bLuCy6zbW2w6XRy2l4f7eDeJPYPlcyw34QTm922NXgVpv+NN1Z09jYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682471; c=relaxed/simple;
	bh=Qq/aTv3WAEc0zWKZSO4Rtn200Nr5LrgQwWARwmgMnIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYeQP0p5VBFsKAZk5BXHV8qRLPn29jXkNmiQp6f2NvrMPoUOcIjRCfj6HnEAa0VdpnWljmaSj1SuJqfe57r8jmJde5o6rZ0HKJHpnCkTxBoGS7Al9yYS8JsmjQne/NFhD928tKMeI8HtFTwiRtzw7WjdlqHxthcAWVEm9Vnx5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EDD311FB;
	Tue,  4 Feb 2025 07:21:32 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36BA93F63F;
	Tue,  4 Feb 2025 07:21:06 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	eauger@redhat.com,
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
Subject: [PATCH 0/8] KVM: arm64: FPSIMD/SVE/SME fixes
Date: Tue,  4 Feb 2025 15:20:52 +0000
Message-Id: <20250204152100.705610-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix some isuses with the way KVM manages FPSIMD/SVE?SME
state. The series supersedes my earlier attempt at fixing the host SVE
state corruption issue:

  https://lore.kernel.org/linux-arm-kernel/20250121100026.3974971-1-mark.rutland@arm.com/

Patch 1 addreses the host SVE state corruption issue by always saving
and unbinding the host state when loading a vCPU, as discussed on the
earlier patch:

  https://lore.kernel.org/linux-arm-kernel/Z4--YuG5SWrP_pW7@J2N7QTR9R3/
  https://lore.kernel.org/linux-arm-kernel/86plkful48.wl-maz@kernel.org/

Patches 2 to 4 remove code made redundant by patch 1. These probably
warrant backporting along with patch 1 as there is some historical
brokenness in the code they remove.

Patches 5 to 7 are preparatory refactoring for patch 8, and are not
intended to have any functional impact.

Patch 8 addreses some mismanagement of ZCR_EL{1,2} which can result in
the host VMM unexpectedly receiving a SIGKILL. To fix this, we eagerly
swith ZCR_EL{1,2} at guest<->host transitions, as discussed on another
series:

  https://lore.kernel.org/linux-arm-kernel/Z4pAMaEYvdLpmbg2@J2N7QTR9R3/
  https://lore.kernel.org/linux-arm-kernel/86o6zzukwr.wl-maz@kernel.org/
  https://lore.kernel.org/linux-arm-kernel/Z5Dc-WMu2azhTuMn@J2N7QTR9R3/

The end result is that KVM loses ~100 lines of code, and becomes a bit
simpler to reaason about.

I've pushed these patches (with some additional debug patches that can
be used for testing) to the arm64-kvm-fpsimd-fixes-20250204 tag on my
kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

I've given this some basic testing on a virtual platform, booting a host
and a guest with and without constraining the guet's max SVE VL, with:

* kvm_arm.mode=vhe
* kvm_arm.mode=nvhe
* kvm_arm.mode=protected (IIUC this will default to hVHE)

Any additional testing would be much appreciated.

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

 arch/arm64/include/asm/kvm_emulate.h    |  42 ---------
 arch/arm64/include/asm/kvm_host.h       |  22 +----
 arch/arm64/kernel/fpsimd.c              |  25 -----
 arch/arm64/kvm/arm.c                    |   8 --
 arch/arm64/kvm/fpsimd.c                 | 100 ++------------------
 arch/arm64/kvm/hyp/include/hyp/switch.h | 116 +++++++++++++++++-------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  15 ++-
 arch/arm64/kvm/hyp/nvhe/switch.c        |  91 ++++++++++---------
 arch/arm64/kvm/hyp/vhe/switch.c         |  33 ++++---
 9 files changed, 170 insertions(+), 282 deletions(-)

-- 
2.30.2


