Return-Path: <stable+bounces-124259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53198A5F014
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A834E17DDA5
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A026562A;
	Thu, 13 Mar 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ruhIPBuu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A5263C8A;
	Thu, 13 Mar 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859900; cv=none; b=nabc7EAT0JPHXhNiiSzkX3tfshPPBhg71DEbwhI16bN3CtpVzGILet3JH7DYidVh9Cp/QvPaCkNempCay1zDeVBJdTD/JiHp4c0nK6Rv7Zg1Uf0UYE6pVpPcA8i2qFcHRt04uH3rMrSZxsJyVzjhTIt7ND/Wj5KpBtpH3obS2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859900; c=relaxed/simple;
	bh=cuy3wdeUkqjYr5LUbKSKDKjMf1F2kQtjs1UZvwSxQts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNu6+rk5nl5Xb46Prc3EC3hwmA5Yngmn5ayV+mfQnrrRbcU+jIIVPvdhZ7TGmfaCilW2Zi5N7cbaWwoFEYxDvGQqbPTnJqDL/wCJFEcw+PeY1jhUGAiOEGovrLmGDyNrA5XSQNLqgq60jw39Lz6gumAbMQt/H84QqC8O1yP5lmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ruhIPBuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8690BC4CEFA;
	Thu, 13 Mar 2025 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741859900;
	bh=cuy3wdeUkqjYr5LUbKSKDKjMf1F2kQtjs1UZvwSxQts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ruhIPBuuhy04aY+GzopKjQXlQkBEg/msZwU2IW8670KDT3HZ6PgJrNEQy2y3rcU8G
	 o52jFa8GcXBC1JZyYUuA8fV0bYliGko9220RiDftkvB6FCllOfGExY6hDf2j1xhEry
	 +d4KBW+Id+UyEtaXdPwRUeCQT82yHAFQti4gfbWQ=
Date: Thu, 13 Mar 2025 10:58:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jdamato@fastly.com,
	aleksander.lobakin@intel.com, quic_zijuhu@quicinc.com,
	andriy.shevchenko@linux.intel.com, wanghai26@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: fix error handling in
 netdev_register_kobject()
Message-ID: <2025031355-legend-liftoff-63bc@gregkh>
References: <20250313075528.306019-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313075528.306019-1-make24@iscas.ac.cn>

On Thu, Mar 13, 2025 at 03:55:28PM +0800, Ma Ke wrote:
> Once device_add() failed, we should call put_device() to decrement
> reference count for cleanup. Or it could cause memory leak.
> 
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8ed633b9baf9 ("Revert "net-sysfs: Fix memory leak in netdev_register_kobject"")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/core/net-sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 07cb99b114bd..f443eacc9237 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -2169,6 +2169,7 @@ int netdev_register_kobject(struct net_device *ndev)
>  
>  	error = device_add(dev);
>  	if (error)
> +		put_device(dev);
>  		return error;

You obviously did not test this :(

Please be more careful in the future.

