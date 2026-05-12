Return-Path: <stable+bounces-245981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GwkDdhpA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:56:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C95264DF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BA763076F72
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FB3E9C39;
	Tue, 12 May 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bvv2BYhv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00C3EDE7D;
	Tue, 12 May 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608051; cv=none; b=i1leacTrdjAE41B/lYRiK/aNtZ2PoF0d2ON/QHH7+RJknbdcVxV4rWWYe++lTzb3Z7C0Cdq4tO6qv61gilAisZ49jmFW4I3KiOKNIm24SJxE6weeRL1zyR7NfXXI+bGEoSluIW+j7QIwEIywAIqwL+56CLB4ZMIK/QJGJzrbQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608051; c=relaxed/simple;
	bh=ApOlhyRqlwMzuUVndKd0tQSo7eTg0Gd3vnHO7Q4pEe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWbH0uMakGG2es/5yJHdGinihubnfEga5qDEVp2mnaNH4cPiWFcXNObuJSpL1W8I8QG6D4FFmAB2tcYrc/f3xcOdGnEndtzSKG6dwivO5WNk23DSZ0gnrKY0v36aKo+bdiIN4HzkvybEk4m5Ujx+IiEmEbj7uBs9ky3+R2mTOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bvv2BYhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC5DC2BCF6;
	Tue, 12 May 2026 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608050;
	bh=ApOlhyRqlwMzuUVndKd0tQSo7eTg0Gd3vnHO7Q4pEe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bvv2BYhvb4Z/rWnSMT5ImDLm9Rq6IJnDZvYb9BtO6MNDmLmp9o59pdzsGa5jCvPl0
	 yA/4x9x4jJ7m1fIahdxqb+4n/nxEYVqIs3A6HUg5wrQ/8fi9aXn5ZVSIlTSdgqJsWw
	 J9QlD0weEdLQhwWavyP/SIncsCc3gpffeYQUmXc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Andy Chiu <andybnac@gmail.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 6.12 135/206] riscv: kvm: fix vector context allocation leak
Date: Tue, 12 May 2026 19:39:47 +0200
Message-ID: <20260512173935.718950582@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 300C95264DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245981-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,brainfault.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,brainfault.org:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Osama Abdelkader <osama.abdelkader@gmail.com>

commit b7c958d7c1eb1cb9b2be7b5ee4129fcd66cec978 upstream.

When the second kzalloc (host_context.vector.datap) fails in
kvm_riscv_vcpu_alloc_vector_context, the first allocation
(guest_context.vector.datap) is leaked. Free it before returning.

Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Andy Chiu <andybnac@gmail.com>
Link: https://lore.kernel.org/r/20260316151612.13305-1-osama.abdelkader@gmail.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kvm/vcpu_vector.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -79,8 +79,11 @@ int kvm_riscv_vcpu_alloc_vector_context(
 	cntx->vector.vlenb = riscv_v_vsize / 32;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
-	if (!vcpu->arch.host_context.vector.datap)
+	if (!vcpu->arch.host_context.vector.datap) {
+		kfree(vcpu->arch.guest_context.vector.datap);
+		vcpu->arch.guest_context.vector.datap = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }



