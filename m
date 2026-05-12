Return-Path: <stable+bounces-246049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPkrOKhqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:00:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72989526775
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A496631939CE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC563BB11D;
	Tue, 12 May 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ss+Do952"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DE3955D0;
	Tue, 12 May 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608227; cv=none; b=T45IxofeX1FIDmaWExE8pYbyjE+/u2g+KsuS2EKyFuZkvWf7xlB+wMVtaXMFObC6vIQRE/OsC/P32kW4JOGOylOpFG6h3EdJUOlPDThXui+vbkDH/OBCPSOllgqug4OLHDBwR2cX3MYUxvajMVq3wWxEcbRllWMk+59pNTRwVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608227; c=relaxed/simple;
	bh=NpREYZLX1YAOn2fh4tttvCfwdUycwYXMxxiyG2flXq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHr5PiqOrHws0XaEK8FA++1wZX6z0Xzt52j5YVdMA4OgibxHM1aYP96rLgFLoWl/seZKUyjIa623/zUDmRwLglNxQiec029o7im1JCKG9X01kBshsygN+gOKDp10R50yfrvyBOsZadIQ3KMZ+EFbrtn3NwbrIgx9zAN0znfQnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ss+Do952; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35AEC2BCB0;
	Tue, 12 May 2026 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608227;
	bh=NpREYZLX1YAOn2fh4tttvCfwdUycwYXMxxiyG2flXq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ss+Do952srpVsZBbRm+EuITdRGaCxff/67kkeQmXrA/3ItmeHv4gWUw/p1nTrf9p+
	 zKezJAkaC/f3jorbKLNr3gXU7FzSMNhnKtOXxPqu1QekwxwmHiLiWi1hyLtLlkm1pU
	 liqQhHbi7WgVnmWfvcsD8Ll94w2vQuzyXHXx/pKQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.12 205/206] KVM: arm64: Wake-up from WFI when iqrchip is in userspace
Date: Tue, 12 May 2026 19:40:57 +0200
Message-ID: <20260512173937.217612722@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 72989526775
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246049-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/arm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -729,6 +729,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(stru
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



