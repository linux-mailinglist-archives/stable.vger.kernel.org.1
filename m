Return-Path: <stable+bounces-248926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPENCkeVB2pU9AIAu9opvQ
	(envelope-from <stable+bounces-248926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:51:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FA558722
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E68D3300253D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA753ED13C;
	Fri, 15 May 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcjvZuKz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76E3E8C4F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880993; cv=none; b=GwLyK0YnuJc9ijJAzjlubxxB2X5NeNWVDB0h/sqTInc5+LGDsWGd3yEtIJ7Vbd6EPJoDn8i/6xBJG1N7N1pX4kjszKtCzV7KEoTh121sHoISyVajY8W9jDGsF9S9mYOtkYjXwlYBXpSE4Ci/1tNfWpjOERtwSA9tdrcOaOeSxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880993; c=relaxed/simple;
	bh=hlAOhLGh58Gy3zan6ewmiQ7pq8blPJAAQ8CMHzesHaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3+BMRvhNxIu0cgJRkkF01dvwCIg8axUYd2fuHETrQr5HThDCMulzKj5A6aLtcrUFAUTsZQIUgLmaNKjj2Mv4AKE64+bGLMZbnXs5phu91PPfzyWqUao2utv/2ctdzUNrdps5n3S7Pn9De2uKrAeBimcpJwAlBg3nwV2/R/c3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcjvZuKz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba4a1a0325so2619175ad.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778880991; x=1779485791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl3ISS/q5ODJOgUNvJqQup6LUHmvQRG/4621LRENO2M=;
        b=IcjvZuKzQQ7GlGStkVKGcO8VaZv5Y1gqGewN/waRGok2q3hQ7vfohyRhZigSwTw3F1
         PMImTmq00PceeC+zt/TLEFUQWiCZpQOjlrz395hXRU+66mlCToG5LzO6swuOdhhT2bKV
         vlqRgttZ2qJydgmjynhgP5aNBsvgTYQjF62FCZzVrsCJ7MwD/Iy3IadrUARnhiOIQQqy
         qUjcXYmlC74ibpN90tVCF7ZIT9iU+7T0HshnLD/EvwAH7CXVPE8UAtWdUboanKhjDqPL
         +xbSRI3B5kUXgF4Dj/OZYMAvnEqOOh/Z0rq4YAr0dF/N7cb4L35X2VhucX9gwAdB+c+v
         WgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880991; x=1779485791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl3ISS/q5ODJOgUNvJqQup6LUHmvQRG/4621LRENO2M=;
        b=PH+yT9yJORV6D8NPWRtARqarkBIBwlEOVHvF/OmRWtPqUbfSLotEqgsPJEeZhGLzLu
         EZ/uKAvtfaVL9401QMaaTDrG6eKdOIBxqNkmZUPUd1SQr6KqkybN12JpIFBwVj+kKvG9
         WkGv1Mb1W6ojIyg7NgMumn2fd8bVM5ycBHzVoJp0n7hMJUI7tWcx+vPz7WOI85JOcqG0
         VLqYoEIJkHsXfU9xev94qYehFyRfEt5ChBf7VQ+ah4BhdpmF3WsLSFuuF1cqzxGon1Rd
         K7x5SaCGVEkgeo664SREe2iYv1EwgnWQmq52o8zY5FWdaP6OD3Bopeqpe4xNonx8tkDe
         Gjxg==
X-Forwarded-Encrypted: i=1; AFNElJ+0agce3D/AAMg3MxLH2Smj6s/h0STgrms2Jm5gQZobMFsqCpTTpJq8DG0TaNifnhKKCwtIeBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDejX9qV9nWY7EbXWcOsCwQQEeV2kPh9UHjyFfvC7cU9b9aWJ
	yTO//uM2p9BkX/uBEl4xMl8KILZgnTQnLr3ZDceAcVpuoyxWCm00SE6f
X-Gm-Gg: Acq92OGqU6G1VqjkZHDyIqils+wJSHeQJA9N9/xrPmJMQPa8TgLo2hGJ/r48vxltDH1
	7JAdJcaJHRBLWW9tGPmJH5GvuJqC471gzEQ9XVKHIG4HV+B8P7lE4s4Wz1hb48geImJ6BPQWynI
	/kyQT03UNTNY1P40Jhh3LejhdALZWLET0YmEBtopk0NBfbe45NJyKpiw/oWaxqrwEt6e/ti3KFU
	77S9orpgRy5qAWMFYJkzp//CAc6/Zo2Wq1LbeET45dA2oXSTS2eR/WKLUgdNs9gRR7NLNQmkQ7J
	x/GcGG0/22xUADE5VYlniw6KSyieuLVr+5H7bJBEzcQAbtQ4lOvHxKT6n7L1yRtgLPfH6+n31lV
	lVapS3lVM6O6jQjflCrgV8xuQxejTeWl2ExV08EN3GGyvj4DRPyfI/DKXXh23vO0EO53o2xsB5D
	GTZWDx0+r99QpasdCCykGVKBdP0c59x1luMtu4GVF0tvo=
X-Received: by 2002:a17:902:fa0c:b0:2bc:dca9:f0ef with SMTP id d9443c01a7336-2bd7e8cbbc5mr40307095ad.36.1778880991168;
        Fri, 15 May 2026 14:36:31 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fae5sm70746195ad.6.2026.05.15.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:36:30 -0700 (PDT)
Date: Sat, 16 May 2026 06:36:26 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, sultan@kerneltoast.com,
	sd@queasysnail.net, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <ageR2qzTRtpH8JGY@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
 <20260515164121.2608076-1-aaron1esau@gmail.com>
 <ageAmZcEMu4Yjyyl@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ageAmZcEMu4Yjyyl@v4bel>
X-Rspamd-Queue-Id: 390FA558722
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248926-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,kerneltoast.com,queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,linuxfoundation.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 05:22:49AM +0900, Hyunwoo Kim wrote:
> On Fri, May 15, 2026 at 11:41:21AM -0500, Aaron Esau wrote:
> > skb_segment() propagates SKBFL_SHARED_FRAG from head_skb only.  When
> > segments pull frags from frag_list members, the flag is never
> > propagated from those members into the segment skb.
> > 
> > There are two miss sites:
> > 
> > 1. Line ~4986: a new nskb propagates only from head_skb, but frag_skb
> >    may already point to a list_skb carried over from the previous
> >    segment's iteration (i, nfrags, frag_skb persist across the outer
> >    do/while).
> > 
> > 2. When the inner loop exhausts head_skb frags and switches to a
> >    list_skb (line ~4999-5002), frag_skb is updated but its
> >    SKBFL_SHARED_FRAG is not propagated into nskb.
> > 
> > Your v4 GRO fix means head_skb will normally carry the flag, so
> > skb_segment() picks it up indirectly.  But skb_segment() itself should
> > propagate from frag_list members directly --- otherwise any non-GRO
> > frag_list producer re-exposes the gap.
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4986,7 +4986,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >  
> > -		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> > -					   SKBFL_SHARED_FRAG;
> > +		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
> > +					    skb_shinfo(frag_skb)->flags) &
> > +					   SKBFL_SHARED_FRAG;
> >  
> >  		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> > @@ -5000,6 +5001,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >  				frag = skb_shinfo(list_skb)->frags;
> >  				frag_skb = list_skb;
> >  
> > +				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
> > +
> >  				if (!skb_headlen(list_skb)) {
> >  					BUG_ON(!nfrags);
> >  				} else {
> > 
> > Site 1 covers segments that start mid-list_skb (frag_skb carried from
> > the previous segment).  Site 2 covers segments that switch from
> > head_skb frags to list_skb frags mid-construction.
> > 
> > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> 
> If I understand correctly, triggering this in practice requires both
> an skb with SHARED_FRAG asymmetry and that skb reaching skb_segment()
> with GSO set, is that right? Looking at mainline, I couldn't find any
> code path that produces such a combination.
> 
> Do you happen to have a reproducer or a concrete trigger call path?
> If so, please share, I'd appreciate it.
> 
> Anyway, since I consider this one of the "relatively" more concerning
> items among the "potential issues", I'll wait a bit longer for
> additional reviews and then include it in v5.
> 
> As a heads-up, after this one, I don't plan to fold further "potential"
> fixes into this patch. This patch is intended as an urgent fix for an 
> actually triggerable issue, and the remaining potential issues are
> more likely to be addressed together as a separate batch later:
> 
> https://lore.kernel.org/all/20260514163802.1d49d7cb@kernel.org/
> 
> Thanks for the review.
> 
> Best regards,
> Hyunwoo Kim

Ah, I see. you've released another exploit publicly.

https://github.com/v12-security/pocs/tree/main/fragnesia-5db89c99566fc

It looks like the exploit doesn't work because the GRO propagation
in the already-published v4 patch prevents the SHARED_FRAG asymmetry
from being created in the first place.

In any case, v5 will be submitted shortly.

