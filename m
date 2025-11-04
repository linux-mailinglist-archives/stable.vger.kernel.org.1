Return-Path: <stable+bounces-192456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA4C3362A
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 00:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588AB18C2CC3
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B52DFA38;
	Tue,  4 Nov 2025 23:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="yBTFQR6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0zltDhmG"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578222DEA8F;
	Tue,  4 Nov 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298946; cv=none; b=untHcS5HZkRki6iJbpQJ9eoFi378rBjqz1k5O6TTA7EL5jPX8bew2zXNPkZ4rz4iFyUenHIQ7/y0Gjq7iWP5F3fmpTV+C9TUGD1s11zHnH/2dBmfHJXGDYZ6fOw7T84B8yX+MZKVm3FxC4iXfY8w8Jva3vM0PdVzWBA/BLuftDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298946; c=relaxed/simple;
	bh=IAYCbutDxV+8B5cDn+cLRc9Kuy667sOtiE9CrMvLnT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbprI8PJoFxByAlAk/BE4JEIb5kcmiPwT7bR7ooXSWmF1tNq2qlGDPsm/eW8JT9URcyLObqm5STrCS0Up1THKX9rZOeO6NA2mZMJtA8tBLjHXLFVQWD94YebFADZTbdWx9wyFiPVdYLMTMjU5tulRVWaothgIng7sRZ0IQ3xmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=yBTFQR6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0zltDhmG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1B147A0145;
	Tue,  4 Nov 2025 18:29:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Nov 2025 18:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762298941; x=
	1762385341; bh=EBaus4dcwmLkGPJEcpKYMG6v7xMgaARAAXfK6VCCHV8=; b=y
	BTFQR6qZaIO80HCsaqcnTldp8PPYXhD3PZOMc3UHEThoq6QjzXreLVuFhSZ3ytgx
	xSxNrBWLgzNis473GrQkXBGCR33uXI1v7+7Y5Go7JJK8skS7r8fG6qG2DNrWzyFn
	LkLczZ8daa5nu6y0IykrN709Bpg55mn7GqyJVg++fBpcRkqQJHwVqQVbAQD2GU6h
	putRUYZHdio7gkOCX5l2Q0vo8x6Ecnz6aNbvf0abilDbtHnwvGJRQ+sg0LrBzVZX
	HA9GMcrYNCXRtf5022KmR+ubW/PFoZ+2nJvs2t7/7Nb27+vI96cTm9J3VBEjGk60
	/6Ycs2d4i5dUp+Vi2ESnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762298941; x=1762385341; bh=EBaus4dcwmLkGPJEcpKYMG6v7xMgaARAAXf
	K6VCCHV8=; b=0zltDhmGzYvn7zRSYubpqq+4rKXyqeVNZWSlQqM67EF3EvlrjUy
	diSmpFZrelg28495tWprQmzRUH9fGPoGzjzEgMgUaChVCwnRAkjF7IEbQQhOxFG2
	fmnYgEelBtEUQqI60LBRtis9Ign3Cd2zx+JyFrtuazMG1ULVCY5ZA6HZ3OuiJJfa
	aGwr/pPxzus8cvBOsvM41bbwN+RiARZo+ulzTTU/dEM1l5mR6TECtxhsasPN/vQz
	DbRIwFN+Ys5F819aUJGzkYtMg71okYiv8pQCCY0cgosw2p2dq7dPGgWe5zZ3Rgpo
	MgDtdTMMWLlbwmoljG8zA+I7zJNE68QL3+g==
X-ME-Sender: <xms:PYwKaSQ3NjwGX5I1PH9tjT1Uif7aaGIqvcbHrThuym7gW2Vf_58I2Q>
    <xme:PYwKaXUR7gMXTZ_v2Z1mYklcksJt4my5KFDZGx7DGPHH-Ei3aAdRQSsd3eQFOzrqB
    GQyLqKoCUiI5A2BITmSaJYZH1Bg5wbo1aDhlsz-l7neHFRwoGztAcg>
X-ME-Received: <xmr:PYwKaUIgZAAYWb7qIUq_Q-uA_5Y_fQpcTG8DLHlfChEE5uQzpj5o6hEs2B1f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgrthgvrdhkrghrshhtvghnshesghgrrh
    hmihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgrthgvrdhkrghrshhtvghnshesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhmsehquhgrnhhtohhnihhumhdrnhgvthdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    grsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:PYwKaQiIVVlveKmfZSKCApLVkzBnaqIqjJXuNT370_NeNidKWhZzaQ>
    <xmx:PYwKaZKsvXt7Uh9PwXcLNtuHNr8505-c-QDCjF-BNQbfVaZ3pjBb5w>
    <xmx:PYwKafi6mlImneFqoQB_2i7y__K116d_VBGohEb8RuSG9mswigAgbQ>
    <xmx:PYwKaX0LQ0kdmIzROfXAwxSp17SOZq4yDRZNVM4pUNDH1VX-yZB0Uw>
    <xmx:PYwKaXEJsQycRAXSij1MORXeMyuzKqYIoXyJgW5V4BWLpE7d5EfDnzrj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 18:29:00 -0500 (EST)
Date: Wed, 5 Nov 2025 00:28:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Nate Karstens <nate.karstens@garmin.com>
Cc: netdev@vger.kernel.org, Nate Karstens <nate.karstens@gmail.com>,
	Tom Herbert <tom@quantonium.net>, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Jiayuan Chen <mrpre@163.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
Message-ID: <aQqMOoy9_pmdcwHS@krikkit>
References: <20251104174205.984895-1-nate.karstens@garmin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104174205.984895-1-nate.karstens@garmin.com>

2025-11-04, 11:42:03 -0600, Nate Karstens wrote:
> The `len` member of the sk_buff is an unsigned int. This is cast to
> `ssize_t` (a signed type) for the first sk_buff in the comparison,
> but not the second sk_buff. This change ensures both len values are
> cast to `ssize_t`.
> 
> This appears to cause an issue with ktls when multiple TLS PDUs are
> included in a single TCP segment.

Can you describe a bit more the problematic case (state of the
strparser and all the variables involved maybe?), and how the added
cast fixes it?

And what kernel version are you using to trigger this issue (and then
verify the fix)? ktls hasn't used net/strparser for quite a while (see
commit 84c61fe1a75b ("tls: rx: do not use the standard strparser")).

> Signed-off-by: Nate Karstens <nate.karstens@garmin.com>

A Fixes: tag would also be good, and the subject prefix should be
"[PATCH net]" for bugfixes.

-- 
Sabrina

