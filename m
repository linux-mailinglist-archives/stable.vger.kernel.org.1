Return-Path: <stable+bounces-239729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J4RAStP5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:07:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B395842F002
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DBDF302F489
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66433F8D6;
	Mon, 20 Apr 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8euEZuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72D33F586;
	Mon, 20 Apr 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701067; cv=none; b=ZqSokM13hoiId0XtlpFUZ7vMlweBMJdRvIPKvoM40yvQPmB4KVOZ+dVpEGWBIqLDemxrIJN9JzzUWy9CyJ0KwepZJaobQH3QgF94x1Q2cF3CwTlwNJI2BAsqNxs1GhWq4kh57QsAKRZud8ckhR8GWx8aIws2UVyFZFaWiYtKppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701067; c=relaxed/simple;
	bh=8tDWD8hcJ2O5fEYHeeJDZw6x89gnwLXLP3wpJdFnFTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrmrxh1BBlLfK6gEaSfR+kkdiPOnIfGrNLEz9iKxOTh8yAnUK+wghhmOw3khRPHFZ02642yPc7NmQWtUZqU4xHXchvRTzjP8zixuIXSCI3J+a/ATNc/9TEWkn93EVDxnNb89oJB6YfjZLnyfBFEocrGf8v/8OdCT1XHvECVOrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8euEZuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72D4C19425;
	Mon, 20 Apr 2026 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701067;
	bh=8tDWD8hcJ2O5fEYHeeJDZw6x89gnwLXLP3wpJdFnFTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8euEZuBXGp1ryk85MgdZVHyYGMT33Yirgy5llI8Kv2XMmI/g7gT+oXuvdq9ORgi0
	 foIfqTLxG6dSdHwFPlc4vOCIfdH8+K4bQBwqV6SYYQtN3ZCE2hheibRAfEm3qhERD7
	 cJNRZ47MZxT91lHjVX8J5jNU6+TZ4jMp3izxrilw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jethro Beekman <jethro@fortanix.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.18 168/198] KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
Date: Mon, 20 Apr 2026 17:42:27 +0200
Message-ID: <20260420153941.660131323@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239729-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,fortanix.com:email]
X-Rspamd-Queue-Id: B395842F002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 624bf3440d7214b62c22d698a0a294323f331d5d upstream.

Reject LAUNCH_FINISH for SEV-ES and SNP VMs if KVM is actively creating
one or more vCPUs, as KVM needs to process and encrypt each vCPU's VMSA.
Letting userspace create vCPUs while LAUNCH_FINISH is in-progress is
"fine", at least in the current code base, as kvm_for_each_vcpu() operates
on online_vcpus, LAUNCH_FINISH (all SEV+ sub-ioctls) holds kvm->mutex, and
fully onlining a vCPU in kvm_vm_ioctl_create_vcpu() is done under
kvm->mutex.  I.e. there's no difference between an in-progress vCPU and a
vCPU that is created entirely after LAUNCH_FINISH.

However, given that concurrent LAUNCH_FINISH and vCPU creation can't
possibly work (for any reasonable definition of "work"), since userspace
can't guarantee whether a particular vCPU will be encrypted or not,
disallow the combination as a hardening measure, to reduce the probability
of introducing bugs in the future, and to avoid having to reason about the
safety of future changes related to LAUNCH_FINISH.

Cc: Jethro Beekman <jethro@fortanix.com>
Closes: https://lore.kernel.org/all/b31f7c6e-2807-4662-bcdd-eea2c1e132fa@fortanix.com
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260310234829.2608037-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c   |   10 ++++++++--
 include/linux/kvm_host.h |    7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1019,6 +1019,9 @@ static int sev_launch_update_vmsa(struct
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = mutex_lock_killable(&vcpu->mutex);
 		if (ret)
@@ -2039,8 +2042,8 @@ static int sev_check_source_vcpus(struct
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
-	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
-	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+	if (kvm_is_vcpu_creation_in_progress(src) ||
+	    kvm_is_vcpu_creation_in_progress(dst))
 		return -EBUSY;
 
 	if (!sev_es_guest(src))
@@ -2446,6 +2449,9 @@ static int snp_launch_update_vmsa(struct
 	unsigned long i;
 	int ret;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.page_type = SNP_PAGE_TYPE_VMSA;
 
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1030,6 +1030,13 @@ static inline struct kvm_vcpu *kvm_get_v
 	return NULL;
 }
 
+static inline bool kvm_is_vcpu_creation_in_progress(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->lock);
+
+	return kvm->created_vcpus != atomic_read(&kvm->online_vcpus);
+}
+
 void kvm_destroy_vcpus(struct kvm *kvm);
 
 int kvm_trylock_all_vcpus(struct kvm *kvm);



