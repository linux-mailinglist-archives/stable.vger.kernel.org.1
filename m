Return-Path: <stable+bounces-69340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FD954FEC
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AE61C242CB
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D51C2333;
	Fri, 16 Aug 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3NqEnOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB02BB0D;
	Fri, 16 Aug 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828817; cv=none; b=mMyBawmlBhLbMH//j4FE27MWEl6LKCmcPtkJ8GI0KV2X4t70py3wwsZ+sFnln/+V6+6WdZ8nsoul6xK1XM/ZUrY09WRw3l2pybloNdyRyW6qCQyHnWfFZNXN39K5c80JKxiCxy2MgqMKuR/pM50CxMPhkexAD9lUMNb8MQjr9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828817; c=relaxed/simple;
	bh=yZK6p20zM5lEcMttmDmGvTzc0UQPEqUeHZaVijULW6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjv5VV3KP6UCuCuHfOaBG+y8wck1FI4jBJmh7yj54skCAJP1aeWxweSMzi03eL5YxHaIbVqDG2CMPqqMtuKdiuFK6PuGSVNKg+HkFWUs9KGAlwOix/PrXaER5JXHnipb/w+VQ3gmUqmAn85k48us8STQWRpqeHe1kGZaMl7wJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3NqEnOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC864C4AF0C;
	Fri, 16 Aug 2024 17:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828816;
	bh=yZK6p20zM5lEcMttmDmGvTzc0UQPEqUeHZaVijULW6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3NqEnOg/BZGt4LHLePvIS/20jbO/rd19Jplwbx2jwGBvoVElDE9KfVbonf5teqbm
	 OZfFkEteeTCmgm/rm54cg4qGXj5cLL+KQHGxGPRuXelLDb+bpRTKg3Kq6odm8Gj6nf
	 /brhIDgmDKPnVdJTaqauPsBKOAZWqI0VjYzEteHV8c97ULnUbHemM/4wo89SEHhIIc
	 YjbZ895kIP+a1wUKm+UjPxw3zTnzBFyf30aS5wlRzqp5gaWrk5uVlnlq8u94TjvKHg
	 QfKPuv8jsugguGP5fT4HyY08FhOs0HBVhKRT4Se9cf9TgOs2w39lSxJ5sC5nu/EgVF
	 ZpM2t6ZBhSFWg==
Date: Fri, 16 Aug 2024 18:20:12 +0100
From: Simon Horman <horms@kernel.org>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, lvc-project@linuxtesting.org,
	Kumar Sanghvi <kumaras@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] cxgb4: add forgotten u64 ivlan cast before shift
Message-ID: <20240816172012.GF632411@kernel.org>
References: <20240816082239.4188902-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816082239.4188902-1-kniv@yandex-team.ru>

On Fri, Aug 16, 2024 at 11:22:39AM +0300, Nikolay Kuratov wrote:
> It is done everywhere in cxgb4 code, e.g. in is_filter_exact_match()
> There is no reason it should not be done here
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> 
> Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
> Cc: stable@vger.kernel.org
> Fixes: 12b276fbf6e0 ("cxgb4: add support to create hash filters")
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> index 786ceae34488..e417ff0ea06c 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
> @@ -1244,7 +1244,7 @@ static u64 hash_filter_ntuple(struct ch_filter_specification *fs,
>  	 * in the Compressed Filter Tuple.
>  	 */
>  	if (tp->vlan_shift >= 0 && fs->mask.ivlan)
> -		ntuple |= (FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;
> +		ntuple |= (u64)(FT_VLAN_VLD_F | fs->val.ivlan) << tp->vlan_shift;

LGTM, but please line wrap this so that it doesn't extend
beyond 80 columns wide (as is the case elsewhere in this function).

>  
>  	if (tp->port_shift >= 0 && fs->mask.iport)
>  		ntuple |= (u64)fs->val.iport << tp->port_shift;

-- 
pw-bot: cr

