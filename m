Return-Path: <stable+bounces-41814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312438B6C74
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FD9283C9B
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D0C45027;
	Tue, 30 Apr 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TY6TNq0I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FE405F2
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464321; cv=none; b=Oo5iQuXtuA7LkA20G78eR632fb3ahJE2nFGSDub3dwt/h1F6lljcj1Z6AfPVlwtEmCXN07xCtBzSWgu0ibhY0i9rKoo/g6Z72a/rGEf94GY/IuDltPP38PmwYaEblD2RaO23PFQsBTfAch9FsvuxN0cNQNOhPOk0ZiPdfbG6ZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464321; c=relaxed/simple;
	bh=OewqXCcGyEBrACQGHSHd2VREO/XcVz4tryaHbJwLHPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoXTI+L8/HsxPyP3UGzrKnHyXyk4Kqcc4uR7mYFXlF+J5XHc7qorDtqB7YTGOwV4NOS6gITVaWLWKXkK7mkVrOxf92Ryj216SVSg6WUOdtzSm5nNr8iVoBG8xB58Y5yH+suBelZ6+4jAXIYrcc8WoVhcxn9Tnw0HSQo4PKTwGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TY6TNq0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36E3C2BBFC;
	Tue, 30 Apr 2024 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714464321;
	bh=OewqXCcGyEBrACQGHSHd2VREO/XcVz4tryaHbJwLHPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TY6TNq0It3o8LG+hXjFUjsHKfYuGEWEY5WDbFRzsGZmBa3OBj0V+EELnDuA2rzU6N
	 q3D1+8rmB40DxdUCsWTegBS/pquEFFOM+LeLdIp2KpDZhV/fmJQg4aHrps8rrohxDI
	 cYzQnGwMwyPPQNFm99Byl1O7xcJAOzbDcgugeCto=
Date: Tue, 30 Apr 2024 10:05:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: stable@vger.kernel.org, bpoirier@nvidia.com, cratiu@nvidia.com,
	kuba@kernel.org, sd@queasysnail.net
Subject: Re: [PATCH 6.1.y 1/4] macsec: Enable devices to advertise whether
 they update sk_buff md_dst during offloads
Message-ID: <2024043009-isolated-kettle-9e8f@gregkh>
References: <20240430004439.299386-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430004439.299386-1-rrameshbabu@nvidia.com>

On Mon, Apr 29, 2024 at 05:44:21PM -0700, Rahul Rameshbabu wrote:
> commit 475747a19316b08e856c666a20503e73d7ed67ed upstream.
> 
> Omit rx_use_md_dst comment in upstream commit since macsec_ops is not
> documented.
> 
> Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
> without knowing whether the device is able to update this field during an
> offload. Assume that an offload to a MACsec device cannot support updating
> md_dst by default. Capable devices can advertise that they do indicate that
> an skb is related to a MACsec offloaded packet using the md_dst.
> 
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: stable@vger.kernel.org
> Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://lore.kernel.org/r/20240423181319.115860-2-rrameshbabu@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/macsec.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/macsec.h b/include/net/macsec.h
> index 65c93959c2dc..dd578d193f9a 100644
> --- a/include/net/macsec.h
> +++ b/include/net/macsec.h
> @@ -302,6 +302,7 @@ struct macsec_ops {
>  	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
>  	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
> +	bool rx_uses_md_dst;
>  };
>  
>  void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
> -- 
> 2.42.0
> 
> 

All backports now queued up, thanks!

greg k-h

