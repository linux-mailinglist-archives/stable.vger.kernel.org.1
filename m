Return-Path: <stable+bounces-23809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D2C868872
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 06:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A841F24E40
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB2524BB;
	Tue, 27 Feb 2024 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEdjqaSA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C451C23
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709010069; cv=none; b=aaelkB8sTCP2/XkvJDTdQCpEnGfnaCoZA5G9c/+Ncz+zHigETayERMulOB1EllMo5ZjodwtkGRa5uZCubAmYZDW+Qs5jhHBrcR+LxsQtvCoeVk4N6WU7Azk/yOmiWDeIC8xHv6LOQUNPz+aY1zLBSVFIcpfhfZOE4C3k6oOYs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709010069; c=relaxed/simple;
	bh=YbgUm2uQKA/UqOIwjl1zIj0vQBK0fLZLG+LVoUAqdXY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT8muPi5R/SwpvOPXW7yWCqQwWbk7Kb8a3dq3U0JCQEkeZkQgmVbAUWdViGcOWUtHbqE444GLFC0NPRZcHisDmlPC05AzVZF+aQqy0SvQ/ciMpD+qy9DRhBTEfDGFF/AA5F0xzQWOz2oP3y9MVtctPX2V87QTrTiKN9U179ldOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEdjqaSA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709010068; x=1740546068;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=YbgUm2uQKA/UqOIwjl1zIj0vQBK0fLZLG+LVoUAqdXY=;
  b=QEdjqaSAUQ8zz946NfGy62D30yO0y4kaA8aJyA5hNsqI/z8+B7WqNFNl
   XIYTnWvErNNh/dkETgZJ3yXDAefmREBG9UHDVTBRjqkFy1UwJFItwHnRY
   HjupGRMvVhChkhMNewDEyLKlkeD9CdkHBVdIWt2L5zYlW0JZZiVly6BCI
   7QR2XI6yRiuG189BuFgwLfoYDjAb/qRQPWUrzE5MgMwV/HYXz01lcLBzV
   pHetbDclej6vbSveqquM/Pq992hJCHbVDhIojg3SFmJQ/W9VzEDZlwM1t
   48NC8IoXnyvjATNcyVlubU/Pt1M2iooOqxTjB07P+LBvlfmIz+2du6LH/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3493283"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3493283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6786959"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 21:01:07 -0800
Date: Mon, 26 Feb 2024 21:01:06 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: [PATCH 6.7.y 3/6] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240226-delay-verw-backport-6-7-y-v1-3-ab25f643173b@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>

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
index c73047bf9f4b..fba427646805 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -885,6 +885,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -954,6 +955,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1146,6 +1148,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

-- 
2.34.1



