Return-Path: <stable+bounces-257212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJqKNY8XG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:59:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EAF60EAFE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC3263042510
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91133FE15;
	Sat, 30 May 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEzBsG/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19253438AE;
	Sat, 30 May 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160201; cv=none; b=baXV5zhuZklueI8WDlbGtTYBY+v4DZkaJbhRHrsKVwnjgi3GNZDNglAZeCGkUaVVBx5U8egJLvDXZCpAxLqI5fGSjz+sp5P9lBiQwfOVPyCs4EQS1nRHMxQ0YEJFV0CPz6fJH/IoeBhxivS3mZP4lfZTJRbZVDtyWl5spdMtA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160201; c=relaxed/simple;
	bh=enK5cjeCOJ5usj7o4M0yGN7tqEi3S5U5kmkYb5pu00c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj3J6w98oei862/jjSBFu31Su2BQtYLt0wrlFM7TYWjOAyENKmd08sHawyRTzB1gkU0UCY2TwAABMiH1pUhGAmekznVZW/sBcpHw4/RiftKQTPl4jYZ9rlbz52w/fsYV/nHp19aJfDpABwseOvjCXQmeUuV/pKRr9f3qQNJohUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gEzBsG/B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAFE1F00893;
	Sat, 30 May 2026 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160200;
	bh=AosIkSzgUQA3rEuK3ApIed9LBkIawWZMrOME951Cdmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEzBsG/BhReIM5nn2HbvlLa1HvmA1vaQ6XMEj9JSJ1bt+ZHW2/1dLY5svR/I4miyV
	 zKwgiSKGXtr82WND2Z0LfNw0JNHh44hw6DJhuEaU3VgEzPyYTl42Uih4firQJePpqU
	 0D/HpM/5RZXQSz3gFS9qnFhbMj/EDtoDwk4HWTzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Cheng <chengkev@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1 235/969] KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0
Date: Sat, 30 May 2026 17:55:59 +0200
Message-ID: <20260530160306.949903327@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257212-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 75EAF60EAFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Cheng <chengkev@google.com>

commit d99df02ff427f461102230f9c5b90a6c64ee8e23 upstream.

INVLPGA should cause a #UD when EFER.SVME is not set. Add a check to
properly inject #UD when EFER.SVME=0.

Fixes: ff092385e828 ("KVM: SVM: Implement INVLPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Cheng <chengkev@google.com>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20260228033328.2285047-3-chengkev@google.com
[sean: tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/svm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2399,6 +2399,9 @@ static int invlpga_interception(struct k
 	gva_t gva = kvm_rax_read(vcpu);
 	u32 asid = kvm_rcx_read(vcpu);
 
+	if (nested_svm_check_permissions(vcpu))
+		return 1;
+
 	/* FIXME: Handle an address size prefix. */
 	if (!is_long_mode(vcpu))
 		gva = (u32)gva;



