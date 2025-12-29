Return-Path: <stable+bounces-204055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085FCE78F7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 716763006E38
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58B33344C;
	Mon, 29 Dec 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HumBFlIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E16334690;
	Mon, 29 Dec 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025922; cv=none; b=sca9C4UNkpljT0soTTxZypyxaWchMeIwyqb5b1+csakVZfHOaiBGneueP98HN3GxmK0f20tLwM3qu09DYKR0c47F43MXbi4pLSOouz0vAveKwGiuwXOn8pOBkP3/4qsr1kWQ+P1/7dIYZuYUecuR3BBe5LeLVHnFFIOAk4YTxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025922; c=relaxed/simple;
	bh=OJpSrXIlBJV+0LiDoXBdEqjqg2NMCCsINRgkYaCcNOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdfDlY1bvpHBILx1IRBB3RMUqP52tmn4OkC92VEj/gv4JlCBJZGrTx9iuSSL1Xru1JGrTylRYvue1aHYBwwspCriQo6T/7IkSbTewc+FpidON6i9bVClCnAY33YYU/ppm6P9c+KT62OoRUAdmC4PfNFzRYLCaiMtMHipeloFQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HumBFlIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034EC4CEF7;
	Mon, 29 Dec 2025 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025922;
	bh=OJpSrXIlBJV+0LiDoXBdEqjqg2NMCCsINRgkYaCcNOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HumBFlIkaC3WOp9irK7sb2RZgBXVa6pYq2Unxex8IKPYaiUOwxWCGxxQgcJ/tMdyk
	 sOFbFhs4UiKEF+BYPyUz4YCR9jlV6AJJZ4G4zGIvBwD5FEpbT/7124g3zTn8fhQM0l
	 RU+dSiPqq86u3rjbcTfxF0sFa7wung35Fs6sGIfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.18 343/430] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
Date: Mon, 29 Dec 2025 17:12:25 +0100
Message-ID: <20251229160736.951771689@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 7c8b465a1c91f674655ea9cec5083744ec5f796a upstream.

Mark the VMCB_NPT bit as dirty in nested_vmcb02_prepare_save()
on every nested VMRUN.

If L1 changes the PAT MSR between two VMRUN instructions on the same
L1 vCPU, the g_pat field in the associated vmcb02 will change, and the
VMCB_NPT clean bit should be cleared.

Fixes: 4bb170a5430b ("KVM: nSVM: do not mark all VMCB02 fields dirty on nested vmexit")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/r/20250922162935.621409-3-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/nested.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -613,6 +613,7 @@ static void nested_vmcb02_prepare_save(s
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	nested_vmcb02_compute_g_pat(svm);
+	vmcb_mark_dirty(vmcb02, VMCB_NPT);
 
 	/* Load the nested guest state */
 	if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {



