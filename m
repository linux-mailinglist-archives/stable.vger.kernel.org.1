Return-Path: <stable+bounces-228950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFo2KfJYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B62F60C2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A704430F5C66
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5013AEF4F;
	Mon, 23 Mar 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h2DEK2FN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC72741A0;
	Mon, 23 Mar 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277583; cv=none; b=afpORnKb39X9EnvxwyC99bkXHn/c6FBz4VTv5zqJq1ovinLp8Ti2NHCAijtvQuB7FfSer8eWTIcBCngk+t8TQfaj+Q7RZn+/pIoovBvwQnKvjj7cSZxcWyvQIbI1vv4O7TYSY6UFF6GYE3I00GISm/lnBrytV8k5OpA0s17wp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277583; c=relaxed/simple;
	bh=rRWxYtlYdI9DflkdX47+nrmkHHGgYYdrsx8M07+gYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt2+ZsJNuJdEUuuKYKS9LBD8SIUGaXS80bnPpwSs3IpKC/A0g3Npwzk5BsIXoGK/CTke9tlHW6o8e9UsNn2Qjj6z3FMRIa+3IEyFZL6H3yPNnxydzRkccfHcLBVU66eVOQLaBJx8QPNEAfFob3AJY4QGBhSHbb2A//+XH7kY0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h2DEK2FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAA8C4CEF7;
	Mon, 23 Mar 2026 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277583;
	bh=rRWxYtlYdI9DflkdX47+nrmkHHGgYYdrsx8M07+gYm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2DEK2FNNpTh+7U15oJd4HRj64M/40m2rPIo6GYmRguZ4Emuawgus4ByAC2bqWKqS
	 x1jiwXZTrjAld1h4IGi8NTmlp8M+K5rx2XopBt1qy8mfUsqMzegXJJZuJ61lnYdIRK
	 Q3nfi9eNpx5J4HA9YUNjJR6A2DymTx8w8ZH0tKqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 039/567] KVM: x86: WARN if a vCPU gets a valid wakeup that KVM cant yet inject
Date: Mon, 23 Mar 2026 14:39:19 +0100
Message-ID: <20260323134534.762794788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228950-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 462B62F60C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 45405155d876c326da89162b8173b8cc9ab7ed75 ]

WARN if a blocking vCPU is awakened by a valid wake event that KVM can't
inject, e.g. because KVM needs to complete a nested VM-enter, or needs to
re-inject an exception.  For the nested VM-Enter case, KVM is supposed to
clear "nested_run_pending" if L1 puts L2 into HLT, i.e. entering HLT
"completes" the nested VM-Enter.  And for already-injected exceptions, it
should be impossible for the vCPU to be in a blocking state if a VM-Exit
occurred while an exception was being vectored.

Link: https://lore.kernel.org/r/20240607172609.3205077-7-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: ead63640d4e7 ("KVM: x86: Ignore -EBUSY when checking nested events from vcpu_block()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19cae03e423b1..3edfcb4090b18 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11003,7 +11003,10 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 	 * causes a spurious wakeup from HLT).
 	 */
 	if (is_guest_mode(vcpu)) {
-		if (kvm_check_nested_events(vcpu) < 0)
+		int r = kvm_check_nested_events(vcpu);
+
+		WARN_ON_ONCE(r == -EBUSY);
+		if (r < 0)
 			return 0;
 	}
 
-- 
2.51.0




