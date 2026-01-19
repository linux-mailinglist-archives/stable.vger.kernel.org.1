Return-Path: <stable+bounces-210394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1912BD3B70F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 20:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 823A930484A6
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B0366DD7;
	Mon, 19 Jan 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPp4Jc4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9D387579;
	Mon, 19 Jan 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768850094; cv=none; b=kIn035Vtveb1ga8KcrsRaTLy89Wi8rVzv6lzToznVMouTqlwJwAo/oJu1keoMNBIRvKhcILF+fX/9w06K90gZaSuuhXVjUtZZYF6KyPmYBo+rKxAc+0VWJ8Mv8LU1h95mWBQTsCbSJsF/FSGyTXf32ndChahYDHhgvvgZcOY8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768850094; c=relaxed/simple;
	bh=YpvvfBGMmGHJD0VZNkSOlySrSH6aKmR+qr7PRT5JzXA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+NBy2QOFPfWHrE2+g4qEe6w3L8Ve1GVTj2ds0bgYfWe77P7aaTeRZ5FL00KPUU5Qb/v8c349GW17gicX/ayLOXQh9s14EBFAF1Hv4/AJbJaSusD1YJclCy2MrKZy513vWUqcKwT8XvqmSjhsj+H6Rf32qb5/e0eeBHZEVI55fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPp4Jc4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7580C116C6;
	Mon, 19 Jan 2026 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768850093;
	bh=YpvvfBGMmGHJD0VZNkSOlySrSH6aKmR+qr7PRT5JzXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DPp4Jc4FquG2JfHQEu8aWrOhFVGtXuN6Hj8bvMFG5YABcg/iZaKXKfrebi4sptcaa
	 g1FzGB3qxA4yxIxEXDmWQdZptfsz5XOSAC8aNYa+hMrGgaKw/gdLYwfQrEojZ83+bo
	 m3O1ag6pu7Zl3vvFU7aYsyP6mxQfXc5S3mN/GTJCDPH+yKJ/6mcWyEGrY1G69HNDqj
	 Ki1rjXxg2aUPOVr/SKOmEwNiKjXt7zhyigXtTHHuj0vLHFhNPBOO7GIJB8SIUtyq/C
	 RWpKbLbvql6iCabgF8UVVIkCrCjj1A6WIJlMF9itXPot65kCGiqoD21YnX+CZvFuvW
	 /k94vjioC1QBw==
Date: Mon, 19 Jan 2026 11:14:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v1 3/3] net/sched: act_gate: zero-initialize netlink
 dump struct
Message-ID: <20260119111452.37dde230@kernel.org>
In-Reply-To: <20260116112522.159480-4-p@1g4.org>
References: <20260116112522.159480-1-p@1g4.org>
	<20260116112522.159480-4-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 11:26:08 +0000 Paul Moses wrote:
> -	unsigned char *b = skb_tail_pointer(skb);
>  	struct tcf_gate *gact = to_gate(a);
> -	struct tc_gate opt = {
> -		.index    = gact->tcf_index,
> -		.refcnt   = refcount_read(&gact->tcf_refcnt) - ref,
> -		.bindcnt  = atomic_read(&gact->tcf_bindcnt) - bind,
> -	};
>  	struct tcfg_gate_entry *entry;
>  	struct tcf_gate_params *p;
>  	struct nlattr *entry_list;
> +	struct tc_gate opt = { };
>  	struct tcf_t t;
> +	unsigned char *b = skb_tail_pointer(skb);

Why is *b moving? Please avoid unnecessary code changes in fixes.

Also -- we prefer the declaration lines to be sorted longest to
shortest. If a dependency prevents that the init needs to be moved
to the body of the function (this mostly applies to patch 2).

