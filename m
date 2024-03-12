Return-Path: <stable+bounces-27552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCD8879F09
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 23:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32ECB20AF3
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F520B00;
	Tue, 12 Mar 2024 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W26ln51t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965214293
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283287; cv=none; b=p8aKsi+Qw6tjj1W9cF9ZHg6dQoKOitRVO129pMJI9n313+uYGUa+fcGdUi8cMJtqAwW1IBBRQAUZAexKP4GKmQZn9rubvV/3JE1JAYYIQ5F8Y3oAlIYRyKl80NyM8B45wrn245JTgkVuE6Yivdahh+Rdl9QC1MDyL4bTD8n1BEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283287; c=relaxed/simple;
	bh=nzuoroHMq5+yvX6EXbr/JBNGWcUtyMRkuLRLNmiePFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3v8zOt8PFtMRF+RWM3r4AliLxAXexRjO4DbqJtm5Qp6nNZYaIVZGZ6johaWF8mNIcHJQPEJgV7jAmQnVU6PsIvnAZFNjkLekBjLEzW0yT85izNOWGKzcJbTIbjJPnja+k+FIewUdJLQ09UoTRvGv4ydbbZvm5ppeOgGam1qd/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W26ln51t; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710283286; x=1741819286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nzuoroHMq5+yvX6EXbr/JBNGWcUtyMRkuLRLNmiePFc=;
  b=W26ln51tHk8mf2MGz9orQDw84XX6tpNDLfNbHc/LUqTh3bDTha8kuxua
   kl3zdyPtzcOTAtp2seKoUMWqzksbmHd/szw9O6hRCDvUSz+I2kRGxVKKv
   inBPifhSLxQ9mzhlZWcCGIPcGyb2PAGkWk/JYbdUVLnWMUQdVAkqtVnSh
   zdY2G/O2x2Eu7EN4ak8NdSk4LMbf0DPKwYVbPM97yQ//38Lsoaj1Zd9Oz
   ggJOJZxnWNAqsXFSsMmzUuJ5XFrJKaDoQNtNzFQ3ljJcQmTHAWo20ESqk
   gg/KKv7U5btND3MhAyw1TEhgq+oUryoggLo1Xi1rSAyULiCJOGHTgff3J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5632258"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5632258"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16423594"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:41:26 -0700
Date: Tue, 12 Mar 2024 15:41:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.10.y v2 11/11] KVM/x86: Export RFDS_NO and RFDS_CLEAR to
 guests
Message-ID: <20240312-delay-verw-backport-5-10-y-v2-11-ad081ccd89ca@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-delay-verw-backport-5-10-y-v2-0-ad081ccd89ca@linux.intel.com>

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
index 6c2bf7cd7aec..8e0b957c6219 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1389,7 +1389,8 @@ static unsigned int num_msr_based_features;
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1426,6 +1427,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*

-- 
2.34.1



