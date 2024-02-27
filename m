Return-Path: <stable+bounces-23853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0A868B6D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFCC1C208BC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF53133419;
	Tue, 27 Feb 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erwuH97k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A3131734
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024203; cv=none; b=fT7JH9p/95SOe6FWF9LukQ2NpJsvVV/fJAF0Pkd0ObsBrKDLrteAzBA8MnFHk0CSi00VWYbkAjfZmJhORdtBUYSKJZMxQLLb7zA8K94yrkUEudLu81+a3jWL/Wj4O/nMbVihBstEqY12W5YnR5kgtDx/9Atpjwdl2Fe9MAoryv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024203; c=relaxed/simple;
	bh=//AlDGAujOrB8DiEw4WkuP5J0mRMKGNqykkasq8g59U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh8sNdQBwRLVpFBllmxQOwL80oWuavNB4z+0AmKKIAjLP5ui541wycE/Oa23ThmKRW+JhfSkV+j5lHvb5wvM5vlzNKPhKI/AAt0XoApQ/MbvZMmsL1WpC+K0Mf2jkD+/pePjHLKsKorEglhTkfBmpebWSU3V3UHqAdfD8yEihlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erwuH97k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709024201; x=1740560201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//AlDGAujOrB8DiEw4WkuP5J0mRMKGNqykkasq8g59U=;
  b=erwuH97kjQfVkb7bNMLHI4X/vHCd2AsHu8j4G2eh+RcoOe3OsBDVfknV
   wwvesvPZBffpzDVxzhOx+fTpZJApnRc5MaPAV6GxBnsstyWVGsJIU1Yjx
   2E+4ZdCccwHMMfA9kdOAL4Ez5553btPijjwr9K7XgkG0NCDnQSlnSGZfo
   1mZEtgV6oMJxS9soToKu24gJGX/KWBK0//xJPKO1WDHkMOgeGPPjRSsik
   NeatwU3+9ydIwbmkb4vzJ+R/G+/2gwKN1WXksGIBJzdJxkxcYys7LSUPu
   RxsX4TYP/YQCzGl494eLFZpIqtLuUO4LGeo2np3yhFOoAOhwwcqhD/kix
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="28794068"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="28794068"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11637061"
Received: from akonar-mobl.amr.corp.intel.com (HELO desk) ([10.209.73.210])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 00:56:41 -0800
Date: Tue, 27 Feb 2024 00:56:38 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.1.y 0/6] Delay VERW - 6.1.y backport
Message-ID: <20240227085638.plb5gvunrjqgj7yp@desk>
References: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
 <7f75bfa1-03a1-4802-bf5d-3d7dfff281c2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f75bfa1-03a1-4802-bf5d-3d7dfff281c2@kernel.org>

On Tue, Feb 27, 2024 at 09:21:33AM +0100, Jiri Slaby wrote:
> On 27. 02. 24, 9:00, Pawan Gupta wrote:
> > This is the backport of recently upstreamed series that moves VERW
> > execution to a later point in exit-to-user path. This is needed because
> > in some cases it may be possible for data accessed after VERW executions
> > may end into MDS affected CPU buffers. Moving VERW closer to ring
> > transition reduces the attack surface.
> > 
> > Patch 1/6 includes a minor fix that is queued for upstream:
> > https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/
> 
> Ah, you note it here.
> 
> But you should include this patch on its own instead of merging it to 1/6.

Thats exactly what I would have done ideally, but the backports to
stable kernels < 6.6 wont work without this patch. And this patch is
going to take some time before it can be merged upstream.

> You might need to wait until it is in linus' tree, though.

Ok will wait.

