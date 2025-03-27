Return-Path: <stable+bounces-126873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A53A7350C
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E793172DAD
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E92185BD;
	Thu, 27 Mar 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCfR81V5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6305C603;
	Thu, 27 Mar 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087349; cv=none; b=gLoCpjL9e0la1E2Z4VvmZEJaNv2PQhVpETMf542KsN9lgw2rXR9g6icMQHnfryJwsFF+7qGY8WQTXbxvw7eDV5TaTpR1g4Ci144Jc1YCNFh6d/WlFWWo8SUlsvJIL1GycdxU4FvZJ+IYTePsLpq22ORlXAah4NBL7Njv4iSyIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087349; c=relaxed/simple;
	bh=O+fF0T1K8ENoKQc8U/kUz5mudOhbJ4KqLrmWLy8Gx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvFFZI8OBCmraWbvvZeDLOHZVwiHyDxQvrhcP6KbghyLDzUOAmLvVvvNMTf6V990dpoWf15tN/mw90sT3STZJTubMmURbAmEEhLceZBFAYkDsDAahoM/UfcMlx44ZGKejKAjhnfy3MbicN4TMxw0HEqqFLjqimkfL2bHslD0Rl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCfR81V5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743087348; x=1774623348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+fF0T1K8ENoKQc8U/kUz5mudOhbJ4KqLrmWLy8Gx68=;
  b=jCfR81V5Z3Ya9pBfIEPAdBOJ2waHOATlVLW/g1MQ7lxrCkrg8GlkKztI
   RaEKYU+25DRHDAGTH0EvDxj31nlQ82oZuuy7B3OHr6ukicFetuGR06X39
   W8FGtuPGBWYUyFpLbz/xRpKVDHIw52S2vpRJHm1fFBEhwFmZj2FM8apVD
   O9ARy3DFRc3/F9Brnz7AjImabtMXNmkntD4PvFh/G+5VDyAr6YIqzufY7
   NZxHaBz0itJQe+fErLhhiymK1qDmGHY0kEvUemt339HMoDl7o/H59bBaC
   NUskM5IXc28OUZq7KNyL57qm8R5NC1s8w6/sM2/yxIv6PutymZtO18Zf3
   A==;
X-CSE-ConnectionGUID: fYYDA3tTQc6GOZb4oV+2zg==
X-CSE-MsgGUID: 38b+GzfqRoeApe8vHzNaPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44342591"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44342591"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 07:55:47 -0700
X-CSE-ConnectionGUID: w6/uUPDzQ22W/58VoYQrmA==
X-CSE-MsgGUID: mbijv60mSXS2SPK0EiC98g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="130231181"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 27 Mar 2025 07:55:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 64B461CA; Thu, 27 Mar 2025 16:55:43 +0200 (EET)
Date: Thu, 27 Mar 2025 16:55:43 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] thunderbolt: do not double dequeue a request
Message-ID: <20250327145543.GC3152277@black.fi.intel.com>
References: <20250327114222.100293-1-senozhatsky@chromium.org>
 <20250327133756.GA3152277@black.fi.intel.com>
 <vxocwwtfwg3tmjm62kcz33ypsg22afccd2ua5jqymbxaxwcigf@nnydc53vu3gv>
 <20250327142038.GB3152277@black.fi.intel.com>
 <jdupmjvntywimlzlhvq3rfsiwmlox6ssdtdncfe3mmo3wonzta@qwlb3wuosv66>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jdupmjvntywimlzlhvq3rfsiwmlox6ssdtdncfe3mmo3wonzta@qwlb3wuosv66>

Hi,

On Thu, Mar 27, 2025 at 11:37:35PM +0900, Sergey Senozhatsky wrote:
> On (25/03/27 16:20), Mika Westerberg wrote:
> > > On (25/03/27 15:37), Mika Westerberg wrote:
> > > > > Another possibility can be tb_cfg_request_sync():
> > > > > 
> > > > > tb_cfg_request_sync()
> > > > >  tb_cfg_request()
> > > > >   schedule_work(&req->work) -> tb_cfg_request_dequeue()
> > > > >  tb_cfg_request_cancel()
> > > > >   schedule_work(&req->work) -> tb_cfg_request_dequeue()
> > > > 
> > > > Not sure about this one because &req->work will only be scheduled once the
> > > > second schedule_work() should not queue it again (as far as I can tell).
> > > 
> > > If the second schedule_work() happens after a timeout, that's what
> > > !wait_for_completion_timeout() does, then the first schedule_work()
> > > can already execute the work by that time, and then we can schedule
> > > the work again (but the request is already dequeued).  Am I missing
> > > something?
> > 
> > schedule_work() does not schedule the work again if it is already
> > scheduled.
> 
> Yes, if it's scheduled.  If it's already executed then we can schedule
> again.
> 
> 	tb_cfg_request_sync() {
> 	 tb_cfg_request()
> 	   schedule_work()

This point it runs tb_cfg_request_work() which then calls the callback
(tb_cfg_request_complete()) before it dequeues so "done" is completed.

> 	                        executes tb_cfg_request_dequeue

> 	 wait_for_completion_timeout()

so this will return > 0 as "done" completed..

> 	   schedule_work()
> 	                        executes tb_cfg_request_dequeue again

..and we don't call this one.

> 	}
> 
> I guess there can be enough delay (for whatever reason, not only
> wait_for_completion_timeout(), but maybe also preemption) between
> two schedule_work calls?
> 
> > > The 0xdead000000000122 deference is a LIST_POISON on x86_64, which
> > > is set explicitly in list_del(), so I'd say I'm fairly confident
> > > that we have a double list_del() in tb_cfg_request_dequeue().
> > 
> > Yes, I agree but since I have not seen any similar reports (sans what I saw
> > ages ago), I would like to be sure the issue you see is actually fixed with
> > the patch (and that there are no unexpected side-effects). ;-)
> 
> Let me see what I can do (we don't normally apply patches that
> were not in the corresponding subsystem tree).
> 
> In the meantime, do you have a subsystem/driver tree that is exposed
> to linux-next?  If so, would be cool if you can pick up the patch so
> that it can get some extra testing via linux-next.

Yes I do, see [1] but it does not work like that. First you should make
sure you patch works by testing it yourself and then we can pick it up for
others to test.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/

