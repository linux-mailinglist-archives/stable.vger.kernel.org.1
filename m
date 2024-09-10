Return-Path: <stable+bounces-75639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5D97383B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0931F269DC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D96191F72;
	Tue, 10 Sep 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcEKE5VX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45518C00D;
	Tue, 10 Sep 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973518; cv=none; b=gjtJ7Ju9B/KURaixNrUEjamHlloy2pH53Er0CMiFP8kDWUQKOtaXPOja38wOOLszXZSwqq15OJB+U8Sn+3h5jGFS24npaw5CfEPeSbzq8IiMnmo3NjWr476ServDOyoCb00qT86ZHC/rRuysyLz+69JFz/JJo0/WHG4k+5fxX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973518; c=relaxed/simple;
	bh=e5dl7rhTvT8U88gO91GvPckWYrls1EUDpHm65XSFRHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egzm0FwTdlnoeiPN8RTKOTVAesYQaw0M36UNH8/HNphWFTHs7qI4TDVYSYTmP8I+vsAJLaCCh22dG1ofAtBjfPIUJYu4Nz6321aUwtPUzT4TElICsLgIKnvLHKL4Pd+wqKmbn7rtqj/VMEZOSaU7Ucrl0VesZWIsdNroJ1URzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcEKE5VX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725973517; x=1757509517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e5dl7rhTvT8U88gO91GvPckWYrls1EUDpHm65XSFRHE=;
  b=IcEKE5VXoaBEM/WkdB2eiRNbOcObHP8pyqOC4ipb1nvWZi9uq+xpnMcS
   /gP/UybXnvVl5LsGPnkmNFpTeE6zH02UOsHM3N+gZ3o/bvdYEWrXlBVRY
   2imMr/AbnGzXgpe+j6q9YrNBnkNOXNLsBE3utFcbDYg1AEZ+JU9c0P/Dm
   T0An+6cqlsgSp97hYv160avfhQsGQseAjDayod4PQlRU9B56ZSHkAA26l
   4xkxUi31mFIS5VqHnuPyLEw036FcVr44B9z5gJ8zouciPhnt73SvMFLI7
   ITQxy+eyGQzZ9o8Sf/0cZ3hFFRc7VXseSF/NcBFvvdQp10tU1E4mvjB5x
   g==;
X-CSE-ConnectionGUID: dQW+EnE6RROQxrIjUquE0w==
X-CSE-MsgGUID: cQyzFr4oRKekVzwDr2pcZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42191318"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="42191318"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:05:16 -0700
X-CSE-ConnectionGUID: Xd9L7Gp2RNCKe72KRzKOpA==
X-CSE-MsgGUID: 5TgIvzSPQWua0RSpn/N0xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67547864"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO [10.245.245.155]) ([10.245.245.155])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:05:13 -0700
Message-ID: <568137f5-4e4f-4df7-8054-011977077098@linux.intel.com>
Date: Tue, 10 Sep 2024 16:05:20 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, stable@vger.kernel.org
References: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/09/2024 19:47, Krzysztof Kozlowski wrote:
> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
> breaks codecs using non-continuous masks in source and sink ports.  The
> commit missed the point that port numbers are not used as indices for
> iterating over prop.sink_ports or prop.source_ports.
> 
> Soundwire core and existing codecs expect that the array passed as
> prop.sink_ports and prop.source_ports is continuous.  The port mask still
> might be non-continuous, but that's unrelated.
> 
> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
> Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Tested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> ---
> 
> Resending with Ack/Rb tags and missing Cc-stable.
> ---
>  drivers/soundwire/stream.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index f275143d7b18..7aa4900dcf31 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>  					    unsigned int port_num)
>  {
>  	struct sdw_dpn_prop *dpn_prop;
> -	unsigned long mask;
> +	u8 num_ports;
>  	int i;
>  
>  	if (direction == SDW_DATA_DIR_TX) {
> -		mask = slave->prop.source_ports;
> +		num_ports = hweight32(slave->prop.source_ports);
>  		dpn_prop = slave->prop.src_dpn_prop;
>  	} else {
> -		mask = slave->prop.sink_ports;
> +		num_ports = hweight32(slave->prop.sink_ports);
>  		dpn_prop = slave->prop.sink_dpn_prop;
>  	}
>  
> -	for_each_set_bit(i, &mask, 32) {
> +	for (i = 0; i < num_ports; i++) {
>  		if (dpn_prop[i].num == port_num)
>  			return &dpn_prop[i];
>  	}

-- 
Péter

