Return-Path: <stable+bounces-195464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F558C777BE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A3632330BE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 05:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4283B18A6A7;
	Fri, 21 Nov 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="jE19mFoY"
X-Original-To: stable@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645291D90DF
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763704046; cv=none; b=uPdBHPBD0jV8riW7dDdLZM729ODFvs1iA8m8V2GrP5oRc0W6y34FVyKKMikPK+CrK87d36VagJ+h6JcPQ/JlJbM0whMO4o6DVwG/UntdfOa/WN1zOk4q5k/H09RzEvyIC1ndTGKMxuv7zaRD7s2VM1dVa7xsZT0KakISdHrE4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763704046; c=relaxed/simple;
	bh=RLwCISjjvpDqQh9UjZYzjmyBIri8qVFiBn6s2EBVp2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfD++kbcMnecJkdH04eT3jydJoqLknjFUauWyRpl2Lox6n2bz7XzAlQT8TZfMOxW7W3F+RP8O61dXr6AgJqScGLqlXzGHbSrjcw3FiOONZf3P9w3UG16Z0Z1rba8+33FAFT/2SP3eCdXdegBDZbJpxkWC7RhTRjJnTIvIxsOA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=jE19mFoY; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1763704045; x=1795240045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBtBlG1mjzSamjRRUM5N4U8hMEoNzzFk6VpHupteZVk=;
  b=jE19mFoYEPVve7DRAmDq5o8AsI4Bm+4MCSZrbkP+QK+vhaG42vVe6bcC
   nvP0D43jpMTaJwNIB90GYaCksNtC6NGIk8nCjC9/telt2S9WQd0sW3al8
   yQaWnWIIY4/7K8KO3ck/GO/95PorAo9Gkwp5f5YtO0rE6W7urgKsYKbfT
   yJXynpCe1doxhyFJu31ek3wcvD8FyNBhlzXaWVacRsr2Q3BXWVCAa/0dg
   zEFv0Cj63XRVRVE8h+lu3x2fkeYzcYqmTsWkZnroFgulnqDUCXgWpbjXs
   XRDfRCmABq+ZnQHtjCfMqQv6uzfdrneLXBpya50P6JGwRGf9UzYkqHvlb
   A==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 14:47:17 +0900
X-IronPort-AV: E=Sophos;i="6.20,227,1758553200"; 
   d="scan'208";a="550932021"
Received: from unknown (HELO Sukrit-OptiPlex-7080..) ([IPv6:2001:cf8:1:573:0:dddd:79c9:5652])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 21 Nov 2025 14:47:17 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: stable@vger.kernel.org,
	sukrit.bhatnagar@sony.com
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.12.y] KVM: VMX: Fix check for valid GVA on an EPT violation
Date: Fri, 21 Nov 2025 14:53:52 +0900
Message-ID: <20251121055352.67577-1-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025112016-chatter-plutonium-baf8@gregkh>
References: <2025112016-chatter-plutonium-baf8@gregkh>
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


