Return-Path: <stable+bounces-70321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF996072E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242E01F26CBB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1C1A00C9;
	Tue, 27 Aug 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAc8sEpc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9819FA9F;
	Tue, 27 Aug 2024 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753474; cv=none; b=EhoJ8zVNR7U8DTS42I6coGAU5y7tp6tLcBbTjMoKam7Gb4pjduTse0vPB5A+b9+NOp/cQb5hWI0yK+qpSTMhFA4jb+7C51ernQZf9Qw5aTYDWqwY0c/dQ9LVuLgVONTsccfDDkGORecniEf8Ir+XL3BqVaUwg8WJ3Bq/u3f+Gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753474; c=relaxed/simple;
	bh=K/n9rmUZrNbIoJ9voQY+fmqnvNZA8GtP/naYECHuG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSURm8EgLa+Gc5eYk/zKPymVHQq73FecTx9hCaq0U5QbLLA8/+Dk9t1SjBV2b7Ed3hwbiRx2b+V8Rmtk8qfaLPXr9312NlwcFBmIaXK4PPrFXA+rj3JmtbvbiIpbma+8JX0THeqxnb7OgVtKOfiGMloyS0ozXKlsZtncy9pxyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAc8sEpc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724753473; x=1756289473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K/n9rmUZrNbIoJ9voQY+fmqnvNZA8GtP/naYECHuG9A=;
  b=fAc8sEpcMAjDPC2vS7lS6ca8BJNuw/Jhby8JeUgmuXtdoJC9o8KXx9ck
   irTTnn27MWTNC97RjSkfwapdKmE2vWr0uIkJ4jlZYvGmoIjBAj37dGZQ5
   vpkw85RpjFKyeBsTC143AXL8dkmkiqzUWTwEBgqhbIAFyl+PwaA9otDXv
   lp2q0Zk1NXlqynV3UFcgzrYDP6y8pw0OKCCBMGU541vSqhiqauqc2T7So
   BTeUPhD7PsJQzMPpaBj9M+nTgk9+Nj9VKFB41AkhcA+DhtEVA/P7IFdeR
   1HwFYx2aB1BHJ7q5JxWlvix2E9VaBbMrtndG57SjFySfE/1LpHfc9m5Ar
   w==;
X-CSE-ConnectionGUID: SoL1Mmb4Sk2gyfiDeaeHMQ==
X-CSE-MsgGUID: IJunGVwxSryyFIufnTmMKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23088289"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23088289"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:11:12 -0700
X-CSE-ConnectionGUID: 2b9slf1OSKKy5ud4cgxGQw==
X-CSE-MsgGUID: oAWGi3+wQFCNq4D02FzIpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62785349"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2024 03:11:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4D6A5170; Tue, 27 Aug 2024 13:04:19 +0300 (EEST)
Date: Tue, 27 Aug 2024 13:04:19 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv5, REBASED 3/4] x86/tdx: Dynamically disable SEPT
 violations from causing #VEs
Message-ID: <fs4n5t3ylzhboxcdrnuhlm6rdsprt7xaeeoae3cbyapw6y4cha@kqm5cwjavs3n>
References: <20240809130923.3893765-1-kirill.shutemov@linux.intel.com>
 <20240809130923.3893765-4-kirill.shutemov@linux.intel.com>
 <92fcceab-908f-4bfe-811d-694104d4dfa5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fcceab-908f-4bfe-811d-694104d4dfa5@intel.com>

On Wed, Aug 21, 2024 at 01:52:49PM +1200, Huang, Kai wrote:
> > + * attribute is no longer reliable. It reflects the initial state of the
> > + * control for the TD, but it will not be updated if someone (e.g. bootloader)
> > + * changes it before the kernel starts. Kernel must check TDCS_TD_CTLS bit to
> > + * determine if SEPT #VEs are enabled or disabled.
> > + */
> > +static void disable_sept_ve(u64 td_attr)
> > +{
> > +	const char *msg = "TD misconfiguration: SEPT #VE has to be disabled";
> 
> The original msg was:
> 
> 	"TD misconfiguration: SEPT_VE_DISABLE attribute must be set."
> 
> Any reason to change?

Because the attribute is not the only way to control if #VE is going to be
injected.

> 
> 
> > +	bool debug = td_attr & ATTR_DEBUG;
> > +	u64 config, controls;
> > +
> > +	/* Is this TD allowed to disable SEPT #VE */
> > +	tdg_vm_rd(TDCS_CONFIG_FLAGS, &config);
> > +	if (!(config & TDCS_CONFIG_FLEXIBLE_PENDING_VE)) {
> 
> Does this field ID exist in TDX1.0?  I.e., whether it can fail here and
> should we check the return value first?

See TDG.VM.RD definition:

R8  Contents of the field
    In case of no success, as indicated by RAX, R8 returns 0.

No need in error checking here.

> > diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> > index 7e12cfa28bec..fecb2a6e864b 100644
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -19,9 +19,17 @@
> >   #define TDG_VM_RD			7
> >   #define TDG_VM_WR			8
> > -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> > +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> 
> I am not sure whether this change is necessary.

It is more in-line with spec json dump.

> > +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> > +#define TDCS_TD_CTLS			0x1110000300000017
> 
> The TDX 1.5 spec 'td_scope_metadata.json' says they are 0x9110000300000016
> and 0x9110000300000017.

The spec is broken. It is going to be fixed. I use correct values.

> I know the bit 63 is ignored by the TDX module, but since (IIUC) those two
> fields are introduced in TDX1.5, it's just better to follow what TDX1.5 spec
> says.

Newer modules will ignore this bit and both values are going to
acceptable.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

