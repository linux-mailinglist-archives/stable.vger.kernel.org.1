Return-Path: <stable+bounces-220636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGWkD3ZRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:35:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927061C86E5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E074F327CF21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE83EB6D4;
	Sat, 28 Feb 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhPrqLim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239753EB6CE;
	Sat, 28 Feb 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300519; cv=none; b=ensRoXGrkXWjjS/cXFvfJlRgIkyu6UdTdTzKX0DCzZooi019EzldMbODI9LwVbIFBNHnxV4cOXa6sszBfeabQVI/nXHMNzHSJTySAkqPVHdl2pueYJEdO59jVDVit9DXV8hJ36ixrhACTin7IZBf6SUURN9hQB/4QdqK/BST85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300519; c=relaxed/simple;
	bh=W0qTrvHv2YAPoB46BGrdjXvnMgB2NRqo3POMDi/S+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INKMIFP9nLGuylx2oW5d8U2iBeDf71SUOo5Oh1iSB5fHMf50xFMv5f09CABTIKUJw9uyq4vLmDz0x0CDJCOfb04jIrRkexHDvBa17umn1lGuI1ohfgjHWrVsKhXJ7w6es/XfQjL2/ftP1UES0LsI8DplILwj817YrYsx2RE8Ih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhPrqLim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF61C19425;
	Sat, 28 Feb 2026 17:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300519;
	bh=W0qTrvHv2YAPoB46BGrdjXvnMgB2NRqo3POMDi/S+PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhPrqLimCKEBBx87cnSwnOTOU6pH2pyIqdviPQJLoTF3Zh7RCmWE/8fjT39JgP49/
	 VcVGucGKEPZzl/haGdiBqe79kXstX0oOftaR/gjiUmpWIlfwCckZsKLQCgxEoDxAf0
	 +0v0PK4wRGisJSdQSnaeST9q2B59jKtm2JbxgaZIZFxY/jxvVkrewoL+eYlISbkbyu
	 pFhl3/1jQkvbn7t47Rab2xwJdn4hHaAFA/wlniWbZ/eY2mEZcAwV09ep+Zz1iX0WTA
	 EuK8suXVJWRCBVevtR/dngf0UPz0VdU3sll1Q/jjCcJyxKSQqmzzaZZQBYXw99QomI
	 1r1DLApPRGxXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 557/844] KVM: nSVM: Remove a user-triggerable WARN on nested_svm_load_cr3() succeeding
Date: Sat, 28 Feb 2026 12:27:50 -0500
Message-ID: <20260228173244.1509663-558-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220636-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 927061C86E5
X-Rspamd-Action: no action

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit fc3ba56385d03501eb582e4b86691ba378e556f9 ]

Drop the WARN in svm_set_nested_state() on nested_svm_load_cr3() failing
as it is trivially easy to trigger from userspace by modifying CPUID after
loading CR3.  E.g. modifying the state restoration selftest like so:

  --- tools/testing/selftests/kvm/x86/state_test.c
  +++ tools/testing/selftests/kvm/x86/state_test.c
  @@ -280,7 +280,16 @@ int main(int argc, char *argv[])

                 /* Restore state in a new VM.  */
                  vcpu = vm_recreate_with_one_vcpu(vm);
  -               vcpu_load_state(vcpu, state);
  +
  +               if (stage == 4) {
  +                       state->sregs.cr3 = BIT(44);
  +                       vcpu_load_state(vcpu, state);
  +
  +                       vcpu_set_cpuid_property(vcpu, X86_PROPERTY_MAX_PHY_ADDR, 36);
  +                       __vcpu_nested_state_set(vcpu, &state->nested);
  +               } else {
  +                       vcpu_load_state(vcpu, state);
  +               }

                  /*
                   * Restore XSAVE state in a dummy vCPU, first without doing

generates:

  WARNING: CPU: 30 PID: 938 at arch/x86/kvm/svm/nested.c:1877 svm_set_nested_state+0x34a/0x360 [kvm_amd]
  Modules linked in: kvm_amd kvm irqbypass [last unloaded: kvm]
  CPU: 30 UID: 1000 PID: 938 Comm: state_test Tainted: G        W           6.18.0-rc7-58e10b63777d-next-vm
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:svm_set_nested_state+0x34a/0x360 [kvm_amd]
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl+0xf33/0x1700 [kvm]
   kvm_vcpu_ioctl+0x4e6/0x8f0 [kvm]
   __x64_sys_ioctl+0x8f/0xd0
   do_syscall_64+0x61/0xad0
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Simply delete the WARN instead of trying to prevent userspace from shoving
"illegal" state into CR3.  For better or worse, KVM's ABI allows userspace
to set CPUID after SREGS, and vice versa, and KVM is very permissive when
it comes to guest CPUID.  I.e. attempting to enforce the virtual CPU model
when setting CPUID could break userspace.  Given that the WARN doesn't
provide any meaningful protection for KVM or benefit for userspace, simply
drop it even though the odds of breaking userspace are minuscule.

Opportunistically delete a spurious newline.

Fixes: b222b0b88162 ("KVM: nSVM: refactor the CR3 reload on migration")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251216161755.1775409-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ba0f11c68372b..9be67040e94d9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1870,10 +1870,9 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * thus MMU might not be initialized correctly.
 	 * Set it again to fix this.
 	 */
-
 	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
 				  nested_npt_enabled(svm), false);
-	if (WARN_ON_ONCE(ret))
+	if (ret)
 		goto out_free;
 
 	svm->nested.force_msr_bitmap_recalc = true;
-- 
2.51.0


