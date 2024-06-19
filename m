Return-Path: <stable+bounces-54651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B890F158
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3359128A849
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96753249F5;
	Wed, 19 Jun 2024 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXQr2W9v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A050134A5;
	Wed, 19 Jun 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808795; cv=none; b=B/Z5vv/rHTDRb4y0pdgv5fJ8TMc6+pWBmn2APLwbYMKQUiJfg4Q3UzxBWlaGxly2azl5Y95xBAU2sYnd8DpzjQH0EGuS27r8Zy6dWKMNQRvHJhBtThA9Z3c7A/0WvltsbYzYK72J9AUrOWPt4DBvpmWJGvvN4rYdo1rY4evoUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808795; c=relaxed/simple;
	bh=mhSLdjbXIugKuXxjNfh4RzA3lC4RlS0/kcc/bks2uww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEVxkw8rHR0KEJSV4FRxHc/TNyv5IJzOiEAvuvtRbZRLLNi+bAiXzdivqI15VGmLEZGGQ1GlCqLFkBJ5r5LnDmIXIzvfsYLJ5fsGNZFBZ/Lh8CbHpPmRb4ejFKXz87t0XI33nucqZMsZDhx9dkZhq9aQK+91Q3Fo4akSYziArz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXQr2W9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D77BC2BBFC;
	Wed, 19 Jun 2024 14:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718808794;
	bh=mhSLdjbXIugKuXxjNfh4RzA3lC4RlS0/kcc/bks2uww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXQr2W9vG2692EJIFlLIv/3ad7ieKP1tYJGwQ6Or3r6OzJIqLoF7Lv5J9DCxjLwkx
	 c5+b59DoQvZoQjjywE7Gj5ZtuJ4Q6hJsI583+tP+DJ7QO234hxFIhDYjeucmGPFseF
	 8oOkSjqfO/k/tugfuk0UNMX2GMRBjqMZB3waRRJ4=
Date: Wed, 19 Jun 2024 16:53:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, davem@davemloft.net, madalin.bucur@nxp.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] devres: Fix memory leakage due to driver API
 devm_free_percpu()
Message-ID: <2024061949-dullness-snippet-da5a@gregkh>
References: <1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com>

On Wed, Jun 19, 2024 at 09:38:01PM +0800, Zijun Hu wrote:
> It will cause memory leakage when use driver API devm_free_percpu()
> to free memory allocated by devm_alloc_percpu(), fixed by using
> devres_release() instead of devres_destroy() within devm_free_percpu().
> 
> Fixes: ff86aae3b411 ("devres: add devm_alloc_percpu()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/devres.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 3df0025d12aa..082dbb296b6e 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -1222,7 +1222,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
>   */
>  void devm_free_percpu(struct device *dev, void __percpu *pdata)
>  {
> -	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
> +	/*
> +	 * Use devres_release() to prevent memory leakage as
> +	 * devm_free_pages() does.
> +	 */
> +	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
>  			       (__force void *)pdata));
>  }
>  EXPORT_SYMBOL_GPL(devm_free_percpu);
> -- 
> 2.7.4
> 
> 

These are good fixes, how are you finding them?  Care to write up some
kunit tests for the devres apis?

thanks,

greg k-h

