Return-Path: <stable+bounces-77736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D66986926
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 00:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414232864ED
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2D158DDC;
	Wed, 25 Sep 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyGGszPH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A9148838;
	Wed, 25 Sep 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303148; cv=none; b=kKz4l3UewDZcUE0RYBeeIWcwzKpSY7sZPFG3doZkk/hxpS+7ovA40C5Oh6tMY0rjDdpE4DmI4MLPO3GqND/6LFag6RJETKelqFfZ2PI8FY8Z+GV4yi8Rp35R45ColdwXESgOaV38ZZL73bNwCpb/dGveJl5YmB23FVSmDNetgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303148; c=relaxed/simple;
	bh=7XNLoPjMi2p0yPNBVBbQHtFB3VyLvnKB24qCJaKJbNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHCLBbg7vznz4+Qie8sFtdi5j9g/c0IUhGvYB1AXxDhj7JE6WEohfPspnoomYxxb+oqHLMh3NDhCm0hdxKr/4pl7nJUSv8mHOPBg0rAVYrg5fWDX6aXyLKsiF+I73phdRo48yIFT4p5fikMLxFBj/jjyCxSdMgfSUD74/WfZlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyGGszPH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727303146; x=1758839146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XNLoPjMi2p0yPNBVBbQHtFB3VyLvnKB24qCJaKJbNM=;
  b=ZyGGszPHfGChi4JBraQvKZ4G/sriT0+n/bica0LhKzgbPf3IMGnHz5XE
   eS+4AIGFjrKsCCBHP0D0yNo2K/fZ8nZZuHWUETrza2wNkIS3FRliEklU3
   fthWFQr1XmRMVQ5k5MbdktDZW0EYkZhFCDzhhagEOYDcB3p22rrif5lsf
   4Wql7JOa1I4XwT4GTw+OSK8axHJxhcIlBvV7riQmabhgVpCpY9IRzLr92
   MBvEwvQUN0E+qAug7vDXzTko9t4xs0keTxR1D7XlkQKJ+FacDnZqY0nRu
   utHIaxfJqTs+GoZmIgm9L98FIpATENiYDttsHN9bzHsGqc4QMkhv5WxGs
   Q==;
X-CSE-ConnectionGUID: 3XxVLLYjSQKlrhY+9TEYGw==
X-CSE-MsgGUID: zJfhXLj7TYm0t3lXAsrV0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26531625"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26531625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:45 -0700
X-CSE-ConnectionGUID: opMfDUYoQzGWigxpE3SF5Q==
X-CSE-MsgGUID: k04R3mphSHOJ6iDmQ2zYtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="102750712"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:45 -0700
Date: Wed, 25 Sep 2024 15:25:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: [PATCH v7 2/3] x86/entry_32: Clear CPU buffers after register
 restore in NMI return
Message-ID: <20240925-fix-dosemu-vm86-v7-2-1de0daca2d42@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>

CPU buffers are currently cleared after call to exc_nmi, but before
register state is restored. This may be okay for MDS mitigation but not for
RDFS. Because RDFS mitigation requires CPU buffers to be cleared when
registers don't have any sensitive data.

Move CLEAR_CPU_BUFFERS after RESTORE_ALL_NMI.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Cc: stable@vger.kernel.org # 5.10+
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 9ad6cd89b7ac..20be5758c2d2 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1145,7 +1145,6 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
-	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
@@ -1166,6 +1165,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	CHECK_AND_APPLY_ESPFIX
 	RESTORE_ALL_NMI cr3_reg=%edi pop=4
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1207,6 +1207,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 *  1 - orig_ax
 	 */
 	lss	(1+5+6)*4(%esp), %esp			# back to espfix stack
+	CLEAR_CPU_BUFFERS
 	jmp	.Lirq_return
 #endif
 SYM_CODE_END(asm_exc_nmi)

-- 
2.34.1



