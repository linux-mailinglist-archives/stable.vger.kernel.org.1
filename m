Return-Path: <stable+bounces-75820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D829B975176
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E39B28DD8
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72F187543;
	Wed, 11 Sep 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1KDYyBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B873477;
	Wed, 11 Sep 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056535; cv=none; b=dLBEGNEaeRgm1IGCTu8qdu8rYCvEjOVnOfKTvew16GSHvYwuWcAcjvzg88hB7B8hqssZsl8FBtYpDb33k0mj2O5UtdLK9VFWsCmOnc2O7T32ds5TMPRVcBQdUU+4bnvAY98EsmWI7HH4sik3e6r4jtpArwe7Dfi2OB+JjSOy5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056535; c=relaxed/simple;
	bh=w/tDZv4M/XcKS4q0HA8T/eO5qRUpw6WhnQbqCTdFFvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfjr3LbUnI5W92or7YBRWU53mi/kaVNf7+h8xmWiQqd5B+heskRXBlpVC8tNYVyJvvvXQL6WJiBzsjeWMP2fyVHxw6pCEz+uqW3/BV6U9CEiXyPP0eftRIZq6Bwu8x46eC6Lwtde5yxaQYCo8Ub8nRcLbHQnCKm2pCLTIHYY8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1KDYyBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A77BC4CEC5;
	Wed, 11 Sep 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726056534;
	bh=w/tDZv4M/XcKS4q0HA8T/eO5qRUpw6WhnQbqCTdFFvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1KDYyBql2g0tmnA4tajxcg2o9MFrW6hOdI5jmJVDR9RivGjEV2MZcIT7bp88c29f
	 ov/M8bP8IDDX9wM8N+wBoYsalVsh6p5vMcorq11vr/deYqq+74Cd0cgdo+zSPT6uSd
	 K5LsIBliXj81sT/gm6Zyi90gWZsWZ6yQCWW8mg4Y9X94wWOcdrWWJSqyfn3uJTjDdL
	 rUaweht1UGI0aUDuRb4PVgkxN34gASe2taDRPz5ONXxdZw/+c6QxXPDVyeHZi142h4
	 mNfJvEg9LQ+veMNU2eOMgZxD1Pgd0N4eCMbDoHX9liKoFFlS//pD3upQ++iAb3B/3r
	 RdaYsLpd/1i+w==
Date: Wed, 11 Sep 2024 14:08:47 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com, decui@microsoft.com, John.Starks@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/6] x86/tdx: Fix "in-kernel MMIO" check
Message-ID: <ZuGITwFiv5X3wg0y@example.org>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <398de747c81e06be4d3f3602ee11a7e2881f31ed.1725622408.git.legion@kernel.org>
 <24ec1497-af03-4e65-abb4-db89590fb28e@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ec1497-af03-4e65-abb4-db89590fb28e@intel.com>

On Tue, Sep 10, 2024 at 12:54:19PM -0700, Dave Hansen wrote:
> On 9/6/24 04:49, Alexey Gladkov wrote:
> > +static inline bool is_kernel_addr(unsigned long addr)
> > +{
> > +	return (long)addr < 0;
> > +}
> > +
> >  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  {
> >  	unsigned long *reg, val, vaddr;
> > @@ -434,6 +439,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> >  			return -EINVAL;
> >  	}
> >  
> > +	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
> > +		WARN_ONCE(1, "Access to userspace address is not supported");
> > +		return -EINVAL;
> > +	}
> 
> Should we really be open-coding a "is_kernel_addr" check?  I mean,
> TASK_SIZE_MAX is there for a reason.  While I doubt we'd ever change the
> positive vs. negative address space convention on 64-bit, I don't see a
> good reason to write a 64-bit x86-specific is_kernel_addr() when a more
> generic, portable and conventional idiom would do.

I took arch/x86/events/perf_event.h:1262 as an example. There is no
special reason in its own function.

> So, please use either a:
> 
> 	addr < TASK_SIZE_MAX
> 
> check, or use fault_in_kernel_space() directly.

I'll use fault_in_kernel_space() since SEV uses it. Thanks.

-- 
Rgrds, legion


