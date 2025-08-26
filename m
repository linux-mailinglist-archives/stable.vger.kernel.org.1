Return-Path: <stable+bounces-174350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3391CB362FF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552C32A2B53
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495E230BCE;
	Tue, 26 Aug 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DzpEDehJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B5139579;
	Tue, 26 Aug 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214158; cv=none; b=LDaNRLAqrNUlvOUxVrrhbaH0sJNX2kxQh0wKn/c0oPAcPxA3DZkpRsdVYcfq0u/WNm/QpXgKqqdTNJdbKb9BFWBUKuc3T+lknqEhJcgv/Kj0eOlAl1yxYf/IQ6iVjiRx3miQv3nGUm0WMOvGJou4XouHq+2YLvQYkWC7SvlUEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214158; c=relaxed/simple;
	bh=vwLkTh+QGaa70He0UUZAUKnaZuuJ7sff/NHBlXj9z/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHZIMlB9Q38YsZjSE8E0cAL0LhouN3qbk3hEdis+UEfmJ0eb+SJ0GLS4s4KIGEMbo3nsEi5BB0bN2xuvseSrnkWVfG2sjx4mZSJbtiwkqLe1SHILxP5c7NzDAsoxugduzwd89H8BxprtR64vUMZZn74o99dZV9D3tXyxocTUqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DzpEDehJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CEDC4CEF1;
	Tue, 26 Aug 2025 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214157;
	bh=vwLkTh+QGaa70He0UUZAUKnaZuuJ7sff/NHBlXj9z/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzpEDehJGjAwIwDL9OieRvbaCnxHqlealnhHiL+6PJ1gyOfxcAwB5EVB7GsD/yuni
	 Lazk+W6f5/KW84DKNF6EQVwVI5+Ye4GF/MnRW4Pce3nXa9ld4J5NvCNvtygh/41RlK
	 Hy5CQxH8WVIrA8qJ8lc1jbGtBPoZKcwu9Hfbo4KU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 6.1 032/482] KVM: x86: Snapshot the hosts DEBUGCTL after disabling IRQs
Date: Tue, 26 Aug 2025 13:04:45 +0200
Message-ID: <20250826110931.599155324@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 189ecdb3e112da703ac0699f4ec76aa78122f911 ]

Snapshot the host's DEBUGCTL after disabling IRQs, as perf can toggle
debugctl bits from IRQ context, e.g. when enabling/disabling events via
smp_call_function_single().  Taking the snapshot (long) before IRQs are
disabled could result in KVM effectively clobbering DEBUGCTL due to using
a stale snapshot.

Cc: stable@vger.kernel.org
Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250227222411.3490595-6-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ba24bb50af57..b0ae61ba9b99 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4742,7 +4742,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10851,6 +10850,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
-- 
2.50.1




