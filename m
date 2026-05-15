Return-Path: <stable+bounces-248908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDLEBWeBB2qQ5gIAu9opvQ
	(envelope-from <stable+bounces-248908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:26:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C4D557683
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4D33034A9B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7B939EF2B;
	Fri, 15 May 2026 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxOGnYgX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7087839B971
	for <stable@vger.kernel.org>; Fri, 15 May 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876577; cv=none; b=MD8so5ZTJ1Of+ilTAtb2X0b2ZPBRHFDKNbH0ITgPK6XOtllX13Rz21Lv1BocIUioGqzVfepBURKqNtkC74qQAldZZjBdI7dAfaVIo+ArGOeZGbaNBsxEDWMgd1IX8HP2Mg0XcKty6LAEyt1gUR7zW+kRdsF1b3zs7l4GwiF+YMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876577; c=relaxed/simple;
	bh=U61/B2ykMg4PfM9Fekj58Selv6Wgresu/kmK7wD1IyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxWH5+mw8uCck9zt9PbT8PRQS01c+JlgDQ8VC4AaT5GPGRzOQR6Iz7h9vkeoMYCnzuhS3HKFRHhHFXSnr9nFzqpysXVhsxk3WHZHVCyfdvYaKXT57Bvp3RWj0jcD3z49NBNbyvClW2w6sAeWlF7Nf3d1rRsQGbk3k0fWI3c+71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxOGnYgX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8016d642b2so679827a12.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778876574; x=1779481374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uvBRYS3NehiSNdfNWS2aMfLUiOXFlz+XSxZ4gL1pi8=;
        b=cxOGnYgXfCMX2pJGU/uqjfMSDRgP4BnnkhvoaKFRFzNvC8pxX2ZMxWjNcqbCEPIejz
         mLlBf0RLzs6qUeOEO5p87u7k1Z64nDAh9c335FCX192PNN378Z2tdarv419BsD5vZUwZ
         cY44DnAi+RPolps7CM+lfwF/pLLEHIoewuVwaoWlfUOcOii8YRPg292Q/PVgvdM0hLnL
         UxECcCylyPcaRITNQHLXeDANuV+YelYejqgiMlsdRCLHj9lORj7Z5xE4R+6C0qow+ueO
         Az7OyIeluiEfFGHwPfKFA+2tmRhcH596cMcfmsot/6FNmkCaLPjzxNgvWwTUqIOpJWMj
         dA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778876574; x=1779481374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uvBRYS3NehiSNdfNWS2aMfLUiOXFlz+XSxZ4gL1pi8=;
        b=LZlawPsDQ20lgNW7eZKudvsVnV0T+JevRP4fnNPG4QIIzphfKTqiDO/ZY7qIfEZNz3
         f6G8xocrGVYshw8YdtjuToxLb1LmpT5heTbvqceNfE/J+9vIqS8GNfVudpD21QpLXswN
         8Hg+iRVUweu3/zK0huRk1yd445K1X/jzrCaGpCx4HurnhUHew8FeNozH7zkbSYhbkPIu
         GaqYhzpX1QOefPNiIh4C3Uvr3TuE7PmAel7Pz9iqmZgnY90U7pqavh2h2dTHlm+QGrFk
         43MopbkzSNpMYN8UikZk9CBSu85hYX7LyQkOd84eefTQe9FThPgJU3TY8lhIdqntwPuX
         TrYg==
X-Forwarded-Encrypted: i=1; AFNElJ+cvpGbE1JoX5yIvtrHryjuSgECMIAT1VJPLbhagR/tFPoO+IaKs9Ti6jpVagz4wqPTUROvl68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwmsuPTEppzHPiAI7Z6x31QBEywc/bZedwApVGtXZaN6NW93tD
	y/fTv/PlimBD7fUGDcUKPuPAwIe05MTNma+vCMnqWX8WRpyB8HNk3nU6TRYSZsDM
X-Gm-Gg: Acq92OFp20eLdRpbJaW21dRfPup9lnOUpmDRUyzCfz4GYgMHdGZt3o7n9DzZNnNfRGN
	xrltZZwRotAlhgs7fwkNWlaAm4CJ12IMJO7e4IDLqW0HmmQZ7jltvd4qltrmHv7/UKyEUXhXqcZ
	fHE0DOVIYywp7Yjkawxl/C/Z/REBg1D+vhLdiwYIGqinh77b9UUtzhjCr8o8COjHi7goMnbztAo
	M9hPZAOET6aqYmcdih6hhSaVjlP4Yn2s1VQUNnqXrGZd+zPPw797xtezDSAygH1VszSfZ0KfLj0
	8U+7aT1Q+4YHZS8aReUQr7q5mc0Xm4TUpnq7+honPT526py8r6q87wyLtttGv5GfmBVRIzZSRDv
	HVLQ3CRTmKskIv3fnbYazPtWkt9hNPVhso/g6b+Od21f2HeD4VVwhMBjjLLqD2MoFNTY4TurptC
	D9DZp8munBEcye18fi2LHLYFxAOCKmhoEHj6l5zMaD935Yij5WIO8oRQ==
X-Received: by 2002:a17:903:388b:b0:2bd:8c03:2efe with SMTP id d9443c01a7336-2bd8c0334f8mr34077815ad.26.1778876574343;
        Fri, 15 May 2026 13:22:54 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm69026465ad.57.2026.05.15.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:22:53 -0700 (PDT)
Date: Sat, 16 May 2026 05:22:49 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, sultan@kerneltoast.com,
	sd@queasysnail.net, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ageAmZcEMu4Yjyyl@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
 <20260515164121.2608076-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515164121.2608076-1-aaron1esau@gmail.com>
X-Rspamd-Queue-Id: 68C4D557683
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248908-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,kerneltoast.com,queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:41:21AM -0500, Aaron Esau wrote:
> skb_segment() propagates SKBFL_SHARED_FRAG from head_skb only.  When
> segments pull frags from frag_list members, the flag is never
> propagated from those members into the segment skb.
> 
> There are two miss sites:
> 
> 1. Line ~4986: a new nskb propagates only from head_skb, but frag_skb
>    may already point to a list_skb carried over from the previous
>    segment's iteration (i, nfrags, frag_skb persist across the outer
>    do/while).
> 
> 2. When the inner loop exhausts head_skb frags and switches to a
>    list_skb (line ~4999-5002), frag_skb is updated but its
>    SKBFL_SHARED_FRAG is not propagated into nskb.
> 
> Your v4 GRO fix means head_skb will normally carry the flag, so
> skb_segment() picks it up indirectly.  But skb_segment() itself should
> propagate from frag_list members directly --- otherwise any non-GRO
> frag_list producer re-exposes the gap.
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4986,7 +4986,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
> -		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> -					   SKBFL_SHARED_FRAG;
> +		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
> +					    skb_shinfo(frag_skb)->flags) &
> +					   SKBFL_SHARED_FRAG;
>  
>  		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> @@ -5000,6 +5001,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  				frag = skb_shinfo(list_skb)->frags;
>  				frag_skb = list_skb;
>  
> +				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
> +
>  				if (!skb_headlen(list_skb)) {
>  					BUG_ON(!nfrags);
>  				} else {
> 
> Site 1 covers segments that start mid-list_skb (frag_skb carried from
> the previous segment).  Site 2 covers segments that switch from
> head_skb frags to list_skb frags mid-construction.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")

If I understand correctly, triggering this in practice requires both
an skb with SHARED_FRAG asymmetry and that skb reaching skb_segment()
with GSO set, is that right? Looking at mainline, I couldn't find any
code path that produces such a combination.

Do you happen to have a reproducer or a concrete trigger call path?
If so, please share, I'd appreciate it.

Anyway, since I consider this one of the "relatively" more concerning
items among the "potential issues", I'll wait a bit longer for
additional reviews and then include it in v5.

As a heads-up, after this one, I don't plan to fold further "potential"
fixes into this patch. This patch is intended as an urgent fix for an 
actually triggerable issue, and the remaining potential issues are
more likely to be addressed together as a separate batch later:

https://lore.kernel.org/all/20260514163802.1d49d7cb@kernel.org/

Thanks for the review.

Best regards,
Hyunwoo Kim

