Return-Path: <stable+bounces-25804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080D86F929
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 05:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06261F214E3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 04:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBE611B;
	Mon,  4 Mar 2024 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYzexrKM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BE96117
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526255; cv=none; b=Vgy/7c//L7A+upzOGqzOaJhfPg55RglPvbsZ89o1yXkzZp0Kx1JRCR8g6pbzaYDoFT1dgycKy4906T55Nc0Tu9KDSls15b552/1/3LvP+TK4ylyTt0HF3VsAo8rOM1cAglxlRFAQlzy3Ue8ROjIAA5Mt5+IYfvzKldEwA2R/o8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526255; c=relaxed/simple;
	bh=YbgUm2uQKA/UqOIwjl1zIj0vQBK0fLZLG+LVoUAqdXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb3X988Ky8E4zKR/kVqZLMIb26qO3thEk4IgUWrLXFERlfXMvcl307hhmtddQ7RiBSk6tpWhtYOgXvqAajxdeesbNPDpq53G4zuqDE2g17jDv+L/PHE9yfBjJglIFHbOciYLR/P+uwYY0YleN8sWbPDX+UHiT8NvRCGsLn2tmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYzexrKM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709526255; x=1741062255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YbgUm2uQKA/UqOIwjl1zIj0vQBK0fLZLG+LVoUAqdXY=;
  b=TYzexrKMrBOWx6gIn4+NgMh1JwxzEw3EPNmrtPbSdW802Ujioe+LxYvX
   UVAwtz+p+PwttssFjYwd+krX2KoqPtfzZnAUfZ+E4qV9Xg7E6skwTL8EC
   S1UTwbLGMV59BDaBG7GnxdWX+MQnt6AUpSdy//qbD3dDyiJCU32G1/zow
   kbatS8tvZpDn9HT8PusU8Af3VTUDIMYQgm+sHEVgCkI9JWDx72ywrrCZg
   u86mKw/PLAw4VXEiNW7cOOp1TQbTLJxv12Arwf8EH9PXKBTf4wwAtkfAC
   wou3Be4oI3HqJ7JD84IfwFYnoaAptB8UZp+h+7cwMUkaK3/g8rYf3wJgZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4121812"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4121812"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 20:24:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13516368"
Received: from dhorstma-mobl.amr.corp.intel.com (HELO desk) ([10.209.64.132])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 20:24:14 -0800
Date: Sun, 3 Mar 2024 20:24:13 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.7.y v2 2/5] x86/entry_32: Add VERW just before userspace
 transition
Message-ID: <20240303-delay-verw-backport-6-7-y-v2-2-439b1829d099@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303-delay-verw-backport-6-7-y-v2-0-439b1829d099@linux.intel.com>

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



