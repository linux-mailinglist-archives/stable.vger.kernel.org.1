Return-Path: <stable+bounces-27490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412AE879AE0
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732E61C22433
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700F1386B6;
	Tue, 12 Mar 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpPMUE+A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6BD1386B1
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266154; cv=none; b=sdsjET8kBa55pTDixyAIT19HDIv/ZWDKOgWImLKxdsTageZLH0S9Td+p055XdT493ZlJiufDP5u7TQHlYwBVaSoYMBnzBF71EdX2MwfbGJNVfIWkSqOxbJO3T+eLMhW4TdymYeir1QNV0tXzYVvNATMmzrYCfOxT+1/D7MBxh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266154; c=relaxed/simple;
	bh=M/OD7gks2hiWrvdgnHDUYPJBC9GeI9G94PqBCj95ZIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo+JoPs1Dt9fCATq8L1rOkbyNJLijgFwCHmNVtRdPeSXFlr4DKJaeuiaw8ORZTfo0tkMNQDri8TQ72T+lbLPA+t014+4Es3k29YhMH0+k4RSwMWW0Ff/D7X8O9FkhRdal8HsfOcxePbT0d1+QpB3D79n1F8lLommEcLuYegwnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpPMUE+A; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710266153; x=1741802153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/OD7gks2hiWrvdgnHDUYPJBC9GeI9G94PqBCj95ZIQ=;
  b=JpPMUE+AtkrES7n3Hro+aINWDmb2qn2WyzNnFbCj7FfThsEE9KQPDXIj
   o72h0jeiNZCYnvkusRStCPMfB2oPo+peaOX0LpDEQh2MYBqONUsWyIKRK
   3n3QjPl/bkeNVorrshJSq2i7VKS3gDkxQgPkgi88LHdIZ5NXAFopbq4q+
   bxb3LcdX972iB/nedIVVOFtV+d+iH1paKrIHFlh+hYrpyemNtM/YyKDSA
   QE+HV03Zylv4zOOsydfT1KwUsK3Cls5EAcDvUz8ob6RIsOrT9lFEWAtK0
   GsuPLojFsWhGdxY2FNICl/stYX6msU4EOJw4PgUrvGZsly87LaiYU4ynp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5177961"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5177961"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16188358"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:55:52 -0700
Date: Tue, 12 Mar 2024 10:55:51 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 4/4] KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests
Message-ID: <20240312-rfds-backport-6-8-y-v1-4-d4ab515a4b4f@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>

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
index e02cc710f56d..ffe580169c93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1623,7 +1623,8 @@ static bool kvm_is_immutable_feature_msr(u32 msr)
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1655,6 +1656,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*

-- 
2.34.1



