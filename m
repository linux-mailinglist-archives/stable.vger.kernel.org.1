Return-Path: <stable+bounces-27533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF669879D51
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11851C214C4
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D0142907;
	Tue, 12 Mar 2024 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgZepMrm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D41428FC
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277899; cv=none; b=RS3OjHpsydS5f1hIy80dyQJV8vsMZn503p8RobxRq1+dsHRtCMTY4ke5+j1jd3oN+hYUtKsGXz0ycjMWx62fVGQxOX0rua73MKQduQpqX7S4/oh6xl2lJhLG84ZJ44Ve/4OGUdyit//BATMkOe2dNLAmffsbJvxTrK66pg1uC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277899; c=relaxed/simple;
	bh=uNrPb3x0T6fpEKMFs+xIKE+hQ0eywBrmLhe6TfAGK3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On2uL0f2RbENZmvZH/MzufxCwCKBjuaOSSLkVPbF3xYuOdl9t9QlGsRJ7zFVkDkLPniOp++38JnJA+diGF4zfUxyMXlNmTujZ5UQ9O6yeEP78+T+3iPPITeEYR5S4SA8Rxan+dULgiB0GeyYRfv52Y8JNkhipQGyvMR0uz8ByjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgZepMrm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710277898; x=1741813898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uNrPb3x0T6fpEKMFs+xIKE+hQ0eywBrmLhe6TfAGK3I=;
  b=PgZepMrmp9MamC9tB5gVlMP5VFa/lVDg9LS6UXHv1NYBTA3SAGUOEm0l
   MTaozw5JMXQX70yZFYFa7/5zRE6ifzQK2Dlj/cZwu303yCCJc2bf5aUpA
   AWm55ICK7nVvHntWO3AvLooNvhY3nyzni/hosmagX2upoU64TwBHoYsJB
   LsbLYCA4NvagUDSGa/+iNcMwGxPipOnVcOgbjASLCfpXIIWCemfcr8EbX
   ZKSpeBbShjNSGDvfLiDWVs3ApzUNXm4hR3sJV06wo8/cAA0q12Tnf5nif
   hsEk0JZ4FIAL7fLDM+I1S2YdJT6345eaAFAxngDzcpmzrdG2uURlIzfC/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5138888"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5138888"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11742517"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:11:37 -0700
Date: Tue, 12 Mar 2024 14:11:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.15.y v2 11/11] KVM/x86: Export RFDS_NO and RFDS_CLEAR to
 guests
Message-ID: <20240312-delay-verw-backport-5-15-y-v2-11-e0f71d17ed1b@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-15-y-v2-0-e0f71d17ed1b@linux.intel.com>

commit 2a0180129d726a4b953232175857d442651b55a0 upstream.

Mitigation for RFDS requires RFDS_CLEAR capability which is enumerated
by MSR_IA32_ARCH_CAPABILITIES bit 27. If the host has it set, export it
to guests so that they can deploy the mitigation.

RFDS_NO indicates that the system is not vulnerable to RFDS, export it
to guests so that they don't deploy the mitigation unnecessarily. When
the host is not affected by X86_BUG_RFDS, but has RFDS_NO=0, synthesize
RFDS_NO to the guest.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aa6f700f8c5f..a742deca6388 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1498,7 +1498,8 @@ static unsigned int num_msr_based_features;
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1535,6 +1536,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*

-- 
2.34.1



