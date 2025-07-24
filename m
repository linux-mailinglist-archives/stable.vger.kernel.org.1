Return-Path: <stable+bounces-164655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2DDB110AB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652B03A19B2
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE442EBDE0;
	Thu, 24 Jul 2025 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX2gkxNa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2ED2EB5D3
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380698; cv=none; b=NiHOiKKzG2xyWONVXbuusd4gi76HVXpVHx4kHgo4DuUY2pPHXCV5o84jGYeCDIqdbbI5/NBXOZ9qUcN6mzc/6J359npmP8KqTI5hpc8ydiI7E/Fm4kqb9n/lPK5tMDaV3GvlP44Q5M+ut0y34qQdpyNa8vPMQkWFXBhNpTMF4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380698; c=relaxed/simple;
	bh=QePzPyzsFawXQYJ1FyApMa+QFt9RINhCr3auSEP5TTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+hjMIA2Wh5tQ2IZYJkWTWAbKQljKKZDRK09zGGGND+iO8ykkfxKG3SKgfSj9AtJAqfqWWE7raarrnDux2GD5nV5FB/RuIjtILKlXjn9+akYHGM8zHr7SoEVjS1TNyfv5GxKX/eQMXMDHY06gApXSFHpaqoe+zYZ2zH08WxxsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX2gkxNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F70C4CEED;
	Thu, 24 Jul 2025 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753380697;
	bh=QePzPyzsFawXQYJ1FyApMa+QFt9RINhCr3auSEP5TTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qX2gkxNa9UPNaIOBXW6DQNfkDsiKD0NjZ81aQ7eOEJL4kisSKl9oPXkiOhRforAXw
	 OtbUvCRwocyKHBWMry/lTbYcmaqvAMCSiyjJ2ZrjBy4IvJXBLr5sP64EoNNwOgLPhp
	 fQtlYzqCj2yovDY3qriGt9YrJCvq82I+qGQcSe0rKiuwt9SAAv6vFssf9yVOERr/vA
	 6TP0bu3LCabYCw5FW24O5820p6aMVzNPgAcgBfUGhiBO8AE6MxQvvlmOkwb0T/yPTj
	 C+Q20aRsK108IaamGd7zjN/vEoKRbAvpsGHsu0KsLhL1ibtMb7KGo2FsXuF6hvLwPg
	 jR5G5mu+ERNnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] KVM: VMX: Flush shadow VMCS on emergency reboot
Date: Thu, 24 Jul 2025 14:11:34 -0400
Message-Id: <20250724181134.1457856-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062039-anger-volumes-9d75@gregkh>
References: <2025062039-anger-volumes-9d75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Gao <chao.gao@intel.com>

[ Upstream commit a0ee1d5faff135e28810f29e0f06328c66f89852 ]

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
[ adjusted context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b0553e002e0a1..ab3098ea4ebde 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -681,8 +681,11 @@ static void crash_vmclear_local_loaded_vmcss(void)
 	struct loaded_vmcs *v;
 
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
-			    loaded_vmcss_on_cpu_link)
+			    loaded_vmcss_on_cpu_link) {
 		vmcs_clear(v->vmcs);
+		if (v->shadow_vmcs)
+			vmcs_clear(v->shadow_vmcs);
+	}
 }
 #endif /* CONFIG_KEXEC_CORE */
 
-- 
2.39.5


