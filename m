Return-Path: <stable+bounces-203062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 924DCCCF636
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7AE3032FC2
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740EC2AEF5;
	Fri, 19 Dec 2025 10:21:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1C2D4811
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139703; cv=none; b=VxHAjhwQphNkZRxm4vfeYurDAJDC04pNa8B/ijDf05VDQgkPyRFYvU3cU6V4cnZ3+cJSb76QwwAuQk3JOQ9Pe3wZSTz9Dol6D5V0WUsSzkq8esOiY+KUs97eNMhK3ePbAf/qyQ0Cmz5ArFjrtApBzu1QBf7CblWdtqJlwTJfHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139703; c=relaxed/simple;
	bh=E+8oqWYrJmfpkJJ2GW25OVBgEXaOOWoEYGG31zo4ym8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgeXMOMOlCxQRcPISs0ywJGPtih23wj8PoF6UgGqlSthgC+oe4CaTnJ29DaF7dZbfVfQmArVRBU5TfAzJqIUkfY3MyH/8Dke6f2Wmm28zUc/YY/A7jzJ1Z2x5RwOXujhRKwF7uZJ7wTlB3+2mVWaZbwIxOyfvfJaV2iSa5JagWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC9C106F;
	Fri, 19 Dec 2025 02:21:33 -0800 (PST)
Received: from workstation-e142269.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4944C3F5CA;
	Fri, 19 Dec 2025 02:21:39 -0800 (PST)
From: Wei-Lin Chang <weilin.chang@arm.com>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: [PATCH 6.12.y 0/3] arm64: Early system register initialization fixes
Date: Fri, 19 Dec 2025 10:21:20 +0000
Message-ID: <20251219102123.730823-1-weilin.chang@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series is a v6.12-only backport (based on v6.12.62) of fixes for
system register initialization issues affecting protected KVM on arm64.
This affects some contemporary and upcoming hardware which will run the
v6.12.y stable kernel, or something derived from it, such as the Android
common kernel.

The FEAT_E2H0 patches fix code introduced after v6.6, and so only
need to be backported to v6.12.

The SCTLR_EL1 patch fixes code introduced in v5.11, but practically
speaking only affects recent hardware which is unlikely to run
something older than v6.12.

Note: Marc Zyngier performed the initial backport, which I have
rebased and tested, hence both of our sign-offs being added to the
tags from the upstream commits.

I have tested the backport and observed they solve the problems as
expected.

Ahmed Genidi (1):
  KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()

Marc Zyngier (1):
  arm64: Revamp HCR_EL2.E2H RES1 detection

Mark Rutland (1):
  KVM: arm64: Initialize HCR_EL2.E2H early

 arch/arm64/include/asm/el2_setup.h   | 57 +++++++++++++++++++++++++---
 arch/arm64/kernel/head.S             | 22 ++---------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   | 10 +++--
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 ++
 4 files changed, 65 insertions(+), 27 deletions(-)

-- 
2.43.0


