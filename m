Return-Path: <stable+bounces-126866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B28A7343D
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EFE16C908
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0421766A;
	Thu, 27 Mar 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFTd+GoG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8121422C;
	Thu, 27 Mar 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085244; cv=none; b=YJzogbY9Hf7u1qnlTMbb8vfs4f59QpxOUAMyVQUmaf8GHJO9Wsf/X8+EnTrvNVC+ICMbk9Zox9nr9r30yfsyW1z7iRt1YvcC6IG5fiTZbQZDXM3bATRJ+7KTbwe+dKVOfzrYgKG2CxN7n17H/icSTRuRw/YN8XuWWBs6r6jm7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085244; c=relaxed/simple;
	bh=Kp8tmG94C1NlHRTeGN7AQJ/wzvfSetrtkc7dV9pp+ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWLjIEMHBe8e/g+IOsUa08CLcfWpf5aT5Mbr/pdOFTr6YI9zwyNUqzhyx/bNMXT44NqrV9tbGWIps7ojGukSRyaaTDR4qZ6vkSDbeNR9lkFW5TKbTJ8Vad9h+01zYfToVOjXBGHExclXTc0YtBq/n3fSIXV9D5Imir+OhuYqBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFTd+GoG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743085243; x=1774621243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kp8tmG94C1NlHRTeGN7AQJ/wzvfSetrtkc7dV9pp+ug=;
  b=gFTd+GoGMeXyZtvTp1U6ciegvFIpE62SPhMe9Jas80cJmQs9akocR5Tp
   pqadrkmq/4CNWG3DwOf757SsH0uaeyYltVryB8wezbANSS3AsZqKJtg+r
   i9BphNyCAbJvGqHNW246Ogc9MKURDom7hlFau/njFn7yXyyjiqhcsQ5z/
   jH0qVZ7Nyl082FzPOmK1icMO04YbIQ0sbFA7mMZIXVxEBFAZTc+9VcPyK
   bksFwm2ld2pTvLWnUCylW1S25AE6Nb3gQPKYi961GocwECJnD9nNpDoPK
   AAy11XAoVr1pdK8RWiiiE10DcbF6tsLm0e1kbgUx4X8yVhKVnTmhJZ2n3
   Q==;
X-CSE-ConnectionGUID: dAKc+rYJTt6IE810RwRirg==
X-CSE-MsgGUID: C4SisLOMSnOtz/1R7LSDpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44435719"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44435719"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 07:20:42 -0700
X-CSE-ConnectionGUID: x5QxreAqSqa894qDKsBJ7Q==
X-CSE-MsgGUID: PXo505ySSDCVuk2lWzsCDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="126082271"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 27 Mar 2025 07:20:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id CCAB51D9; Thu, 27 Mar 2025 16:20:38 +0200 (EET)
Date: Thu, 27 Mar 2025 16:20:38 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] thunderbolt: do not double dequeue a request
Message-ID: <20250327142038.GB3152277@black.fi.intel.com>
References: <20250327114222.100293-1-senozhatsky@chromium.org>
 <20250327133756.GA3152277@black.fi.intel.com>
 <vxocwwtfwg3tmjm62kcz33ypsg22afccd2ua5jqymbxaxwcigf@nnydc53vu3gv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vxocwwtfwg3tmjm62kcz33ypsg22afccd2ua5jqymbxaxwcigf@nnydc53vu3gv>

Hi,

On Thu, Mar 27, 2025 at 11:02:04PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> On (25/03/27 15:37), Mika Westerberg wrote:
> > > Another possibility can be tb_cfg_request_sync():
> > > 
> > > tb_cfg_request_sync()
> > >  tb_cfg_request()
> > >   schedule_work(&req->work) -> tb_cfg_request_dequeue()
> > >  tb_cfg_request_cancel()
> > >   schedule_work(&req->work) -> tb_cfg_request_dequeue()
> > 
> > Not sure about this one because &req->work will only be scheduled once the
> > second schedule_work() should not queue it again (as far as I can tell).
> 
> If the second schedule_work() happens after a timeout, that's what
> !wait_for_completion_timeout() does, then the first schedule_work()
> can already execute the work by that time, and then we can schedule
> the work again (but the request is already dequeued).  Am I missing
> something?

schedule_work() does not schedule the work again if it is already
scheduled.

> > > To address the issue, do not dequeue requests that don't
> > > have TB_CFG_REQUEST_ACTIVE bit set.
> > 
> > Just to be sure. After this change you have not seen the issue anymore
> > with your testing?
> 
> Haven't tried it yet.
> 
> We just found it today, it usually takes several weeks before
> we can roll out the fix to our fleet and we prefer patches from
> upstream/subsystem git, so that's why we reach out to the upstream.

Makes sense.

> The 0xdead000000000122 deference is a LIST_POISON on x86_64, which
> is set explicitly in list_del(), so I'd say I'm fairly confident
> that we have a double list_del() in tb_cfg_request_dequeue().

Yes, I agree but since I have not seen any similar reports (sans what I saw
ages ago), I would like to be sure the issue you see is actually fixed with
the patch (and that there are no unexpected side-effects). ;-)

