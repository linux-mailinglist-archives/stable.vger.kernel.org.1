Return-Path: <stable+bounces-71549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51796533B
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4301F23694
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4279618DF60;
	Thu, 29 Aug 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYYY2L4e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CB18A6D2;
	Thu, 29 Aug 2024 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972681; cv=none; b=LeXBvZb80czJFGGFOeJZWhQC3yQ95IJOkieSv+nf8YA02DUjaAVbqbwSfGc4hrkJHsdvH/s2uSomTB12SVAF2jeoNtSKR/lB1OjyJjj7M1kB8fMh7ujiaLRk79FFyKYqVdn5A6fdpmswXEvf/UwQrqiN+9EHSpBcDXD/eF4cyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972681; c=relaxed/simple;
	bh=xxKz9PCxVQJGKzd3KrLHagUw7YiCjOLdR1D0sByscmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArGURY9N5TmQ5kWqdYjp1DizsTf/LS8ZhIBoX/K3kejweedawNxi5gh3SXiOKNxj6o2h5gTCGQP71mcbqIImHnbqGJtMNMWUDMnamlwoM5Q66Sm7p2vxl9w7vtzp0hQ3ji0w1t6+OgatOBS1Dj1iUAYItGIPDDA1eC9FS11tBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYYY2L4e; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724972679; x=1756508679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xxKz9PCxVQJGKzd3KrLHagUw7YiCjOLdR1D0sByscmA=;
  b=fYYY2L4e1V07AoyWKKWgUdY5bwfTlE3sK0Xn37GWPyKzfD35L6M2hDOG
   ij1+pWRbWGEllgSAxS+9mvt3TZLQtB9Fc6Za6ujblvPACiNj7+s52KVjk
   oVryv75MJAzrCa1F01Atjw5wV3P3REuBhDqicZ2z9FxOMZO2WWs+iDouE
   E23Wg24usUsysbq19Ltko5Lf+ZwIxsV4hvpL4tTFloLZjipsXzvCT9kzi
   1lxtNEG/l7We5GlCSDjLdADsp2nrhRiXsCOA/ImdhGija8XEZSGbcJL8Y
   o6lv0Bz8kVHa4XzcaWq0QA2KaaP9D9sPqwN+hjNLnTlG92w8EVA3lnC+D
   A==;
X-CSE-ConnectionGUID: i9lOqrZZQeCjANDk9aZAWA==
X-CSE-MsgGUID: PIRpRCtISziPPU+nrb1v7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23787287"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="23787287"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 16:04:38 -0700
X-CSE-ConnectionGUID: zZrwyE/lRvChSnynhLhZ3g==
X-CSE-MsgGUID: 27Uof+B2QCmlHWAXj6GV2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; 
   d="scan'208";a="101234744"
Received: from bpinto-mobl1.amr.corp.intel.com (HELO desk) ([10.125.65.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 16:04:39 -0700
Date: Thu, 29 Aug 2024 16:04:29 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] x86/entry_32: Use stack segment selector for VERW
 operand
Message-ID: <20240829230429.bksowrtyj7qqwtsh@desk>
References: <20240711-fix-dosemu-vm86-v5-1-e87dcd7368aa@linux.intel.com>
 <cdcc5b91-321b-4e33-9a86-829b8f632ae6@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdcc5b91-321b-4e33-9a86-829b8f632ae6@intel.com>

On Thu, Aug 29, 2024 at 03:28:13PM -0700, Dave Hansen wrote:
> On 7/11/24 15:03, Pawan Gupta wrote:
> > +/*
> > + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW operand
> > + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %ds.
> > + */
> > +.macro CLEAR_CPU_BUFFERS_SAFE
> > +	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> > +.endm
> 
> One other thing...
> 
> Instead of making a "_SAFE" variant, let's just make the 32-bit version
> always safe.

That sounds good to me.

> Also, is there any downside to using %ss: on 64-bit?  If not, let's just
> update the one and only CLEAR_CPU_BUFFERS use %ss:.

A quick test after adding %ss: on 64-bit doesn't show any significant
latency difference. I will revise the patch.

