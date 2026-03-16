Return-Path: <stable+bounces-225633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DpIIpM8uGmpagEAu9opvQ
	(envelope-from <stable+bounces-225633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:23:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0C729E149
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A82D83049CA7
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43123D6478;
	Mon, 16 Mar 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHbGy5IH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB23D1CBB
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681607; cv=none; b=sSogY+2vCPsS4Y0XbpyR6xosGbsG028p9UQj/pNGS+1oXMiHFrs5cU8WhOauzQksWdXv8pMUXnSuxBfYkfacARAR3Vftn6RqBzc495U+VrDpCahyFcCC9Ll8ok92aa8+j5/ILJJ434tQZzwU4rwnIsXGTjmG9R/kIPBseQn80Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681607; c=relaxed/simple;
	bh=cXvjuo67lKYeT92wjTdUu1sNlLFfnHS6RTivXEKFbRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fny6P2o5MdAI6Dp3vVyvnZYV8yhzZ1yf4G5/I3gsz92v+efyScYxYyx34JSTSUaHb4jZkZMIhC+PSp4hCK4Nc89GT8xUrnHHVbvjHmGyWk61p5nLNaV4z1Tv04MQDAITtx3BZJ7vmVVbWXAI7pnC30rJCVY1bxNPDc7QEs6zzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHbGy5IH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC05C2BCB3;
	Mon, 16 Mar 2026 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773681607;
	bh=cXvjuo67lKYeT92wjTdUu1sNlLFfnHS6RTivXEKFbRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHbGy5IHT0UqMubkZ4JE6A1C5PJZrXYi3NqiMctjZWzZWXyDkepmw6JUMgh90+dby
	 lDBAYVIysb0Oy2oRyzJzITVLyE/lgFGdYxslKeBpk2tFTWgftPvyIaRZTgZaewsfEC
	 lehdNyVFE7X5d4GRVZlQD0yq/rZgku+JnsrIb1WtQfTE4K88qwtb6YudpDbvc0P+jB
	 Kryl5CRJ+6i0UiqHLemWZ2iYdNkhX5RyALGYdO/IfW6R73QUqcfpt2ds5yqilXhqpC
	 Qb0CePiGyEuhaITJuiSh1s/5x0FXUx4ycHEv96cRTkoGV7a8gsKf88pfG0v2rmSBi4
	 Mg3y8PkiVA0Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/8] KVM: x86: do not allow re-enabling quirks
Date: Mon, 16 Mar 2026 13:19:58 -0400
Message-ID: <20260316172003.1024253-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316172003.1024253-1-sashal@kernel.org>
References: <2026031659-scroll-setting-4687@gregkh>
 <20260316172003.1024253-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225633-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C0C729E149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 9966b7822b3f49b3aea5d926ece4bc92f1f0a700 ]

Allowing arbitrary re-enabling of quirks puts a limit on what the
quirks themselves can do, since you cannot assume that the quirk
prevents a particular state.  More important, it also prevents
KVM from disabling a quirk at VM creation time, because userspace
can always go back and re-enable that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: e2ffe85b6d2b ("KVM: x86: Introduce KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c504d6fecf59..10bbc7c446cd8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6538,7 +6538,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 		fallthrough;
 	case KVM_CAP_DISABLE_QUIRKS:
-		kvm->arch.disabled_quirks = cap->args[0];
+		kvm->arch.disabled_quirks |= cap->args[0];
 		r = 0;
 		break;
 	case KVM_CAP_SPLIT_IRQCHIP: {
-- 
2.51.0


