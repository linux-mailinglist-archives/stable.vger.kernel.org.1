Return-Path: <stable+bounces-104457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855719F460F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E13118876E6
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9802A156227;
	Tue, 17 Dec 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WzHXEhen";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3pE6EOsX"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC242AA1;
	Tue, 17 Dec 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424236; cv=none; b=j+hPKU5IkNLWC8pzhbOS5imsgTtwxiUVLhVjOKkt6yjHjexKSwfephpU7GgH4/6SQkc/V4vyYd6RqunEXUMhD+sF7p9DnYBUI7lPsyYT4drAAN+NjqkUup+OBlP0CXzRP2oKbyF5dpuKqE0CNpy/HKjbHA3E7NtJaaRw0x+M7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424236; c=relaxed/simple;
	bh=OSdBpx1Myr3O1zIZ3mp1iogM3ydizKDyYLvwjYyMACA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey317A0YFipog3YlLmgpOGbNwmozxxyys6DrzjWPGuliLJk3/gjGMiQdlJkzft2Rjapgy6ZDHUGFcIFxao4UNfHtadN4YVDwQ5BBVNP5QVaV+tPmuGBYesJ02IonkaMvJciRsQ3lJ87vZ/TZP3SegJ4mFjDmo1Mq9D484CGP/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WzHXEhen; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3pE6EOsX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CE861140266;
	Tue, 17 Dec 2024 03:30:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Dec 2024 03:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734424233;
	 x=1734510633; bh=JHfFPC6NwoRI9bysS/KO6bTDlukpT1NYlNNLGP9kaZA=; b=
	WzHXEhenDoG2A6wn5YhRuP6braZ5EkVUYqo2sPzdPZApotHEY5rp4qZH/WCDMbFT
	WxFgQyzqNYw2N3nj859DUPw6zZDJA2zRZbte2BRrJIiKTy+43Mn9mLJsBB7xKCvK
	9fdRftXvinhYUpzXjV8d5lIqUXOqCPUX0c4421MJ0oHGPUqMNV1wwhCXiYLE2qv5
	VbSRF6bxf00dKM6MpyDkzVl049U+92GfzA7Ypk2GXzjeTrhjmLy+1MxXk7H48lFA
	SkqrmXoseTce8f7APrAyMEA33SUxRWnHHF8BZXZDu6NkT4fd9T+zm7tvoShu7ii+
	D8ReazVqgDNuNQwdRgmMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734424233; x=
	1734510633; bh=JHfFPC6NwoRI9bysS/KO6bTDlukpT1NYlNNLGP9kaZA=; b=3
	pE6EOsXRKAzmFdIF/x4oYHiexQrEzGBVOYyKhOA0qZPAdExv41x5goD/EdqgCmkl
	F+ybEZmj7HhSGr/JjO/1XgV8hVekL+o90m0E+bEcG6KEv5TVtEACqPkZLy0X/gKV
	D+V4vhVdBhK/mZV6ifhrKrPaAd1FnsLcn1PEQ2m/NvzGV5b6PBbcq1Cw0b5rlMcn
	npVFve/JpriHP47+gEJdoRsveLwiJxQgR8iTyF7D43s3HAGHkv1bpvF9uAEORkGX
	GWvAXbugSZbK45ivJ5rqpUWKg6WYGrnxqZlShIZ4BQb1q/hi5Z8nQhYCPJDCu/rf
	RJoL/lNNWftxI5heSmj/w==
X-ME-Sender: <xms:qTZhZwnaOUCqF877aI1cSpxqOLVwyPb8Oy4ehXSy0KPlB1agdi79vw>
    <xme:qTZhZ_0HyGiIWWmDtMGkGWiXyEfTuo6GAf2dlOgr19NYdRcEudJGbFcnby8KlnDzt
    fgZZokeXg-NAA>
X-ME-Received: <xmr:qTZhZ-oM9Q5hCT08KURSGHky2SQ6TrQURf6vpFqXeTXYEgFv7QlTBUudgv4TfBsrQiQobRrKLy47kTJzLMxJXbDnUYIb5CftTv2lBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegveevtefgveejffffveeluefhjeefgeeuveeftedujedufeduteej
    tddtheeuffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuh
    drkhhlvghinhgvqdhkohgvnhhighessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslh
    gvqdgtohhmmhhithhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigs
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslh
    hinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-ME-Proxy: <xmx:qTZhZ8knjKBwuF2GK2v8ywyIxnLl6yAVl6I0eYRFi5gSbr2kVPR1gA>
    <xmx:qTZhZ-1K-354i1oeqa7iyZjCFtep983KUmBz8j2vECASAikJMKr47A>
    <xmx:qTZhZztxsu9iC7XFdxjLutBnS-XwIMbOXWXKmXbVHL87TD9T_XO8jg>
    <xmx:qTZhZ6XJtl-K4QvpYfG_spW4Bc9pL0FFXPZuCoDpC9PTSAQwo3zqCw>
    <xmx:qTZhZ0N9bKCVdNZUSlrw4wr1Q6KSGShqAvzN4inVmmAgg-rMZFlLWJQy>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 03:30:32 -0500 (EST)
Date: Tue, 17 Dec 2024 09:30:30 +0100
From: Greg KH <greg@kroah.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	William Breathitt Gray <wbg@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: Patch "gpio: idio-16: Actually make use of the GPIO_IDIO_16
 symbol namespace" has been added to the 6.12-stable tree
Message-ID: <2024121701-giveaway-decibel-4af4@gregkh>
References: <20241215165457.418999-1-sashal@kernel.org>
 <2cjlh3rtjqyrxvqkeklzdqxv2shy5fqolflx3fa2itxig2y4kc@gvl3fecajwqr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cjlh3rtjqyrxvqkeklzdqxv2shy5fqolflx3fa2itxig2y4kc@gvl3fecajwqr>

On Mon, Dec 16, 2024 at 09:32:27AM +0100, Uwe Kleine-König wrote:
> On Sun, Dec 15, 2024 at 11:54:56AM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      gpio-idio-16-actually-make-use-of-the-gpio_idio_16-s.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 8845b746c447c715080e448d62aeed25f73fb205
> > Author: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > Date:   Tue Dec 3 18:26:30 2024 +0100
> > 
> >     gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace
> >     
> >     [ Upstream commit 9ac4b58fcef0f9fc03fa6e126a5f53c1c71ada8a ]
> >     
> >     DEFAULT_SYMBOL_NAMESPACE must already be defined when <linux/export.h>
> >     is included. So move the define above the include block.
> >     
> >     Fixes: b9b1fc1ae119 ("gpio: idio-16: Introduce the ACCES IDIO-16 GPIO library module")
> >     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> >     Acked-by: William Breathitt Gray <wbg@kernel.org>
> >     Link: https://lore.kernel.org/r/20241203172631.1647792-2-u.kleine-koenig@baylibre.com
> >     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Hmm, I don't think the advantages here are very relevant. The only
> problem fixed here is that the symbols provided by the driver are not in
> the expected namespace. So this is nothing a user would wail about as
> everything works as intended. The big upside of dropping this patch is
> that you can (I think) also drop the backport of commit ceb8bf2ceaa7
> ("module: Convert default symbol namespace to string literal").

Yes, as the previous commit that ceb8bf2ceaa7 fixes is not in the tree,
ceb8bf2ceaa7 should be removed, I'll go do that now, and drop this one
too, thanks.

greg k-h

