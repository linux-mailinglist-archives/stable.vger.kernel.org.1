Return-Path: <stable+bounces-227254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGwfKIrLu2leoQIAu9opvQ
	(envelope-from <stable+bounces-227254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:10:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355622C9469
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F293143BDE
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF86377EB5;
	Thu, 19 Mar 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwA7qTyj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3973BD63F
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914548; cv=none; b=NukE4RYlpwjvQYv/lYZPvRMxG/Bt5xbViTj2+5WhDBkZhLyCPx6YHRKgMI45rhhVlKprqEOTiLOm3jimobt3WGLzrQH4sjE6yQrtL5zu70awEw+wuCixb2ujqQV5/TTIkiH4qR2uXgzwelxQ1wlZQBGW82Fr7A7bc+IPfSFJoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914548; c=relaxed/simple;
	bh=RPvAUzkCv/Pg1fjsxwFvMt7kmQMeT2lgZoA0riWocrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P7Z3UK2szp7VdcShGewksj9ngD7+0yjjiWcw/V4BQxE/tfxmWMqxNkGApFBFDU9s8+8EUXn3vUn/pQnCqlg8CjLKgwQuvk57unWtiX82yJx8YBRimpVJ1UpB2g1XtuGnee1iEF8g3P59gqJ8PluDz6NG1aVTNRHKGYlZMIAFfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwA7qTyj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773914544; x=1805450544;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RPvAUzkCv/Pg1fjsxwFvMt7kmQMeT2lgZoA0riWocrA=;
  b=KwA7qTyjXbYYgG0jn1Xj7X01JevOxheDkBTDV7X9+WF15Hmulj20U3lJ
   nXJ8ddmp9OZmuJVjnORIbUU9lQ0zQpotj9Zs6zeyABcGvmwcrGTkpUMY1
   nS4mdtNYZ8D3PagMSxt2TUFD+tSc1aTb1HEWANK7vt/Z2RyIqsSkWAAMa
   dl68odTn/H2i0ZS9xjG0qfbsCvoLehf8P1kyjr0THBrLYkOc3wjh/T5K4
   JD+3FuUVzR5SlmoNarFaeTz8+Tkcf3rirh0/9ktjMUULIbPxFPBAizzFR
   /cSfcWWo7oJGh6/sIXNwcQ3Z8bti1CWCNiqxzNgA4R3y6BLsWYrqYYv1b
   A==;
X-CSE-ConnectionGUID: hVbMzo6cQqmCvD4ehvfNLw==
X-CSE-MsgGUID: yUP/SGe7RO+GPKM6KGk7pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86343480"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="86343480"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 03:02:23 -0700
X-CSE-ConnectionGUID: A09ByfiZQamABRDREZboHw==
X-CSE-MsgGUID: PEsfxwSjRTe84v9y6cuxPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218840320"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO mwiniars-MOBL.ger.corp.intel.com) ([10.245.246.121])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 03:02:21 -0700
Message-ID: <60a007aeebab10377b66951d958e711ae89e573a.camel@linux.intel.com>
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Will Deacon	
 <will@kernel.org>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pasha Tatashin	 <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja	 <skhawaja@google.com>, stable@vger.kernel.org
Date: Thu, 19 Mar 2026 11:02:18 +0100
In-Reply-To: <ed985e72-dbfe-4d60-b5f1-581ba58e3c18@arm.com>
References: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
	 <13e28ac2-a4d6-466a-aef2-7b3d7d9167bd@arm.com>
	 <20260303130420.GB972761@nvidia.com>
	 <ed985e72-dbfe-4d60-b5f1-581ba58e3c18@arm.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-227254-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[janusz.krzysztofik@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: 355622C9469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, 2026-03-03 at 15:56 +0000, Robin Murphy wrote:
> On 2026-03-03 1:04 pm, Jason Gunthorpe wrote:
> > On Tue, Mar 03, 2026 at 12:53:28PM +0000, Robin Murphy wrote:
> >=20
> > > > Further, there are several callers that can trigger empty gathers,
> > > > especially in unusual conditions. For example iommu_map_nosync() wi=
ll call
> > > > a 0 size unmap on some error paths. Also in VFIO, iommupt and other
> > > > places.
> > >=20
> > > My instinct is still to tidy up the 0-length unmap case(s), but I gue=
ss
> > > iommu_iotlb_sync() is itself also a public API where being more robus=
t
> > > against erroneous usage is no bad thing.
> >=20
> > I also wanted to do that but found enough problematic cases I lost
> > confidence I could reliably catch them all..
>=20
> I reckon an early "if (!size) return 0;" in iommu_unmap() would suffice=
=20
> to cover the internal error cleanup paths and most careless external=20
> users. However if we don't trust iommu_unmap_fast() users to always do=
=20
> the right thing either then we want this check in iommu_iotlb_sync()=20
> anyway, at which point the iommu_unmap() check would really only serve=
=20
> to skip a bit more unnecessary work on error cleanup paths, and do we=20
> really care about optimising errors? Hence I'm satisfied that this patch=
=20
> does in fact seem to be the best option.

Is this patch going to be applied soon to one of your branches? I'm=C2=A0
waiting for that to happen because I want to cherry-pick it and propose as=
=C2=A0
a temporary fix to be applied to our core-for-CI sub-branch of drm-tip=C2=
=A0
until=C2=A0the original=C2=A0lands in=C2=A0mainline.

Thanks,
Janusz

>=20
> > > > -	if (domain->ops->iotlb_sync)
> > > > +	if (domain->ops->iotlb_sync &&
> > > > +	    likely(iotlb_gather->start < iotlb_gather->end))
> > >=20
> > > Elsewhere we just use "gather->end !=3D 0" as the "non-empty" conditi=
on; how
> > > concerned are we about defending against more-intentionally malformed
> > > gathers here?
> >=20
> > I choose this deliberately to protect the driver, a malformed gather
> > that is 0 sized, or negative sized looks like it will have Weird
> > Things happen in drivers.
> >=20
> > We could further classify the < and WARN_ON the malformed cases, but I
> > don't want to pass negative sized gathers into drivers. We'd probably
> > also have to de-inline the function if more is added. Do you have a
> > preference?
>=20
> No, that's fine, I just wanted to confirm the intent - this isn't a=20
> place where we should need to be concerned about micro-optimising to=20
> maybe save a load and an extra ALU op or two, just that I don't think=20
> it's worth doing any more than strictly necessary for our own=20
> robustness. Thus there's no need to change the check in=20
> iommu_iotlb_gather_is_disjoint() either, as that now just serves to skip=
=20
> the redundant reinitialisation of an already-empty gather, which is=20
> justifiably a different thing from the actual validity-of-sync condition=
=20
> anyway.
>=20
> Cheers,
> Robin.

