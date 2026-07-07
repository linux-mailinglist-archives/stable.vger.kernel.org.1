Return-Path: <stable+bounces-272390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PofyF1nCTGoZpQEAu9opvQ
	(envelope-from <stable+bounces-272390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 11:09:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E28719898
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 11:09:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=aSVIX2y8;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272390-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272390-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39EA30947D0
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297738F65C;
	Tue,  7 Jul 2026 09:02:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8138E8BE;
	Tue,  7 Jul 2026 09:02:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414956; cv=none; b=Uq7f6qJ/i55vBuMccAxZHf8WteAff7FEtkA4zZWZI2llLmLnKb8DeQJ1VCbBtEEvZDZgVtuWFT+JOl9YxgxFf+86YJrjmlv8WkMxSu2cWmmK010C9pEO2SceUVh+FsC6tbeYW37TEHyNhrYk2ZckAghqILQwrLZfqMXZUHtgjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414956; c=relaxed/simple;
	bh=+e+ez9ewvt0ECIJbO/nKkoaBW6MIulXZo8Sc0cbiZro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3pP9IvR4L9kK+rI60ocOBapgTL7MvGp+kbmeZqP53Udd4jLkAV0eq1gLuZ9bTMr40qt5B8DWDDNp2LzZrj+JgpyUcPYSR6jyVWYdb0YTkgeoDMrW9de+bsSaZW1IC13zfsrm2C7vHfCKVj1qBjKATWfF7Sl+aUTpAArqV5QTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aSVIX2y8; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783414954; x=1814950954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+e+ez9ewvt0ECIJbO/nKkoaBW6MIulXZo8Sc0cbiZro=;
  b=aSVIX2y82vo8zUehaNLOFqJZMoO9vBnkE+eNn7QOTqaUtyz04SoP7+uS
   0RTgQI0ioH6VqeXP23mIgXnhmyRMMBLmarJhYTCxhhaoQ2n8/75Szn09K
   sIB541Pkep+ctcSUxA7QkJNXFC2+wOKaTWrzDsfSrF7yk/k4TmkK68NXm
   D/YV0jOpVc2EIVGGIJIiSBUIPOHDOZPEMIrq50CNlIYV+3wGO0+/GBwLi
   Fa0e0/02s2z3Uf4318VHzc4jxt+QMkV1TMsiZNja4r8i1ZK9SkY/OeVce
   344VctyS2sjGOybhGMK5Pu66GRFEZgRGNS84LMa+aZqquA1ztBtNL4sV3
   A==;
X-CSE-ConnectionGUID: c1lhTsPCTm62uOstoLfd8Q==
X-CSE-MsgGUID: 0+cw6w5vSvGcuY7DohtSLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94702511"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94702511"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:02:33 -0700
X-CSE-ConnectionGUID: hZsRr+XZRJuF1HByaaTvcA==
X-CSE-MsgGUID: VTWvL/QdTue5Ae6n9N3UMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252871119"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.178])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:02:31 -0700
Date: Tue, 7 Jul 2026 12:02:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Adin, Menachem" <menachem.adin@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	lkp <lkp@intel.com>
Subject: Re: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Message-ID: <akzApAxptnbNwg_y@ashevche-desk.local>
References: <20260706-fix_type_le-v2-1-586826351454@intel.com>
 <2026070608-reformat-pungent-aeb4@gregkh>
 <CY5PR11MB63665C97B337ACAC21A8A626EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
 <akypBhzJdxGLJiYq@ashevche-desk.local>
 <2026070722-zips-outgrow-ee43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070722-zips-outgrow-ee43@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272390-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:alexander.usyskin@intel.com,m:arnd@arndb.de,m:badal.nilawar@intel.com,m:linux-kernel@vger.kernel.org,m:menachem.adin@intel.com,m:stable@vger.kernel.org,m:lkp@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1E28719898

On Tue, Jul 07, 2026 at 10:47:42AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 07, 2026 at 10:21:42AM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 07, 2026 at 06:43:20AM +0000, Usyskin, Alexander wrote:
> > > > On Mon, Jul 06, 2026 at 04:01:30PM +0300, Alexander Usyskin wrote:

...

> > > > > Cc: stable@vger.kernel.org
> > > > 
> > > > Why cc: stable?  It doesn't actually cause any functional change to the
> > > > code at all, right?  This isn't running on s390, or am I mistaken?
> > > 
> > > This driver is for discrete graphics card, so it may run on non-x86 system, thus all conversions.
> > > 
> > > I've been told that if there is Fixes: for commit that already in stable, I should cc: stable.
> > > If it is not hard rule, I'll drop cc: from the next patch revision.
> > 
> > Cc'ing stable@ is a rule which is documented in-tree. Many developers just omit
> > it for unknown reasons.
> 
> My point is that this is NOT an actual bugfix that needs to be applied
> anywhere except during the next merge window, as all it does is make
> sparse quiet (which is a valid change).  It doesn't do anything "real"
> as this hardware is not on any big-endian systems.

I was not objecting that. My comment was regarding to "if it's not a hard rule".

> Please don't send stuff to stable that does not actually need to be in a
> stable kernel tree.

Fully agree.

-- 
With Best Regards,
Andy Shevchenko



