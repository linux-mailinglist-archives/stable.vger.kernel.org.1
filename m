Return-Path: <stable+bounces-75637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2A697382E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F1E28390C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE4718EFDD;
	Tue, 10 Sep 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2jWVQz3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD7524B4;
	Tue, 10 Sep 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973356; cv=none; b=QG0AY5ZFXN65UDfUNfshxO+b7YtOkLclS1wvuAbQLM9Ofi26Tt0bVDYrFry1Rgpfshn1yjpNLYW5T8ysHabEhwhdmicE4GucYPTxP8q4pzKEd48Q9B/aSmE1kIJgo5y74cu7vxxKj39ugvBnKE2rGP8tNowqzBCR47ucw/Nhsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973356; c=relaxed/simple;
	bh=nOKLnXy/12xJXPE117m27o4YsYnM7APsdPBMXFqYyfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BuszK4t9Abadcn5wWhzA2Vr+/eSrb4V7IWymMq5GaysTeJqbA1kOnNuIYmnoYQbrpOUiAx/EhPdQZxHGIk4MdaANzShnge9Y6W87WkwNlzH4Dq/XorYZMWuuFI9n2WK+DHDvz/3efzRKN8yRpzmjxbLHU7eaOOP+STeodAwejRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2jWVQz3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725973355; x=1757509355;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nOKLnXy/12xJXPE117m27o4YsYnM7APsdPBMXFqYyfc=;
  b=m2jWVQz3NyWdfyzH9cirxDTnk7jGVyDGPYzwnNx4dJ+m2qaDCsEQfr9Q
   cDHAWsbScH9G0XZ8DYfdFSEYzDRSphiANRV50ZLcATKgV1IpuAJnCXwfy
   5RAn9qMsDW4eokFp4Dfv9ev0mMobtuoHhGh+P7mluheadVY0xip2jjWSM
   Hv2Z6VufYWDfpBnf8h6VgD1T6sj1ju95/gQk3QIBcd1pCguKi1TJareN4
   s6zXZvzEX96kiJIUn5hCNwfBr0D+FuHgGWXARQn2PUVrnCHPw0gtjNBr7
   MwGU0F1XrBA5jtJABE85Vo606AsDCTwlEEsFQy4Tw7gkETiuGTWE5al4E
   g==;
X-CSE-ConnectionGUID: ey/9bT8ITzmtfQ63Nnj7FA==
X-CSE-MsgGUID: qQJYC2TKSLCFzDDdM6jIoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24875798"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24875798"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:02:34 -0700
X-CSE-ConnectionGUID: p6uZ63ssRYC6RLYXfUtKeA==
X-CSE-MsgGUID: TCV1IGEEQ7KFYH0evY94gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67070218"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO [10.245.245.155]) ([10.245.245.155])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 06:02:32 -0700
Message-ID: <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
Date: Tue, 10 Sep 2024 16:02:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, krzysztof.kozlowski@linaro.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, gregkh@linuxfoundation.org
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/09/2024 15:40, Peter Ujfalusi wrote:
> The prop->src_dpn_prop and prop.sink_dpn_prop is allocated for the _number_
> of ports and it is forced as 0 index based.
> 
> The original code was correct while the change to walk the bits and use
> their position as index into the arrays is not correct.
> 
> For exmple we can have the prop.source_ports=0x2, which means we have one
> port, but the prop.src_dpn_prop[1] is accessing outside of the allocated
> memory.
> 
> This reverts commit 6fa78e9c41471fe43052cd6feba6eae1b0277ae3.

I just noticed that Krzysztof already sent the revert patch but it is
not picked up for stable-6.10.y

https://lore.kernel.org/lkml/20240909164746.136629-1-krzysztof.kozlowski@linaro.org/

> 
> Cc: stable@vger.kernel.org # 6.10.y
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi,
> 
> The reverted patch causes major regression on soundwire causing all audio
> to fail.
> Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.
> 
> soundwire sdw-master-0-1: Program transport params failed: -22
> soundwire sdw-master-0-1: Program params failed: -22
> SDW1-Playback: ASoC: error at snd_soc_link_prepare on SDW1-Playback: -22
> 
> Regards,
> Peter 
> 
>  drivers/soundwire/stream.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 00191b1d2260..4e9e7d2a942d 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1286,18 +1286,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
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

