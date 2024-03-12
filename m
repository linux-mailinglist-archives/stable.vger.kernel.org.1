Return-Path: <stable+bounces-27492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C4879AF1
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AAE1F22D6C
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339B1386C9;
	Tue, 12 Mar 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tall+UNa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD953BE
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266758; cv=none; b=UA3z1t0WAPnPnpxJSZm8hRsawl5YvfyhtFOHy40pLtS8XPH2i/eu+6+NdAuJh2rkHlKCxnp+ecdAmRaAi2QBNQAWXPERAroVxvKUkyqc7O0XFNR/VmXcfpdSaIHQym6yHaSGRZzJ4jEqi0YqbaeMTDxhjqdnrKlEkqM5r6L+k7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266758; c=relaxed/simple;
	bh=9bLlE36uQTDhTz8hAxTHZSsMKNGhdNf0Jmi/XbXdbGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQxdOJ2XZIPQS9OUNyk0uTeczP2RnuQ8L+ESP5KLTgh9kKrtrNCy6MkF672nRvlrgN/SzQmTJqU/Ypd9RaAk7m6gE/C1xl2ArFn8muEGuZT9kM001yLLGru4yzhIgTh73rbhaczH0hEIThTUhJcqsRrfqlbXNgWbSeo8uZvo+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tall+UNa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710266757; x=1741802757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9bLlE36uQTDhTz8hAxTHZSsMKNGhdNf0Jmi/XbXdbGo=;
  b=Tall+UNa+cI2eGvdYRpoocaLC0F5EnRnLC+hzLqt7Vqq5Dy/4g1k1U5u
   HzahSHHcRRULbmQCSd5GRWDkJVztheR9p2DwnvKs02cSY/N+pXXYCmvqM
   nLB8mdWdRSAkRungk5CLjmG0dc4HyYtmKfrFepTLPQ/ixhSVoYf4ywfgN
   oEHpeiv4gMnKjqct6GbAapEjpI4uj2nRgdYDLR42dMuJmvgPOlN+KzcyE
   qYgkxle1fkg3X9agSxot+Btl+KYSdHzYFIF8GlVkaaEpT5n9qOJgsvZJn
   FhdhJVPrVZaRjwO4GbM7YRa1mFzjaWYncKXMoY8luAnV9JWyFalvMPs+P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15548548"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15548548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11697125"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:05:56 -0700
Date: Tue, 12 Mar 2024 11:05:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 1/4] x86/mmio: Disable KVM mitigation when
 X86_FEATURE_CLEAR_CPU_BUF is set
Message-ID: <20240312-rfds-backport-6-7-y-v1-1-d9aea75fb0df@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-rfds-backport-6-7-y-v1-0-d9aea75fb0df@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-7-y-v1-0-d9aea75fb0df@linux.intel.com>

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
index 48d049cd74e7..cd6ac89c1a0d 100644
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



