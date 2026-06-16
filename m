Return-Path: <stable+bounces-263779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QU3XL/5lMWrziQUAu9opvQ
	(envelope-from <stable+bounces-263779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DA690BD5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:04:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=M6hsx5AE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263779-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263779-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B8D305A5E4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BCD36DA1D;
	Tue, 16 Jun 2026 15:03:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF73370EA;
	Tue, 16 Jun 2026 15:03:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622213; cv=none; b=H/CmD09zFDCq38+8x/mbeGH7WRhHEmwITa1PZaVE33Ae+WpBWBuX9gtOgn8o5i8h9AjMSGSEwvpt4+MqBHS7jLy6X/w2pS6vNZ10HyY0Xq0jNLZMTuQ4qFpdkV9EYimoGlMsaxvSL055I2KK0AqGcWNSt7yRm1iEicH60I5DsC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622213; c=relaxed/simple;
	bh=eYe3x0EI555uGi8gc2ou88j87W+qa72B6JNA0P1/VRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HShZ7NJVKL7b7Mqd8bH2DfDVXiIilE3oC+zMbZFtrgAgis0dxDdgedAYpttbZ+/rRuY24+3R/5DP/9Q0jGuEojxWf9Ic5smWvNifdO3xLU5M5Q75fEO5T8RL+V7lXbVSVX1HKFDA38Tid1kq8Yh3anWv6mOPg5Rs9iBWZzNWVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6hsx5AE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE971F000E9;
	Tue, 16 Jun 2026 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622212;
	bh=DgRbclZJmqbhpaApX8pK1Gm25i63lzMi4U2As45SQI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6hsx5AEcVANuYnxDiXnqxQJUQRN16CdDOtH/ZT+qCe8Bpwpvuv+JzdK4j+pZ9/N5
	 sO4B4ycwsYMqeXNSr6Daa5Y0b9XrIr74dB3WRYgRrkcEm2tB1sYNGI6GW/hKbn6I4x
	 oXKKdosWcFKpDzhT3oiZgtGTSEXjQI3vAtJF0j68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Upton <oupton@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 7.0 002/378] KVM: arm64: Take the SRCU lock for page table walks in fault injection and AT emulation
Date: Tue, 16 Jun 2026 20:23:53 +0530
Message-ID: <20260616145109.883038193@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263779-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:oupton@kernel.org,m:imv4bel@gmail.com,m:maz@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[oupton.kernel.org:query timed out];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 606DA690BD5

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

commit f2ca45b50d4216c9cc7ffabf50d9ad1932209251 upstream.

walk_s1() and kvm_walk_nested_s2() expect to be called while holding
kvm->srcu to guard against memslot changes. While this is generally
the case, __kvm_at_s12() and __kvm_find_s1_desc_level() call into the
respective walkers without taking kvm->srcu.

Fix by acquiring kvm->srcu prior to the table walk in both instances.

Cc: stable@vger.kernel.org
Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/aiAZfdeyanIvP8SD@v4bel
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/at.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1568,7 +1568,8 @@ int __kvm_at_s12(struct kvm_vcpu *vcpu,
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
-	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return ret;
 
@@ -1664,7 +1665,8 @@ int __kvm_find_s1_desc_level(struct kvm_
 	}
 
 	/* Walk the guest's PT, looking for a match along the way */
-	ret = walk_s1(vcpu, &wi, &wr, va);
+	scoped_guard(srcu, &vcpu->kvm->srcu)
+		ret = walk_s1(vcpu, &wi, &wr, va);
 	switch (ret) {
 	case -EINTR:
 		/* We interrupted the walk on a match, return the level */



