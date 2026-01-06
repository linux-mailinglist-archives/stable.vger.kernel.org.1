Return-Path: <stable+bounces-205348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3CACFA5C9
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EE653012ABA
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A903348865;
	Tue,  6 Jan 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGmCkLLS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973935294A;
	Tue,  6 Jan 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720394; cv=none; b=QqN2HyEMZwGhYbmRJhEjwafDSbLmZby/0vZKWBVMZ2rqQBhuynoq4hhsfw/yyJZp8hQ9xhC14ixxV7kIyDv0cpQUlROMvodvpeoM4eFF4iT8S1UcyPZpzejK9Xi5cMp2wn853UDNGOyPO78xgmV84kFPfGYYvkVuzNBKhcFQcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720394; c=relaxed/simple;
	bh=1Zi0OjMsRjlfm6Xq6uZQMQmSVy8pLPL/ZH6AqabzAg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7kt6WSldxtfqJUrMw1s7G8NHnCvFFAq5ah+pfVD5raGkqaNGVxOcMmxf8YIVdNmnm2ePku2LobqlaChRMHPwxsBEzX+YyllujazVB4cXJNxBmvqfk9Pz4hFzzw5bPb7StRE6uwy0afpeUTGD4dm+B5rg7fkg+2yAmsB5frtJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGmCkLLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E875C116C6;
	Tue,  6 Jan 2026 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767720393;
	bh=1Zi0OjMsRjlfm6Xq6uZQMQmSVy8pLPL/ZH6AqabzAg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGmCkLLSXzhNiO21JgOb2HrjeiMPdt8LMyxGAjTZGbfBVVP9lEku9Dn9KcmBMV84u
	 mykYzVnmUFLqWPVHsKGi9d69eRSJ63b5CE1oY2tt8tFqsrQPiZdpl81jo4nWviy7NF
	 byme8f+m1oWiW0CvVVVKO4Yuwg+N8utGDBBR5L4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12 224/567] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
Date: Tue,  6 Jan 2026 18:00:06 +0100
Message-ID: <20260106170459.600319995@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -546,6 +546,7 @@ static void nested_vmcb02_prepare_save(s
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
 	nested_vmcb02_compute_g_pat(svm);
+	vmcb_mark_dirty(vmcb02, VMCB_NPT);
 
 	/* Load the nested guest state */
 	if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {



