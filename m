Return-Path: <stable+bounces-200800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA4CB6113
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 14:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F64B3002150
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 13:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FC731328F;
	Thu, 11 Dec 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhAFrF2V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2623AE62;
	Thu, 11 Dec 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460551; cv=none; b=IFbXO5R7dKbCuPeshJS3fyytGy8VVxc2MemqvgxeLwwqQNfwadVAYCA27to1iuBN1wVC21uFKjra5Q8LfxgIhebCy9eJRAmmB/AO7bamYk5Q8ZHa2k3SAT03rEg7MURNCT+0Z9d2SEEliilcn6oo5Fy6OKAV45Qar5lGsWYuBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460551; c=relaxed/simple;
	bh=DXB+albUs7qjZXiSV8szFw0zSiV1oclQ+zF5jpW6srE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGiDG1a8oqxjqJH+qQpIYviZJb6EZpvVXJiGQleyPVUUUxRxrBcCOHnYwMpdi4xoG/hJUAvktbVQhidtS+YPTJdDqte0cLpgjEeVezhBHtz32Hxmp7IQu13bc2c+MjEPCo9VyKDUJa6m45RKdIncwSGw2jRRz45nLbLhJd6WcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhAFrF2V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765460549; x=1796996549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXB+albUs7qjZXiSV8szFw0zSiV1oclQ+zF5jpW6srE=;
  b=NhAFrF2VLannGNwpgnCUHRPCnTinlQcgNQGdxbXbnR8aSVqlk4cd0Y4K
   Kv8QOCFS/55f/QltCyBPHsWRY4AV0LU7E1wrgnaoZH4XDnHx5BzWxPl2V
   l6bi8jn0DW6ijNCFjWoHLM/wyv9YIziIdoZ+NDPKyp/Bv11befcFJei+k
   gYBB332dusan68oSwbOl8s+omKvGzoY3BtSk60Kg4ghCi2DTjS1A4igjr
   MZ0pw8uwWf6AOjt/vxQgpjqytQ/7gBCW94G53mncvtXnUl1s7ToSNHxfD
   8VIctkHpg1jy86z4Vgq8AYgw+llX/9gESIZRSX3MecqKyAsdgBGdD6uJW
   w==;
X-CSE-ConnectionGUID: b7697KP5TdS3bELzInU3dA==
X-CSE-MsgGUID: FcZg3E+0QF6VLjlLQXCgAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67174550"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="67174550"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 05:42:28 -0800
X-CSE-ConnectionGUID: 0rjdKFBWRWaoclDO0wy4Nw==
X-CSE-MsgGUID: cv96XoGNR72fvJCJWc7nFQ==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha) ([10.124.222.61])
  by fmviesa003.fm.intel.com with SMTP; 11 Dec 2025 05:42:25 -0800
Received: by kuha (sSMTP sendmail emulation); Thu, 11 Dec 2025 15:42:14 +0200
Date: Thu, 11 Dec 2025 15:42:14 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, rdbabiera@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: altmodes/displayport: Drop the device
 reference in dp_altmode_probe()
Message-ID: <aTrKNrvXX1gZ49cS@kuha>
References: <20251206070445.190770-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206070445.190770-1-lihaoxiang@isrc.iscas.ac.cn>

Sat, Dec 06, 2025 at 03:04:45PM +0800, Haoxiang Li kirjoitti:
> In error paths, call typec_altmode_put_plug() to drop the device reference
> obtained by typec_altmode_get_plug().
> 
> Fixes: 71ba4fe56656 ("usb: typec: altmodes/displayport: add SOP' support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 1dcb77faf85d..5d02c97e256e 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -764,12 +764,16 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
>  	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
>  	    !(DP_CAP_PIN_ASSIGN_UFP_D(port->vdo) &
> -	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
> -		return -ENODEV;
> +	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo))) {
> +		typec_altmode_put_plug(plug);
> +		return -ENODEV;
> +	}
>  
>  	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
> -	if (!dp)
> +	if (!dp) {
> +		typec_altmode_put_plug(plug);
>  		return -ENOMEM;
> +	}
>  
>  	INIT_WORK(&dp->work, dp_altmode_work);
>  	mutex_init(&dp->lock);
> -- 
> 2.25.1

-- 
heikki

