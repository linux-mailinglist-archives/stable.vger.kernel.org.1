Return-Path: <stable+bounces-243510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIM7JAmt+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:28:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ECA4BF83C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDCC13020A64
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084613D75D7;
	Mon,  4 May 2026 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iw87RUva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D83AA4F8;
	Mon,  4 May 2026 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904069; cv=none; b=m7lGBSSG3EXIB9ea/jX5ZADcfh9R6tBYrfBAqCI5ANfv8lcr5oEIDp4bfd7I+DUFJHDLlYS7C0gIUJN6wIWQDbo/rk4Av6Q9P2S5+OX6GYPgBBkXmE87uPEN5W2QMcb9Ncj/76L+aOEr00ZMidcDSbdXNu4lA5PVTVDqP3vpfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904069; c=relaxed/simple;
	bh=wgFDb6FcY7v8LhDiuJGc5QTiNa+CJAQfgGca2QHjlJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ3qDP1bqdFBpPmPVKQcbQSJkHdLlxHADJkX91HVDi/oDkguAkOEiJdl9aInCx12R9YMxnc8wuRgvYns3ORR6FGjhBRQrxWpJa0/OSH3VgVGJcVSLeqhCvx34k5o+1/fOht0KWSXfi4g1rKMjzQXbIPA1DOgk00pDPZ5ZiED0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iw87RUva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5592FC2BCC4;
	Mon,  4 May 2026 14:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904069;
	bh=wgFDb6FcY7v8LhDiuJGc5QTiNa+CJAQfgGca2QHjlJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iw87RUvaxXzEeA/p1xdRbrnCQZjceqtuMFLbzNjseQ063Jk6mGd+0aG6iUP071Jhy
	 Q3Kur9rRYsjED5RHDkeMHs4tkih1LGfSyy7fJ8X4InNx2W+7okZ+QOjgcp6WRLqhy/
	 /fF5iKrAVN33yr0nR8xu7yYWZvJceIHTbHf5f6to=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Cheng <chengkev@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.18 172/275] KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0
Date: Mon,  4 May 2026 15:51:52 +0200
Message-ID: <20260504135149.450480792@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 04ECA4BF83C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243510-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,linux.dev:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2289,6 +2289,9 @@ static int invlpga_interception(struct k
 	gva_t gva = kvm_rax_read(vcpu);
 	u32 asid = kvm_rcx_read(vcpu);
 
+	if (nested_svm_check_permissions(vcpu))
+		return 1;
+
 	/* FIXME: Handle an address size prefix. */
 	if (!is_long_mode(vcpu))
 		gva = (u32)gva;



