Return-Path: <stable+bounces-78469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF098BAFA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0372838CB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E01BF807;
	Tue,  1 Oct 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jj+/khYe"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCA19AD4F;
	Tue,  1 Oct 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782021; cv=none; b=a4vmZRjvJy9R0afNuiqpUVdXd5SQO7pdXVrwJ+rGSqaqx3JxK8TDhWg2MF5iBPO58ZEZg3Ulu2UZowxAs43YB8e/ODOYHZGX/96SunFzacxPtHR/oAMI+MXN6UzcyK4Vb84eIyto+U/PzKGglXbt4ntTX0BAPFLxgWTi7ywlpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782021; c=relaxed/simple;
	bh=pJpo/9nlenGg9LeNsmXdGVa1hJvHzCo9llQzihv+rsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbJLcyRnp/Doy/e5eb9/1hJreT8Gru5yFtAWMPBHlRwPQNq0ZfVzgLOD9BAPufNei1In1WN8HzWFWpmr0GycQ9hqoGIKI4tFc4mhgZB0uxQCCPJvvJmGAoIXH5h68s/VY3ClAH9I2JgOYWne9YygP87ek/+SHNB9c4HZ7ClBpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jj+/khYe; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f28f2b21-a829-48c6-a122-4850b7276b8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727782016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cBUOWnEConx+IWDW0GCsQ6ijdhHKbEVnoz17VjGz20=;
	b=Jj+/khYeG5yWFqTqDhKyUDj0TbMLyhL48Gk79bPpczjnogz50Mm6zl9RHAKJVfjQ5K5TZM
	3fmKBJDYpvqFskZYO46m3ZVGr5Oit2X+0BEUnloTZrGYz3Fau6K7Wjfa4pTk6W8IiajEVO
	G3SZVxHgbPNfnCT9Prx+QSHSZtxR4Vw=
Date: Tue, 1 Oct 2024 12:26:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 02/10] ice: Fix improper handling of refcount in
 ice_dpll_init_rclk_pins()
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@outlook.com>, baijiaju1990@gmail.com,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, stable@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
 <20240930223601.3137464-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240930223601.3137464-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/09/2024 23:35, Tony Nguyen wrote:
> From: Gui-Dong Han <hanguidong02@outlook.com>
> 
> This patch addresses a reference count handling issue in the
> ice_dpll_init_rclk_pins() function. The function calls ice_dpll_get_pins(),
> which increments the reference count of the relevant resources. However,
> if the condition WARN_ON((!vsi || !vsi->netdev)) is met, the function
> currently returns an error without properly releasing the resources
> acquired by ice_dpll_get_pins(), leading to a reference count leak.
> 
> To resolve this, the check has been moved to the top of the function. This
> ensures that the function verifies the state before any resources are
> acquired, avoiding the need for additional resource management in the
> error path.
> 
> This bug was identified by an experimental static analysis tool developed
> by our team. The tool specializes in analyzing reference count operations
> and detecting potential issues where resources are not properly managed.
> In this case, the tool flagged the missing release operation as a
> potential problem, which led to the development of this patch.
> 
> Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_dpll.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index cd95705d1e7f..8b6dc4d54fdc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -1843,6 +1843,8 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
>   	struct dpll_pin *parent;
>   	int ret, i;
>   
> +	if (WARN_ON((!vsi || !vsi->netdev)))
> +		return -EINVAL;
>   	ret = ice_dpll_get_pins(pf, pin, start_idx, ICE_DPLL_RCLK_NUM_PER_PF,
>   				pf->dplls.clock_id);
>   	if (ret)
> @@ -1858,8 +1860,6 @@ ice_dpll_init_rclk_pins(struct ice_pf *pf, struct ice_dpll_pin *pin,
>   		if (ret)
>   			goto unregister_pins;
>   	}
> -	if (WARN_ON((!vsi || !vsi->netdev)))
> -		return -EINVAL;
>   	dpll_netdev_pin_set(vsi->netdev, pf->dplls.rclk.pin);
>   
>   	return 0;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

