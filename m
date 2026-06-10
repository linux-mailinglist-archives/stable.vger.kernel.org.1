Return-Path: <stable+bounces-262566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SHGEJZWyKWqAcAMAu9opvQ
	(envelope-from <stable+bounces-262566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 20:53:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E566C61A
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 20:53:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NDFVv3f3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+Bl4g6Bv;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NDFVv3f3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+Bl4g6Bv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262566-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262566-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65EC30EE3FD
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EC3502A5;
	Wed, 10 Jun 2026 18:53:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BED3002D1
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 18:53:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117586; cv=none; b=HNV2Z0pPNC/XpLIboJa3VPtu0eOgvWi/TRqqb8bKNTCyMOot52jGl1c9Ah3vOLVlLR4arfC3EcnfpTil950xGzjbSPSCRswKjXMnSmHVhRcFxSH7c7hJU++gWe83wb3c3Hv0IW+Sb6M0a2nUb0oDIcH5n4edaC40k2v4ORiH/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117586; c=relaxed/simple;
	bh=WZckIkPtJEFt85KizNg0TyTxE35KcCiksInVQT7La7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=csgwneLWgiIiwAryiITm8eDzSnuwCeIBTKiajBD7AzyaFkaADCCyF5q+H9czmvg4z2mUDYrZLTS3RL206Wwo4c+vkM4Y0NqKAzAIWzFazD49MwnHcUFnSCB9RgAZqv4+H7Vc/R4BUeFCfflsGqqxymK9idOPgM/S00BSHBvpQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NDFVv3f3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Bl4g6Bv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NDFVv3f3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Bl4g6Bv; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9942B6AD9B;
	Wed, 10 Jun 2026 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781117583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQrpQAXhwzte2PS5h1duYn8S+KPaq/lup3R50f9DqUg=;
	b=NDFVv3f3DGbRJECfKy850c4mmohlkt5vb4m5Dj7jJWtKuoZN4VY44bQ6hqIsuhRpKdi6qT
	cN6hPCrxNu2yl1PmygAFC+E6VNQMVvkkHuvwNmTjn4QiBvUEzJR46ND1+GP+bbPIu4WoHh
	evUV6fxv20PmYvl4AI7QKZt9s8b86BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781117583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQrpQAXhwzte2PS5h1duYn8S+KPaq/lup3R50f9DqUg=;
	b=+Bl4g6BvB5FTZR6UsAVzGbR4LWz8BVvV6ibX0OfBBaexWwjnRI4ht+H3VJlt2oFkq+376y
	xhjiHf6UtgY3wjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781117583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQrpQAXhwzte2PS5h1duYn8S+KPaq/lup3R50f9DqUg=;
	b=NDFVv3f3DGbRJECfKy850c4mmohlkt5vb4m5Dj7jJWtKuoZN4VY44bQ6hqIsuhRpKdi6qT
	cN6hPCrxNu2yl1PmygAFC+E6VNQMVvkkHuvwNmTjn4QiBvUEzJR46ND1+GP+bbPIu4WoHh
	evUV6fxv20PmYvl4AI7QKZt9s8b86BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781117583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQrpQAXhwzte2PS5h1duYn8S+KPaq/lup3R50f9DqUg=;
	b=+Bl4g6BvB5FTZR6UsAVzGbR4LWz8BVvV6ibX0OfBBaexWwjnRI4ht+H3VJlt2oFkq+376y
	xhjiHf6UtgY3wjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C62DE779A7;
	Wed, 10 Jun 2026 18:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 921CLY6yKWotZQAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 10 Jun 2026 18:53:02 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: osteffen@redhat.com,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Roman Kagan <rkagan@virtuozzo.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] KVM: VMX: Raise KVM_REQ_EVENT on TPR below threshold exit
Date: Wed, 10 Jun 2026 20:50:43 +0200
Message-ID: <20260610185042.2810880-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.29
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-262566-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[clopez@suse.de,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kvm@vger.kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:osteffen@redhat.com,m:clopez@suse.de,m:sgarzare@redhat.com,m:stable@vger.kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clopez@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E57E566C61A

The TPR_THRESHOLD field in the VMCS is used by VMX to induce VM exits
when the guest's virtual TPR falls under the specified threshold,
allowing KVM to inject previously masked interrupts.

KVM handles these VM exits in handle_tpr_below_threshold().
Commit eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
optimized this function by calling apic_update_ppr() instead of raising
KVM_REQ_EVENT. apic_update_ppr() then raises KVM_REQ_EVENT if there is
a pending, deliverable interrupt.

However, if there are no new interrupts pending, apic_update_ppr()
does not issue the request. This skips calling update_cr8_intercept(),
and thus vmx_update_cr8_intercept() before VM entry, which results in
a high, stale TPR_THRESHOLD. This is problematic due to the following
sentence in 28.2.1.1 "VM-Execution Control Fields" in the SDM:

  The following check is performed if the “use TPR shadow” VM-execution
  control is 1 and the “virtualize APIC accesses” and “virtual-interrupt
  delivery” VM-execution controls are both 0: the value of bits 3:0 of
  the TPR threshold VM-execution control field should not be greater
  than the value of bits 7:4 of VTPR.

This error condition is typically not observed when KVM runs on a bare
metal system because modern processors support APICv, which enables
virtual-interrupt delivery, and which KVM uses when possible. This
causes the processor to no longer generate TPR-below threshold exits
and to no longer check TPR_THRESHOLD on entry. However, when running
on older platforms, or under nested virtualization on a hypervisor that
does not support virtual-interrupt delivery and enforces this check
(like Hyper-V) this can cause a VM entry failure with hardware error
0x7, as seen in [1].

Fix this by re-introducing an unconditional KVM_REQ_EVENT when reacting
to a TPR-below-threshold exit, ensuring that vmx_update_cr8_intercept()
is called to re-evaluate TPR_THRESHOLD before entering the guest.

Link: https://github.com/coconut-svsm/svsm/issues/1081 [1]
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Fixes: eb90f3417a0c ("KVM: vmx: speed up TPR below threshold vmexits")
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/kvm/vmx/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c548f22375ad..21a469d3ba21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5824,6 +5824,7 @@ void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 static int handle_tpr_below_threshold(struct kvm_vcpu *vcpu)
 {
 	kvm_apic_update_ppr(vcpu);
+	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	return 1;
 }
 

base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.51.0


