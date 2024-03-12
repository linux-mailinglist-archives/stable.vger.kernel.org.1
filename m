Return-Path: <stable+bounces-27503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA4879B2B
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2191C2256D
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD3139589;
	Tue, 12 Mar 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3Plj28S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41273139580
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267437; cv=none; b=AZuy+zMkgpTAzY71sAujVg9QMynqyBOMM9Ok3xbVbAdNY/BTxLOoEo+bKIyv289vqQWb3xfmm+tfuyN7pltOLqnyM7npR18ZnnWX3vHKe/O8OhyBS8z6NKTe/9ymk8j9QunIwDPCle/uMFTXp59+RZP+4DIKtSATwjyvcT+UIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267437; c=relaxed/simple;
	bh=fnLF+ybQuwd50mNkKD5YmM0rQyk32qWZgZDJEgn7f34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbeVuOnNhEH1ihyf5zojUDSuhO+V1QIGOdQB7bMsmHCzMliRhdAXWTmBktRwkdYcJ7F5pB1xNi74zNRq0s5akwhKJFJPRQaNjKUgCQwWMbbO+SkdE3cLS3RLshC0vRC/K9qe+oXqm/n1Y284SovhuZiAikDhRTbVvbmPaBH6vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3Plj28S; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710267437; x=1741803437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fnLF+ybQuwd50mNkKD5YmM0rQyk32qWZgZDJEgn7f34=;
  b=A3Plj28S4P58gvZy19OIILlgwJ/mRFZhy4PY8apo5igqJQ+DR56BD0QN
   qwZMB/kA2RL2k8hWpgiBtAzVWnReziwH9dDAr1aRZ7fn0w0SUFSQOo21I
   TKueFB63RDFqdy63ZVttkfPg8dCvDy0Mc2UtGi6RpOnfv0SEPnHTU/DzY
   IO6zKV0uQ21IzdzdVEMCvuTIFCEgE2w2b8Sr8SZRpazzx6QO34ux/PwNM
   umMUbCMjmZVbt6pnsaFpNkPoZ0BbdGQ4KUp4CNiufO958U5uW6c5miwPD
   nLToj9Ij6gZvHaJ2emiJjI7oArjaF8NOhqHXemT8bHq3ORSdWaNnc5+nb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16136431"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16136431"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11717888"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:17:15 -0700
Date: Tue, 12 Mar 2024 11:17:14 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 1/4] x86/mmio: Disable KVM mitigation when
 X86_FEATURE_CLEAR_CPU_BUF is set
Message-ID: <20240312-rfds-backport-6-1-y-v1-1-31cae244c4de@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-rfds-backport-6-1-y-v1-0-31cae244c4de@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-1-y-v1-0-31cae244c4de@linux.intel.com>

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
index d1895930e6eb..c66f6eb40afb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -421,6 +421,13 @@ static void __init mmio_select_mitigation(void)
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
 
@@ -497,8 +504,11 @@ static void __init md_clear_update_mitigation(void)
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



