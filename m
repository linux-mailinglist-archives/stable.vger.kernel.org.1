Return-Path: <stable+bounces-155028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D60AE16FF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7824A5F06
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302F27FD55;
	Fri, 20 Jun 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSPpQD2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD527FD49
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410402; cv=none; b=OW24IG8JG9zNl2FYcxENdceoUQkbgG7jw2bl7jy0sCGy4ueNNNffH6gsFCKXBBjRc4NH/8oGe+WjnKCeVj4FEuDBdhFzCOMfBdf26A+7lWYpxLc0TZk9cww83YVZPRCONA089009BwnbnF2LWhEHqWOfz++9DEopQTaGa7tt3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410402; c=relaxed/simple;
	bh=8nOsR9Wznn6K5E990jx0iKGyYTWovMD64ypt8UeWEr4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tkO9PoXAMSP+dd1mLXS6qOjN3/y3T7srype/9NJZ3QQ9xamw1CeTMLSfayjRjOiy/9Hy5ybcBHje3BAxyi0NH/n4xp0JrSwO0u0U9OAvUNzVjH0ihJrh+U1ifxiG91WXRGgKH6x84oGvII353pH65pj7CTFRYA+7MppGj/GINIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSPpQD2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B83EC4CEE3;
	Fri, 20 Jun 2025 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410402;
	bh=8nOsR9Wznn6K5E990jx0iKGyYTWovMD64ypt8UeWEr4=;
	h=Subject:To:Cc:From:Date:From;
	b=XSPpQD2gugcK1MuXNb0uRWOq1bx1FOuVR05/iEwDMnof9bHCzHu/B/mZu2exBRp5k
	 6vKquYr+3lAh5l7ELOC6oLPIISieb58ofYN91D5CwD5ZvYj7qFJwA9s4+4ogcNtA3S
	 sbKc7WanRIX5BA6lPw98fZTzizfRMxfOD9s030AU=
Subject: FAILED: patch "[PATCH] KVM: VMX: Flush shadow VMCS on emergency reboot" failed to apply to 6.1-stable tree
To: chao.gao@intel.com,kai.huang@intel.com,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:06:34 +0200
Message-ID: <2025062034-chastise-wrecking-9a12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a0ee1d5faff135e28810f29e0f06328c66f89852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062034-chastise-wrecking-9a12@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


