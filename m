Return-Path: <stable+bounces-247162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KcSMBqiBWo1ZAIAu9opvQ
	(envelope-from <stable+bounces-247162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FE54052F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BF54301572C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBDC3909A4;
	Thu, 14 May 2026 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VS5aZHUb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="srz6LnlD"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A8386572;
	Thu, 14 May 2026 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778754071; cv=none; b=W2rhQVI9Yg5IbOH0P4S8/687a5QyhbZmvevYs0wDSMPi1RaPSsnPFsG/xzAv3hhfXLhVtH8mxJl2ks1oY5H5J4YlZz7MQKpoVAn2WRlLROOB3VqNOWOg8VuPEmv0vRr1v0IdiycMKWKi+LTef2qaiquu5Si48j4K45ZAjpS0ZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778754071; c=relaxed/simple;
	bh=fyftp4iasBnUciMCnM4ih4eUsfsD+0Ri23BKLLqY2ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2NFLpGUG1bhqKKMDo+UEeIS/o6YHYfGQG6UJqSpuRaATnKE7osRc2p3TtaWZM3YGSNlLU8ZZBm1h4nHfpuWhTqENPY7NJeRrjF6Fyp6biMEreDGY3CxiDEDdHv2RN3QXfqo+GQpOs7LuCdae+fqdYpDkY/WDYa7cm7UErcc1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VS5aZHUb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=srz6LnlD; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 96F33EC021F;
	Thu, 14 May 2026 06:21:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 06:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778754067; x=
	1778840467; bh=oF8/clMVOVZTaaaI32fozRcP/Wi9a3HrHpi5Mv76kI0=; b=V
	S5aZHUb5RPGhOhQnfFh3G4dJ7exkG4pk2NQXht8jHBSL+7QQ+rImjSWTrFQoLcqM
	HGS26c9Uv62aScZ41am969nLFzhgAI2JoHUdpWD4Nk9J7wlYor2CfUVMMuZQuLd9
	xtMNKMUK2z9bYebj4k7+xD2D5p3ya1Sl44SPCznuT/y9GYyrPT5xh4mjQbyPX09M
	F1DAF8xURY56SLn6gvnfb8TGbBtM04NI0234pCnQvrAocg9Tu7RYBL+jyIBrRzCo
	x5VydIebM5RBOObgyWvzLW9j4F/3A48agi/xZsgsTn5ZNfud0FqiE3tzEFeF3uq7
	s1tZ1dm+6fJmzTU2l1Uug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778754067; x=1778840467; bh=oF8/clMVOVZTaaaI32fozRcP/Wi9a3HrHpi
	5Mv76kI0=; b=srz6LnlDTMXtHv3m8z7dsucblkUkP9zWHgkFixn/QS+MRV/UUWP
	1Qo7HO04W5+zDrUwibHJUDGlpxvi7QOrtRKaFtnm4kXUUwfq/HSByRFBUjP6NdnO
	4nRfgZbjzOFi5wgR97phkLuFe2MmkUB5KWaSUu1ywBLEP8+fDSbXUeJgChC7Achr
	1A8KCkcoHVRzje0GetL4fkiEi4D6ZnvZ7IvsHQvYqVLof35khCwGEZ23un+ApmMo
	VlrLiqp+zIrsCbE5Aq4ULxxsSqJF2S99eBOPQJ+YjaFrcYGwNZzLwxn06JEO0Tcs
	VMaW9MtfNjuDYXcUWQilqvOncO60FrjkEyA==
X-ME-Sender: <xms:EaIFamyImrPr1ohksyZhJvs_5zPXw5VapGcAZkWBtr7qkSaxW-2PFw>
    <xme:EaIFauPcMQSw6pLpb5jEkbwO3ngpLBEdB0QTCEPWreAzuGIutWnyr25Ljt0uYz_zT
    GRU0CK4aj8NTvOuo4rm5tsgTZ5KHc0DsZ12xpv8HHr5frnIhIoyz8M>
X-ME-Received: <xmr:EaIFauea1NNJspmCLGH4vcWRSPYWY914xpDqigqxjihLXHr4c8lxGlS8n10ysc5d6W3DK_sYs6uzymx1vJGXZkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehimhhvgegsvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhrghl
    sehrsghogidrtghopdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
    dprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EaIFai5XS3YJ6722Vai9ffVY4TNuq9NOkelNN-vWCdj4GMCi5dD2ow>
    <xmx:EaIFamIlj13qmb0dxB7qgdstrg4MfG30Fz64qwhoXeyO-4VWXIxvew>
    <xmx:EaIFam6SCYEJQ1qGK7b3ShqpX-vpudhDV9CBIZsBOuQC_aRYI5JbTQ>
    <xmx:EaIFalZMqTakV01b7_KSkyKLnBHVyvkHSrbDHlFwoSPPWlQlqb3Yeg>
    <xmx:E6IFagyq0Bl9nsFPUymvN7fvbKgePQ0jUgpv58QyXwdQelrwzOx6EYkj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 06:21:05 -0400 (EDT)
Date: Thu, 14 May 2026 12:21:02 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org,
	steffen.klassert@secunet.com, netdev@vger.kernel.org,
	stable@vger.kernel.org, mhal@rbox.co, davem@davemloft.net,
	horms@kernel.org, edumazet@google.com, kerneljasonxing@gmail.com,
	herbert@gondor.apana.org.au, vakzz@zellic.io, kuniyu@google.com,
	jiayuan.chen@linux.dev, ben@decadent.org.uk, dsahern@kernel.org
Subject: Re: [PATCH net v2] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agWiDlvu351MSuqO@krikkit>
References: <agToIEDI4TaTNLRb@v4bel>
 <92ec6190-0255-4b7c-9524-254cb37476ab@redhat.com>
 <agWYGuJ__OtpgjnB@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agWYGuJ__OtpgjnB@v4bel>
X-Rspamd-Queue-Id: 3F7FE54052F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-247162-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,secunet.com,vger.kernel.org,rbox.co,davemloft.net,google.com,gmail.com,gondor.apana.org.au,zellic.io,linux.dev,decadent.org.uk];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-14, 18:38:34 +0900, Hyunwoo Kim wrote:
> On Thu, May 14, 2026 at 10:04:29AM +0200, Paolo Abeni wrote:
> > On 5/13/26 11:07 PM, Hyunwoo Kim wrote:
> > > Three frag-transfer helpers (__pskb_copy_fclone(), skb_try_coalesce(),
> > > and skb_shift()) fail to propagate the SKBFL_SHARED_FRAG bit in
> > > skb_shinfo()->flags when moving frags from source to destination.
> > > __pskb_copy_fclone() defers the rest of the shinfo metadata to
> > > skb_copy_header() after copying frag descriptors, but that helper
> > > only carries over gso_{size,segs,type} and never touches
> > > skb_shinfo()->flags; skb_try_coalesce() and skb_shift() move frag
> > > descriptors directly and leave flags untouched.  As a result, the
> > > destination skb keeps a reference to the same externally-owned or
> > > page-cache-backed pages while reporting skb_has_shared_frag() as
> > > false.
> > > 
> > > The mismatch is harmful in any in-place writer that uses
> > > skb_has_shared_frag() to decide whether shared pages must be detoured
> > > through skb_cow_data().  ESP input is one such writer (esp4.c,
> > > esp6.c), and a single nft 'dup to <local>' rule -- or any other
> > > nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> > > skb in esp_input() with the marker stripped, letting an unprivileged
> > > user write into the page cache of a root-owned read-only file via
> > > authencesn-ESN stray writes.
> > > 
> > > Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> > > were actually moved from the source.  skb_copy() and skb_copy_expand()
> > > share skb_copy_header() too but linearize all paged data into freshly
> > > allocated head storage and emerge with nr_frags == 0, so
> > > skb_has_shared_frag() returns false on its own; they need no change.
> > > 
> > > Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> > > Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> > 
> > WRT the 2nd fixes tag, I *think* f4c50a4034e6 would need
> > additionally/instead a follow-up similar to the one mentioned by Jakub here:
> > 
> > https://lore.kernel.org/all/20260510084520.476745b5@kernel.org/
> 
> Agreed. tracing SKBFL_SHARED_FRAG propagation paths one by one is
> not a robust direction for the fix. Even minor logic changes elsewhere
> could cause the issue to resurface.
>
> As a follow-up,	eliminating the in-place handling in esp_input -- accepting 

It would close this group of vulnerabilities, but there are other
parts of the networking stack that consume this flag. For those,
chasing missing flag propagation is still a useful task.

> the performance trade-off -- seems necessary. That was actually the
> direction of my initial proposal:
>
> https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/

But you chose to abandon this approach (I guess because of the AI
feedback Simon forwarded? feedback doesn't necessarily mean "drop this
entirely").

-- 
Sabrina

