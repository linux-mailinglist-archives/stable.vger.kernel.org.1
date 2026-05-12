Return-Path: <stable+bounces-245814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG7EKEFKA2r+2wEAu9opvQ
	(envelope-from <stable+bounces-245814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:41:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D53523DE6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B0E30E0FDF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46CC25393B;
	Tue, 12 May 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyDt4WA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983652D0C94
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597388; cv=none; b=OnXSP5qweMEzOvd8FcFrB98vfarCQfqhXEYLxl1QenEsvhLZpwrT9FPU/wQSsCHZ9K4D/2nWvFtayLla1nHO2ekh7y8IyXpy1tnkK9YaRl1k5qN4L/RxyBfq3Hn7klW8FU/6HhkNg1UlHOuxioiqAOCcaZ+l8vT3u4bJuMYnMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597388; c=relaxed/simple;
	bh=Gdm+NF/o8Vk/qHJYm/9RTsvqBhjO0eFortADgcTUtFg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bArDSNfTjtcCZ7mCrVSmaD74d1AKtxoNhT47f1bKxxMN2Yd+dPhW1Mc81hfTRl8qTonSdYWFi2vKMnZAVryDFDpCnAwIgKMKOjcX5T9eIc5ma/kRTfC2mkvgWp307uNduPi7UaMc7IT8Qz9F9xIOpmb604bHMvUhy0ikGELWvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyDt4WA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7CAC2BCB0
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597388;
	bh=Gdm+NF/o8Vk/qHJYm/9RTsvqBhjO0eFortADgcTUtFg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LyDt4WA05IE2b9PUfm+rCiaxE3BJ3hSeJGHQ5Vnh3Rev24bLndUV+R0QbfMqG5Sol
	 IbAjn0zUIMYZbrB72qc9bX8P3N7nIzyabglaU91jHo8WzMs8q1QMh4jwP2BVQWQYqP
	 9K7sZDLbV+ttEczryBbqt/EUkxmK0Fe/N0aCI/OBQdGIjLDr7jp59G3bSrPg5DSZJE
	 OQrqn/YcOTaIYK3FmthwhIBLEjnpOV3F9gcwyLfWlMMBwEMcvlRsWRKvnL+HbITQ4O
	 ATok1tJpCBL7nca2KnyaW2Nv6wTiv16P5CkRA8kGtQFs2k9TPRGM79ziS9jon6xJSp
	 5Snhbx8+iTePA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wMoQc-00000001b0u-13TH
	for stable@vger.kernel.org;
	Tue, 12 May 2026 14:49:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] KVM: arm64: Wake-up from WFI when iqrchip is in userspace
Date: Tue, 12 May 2026 15:49:34 +0100
Message-ID: <20260512144934.3676827-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051236-wistful-naming-15fe@gregkh>
References: <2026051236-wistful-naming-15fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Queue-Id: E5D53523DE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-245814-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

commit 4ce98bf0865c349e7026ad9c14f48da264920953 upstream

It appears that there is nothing in the wake-up path that
evaluates whether the in-kernel interrupts are pending unless
we have a vgic.

This means that the userspace irqchip support has been broken for
about four years, and nobody noticed. It was also broken before
as we wouldn't wake-up on a PMU interrupt, but hey, who cares...

It is probably time to remove the feature altogether, because it
was a terrible idea 10 years ago, and it still is.

Fixes: b57de4ffd7c6d ("KVM: arm64: Simplify kvm_cpu_has_pending_timer()")
Link: https://patch.msgid.link/20260423163607.486345-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7d301da8ff289..376a865e88426 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -729,6 +729,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
 	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF);
+
+	irq_lines |= (!irqchip_in_kernel(v->kvm) &&
+		      (kvm_timer_should_notify_user(v) ||
+		       kvm_pmu_should_notify_user(v)));
+
 	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
 		&& !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
 }
-- 
2.47.3


