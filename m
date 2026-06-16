Return-Path: <stable+bounces-263502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /oj+MvKbMGq8VAUAu9opvQ
	(envelope-from <stable+bounces-263502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:42:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B15568AFF1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:42:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="RvrzJ/gg";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263502-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263502-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46C5A301B921
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990827466A;
	Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CB1DE8AE;
	Tue, 16 Jun 2026 00:42:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570543; cv=none; b=mAeKjl38Js/AoZRtjqWDXgQ2aZqm6fRvAL0qSTDcgd582cO6QttaGfUG5E7wu2kjYiuel5fkWMGNk78fpxRTJ41GG4Oai0jY3wlFjiAeIJ3+nXxLddSzrMS776yREfoR39v8yqFzg3OXFwqQPmPEjlrterGzeLH1ZGlZ34g6fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570543; c=relaxed/simple;
	bh=FRilfmR+d+A25hTKp4FIVw/tyYYYRjLaVif+7ce2QNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSXRR6Jw0yW9mzD+Bys4wQwEsTYAHc4XInj+ZvO/KvyCt/Qbtl4VUHDPuGX+uW8YSDabir4FlAd3ltfF+zO9Omgch7algo+dXl4FV8wP3S7HOPVE7EmK7TYgmSEDWywOycsixe89ENExd4KiCbAHpTxV2aRPLVVxv4m5khwhdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvrzJ/gg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22701F00A3A;
	Tue, 16 Jun 2026 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570542;
	bh=B4F1ALEQLUiONmHOJm1mdesxSoMcf+r/fQlWcYw7h5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RvrzJ/ggNqPQUeVdlY0kg9VztAKYSNNLEEYUY6L1DEzafooZG6soSG/63AxVuAb8g
	 C2lsR4zmGXiuWJnMq2be92bT9mzm4P9LG4IgJduF/HVPkV2n3Aoltvifio4jcr9G/e
	 v/3OVjEtMxOnDAwNSDNbotcpwqFd4xxuR0Uk4JNXdfMkGPjqdxq3H1ah+uORr/1ODa
	 jyHW5F6Eq5AT6fsYkzIWB0grTbLmkvkfYgONrlaxla95nMt80/E36yi3JUlPHWlD0c
	 2d3XgPirI9sjkWWXhoiqGOTwl7wt7SBMTrnc2qahiWPHhiYaA226i7ckpNFknNWMXz
	 aLfCy3QKxrY7A==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [RFC PATCH v2 01/25] KVM: nSVM: Flush the TLB after forcefully leaving nested
Date: Tue, 16 Jun 2026 00:41:30 +0000
Message-ID: <20260616004155.1435766-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:jmattson@google.com,m:mlevitsk@redhat.com,m:vkuznets@redhat.com,m:thomas.lendacky@amd.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yosry@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263502-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B15568AFF1

KVM flushes the TLB on nested VM-Enter and nested VM-Exit, but not when
forcefully leaving nested. In this case, L2 TLB entries can leak into
L1. Flush the TLB after forcefully exiting L2, similar to nested
VM-Exits.

Note that vmx_leave_nested() handles this correctly, as it reuses
nested_vmx_vmexit(), which handles the necessary TLB flushes on an L2 ->
L1 transition.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1ab8b95975a4b..c85aa5cf670f4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1550,6 +1550,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+		nested_svm_transition_tlb_flush(vcpu);
+
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
 
-- 
2.54.0.1136.gdb2ca164c4-goog


