Return-Path: <stable+bounces-272311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3kkDCUITGpSfAEAu9opvQ
	(envelope-from <stable+bounces-272311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 21:55:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FB7152C4
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 21:55:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C+94d6Id;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272311-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272311-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 826DC302419B
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4A3D3D04;
	Mon,  6 Jul 2026 19:54:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95743C6A43;
	Mon,  6 Jul 2026 19:54:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367684; cv=none; b=WmUAL/C3XZxMWYATbDVzVJ+t+DiAS2FbhCTBprsYKVkAPlXB0a6thb79YE5AQMEtwPmuR5znEvSCL3Yy2G+2DiXnUdTyrvlRhkQLNYeEmYGWEb0jjm+d3dcXXmh+xm5FztkxF41FnCWrJPTtNH5357+lbpjuvRlfbHFooRT+2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367684; c=relaxed/simple;
	bh=CXuN/SKa1PPqCyuMUimFuRCk8zlVeXxVv5QjWF4EVOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC+5J3Q2KIDOLgSD0kDqbAyfpOBTE1s+8MatZsQdqVEEhdAp0aB34+e2OfjILeLHsx2T5ufHgSak00Iu77jB4I9kMKSdsLErA5OVwPYq5BfYSJ2ZkVpjsTrxRDPJFrGDJdPaaef5veYDKiqI5Hqx3dDGWvllFQ7ajUoQF7ZjhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+94d6Id; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4191F00A3D;
	Mon,  6 Jul 2026 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783367683;
	bh=I5xj/qWEmAskgEVgftFii5/CUCVUTTeCRaGrmv9HR6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C+94d6IdItHrDM9oEW8bwAA0X78ogpNMHO8kZLJnocIygc4eBO0HASFs7wr5TNKV7
	 6/HJ/bX91sjFHmJmE1oFXO43wjZnb3LgcpG7GqcMHQWDHQfv6PsIzE2RMNJqkPEtk/
	 5fBDRjQoW8Ff1zfe/9DMBXuPs1MUO42DLK/HO2Lutsw5MkNbMchEENaHc6gr4hdOIj
	 EJmHtXNFPWv5IkBzrZ/mSYehrSKLSfNXEyaVsSyVeNzfPu5IXS7FXIe4cQXSwY8P+S
	 Q8xeo+ARKOrAj0gg1YrhIAMEVEK+9g4cJXnNFgBhzb+8o2GVenTcCmrUyQbEFg4Yme
	 kpYFOO3MMqufQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/7] KVM: SVM: Disallow EFER.SVME and EFER.LSMLE if nested is disabled
Date: Mon,  6 Jul 2026 19:54:08 +0000
Message-ID: <20260706195413.1966458-3-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706195413.1966458-1-yosry@kernel.org>
References: <20260706195413.1966458-1-yosry@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272311-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yosry@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A41FB7152C4

Explicitly disallow setting EFER.SVME and EFER.LSMLE if nested
virtualization is disabled on SVM, to prevent the bits remaining allowed
if kvm_amd is loaded with nested=1 and then reloaded with nested=0.

This is a minimal fix for the benefit of stable backports, which will be
followed by a more systematic fix (moving efer_reserved_bits to
kvm_caps).

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/msrs.c    | 8 +++++++-
 arch/x86/kvm/msrs.h    | 1 +
 arch/x86/kvm/svm/svm.c | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e38..45170df0ce40b 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -660,10 +660,16 @@ static int set_efer(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 void kvm_enable_efer_bits(u64 mask)
 {
-       efer_reserved_bits &= ~mask;
+	efer_reserved_bits &= ~mask;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_enable_efer_bits);
 
+void kvm_disable_efer_bits(u64 mask)
+{
+	efer_reserved_bits |= mask;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_disable_efer_bits);
+
 bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)
 {
 	struct kvm_x86_msr_filter *msr_filter;
diff --git a/arch/x86/kvm/msrs.h b/arch/x86/kvm/msrs.h
index b698983e37fb6..89f10447cdddf 100644
--- a/arch/x86/kvm/msrs.h
+++ b/arch/x86/kvm/msrs.h
@@ -59,6 +59,7 @@ int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 		     struct kvm_reg_list __user *user_list);
 
 void kvm_enable_efer_bits(u64);
+void kvm_disable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
 int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index ef69a51ab27f9..1d51500238462 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5645,6 +5645,9 @@ static __init int svm_hardware_setup(void)
 		r = nested_svm_init_msrpm_merge_offsets();
 		if (r)
 			return r;
+	} else {
+		kvm_disable_efer_bits(EFER_SVME);
+		kvm_disable_efer_bits(EFER_LMSLE);
 	}
 
 	/*
-- 
2.55.0.rc2.803.g1fd1e6609c-goog


