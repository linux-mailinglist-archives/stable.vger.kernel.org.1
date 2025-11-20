Return-Path: <stable+bounces-195290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF896C752E5
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3235A365B7E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AFF231827;
	Thu, 20 Nov 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXJLD5RH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191712D0C62
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653879; cv=none; b=jkvP4XHzRB9d6REHyDErlOTn6D22om88euhFq8TVDjpVm7zsCP6rOjDjLLdWDjRFb2QbqgV/6zcbB8LnW4+KOuHyqR79Kh3j2bgERZ8NIWjOAH28W30CYK/g0FzLsmpkzoOft9ryV/mMid9cKAsFvZIXwfviNR/zWNj8HqdamKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653879; c=relaxed/simple;
	bh=SLS9t/1UNCOYEojdQlvHM6/oaHPdTDhPP3qY3K7DvbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Znq411EcP/xeJK2XQsMtPl33q4lpS2+FDSYhld7fMjW+/1+c9WrfhvtKdD0WQanDOq0IO3WLltAUVXVM75QC3TasUjWdqjkUVuwOSFdr5GMWpjiYi4cJTDYgufXIsVQjaDM9dfIqEP0MejynfacEchnwz+XRybO56RybMN0GGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXJLD5RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F3CC4CEF1;
	Thu, 20 Nov 2025 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763653878;
	bh=SLS9t/1UNCOYEojdQlvHM6/oaHPdTDhPP3qY3K7DvbI=;
	h=Subject:To:Cc:From:Date:From;
	b=SXJLD5RH1HYmmOT+HaYMbV7BdtEPlDtzs9ZELRXosyd+682AmGUA4s1UBKfCC/Zc/
	 dbuChqAdTgepET7W/flxbCxRKsdkm+UKARYe6GlvENjV38A17Vn3wKiZNNZ20ZvOky
	 dD7gm4F3f1wyVrk+MJwwgu7oQC9faQRgaJvW+2bQ=
Subject: FAILED: patch "[PATCH] KVM: VMX: Fix check for valid GVA on an EPT violation" failed to apply to 6.12-stable tree
To: Sukrit.Bhatnagar@sony.com,seanjc@google.com,xiaoyao.li@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:51:16 +0100
Message-ID: <2025112016-chatter-plutonium-baf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d0164c161923ac303bd843e04ebe95cfd03c6e19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112016-chatter-plutonium-baf8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0164c161923ac303bd843e04ebe95cfd03c6e19 Mon Sep 17 00:00:00 2001
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Date: Thu, 6 Nov 2025 14:28:51 +0900
Subject: [PATCH] KVM: VMX: Fix check for valid GVA on an EPT violation

On an EPT violation, bit 7 of the exit qualification is set if the
guest linear-address is valid. The derived page fault error code
should not be checked for this bit.

Fixes: f3009482512e ("KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is valid")
Cc: stable@vger.kernel.org
Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20251106052853.3071088-1-Sukrit.Bhatnagar@sony.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index bc5ece76533a..412d0829d7a2 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -98,7 +98,7 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	error_code |= (exit_qualification & EPT_VIOLATION_PROT_MASK)
 		      ? PFERR_PRESENT_MASK : 0;
 
-	if (error_code & EPT_VIOLATION_GVA_IS_VALID)
+	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 


