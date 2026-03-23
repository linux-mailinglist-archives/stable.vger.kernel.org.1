Return-Path: <stable+bounces-228951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Au5MvNYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B92F60C9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B65305C8E9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D23AEF51;
	Mon, 23 Mar 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgCaCWl7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375442741A0;
	Mon, 23 Mar 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277586; cv=none; b=cUssEWmOgrRJaVY99kOszhrnBHMRLuxlMzYeZGjlS+1Rf+NfwOVWDada3E8MfYqUk1DpVndjBFM9gXPINeUpNlmVrGIvePsQKqkAb/6zr7zUjQ6nS+OBdDdn+2jNqQIkO1UwtFrUkFrQ61uv2bcH5bqrwGQAM1RmcyIGWKGYa64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277586; c=relaxed/simple;
	bh=9bCfTXRT9xHqGeJYUGJLC4ppxn/ELbNNp7c4algXYZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qE9oScjA49ZhuTzNJzFiPRshYCrm9IJ1KNTMQMgih4SdHePiGAKuEgeQkOus22xIcrAdfSZYNrj50XjFttggybxcgEFNWnOXqds5RBLiafwd2pz4EMr9ZTmBuS0Etk1MKdzj086Ngqr1coIQu1uR9ODhfEkOxQYf20zEQcT3cqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgCaCWl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0989C4CEF7;
	Mon, 23 Mar 2026 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277586;
	bh=9bCfTXRT9xHqGeJYUGJLC4ppxn/ELbNNp7c4algXYZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgCaCWl7en3T+eUrwofcJRgOwxpRADXUXcBrRhREuslmO2gJ1293gpannl5pdG1WT
	 6IwSk2UhJRtpRqoWn36Qg1fAoxDFAVVU4yY1/6o0+UkD2RWaobLFH25ebEIA08QOsT
	 2/2epvFI7Tf8g16ZzRCP+YtrBgL6X0+DJVhaf0Pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessandro Ratti <alessandro@0x65c.net>,
	syzbot+1522459a74d26b0ac33a@syzkaller.appspotmail.com,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/567] KVM: x86: Ignore -EBUSY when checking nested events from vcpu_block()
Date: Mon, 23 Mar 2026 14:39:20 +0100
Message-ID: <20260323134534.785615917@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228951-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,1522459a74d26b0ac33a];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3D2B92F60C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 3edfcb4090b18..ac0b458582c38 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11005,8 +11005,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 	if (is_guest_mode(vcpu)) {
 		int r = kvm_check_nested_events(vcpu);
 
-		WARN_ON_ONCE(r == -EBUSY);
-		if (r < 0)
+		if (r < 0 && r != -EBUSY)
 			return 0;
 	}
 
-- 
2.51.0




