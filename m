Return-Path: <stable+bounces-23861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD3868B99
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A989F1C2299D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE86130E48;
	Tue, 27 Feb 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgz7d91t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC855E78
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024706; cv=none; b=CwdTNmGGcDD15m2y1+b4D/Zp2HeSjStre5SXNeiuloPJ8+2rrH0pFUSYSlmgaYkG9kYB/enweIYYBBX7smQjrHNwwbKfqt5OY5/W6oelwLvevO/ks2C8PbqK9nsiHtj0qM7eiRbnUlX0s0U1KeLiXwLmKXMcY9B1sba3Rg3bGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024706; c=relaxed/simple;
	bh=bZ6gGQP2OTTZgnlvkymmgj6TYlUQ/gv5UiQh+pXz5v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJkXH1bDOMv7k/0nFWowFQMtNNjwiwEjlSM0jXtoainb4pUyxYKzJOD5J+Ma+iWCgImu9bjUYNyFaQ1o4kgthppJvXAwzwtXWVB/S+lB6gTiOQAQ1pUgWU2ohchYgv/l78rK7c7qyrGBbEDzkCZlNI5hsShSqedXvL4yt7mDrZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cgz7d91t; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709024705; x=1740560705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZ6gGQP2OTTZgnlvkymmgj6TYlUQ/gv5UiQh+pXz5v0=;
  b=Cgz7d91tVW4qrumDnc2WimGIpEz/sZ+EHH3Euc8ze59BBXLM6FP++vZJ
   ya/3i8ACx42Ze61apU4byKL4N8gvD7JmS5JLnKO1HeVdvudp+UoQkgYk3
   dcMV33VSNlGzS+JRtIU47jCgjAo6fqupr8tPxBt2mlCT4rJKZQXQGPEIA
   slnG3XunKDpZ6aOFty7D8duoGIYd1oI2OPgoMTmutFGakecN1X/0JWHgU
   5gaomeGDB7lVjBvfujjLpUB2t4AyPIA8e96G1goUEtqGv6GSCTtYeWeMD
   NwRyKMFF7vd69YR+2ASK6wDb2558ILE5xK7Nq7kk1OPXeVlXxgh+gJQlR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="13994923"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="13994923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6938401"
Received: from akonar-mobl.amr.corp.intel.com (HELO desk) ([10.209.73.210])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:05:02 -0800
Date: Tue, 27 Feb 2024 01:05:00 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.6.y 0/6] Delay VERW - 6.6.y backport
Message-ID: <20240227090500.hfuo546w4cuio762@desk>
References: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>
 <2024022740-smugness-cone-e80c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022740-smugness-cone-e80c@gregkh>

On Tue, Feb 27, 2024 at 09:54:00AM +0100, Greg KH wrote:
> On Mon, Feb 26, 2024 at 09:34:14PM -0800, Pawan Gupta wrote:
> > This is the backport of recently upstreamed series that moves VERW
> > execution to a later point in exit-to-user path. This is needed because
> > in some cases it may be possible for data accessed after VERW executions
> > may end into MDS affected CPU buffers. Moving VERW closer to ring
> > transition reduces the attack surface.
> > 
> > Patch 1/6 includes a minor fix that is queued for upstream:
> > https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/
> 
> Obviously I can't take this, you know that :(
> 
> Please include the actual commit in the series, when it hits Linus's
> tree.

Backports to 6.6 and 6.7 will work without the commit waiting to be
upstreamed.

> I'm dropping all of these backports from my review queue, please resend
> the fixed up series when they are ready.

I will resend 6.6 and 6.7 without this change:

  https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/

