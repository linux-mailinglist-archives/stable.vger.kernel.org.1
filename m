Return-Path: <stable+bounces-26867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800CB8729D3
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358EE28B49D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D512D213;
	Tue,  5 Mar 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLDRNHVX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0C12D1E4
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675711; cv=none; b=jcKnBctlrTIbSU8mIWoCyw1yIlIsjeBwMpsstBeSAyr32Pd9Lr8MdyYICEgMH3QyoZ/RqULkdSK+KKvOGlMGsfOJE5YTiIYgB//3zVLuxMiw5VAgqr7X11rb1K9UOl8moWQ+5jWEw+B/FCC3/yhqkUNM5pxf7SV7cuGMzTnx9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675711; c=relaxed/simple;
	bh=AkCWN3AsdaO6n62Nyp/Vb6Qxgxa/JaG386UFDCtkgOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEAkFs4+2eGCZKJtk1aGa5wednjGXKQP/BLLBGLXSCNXUtg1Zi7Sziwgd44uq7qGpOXeb10joRJsgWpNBtI8LOmyI7jt4xskK1krfbLGG1avPzH/nIZXPNKmD9ZfDz1joWzWDzmVhdiSJ6mOulug9KxvRnbJnfsSjROpTn0qypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLDRNHVX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709675709; x=1741211709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkCWN3AsdaO6n62Nyp/Vb6Qxgxa/JaG386UFDCtkgOM=;
  b=SLDRNHVXmrx3jbyE0PHGR3G1/FABCuqNMAN8ftaA4t1TPDYw20koyvDC
   vwgv5Vy/0C3yzr5pNZjS13KVOV0HknO2VcfkbzdVKQ6pywYYGqzeA3Fiz
   1QcBVlB0DaonF9M1KqfoTJeZVLQUQktf9X+fISvSdQslCOswLB7ZSRifa
   dka9sIkJQ/KO2zIdeuQYgM5Wf/SfFd0PredHZdArvcdbnFR9NQ6QM9L0b
   WMwFpcArUM/pHp0PA7nWmDTC80Vu0drJjPjVyV7RirmZwNyTaMTJ/vKKk
   mE+qWf0wPwr6P19mGUDCTLuH9HcRSpGvZQ/hrCDK8QTA5mIGDcoGyQYbs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4119766"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4119766"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9683856"
Received: from pbemalkh-mobl.amr.corp.intel.com (HELO desk) ([10.209.20.113])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:55:09 -0800
Date: Tue, 5 Mar 2024 13:55:08 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.10.y 4/7] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240305-delay-verw-backport-5-10-y-v1-4-50bf452e96ba@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-delay-verw-backport-5-10-y-v1-0-50bf452e96ba@linux.intel.com>

commit a0e2dab44d22b913b4c228c8b52b2a104434b0b3 upstream.

As done for entry_64, add support for executing VERW late in exit to
user path for 32-bit mode.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-3-a6216d83edb7%40linux.intel.com
---
 arch/x86/entry/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 70bd81b6c612..840e4f01005c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -997,6 +997,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -1069,6 +1070,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1267,6 +1269,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



