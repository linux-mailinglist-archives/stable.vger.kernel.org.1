Return-Path: <stable+bounces-203638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D058CE71C2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16EA5301634C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174273246E0;
	Mon, 29 Dec 2025 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wHLroS8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B415324B10
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019407; cv=none; b=IVDScFF7txpMDyqQLr9o7M2rw8G60Xn8OcIlaW9FVzOQDS3nsmTWNr9xC3hYE2B1Ehq7DzRa7IlpsHEgz3CVd8Z88GvsyZnlS2Z1OSUZlBQRAEpb+d0WMicGMeBBHWpaXbaR1l0tNfKzshLvQZxMYQMyUBQKRg1VxH7oyr0TsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019407; c=relaxed/simple;
	bh=+xmpA5TfNUm0JFndRRmTmwkcpZYexVyGDhd+0hV8hXo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IjLqiPI0JC5BdEXNtRCORhv5RgpPO7eKMehEdhioLLJXEleg5aiTmCJ/ySwMdTExjaZC7tT4AzVRm/UeaQKxmFK4yV8HaeTyBQd03+gLn6avV2a1LwR8csg04UUQmFJSEig3jPs8oPB9uaHeJHUYZJ6tanzH2s1LfMVbuompl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wHLroS8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FA3C4CEF7;
	Mon, 29 Dec 2025 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767019407;
	bh=+xmpA5TfNUm0JFndRRmTmwkcpZYexVyGDhd+0hV8hXo=;
	h=Subject:To:Cc:From:Date:From;
	b=wHLroS8QuJFX88H6O730VECS1zgBRB8f+xGWztRgrECx3KcDkxLKOeyzw+2Bc5c9G
	 p2XhhzS8EF/TzNJm5yrZJStpxDaIyKuY0d31bgozelQbEKaP4gEXC3/bj1AUhhKUWw
	 aw1iWzhS5izVQ7DqCDzwKGYv0yEsKPbGplPXSOvU=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Immediately refresh APICv controls as needed on" failed to apply to 6.6-stable tree
To: dongli.zhang@oracle.com,chao.gao@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:42:17 +0100
Message-ID: <2025122917-cadet-worrier-23c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29763138830916f46daaa50e83e7f4f907a3236b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122917-cadet-worrier-23c0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


