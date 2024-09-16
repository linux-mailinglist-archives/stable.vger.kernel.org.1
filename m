Return-Path: <stable+bounces-76523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92497A77E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164321C21540
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF215B57D;
	Mon, 16 Sep 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rd0nGP5p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6tZv6P+y"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2561459FD;
	Mon, 16 Sep 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726512869; cv=none; b=D05vmwQW4jPNjrUFJNnS4MjFUh2NCGMABgce1B3dW3UVtGuTOBgNNh4RfyDgKbXsPr1EKJYyH06hseVv3xs//EbrKjdkZ8xfMUlZDDxzR78EDoiL5agf7oa/8OVQB/B1L7IDSY7f8TR7LpFo1ByTbROg1UKtvdsFh7muxoBXZ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726512869; c=relaxed/simple;
	bh=W/0XgRvvrj+SWosEDYsOeeYcfO/FH0lmxjeTROeBRZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCGKk3Gb+vxYl/M7SDk+rEw4leOY7/iAmO6vWahIoZYVi4jcX38ywQdTHXRy5xcF+WZrBAFmarUraLZBfRUCh6rDRHflKtbAiXrlJYY/Q5fr0J/oL7sXZUP+pbWA9FSR6MfaEJG/1eYAnxUXtcCYwtVnl0w5qGHvOtNHCyYfU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rd0nGP5p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6tZv6P+y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 16 Sep 2024 20:54:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726512863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv/7LY3pNk9pkvxRBMPHj6K22RVaVkFdLdxQltt1hFU=;
	b=rd0nGP5pn6U+1mLATZ5ERArM8STGCCon9Nro3vFmb14K02HDGahaRc3GRu/jJJOZeSn1pW
	eN1vg5RkKD2FVPxa5o7VD9GEojbXP7J7u7Ac4JGrdvaAfwfeMZHCE3pBP4Az9b+f4jkwU2
	zziHysm8upCevqDR2G1bxQJGh2bGzx+ifnhtYs9x1DiXaJyNfAgrVlnlfKeUcikU68N5JN
	CyctiBIl4dGdimlpn3VLbNi5jHK3mcKKCYQ5uc9LlZArnWs6XegydEOFENRIlbx1Fx+qES
	eNBP4d2jd0IaGVmOVWwbsMkKI4AZzeGlyPk3Wa2QsVhcI0tdp0KBM01K/YwvRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726512863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv/7LY3pNk9pkvxRBMPHj6K22RVaVkFdLdxQltt1hFU=;
	b=6tZv6P+yjhDgsIQf9vWkV54siOKT9nLQDa0YUZQ+BxstabivrgK74rhnizlEKq0a+FyOME
	G+Pzj81As3cAZHAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Message-ID: <20240916205246-5df7e565-6950-4503-ac4d-741c37b1afda@linutronix.de>
References: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>
 <20240916184443.GC396300@kernel.org>
 <20240916184851.GD396300@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916184851.GD396300@kernel.org>

On Mon, Sep 16, 2024 at 07:48:51PM GMT, Simon Horman wrote:
> On Mon, Sep 16, 2024 at 07:44:43PM +0100, Simon Horman wrote:
> > On Mon, Sep 16, 2024 at 06:53:15PM +0200, Thomas Weiﬂschuh wrote:
> > > The rpl sr tunnel code contains calls to dst_cache_*() which are
> > > only present when the dst cache is built.
> > > Select DST_CACHE to build the dst cache, similar to other kconfig
> > > options in the same file.
> > > 
> > > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> > > Cc: stable@vger.kernel.org
> > > ---
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Tested-by: Simon Horman <horms@kernel.org> # build-tested
> 
> Sorry Thomas, I missed one important thing:
> 
> Your Signed-off-by line needs to go above the scissors ('---')
> because when git applies your patch nothing below the scissors
> is included in the patch description.

Welp, this seems to be due to a combination of me forgetting to add it,
b4 adding it below the scissors automatically and then failing to warn
about the missing sign-off.

I'll resend v2 with your tags. And will also remove the Cc: stable as
per net rules.

Thanks!

