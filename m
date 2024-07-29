Return-Path: <stable+bounces-62575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48B593F83F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7791F1F221B1
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890DB188CD7;
	Mon, 29 Jul 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOtXgj84"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A918187860;
	Mon, 29 Jul 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263326; cv=none; b=LVfaQ3il499ptBHTz2SrI9ED2odV1bqcKKjJjhe7tTle6iGvPI1c/a89iltoz35JQJVgzsEljyDDl94+z7fpqIb/EpTyu9bBoHOYvf25WMQxi96+CygrkN9RITPXkUOipN3MZrncQIte4kvzpXFO8gvdWHPWW2VaTe7ZedN5eRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263326; c=relaxed/simple;
	bh=NehnDBe65QUb/bCNXvqWYiRaGGm51AIYVQytQZgxYgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLw8hTpcNx3qosXabCphwDHYA3itqCZBWNLa5ZNEwU/Fzr1YvJ6xfDFtgSSo6uf9l5/9hoNkM8KzFhdZs9z/szmv5rRq73ieovAW6dPJreFbdAdXpg0LPn/f8ad4cVaI4hvtSy92mXJrP8vd3SJL6Jr8XFWaRifiKF9vutMAtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOtXgj84; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722263324; x=1753799324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NehnDBe65QUb/bCNXvqWYiRaGGm51AIYVQytQZgxYgU=;
  b=FOtXgj84up71elTFBl3vRLf69bRt1Keg0UAy+4sCJCvQcVgtCcPuK2bm
   tMc4gCBeRhPXvDmavA7DoJPplFlUdd+X32CXEKHtOdIrzvkDbsm9URCm/
   7j0fTuuXG+O1nXIZw5qAZrYD6XNrxK4UUiN7zXahsqO4vlwGVi4UhL+SH
   dbU23d6SVkPXfAWGjUx6LBx9TMvjwVpTmCB5IMwQXxQjX033n6SEd/suB
   WrwjV8ghivNSc8exRECvHUobTGpZMf8+bbTJF7SR8kuP6pdsTiPK2XL88
   4qInUwOgs9+EBSmLwy0xfBzKspluizfJylglsDmadZu33IDam2Kh+7eJ+
   w==;
X-CSE-ConnectionGUID: O8ir7Z9KR72SltrmS0KVrA==
X-CSE-MsgGUID: OpxW7MNCRX6dyzeF4ubMAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30692055"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="30692055"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 07:28:43 -0700
X-CSE-ConnectionGUID: aaRxpF21Q2+Qdt21vlrXrw==
X-CSE-MsgGUID: TrH4A4xhQ8qG38n6OD5zkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53889098"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.246.219]) ([10.245.246.219])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 07:28:40 -0700
Message-ID: <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
Date: Mon, 29 Jul 2024 16:25:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 16:01, Krzysztof Kozlowski wrote:
> Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
> 'sink_ports' - define which ports to program in
> sdw_program_slave_port_params().  The masks are used to get the
> appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
> an array.
> 
> Bitmasks can be non-continuous or can start from index different than 0,
> thus when looking for matching port property for given port, we must
> iterate over mask bits, not from 0 up to number of ports.
> 
> This fixes allocation and programming slave ports, when a source or sink
> masks start from further index.
> 
> Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This is a valid change to optimize how the port are accessed.

But the commit message is not completely clear, the allocation in
mipi_disco.c is not modified and I don't think there's anything that
would crash. If there are non-contiguous ports, we will still allocate
space that will not be initialized/used.

	/* Allocate memory for set bits in port lists */
	nval = hweight32(prop->source_ports);
	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
					  sizeof(*prop->src_dpn_prop),
					  GFP_KERNEL);
	if (!prop->src_dpn_prop)
		return -ENOMEM;

	/* Read dpn properties for source port(s) */
	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
			   prop->source_ports, "source");

IOW, this is a valid change, but it's an optimization, not a fix in the
usual sense of 'kernel oops otherwise'.

Am I missing something?

BTW, the notion of DPn is that n > 0. DP0 is a special case with
different properties, BIT(0) cannot be set for either of the sink/source
port bitmask.


> ---
>  drivers/soundwire/stream.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 7aa4900dcf31..f275143d7b18 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>  					    unsigned int port_num)
>  {
>  	struct sdw_dpn_prop *dpn_prop;
> -	u8 num_ports;
> +	unsigned long mask;
>  	int i;
>  
>  	if (direction == SDW_DATA_DIR_TX) {
> -		num_ports = hweight32(slave->prop.source_ports);
> +		mask = slave->prop.source_ports;
>  		dpn_prop = slave->prop.src_dpn_prop;
>  	} else {
> -		num_ports = hweight32(slave->prop.sink_ports);
> +		mask = slave->prop.sink_ports;
>  		dpn_prop = slave->prop.sink_dpn_prop;
>  	}
>  
> -	for (i = 0; i < num_ports; i++) {
> +	for_each_set_bit(i, &mask, 32) {
>  		if (dpn_prop[i].num == port_num)
>  			return &dpn_prop[i];
>  	}


