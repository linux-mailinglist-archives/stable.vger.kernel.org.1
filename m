Return-Path: <stable+bounces-135056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D431FA96069
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649673A76D9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258922A4D6;
	Tue, 22 Apr 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YDbgCm6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvuw//Zy"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E911EEA48;
	Tue, 22 Apr 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308916; cv=none; b=mHZSv40IH4Rxl7fba+y83fZ6hVtHnXUJQ8YIkzbJ3kOPZH0wgfdQ9mmnmQP1u5TpQ4DtKhG0IrWjA/PhAZ+i1rLQys1UyT6fiEI2ShWSLiksYmvW6T3r+ZmYw5w2vjLou0UhnZL1L+TEZRSzzxTJf1ix49tbnpwWVN6HHHv2D3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308916; c=relaxed/simple;
	bh=BcFJi0bulc2QinYsUNlk2EgoqAvQjtu7GHdQrOwYwi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUzxP0ctrHuGU7nu/DDya+XzZyUXjkMw43NGqiz/4mJkV/OUZ1s4Bo/+OjVar6Z2iGr37NpTZqFi9wZyDKVJrfhQdl5lwsKDWdA31Q2N9cuhvTOmGJxNrSSA6ZzdxEk2tV2HiR+J5WRAy7B4IuyJSF5C3cIA5242NYDQBXL8A9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YDbgCm6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvuw//Zy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3C8725401F8;
	Tue, 22 Apr 2025 04:01:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 04:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745308911; x=1745395311; bh=KqQ0xwRJH+
	edSDFf5TaW+/HsSzh0Lt8XI37stcalce4=; b=YDbgCm6+wYECGRVGJlHR/44zQZ
	3wPb2ql4zEMSiE80mMeMvw6EBNgyg8XXU9uxyN3O0udcSD0vfVIHy5LucRPv1MMS
	qTNd1iar2jkAGJG4fJF+1spyVF0+Xab08BOlvtilbBWVvF4O28QRqn4y9GODJSHm
	5bZvCr/uf2OQ0h3uEMWDo4vKt5zPMK4sMbhfCTTVDwJZDtsG1ysdvLxkTnLeQAwK
	zF1jjipF+RBCCKjk+10XcdvTybdRT3Auq2DjaPF8HnuLRXvHpwnZN8QZhlhUi8Wg
	odzYYBQp8aTwFVhgFY+JsA1pwTOBbcEweHLSARwlvsWcZdIUxpMRIebh2+wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745308911; x=1745395311; bh=KqQ0xwRJH+edSDFf5TaW+/HsSzh0Lt8XI37
	stcalce4=; b=bvuw//ZyoSLI02TAQDKdocsbYfdRrMe+SRS0b9TbTTUusvmZvbD
	g5F23TqJ4Qd3b/6Rzz6xJXIfWLDvxRyHpJjPPtWE1Z82diIrFKnyXWB1PaRPu3b1
	9/fZWE91AiW0sH4aZ8HI9IRITtGvjpsHXMQbUIoU4NMcDizLXBiWqd7u/Ou9qJ7t
	I4D3ZPsTfA9QPnMpYe/rWgy673tXNFCBvkx13oHRvecZqIF2MF5boTtziz+EDuEg
	7WcSS59gF7KQBogNbTuWRpN6bhpcfMbuSxFzNnOaX+KqvRjCuL71oYb/TWaX/ezy
	wCSLtAQMmIomYJetQLSNr1lu6gn3yAFh9uQ==
X-ME-Sender: <xms:70wHaIBrk-yoglB8zLrecPQZw9YHViWCdTlSZp0Vc-hEkF2OM-z6eA>
    <xme:70wHaKjhT4_dQOHDiEhkzD9yxroGWDMsiyw0WE_4WXqvNCSljJXbhKuPOS39zyqDb
    nQU52HBTz4t_Q>
X-ME-Received: <xmr:70wHaLlcAHgPiYhJ1tcgEddi8A0VEtYjfkQHRvMae1y194m7LbynarrN5umyOb2GnmJxh2RygTK2iOeFkrUeIM3bW9eAJos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudef
    feelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    gtrghrnhhilhesuggvsghirghnrdhorhhgpdhrtghpthhtoheprghlvgigrdifihhllhhi
    rghmshhonhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghhmrgiihihlrghnugesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphht
    thhopehsrghshhgrlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:70wHaOwc5Zj8OcnsKwwibajW3dUL2Ldp7bjx-j_7UXvJrm-oQPTB3w>
    <xmx:70wHaNQcXX95zzIKIPJ6yMx7_PNJVQoBeQED19dRld71fuaWfOXXdw>
    <xmx:70wHaJZa4s5xqOrG_aM6NkWayhj2kBzDoft1HzgyZOgBjP55eNfDFA>
    <xmx:70wHaGTnqHz14uJns2goNwcc_nD34kgnwkvyiAavL-zybaERytgfSQ>
    <xmx:70wHaLZaIa6L1hiqoNmggrP1coulcEembmpGA4DEQGRInYGtd0dENZsq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 04:01:51 -0400 (EDT)
Date: Tue, 22 Apr 2025 10:01:49 +0200
From: Greg KH <greg@kroah.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Milan Broz <gmazyland@gmail.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1] mm: Fix is_zero_page() usage in
 try_grab_page()
Message-ID: <2025042243-glider-refurbish-c0d1@gregkh>
References: <20250416202441.3911142-1-alex.williamson@redhat.com>
 <aAAl5HdLYQl3nIjO@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAAl5HdLYQl3nIjO@eldamar.lan>

On Wed, Apr 16, 2025 at 11:49:24PM +0200, Salvatore Bonaccorso wrote:
> Hi Alex,
> 
> On Wed, Apr 16, 2025 at 02:24:39PM -0600, Alex Williamson wrote:
> > The backport of upstream commit c8070b787519 ("mm: Don't pin ZERO_PAGE
> > in pin_user_pages()") into v6.1.130 noted below in Fixes does not
> > account for commit 0f0892356fa1 ("mm: allow multiple error returns in
> > try_grab_page()"), which changed the return value of try_grab_page()
> > from bool to int.  Therefore returning 0, success in the upstream
> > version, becomes an error here.  Fix the return value.
> > 
> > Fixes: 476c1dfefab8 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")
> > Link: https://lore.kernel.org/all/Z_6uhLQjJ7SSzI13@eldamar.lan
> > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > Reported-by: Milan Broz <gmazyland@gmail.com>
> > Cc: stable@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  mm/gup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index b1daaa9d89aa..76a2b0943e2d 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -232,7 +232,7 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
> >  		 * and it is used in a *lot* of places.
> >  		 */
> >  		if (is_zero_page(page))
> > -			return 0;
> > +			return true;
> >  
> >  		/*
> >  		 * Similar to try_grab_folio(): be sure to *also*
> > -- 
> > 2.48.1
> 
> Thank you, with your patch applied one test VM with a PCI passhtrough
> configuration start again.
> 
> Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Now queued up, thanks.

greg k-h

