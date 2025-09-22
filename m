Return-Path: <stable+bounces-180859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F139B8E9DE
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC454179FB1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA523CB;
	Mon, 22 Sep 2025 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA5Wf6Ju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CEA59
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758499662; cv=none; b=sJ/bPzFEeD/6tvnznNPQM2OotcBl9MTSaucZlCdQyi7qz8P5We14I7Dk5MV4MhLlXPSromobjdC3x9TL36N7fAgTcAd7B7xbObL8+0k+SbTH5taQH+9ZOIyfJkjl2md3Fy5zfyQCPx312B3nmMMEn9MtCV56ec+2cqDSUAdVolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758499662; c=relaxed/simple;
	bh=97aTOqeGmswsU+xVa8IyB7+MPt3lMeVeSoz1rjkRCP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrcr1u5UTemFSS52/6DKxAXqzzLeWCAUjoXRXkYD+Vzrn2GC7yOhiIRmJxENuUF3YYMIFYiau9HnTt8bs+uwITdI4TdheK57+ANnF6KkdQ6wliArFo9Yv0ABs0L8kvx40zelW1Mgmx5lvFjZDytZcChrOGmRop1TaaFqaiLlRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA5Wf6Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2310EC4CEE7;
	Mon, 22 Sep 2025 00:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758499661;
	bh=97aTOqeGmswsU+xVa8IyB7+MPt3lMeVeSoz1rjkRCP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pA5Wf6JuvD/SI72MVvk/uuE1IUv/YC+2ax30Te8xP0ZFDTVJ1lPVI5zjdzOr/yHt6
	 gZR3BCd/NhBFghO0F9xdtpVYSfUHF2TBas1eiH1/czomDDbXqpwWdiPDI/zbRg/9uD
	 uWidLzkws9k/V58dLTLivms6MglE/MFgqwbwSkfCSP2C91AtV0v8HPieJcimY3SCGu
	 Qc01+3F+4Bl2oKrekq/qqPke6BiViUmyTU8a73WVMS/6nGe1f8PO2Od7wcgt4i259G
	 ZwToeLZceoKDgqJdZUxkkik6mfDWY86g/BG0Rv18eYJI2cShVbPoJSFpxqXg3TkPSx
	 9DqLqVAt502iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	"Naveen N Rao (AMD)" <naveen@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active
Date: Sun, 21 Sep 2025 20:07:39 -0400
Message-ID: <20250922000739.3096059-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092122-popper-small-d970@gregkh>
References: <2025092122-popper-small-d970@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

[ Upstream commit d02e48830e3fce9701265f6c5a58d9bdaf906a76 ]

Commit 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
inhibited pre-VMRUN sync of TPR from LAPIC into VMCB::V_TPR in
sync_lapic_to_cr8() when AVIC is active.

AVIC does automatically sync between these two fields, however it does
so only on explicit guest writes to one of these fields, not on a bare
VMRUN.

This meant that when AVIC is enabled host changes to TPR in the LAPIC
state might not get automatically copied into the V_TPR field of VMCB.

This is especially true when it is the userspace setting LAPIC state via
KVM_SET_LAPIC ioctl() since userspace does not have access to the guest
VMCB.

Practice shows that it is the V_TPR that is actually used by the AVIC to
decide whether to issue pending interrupts to the CPU (not TPR in TASKPRI),
so any leftover value in V_TPR will cause serious interrupt delivery issues
in the guest when AVIC is enabled.

Fix this issue by doing pre-VMRUN TPR sync from LAPIC into VMCB::V_TPR
even when AVIC is enabled.

Fixes: 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/c231be64280b1461e854e1ce3595d70cde3a2e9d.1756139678.git.maciej.szmigiero@oracle.com
[sean: tag for stable@]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index e9444e202c334..cb3c86014adbd 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5580,8 +5580,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 cr8;
 
-	if (svm_nested_virtualize_tpr(vcpu) ||
-	    kvm_vcpu_apicv_active(vcpu))
+	if (svm_nested_virtualize_tpr(vcpu))
 		return;
 
 	cr8 = kvm_get_cr8(vcpu);
-- 
2.51.0


