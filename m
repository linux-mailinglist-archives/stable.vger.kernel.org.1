Return-Path: <stable+bounces-243749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HqEJOiw+GkdzAIAu9opvQ
	(envelope-from <stable+bounces-243749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927064BFF6D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA8CF30762FA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3503DEAE0;
	Mon,  4 May 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9MYTwmD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFF3DE45B;
	Mon,  4 May 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904680; cv=none; b=WC+L9TU+p0kiwpyO5sJpZRp7cSxoFhe9ELhpMyc/RfucXWPMqR1eHh+wg9hOlON/f7PqoxrlnHxnRtPBajQswfmZJc57xAI/fY3NFePa1px9i9sZ/LQZRXJZp6djs0lUbkfsSVl81uTfMFFXgmpMZEFNgiudmqIo8hODSWjzuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904680; c=relaxed/simple;
	bh=cWsEqZTjkdK/pdHc4kGIEV8CGAt3RJeX1xRxpsRZsLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi2MKYTayjQMyZj1xDIiWgUZQ9Ttjs3vz9SsvQbdSpROJY4WCGYmpQ6iAguqNSWzxTbbkkmBRw2jicmwbD9dsIwJEjeMCYut/9md9og1RW5ZquLgSLMRweI7mEcmmTAj7PfIZl7BOQ1JAmYxapgfV86Y417LO+e0nSDKMTkNyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9MYTwmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8124FC2BCB8;
	Mon,  4 May 2026 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904679;
	bh=cWsEqZTjkdK/pdHc4kGIEV8CGAt3RJeX1xRxpsRZsLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9MYTwmDXUA0R7/SVmStJ2ivbiDq37s3VPIlH4OTmBgUx5BAJYzA51ibOmYYXjqQ+
	 qWtVlqz1lCDVGR17WVdZ4esK6IFaX+DSQ/O03bn6wQEFjbbYB6TGKKiUS4rdJybh6T
	 tYxtg2Cq2TEQhDOl+vWbqu197b7aikX+RzTe6n5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12 131/215] KVM: nSVM: Add missing consistency check for nCR3 validity
Date: Mon,  4 May 2026 15:52:30 +0200
Message-ID: <20260504135134.935667782@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 927064BFF6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243749-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,g_pat.pa:url]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry@kernel.org>

commit b71138fcc362c67ebe66747bb22cb4e6b4d6a651 upstream.

>From the APM Volume #2, 15.25.4 (24593—Rev. 3.42—March 2024):

  When VMRUN is executed with nested paging enabled (NP_ENABLE = 1), the
  following conditions are considered illegal state combinations, in
  addition to those mentioned in “Canonicalization and Consistency Checks”:
      • Any MBZ bit of nCR3 is set.
      • Any G_PAT.PA field has an unsupported type encoding or any
        reserved field in G_PAT has a nonzero value.

Add the consistency check for nCR3 being a legal GPA with no MBZ bits
set.  Note, the G_PAT.PA check is being handled separately[*].

Link: https://lore.kernel.org/kvm/20260205214326.1029278-3-jmattson@google.com [*]
Fixes: 4b16184c1cca ("KVM: SVM: Initialize Nested Nested MMU context on VMRUN")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260303003421.2185681-16-yosry@kernel.org
[sean: capture everything in CC(), massage changelog formatting]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -271,6 +271,10 @@ static bool __nested_vmcb_check_controls
 	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) && !npt_enabled))
 		return false;
 
+	if (CC((control->nested_ctl & SVM_NESTED_CTL_NP_ENABLE) &&
+	       !kvm_vcpu_is_legal_gpa(vcpu, control->nested_cr3)))
+		return false;
+
 	if (CC(!nested_svm_check_bitmap_pa(vcpu, control->msrpm_base_pa,
 					   MSRPM_SIZE)))
 		return false;



