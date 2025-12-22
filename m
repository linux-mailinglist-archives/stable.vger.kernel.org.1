Return-Path: <stable+bounces-203191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EFCD4C98
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 07:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8286F30084C7
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 06:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C99324B24;
	Mon, 22 Dec 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VIPSrzns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF943002C8;
	Mon, 22 Dec 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384405; cv=none; b=mZ5tA8AgE+V71I9ZTxIb1ej7GP1kpDtEX1wS9bYonkCSuRYqgLiuooVjt8I0sZCgpTecr1Dzpuvjrq5haxACV5FrxtX/Y+ehNswIpgOxJnYJExmskP9dsboTj6XIvKnf103jpm9cHqmF/buaxOdIaNRAMkHHOo1CWXnJGcr4Ymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384405; c=relaxed/simple;
	bh=YGkELqsIKU8rBjyfo2gCT07jzGxgx9BW3JXVX/lfT4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBKtDa3wWIjONKYFjTrOBxPv1CfHJz7qQwa8/BpL9S7n0WTYJ+xNPB6oUcEF0lYJqS0++1gcfudTpT2MOw85gfDm8NfDjSgfjL5dQGY8cKpltBXk36UMhGI1Bn1BhskAvSoMqxKyvQtmHcbQUIKp5uGX4mbyPRc6sK2hAURx9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VIPSrzns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E4DC4CEF1;
	Mon, 22 Dec 2025 06:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766384404;
	bh=YGkELqsIKU8rBjyfo2gCT07jzGxgx9BW3JXVX/lfT4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIPSrznsWaB+SAA4R19WJuv7g80xiVd+ss+g9racXlGqm4Mec73FjxMdxs+yrcvTj
	 rltvWpowMowB5dMDGV8MioAjDN4uJoyfvHanYm1xZdqQhwHWHzVthxQ9ydtHTo/CGd
	 W+90/8K4xw7uj5PbaJztrKle88fhwLklOmOIQCBM=
Date: Mon, 22 Dec 2025 07:20:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	ritesh.list@gmail.com, byungchul@sk.com, abarnas@google.com,
	kay.sievers@vrfy.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/cmm: fix the error handling in
 cmm_sysfs_register()
Message-ID: <2025122248-obsession-urgent-648f@gregkh>
References: <20251222031225.968472-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222031225.968472-1-lihaoxiang@isrc.iscas.ac.cn>

On Mon, Dec 22, 2025 at 11:12:25AM +0800, Haoxiang Li wrote:
> If device_register() fails, put_device() should be called to drop
> the device reference.
> Thus add put_device() after subsys_unregister label and change
> device_unregister() to device_del() in fail label.
> 
> Found by code review.
> 
> Fixes: 6c9d29095264 ("power: cmm - convert sysdev_class to a regular subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 4cbbe2ee58ab..0666d3300bdb 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -419,8 +419,9 @@ static int cmm_sysfs_register(struct device *dev)
>  fail:
>  	while (--i >= 0)
>  		device_remove_file(dev, cmm_attrs[i]);
> -	device_unregister(dev);
> +	device_del(dev);
>  subsys_unregister:
> +	put_device(dev);
>  	bus_unregister(&cmm_subsys);
>  	return rc;
>  }

this does not look to be correct, how was it tested?

Also, why not fix all of this up properly by calling the correct
functions so that you don't have to manually add/remove the sysfs files?
That would resolve the "problem" you seem to think is here in a much
simpler way, and also fix the real bug in this function (i.e. it races
with userspace and looses.)

thanks,

greg k-h

