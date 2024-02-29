Return-Path: <stable+bounces-25478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C9986C612
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 10:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42C91F25CEC
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 09:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6D627FE;
	Thu, 29 Feb 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIzt+9JU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FD62154
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200405; cv=none; b=Z3rO1EGQHuPaHboBmm3wEOtKNaFwSxet8FTHwf8XPTtSJwGXfbey/E6yAsay9e8F61dHBqYImHm9Rv3dk3FkJWEaYIzA2mRbGz5/m99b+A3wtfO8mElHebRgU7xzy39PSjaZ8u3dfQbgZ/hYXDcsYrgpfF81WUSXL0lmUgPWliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200405; c=relaxed/simple;
	bh=ytj3cdkx97dAuk3gEuj3SCojz6k1VkMX4nyrBboQXXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsKKp+ApS8OiCo2k80cYSB+uNe0vz3o9k8SBjAlpVzmwxODlWnp2rAyEtRriuqxIa7vc64Pht3Iou6yb5aq6kVgfVK6Y5PRxUcn1HpHb7KbNbf0fAJHsAl0ZZTQ/AogeJULxeQBNz4GnCPY+kDGtoVfvDwzrGtoNPCbgU+veYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIzt+9JU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200404; x=1740736404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ytj3cdkx97dAuk3gEuj3SCojz6k1VkMX4nyrBboQXXY=;
  b=XIzt+9JUeIaVFb/K9JhF09onHtfeCaZJ7V8PLlDnCkcq09W9JCGLD2sc
   LCzbAkHUCYNm+sokmFvIJjTWK/RIh5kyYZSvYaKFwNYB/WamnIVt0XVQH
   mwzserRg+UeDA9Ej25G7BLR6m51cUPT/OfJeQzqrv6TjpjzMXlaP8KUF5
   MO4y///0QUiN0t45sSIoHpVXeEX6R1FMu0z0hQmlBi++iJMYid0Tpey7y
   MBvfZQ8nRms7n5AjA6DppdM/Q24H5+C1Q9+pAea5SewOtiE411LUY1ef3
   HUknpsZQVhd7IBhcIflN3kEi2mnZGKmotFkZCYj6USe/zJGKoUhSMinUU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14366941"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14366941"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:53:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38811204"
Received: from vyalavar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.79.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:53:23 -0800
Date: Thu, 29 Feb 2024 01:53:22 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.1.y 0/6] Delay VERW - 6.1.y backport
Message-ID: <20240229095322.uaogvei6amclumkz@desk>
References: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
 <7f75bfa1-03a1-4802-bf5d-3d7dfff281c2@kernel.org>
 <20240227085638.plb5gvunrjqgj7yp@desk>
 <2024022716-undiluted-donor-17cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022716-undiluted-donor-17cb@gregkh>

On Tue, Feb 27, 2024 at 10:09:06AM +0100, Greg KH wrote:
> On Tue, Feb 27, 2024 at 12:56:38AM -0800, Pawan Gupta wrote:
> > On Tue, Feb 27, 2024 at 09:21:33AM +0100, Jiri Slaby wrote:
> > > On 27. 02. 24, 9:00, Pawan Gupta wrote:
> > > > This is the backport of recently upstreamed series that moves VERW
> > > > execution to a later point in exit-to-user path. This is needed because
> > > > in some cases it may be possible for data accessed after VERW executions
> > > > may end into MDS affected CPU buffers. Moving VERW closer to ring
> > > > transition reduces the attack surface.
> > > > 
> > > > Patch 1/6 includes a minor fix that is queued for upstream:
> > > > https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/
> > > 
> > > Ah, you note it here.
> > > 
> > > But you should include this patch on its own instead of merging it to 1/6.
> > 
> > Thats exactly what I would have done ideally, but the backports to
> > stable kernels < 6.6 wont work without this patch. And this patch is
> > going to take some time before it can be merged upstream.
> 
> It's in the tip-urgent branch, doesn't that mean it will go to Linus
> this week?  If it's in linux-next, and you _KNOW_ it will go to Linus
> this week, and the git id is stable, then we can consider the
> application of it to the stable tree now.

If we use the approach in Nikolay's backport, we can avoid dependency on
any other patch. Basically alternative patching jmp instead of VERW:

+.macro CLEAR_CPU_BUFFERS
+       ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
+       verw _ASM_RIP(mds_verw_sel)
+.Lskip_verw_\@:
+.endm

https://lore.kernel.org/stable/20240226122237.198921-3-nik.borisov@suse.com/

I will send the backports with this approach.

