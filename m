Return-Path: <stable+bounces-243741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIgnBbGw+GkdzAIAu9opvQ
	(envelope-from <stable+bounces-243741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:44:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 129994BFF2A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3169C30AB8C4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84803E120C;
	Mon,  4 May 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYRH1IOb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F03E1D06;
	Mon,  4 May 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904659; cv=none; b=B7NTyB9zqXnME0EznZOhJ6riCqNL1FfKZH2klwrQMhYw3Gr+3qdaujm/s/B8+MqGt5s8nGLA3pD9x0rcyT+IHxfS1cfoOkKhIHcu/+S5gMxaNXiQz16qVKXnoOJoIQYG/53XU5ID+LqW2uFsM10BRLQkfL7p/WbpfeO1a2t4gMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904659; c=relaxed/simple;
	bh=hIl+NbhoEmsAvH4dgWbnJc+jtWmZkwn+lP1Y4vx7GM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RB8QioSA2fsdcDlgokKfuB/8jlsIxFUGpJHZVBYfa0uSUOIcUhIo8ba+ccu8UvVN4Qsb5AgiTTNDxOe+u3fY9xlNiQM51lNxoXzGh77hmCPMI1jHaRWED/K4QPVwJisbzobUmxQR5OktGglwKAw1qksoE+Yxje8QvOrFmT4TVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYRH1IOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C342FC2BCF5;
	Mon,  4 May 2026 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904659;
	bh=hIl+NbhoEmsAvH4dgWbnJc+jtWmZkwn+lP1Y4vx7GM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYRH1IOb3UaZpkD6bfbKu8TWEaXhm2JtYNFcaw3dHvNtdMr8q2GlEPdrWYmtj4+N7
	 zBz8Fb2ffyQyW8+wfchWTkGnNlnVRar5ANwBCTFAmx/9NE5Z8Pou/djW/WunCYOfcs
	 xKPaeIn9p3dHeyxaLWooGM5j4/rADLAyf0qPWj5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12 124/215] KVM: nSVM: Ensure AVIC is inhibited when restoring a vCPU to guest mode
Date: Mon,  4 May 2026 15:52:23 +0200
Message-ID: <20260504135134.680930949@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 129994BFF2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243741-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry@kernel.org>

commit 24f7d36b824b65cf1a2db3db478059187b2a37b0 upstream.

On nested VMRUN, KVM ensures AVIC is inhibited by requesting
KVM_REQ_APICV_UPDATE, triggering a check of inhibit reasons, finding
APICV_INHIBIT_REASON_NESTED, and disabling AVIC.

However, when KVM_SET_NESTED_STATE is performed on a vCPU not in guest
mode with AVIC enabled, KVM_REQ_APICV_UPDATE is not requested, and AVIC
is not inhibited.

Request KVM_REQ_APICV_UPDATE in the KVM_SET_NESTED_STATE path if AVIC is
active, similar to the nested VMRUN path.

Fixes: f44509f849fe ("KVM: x86: SVM: allow AVIC to co-exist with a nested guest running")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260224225017.3303870-1-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1776,6 +1776,9 @@ static int svm_set_nested_state(struct k
 
 	svm->nested.force_msr_bitmap_recalc = true;
 
+	if (kvm_vcpu_apicv_active(vcpu))
+		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+
 	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 	ret = 0;
 out_free:



