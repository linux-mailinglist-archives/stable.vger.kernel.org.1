Return-Path: <stable+bounces-152845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C0ADCD9A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963C8188C167
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6982E2646;
	Tue, 17 Jun 2025 13:37:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B422C08B8
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167452; cv=none; b=XS4FNg7hzhemzDw83EbWIVq9vT+WWzmZGPqap9ZviWAD27pQkREPTIETUBm91DmUwiW/Zkl8hMyZDyf4EDzyP74r/TMBlkvUYUT/w2aSfnR5vsUocoxBZ7eyXKuIk+lWatu/dQpHEhVmnrqpi63htrTRjmKgyEUYr8UzL2CHbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167452; c=relaxed/simple;
	bh=UrVxdD15CWzA7wot5nb34iSJalGMyLmizhXK/wJXqkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SE4IukjI7EaEkJ4wkKHqS5RUL972PhpZWKpHIcJZ/VvUB85Xe49hO7KhZjZ38mDg4p3rXJJ4vFSRtBnoFqIZCQWe9lrQkGXwalYKnZNjfF+5GoDgWYb1q7JfbpZZ1hhtD7592JSy41B5YyO5mmTaRlR4q5pmIwMdE533DcvmzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EDA1595;
	Tue, 17 Jun 2025 06:37:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7E7A3F673;
	Tue, 17 Jun 2025 06:37:28 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	kvmarm@lists.linux.dev,
	mark.rutland@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	stable@vger.kernel.org,
	tabba@google.com,
	will@kernel.org
Subject: [PATCH 1/7] KVM: arm64: VHE: Synchronize restore of host debug registers
Date: Tue, 17 Jun 2025 14:37:12 +0100
Message-Id: <20250617133718.4014181-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250617133718.4014181-1-mark.rutland@arm.com>
References: <20250617133718.4014181-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KVM runs in non-protected VHE mode, there's no context
synchronization event between __debug_switch_to_host() restoring the
host debug registers and __kvm_vcpu_run() unmasking debug exceptions.
Due to this, it's theoretically possible for the host to take an
unexpected debug exception due to the stale guest configuration.

This cannot happen in NVHE/HVHE mode as debug exceptions are masked in
the hyp code, and the exception return to the host will provide the
necessary context synchronization before debug exceptions can be taken.

For now, avoid the problem by adding an ISB after VHE hyp code restores
the host debug registers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
index 502a5b73ee70c..73881e1dc2679 100644
--- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
@@ -167,6 +167,9 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
 
 	__debug_save_state(guest_dbg, guest_ctxt);
 	__debug_restore_state(host_dbg, host_ctxt);
+
+	if (has_vhe())
+		isb();
 }
 
 #endif /* __ARM64_KVM_HYP_DEBUG_SR_H__ */
-- 
2.30.2


