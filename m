Return-Path: <stable+bounces-115103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B7A337AC
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A7B7A24B0
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241B2066D4;
	Thu, 13 Feb 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LB8+CRIZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDE1E376E;
	Thu, 13 Feb 2025 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426604; cv=none; b=N4TbGcALhYtPTPehy5Z97iukh3rqtSHEeCXnE9TJ1Cx/DA7U3UabparY3xb5Ph+cDj7XaUkeLrCy5V6GhFDjn7Me4vQhg4yGRM6ilOvynKupigqgK3DVQ93dIIM9x5VcjOgelvJRfyT8QfqmVhLTZE8BwhBgiIsTWmrn6BLs494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426604; c=relaxed/simple;
	bh=A1KejvtxR9/JSfGOFPXMqvUIQBaZlAHvh1/62NOg5Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M21KyCEqHTk5Vk/pC61GLDVzhrjl19UAUVih2pboDIL1CdndhNTh/3pjY79RSYGVBuB82K+gISlaIMWaxXyNlshTL5CCWToH1EtpJsmME+/OFWuy4pXeMkj3f7aXr80wg7+aYVKplG7eJ2/reu8BJX2Uf6rvA5nNnLuJAMDwIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LB8+CRIZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739426603; x=1770962603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A1KejvtxR9/JSfGOFPXMqvUIQBaZlAHvh1/62NOg5Y8=;
  b=LB8+CRIZyDsFotBQH8KFunpfma2smt4yYX8cVeSpr66fjhTryEUP+D57
   4dpw6owdPhAgpj39TNqZyUCJrmbsRZ0W/Vcu9SoSSgJIj+xrPQFUchl1o
   eBE4+i293mXkPy3xsvAoCBHbq4lmLYV+KKcOdkrN2pbv0mfFCmRKxZm1+
   gB0Qj0x/NILSjv874rvaxz8WGsUjsIj0R+969lSkE3OfKz4WbKETz05uu
   I62aCMWqGspb+My5o3xgI3Ox/OoKxXyX23fXzWaj2gR2UQOkgkIJfienu
   JMFPKZsZ5O0vDUFRfy5hP7MXXi0KmF3OScpC0HSK6IYiJ1p0aXIesp+OL
   g==;
X-CSE-ConnectionGUID: yfyih/YkQoOYa7ODLPVcQQ==
X-CSE-MsgGUID: MRws48Y+THm/FAdCMXmQKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="57644332"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57644332"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:03:22 -0800
X-CSE-ConnectionGUID: AvIoVobbT6+oTVNraSds5w==
X-CSE-MsgGUID: kvlLfINJR0uni5uKSjASzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112900246"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 22:03:18 -0800
Date: Thu, 13 Feb 2025 06:59:43 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: felix:  Add NULL check for outer_tagging_rule()
Message-ID: <Z62KTwRLHAQDyIGb@mev-dev.igk.intel.com>
References: <20250213040754.1473-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213040754.1473-1-vulab@iscas.ac.cn>

On Thu, Feb 13, 2025 at 12:07:54PM +0800, Wentao Liang wrote:
> In felix_update_tag_8021q_rx_rules(), the return value of
> ocelot_vcap_block_find_filter_by_id() is not checked, which could
> lead to a NULL pointer dereference if the filter is not found.
> 
> Add the necessary check and use `continue` to skip the current CPU
> port if the filter is not found, ensuring that all CPU ports are
> processed.
> 
> Fixes: f1288fd7293b ("net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/ocelot/felix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 3aa9c997018a..10ad43108b88 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -348,6 +348,8 @@ static int felix_update_tag_8021q_rx_rules(struct dsa_switch *ds, int port,
>  
>  		outer_tagging_rule = ocelot_vcap_block_find_filter_by_id(block_vcap_es0,
>  									 cookie, false);
> +		if (!outer_tagging_rule)
> +			continue;
>  
>  		felix_update_tag_8021q_rx_rule(outer_tagging_rule, vlan_filtering);
>  

All other calls to ocelot_vcap_block_find_filter_by_id() are checked, so
looks correct, thanks.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.42.0.windows.2

