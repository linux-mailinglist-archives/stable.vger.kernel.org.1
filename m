Return-Path: <stable+bounces-164649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE94B11030
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250043B749D
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3326A1CF;
	Thu, 24 Jul 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUcgY8BO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503361E04BD
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376855; cv=none; b=cJSKKWwWX8To0jijJc6L2cbfzl7E/Qn6aiZjkTs8+43jDnIJwbXe6w9Yzv/1nwW8Jgd0IhQFtuHj+212QV7zsH6SPt6uWIVhJ21cGBR11uQ/WrO7wFlhAGsSs+o0E+TMpp6SvMdqP/rals0+Yg/lTDxHBNtfnNtuYAr30mMUpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376855; c=relaxed/simple;
	bh=d6wplKgks3W6vRALmiM1JCUKZCkKcvrL6WD8OgxoN/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p4E1aXGXsKL/9kvEoThh0iJRjvhBV9YUH4ZFS9o54sh3cjfs7+SDD50aU4jOXRAkLbYu5qJ58Wj2KDe6DtaaXlpSBqZ9Q3oyy0lCinx7Tb2/Dk6YNUywil+yid0fQPnKsWsJioE3IjxITMLdO7t4r+WuGxPe6RX7QFEyk8P+RKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUcgY8BO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB44DC4CEF1;
	Thu, 24 Jul 2025 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376854;
	bh=d6wplKgks3W6vRALmiM1JCUKZCkKcvrL6WD8OgxoN/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUcgY8BO9jIR4Q5k2suAe3zll36+fUt40ukNeVZwGjKOBH+tTdF14Xe1LyOx6ngNe
	 W/0TFeD45B5btjErZWs8s7ZwdMB3VDHtwnoIBUkxaQFf0nOduF1iGg05gkXqoqvypG
	 +CWzRelSkWEuspXxJidqXrjKplIRXH44HT9zmHdjDsoL0HRZGuk8zAVvYCgL3OFN/y
	 nDj17CP537K1icCNtKuwANBpkCd9AWGnxun/4QNwc/gmVHBt5+2XtZm5bl7WOdUwfp
	 6p598kZlFJHmsaDqbKtkAxat4LzZJMhIcRfkCbFyn2jQ9Dp2XXAk4u9dOozz7RX1De
	 0y0pZc/LMI9gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Gao <chao.gao@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] KVM: VMX: Flush shadow VMCS on emergency reboot
Date: Thu, 24 Jul 2025 13:07:25 -0400
Message-Id: <20250724170725.1404455-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724170725.1404455-1-sashal@kernel.org>
References: <2025062034-chastise-wrecking-9a12@gregkh>
 <20250724170725.1404455-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ef9cb8445dc48..12f9b220b6bd1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -711,8 +711,11 @@ static void vmx_emergency_disable(void)
 	struct loaded_vmcs *v;
 
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
-			    loaded_vmcss_on_cpu_link)
+			    loaded_vmcss_on_cpu_link) {
 		vmcs_clear(v->vmcs);
+		if (v->shadow_vmcs)
+			vmcs_clear(v->shadow_vmcs);
+	}
 
 	__cpu_emergency_vmxoff();
 }
-- 
2.39.5


