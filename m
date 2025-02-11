Return-Path: <stable+bounces-114856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9297A305CD
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38268188812B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883641EEA5C;
	Tue, 11 Feb 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNxyxJWM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B7192B86;
	Tue, 11 Feb 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262768; cv=none; b=EZ/p1TFu4TTXzCVM+XCnNyvQQA5Ef5ac6jUAjN5ymWhU1XYT+Kw796FrKkIC44b0ViRsd2b972V6BefFXD++DCOgORQfL+CyA3E/GDdIushHq/ZxEZ0Igkm48ymUNu4O6TZTiFRz0fJRYix9Y1SmiIc0mBvxuj/z01gBHyB/d6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262768; c=relaxed/simple;
	bh=3HUp0iLtp5lEEMyD1HDsvb7Mi/lw64moNCaiNwR77eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0I1g5NpFbRvPzhioyBqFzHG8nIHVj3qhNAau3JlezMrGEz5EfDdAMJZts710jalFO3JeZu7Liac/LGTmL99MQ3En5XaPGx2AmiDBUo+y8d3dp4Oqd+KvnpToCIH570jQeXPfAllIOUjqTDnVbQvX4RZYTpA+ewQ6ZFac9MnkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNxyxJWM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739262766; x=1770798766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3HUp0iLtp5lEEMyD1HDsvb7Mi/lw64moNCaiNwR77eI=;
  b=SNxyxJWMM23/Dwhj0meMosX99GtL7SYw6Hf+LDsn+yujY4yFAyKuHQxO
   Q771HjafWAySBo4GSIg0BHqx2RnBNJIpxcXF3EYdiviDwajaV6ZS/C6Fg
   naHRQwAtIR0oNrlFkTcE/kZMMxv7bn735NEyYhIggQDcVzo0aM/O6B2+5
   CgLX43NwQTrwv15b2sm8a/JtRL73F3+F7eqwFEbN+CZ8QYVqnYxTos2zk
   V7W+2PbG+fQ9BPc6yAmMDOiEkw4hflQV5F7AXCoRfICElO9wnsEjVWSko
   Fv20QZzXZxDnPZ5nfmLO0FUadvamXPiRIO8HYjogtfII9+pfGAcO/42e7
   A==;
X-CSE-ConnectionGUID: NkLUK/MrTWOU/VkA5Oaw/Q==
X-CSE-MsgGUID: aKHg5V3JQ2+Gj3CU9+kekg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40015888"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="40015888"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 00:32:45 -0800
X-CSE-ConnectionGUID: kHJ2xn4rRc2XCuRjxkElzQ==
X-CSE-MsgGUID: E0HBB7nTSwu9tWF5JA2CIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135697221"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 11 Feb 2025 00:32:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F24E1311; Tue, 11 Feb 2025 10:32:40 +0200 (EET)
Date: Tue, 11 Feb 2025 10:32:40 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH V3 1/2] x86/tdx: Route safe halt execution via
 tdx_safe_halt()
Message-ID: <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury>
References: <20250206222714.1079059-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206222714.1079059-1-vannapurve@google.com>

On Thu, Feb 06, 2025 at 10:27:12PM +0000, Vishal Annapurve wrote:
> Direct HLT instruction execution causes #VEs for TDX VMs which is routed
> to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
> so IRQs need to remain disabled until the TDCALL to ensure that pending
> IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
> be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.
> 
> Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
> prevented the idle routines from using "sti;hlt". But it missed the
> paravirt routine which can be reached like this as an example:
>         acpi_safe_halt() =>
>         raw_safe_halt()  =>
>         arch_safe_halt() =>
>         irq.safe_halt()  =>
>         pv_native_safe_halt()
> 
> Modify tdx_safe_halt() to implement the sequence "TDCALL;
> raw_local_irq_enable()" and invoke tdx_halt() from idle routine which just
> executes TDCALL without changing state of interrupts.
> 
> If CONFIG_PARAVIRT_XXL is disabled, "sti;hlt" sequences can still get
> executed from TDX VMs via paths like:
>         acpi_safe_halt() =>
>         raw_safe_halt()  =>
>         arch_safe_halt() =>
> 	native_safe_halt()
> There is a long term plan to fix these paths by carving out
> irq.safe_halt() outside paravirt framework.

I don't think it is acceptable to keep !PARAVIRT_XXL (read no-Xen) config
broken.

We need either move irq.safe_halt() out of PARAVIRT_XXL now or make
non-paravirt arch_safe_halt() to use TDCALL. Or if we don't care about
performance of !PARAVIRT_XXL config, special-case HLT in
exc_virtualization_exception().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

