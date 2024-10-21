Return-Path: <stable+bounces-87544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB489A676A
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D761C221EC
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AB1EABD4;
	Mon, 21 Oct 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9TgoNEQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD41D7E5B;
	Mon, 21 Oct 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511918; cv=none; b=Qxkp9us1b9/RepWHFGFRMbcde3ehP1pACWojbal8KMLVzp8amMDSKyhKiDCH2UgFXGghQ1J6fmRR1iQEjAxOpiEzc+e0D3wVKfU5Em0dJhOs4Q67iecckNh1WkNcfCx9nqhizGcfls8QBubQCaRxF0C7qIhGqvL/m152CHC+mDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511918; c=relaxed/simple;
	bh=9a5VFldN6zVh/rUpVFfhNFaXH3Rcgz+fBDNfZCeivAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXJNbcBxr+uvsr7/1Oh9Jmy8PWYT76Fa/2j2EaU+MxV3G93L/JUWDSmAnQbFkQHKXqfy0rPGzzw+oFhcKPl/G5nh8lQyPk2EJHDYLSkwbzam6zntp+Ll/WZF0t6nOcl1bMYCCTJayemm1/X+3fVfF/ZIgjM9xVXprwDTPpo3U7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9TgoNEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911EEC4CEE4;
	Mon, 21 Oct 2024 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511917;
	bh=9a5VFldN6zVh/rUpVFfhNFaXH3Rcgz+fBDNfZCeivAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9TgoNEQ2vEfk8EA7n/XJotulaqvMrlvm4VbZ5QYar3HxoJzzwQpG4YE8Dud+vadN
	 OuoGnJGtzjc4Rpobz2+ib1g/CaqKBw8Cjy2VqqWummqVBobVsGh8dPs+80qJBJs0Ft
	 AlUONhHl2G8/cEDuaQ4aESXZR1BvTJb3hw0/ydlJlvsWOq8pPbNEyBUVng9n2+TLGh
	 Iw0xgMsmuwk3EazIX6hmnqNzMbbsqKPPhLQ2LJbPKodXB0K83hEH+SJgoibU+hcZPh
	 HIwe7iwpf11BUJmqyVfndbiwSGqZIRVADmkdfftlFnpj5eUHgMPpQX+Kwkpbw4lITC
	 PVXkRhVflHhqg==
Date: Mon, 21 Oct 2024 12:58:33 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Wolfram Sang <wsa@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dung Cao <dung@os.amperecomputing.com>
Subject: Re: [PATCH net v2] mctp i2c: handle NULL header address
Message-ID: <20241021115833.GG402847@kernel.org>
References: <20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au>

On Mon, Oct 21, 2024 at 12:35:26PM +0800, Matt Johnston wrote:
> daddr can be NULL if there is no neighbour table entry present,
> in that case the tx packet should be dropped.
> 
> saddr will normally be set by MCTP core, but in case it is NULL it
> should be set to the device address.
> 
> Incorrect indent of the function arguments is also fixed.
> 
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Cc: stable@vger.kernel.org
> Reported-by: Dung Cao <dung@os.amperecomputing.com>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
> Changes in v2:
> - Set saddr to device address if NULL, mention in commit message
> - Fix patch prefix formatting
> - Link to v1: https://lore.kernel.org/r/20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au
> ---
>  drivers/net/mctp/mctp-i2c.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
> index 4dc057c121f5d0fb9c9c48bf16b6933ae2f7b2ac..c909254e03c21518c17daf8b813e610558e074c1 100644
> --- a/drivers/net/mctp/mctp-i2c.c
> +++ b/drivers/net/mctp/mctp-i2c.c
> @@ -579,7 +579,7 @@ static void mctp_i2c_flow_release(struct mctp_i2c_dev *midev)
>  
>  static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
>  				  unsigned short type, const void *daddr,
> -	   const void *saddr, unsigned int len)
> +				  const void *saddr, unsigned int len)
>  {
>  	struct mctp_i2c_hdr *hdr;
>  	struct mctp_hdr *mhdr;

Hi Matt,

I think you should drop this hunk.
While it's nice to clean things up, in the context of other work [1],
this isn't really appropriate as part of a fix for net.

[1] https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches

> @@ -588,8 +588,15 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
>  	if (len > MCTP_I2C_MAXMTU)
>  		return -EMSGSIZE;
>  
> -	lldst = *((u8 *)daddr);
> -	llsrc = *((u8 *)saddr);
> +	if (daddr)
> +		lldst = *((u8 *)daddr);
> +	else
> +		return -EINVAL;
> +
> +	if (saddr)
> +		llsrc = *((u8 *)saddr);
> +	else
> +		llsrc = dev->dev_addr;

This last line doesn't seem right, as llsrc is a u8,
while dev->dev_addr is a pointer to unsigned char.

>  
>  	skb_push(skb, sizeof(struct mctp_i2c_hdr));
>  	skb_reset_mac_header(skb);

-- 
pw-bot: changes-requested

