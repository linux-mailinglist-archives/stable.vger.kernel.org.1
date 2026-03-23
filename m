Return-Path: <stable+bounces-229500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IGRDlxjwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A59C2F7385
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A5A3428464
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D6B3BF692;
	Mon, 23 Mar 2026 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qk1CdL3G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E33BF685;
	Mon, 23 Mar 2026 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279432; cv=none; b=ZygQGuE1etfssEq9iZ0NqW0LnMi4mMnMq51nqnomQvGubJo2387O/Y4qbPbqGyFP09mHEJMuewpJNcZuM5FkFFiqS9HeRG8r+LDs25j0UYcMiicwbG6DYKHHUDZoth6WFiGtHWrge0aP7qki0cNdn5DEvXamXlvtKxXbez8X8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279432; c=relaxed/simple;
	bh=TteG2VwSszXE0131B6otfJFhqA+o16uAp8Y4RSiFekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca4La3iFGS+KSBpDt/Vys/rPu23PCSA712Ec0oFEOVy6arQOC3fbBzqtL46RDW5Ql+erI7bl37H1lFvVoc9Bx4eZHDI1hciBpMNLpOdtjMVV5VEm8IaWFzKN0jsIU+dXQaFB+KdtL9eQwC6Y/F0TFfNOBVEMY4H7545BRdeLrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qk1CdL3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CE0C2BC9E;
	Mon, 23 Mar 2026 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279431;
	bh=TteG2VwSszXE0131B6otfJFhqA+o16uAp8Y4RSiFekc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qk1CdL3Gyr4ckgvWmOeknYnCXB7O3WHSstRQYuFJ6u+DTQrdRypzyrR/M8CamdDMu
	 iEjXCK91V7oJHHtDzVgWo2b71mmFcL72/GZdH4dymWPoWVU2oSpoILYAEiHlRQBUO3
	 zCKNl6CyXDfq7MFXX7vHH9+7d5a+XrFVfiV5pmdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessandro Ratti <alessandro@0x65c.net>,
	syzbot+1522459a74d26b0ac33a@syzkaller.appspotmail.com,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 035/481] KVM: x86: Ignore -EBUSY when checking nested events from vcpu_block()
Date: Mon, 23 Mar 2026 14:40:17 +0100
Message-ID: <20260323134526.093335094@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229500-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,1522459a74d26b0ac33a];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,syzkaller.appspot.com:url,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0x65c.net:email]
X-Rspamd-Queue-Id: 8A59C2F7385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit ead63640d4e72e6f6d464f4e31f7fecb79af8869 ]

Ignore -EBUSY when checking nested events after exiting a blocking state
while L2 is active, as exiting to userspace will generate a spurious
userspace exit, usually with KVM_EXIT_UNKNOWN, and likely lead to the VM's
demise.  Continuing with the wakeup isn't perfect either, as *something*
has gone sideways if a vCPU is awakened in L2 with an injected event (or
worse, a nested run pending), but continuing on gives the VM a decent
chance of surviving without any major side effects.

As explained in the Fixes commits, it _should_ be impossible for a vCPU to
be put into a blocking state with an already-injected event (exception,
IRQ, or NMI).  Unfortunately, userspace can stuff MP_STATE and/or injected
events, and thus put the vCPU into what should be an impossible state.

Don't bother trying to preserve the WARN, e.g. with an anti-syzkaller
Kconfig, as WARNs can (hopefully) be added in paths where _KVM_ would be
violating x86 architecture, e.g. by WARNing if KVM attempts to inject an
exception or interrupt while the vCPU isn't running.

Cc: Alessandro Ratti <alessandro@0x65c.net>
Cc: stable@vger.kernel.org
Fixes: 26844fee6ade ("KVM: x86: never write to memory from kvm_vcpu_check_block()")
Fixes: 45405155d876 ("KVM: x86: WARN if a vCPU gets a valid wakeup that KVM can't yet inject")
Link: https://syzkaller.appspot.com/text?tag=ReproC&x=10d4261a580000
Reported-by: syzbot+1522459a74d26b0ac33a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/671bc7a7.050a0220.455e8.022a.GAE@google.com
Link: https://patch.msgid.link/20260109030657.994759-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 824844a7c6e88..8617f7fec9643 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11066,8 +11066,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 	if (is_guest_mode(vcpu)) {
 		int r = kvm_check_nested_events(vcpu);
 
-		WARN_ON_ONCE(r == -EBUSY);
-		if (r < 0)
+		if (r < 0 && r != -EBUSY)
 			return 0;
 	}
 
-- 
2.51.0




