Return-Path: <stable+bounces-259924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ROZwJVptH2pxlwAAu9opvQ
	(envelope-from <stable+bounces-259924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 01:55:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A137633051
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 01:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WkVkjvwP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259924-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259924-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B61B3018F7C
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA53BC680;
	Tue,  2 Jun 2026 23:54:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A939936D;
	Tue,  2 Jun 2026 23:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444498; cv=none; b=uEAWzQ437oYC/zYCm3eLtTCVM1cRVX4WWQo52SblBrBBEb9rp9fPAwRitEzSbDBaPFuWRDzQ5QGwLtJOggcwbtr4a5VVYL+WYVeaciAMn6oZwqF/JsNhxlYm0SfT5S/0UDwEymbCyAcvhlVmkMomH5AzmPWxDujQjl2L63dR3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444498; c=relaxed/simple;
	bh=9C8DQw0flKH0sM335ms4ayLG4jw5+1Dwb3103XIomUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7wxix9vTTGrR7kJNdQGxDiNNFagmzVnuddfJApyELPbpeY4HQdoSjscxfXG4vxjfbF75I6mAhxfpAU2zlM17WQwqAeBQ0/f5DsdSO+k0fJMeAcvf7HTHQvhc7Tz7wcufRUmoB9vhcbwuQC7VkayRWYlLdGGEaoHrOdZUyqeUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkVkjvwP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126101F0089A;
	Tue,  2 Jun 2026 23:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444496;
	bh=0x6QdNpCBv6Ii/bbNu324c1LO1y8u1r1+aTEfVKd050=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WkVkjvwPfuN+Z9MaUcb6tGtodaynhsAlbysX2XQuO6RYPO1QgDg4rc094dDQ30a1n
	 FxPWPCse48KCXe+7XjcjGezzuUWAUxfNRwbgyHhaapE5a631Z65mt5AR+QMuL3qytU
	 NsNyU0LJtll9v0iWRnKWtyS1Y7zSpiUPkxqhpxJUlDHY5L00wsNxz1gd8fp0DGHLF0
	 7kCpzsjw79LAYewk67+4AmSITUnAWt2URUqd6AbTipz/93MLn7+1jPI2RoNXRo3b+v
	 w1xefwZ9QcfV3P9BN8FYuazVRYq6jAt5yh0jxW+m03gOxabPvNOc5iaftTluvuUJsV
	 XddUOG36lUpow==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: arm64: Don't leak PFN when kvm_translate_vncr() races MMU notifier
Date: Tue,  2 Jun 2026 16:54:46 -0700
Message-ID: <20260602235450.103057-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602235450.103057-1-oupton@kernel.org>
References: <20260602235450.103057-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259924-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:weilin.chang@arm.com,m:oupton@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A137633051

In the case that kvm_translate_vncr() races with an MMU notifier the
early return does not release a reference on the faulted in PFN. Add
the necessary call to kvm_release_faultin_page() for the unused PFN.

Cc: stable@vger.kernel.org
Fixes: 069a05e535496 ("KVM: arm64: nv: Handle VNCR_EL2-triggered faults")
Reported-by: Sashiko (local):gemini-3.1-pro
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 883b6c1008fb..4fa82e96454d 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1326,8 +1326,10 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
-		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq))
+		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
+			kvm_release_faultin_page(vcpu->kvm, page, true, false);
 			return -EAGAIN;
+		}
 
 		vt->gva = va;
 		vt->hpa = pfn << PAGE_SHIFT;
-- 
2.47.3


