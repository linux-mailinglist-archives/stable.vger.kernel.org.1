Return-Path: <stable+bounces-174741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870DB36520
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F088E0F89
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215E24A066;
	Tue, 26 Aug 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwcY8FaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B98228C9D;
	Tue, 26 Aug 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215195; cv=none; b=p06W53sgs/txulJzY9GBsJ5nfUmui8rfsinhqndlndN+NaSeqV4YHgw5u87cOl5bKBoCJmAWh2BWi1l5aHUrVwgTcfu/R/1GQ+nahUD9iGmlpA+8zA0AxytxTaGB1hSTBfpxLGAMt+s1SKg7JudJ9eFeKoX1t89LQvzoB8n7jH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215195; c=relaxed/simple;
	bh=6ft4k1pvcYpuLDdWyRjEA/B1husa2cyxcoITOLbObFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSeZoY5upGRqpeZ9anCK7npb2RCjF9VNw5blqL99zSzxRiUkp+fcfiAAoCjQK6a/iQW4DB7lew225b1jgrq7fu/M3UvfCONffMN+Ywu6zw/zdKYEijxPNa0sLwZequ/L0W5pzuj6HmS5aPRFp+NreMAFkXDZ7bz/y80crnr5dQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwcY8FaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D8C4CEF1;
	Tue, 26 Aug 2025 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215193;
	bh=6ft4k1pvcYpuLDdWyRjEA/B1husa2cyxcoITOLbObFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwcY8FaHdaNsJbAWd+WMLWrWzb01x9NowHp8+6MGka60uKyN0Gj8PB4F6Pm7EFyMI
	 NBwIf2H1Vtzc+J0HpXZi6wu3bq6CubVTS/NgT0ZX5H6Yoo6o+FtQYtk2RORMqtMfwL
	 lXhdXLnoq6uVgk/l3P9tzucXosrXN4eb0Ct6MMq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Gao <chao.gao@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 392/482] KVM: VMX: Flush shadow VMCS on emergency reboot
Date: Tue, 26 Aug 2025 13:10:45 +0200
Message-ID: <20250826110940.512419004@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx/vmx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -713,8 +713,11 @@ static void vmx_emergency_disable(void)
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



