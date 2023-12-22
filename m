Return-Path: <stable+bounces-8347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F8281CFA0
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 23:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE07D2865E4
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45112EAED;
	Fri, 22 Dec 2023 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRSTo84b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC02EAE5;
	Fri, 22 Dec 2023 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703282522; x=1734818522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXWRQKbGRnLFsCOzz3BQESBgLFNyy944V/y5K7CPsmI=;
  b=PRSTo84bOUEW0cZDqYvd0eMgxApBlnkTmVOQb56ymC7q2OE9/VYqLiDz
   6f558w5L9TU2FnFQc76u56e5CCwVGnHB6T8B2jBODF8x+gjXaLf7wN4PQ
   Uk20ljfry4wPsdZeqyv6vFn/E/H6H8lpDcHk8XG7vRq1ahZlnN7wrpuQW
   on4lTlh4uNv3bw+RBwaFcYgLUom3BipfRik9g+/MUO5KQA1zJ3xH71qBr
   eZkWUPS3Yms1UOiSMjFeHaFam55qJ7/MmVohnrsubrKFT4g9YascTPw0/
   +fA6sVeH5sdwWUDHCOnxeyDNe5vGjUVSZJipKBXIP6HNtZAm6tj8PcKOa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="460490679"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="460490679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 14:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="19147029"
Received: from jbjohns2-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.160.53])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 14:01:59 -0800
Date: Fri, 22 Dec 2023 14:01:57 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] cxl/port: Fix decoder initialization when nr_targets >
 interleave_ways
Message-ID: <ZYYHVVRi1RO9M8y5@aschofie-mobl2>
References: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>
 <ZYXtvKOfnIkGuwOe@aschofie-mobl2>
 <6585fb5cbac83_90f7e2948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6585fb5cbac83_90f7e2948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Dec 22, 2023 at 01:10:52PM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > On Thu, Dec 21, 2023 at 10:12:12PM -0800, Dan Williams wrote:
> > > From: Huang Ying <ying.huang@intel.com>
> > > 
> > > The decoder_populate_targets() helper walks all of the targets in a port
> > > and makes sure they can be looked up in @target_map. Where @target_map
> > > is a lookup table from target position to target id (corresponding to a
> > > cxl_dport instance). However @target_map is only responsible for
> > > conveying the active dport instances as conveyed by interleave_ways.
> > > 
> > > When nr_targets > interleave_ways it results in
> > > decoder_populate_targets() walking off the end of the valid entries in
> > > @target_map. Given target_map is initialized to 0 it results in the
> > > dport lookup failing if position 0 is not mapped to a dport with an id
> > > of 0:
> > > 
> > >   cxl_port port3: Failed to populate active decoder targets
> > >   cxl_port port3: Failed to add decoder
> > >   cxl_port port3: Failed to add decoder3.0
> > >   cxl_bus_probe: cxl_port port3: probe: -6
> > > 
> > > This bug also highlights that when the decoder's ->targets[] array is
> > > written in cxl_port_setup_targets() it is missing a hold of the
> > > targets_lock to synchronize against sysfs readers of the target list. A
> > > fix for that is saved for a later patch.
> > > 
> > > Fixes: a5c258021689 ("cxl/bus: Populate the target list at decoder create")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > > [djbw: rewrite the changelog, find the Fixes: tag]
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---

Thanks for answering my questions -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> > >  drivers/cxl/core/port.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index b7c93bb18f6e..57495cdc181f 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -1644,7 +1644,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
> > >  		return -EINVAL;
> > >  
> > >  	write_seqlock(&cxlsd->target_lock);
> > > -	for (i = 0; i < cxlsd->nr_targets; i++) {
> > > +	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
> > >  		struct cxl_dport *dport = find_dport(port, target_map[i]);
> > >  
> > 
> > Does this loop need to protect against interleave_ways > nr_targets?
> > ie protect from walking off the target_map[nr_targets].
> 
> It's a good review question, but I think target_map[] is safe from those
> shenanigans. For the CFMWS case interleave_ways == nr_targets, see the
> @nr_tagets argument to cxl_root_decoder_alloc(). For the mid-level
> switch decoder case it is protected by the fact that the decoder's
> interleave_ways setting is sanity checked by the eiw_to_ways() call in
> init_hdm_decoder(). So there's never any danger of walking off the end
> of the target_map[] because that is allocated to support the
> spec-defined hardware-max of CXL_DECODER_MAX_INTERLEAVE.
> 
> > There is a check for that in cxl_port_setup_targets() 
> > >>   if (iw > 8 || iw > cxlsd->nr_targets) {
> > >> 		dev_dbg(&cxlr->dev,
> > >> 			"%s:%s:%s: ways: %d overflows targets: %d\n",
> 
> That check is for programming mid-level decoders where we find out at
> run time that the interleave_ways of the region can not be satisfied by
> one of the decoders in the chain, so that one is not about walking past
> the end of a target list, that one is about detecting impossible region
> configurations.

