Return-Path: <stable+bounces-195463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A472DC77794
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ECD7362392
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 05:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFF824BD;
	Fri, 21 Nov 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EUS3K6sp"
X-Original-To: stable@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B452EFD90
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703944; cv=none; b=AC+7Vg/zru2W1OO+zuQFX2ofPdHV+/K2j2QvkzoC4f47A9w+tlFpQ+UyhaSL21kIuejyo0BS/PGWiPSykB3JNZIc32i3vhcLwbf8Aurr+CwiPTestrWYdOQ7/51uKag1oY3FRAlB7PhOLrjUEY+WUuZH/DFqE4XYLEQ0by7xvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703944; c=relaxed/simple;
	bh=RLwCISjjvpDqQh9UjZYzjmyBIri8qVFiBn6s2EBVp2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjxPcrddZM/UsBELJJ0JT9pvCbIBEgMqQ7vCjlDpLHDczTBYn2bB3XT127QM8OeiIWDPB2HwE8iqg/CX1W01xm3xkv+krzeQ0TmNFw0mvzOhe/mTnNcD1G9hwP/LftROAuUXU9T24cq2B9YERryaC0UfbNyGzIsRoTUlDptJy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EUS3K6sp; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1763703942; x=1795239942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DBtBlG1mjzSamjRRUM5N4U8hMEoNzzFk6VpHupteZVk=;
  b=EUS3K6spPn0INBZXPg+4dQmzKR2BlJ4UAMH5DCdAT0gxHPpTFw/2/x71
   IpXnorMTHK3XLMsJr6nSZjFOIWDrtXZr65GuPqKhox0XCybvDff7nErhr
   1/RTvfV2RqT3xdQfOMIvw/AmvHkuxiG1KzHmrzM5zFox+buTI35DuQA18
   NI7Xwtrw2FeYDqQh1CJEG6MYAigu75F+tel7ivJSeFi41AKYBgGsLbPRZ
   8dvldyeax3wa8jb9XVXeZE4bWQb3+t+ry4GRGRLe+/teGruaLUAOybXVK
   G9lfHyZIc5IyE7fWATnrDfhQJQ2J3VcilcwDZUKWu8IaA0XXl15UxUuAe
   w==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 14:45:34 +0900
X-IronPort-AV: E=Sophos;i="6.20,227,1758553200"; 
   d="scan'208";a="581475090"
Received: from unknown (HELO Sukrit-OptiPlex-7080..) ([IPv6:2001:cf8:1:573:0:dddd:79c9:5652])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 21 Nov 2025 14:45:33 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: sukrit.bhatnagar@sony.com
Cc: stable@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12.y] KVM: VMX: Fix check for valid GVA on an EPT violation
Date: Fri, 21 Nov 2025 14:52:09 +0900
Message-ID: <20251121055209.66918-1-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an EPT violation, bit 7 of the exit qualification is set if the
guest linear-address is valid. The derived page fault error code
should not be checked for this bit.

Fixes: f3009482512e ("KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is valid")
Cc: stable@vger.kernel.org
Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20251106052853.3071088-1-Sukrit.Bhatnagar@sony.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
(cherry picked from commit d0164c161923ac303bd843e04ebe95cfd03c6e19)
Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6c185a260c5b..d0387f543107 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5810,7 +5810,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	error_code |= (exit_qualification & EPT_VIOLATION_RWX_MASK)
 		      ? PFERR_PRESENT_MASK : 0;
 
-	if (error_code & EPT_VIOLATION_GVA_IS_VALID)
+	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
 
-- 
2.43.0


