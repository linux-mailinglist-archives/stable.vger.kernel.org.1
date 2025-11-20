Return-Path: <stable+bounces-195377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB036C75DDF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE94E0312
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA17030CDBA;
	Thu, 20 Nov 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6cMMqiH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922B2D0C62
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662019; cv=none; b=ddoPlxz7asFDSG39d4yY9dFCmkqDe2tvct42+lD1jpNwDGNkIh1IqQGd0D+PhvMkK1x78Sy43fquiHjeeDEGbwpttsnmkzHRJg1hTZJPxUZmQY7MrGz42lWQ2S//QQcWYWhlX1BJmrFih1gEbe5WjlfEluUifQRjfKylb7U2sFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662019; c=relaxed/simple;
	bh=sbxQMkJIOSWBcl6/w91i3kpPeiPOT3wVBu8fiDcAp4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDy6EEL6edYxa8uPvWHBvZD1KE4Iz+I+cTRldZsuZjJndPo53J+u7Pt95x/zGaVSg41t2i6RFjXpAmQn9lnQf3xdiZdbtxxMFWo8COcflPfriNuiDtaXPE/d7XXK3IPn1UatR+Fw0VVSGrjATnexiWLlQdEMHhl6ubsbLVBb3z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6cMMqiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBEBC4CEF1;
	Thu, 20 Nov 2025 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763662019;
	bh=sbxQMkJIOSWBcl6/w91i3kpPeiPOT3wVBu8fiDcAp4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6cMMqiHHT1l+Ykak6eN5Ce7rqi/a5ZiIHIgmUSTTcgz1P9GBpSvGZnNyWtIGy/nI
	 gdTjfNQut6yagIXnBxb/51k9TQXrcmTel/IdBgOieTLAgRQwJOQNwxdLWoYxpyOLG8
	 Mrb/b0yBOW5vNen8wGgEFSYfbpXno70KBvbr0NpdrLFKLcM2/8ljn8PWvPvr5DtNZy
	 jfx20LdlYp/4crIug3AS3IpHf6uJq8RTPaCBPSh1a1pSRPtRq5johtnN+02XIOfLLQ
	 Fw0XJMa2uW0qCTrKVybdM5HiB5H1xy34Xdrss5QQU3ZrbBJ+LKTHJT6QmyyT7M2M6f
	 xXvanm1U+IC/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Matteo Rizzo <matteorizzo@google.com>,
	evn@google.com,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated
Date: Thu, 20 Nov 2025 13:06:55 -0500
Message-ID: <20251120180655.1918545-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112036-abdominal-envelope-7ca0@gregkh>
References: <2025112036-abdominal-envelope-7ca0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry.ahmed@linux.dev>

[ Upstream commit dc55b3c3f61246e483e50c85d8d5366f9567e188 ]

The APM lists the DbgCtlMsr field as being tracked by the VMCB_LBR clean
bit.  Always clear the bit when MSR_IA32_DEBUGCTLMSR is updated.

The history is complicated, it was correctly cleared for L1 before
commit 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when
L2 is running").  At that point svm_set_msr() started to rely on
svm_update_lbrv() to clear the bit, but when nested virtualization
is enabled the latter does not always clear it even if MSR_IA32_DEBUGCTLMSR
changed. Go back to clearing it directly in svm_set_msr().

Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Reported-by: evn@google.com
Co-developed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251108004524.1600006-2-yosry.ahmed@linux.dev
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[ Open coded svm_get_lbr_vmcb() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f56dcbbbf7341..00fb1c18e23a8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3053,11 +3053,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
-		if (svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK)
+		if (svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) {
+			if (svm->vmcb->save.dbgctl == data)
+				break;
 			svm->vmcb->save.dbgctl = data;
-		else
+		} else {
+			if (svm->vmcb01.ptr->save.dbgctl == data)
+				break;
 			svm->vmcb01.ptr->save.dbgctl = data;
+		}
 
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		svm_update_lbrv(vcpu);
 
 		break;
-- 
2.51.0


