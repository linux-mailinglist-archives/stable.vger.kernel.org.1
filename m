Return-Path: <stable+bounces-247395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEuYHTa4BmocnQIAu9opvQ
	(envelope-from <stable+bounces-247395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:07:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B5549DA1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A5E9300DD65
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CFE377EAB;
	Fri, 15 May 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgkUg8B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81824677B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825265; cv=none; b=OCfAyaw4u8UT8WMmL7ieYLL2slbjQROTyPBUwLABGHv3ONyPtd3XRvffLyWiJ9gCIkoUxKf7EdwE0c8stDiTV3IpYPFz+8geUnoh6pBezO88NGBuDmTZMb7/pVjPuppp60Em6W/ixjMdeOP+/DGVc+47gZeMnDVtf6CYSw7wkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825265; c=relaxed/simple;
	bh=+os5diGbM0rQuQsh1pnR7VysuCSPjKqRUmyB+QHMOog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxW8SdDLBaMaRpv0Qv/EkCE6sb6A+SNHq+Z/M5RhvenbqINUd4gjBuzdqASHmpcLTPh0xFKAYPhZPnBJ4dlxDz2DROW0s0h5A1fKbtKhxWD5xk1W9tqSqNki8mC0XAbpOB0qY6It8hvAI6IKK8YLWev/lygsKtwGkdFQFyo0HEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGgkUg8B; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c827313dac0so274186a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778825263; x=1779430063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itu1od+G5dozoGgTbnQ0j5SYYRoj4kQeiJIPcCU4pOI=;
        b=NGgkUg8BI2nv/Ork8CXqzSiHg01ryrpFNil7mDOZ9nPRVSpPp9iY5rA6c7KokxRBCR
         a274nHse3H9vi+SVuo/GkFQn96sCNdvuQzvPMfBn3m4NLbxzhRGsPBSjRQsJIpzGPHId
         dN7SdG3lprgsntNbqEijvJs7NvBkyRcSq2nTFzXXljYKYMzkPKOJbBh/X2Gqk+Ka3UL0
         94fk4CWwi70u6yTNgJocaR977sNcaaDvJtna6QLkwk4v/WFavjZLr9lEUlyB09leZq7R
         uKX1KxWA1V6Xw674tt3w87O4He2HEKiI2O4Jt7JdUTDwis7KZx+55TLZIrLzb6ALAFIO
         xYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778825263; x=1779430063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itu1od+G5dozoGgTbnQ0j5SYYRoj4kQeiJIPcCU4pOI=;
        b=S8AROZjh28x+eUmWUZC3waUKuyn/0KfelGd6kQ7paWs9UZaEf/Xp4jyKe26XOM53xo
         C6WdJXe1/eRYzd5Eo6d2A8I4xLKWDoalFmwDVhdjTHpRBlidhESYXH5PC8G/SgNVi6a/
         z/2MPqLrCeGllLK2ldzazQifGaBRaiC0mLk9E1Jsb6hSd0bH/1XohOqgOhuhelGZSaC5
         r0U/quyeZU/i/qfPD3X7nKchMCL+c2FHGtoM6nmk/ZULDJqYfR0T2nu7FCMVLqhz/OXT
         IWBnIss2UnTwJy4fGy/i/zOnpfoXa1ZQ4k3acy7nHdtyi/o7r5AGw8X33j1rmRaC1K/3
         9+Yg==
X-Forwarded-Encrypted: i=1; AFNElJ/iQL2+xr+mMsLn5rMOybtf2WtzQGT/vDs2GwSSt+3mtc6vTCvpd0mLYIW1oJIMARVu0TV0D0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Z154b+Tnafr03LMciK/iVvwuMyJcJxEhqOlocXQSArdSeAmL
	0U01FBVjVaOSunHFw6LujHztDUgcg+oJEHqFUHftWInu4tpSdhHGzQ5N
X-Gm-Gg: Acq92OF2Q21oIp9/VX0sxi9lT4rucLLB4NpaT5/SVX/XevVpxSxclGaqIeN+us6O/LT
	XMnaamfoOERTeSF8dd7NAsIIu1PMAN5w67yx5xyphCHPNFl6B3cPriNaT+FlmD40Ma+Ig0bTXLt
	mR/4tvZFAIjEyEYxbtwMVayOwJMb9N5xW7tFzx7A9SKF1oPeNqXTeXIkpcixG4lrW9pFQShhkrz
	ci1C2mN3zGeYScW0od/a7sd7FOwjO+S5qH8FYPtBhj2rXVeRz9jotYfuxCSJ1ap5g9epAxo8n/K
	FMiVWxMGxKKfZLDc+JCZUpU8SVyHkBD6J8cdcf5kjYADLfNXp/2WhJLq+eaIpiIwJfy6TK5Fj0D
	NUkwK9X2pPjvJ50iti4tgkDnkiIPUpg++KpPyGmLEcirUSpBKbcQSg6mkEtFynv7BlQPI9WbGk7
	3IcNtydgcmxX8zI46S/MDEXQnIvYYBmmfJdlUHvqQHB74=
X-Received: by 2002:a17:902:ef08:b0:2bd:8a97:14fc with SMTP id d9443c01a7336-2bd8a9716d9mr10354565ad.1.1778825263036;
        Thu, 14 May 2026 23:07:43 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d23044csm44639995ad.78.2026.05.14.23.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:07:42 -0700 (PDT)
Date: Fri, 15 May 2026 15:07:37 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	sultan@kerneltoast.com, sd@queasysnail.net, malin89@huawei.com,
	tanjingguo@huawei.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <aga4KZtvaRQAMv6B@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aga1VyHpHaUhnGZa@v4bel>
X-Rspamd-Queue-Id: E11B5549DA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247395-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,kerneltoast.com,queasysnail.net,huawei.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kerneltoast.com:email,queasysnail.net:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:55:35PM +0900, Hyunwoo Kim wrote:
> Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
> to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
> moving frags from source to destination.  __pskb_copy_fclone() defers
> the rest of the shinfo metadata to skb_copy_header() after copying
> frag descriptors, but that helper only carries over gso_{size,segs,
> type} and never touches skb_shinfo()->flags; skb_shift() moves frag
> descriptors directly and leaves flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> The former moves the incoming skb's frag descriptors into the
> accumulator's last sub-skb via two paths (a direct frag-move loop and
> the head_frag + memcpy path); the latter chains the incoming skb whole
> onto p's frag_list.  Downstream skb_segment() reads only
> skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> shinfo as the nskb -- both p and lp must carry the marker.
> 
> The same omission also exists in tcp_clone_payload(), which builds an
> MTU probe skb by moving frag descriptors from skbs on sk_write_queue
> into a freshly allocated nskb.  The helper falls into the same family
> and warrants the same fix for consistency; no TCP TX-side in-place
> writer is currently known to reach a user page through this gap, but
> a future consumer depending on the marker would regress silently.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>

Since they are asking for credit, I will add them:

Suggested-by: Lin Ma <malin89@huawei.com>
Suggested-by: Jingguo Tan <tanjingguo@huawei.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v4:
> - Include the tcp_clone_payload() propagation suggested by Sabrina.
> - Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
> - v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/
> 
> Changes in v3:
> - Include the skb_gro_receive() audit patch suggested by Sultan
> - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> 
> Changes in v2:
> - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> ---
>  net/core/gro.c        | 4 ++++
>  net/core/skbuff.c     | 3 +++
>  net/ipv4/tcp_output.c | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 31d21de5b15a..9f8960789b2c 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -213,10 +213,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>  	p->data_len += len;
>  	p->truesize += delta_truesize;
>  	p->len += len;
> +	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>  	if (lp != p) {
>  		lp->data_len += len;
>  		lp->truesize += delta_truesize;
>  		lp->len += len;
> +		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>  	}
>  	NAPI_GRO_CB(skb)->same_flow = 1;
>  	return 0;
> @@ -244,6 +246,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>  	p->truesize += skb->truesize;
>  	p->len += skb->len;
>  
> +	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>  	NAPI_GRO_CB(skb)->same_flow = 1;
>  
>  	return 0;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9c4e8d331d6d..7cd388504297 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
>  			skb_frag_ref(skb, i);
>  		}
>  		skb_shinfo(n)->nr_frags = i;
> +		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>  	}
>  
>  	if (skb_has_frag_list(skb)) {
> @@ -4349,6 +4350,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>  	tgt->ip_summed = CHECKSUM_PARTIAL;
>  	skb->ip_summed = CHECKSUM_PARTIAL;
>  
> +	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>  	skb_len_add(skb, -shiftlen);
>  	skb_len_add(tgt, shiftlen);
>  
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f9d8755705f7..6e4bb411dc04 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
>  			todo = min_t(int, skb_frag_size(fragfrom),
>  				     probe_size - len);
>  			len += todo;
> +			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>  			if (lastfrag &&
>  			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
>  			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +
> -- 
> 2.43.0
> 

