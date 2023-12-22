Return-Path: <stable+bounces-8345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032B81CF29
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25847B23F08
	for <lists+stable@lfdr.de>; Fri, 22 Dec 2023 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F322E831;
	Fri, 22 Dec 2023 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBVeWWOJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A702F841;
	Fri, 22 Dec 2023 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703275967; x=1734811967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hSRK2Jxd0SScRG0U9+Kjmc5EEcBf4XyA1lGfiWtNBaY=;
  b=XBVeWWOJbEh9g3GoVuNGX1mzZRmv2cKavU3pBrnrvvVNmfM/XrXQXPc6
   CzqxTUtStbMdjP+GK2KSRovnYitHVVo3X/C1kzqcUUNnF9HarJEs1Iq16
   aY4uFkqPtyh48M9FSnxJC29uyv3HRKXuMfkmK7wZepLJWTHYAnvDAUzAI
   ve3p+rHXMWsg2S6CAoBzLrijxWAMuPHjbHSECceOVYbxfyAKayUCJDkdI
   Wb3KqJuLN+a9lgs+RthTOOy+CWXM6mLYm4cbJmnDwV11ovnlI/O16MuZw
   dmtCPzmTt9g24jRQFWwPNbVrjiUd2xK7FZdffa/FjsF3V4xnidERoirJ4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="427315381"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="427315381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 12:12:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811402449"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="811402449"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.160.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 12:12:46 -0800
Date: Fri, 22 Dec 2023 12:12:44 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH] cxl/port: Fix decoder initialization when nr_targets >
 interleave_ways
Message-ID: <ZYXtvKOfnIkGuwOe@aschofie-mobl2>
References: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170322553283.110939.32271609757456243.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 21, 2023 at 10:12:12PM -0800, Dan Williams wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> The decoder_populate_targets() helper walks all of the targets in a port
> and makes sure they can be looked up in @target_map. Where @target_map
> is a lookup table from target position to target id (corresponding to a
> cxl_dport instance). However @target_map is only responsible for
> conveying the active dport instances as conveyed by interleave_ways.
> 
> When nr_targets > interleave_ways it results in
> decoder_populate_targets() walking off the end of the valid entries in
> @target_map. Given target_map is initialized to 0 it results in the
> dport lookup failing if position 0 is not mapped to a dport with an id
> of 0:
> 
>   cxl_port port3: Failed to populate active decoder targets
>   cxl_port port3: Failed to add decoder
>   cxl_port port3: Failed to add decoder3.0
>   cxl_bus_probe: cxl_port port3: probe: -6
> 
> This bug also highlights that when the decoder's ->targets[] array is
> written in cxl_port_setup_targets() it is missing a hold of the
> targets_lock to synchronize against sysfs readers of the target list. A
> fix for that is saved for a later patch.
> 
> Fixes: a5c258021689 ("cxl/bus: Populate the target list at decoder create")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> [djbw: rewrite the changelog, find the Fixes: tag]
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b7c93bb18f6e..57495cdc181f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1644,7 +1644,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  		return -EINVAL;
>  
>  	write_seqlock(&cxlsd->target_lock);
> -	for (i = 0; i < cxlsd->nr_targets; i++) {
> +	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  

Does this loop need to protect against interleave_ways > nr_targets?
ie protect from walking off the target_map[nr_targets].

There is a check for that in cxl_port_setup_targets() 
>>   if (iw > 8 || iw > cxlsd->nr_targets) {
>> 		dev_dbg(&cxlr->dev,
>> 			"%s:%s:%s: ways: %d overflows targets: %d\n",

Wondering if a check at the time of walking is clearer, esp since
nr_targets is explicitly defined w the target list in cxlsd.

>> struct cxl_switch_decoder {
>>         struct cxl_decoder cxld;
>>         int nr_targets;
>>         struct cxl_dport *target[];
>> };







>  		if (!dport) {
> 

