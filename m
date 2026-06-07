Return-Path: <stable+bounces-261364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ML2K3xIJWoEGAIAu9opvQ
	(envelope-from <stable+bounces-261364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:31:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE9864FBD1
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:31:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=QxksFNLA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261364-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261364-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 169AE3003BC6
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B253327BFA;
	Sun,  7 Jun 2026 10:31:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96132AAD6;
	Sun,  7 Jun 2026 10:31:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828267; cv=none; b=WpJoApdqPNh9UvNEls6U9JaAtRnHjWUNPbfi9/7O/vQJQktInRuEtIF5pB42kekz5IjDiSkF8dDxd+e5O+xpewt3nMR8vGa87bf7FL2ozfZ4ZM2wji4FT+PLX5dgW0aBjhNaLpVafpZ1xdhDoyNXzjMpGbe/IhoaOVVktAN6ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828267; c=relaxed/simple;
	bh=HPDpCw4WfpzWGLOdk4nttvcXC+MD2kaPyErePkipZlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjmsKuXBtLRNsWFnaNEVJXDj2yXdsnnBoQ+Zrz5UDM2lzNtektRMw6UCv3hsUaxAZc51zbHYsmbvJXaMimvYJCcKXhBTdol2lxhbrAq3nLkvKVYzkMIJg4mcKIeEplXI0ve/hAZQlQ2iot+CgajUsct7rUwtP7ZZ0Sx+8KGioc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QxksFNLA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4981F00893;
	Sun,  7 Jun 2026 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828266;
	bh=GltwVCuo4e65V/mRlWN2NUcOMsewYnSrLYzWrJ1weUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxksFNLA1Hn3fYH/inAGeMcD41dzaZrPEhcaQJqEa3CiVx8ecVre7Lrc8X5IdR6jB
	 QGPBuubJ5vb+wSnOkRZ/3PKA92QgUBKIgQG1btH+rjQI9ZRI4jFFEW9S9aA7991J+j
	 mto+g8DqF3nae/UyVHJhGnwgPjEKu2EQ9I2e2S3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.18 145/315] KVM: SEV: Ignore Port I/O requests of length 0
Date: Sun,  7 Jun 2026 11:58:52 +0200
Message-ID: <20260607095732.929090398@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261364-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:thomas.lendacky@amd.com,m:seanjc@google.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABE9864FBD1

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 3988bd2723de407ae90fa7a6f6029b4e60238c58 upstream.

Explicitly ignore Port I/O requests of length '0' (or count '0'), so that
setting up the software scratch area (and other code) doesn't have to
worry about underflowing the length, and to allow for WARNing on trying
to configure the scratch area with len==0.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4499,6 +4499,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
 	default:
 		ret = svm_invoke_exit_handler(vcpu, exit_code);
 	}
@@ -4519,6 +4524,9 @@ int sev_es_string_io(struct vcpu_svm *sv
 	if (unlikely(check_mul_overflow(count, size, &bytes)))
 		return -EINVAL;
 
+	if (!bytes)
+		return 1;
+
 	r = setup_vmgexit_scratch(svm, in, bytes);
 	if (r)
 		return r;



