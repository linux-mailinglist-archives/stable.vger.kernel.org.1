Return-Path: <stable+bounces-195384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C132FC75E4F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F474E0208
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0A3242CA;
	Thu, 20 Nov 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThfqmcXl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B76427C84B
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662784; cv=none; b=g8WI2R1JQzpG2o+dEcB0jNdN3L1g6YaoiwRObs4+B9OWRZ8cFNkl71Ob2CfUeC0GUaV1BMfNBySa5GIZxrH/8KmUDqvCuBclkK9WY3ekcF84NjAAXNaXwIoOBvasvGNELj4U/ikp6pPr8cNwK0WHI2vM4nPl2owTBecQebVtUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662784; c=relaxed/simple;
	bh=nIHX9V3wTOs5iwU1BVeqqaj1RIz4WRQdNkbFkPkg6q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4cnBwmjbqmMT37V8CMacn8C8bLcB6Juz5cVCJwEnIGTA1iSDgANVj6/UCXj+kPzET16k9PEh4UBbek85M3APLh6ZKMdKzozi1YNGOKjc1wOoISpxSwiClg6I9iXtz3sIa0lTmFzZMX9SE4ckmIGxSxMAV4/288T4YlVYlzdsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThfqmcXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74093C116D0;
	Thu, 20 Nov 2025 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763662784;
	bh=nIHX9V3wTOs5iwU1BVeqqaj1RIz4WRQdNkbFkPkg6q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThfqmcXlP+/i7dQaworjV+CpjlghEN21PIxNi6DDdXi8A48Bt+StsH8H0DVMcse+K
	 WKhPjeV9JBa370vDG7oREBm7nOvzNbytbTTsh11kK+fgWLr3+7oqfd5U2k/vYVk591
	 A9slCzywSZTV6YiPGIgatLwib6NkjPfBvYGGD1uCLPf3WlMxzCnEZHUdM+IN4O3g99
	 cwgf3cTQdUaKbNGAEVhoi1Lb1uxVkuzWr7d3tNjcyA44G6ch3AADom++iBpvaa/y9q
	 p75pKZm27xW3XiD3dzEVjJZ0442Sdq/11ntUF+IMr0MO+NFgFeCwdtdxBgbHvE0ppK
	 ht6IvQTRKKPnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] KVM: VMX: Fix check for valid GVA on an EPT violation
Date: Thu, 20 Nov 2025 13:19:40 -0500
Message-ID: <20251120181940.1924069-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120181940.1924069-1-sashal@kernel.org>
References: <2025112016-chatter-plutonium-baf8@gregkh>
 <20251120181940.1924069-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>

[ Upstream commit d0164c161923ac303bd843e04ebe95cfd03c6e19 ]

On an EPT violation, bit 7 of the exit qualification is set if the
guest linear-address is valid. The derived page fault error code
should not be checked for this bit.

Fixes: f3009482512e ("KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is valid")
Cc: stable@vger.kernel.org
Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20251106052853.3071088-1-Sukrit.Bhatnagar@sony.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 78ae39b6cdcd0..27beb9d431e00 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -24,7 +24,7 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	error_code |= (exit_qualification & EPT_VIOLATION_RWX_MASK)
 		      ? PFERR_PRESENT_MASK : 0;
 
-	if (error_code & EPT_VIOLATION_GVA_IS_VALID)
+	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 
-- 
2.51.0


