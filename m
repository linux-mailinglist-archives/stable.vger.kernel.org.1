Return-Path: <stable+bounces-146331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406DAC3C33
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 10:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915F43A78A6
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B351EB5C2;
	Mon, 26 May 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mo5iOhRd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914A2AEFE;
	Mon, 26 May 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249962; cv=none; b=ck/zR01SpHfefEo0woQZKnPzzoLKDQexd99GXnTk5nAAthhjqPUrMkgiiPxpsI4mr1PjDaJJU1hLhQFt2PDIwNuNTBEC/8ktx29v6xBbj130yMO1I4XfG8IVYl/zpliz0inZXNDujNyRye4pdJysnn7Q+8HRf8wXTXSJzTLVL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249962; c=relaxed/simple;
	bh=BdA9mPuHJ0+Hh9B8jPgulgQ8/U/ggWA26Ja0q9N75E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH05zei8wzwxEdg6yiioCxm99hQIk9FdLnFiHD0CtV98zRAnWDjd007Z7nl+9/rTDskedGtOZENRQczF/JvdTbjZQ6Ixxq2N1hK+ooqMJ2YbzIL48l9ASnG2/9aGLklx98snrAfpWckoiV6fu+lsCt/uLwtx5NFn3ma+JAtlN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mo5iOhRd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748249961; x=1779785961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdA9mPuHJ0+Hh9B8jPgulgQ8/U/ggWA26Ja0q9N75E8=;
  b=Mo5iOhRd3ecPEG1H8/lATWarZ8Oh/dKjFHad7XeXIO7F3QXzf2if21z2
   7+hZNHG6E8axiFkIBic9vuCb+f9BZdNNAxEcWfWdc5QhwtXA1Zj9cQRco
   GubB4UvoRqF67rmOWXdvDLD0J5Nj8cLIk7JrzO7lDDgFUNiXxZ5iUmg6d
   xyp15rHEeBHkq1qaviGn6eosB+8kmhnYWIkKM7vewGopkgUVYq589i6sc
   RC3jL3z318xfQadlfXXD7DLOC1mBcL+oPIW55No5LP8NuruNWW9ppGpIi
   VhWi1lC31mOrkEcVB7Y65Mnp/L2swjqOs3ycrBir0ownek9RH/TC0xKSj
   g==;
X-CSE-ConnectionGUID: OQ5JYd+9QhKfx0qm07k4DQ==
X-CSE-MsgGUID: 2lyc4xocTmO6KKkZ8jUrGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="60468911"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="60468911"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 01:59:20 -0700
X-CSE-ConnectionGUID: BJtMHkLOQhiTL9+A1un3Tg==
X-CSE-MsgGUID: xx6T1i4oRE6sWLGokSRPsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="165472427"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 01:59:17 -0700
Date: Mon, 26 May 2025 10:58:39 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: af_key: Add error check in set_sadb_address()
Message-ID: <aDQtPxmS3leVRJew@mev-dev.igk.intel.com>
References: <20250525155350.1948-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525155350.1948-1-vulab@iscas.ac.cn>

On Sun, May 25, 2025 at 11:53:50PM +0800, Wentao Liang wrote:
> The function set_sadb_address() calls the function
> pfkey_sockaddr_fill(), but does not check its return value.
> A proper implementation can be found in set_sadb_kmaddress().
> 
> Add an error check for set_sadb_address(), return error code
> if the function fails.
> 
> Fixes: e5b56652c11b ("key: Share common code path to fill sockaddr{}.")
> Cc: stable@vger.kernel.org # v2.6
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/key/af_key.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index c56bb4f451e6..537c9604e356 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -3474,15 +3474,17 @@ static int set_sadb_address(struct sk_buff *skb, int sasize, int type,
>  	switch (type) {
>  	case SADB_EXT_ADDRESS_SRC:
>  		addr->sadb_address_prefixlen = sel->prefixlen_s;
> -		pfkey_sockaddr_fill(&sel->saddr, 0,
> -				    (struct sockaddr *)(addr + 1),
> -				    sel->family);
> +		if (!pfkey_sockaddr_fill(&sel->saddr, 0,
> +					 (struct sockaddr *)(addr + 1),
> +					 sel->family))
> +			return -EINVAL;
>  		break;
>  	case SADB_EXT_ADDRESS_DST:
>  		addr->sadb_address_prefixlen = sel->prefixlen_d;
> -		pfkey_sockaddr_fill(&sel->daddr, 0,
> -				    (struct sockaddr *)(addr + 1),
> -				    sel->family);
> +		if (!pfkey_sockaddr_fill(&sel->daddr, 0,
> +					 (struct sockaddr *)(addr + 1),
> +					 sel->family))
> +			return -EINVAL;
>  		break;
>  	default:
>  		return -EINVAL;

There are few other calls to pfkey_sockaddr_fill() without checking, but
family is already checked in such case, so it is fine.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

I am not sure if it should be a fix. If family is set there is no
problem. Probably it is set in all cases. Maybe you should target it to
net-next, but as I said, I am not sure.

Thanks

> -- 
> 2.42.0.windows.2

