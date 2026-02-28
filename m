Return-Path: <stable+bounces-220739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mABFBKtBo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6451C703A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A957B3087D6A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948A49218A;
	Sat, 28 Feb 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHeoM1Bs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99633E35A;
	Sat, 28 Feb 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300620; cv=none; b=LPwRTJpjXc/gTEIgcxVr0eCQujF0CLDHqj6A8BENrOz5in456B/P81I+NmBRUwErnWDg7XrzWcmbk2ayhFRJYfzNBZCduuMfwiDyIJ3wJzYff2ZdZaVJgrX9/KSNxc0yEZ3phxufnfAr0VphTzK1RHOy7yro5dKf8184QKEe1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300620; c=relaxed/simple;
	bh=QR45+H+PlYDCm+HpbNLhOxLuXNzrpI9pZ2tdfedIGM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ094bKfmKMO1xrYn9aBOJ8ZuKmgraFpUCs+uILahljPXmNKrOjPUM2pUb3IOY4nXx9curFE9dYaSklPN/YzrANEu9n+gzOZ8PNJRhRVsqflRqn3iY6eatN0fBPsRN3IqrKElQ0A8G+zgzxOPghmRujCEVkRSr1GTKPdpwZFMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHeoM1Bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9CEC19424;
	Sat, 28 Feb 2026 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300619;
	bh=QR45+H+PlYDCm+HpbNLhOxLuXNzrpI9pZ2tdfedIGM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHeoM1BsHyykMRER+RvPA4XRwLBeWQab1NkvhxrVGVhZ34iqFJAGJ9H2WjNl+qms7
	 O3ix+OJ7sBEGG6/d11wEf5ZJioEeQSjAXryReqXLJ1inyjTnwclpjT2bPvrlToSMVQ
	 DQIOKiL3q0jLPP3BfvAph4f1yVVa5Tcff9eFTst+hAl5UZ8APe8ut6gnyoiD566ZzN
	 MwFWhCzQD6lIcU7QzpkAH6FjV90rniWDaqQoVri8D4bBdAe9owm0TlTkuLj6aqy4iS
	 47zy3re0NQgKpcDvi+PL8N2O2pRxQEH84q9LXRDwj0iuj2218hj3fhZliib3qmIS3U
	 X5y4N5MAxGRYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 660/844] KVM: arm64: nv: Return correct RES0 bits for FGT registers
Date: Sat, 28 Feb 2026 12:29:33 -0500
Message-ID: <20260228173244.1509663-661-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-220739-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linux.dev:email]
X-Rspamd-Queue-Id: AE6451C703A
X-Rspamd-Action: no action

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

[ Upstream commit 2eb80a2eee18762a33aa770d742d64fe47852c7e ]

We had extended the sysreg masking infrastructure to more general
registers, instead of restricting it to VNCR-backed registers, since
commit a0162020095e ("KVM: arm64: Extend masking facility to arbitrary
registers"). Fix kvm_get_sysreg_res0() to reflect this fact.

Note that we're sure that we only deal with FGT registers in
kvm_get_sysreg_res0(), the

	if (sr < __VNCR_START__)

is actually a never false, which should probably be removed later.

Fixes: 69c19e047dfe ("KVM: arm64: Add TCR2_EL2 to the sysreg arrays")
Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Link: https://patch.msgid.link/20260121101631.41037-1-zenghui.yu@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 834f13fb1fb7d..2d04fb56746ea 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2428,7 +2428,7 @@ static u64 kvm_get_sysreg_res0(struct kvm *kvm, enum vcpu_sysreg sr)
 
 	masks = kvm->arch.sysreg_masks;
 
-	return masks->mask[sr - __VNCR_START__].res0;
+	return masks->mask[sr - __SANITISED_REG_START__].res0;
 }
 
 static bool check_fgt_bit(struct kvm_vcpu *vcpu, enum vcpu_sysreg sr,
-- 
2.51.0


