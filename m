Return-Path: <stable+bounces-264018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnhdAAltMWoZjAUAu9opvQ
	(envelope-from <stable+bounces-264018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:34:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 925EE691299
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:34:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=giRI+PmJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264018-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264018-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 280E1306849C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0536F8F1;
	Tue, 16 Jun 2026 15:28:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ABD2EEE68;
	Tue, 16 Jun 2026 15:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623691; cv=none; b=B3WVmznBGybhZeMoCszO6WocROplaBPv7yDrDW2xsvBLUjJp6BR2nVJ6g010KOEXSnZI96tVU3BWQiAJny6ycp4/J3Ja2Qrs3qXr43UAGUou1sLpM5thoGvqOlHQQjSuKIHrCeXjCMjNXlqSEvi9C5TLbtvdCPT0totoOM+LAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623691; c=relaxed/simple;
	bh=CXJc3viG5oBeKeU9DHWKuN34C2Y7XHlyjY0BqOTvpfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkeFMp13uBnRnFSOG0GmAzzCBVi8Lp2cDQfbtjwuUwAyCI+IHGBGiY48uFRqaBjdzGVrkfdROrmrU4/rwQmSErfoxSg7MnKUo0p7wGGNDJsvedOLxTPHdB0vdoGa87k3bos13i23HJncU1p8uXtvfDMqc7lHjJc6eNNVQeG7Xco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=giRI+PmJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5FD1F000E9;
	Tue, 16 Jun 2026 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623690;
	bh=+zjdSA7u0llSVey7K3Ft5a4mNSOScWiW6EioL2xU68w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=giRI+PmJ/xjGSM0gEbAmbYGeyjtIAUXD8FOoiCJfSjOTGfvWgsiWhI6x0ufhBEb+z
	 sV5YJqmG9RJrjg7egxMblZcUyIlyAeqFodd0HTa0WxWfeyl4jRvdsPJ9IvuGYaJIS8
	 QgWXocWtvrxSUNc7BrqLiUrS/fiTrtJTcVwIeRFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 7.0 197/378] KVM: arm64: nv: Fix handling of XN[0] when !FEAT_XNX
Date: Tue, 16 Jun 2026 20:27:08 +0530
Message-ID: <20260616145120.760378399@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:weilin.chang@arm.com,m:oupton@kernel.org,m:maz@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264018-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,arm.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 925EE691299

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Upton <oupton@kernel.org>

commit 49b32ddb87a3a109afecea89e55d70f73956b8bc upstream.

XN has already been extracted from its bitfield position so using
FIELD_PREP() on the mask that clears XN[0] is completely broken, having
the effect of unconditionally granting execute permissions...

Fix the obvious mistake by manipulating the right bit.

Cc: stable@vger.kernel.org
Fixes: d93febe2ed2e ("KVM: arm64: nv: Forward FEAT_XNX permissions to the shadow stage-2")
Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
Signed-off-by: Oliver Upton <oupton@kernel.org>
Link: https://patch.msgid.link/20260602165901.52800-2-oupton@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kvm_nested.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -131,7 +131,7 @@ static inline bool kvm_s2_trans_exec_el0
 	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
 
 	if (!kvm_has_xnx(kvm))
-		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
+		xn &= 0b10;
 
 	switch (xn) {
 	case 0b00:
@@ -147,7 +147,7 @@ static inline bool kvm_s2_trans_exec_el1
 	u8 xn = FIELD_GET(KVM_PTE_LEAF_ATTR_HI_S2_XN, trans->desc);
 
 	if (!kvm_has_xnx(kvm))
-		xn &= FIELD_PREP(KVM_PTE_LEAF_ATTR_HI_S2_XN, 0b10);
+		xn &= 0b10;
 
 	switch (xn) {
 	case 0b00:



