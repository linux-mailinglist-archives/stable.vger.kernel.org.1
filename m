Return-Path: <stable+bounces-27498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC516879B0D
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31177B21DD6
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E338139573;
	Tue, 12 Mar 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN3yc3Pa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1C137C2D
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267219; cv=none; b=bv2T/4nNzIwJeimyR/sYWx+TLnRgX+vu5W4lR4ksGNYf2YrQOsUIs6eaWAFXCa8HjZIznpRKwRgt/Nx0U0I28GSNLeSecXuLMIYtRiOw3IKS/Cq/nnG7/zlT1dVaGvt7/ejJpQlQbr5df37kFJJ8n4VjwAATlktE7nyfVIwh8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267219; c=relaxed/simple;
	bh=PP3MrkjogH7kD/yReD7aP0/G/e426HDPpPGrqOwIggM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoWo5sRZAvDaKWcaMjLAIzDE8dfJ4iLTILjmekwGjdLRW0JY/UX+VG78Bi+BqA7QkEavi8vXsayBfqX0dCYaO/mH9/cx+5+6v4U22soCBdTPskSQd1fNcGlr0EGX525RKNgPEdgJEJVmfh4j/VoSiWo/TIsTLKuAgv+lRC1HEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN3yc3Pa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710267217; x=1741803217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PP3MrkjogH7kD/yReD7aP0/G/e426HDPpPGrqOwIggM=;
  b=TN3yc3PambAibqPBHaK44bG5FWRTJlrIPmZ0fJ1a0V/IEHzHGRKlbxVo
   I4i/csPILiOIUONtw1b7DBOxVQjob2pM9O91A/fdVIT6wTI90Be+1mMY3
   uq27PRLGTZhkiNoUvtLliOq5Dr48aj+a8WXmv/GIeib7KcXRoJSdiTddG
   vVAsXxuXkYtKblIyCrPs09RW5p+KFChUwGejpfiBigc12WQJR2W3xpHgI
   hChTp3hN5oark362lu/I1lFJMB3E9A7YjYQMq8rdLFLSFFS2Ofyg0KGNG
   CHp0I6HCZY3BUauvSiPONv6Ne3n5DtLQwfwCH6yozJhJxvhPubIskS/xN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15635022"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15635022"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49063512"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:13:31 -0700
Date: Tue, 12 Mar 2024 11:13:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 1/4] x86/mmio: Disable KVM mitigation when
 X86_FEATURE_CLEAR_CPU_BUF is set
Message-ID: <20240312-rfds-backport-6-6-y-v1-1-8a47699f1e6c@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-rfds-backport-6-6-y-v1-0-8a47699f1e6c@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-6-y-v1-0-8a47699f1e6c@linux.intel.com>

commit e95df4ec0c0c9791941f112db699fae794b9862a upstream.

Currently MMIO Stale Data mitigation for CPUs not affected by MDS/TAA is
to only deploy VERW at VMentry by enabling mmio_stale_data_clear static
branch. No mitigation is needed for kernel->user transitions. If such
CPUs are also affected by RFDS, its mitigation may set
X86_FEATURE_CLEAR_CPU_BUF to deploy VERW at kernel->user and VMentry.
This could result in duplicate VERW at VMentry.

Fix this by disabling mmio_stale_data_clear static branch when
X86_FEATURE_CLEAR_CPU_BUF is enabled.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 17eb4d76e3a5..19256accc078 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -422,6 +422,13 @@ static void __init mmio_select_mitigation(void)
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+	/*
+	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
+	 * mitigations, disable KVM-only mitigation in that case.
+	 */
+	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+		static_branch_disable(&mmio_stale_data_clear);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -498,8 +505,11 @@ static void __init md_clear_update_mitigation(void)
 		taa_mitigation = TAA_MITIGATION_VERW;
 		taa_select_mitigation();
 	}
-	if (mmio_mitigation == MMIO_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
+	/*
+	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
+	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
 	}

-- 
2.34.1



