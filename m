Return-Path: <stable+bounces-27501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAB879B10
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75DC2840A9
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A80139569;
	Tue, 12 Mar 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0rDOYp5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1D137C2D
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267230; cv=none; b=RwLjbOnTCZDAr7rrwxW9URvyQvcv6Uy0lB2/5ZaNEqWO5k1sUbxbm3eq0FmrS/+RbfFEZE30/6LKMr4ZSdeXl8VyMnwcbjkN0bnpEpaqiXdkH7702Q5Ngk60Hxp5u3xHefUneIZ5KOW68hCduxQ8NCVrpIZDCXpfOeO6t56dMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267230; c=relaxed/simple;
	bh=nvwi8B+z3nnL25/3AHsDfNWZycySxf5bKsy18HmR430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyEnIJfJYwwFOPXIHGSK+IRxR5MLfPoJHDPgW0p0MvrFdY3BroakZv5TF6tg8eJR1914FeOcpOfHfSM28Ede08vM5JBKQEa2APE/1uFI1fS2AD0RIc+a4eBjhwBQHFvRGXe07bSClxL8HzPQ6cPycPhwHjUPu9gNt1cp4CRwBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0rDOYp5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710267230; x=1741803230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nvwi8B+z3nnL25/3AHsDfNWZycySxf5bKsy18HmR430=;
  b=X0rDOYp5XuDGI8S5D+LcVKJvEesYnHQSRHMY9aahN15q0OYRGVaI3s80
   2iA0wat9deNc47oKeo3m4efwvAFFd0LNIMRrHZw7MdnbdyPmBxq6pH751
   mbCcZbHY9QRcg9MtYCcErfr/ZLUjNScMPNqY6YieVrmI0I8AfurvHEroD
   tnF14Gxi/bXMkRRHkEML7BPF5yE1wQevfEHncPLy43SJpNB7ssfrMUhL6
   EGZ2SgjroPTG8dW20Hf2g5dfX/04Gnu0JqUllMEWyWmEEqehroOabJq04
   dFvrmNPJr9wFnbNm5UhDZ4oZg7FHjkL+nVdRr9/mXqpqkzAZdgeDgbzwN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15550091"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15550091"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11525560"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:13:48 -0700
Date: Tue, 12 Mar 2024 11:13:47 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 4/4] KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests
Message-ID: <20240312-rfds-backport-6-6-y-v1-4-8a47699f1e6c@linux.intel.com>
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
index 3d8472d00024..9b6639d87a62 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1620,7 +1620,8 @@ static bool kvm_is_immutable_feature_msr(u32 msr)
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1652,6 +1653,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*

-- 
2.34.1



