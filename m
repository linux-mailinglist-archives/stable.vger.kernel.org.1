Return-Path: <stable+bounces-41730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DAD8B5A66
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821C3B223C1
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA4174404;
	Mon, 29 Apr 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="X2bFC7Qq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNzYrq4C"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69D2C69C
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398359; cv=none; b=fKqBYuRkjdhG/2VhmIZc5DyYdISDopO5ohxHyrOEaVI2ROYpwK3IynNRp11bDa3CVG/AvRfn2qADNeHRf1J9ts/dWoZ7fpZu6MLZr/wIO4iuiAg2IWEIkecVc69QYGlIHT7NRQsckpwzZydag0+DddtZ6QlR14tHXGUqxhR8ZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398359; c=relaxed/simple;
	bh=ztPjcQhkOQD3ur5W4BHLxdkoJDy7lboSLeRwWQc8CuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU8WQp3ON9t4rPMEs7eXkAPOZ6ZtUokkjPKeFmQh5A1100rEaX8HT9KWGsoEngw0bYFKT0CmhKWvRSWOoa4eOnL9l4XGXmKFWexW2bQn4yoXw7O5P3MPv4ToHZYeisSHmpGKfjRyHNqaHNsvev7q/862jh3hqIRPiCcS5ZpzfOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=X2bFC7Qq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNzYrq4C; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 550631381A5B;
	Mon, 29 Apr 2024 09:45:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 09:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714398356; x=1714484756; bh=LJo4o96rAK
	Z5NBkctl5AV1MUthszAiXNv6xuuTFiv2A=; b=X2bFC7QqVliMvfHevN8m7P7TLX
	CPRU5paTzTSfblRbFU/wzRmogMfnur9F9BO7IJsEoMTQ95FFp5helDH4PJNHviTu
	bEuJMGiWd02QmZjHwpQOvc3sv39pDroauFgDRujOQk0s3Qlb4roFe/ydnpeMNB+X
	830lVf7ZmolZzCn4hYUxFRHXfIQRf1Ov79bRKFk1XCz4DvyNNjAzGfjy79yhKqvJ
	NubOtmHHuno3u1jHX1maxtlFsthurdOJT9jNN9gQGRbFRWytX1Bgg47YMEWnFodE
	vOyjCAAF0GzDQhNxoeLuvXcjty04Yi8ECj4UAZv+aCVM2z/7QUcz9tPbOoBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714398356; x=1714484756; bh=LJo4o96rAKZ5NBkctl5AV1MUthsz
	AiXNv6xuuTFiv2A=; b=ZNzYrq4CAoFDnbNjplEbw7N2akZhBHypWnhrZc4ZaiKI
	vniJ2ovmYxUr+YCD2JDOpxi9Cwmi3Mado3jVj0l2i9sspk08N1eavAoQ16aPU3RI
	ldvee58US5vnJulf+hiZ5D6Mnk4cxTnxiBmFtXr04Emf2PzqHi5jgaE85FAEsJ4u
	ps1xXk/5XQixkbS2tDcAyB4Z4C1JuWTiwQup5rt4rekDD5pQ6oOf8lhMr4z5p3EA
	olFqcsSzdSYDY5lRdvrv7lE+ncWsosZQ5LKwjStoxQXt2u7mg+Kau5cY+IS4XJD6
	qaJL/SNfUfi82pjpgTdhXL0fFQKoAnFl3rvKQTiN8w==
X-ME-Sender: <xms:lKQvZm9DYfE5g0Rp5636G6SOh_oxzKBhAQRzkJ0SV7V3LGO-hZoVRA>
    <xme:lKQvZmuMSd2HGONTGTSMMCgxIx04-y9rgj6viWne2-4HxXYJ1sV1sOEHGWd-lhUMY
    HdRl3ohEO3Zzw>
X-ME-Received: <xmr:lKQvZsBDfYDIwPF4IbH7FKKb7VIyRZXca618tw7Y3yoFEFYVzrG3csDbSfoK3RnaBBaxN80txzSNCNOseo85yxTYK32umLlcurIFmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:lKQvZufEF3phCnswSXIiete6FWbhcWh5ZYUacB9xqvsreaPAzPyOKg>
    <xmx:lKQvZrMkPmp84HQStJdfAHtWmoeYC9kmyjo3i3wIJrDOhYhpjGN1TQ>
    <xmx:lKQvZokOWaGwSpGGlTBJD3ga-8GSnhjXkGcvhzN8s8pqlWtA4clTig>
    <xmx:lKQvZtvX41ypVHwMsL1Xl0zVsoIw-T9r3Mm5ZRzLhBwCwpGP3zjJ8Q>
    <xmx:lKQvZkicBIX4mylHqsOiSiruQtZqwdSO82l-JFsgNF4BVcBxosYbsouK>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 09:45:55 -0400 (EDT)
Date: Mon, 29 Apr 2024 15:45:52 +0200
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org, Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 6.1.y] rust: remove `params` from `module` macro example
Message-ID: <2024042943-oxidizing-suave-8501@gregkh>
References: <2024042924-ribcage-browsing-7e8b@gregkh>
 <20240429124505.28432-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429124505.28432-1-ojeda@kernel.org>

On Mon, Apr 29, 2024 at 02:45:05PM +0200, Miguel Ojeda wrote:
> From: Aswin Unnikrishnan <aswinunni01@gmail.com>
> 
> Remove argument `params` from the `module` macro example, because the
> macro does not currently support module parameters since it was not sent
> with the initial merge.
> 
> Signed-off-by: Aswin Unnikrishnan <aswinunni01@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> Link: https://lore.kernel.org/r/20240419215015.157258-1-aswinunni01@gmail.com
> [ Reworded slightly. ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> (cherry picked from commit 19843452dca40e28d6d3f4793d998b681d505c7f)
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/macros/lib.rs | 12 ------------
>  1 file changed, 12 deletions(-)

Now queued up, thanks.

greg k-h

