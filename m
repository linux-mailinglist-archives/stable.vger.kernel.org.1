Return-Path: <stable+bounces-203614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06732CE710E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACE5A300D66D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90F322745;
	Mon, 29 Dec 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="181gutbo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D8931ED8E
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018519; cv=none; b=qzgA26rtNOzF+oucm/4OQA3EEHkAevM+XiJHoaE1ocW304qL2pQzuI/z9HbG9wcFz54ezgKH2Ta1q4AR1QdyC/KVmBHMP1FPu84HN+Y0jDlAo8gFqkuM3inz9RVkgjNHrMZ6myqbCSuvGiKfPnbLPBcihSIirnxUZTBkiDTrPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018519; c=relaxed/simple;
	bh=x3S2NLaUfMipJnuXvlvQLPotT7Q4AwBR2+FBjLu+0G0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NMDb/BTC0TtU6TWaUVaTou/DqObBelzPXZsDOeiJE2AxVZeDCT84XYHT336COGpwDQ8zKzHomMAYpmDAP7UVPAk6nrAVLTP1M88lLGYZNI/aLnNW8vsi/ADCW/tED0Mb5A/6UoIqZdQc5jt/xy9UUWDu6l8oM0Vjs4GN9K+7jhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=181gutbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF5CC4CEF7;
	Mon, 29 Dec 2025 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018518;
	bh=x3S2NLaUfMipJnuXvlvQLPotT7Q4AwBR2+FBjLu+0G0=;
	h=Subject:To:Cc:From:Date:From;
	b=181gutboCdS1c/7rS1W5vdzVfIdxQdsrSONoWsCtOKaNTxj7JfkVtGKuYY7NYSF+1
	 HC04M2MydIC+DXoU6xYxro0Bi5+k8DBqRGzGI6RQD5Fd0unK0zkylLvAH2NDY2x4/W
	 YLVHjQpGfMr+RQGzK2ZmMFZKWbA/CV3bVFJFt5p4=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Immediately refresh APICv controls as needed on" failed to apply to 5.15-stable tree
To: dongli.zhang@oracle.com,chao.gao@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:28:27 +0100
Message-ID: <2025122927-delegate-composed-5765@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 29763138830916f46daaa50e83e7f4f907a3236b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122927-delegate-composed-5765@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29763138830916f46daaa50e83e7f4f907a3236b Mon Sep 17 00:00:00 2001
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Fri, 5 Dec 2025 15:19:05 -0800
Subject: [PATCH] KVM: nVMX: Immediately refresh APICv controls as needed on
 nested VM-Exit

If an APICv status updated was pended while L2 was active, immediately
refresh vmcs01's controls instead of pending KVM_REQ_APICV_UPDATE as
kvm_vcpu_update_apicv() only calls into vendor code if a change is
necessary.

E.g. if APICv is inhibited, and then activated while L2 is running:

  kvm_vcpu_update_apicv()
  |
  -> __kvm_vcpu_update_apicv()
     |
     -> apic->apicv_active = true
      |
      -> vmx_refresh_apicv_exec_ctrl()
         |
         -> vmx->nested.update_vmcs01_apicv_status = true
          |
          -> return

Then L2 exits to L1:

  __nested_vmx_vmexit()
  |
  -> kvm_make_request(KVM_REQ_APICV_UPDATE)

  vcpu_enter_guest(): KVM_REQ_APICV_UPDATE
  -> kvm_vcpu_update_apicv()
     |
     -> __kvm_vcpu_update_apicv()
        |
        -> return // because if (apic->apicv_active == activate)

Reported-by: Chao Gao <chao.gao@intel.com>
Closes: https://lore.kernel.org/all/aQ2jmnN8wUYVEawF@intel.com
Fixes: 7c69661e225c ("KVM: nVMX: Defer APICv updates while L2 is active until L1 is active")
Cc: stable@vger.kernel.org
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
[sean: write changelog]
Link: https://patch.msgid.link/20251205231913.441872-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bcea087b642f..1725c6a94f99 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -19,6 +19,7 @@
 #include "trace.h"
 #include "vmx.h"
 #include "smm.h"
+#include "x86_ops.h"
 
 static bool __read_mostly enable_shadow_vmcs = 1;
 module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
@@ -5216,7 +5217,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 
 	if (vmx->nested.update_vmcs01_apicv_status) {
 		vmx->nested.update_vmcs01_apicv_status = false;
-		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+		vmx_refresh_apicv_exec_ctrl(vcpu);
 	}
 
 	if (vmx->nested.update_vmcs01_hwapic_isr) {


