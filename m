Return-Path: <stable+bounces-86881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA09A47A5
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B3328280B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 20:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EEF204F86;
	Fri, 18 Oct 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb4zJCFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC81EE00E;
	Fri, 18 Oct 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281971; cv=none; b=dW60D7Hp7/7D94QqCRg+XkP+G5W66I/0II9+MEWKY88ejnV26UF8vDL1ipkuHzqr/tKln0SsNaEFPte6ft7LA5rzb2IVAhtOOnFkCsZG1iVLIhXNY0/JCUjMyjyTCD4YyPYWjZ553iV8WfIZsIE3buKvJutU8PYogLbpy1xGkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281971; c=relaxed/simple;
	bh=NDRplZoJAjTIlrEMea1y1ifilNkVNbr5i/t5cR4VDck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFLqMylZvIF/t0Df2gusGcSSNQAQgq6bmTJ7PVAKnn02pgquchqkilDzhCen8QIIwgo0Eisf3e6AKQGoBU0y0KB3VuoFV8mFJk6kv7pEAIJbINo4/uUf+IkEHIuXf9TGNGLIYxfgiZ0N1b2KAtapthH7EL3mExrlg3i7ncjRwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb4zJCFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9422AC4CEC3;
	Fri, 18 Oct 2024 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729281970;
	bh=NDRplZoJAjTIlrEMea1y1ifilNkVNbr5i/t5cR4VDck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cb4zJCFoZdTddyo507eIxxOsg03ce9pg7CenAglPMi99WLowVePDhN4bsZ6G0j40C
	 PeOGU8C2YqDiWqXbWEiFHOSIO2OxICqkinZGWm7QcgrBR0tS9j8ToqUgjxu3huAZFf
	 20NDQLj6bbPGXMqTVG9aYqYOngkc7S9/McsiOyaWk9iNiW0LFMJ9exXQg857JgfLAk
	 bXmKwZ9fok8LlF4qySpghoxOSajNc8+c8ABwl4gNNQmulUziPUWd/HVkBIqSEZ/eGQ
	 BCTfCNiY6S8Xaua8hBghShc7rQ3MHKBzgFsX7SGBv3gilUZE3bjTP09z2uys2kX0pX
	 O9ZuQ84Z/fSKw==
Date: Fri, 18 Oct 2024 21:06:06 +0100
From: Simon Horman <horms@kernel.org>
To: matt@codeconstruct.com.au
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Dung Cao <dung@os.amperecomputing.com>
Subject: Re: [PATCH net] mctp i2c: handle NULL header address
Message-ID: <20241018200606.GC1697@kernel.org>
References: <20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-mctp-i2c-null-dest-v1-1-ba1ab52966e9@codeconstruct.com.au>

On Fri, Oct 18, 2024 at 11:07:56AM +0800, Matt Johnston via B4 Relay wrote:
> From: Matt Johnston <matt@codeconstruct.com.au>
> 
> daddr can be NULL if there is no neighbour table entry present,
> in that case the tx packet should be dropped.

Hi Matt,

Is there also a situation where saddr can be null?
The patch adds that check but it isn't mentioned here.

> 
> Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
> Cc: stable@vger.kernel.org
> Reported-by: Dung Cao <dung@os.amperecomputing.com>
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
>  drivers/net/mctp/mctp-i2c.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git drivers/net/mctp/mctp-i2c.c drivers/net/mctp/mctp-i2c.c
> index 4dc057c121f5..e70fb6687994 100644
> --- drivers/net/mctp/mctp-i2c.c
> +++ drivers/net/mctp/mctp-i2c.c

Unfortunately tooling expects an extra level of the directory hierarchy,
something like the following. And is unable to apply this patch in
it's current form.

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 4dc057c121f5..e70fb6687994 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c

> @@ -588,6 +588,9 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
>  	if (len > MCTP_I2C_MAXMTU)
>  		return -EMSGSIZE;
>  
> +	if (!daddr || !saddr)
> +		return -EINVAL;
> +
>  	lldst = *((u8 *)daddr);
>  	llsrc = *((u8 *)saddr);
>  
> 
> ---

-- 
pw-bot: changes-requested

