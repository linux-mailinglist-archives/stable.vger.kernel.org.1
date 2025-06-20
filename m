Return-Path: <stable+bounces-155030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F0AE1702
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6B19E3DF1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7227FD4F;
	Fri, 20 Jun 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W9VW57G+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F4027FB12
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410413; cv=none; b=LE/7iRbVPXiXHLTxGYed7H1OHQOB3IWHerU2lbHDNXApI19M2w+hACrPyCR0uDKvA2Z3rKovawUNE/2I6rjblQYB9XJ/SKh7t4YaViAUmsWpSYomWAsaLsfRxJWJzU4KoVq/rLIq6jLIkVDLzs7ZRfYsIFlpSAAtIi8KEQ/wV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410413; c=relaxed/simple;
	bh=y2bXYxex9E4/EJkIKhnPbnK1wyWDTL/ogb6f6Sol3aM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=unU8SG9r/5d4hJG2EcKv8DbwFvb1ygZdRM1+wjgklOTC+fhNIXhVLXQFOAo6G9zP8Vx7G8dI//+MGft4gY0J4FrOqpsCuzBzVzx/ssujpHRntsgx25iYM30SzZBvzaSbChORRvQxPXZW6Eb9hmhTgIQci+doNc87tU9T1JGeFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W9VW57G+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059BBC4CEE3;
	Fri, 20 Jun 2025 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410413;
	bh=y2bXYxex9E4/EJkIKhnPbnK1wyWDTL/ogb6f6Sol3aM=;
	h=Subject:To:Cc:From:Date:From;
	b=W9VW57G+9C9CfpSJmlIS51ONJocwgYU/BN/UAceXc0DtO7Z6W4AGu4C3xrJfP3/NY
	 FrCBNa0MJn1YB1mg9Sl8tOsYAOqqPRTKtK19lmp2CzOnCpHo3fXJ8c1PbUSESu2Q8r
	 sHcxzZdM2Ju0hSG0jcQbQjOA/V49+jdLOv7VYOYM=
Subject: FAILED: patch "[PATCH] KVM: VMX: Flush shadow VMCS on emergency reboot" failed to apply to 5.4-stable tree
To: chao.gao@intel.com,kai.huang@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:06:40 +0200
Message-ID: <2025062040-affected-disregard-01ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a0ee1d5faff135e28810f29e0f06328c66f89852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062040-affected-disregard-01ae@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0ee1d5faff135e28810f29e0f06328c66f89852 Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Mon, 24 Mar 2025 22:08:48 +0800
Subject: [PATCH] KVM: VMX: Flush shadow VMCS on emergency reboot

Ensure the shadow VMCS cache is evicted during an emergency reboot to
prevent potential memory corruption if the cache is evicted after reboot.

This issue was identified through code inspection, as __loaded_vmcs_clear()
flushes both the normal VMCS and the shadow VMCS.

Avoid checking the "launched" state during an emergency reboot, unlike the
behavior in __loaded_vmcs_clear(). This is important because reboot NMIs
can interfere with operations like copy_shadow_to_vmcs12(), where shadow
VMCSes are loaded directly using VMPTRLD. In such cases, if NMIs occur
right after the VMCS load, the shadow VMCSes will be active but the
"launched" state may not be set.

Fixes: 16f5b9034b69 ("KVM: nVMX: Copy processor-specific shadow-vmcs to VMCS12")
Cc: stable@vger.kernel.org
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/r/20250324140849.2099723-1-chao.gao@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ef2d7208dd20..848c4963bdb8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -770,8 +770,11 @@ void vmx_emergency_disable_virtualization_cpu(void)
 		return;
 
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
-			    loaded_vmcss_on_cpu_link)
+			    loaded_vmcss_on_cpu_link) {
 		vmcs_clear(v->vmcs);
+		if (v->shadow_vmcs)
+			vmcs_clear(v->shadow_vmcs);
+	}
 
 	kvm_cpu_vmxoff();
 }


