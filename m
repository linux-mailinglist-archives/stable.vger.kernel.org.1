Return-Path: <stable+bounces-27495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA6879AF5
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAF01F23392
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D71386D1;
	Tue, 12 Mar 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlWgrqJj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0B53BE
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266776; cv=none; b=KZRI5gvAVzxHtaoyGsAKACcHCIj7QmMHN/oREcmEmB5wx87vU+uIQKj6VHBVl9nhQaWJfPfss5KEYF99zkjFgxGxBuvau/G1RgtF9ARr2JHP4gEQodGhmomL9QMXhcpV8b1N8Sm01PR1KYBROn1dBCJd+wBGEWt6xY/f3Y5qVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266776; c=relaxed/simple;
	bh=B8Hq0XRuTdG7Aef57hD3llfd7udz+FmjQr92m8a1HeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgUyN1c3iSwvyGaSB4Zjwp5M4vNbSGHVysDLEOD8RakzMubCmPwdsG6y3V/VcFEUZqUeurHj1s9FhlrMnjnE/YBJjGl4dHZ1RMJST2ZqOr3Ok/Q23rHi0T70bNU2Js1ATqSeqNa6ePyt4tElmPwieXqaPnmK3wRQe3cXDIw64EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlWgrqJj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710266775; x=1741802775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B8Hq0XRuTdG7Aef57hD3llfd7udz+FmjQr92m8a1HeE=;
  b=JlWgrqJj1b6Flz0xD20W6xrquV0lssQ33RxiOubT2AILgw2H803qBJPT
   gldpqRmnZ2Gqon+zzTUB/tEQcAl+nuSODCgUcIo91pZf9DXGjpf0XRUri
   7g/8gVYGQneMcy0VC9B8q6Mf6aR9zPmnB+u1WulYY0B74Sdiow7LcDolo
   ZL1huGeACZox0Qw23rdoDkSk8TBAM0oOnC1GZmTIP6wJJ+EfZNuSg7zmI
   3UJ9ZcPN0piIPgQVpJNlLVx2OYLljDrcsA/hmJgP9zMhUI6aJIOJrB0Ec
   gAAUdYmWDuM40LV45ZRfis6ZYyom02kHnxAvx5FCuDDa32+cj9iDPGVqw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5599798"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5599798"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11534368"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:06:13 -0700
Date: Tue, 12 Mar 2024 11:06:13 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 4/4] KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests
Message-ID: <20240312-rfds-backport-6-7-y-v1-4-d9aea75fb0df@linux.intel.com>
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
index 468870450b8b..8021c62b0e7b 100644
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



