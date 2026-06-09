Return-Path: <stable+bounces-262370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nk9/KhxhKGryCwMAu9opvQ
	(envelope-from <stable+bounces-262370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 20:53:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1006636F1
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 20:53:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dbNOo5Ha;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262370-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262370-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F27A93007A73
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A04C040D;
	Tue,  9 Jun 2026 18:52:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D7331EC9;
	Tue,  9 Jun 2026 18:52:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031129; cv=none; b=vAggpVXpJ4UtBST4aM1kWUbgKZYUW2JtPNX6eWzkFEF2TzJggfehRxpXjpgu6QcB4aYeygeKCDRgFmu68bK8CtHjpr4A6BkvtphQJWumnMB1Yt98cZu3LxbOxUybJdkQvCnVIdOrat1/jWvDk9ok2bUQ3/OT2ux4qlGbSVryenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031129; c=relaxed/simple;
	bh=pS/mUwGnNpTUlmx84nLsne2qXX4XMTLqGn7FdeebpvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4XkyHIJp2JTPg0VRQxuprD2gSvOg0pBWvbMCORfyCP6Ebzfj9zO59jQgqJXN5AT9mF3rdgl2sWuTjdnf8pIZO5bXKnnQGbJcOB6NcSoJMRplfob1/QiGUoOSRr1ka87fHQTX4iOMsumgDexBowXpndLYCLd2eqhA4Zq51XjrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbNOo5Ha; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB8F1F0089A;
	Tue,  9 Jun 2026 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781031128;
	bh=Pk28Y4P6W8ymkMldEEHau29x9mHLqn44gGvm2nZ6QGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbNOo5Haj5iVEBXor1/Fx1HnTEe3HJq8+3ZzCWLgYyF7oJLQFNtLiIy1BWNZGayXx
	 JdFXklouJb4ApafOen8EMys2JuioHuvidt1VqJzEGNyqkEtk/g+Fm135nibN2sNTTI
	 Dqf5lk1Rrq+KZUKyyEwgIrXmmMSCIDXEssE9EnkCoW6URHCgd1vgWMWvJ1JmU1Gvw4
	 Y2L60WLZDdxpfikvAHMXIB9u48k6vzXRUM0T+QlR1nav3pa+saYqITJ7b505Fsjy/j
	 ezCG3Vu3XCATBRWIG8wUlNJiZTh4v2wrwj0qxMc7vQj6eoVWSvYc51iG8XdFywYHNa
	 19jwJbR+TKYpQ==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] KVM: arm64: nv: Inject SEA if guest VNCR isn't normal memory
Date: Tue,  9 Jun 2026 11:52:03 -0700
Message-ID: <20260609185204.745929-8-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609185204.745929-1-oupton@kernel.org>
References: <20260609185204.745929-1-oupton@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kvmarm@lists.linux.dev,m:maz@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:weilin.chang@arm.com,m:oupton@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262370-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oupton@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D1006636F1

When constructing an L1 VNCR mapping, KVM unconditionally uses cacheable
memory attributes, even if the underlying PFN isn't memory. This gets
particularly hairy if the endpoint doesn't support cacheable memory
attributes, potentially throwing an SError on writeback...

While KVM does permit cacheable memory attributes on certain PFNMAP
VMAs, kvm_translate_vncr() isn't currently grabbing the VMA. So do the
simpler thing for now and just reject everything that isn't memory.

Cc: stable@vger.kernel.org
Fixes: 2a359e072596 ("KVM: arm64: nv: Handle mapping of VNCR_EL2 at EL2")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/nested.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index d5c4b57123a9..a6bd60856fc3 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1413,6 +1413,17 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 		writable = !(memslot->flags & KVM_MEM_READONLY);
 	}
 
+	/*
+	 * FIXME: This check is too restrictive as KVM allows cacheable memory
+	 * attributes for PFNMAP VMAs that have cacheable attributes in host
+	 * stage-1.
+	 */
+	if (!pfn_is_map_memory(pfn)) {
+		kvm_release_faultin_page(vcpu->kvm, page, true, false);
+		fail_s1_walk(&vt->wr, ESR_ELx_FSC_EXTABT, false);
+		return -EFAULT;
+	}
+
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
 		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
 			kvm_release_faultin_page(vcpu->kvm, page, true, false);
-- 
2.47.3


