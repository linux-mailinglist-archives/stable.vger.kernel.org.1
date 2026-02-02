Return-Path: <stable+bounces-213056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICXgAgeDgGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:57:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD4CB4FC
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68689305CF6C
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0053570B2;
	Mon,  2 Feb 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n56N27PV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C472359707
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029475; cv=none; b=a9Oo0ObiIbrDUx5rZRo4uh2i59muwKEewCQ0AMZnGmcAWQIdR98mwe4pyrYO2XBh1nmW0l+8q0mff1E1sYJZmQqf5mrnK6hk325/ArgJFIi13aA9u6V8DMkG0daEx2VUo+UA6JzG55g06zYWqVTOw0iTTc/dMZOS4jiZLYE5uPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029475; c=relaxed/simple;
	bh=CU+EqcrQo41HxY+mJmIJYrt/CzhgHVJ/Cwyd+zcgbdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4V2XOm71p53kFP72f1NcozLTMXPcaQFDQtb+HRdQ/uPrAV4RXfbEXayMvGcFTHwWkAGm3I83Tdn2XP29aD13A+FetklDucLx0au4rLx1R6yzhHBt1M3ks5bRphKWZD8yVfRKSFlz9hikhjWEyyk77ofhkxG8McpaQPMZ32xJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n56N27PV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770029473; x=1801565473;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CU+EqcrQo41HxY+mJmIJYrt/CzhgHVJ/Cwyd+zcgbdA=;
  b=n56N27PVh0cgzbZcUhfmZU9HMOAo4iu299+5vsUi2EBBBAug9f4y11n5
   BqeR+ccVc+jmgyvUUT2jHId9v1PHrwS9WCVwRIUQyYBDhXxxSAl1aAB4M
   pGgV8pbyzqms2Yr+t6MQtCx5n0dSauIeZMBYFbWINGYBfFnHSaDAsOCkf
   sWCTJ9vB8CLlkjW1HtGRWCYYxO8W/HKbCgoXfMv72TuliObPcBQj4kISV
   dT5YNnaZoYRX/1Lzj1TbXkl6Att7A1rMlCJAEivmY8EpyTW/zDAcbJWi0
   FNblFLATI69hrfCN0HrgLOj5aUz/TMe6aK5Pgb5HDO1pf+iOg10ss/pVR
   Q==;
X-CSE-ConnectionGUID: 6yHzOLr1TL2WKuQn+OeN0w==
X-CSE-MsgGUID: DQlIaLtLSx+47ZxGJ5swIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81497362"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="81497362"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 02:51:13 -0800
X-CSE-ConnectionGUID: bdUGNwPTRgCA1JyWkJ5CRQ==
X-CSE-MsgGUID: VxeTC3hDSnaok3tgirY+DQ==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO [10.245.244.223]) ([10.245.244.223])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 02:51:10 -0800
Message-ID: <6a6e054bb6efe76c439b3329702829dbc75b9060.camel@linux.intel.com>
Subject: Re: [PATCH] mm/hmm: Fix a hmm_range_fault() livelock / starvation
 problem
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>,  Andrew Morton <akpm@linux-foundation.org>,
 intel-xe@lists.freedesktop.org, Ralph Campbell <rcampbell@nvidia.com>, 
 Christoph Hellwig	 <hch@lst.de>, Jason Gunthorpe <jgg@mellanox.com>, Jason
 Gunthorpe <jgg@ziepe.ca>,  Leon Romanovsky	 <leon@kernel.org>,
 linux-mm@kvack.org, stable@vger.kernel.org, 	dri-devel@lists.freedesktop.org
Date: Mon, 02 Feb 2026 11:51:08 +0100
In-Reply-To: <nm4qa6fz2kecodhtt7yfcnfx77ik7pr7332amfqvgyhgs5xwqf@v2v6coz5genz>
References: <20260130144529.79909-1-thomas.hellstrom@linux.intel.com>
	 <20260130100013.fb1ce1cd5bd7a440087c7b37@linux-foundation.org>
	 <57fd7f99-fa21-41eb-b484-56778ded457a@nvidia.com>
	 <2d96c9318f2a5fc594dc6b4772b6ce7017a45ad9.camel@linux.intel.com>
	 <aX5RQBxYB029/dkt@lstrano-desk.jf.intel.com>
	 <0025ee21-2a6c-4c6e-a49a-2df525d3faa1@nvidia.com>
	 <a459f147b461c6e6e806282956b7931f74a0aa93.camel@linux.intel.com>
	 <nm4qa6fz2kecodhtt7yfcnfx77ik7pr7332amfqvgyhgs5xwqf@v2v6coz5genz>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213056-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 57DD4CB4FC
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 21:34 +1100, Alistair Popple wrote:
> On 2026-02-02 at 20:13 +1100, Thomas Hellstr=C3=B6m
> <thomas.hellstrom@linux.intel.com> wrote...
> > On Sat, 2026-01-31 at 13:42 -0800, John Hubbard wrote:
> > > On 1/31/26 11:00 AM, Matthew Brost wrote:
> > > > On Sat, Jan 31, 2026 at 01:57:21PM +0100, Thomas Hellstr=C3=B6m
> > > > wrote:
> > > > > On Fri, 2026-01-30 at 19:01 -0800, John Hubbard wrote:
> > > > > > On 1/30/26 10:00 AM, Andrew Morton wrote:
> > > > > > > On Fri, 30 Jan 2026 15:45:29 +0100 Thomas Hellstr=C3=B6m
> > > > > > > <thomas.hellstrom@linux.intel.com> wrote:
> > > > > > ...
> > >=20
> > > >=20
> > > > > I'm also not sure a folio refcount should block migration
> > > > > after
> > > > > the
> > > > > introduction of pinned (like in pin_user_pages) pages. Rather
> > > > > perhaps a
> > > > > folio pin-count should block migration and in that case
> > > > > do_swap_page()
> > > > > can definitely do a sleeping folio lock and the problem is
> > > > > gone.
> > >=20
> > > A problem for that specific point is that pincount and refcount
> > > both
> > > mean, "the page is pinned" (which in turn literally means "not
> > > allowed
> > > to migrate/move").
> >=20
> > Yeah this is what I actually want to challenge since this is what
> > blocks us from doing a clean robust solution here. From brief
> > reading
> > of the docs around the pin-count implementation, I understand it as
> > "If
> > you want to access the struct page metadata, get a refcount, If you
> > want to access the actual memory of a page, take a pin-count"
> >=20
> > I guess that might still not be true for all old instances in the
> > kernel using get_user_pages() instead of pin_user_pages() for
> > things
> > like DMA, but perhaps we can set that in stone and document it at
> > least
> > for device-private pages for now which would be sufficient for the
> > do_swap_pages() refcount not to block migration.
>=20
> Having just spent a long time cleaning up a bunch of special
> rules/cases for
> ZONE_DEVICE page refcounting I'm rather against reintroducing them
> just for some
> ZONE_DEVICE pages. So whatever arguments are applied or introduced
> here would
> need to be made to work for all pages, not just some ZONE_DEVICE
> pages.

That's completely understandable. I would like to be able to say if we
apply the argument that when checking the pin-count pages are locked,
lru-isolated and with zero map-count then that would hold for all
pages, but my knowledge of the mm internals isn't sufficient
unfortunately.

So even if that would be an ultimate goal, we would probably have to be
prepared to have to revert (at least temporarily) such a solution for
!ZONE_DEVICE pages and have a plan for handling that.

Thanks,
Thomas


>=20
> > >=20
> > > (In fact, pincount is implemented in terms of refcount, in most
> > > configurations still.)
> >=20
> > Yes but that's only a space optimization never intended to
> > conflict,
> > right? Meaning a pin-count will imply a refcount but a refcount
> > will
> > never imply a pin-count?
> >=20
> > Thanks,
> > Thomas
> >=20

