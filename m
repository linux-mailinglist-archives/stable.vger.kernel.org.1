Return-Path: <stable+bounces-225685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNarAs9buGl0cgEAu9opvQ
	(envelope-from <stable+bounces-225685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E229FD5B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1996D3028E99
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F723DBD40;
	Mon, 16 Mar 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV49i91V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B53254A9
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689802; cv=none; b=A6/K2F6N+lV80ptgdbLy8wfd573JVJVzyaSuH4CxzSip/LYmHnuHphTXwl3g0FwbuwCFX+JfaarVd6mizRoJC6Ywc0PQJn40UoVIA4JYlAIKfXhYPZcR+272IS0L/bEFmuvS+zPr0rpOBVL4LX4MbXu5cKS6GlQtP26t3EYhhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689802; c=relaxed/simple;
	bh=xwFnhLK7yW82l4CUiNimlXo1CxlPJUBnKKx8UhkPw6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smluczd3AxQuQ4NCTR0hP806TJrDlxUErPgWgd/1vehwT8R/uS1nB2JRAlpv22wnTl+ed5FN8uVN9U2dFPSaPnntLPPXvstw294tAq31hH8v+diNLziI6NvToekJjDRYkd5QNkATZX369vrqzPnCxBMBqfoyfRZ9ZDmt74qCkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV49i91V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61AEC19421;
	Mon, 16 Mar 2026 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689802;
	bh=xwFnhLK7yW82l4CUiNimlXo1CxlPJUBnKKx8UhkPw6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GV49i91VLs8vxzS54ifxyFujo3MWDS5GX0+L6PXDqMOseTQ0L8DiARNmUgfsZHroj
	 FhIxA1/bDkeSI5pHwa7kKdTb+oVBpoEXdEa4vb6FWP6KOA1x1hHPH3l12rZ9M9Z7rO
	 f17NtanHiSg9fkjrm7c+NZ71d72FU/7y4NKiQ4GG/4LxPIT+GKa35fMISYfAdWA5y2
	 V+SLwXCkGRSJqtQm0brB/2psUNnzvuw+LEtuc3CvswtMn5TUEYJ923tOwonRZb0la3
	 wuO3u4yT3HBvxEFaECO5S0kuSYYlBHfp3xnAG+x9HmTIBS1WUdONtZMc/urefeHnGP
	 MBOHMAUp5u+SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 1/2] KVM: arm64: gic: Set vgic_model before initing private IRQs
Date: Mon, 16 Mar 2026 15:36:39 -0400
Message-ID: <20260316193640.1358554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031607-maimed-erasable-eac8@gregkh>
References: <2026031607-maimed-erasable-eac8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225685-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,huawei.com:email,arm.com:email]
X-Rspamd-Queue-Id: AC9E229FD5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sascha Bischoff <Sascha.Bischoff@arm.com>

[ Upstream commit 9435c1e1431003e23aa34ef8e46c30d09c3dbcb5 ]

Different GIC types require the private IRQs to be initialised
differently. GICv5 is the culprit as it supports both a different
number of private IRQs, and all of these are PPIs (there are no
SGIs). Moreover, as GICv5 uses the top bits of the interrupt ID to
encode the type, the intid also needs to computed differently.

Up until now, the GIC model has been set after initialising the
private IRQs for a VCPU. Move this earlier to ensure that the GIC
model is available when configuring the private IRQs. While we're at
it, also move the setting of the in_kernel flag and implementation
revision to keep them grouped together as before.

Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260128175919.3828384-7-sascha.bischoff@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Stable-dep-of: ac6769c8f948 ("KVM: arm64: Eagerly init vgic dist/redist on vgic creation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index dc9f9db310264..86c149537493f 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -140,6 +140,10 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		goto out_unlock;
 	}
 
+	kvm->arch.vgic.in_kernel = true;
+	kvm->arch.vgic.vgic_model = type;
+	kvm->arch.vgic.implementation_rev = KVM_VGIC_IMP_REV_LATEST;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = vgic_allocate_private_irqs_locked(vcpu, type);
 		if (ret)
@@ -156,10 +160,6 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
 		goto out_unlock;
 	}
 
-	kvm->arch.vgic.in_kernel = true;
-	kvm->arch.vgic.vgic_model = type;
-	kvm->arch.vgic.implementation_rev = KVM_VGIC_IMP_REV_LATEST;
-
 	kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
 
 	aa64pfr0 = kvm_read_vm_id_reg(kvm, SYS_ID_AA64PFR0_EL1) & ~ID_AA64PFR0_EL1_GIC;
-- 
2.51.0


