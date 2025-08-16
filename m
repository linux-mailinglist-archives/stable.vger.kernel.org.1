Return-Path: <stable+bounces-169864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A554B28EA3
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479301C242D9
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717C2F28F2;
	Sat, 16 Aug 2025 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b="xE5Av/Gm"
X-Original-To: stable@vger.kernel.org
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F592DAFA0;
	Sat, 16 Aug 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355950; cv=none; b=DpUoaTVoj014+EAEgApYjVX3UhVukO5p4uhGZiK4Jm/PNWtRmPCIUhGxhQKCjqmpVYX3WBsgLV6pNsQ0q7lJCcgXf5fbkv+ttNVlXrpkdO2Ufy8vFybnFSyQWNzAzJcfbv2jqq7Ll50rwpWuaoEgNV4wV/e8CZsVhWH3+RNsnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355950; c=relaxed/simple;
	bh=3do6237ns7Jz5GVPzNLh0umlxmUl0oaKcOpEPreWvws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxJdoa13cz9pNE3G8rM0IjB4WucPIIzWPPOoVhhvkjmHOA0QrNXPsqojIlqzQXpn8EnhdUlO3I+w6p6begg7RlkjfZM4L9LkEQ51h2JK0GLs34tb4og/w13aUxuKM77pILGlhkEMelAw6cVDzRjIXyTOKz+fHEyfSCfIk9VOp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; dkim=pass (2048-bit key) header.d=dominikbrodowski.net header.i=@dominikbrodowski.net header.b=xE5Av/Gm; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dominikbrodowski.net;
	s=k19.isilmar-4; t=1755355415;
	bh=3do6237ns7Jz5GVPzNLh0umlxmUl0oaKcOpEPreWvws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xE5Av/Gmg0m6GPDiMyPYUz84tBhSOk1Hi5sHnSoq21aIwuix8GMu8MLECm6aaEjQt
	 UjoGCcvanr5/QpGflDzt0fXqU3fpc0BBp3/+C0CMSC1pvtc7wMplMrs/ipRRXMzN83
	 1m0ASOpTtwM23a9e2KzE2Pb4bVuC3aMwafMvdZZfxP5RODFCH4cRKKZ/guC668AxCS
	 wzyd97L+omantHV/JxW3B5hySn756u1YpyqfQOVyvNRciaktp/ffGSB5o63/ljqQwd
	 WP0ePctVssOq7dULxYCTBDh08HsIbHgdpTqHp6wkuQKi9Nw2XStbe5avBJvzOO7iFF
	 XJkG/2aV9Ygtg==
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 094C320071C;
	Sat, 16 Aug 2025 14:43:34 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 5559DA009E; Sat, 16 Aug 2025 16:42:15 +0200 (CEST)
Date: Sat, 16 Aug 2025 16:42:15 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ma Ke <make24@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] pcmcia: Fix a NULL pointer dereference in
 __iodyn_find_io_region()
Message-ID: <aKCYx6-E-daskCzh@shine.dominikbrodowski.net>
References: <20250812072509.472061-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812072509.472061-1-make24@iscas.ac.cn>

Many thanks, applied to pcmcia-next. This allocation is practically no-fail
owing to GFP_KERNEL and the small allocation size, and rsrc_iodyn.c is on
its way out, but it's better safe than to be sorry.

Best,
	Dominik

Am Tue, Aug 12, 2025 at 03:25:09PM +0800 schrieb Ma Ke:
> In __iodyn_find_io_region(), pcmcia_make_resource() is assigned to
> res and used in pci_bus_alloc_resource(). There is a dereference of res
> in pci_bus_alloc_resource(), which could lead to a NULL pointer
> dereference on failure of pcmcia_make_resource().
> 
> Fix this bug by adding a check of res.
> 
> Found by code review, complie tested only.
> 
> Cc: stable@vger.kernel.org
> Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/pcmcia/rsrc_iodyn.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
> index b04b16496b0c..2677b577c1f8 100644
> --- a/drivers/pcmcia/rsrc_iodyn.c
> +++ b/drivers/pcmcia/rsrc_iodyn.c
> @@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
>  	unsigned long min = base;
>  	int ret;
>  
> +	if (!res)
> +		return NULL;
> +
>  	data.mask = align - 1;
>  	data.offset = base & data.mask;
>  
> -- 
> 2.25.1
> 
> 

