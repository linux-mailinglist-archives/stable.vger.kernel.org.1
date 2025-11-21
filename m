Return-Path: <stable+bounces-196071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A741AC799E0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D54EC19F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39B734F473;
	Fri, 21 Nov 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aB0ukekP"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CF347FCD;
	Fri, 21 Nov 2025 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732474; cv=none; b=iW44qTpZqhlIdUGmEtOaAkLb/4GRNN/Kvg9LOf7EqFghobfWWpuL/XCz90ayGTRx5LuqZagoAGKkjdYEUlr8Buc2mWYj29fptcmeqDv7IAJywNR7pBJ2ymlAF4Vd25s0N5b/o+DdB3dlm9PuymzRMZcwkfX3K3w7DuUgFerUvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732474; c=relaxed/simple;
	bh=xlUl0585+XOz2fHxVEvTY8HmKk2IO2AE6CSdlJkXTj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuZTteew0FK43PC8KsYLdi9sgc8pobvxU1/b879kPrFZ7q2BQGpdppgomZR0rJVmHRJ3WOXasHC7bx04k0cq3R+bszOJMHddtDKgq1/Mi6qD7sQKEa21EnQohH3Hed+cKmfTRvdlSu/Uq3jMlbAH583WHvxkXzWDZg8ynnNxf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aB0ukekP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PFBZs8t6W0pzfyZ01J5rq91QQeZUm6mtZba2maUekEU=; b=aB0ukekPWbNnoRqGgfvYRe0OzZ
	RUxzQGYPl8gfro79w9oF44YXYroiX3QXTCCmdWd4qNzNT5nBmyMdOhY9LzZz5MzOOGvIBpnxnheQn
	nZVLztM+FqMH9UjK5Mk5CCOUTj4pQdxbHqziEOfU2CNq+mht5TIc+Utr653BrLV9dsoE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vMRNi-00EjfR-A0; Fri, 21 Nov 2025 14:40:58 +0100
Date: Fri, 21 Nov 2025 14:40:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ma Ke <make24@iscas.ac.cn>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	florian.fainelli@broadcom.com, stephen@networkplumber.org,
	robh@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <aec90f22-da8d-4d03-bde6-43fa2bee2e25@lunn.ch>
References: <20251121035130.16020-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121035130.16020-1-make24@iscas.ac.cn>

On Fri, Nov 21, 2025 at 11:51:30AM +0800, Ma Ke wrote:
> When of_find_net_device_by_node() successfully acquires a reference to
> a network device but the subsequent call to dsa_port_parse_cpu()
> fails, dsa_port_parse_of() returns without releasing the reference
> count on the network device.
> 
> of_find_net_device_by_node() increments the reference count of the
> returned structure, which should be balanced with a corresponding
> put_device() when the reference is no longer needed.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6ca80638b90c ("net: dsa: Use conduit and user terms")

Why did you pick this commit for the Fixes tag?

> @@ -1259,7 +1260,13 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
>  			return -EPROBE_DEFER;
>  
>  		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
> -		return dsa_port_parse_cpu(dp, conduit, user_protocol);
> +		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
> +		if (err) {
> +			put_device(conduit);
> +			return err;
> +		}
> +
> +		return 0;
>  	}
>  
>  	if (link)
> -- 
> 2.17.1

You can simplify this to:

		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
		if (err) 
			put_device(conduit);

		return err;

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

