Return-Path: <stable+bounces-192737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 290EAC40805
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2935A4F27BD
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 15:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573432E5B2E;
	Fri,  7 Nov 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ejgLOU5L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0jNIOSff"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10820322;
	Fri,  7 Nov 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527711; cv=none; b=U4DaNNbDMkEPlo3+0Ju+lYTXA9sA0EBNp91PWa8Bzw6lw73WrAI9vtevt7Euck+osBog5NB2PtGeCPRfdo4LZJNmADjcxsb8RQbZDTLhW4ne4vX6WU5hjco6Ol+JtlNgwCe5V3lLhBaJb27Mj9fjicgJEXDHLwdZAZwhqAZd1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527711; c=relaxed/simple;
	bh=hKX9NqHwPyvWQ9qAD9KYGenqTfpej1gkT0MLEjS8A8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCdyJGxAa5LYmzRMza7naZBGjhaKquhVFDW5vIar42OUHWhFe8hcXKX9PYZqkW77euLLS4iexVf5Arc/8kssrNsRjKHoMqni8RMJA8RWXa0gqVpJmTMcLcG9WBjU8ccZsgNUDgkfiG8brDGZbVSepl5gAWdllb2BIy6dW3FU80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ejgLOU5L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0jNIOSff; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 829037A007A;
	Fri,  7 Nov 2025 10:01:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 07 Nov 2025 10:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762527707; x=
	1762614107; bh=kRC3srLxdI1/rQQ/YoHbTjMKAUDZ9Yv07eN0UYC6WpM=; b=e
	jgLOU5LVPVIW4Vqg23pausJkqWeXnBJUy3J9Cl/TdM0KtDDL1I6KzhgTISjz5R/j
	hb3lR5lDhMe4AtpH+8M6h/vAuz3WVmLoDcE7qgcDMbhx0SKnhWrCNqSy5q8qvAD2
	+T5yeTRzOpSIaPbQC84JNz6yeUGlveD3cHB+ON7ZbFmlyV+SIOjPTDOD2UFOSSxy
	fKKWFpPBFoUb93Y+29u7aULrMh1UYhZfn7y48VGneVQjbXKQNLO7+2XcvMVR8xrd
	ehY34muZJJdl8ougCTm/TbU+WFsyfifdOkvkFxSbPmfg5Lt34DWqNBPGPkQzmGfG
	DPpaGnDFDF0q9863vGYgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762527707; x=1762614107; bh=kRC3srLxdI1/rQQ/YoHbTjMKAUDZ9Yv07eN
	0UYC6WpM=; b=0jNIOSffa2YjszV07iP5dGCWcN1vaAWgmfm90aLwh9WU/1Speo3
	lkQ0HZD6r6s08ePOKVqyHTV7hwEOgx43eq4SMDxPuwVzDk60SgfPPVdqxRWpUGTO
	x6LgPHbLzml2gl6UzpGAJUdjgSe0wh+BJpNObmqi4LlLc/mUtqZWxf1aH50HL2+g
	5OeogsgpIOwmGBhyy7dMZQjJg80ijCMnRTPjaNN7K4uBrgJ8yngb3oK+zbPjgN9K
	4yx0mgek5QR6sUQ+jeoA8OYPVp7wUkOtPtQjwOlqNxClmVfm96L47gLWZ7rgukQW
	1D5idUXrv4KtqCA3wCLzxGt2jtiLDb2E0QQ==
X-ME-Sender: <xms:2gkOaYnUOBRnwm2fJE2NyZAqJsuO5MIEgecb6UzQX3WAaS94Wxox2Q>
    <xme:2gkOaYwSqqO6wrvD1ti-aX_CfR6uMwXdndP5vqhFNIT-9aNk1l_zJBft-L3ahjFs_
    wrhvfvo1qCwklnGKydc81_VdcdtnjnzOx1ASiNQArmd4ie0XF0H>
X-ME-Received: <xmr:2gkOaW-z0NtPh6C5kfQqu1Vm642faVK2gY8Sdn9PhG24hXftvhWIiWl5skSz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrthgvrdhkrghrshhtvghnshesghgrrh
    hmihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgrthgvrdhkrghrshhtvghnshesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhmsehquhgrnhhtohhnihhumhdrnhgvthdprhgtphhtthhopehjrggt
    ohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgrsghlvg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2gkOaTDq53Jgw1U8DCshPHCxtO8t4-4bKpreJHHfyXTW-pj0LEwkAw>
    <xmx:2gkOadp4W4egqUEzFYldwrGIIbQr1YFALSk2NMNAaP4p2aqggETtxg>
    <xmx:2gkOabkPw44DdaGNNfKGqH83-MfJ79Wc1YsN2-A27lN99soUKFdtAQ>
    <xmx:2gkOaQWEm7gWmEMh7-id5epnQ1AuQobqhkshppXDKWoJtMu7QPy4Qw>
    <xmx:2wkOaXpXvzicvBosjEUjzcAFKlm12B3wVhMvXi6b-_JonzBjEX0Xy0cO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 10:01:45 -0500 (EST)
Date: Fri, 7 Nov 2025 16:01:43 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Nate Karstens <nate.karstens@garmin.com>
Cc: netdev@vger.kernel.org, Nate Karstens <nate.karstens@gmail.com>,
	Tom Herbert <tom@quantonium.net>,
	Jacob Keller <jacob.e.keller@intel.com>, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <mrpre@163.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Tom Herbert <tom@herbertland.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
Message-ID: <aQ4J169gBFHVzAJa@krikkit>
References: <20251106222835.1871628-1-nate.karstens@garmin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106222835.1871628-1-nate.karstens@garmin.com>

2025-11-06, 16:28:33 -0600, Nate Karstens wrote:
> The `len` member of the sk_buff is an unsigned int. This is cast to
> `ssize_t` (a signed type) for the first sk_buff in the comparison,
> but not the second sk_buff. On 32-bit systems, this can result in
> an integer underflow for certain values because unsigned arithmetic
> is being used.
> 
> This appears to be an oversight: if the intention was to use unsigned
> arithmetic, then the first cast would have been omitted. The change
> ensures both len values are cast to `ssize_t`.
> 
> The underflow causes an issue with ktls when multiple TLS PDUs are
> included in a single TCP segment. The mainline kernel does not use
> strparser for ktls anymore, but this is still useful for other
> features that still use strparser, and for backporting.
> 
> Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
> Cc: stable@vger.kernel.org
> Fixes: 43a0c6751a32 ("strparser: Stream parser for messages")
> ---
>  net/strparser/strparser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Nate.

-- 
Sabrina

