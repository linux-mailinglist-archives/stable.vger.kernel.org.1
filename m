Return-Path: <stable+bounces-262802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XdjxI4EcK2pZ2wMAu9opvQ
	(envelope-from <stable+bounces-262802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 22:37:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA0675363
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 22:37:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fb1rMS3q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262802-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262802-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16AB1310AAB3
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 20:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3B4963D9;
	Thu, 11 Jun 2026 20:37:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207D3A963D;
	Thu, 11 Jun 2026 20:37:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210223; cv=none; b=kf9n6qGh9c6klJX2qVQP8loFiguKMmXWxrgOIunFR6oqJbhrX3RNXXfKgAASqOjI7FhKTBOOf3g9oCd6xMksFLW43eapFBjECmnTVUinHcnLe3CQI4LLyTD0wxQ505qPXb8KDMuqIVbVdMgUQCV7ZLxsdPOXQDTqP8OFpyfwI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210223; c=relaxed/simple;
	bh=zmuYxNoO49Z6dGqQN/+hEW9eG9UPTi7S93B8ZJn4NeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1tLNjt537tXALJPFvr1viUNnquEtF6NNstOcWyxxAQByaZQB9PSsJQeGcfum4EMvCtiwYUcYMPnJIAtBM53/tWw5PryyO9lyzVum9H+TBTax9v/9yB9dBmDqJ7S6RPkmrEi4zst7JS29fwyLVs/py4TipN/u3go7FfI8ndZDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb1rMS3q; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781210223; x=1812746223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmuYxNoO49Z6dGqQN/+hEW9eG9UPTi7S93B8ZJn4NeE=;
  b=fb1rMS3qXC6vZqv/HaW71uiFkF/BFwfT5aBEIvVR0mXF5C8XJCVDakR6
   UOv3G4/OfaTdKu6uqr1YZRBtZSKmrX82pnGJAEvepYqbw2fM19zHALQRG
   ZA0bGq/CGtlv6tKzZdF/3Ik+rQp5zFafNyTb5vHThKFsKkas5hZtQSQOX
   P62OLY+Wyd2Xb3Ru+Qj+II4rRHLAWDILrJmI5MzFfTjeNGNcI0KuWeBtc
   Iu8pj5ZjLTxgorxk65y5fs6h32sQB3oIrUB74yhM50GBEZwUP3MwmujVx
   LZ4mc+jnp+nt2ZcLj13QREZhbHuoYNolR0S617VbRc6ZWCNTbZpG0KJmo
   g==;
X-CSE-ConnectionGUID: BRRYky2NTz2zS1P0D6THXQ==
X-CSE-MsgGUID: qRHDiYwjSmegU+V4D6G45g==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69582204"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="69582204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:37:02 -0700
X-CSE-ConnectionGUID: ZV91wnH5RzScDS+Uy4+6qg==
X-CSE-MsgGUID: fAtgtQsvQAye6Wjrn18a2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="248498299"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 13:36:59 -0700
Date: Thu, 11 Jun 2026 23:36:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yang <xu.yang_2@oss.nxp.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <aiscaI0B4ogb15T7@ashevche-desk.local>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
 <aiLmN2yUsqLadbSo@ashevche-desk.local>
 <aiLw0bLKiipMCZC5@ashevche-desk.local>
 <i7jdx4j4kd6dcntitqrcz74d47wfqv5iwc3zdlwx7rs7xoykql@ivj6mxr2zyva>
 <aipsAxc4j68D2YCz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aipsAxc4j68D2YCz@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262802-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xu.yang_2@oss.nxp.com,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org,kernel.org,ideasonboard.com,vger.kernel.org,lists.linux.dev,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:from_mime,ashevche-desk.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05CA0675363

On Thu, Jun 11, 2026 at 11:04:25AM +0300, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 10:41:45AM +0800, Xu Yang wrote:
> > On Fri, Jun 05, 2026 at 06:52:49PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 05, 2026 at 06:07:41PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Jun 05, 2026 at 06:31:16PM +0800, Xu Yang wrote:
> > > > > This series fixes two issues in the fwnode child iteration logic when
> > > > > a secondary fwnode is present.
> > > > > 
> > > > > The first issue is  a refcount imbalance in software_node_get_next_child().
> > > > > When a software node is used as a secondary fwnode, the iteration code may
> > > > > incorrectly decrement the refcount of child nodes that do not belong to the
> > > > > software node hierarchy. This results in refcount underflow and possible
> > > > > use-after-free.
> > > > > 
> > > > > The second issue is an infinite loop in fwnode_for_each_child_node(), caused
> > > > > by improper handling of iteration state across primary and secondary fwnodes.
> > > > > When iterating over children from both primary and secondary fwnodes, the code
> > > > > may incorrectly resume iteration from the primary fwnode even when the current
> > > > > child belongs to the secondary, leading to repeated traversal and a loop.
> > > > > 
> > > > > Both issues are triggered when mixing different fwnode types through the
> > > > > secondary mechanism, and stem from incorrect assumptions about ownership
> > > > > and traversal context of child nodes.
> > > > 
> > > > > ---
> > > > > Changes in v3:
> > > > > - remove software node patch 
> > > > 
> > > > Hmm... Maybe I was unclear. My question was to investigate the way to actually
> > > > move software node to use the swnode APIs (and not fwnode ones) and be on par
> > > > with what OF code does. This series does the opposite and adds a hack to the
> > > > next_child implementation.
> > > > 
> > > > > - add a kunit test case suggested by Andy Shevchenko
> > > > 
> > > > But thanks for the test case!
> > > 
> > > I'm preparing another patch (just a clean up) and I see that your test cases
> > > indeed fail without any other patch being applied. Also noticed that the test
> > > cases are not fully compliant with the requirement of the "primary"/"secondary"
> > > fwnode flavours. But this doesn't affect the execution.
> > > 
> > > I will play more with this to understand the problem better.
> > 
> > OK. Suggestions on the fwnode flavours would be appreciated :)
> 
> I think your approach is what we should go with. I will send a v4 with my tags
> and some amendments.

I sent a v4 here:
20260611203537.1786399-1-andriy.shevchenko@linux.intel.com
Please, test and confirm it also works for you as expected.

-- 
With Best Regards,
Andy Shevchenko



