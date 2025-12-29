Return-Path: <stable+bounces-204033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7915DCE7837
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABF34301F7F6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBE332EB4;
	Mon, 29 Dec 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="srISrcZP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F7332EAF;
	Mon, 29 Dec 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025859; cv=none; b=fhRVDO+klIkREW1rThiagbckYmLy1iWWlN81nRs9DVD2nZ0WxifgYWy2nOwpbRbawXBXwR1kblRTAK4NHdzu44jM3opl+W0n8n9VGnCm9A6N7Kwupb0MXvQRWrc9HdCqPcbZ4g5l0RX3zSL5ZYjJZVd8hFthDSNFULrvW2NBt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025859; c=relaxed/simple;
	bh=9yWTxMBMPRFnan4JmKrHp/v8JKwlt27P37WYX3KwEo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btHN3Pu5YLIX6YsnFxI2bFF1mnz+sTvuxf37E/dNRX4+JLxFOISJL52tY0O+cKJCrS7gczb8sgCSwE0XTaLsPI4NmRU9tzWSdrP7LPU8a2SmA2r9lQMfqq/bDmUyljNv5aKHg+jGU30L4IxRb6/IMnHNtQZw9SemFMFl2VBZGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=srISrcZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF5C19421;
	Mon, 29 Dec 2025 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025859;
	bh=9yWTxMBMPRFnan4JmKrHp/v8JKwlt27P37WYX3KwEo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srISrcZPyy+IB+Duq4PUAoWpMDVO4OHfdNifTRaqPfpZSSrHo9K7Z5GbZHoazKk+I
	 Ps4GOdjijzLyJIVf7oy4d6Po7mMQZyc4OftmV0cr3h1xRbO8xemZnC0/rj8rY8L2nv
	 OXHFc1+RSHqWnOn8cPXUYiObv9nqkfBREB/JpGj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matteo Rizzo <matteorizzo@google.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.18 345/430] KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW emulation
Date: Mon, 29 Dec 2025 17:12:27 +0100
Message-ID: <20251229160737.024525269@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosry.ahmed@linux.dev>

commit 5674a76db0213f9db1e4d08e847ff649b46889c0 upstream.

When emulating L2 instructions, svm_check_intercept() checks whether a
write to CR0 should trigger a synthesized #VMEXIT with
SVM_EXIT_CR0_SEL_WRITE. For MOV-to-CR0, SVM_EXIT_CR0_SEL_WRITE is only
triggered if any bit other than CR0.MP and CR0.TS is updated. However,
according to the APM (24593—Rev.  3.42—March 2024, Table 15-7):

  The LMSW instruction treats the selective CR0-write
  intercept as a non-selective intercept (i.e., it intercepts
  regardless of the value being written).

Skip checking the changed bits for x86_intercept_lmsw and always inject
SVM_EXIT_CR0_SEL_WRITE.

Fixes: cfec82cb7d31 ("KVM: SVM: Add intercept check for emulated cr accesses")
Cc: stable@vger.kernel.org
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Link: https://patch.msgid.link/20251024192918.3191141-3-yosry.ahmed@linux.dev
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/svm.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4553,20 +4553,20 @@ static int svm_check_intercept(struct kv
 		if (info->intercept == x86_intercept_clts)
 			break;
 
-		cr0 = vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
-		val = info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
-
+		/* LMSW always triggers INTERCEPT_SELECTIVE_CR0 */
 		if (info->intercept == x86_intercept_lmsw) {
-			cr0 &= 0xfUL;
-			val &= 0xfUL;
-			/* lmsw can't clear PE - catch this here */
-			if (cr0 & X86_CR0_PE)
-				val |= X86_CR0_PE;
+			icpt_info.exit_code = SVM_EXIT_CR0_SEL_WRITE;
+			break;
 		}
 
+		/*
+		 * MOV-to-CR0 only triggers INTERCEPT_SELECTIVE_CR0 if any bit
+		 * other than SVM_CR0_SELECTIVE_MASK is changed.
+		 */
+		cr0 = vcpu->arch.cr0 & ~SVM_CR0_SELECTIVE_MASK;
+		val = info->src_val  & ~SVM_CR0_SELECTIVE_MASK;
 		if (cr0 ^ val)
 			icpt_info.exit_code = SVM_EXIT_CR0_SEL_WRITE;
-
 		break;
 	}
 	case SVM_EXIT_READ_DR0:



