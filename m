Return-Path: <stable+bounces-171641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236BFB2B179
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 21:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB0D3B3D98
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F7288A2;
	Mon, 18 Aug 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="SDkGGXoh";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="vUO5nwf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738391DDA14;
	Mon, 18 Aug 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544809; cv=none; b=MbA0UBXrDbVAoEasrO9UvCR9bIoYH7P6FQwr13L0Bb4ym/kxMOmKAElbO7n6axFYBcMNkAkI3mat2lsQnb135kRA4Trwt20GP8BzmmnHYTTaHIskN7m06zZy/6h8QzHG7JDdbX5RHnZy2kzPxS4bcmTpBpSHI3rfqKmXjsJ8qFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544809; c=relaxed/simple;
	bh=Wza6qtvZhTFrsjhfzsFGqK4N3FfU9M1gdnS7kNEhwZI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u+YvgZNb+bg9fZTna76fyve2n/XmLDagqHATs8PvTsXbzSJkWGuAHONK4dv7t4MIFM+g8i0PcMXlbCJiu6dew4QIMUCGWw1ekxOhHK0X3veVqEeL3JHF7zfafhiqcr/OxhA8aCaHMWbQPDHYOtGHzyA92uZUqhS5fShIB+nxBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=SDkGGXoh; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=vUO5nwf5; arc=none smtp.client-ip=160.80.4.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 57IJGC2e003941;
	Mon, 18 Aug 2025 21:16:17 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 800BF120537;
	Mon, 18 Aug 2025 21:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1755544567; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdX4L3NmB2YU0Xr//TXuddy8lAr+NTspye2ibC+fj3o=;
	b=SDkGGXoh28iXoHQ6mSz9HlZasWoXW8YZJMZieYprVE52A1fsb0jpX0658NbzUDnaN1L/Xb
	/Dh4TFAPv7IiDyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1755544567; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdX4L3NmB2YU0Xr//TXuddy8lAr+NTspye2ibC+fj3o=;
	b=vUO5nwf5L5rmgxp/B2En7sHsGZTLV5/yiwSHCfVI1Hzgenz2puhEkvC0VEXA6sw1akBNHI
	o8VuxnH8RHY3katDlVOs1kW4vE6H+Y7hP1huK0bE4RwMqfG8gdO6FRgM3AgcgRzss+BYHX
	ewJTb5lP+LxyxlRm1/xqdSUlOLXvYOWVD3BR6L1loS2Wz/kNjlmuCsAYSWIxn/QHUwyb0Q
	kR8ueb/5xCVRK+M3rP3mOn2VYFRfhpNs1+d+zHVtuDBhir/gB8Ukv8J8hxRoEFqJiR7mn0
	JJSl2z3DWN8xgwNRHKtUgmifyvMVRlH5Sk+qGNOgpvIMkZTEjI5R/OcYbM9R+w==
Date: Mon, 18 Aug 2025 21:16:07 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, David Lebrun <dlebrun@google.com>,
        stable@vger.kernel.org, stefano.salsano@uniroma2.it,
        Paolo Lungaroni
 <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next 1/3] ipv6: sr: Fix MAC comparison to be
 constant-time
Message-Id: <20250818211607.c8eb87fbac2f81774022b54b@uniroma2.it>
In-Reply-To: <20250816031136.482400-2-ebiggers@kernel.org>
References: <20250816031136.482400-1-ebiggers@kernel.org>
	<20250816031136.482400-2-ebiggers@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Fri, 15 Aug 2025 20:11:34 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> To prevent timing attacks, MACs need to be compared in constant time.
> Use the appropriate helper function for this.
> 
> Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  net/ipv6/seg6_hmac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Hi Eric,

Thanks for the fix!

I believe it would be best to submit this fix separately from the current patch
set. Since this addresses a bug rather than an enhancement or cleanup, sending
it individually with the 'net' tag will help facilitate applying this patch to
the net tree.

Ciao,
Andrea

> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index f78ecb6ad8383..5dae892bbc73b 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -33,10 +33,11 @@
>  #include <net/ip6_route.h>
>  #include <net/addrconf.h>
>  #include <net/xfrm.h>
>  
>  #include <crypto/hash.h>
> +#include <crypto/utils.h>
>  #include <net/seg6.h>
>  #include <net/genetlink.h>
>  #include <net/seg6_hmac.h>
>  #include <linux/random.h>
>  
> @@ -278,11 +279,11 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
>  		return false;
>  
>  	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
>  		return false;
>  
> -	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
> +	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
>  		return false;
>  
>  	return true;
>  }
>  EXPORT_SYMBOL(seg6_hmac_validate_skb);
> -- 
> 2.50.1
> 

