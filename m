Return-Path: <stable+bounces-71629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7896600C
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563321F281D9
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AED192D77;
	Fri, 30 Aug 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mM0r5Cst";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Raev1Wcn"
X-Original-To: stable@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A6192D69
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015960; cv=none; b=QoC+0CsVCNzx+iaUJrLf8YO7Oy4ijUPVnB4NkphKi1QQgscBE5V3x1EEVplkPKJgkd9/Y4mKD462+a+sPmEF8nu2EkqRb5WC00lv2A4MzHkSlzZe5BN7COWroN8CHcz1TcF74JO/7qHuY4CtU0678ibs5AqgYvX8mckNrgm2wXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015960; c=relaxed/simple;
	bh=ZhWA+SuzgnFodl+OGFsSDS2b0A5c94Jd3tD7s6pNg2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgspKJ55AjJRD21Lpwp+b/49+jqiyJkbDWbl7Zb5HXKd+apYUud7qnadMsu1mW9qaV4NkWrEnTZQtNeHn4ZHBJxv9UegfAvmUoK6pqmDTi4oav1AKXTdgjLzxB85XB5Yrt5CQ+Cu4faptZGbeT48tDTqNNY6R6p8Mn9crp/Y+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=mM0r5Cst; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Raev1Wcn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6A25611400EE;
	Fri, 30 Aug 2024 07:05:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 Aug 2024 07:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725015956; x=1725102356; bh=ete4J6bbcV
	w8jFtvm54u705s5vWv7ECUhMDzH2CPO/A=; b=mM0r5Cst3NrkeiAShYH4a37pwP
	nM5bQ4VlfjJwJIG9JlxRk47KIphnlP7ZyYDXPQXnThdCRxbh9ro1+nL2qGR2zqVg
	iiL2SQ5ZMcsOPFqP6gRPxcr/WQf75OPgC6i0dqLkWE+ns7AcYUns8pgc5gzM7iwt
	FAd9GeCDM68gr++Zc4+O5MS2kjiiHuyjbln/Ps4i/JtN463ax6WZmK+w5wp4YDTo
	hDms/jv6jbvrtMuSqsLQB5G6xVJ5IfJeDqRIPNLROluUkWMPxEAQq+g5Kpv+8S59
	n4jeUoRlCiiVuKZnCI7nuOV+zcRLx90DZ4VN+LsvW7VvR53753yRi2CF1VZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725015956; x=1725102356; bh=ete4J6bbcVw8jFtvm54u705s5vWv
	7ECUhMDzH2CPO/A=; b=Raev1Wcn7ROanS2MS09HasO3WRtcEuYDKwX+FlvxJak9
	v/dC9QYUmBWJ2ybr2FwHv5Hu17QnnlgUxwwVyxG/uLvy5gaPVvI3GoeE0uj3Zobf
	DYTxhB1jhlHnHdpLGJvl1NSdKETDLAkKm+J0b8zM7r0ICSOl9jDnI4trEdN7Hh8p
	WelGzbM/U81DaXyOkkWda/WTr3TKlDnVARGgeJZ+LOTR+aIWTXjpgLfVDHBJjUHJ
	kdUv/wlvELuWAqN1xkGG7izo0WXc63s1Oriu1HKxfUFZCvUFdIXxL8Bj7HbtfJct
	9ROlLTt32A2yYoYXFy4GXWhOS0wlhtSzRN4i9YbRVA==
X-ME-Sender: <xms:lKfRZgPO1YECVdYavnU-lgJA0-cyh9zPiU07G2eM51OuI_eXiEiV0Q>
    <xme:lKfRZm-F2StD482CAttbPmob8OuTbAcvMSc9kWwx7Eov4ssaZz1Fpcgvz67Kx0RS1
    eycqiaSm-r8jg>
X-ME-Received: <xmr:lKfRZnTiM1VTn2hAlBNbGZLQLaOpsKr6dfPnUdRXZocrWj1APcln_flTYKK1a2JbLGLJturog8FenXa432BTxLf6bUj9mcAQNpMfdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhsh
    himhgvlhhivghrvgdrohhpvghnshhouhhrtggvseifihhtvghkihhordgtohhmpdhrtghp
    thhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hquhhinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegusghuvghsohesshhushgv
    rdguvgdprhgtphhtthhopehmrghnfhhrvggusegtohhlohhrfhhulhhlihhfvgdrtghomh
    dprhgtphhtthhopehllhhonhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrkhhp
    mheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepthhorhhvrg
    hlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:lKfRZosPX4SG780eokxYi-XrJXlTt79YB-PAPt8kcJww7AlTnJzAQA>
    <xmx:lKfRZodE2N4rOIjRhL4EAXo_hep84aIiQfKvMtlTQgmT10M6gHUE0A>
    <xmx:lKfRZs0TAe9xAU_6kt1CHozZ1U6inJERwwHDeMq2fDDp40g0SZWa_g>
    <xmx:lKfRZs8t2TQmxJtXsCh0BgtEP7NYNOWxsJ4b0PGCR-iRoYUSnfcmLQ>
    <xmx:lKfRZrs9-ppoVSGbYCZSBUSlj1kSPnqXQL0COjojaLdnekusSvf7zy4i>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 07:05:55 -0400 (EDT)
Date: Fri, 30 Aug 2024 13:05:52 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
	Davidlohr Bueso <dbueso@suse.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	Waiman Long <llong@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.10 1/1] ipc: replace costly bailout check in
 sysvipc_find_ipc()
Message-ID: <2024083047-excretory-character-c63c@gregkh>
References: <20240830094001.30036-1-hsimeliere.opensource@witekio.com>
 <20240830094001.30036-2-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830094001.30036-2-hsimeliere.opensource@witekio.com>

On Fri, Aug 30, 2024 at 11:38:29AM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Rafael Aquini <aquini@redhat.com>
> 
> commit 20401d1058f3f841f35a594ac2fc1293710e55b9 upstream.
> 
> sysvipc_find_ipc() was left with a costly way to check if the offset
> position fed to it is bigger than the total number of IPC IDs in use.  So
> much so that the time it takes to iterate over /proc/sysvipc/* files grows
> exponentially for a custom benchmark that creates "N" SYSV shm segments
> and then times the read of /proc/sysvipc/shm (milliseconds):
> 
>     12 msecs to read   1024 segs from /proc/sysvipc/shm
>     18 msecs to read   2048 segs from /proc/sysvipc/shm
>     65 msecs to read   4096 segs from /proc/sysvipc/shm
>    325 msecs to read   8192 segs from /proc/sysvipc/shm
>   1303 msecs to read  16384 segs from /proc/sysvipc/shm
>   5182 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> The root problem lies with the loop that computes the total amount of ids
> in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> "ids->in_use".  That is a quite inneficient way to get to the maximum
> index in the id lookup table, specially when that value is already
> provided by struct ipc_ids.max_idx.
> 
> This patch follows up on the optimization introduced via commit
> 15df03c879836 ("sysvipc: make get_maxid O(1) again") and gets rid of the
> aforementioned costly loop replacing it by a simpler checkpoint based on
> ipc_get_maxidx() returned value, which allows for a smooth linear increase
> in time complexity for the same custom benchmark:
> 
>      2 msecs to read   1024 segs from /proc/sysvipc/shm
>      2 msecs to read   2048 segs from /proc/sysvipc/shm
>      4 msecs to read   4096 segs from /proc/sysvipc/shm
>      9 msecs to read   8192 segs from /proc/sysvipc/shm
>     19 msecs to read  16384 segs from /proc/sysvipc/shm
>     39 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> Link: https://lkml.kernel.org/r/20210809203554.1562989-1-aquini@redhat.com
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
> Acked-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: Waiman Long <llong@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  ipc/util.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Now queued up, thanks.

greg k-h

