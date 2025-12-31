Return-Path: <stable+bounces-204358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A381CEC1A0
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F240300CB86
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4326CE04;
	Wed, 31 Dec 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCRUKHju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFF269B01
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191959; cv=none; b=r9FO+sjJb/9wzypPP9Kp9nGEXJkWMo8WOHtATsjKpL4J8es6hs+WMyV85C+2au7EPQ5XyxxTSWX5TiaGxJ3/dNHAENKC4KDWEAEHXdu1GQpYm569vhEx1h01xIs0HgNfQ5Pco3rT2R75hT/Fhwy668hUEUyhoP3TOXYO/vay3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191959; c=relaxed/simple;
	bh=hE2BWwW6nn+2XSgLbnoOHJandX/huV4Sgnkjxw00fj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEpp3EcW5KvodiFdxP82/fP14xEPAv67DLastBkho6I/GvMr99l/ufsjtPzJv9t5wwinsnEq4B2DO5ho8Z7Cl/1tPiGSzrc+OQFa9JomIIaCpkA2HEPzurjXNAtc7aAoBq2M3ScticSeP6s87cauAglRUn9bjyjIjaWcyusmqfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCRUKHju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE51BC16AAE;
	Wed, 31 Dec 2025 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191959;
	bh=hE2BWwW6nn+2XSgLbnoOHJandX/huV4Sgnkjxw00fj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCRUKHju2v+xbNJPzZYHVrpewz2ppGf4C8+ZiG7sVzTnf501EDAURRFJQKJBl8cIu
	 JycnaiG0yhRBUd+UWFr5vapF1dWO/Ne9xEpWOZKJ4cZE6/h0RLw4bmOPVW87JmevI/
	 D2KK30PbU1qLQ6/KPJ90HP6YftIAD9nYdrVJ+NlCDCwSk5bR51GHr4T4L1LR6YDyip
	 q3TvVeWcwgUJQ4HVGvdg60+bU0Svsvxn4e+TszTIc/EzgOrGuVjaC/DeEY5Bt0ktmO
	 QJ0z0z/wG48kcoJBB6ntIcOEIu+5XInC3lJPS9fBNHpT0NupP+MbCo7XoVZYbK48ca
	 0zA16wetT8dfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
Date: Wed, 31 Dec 2025 09:39:17 -0500
Message-ID: <20251231143917.3047237-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122929-riveter-outreach-a5e9@gregkh>
References: <2025122929-riveter-outreach-a5e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Mattson <jmattson@google.com>

[ Upstream commit 7c8b465a1c91f674655ea9cec5083744ec5f796a ]

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
[ adapted vmcb02 local variable to svm->vmcb direct access pattern ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c24d7860bd53..5f9f14eb61c4 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -456,6 +456,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
 	bool new_vmcb12 = false;
 
 	nested_vmcb02_compute_g_pat(svm);
+	vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
 
 	/* Load the nested guest state */
 	if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {
-- 
2.51.0


