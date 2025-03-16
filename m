Return-Path: <stable+bounces-124549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311FA63665
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 17:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7631216C228
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0719ABD4;
	Sun, 16 Mar 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="I4HQPrqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5Zv/SnB"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284612C544
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742142840; cv=none; b=FZXQjdQ3RHRp/iz1IOBnqiVW9+S1eFQeesnawSq4Tum88MEHkbHm+2b0JfT4jxMu2GcXxWTGvJ/BW6lSeicSZouDPsy60yakIKGRDnZGj2YH6MnmankVlnPwJ8L7zOB6Kz4bqK6ayfPKb8QqbhutjckFvb0NOefbGRQLiP47v6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742142840; c=relaxed/simple;
	bh=siIhkN1/NhcJ52Y6kT3lvbJRnOMm52rF1LVsaOTfuUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWTgnyPwcBt0xsymnaI/63scDKZ72opTuS8ul+vhiRLknu6GBPXPh2ZArc57S70olhdRosoV9fRkEVU/fl+j/j4SO7y4E5EdzPKqzzczQXf4+2EtEzf5b/a7rOXLLwa96q0lZejPCBbZOi3//iTpyFSqvxzGM+JcQVNfod1prhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=I4HQPrqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5Zv/SnB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2D681140117;
	Sun, 16 Mar 2025 12:33:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 16 Mar 2025 12:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742142836;
	 x=1742229236; bh=QmBUqH+DeYJGBocnN5XGfQbj4NO+FZpC9tehQQLfclI=; b=
	I4HQPrqIB16vvkvaCFT7mzm+phK1Ho3LXno0k/vE7BQvaGnJAqsFy+R7DN7kaDgA
	WlwViCtXc9pP82aSOHil8NhKVYjQ3PPaCoNGU4zrsC5uxClCoOzqgdFiBsUKxpfz
	wdr2+Z7QQl0q4WYwuQ55qJHPZTDt/IFEVbAo7fZj3r8oG5W75uTiyihHb1vvlRln
	isEvL5UwQI4kYmDpoVOaLiwjS1EZDzwXlhKZ2NJ2f9b++FKFnbRS9PCmnN6KRl6+
	EMx5ySTS2wi9NCZ0jqgqYgVnHNHuxSPl9naYnJuSlkgDGFl3fEgE022Pw3oWN/ne
	XnnKN8ONLgdZkLVUCWBKOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742142836; x=
	1742229236; bh=QmBUqH+DeYJGBocnN5XGfQbj4NO+FZpC9tehQQLfclI=; b=R
	5Zv/SnBqTlJWmHStKnfAWW8C4LkagALbq2w9/Sr5/JPpMZ+/57Uf2mk+WMS07XD9
	EKD93R9orIEPyRmhzrCc9r3vzlyI6TN6HL0ztyvW5BbjHdUrh25xZHA3716cfJz9
	0kspisYJqYrGvlK24RQHlpI1ugekRL39DOl9ZJUSHRscg2nrDgYKICGmu1MXq9em
	MasqC6hESL8VFIN1eyLJVGuTRVHrzeMyjkqJxeksSnLtQLaUv6WQnGfASuAPdv8a
	at5BdUPgUq6vMMKTkn4SxOphUNv9KDpQAZkw5I+fduU+yD8+a7oLzQrrmNzavFm+
	mpJ7Vu1e4wgv+MJa/C1iQ==
X-ME-Sender: <xms:dP3WZ_-nBtPhlBVnaZsqY4HAn5zSFzNG3s43C2_k_yCWd1IoJW5EDw>
    <xme:dP3WZ7u9zh0_dA0FlmdPJjIlB_RdaWG5l9W4TvTjoItvYXViY3ozf6EivYPGMj3CV
    4hKbJxMUgPyDw>
X-ME-Received: <xmr:dP3WZ9AiQXlLzAJmoxHIDHYsm624ZXAWjnwu0FkJ2-ahG5yefELSOkCAAQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefgkeffieefieevkeelteejvdetvddtledugfdvhfetjeejiedu
    ledtfefffedvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguoh
    hnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohep
    rghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusg
    horhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dP3WZ7cepuJGnme2wHHzDuwXE7FmLtcu3mIelNV2StIOIu8ftbUJUw>
    <xmx:dP3WZ0NCS_9XXbmj9WAojKbNIEaJ7IEmObn2SdAduIcRq2_7hw-HUg>
    <xmx:dP3WZ9kEPgEb5O8hbdWUMh9sWy3B7hVxH8kdQpUttgS6s2SRhbt1ng>
    <xmx:dP3WZ-uXbFiCBAC0gF0-Gfl6gmXiaYUhxaVR2NBq3HAUK3LdjXXbrw>
    <xmx:dP3WZwlp6umqbBzBjdRAEAH4S6rK_QEdgA5XQiApcxKtee5qJeVaiSW_>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 12:33:56 -0400 (EDT)
Date: Sun, 16 Mar 2025 17:32:38 +0100
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
Message-ID: <2025031624-nuttiness-diabetic-eaad@gregkh>
References: <2025031635-resent-sniff-676f@gregkh>
 <20250316160935.2407908-1-ojeda@kernel.org>
 <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>

On Sun, Mar 16, 2025 at 05:13:05PM +0100, Miguel Ojeda wrote:
> On Sun, Mar 16, 2025 at 5:09 PM Miguel Ojeda <ojeda@kernel.org> wrote:
> >
> > [ Added Closes tag and moved up the Reported-by one. - Miguel ]
> 
> Note that this is the note of the original commit -- for the actual
> backport, I changed `KBox` to `Box`, and edited the title and the log
> accordingly.
> 
> I can add [ ] for the backport changes itself in the future, if that helps.

In the future, sure, that would help.  Don't worry about it this time.

greg k-h

