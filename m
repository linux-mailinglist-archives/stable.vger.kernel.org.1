Return-Path: <stable+bounces-203160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B810CD3FF9
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 13:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D37C300D490
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0478248B;
	Sun, 21 Dec 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rDaPagDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GC2eoEGk"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9051EA84;
	Sun, 21 Dec 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766319613; cv=none; b=ZJekq+HnwVRs5a/FrkfBWaAJG910BJ4hUVvll+fR5AHqTjvusu9MXKWHgTS+isz+y1oO38LuUHK+NecXE5uPL1qUcEhTTHzDqstHI9J1L1uLEmoTr1ixCsRjIgCmH0ydD0xiHZb5NoJ6kQBkWsaKjKaRCZPnX3zg+hel045r22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766319613; c=relaxed/simple;
	bh=m6XP9NnkPXQPIv2dNC2D6DrymrSzN2QNtzVvhAX/ROw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYOeYd1JcftvRXaoeN2iphRQ9xpkPRp8ZklqECInMUx/zZircCWLiVBCvUULIcTpe3DBxenoLWLxi5E9mNm4KtUpVWjg8uiJ+kbucHA6gMu2Yoe2QFXrguApt8h1w2joIYJhCncpZj8smX8LrsHw5gk+r+W5OXphZ+KTYUUfHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rDaPagDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GC2eoEGk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B4F914000A7;
	Sun, 21 Dec 2025 07:20:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 21 Dec 2025 07:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766319610; x=1766406010; bh=WRIruBPBZm
	27NQWvBEtT7qTRyArxWxry3ZuRyxHcIj8=; b=rDaPagDRcUA3wq2lXsXCHY9e6c
	PSm33+H8kGChoaJcG7ydMRqiuGUtwykQSBGJBKNfPzubCP1otzSR0D+7E3r3zOfO
	Y1CmgQ7gnB/z38fTEIbNerDLxkrvb6H3TZA94EhgUTkpBFiinsZ8Vucmbnmx0xiz
	zCDwZnGrQtd7CPaHv3T+3x6L7NKlp2TrHBGWLjLspJ/tHfBF997sIFQbFI2AZAPT
	094NFLrMUgsAn7dWqe6aGvvRgzv/RfG+o3+ro5QwbFZiB5PZNfjXwCQ/8rVSqAZl
	Y4PWoWSDc2Vtn2IwgSsNBniqMelKqILyqkVyig0vIBIvsTLxW+KNzOuyBAKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766319610; x=1766406010; bh=WRIruBPBZm27NQWvBEtT7qTRyArxWxry3Zu
	RyxHcIj8=; b=GC2eoEGkdQBe5kM5Xxti/Bgackl6RtlAbLRsBZxuA8XSaURcDuG
	kMx5NNlFEJEPYr7hcPIlnoTcHgywEkDFoZQgB6eG912dzthmUUoBEQd4JUlWH7gE
	vre/+stCQXYwqBlbYXcZNHNsNhLIvPXvcFCD8EI9mlN6qfFVJi0RsffN2ZcuUR3S
	uKUHHayzzuzK7vP4Vbufm+R3IIcVSDN/Zcz+t4MEQr1Z+v3aZzF2DCT/8QmFidSY
	4Bfj+C710PTAivjDdXXaHHa1ye6YUeAhE2kwLSxAgsF248S4bCB0q8qDkutUZjYP
	U94hcLUQjKSxo8nvBW2jemA5UVZXut80Hmg==
X-ME-Sender: <xms:-eVHaWAs6lRcZPh8_rtYpGr1OMK_1ysmvpI-BDgFgbrm-_zYg3afSQ>
    <xme:-eVHaWBEsv74ceuD4EXPToJbRl7DJmzF3-h-KvbdkvNCZ46TfFsfLgg6ewymxEZyK
    fdSmfEtDc8jLZQk7Km9BsCXAh48NkYlgQP9EzM93EtSpbIPmsM>
X-ME-Received: <xmr:-eVHaR7070UdyODBzqpL-ctbnFeUSsNYBn9u3STQ4gCp7X30Aa37EwHRME950laMkFFO_D3yp6IoCQ9eNLBeLmtXhv7ApbCTBCMgNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhhrghogihirghnghesihhsrhgtrdhishgtrghsrdgrtgdrtghnpdhrtghpthhtoh
    epmhhpohhrthgvrheskhgvrhhnvghlrdgtrhgrshhhihhnghdrohhrghdprhgtphhtthho
    pegrlhgvgidrsghouhelsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkphhmsehlih
    hnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghnrdgtrghrphgv
    nhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigsehtrhgvsghlih
    hgrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:-eVHaS2k3AdQnX9I4WqBoj8W-Ai-CQGZEfhcmcD5jvbn0t6qHAnVUw>
    <xmx:-eVHadAL5fcDshRlLAAcsZHG7yHgJJfGi1UITOfQI1kvbCqBK8z0Zw>
    <xmx:-eVHaSHxiK7FkvZe0AaoIdmDS8xv9it8VTSqX62s34PdfyAODUqr0w>
    <xmx:-eVHaaSuQVZHrsJge714DPSP6bS6jIzXZBAxfYpQ2ybdueIaLCujLA>
    <xmx:-uVHaY35N-1EOWJD7ExK7YtBmGi8m6mN9EJR7F_pXq4b4XYpm1PCQ_SB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 07:20:08 -0500 (EST)
Date: Sun, 21 Dec 2025 13:20:07 +0100
From: Greg KH <greg@kroah.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com,
	akpm@linux-foundation.org, dan.carpenter@linaro.org,
	linux@treblig.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix a resource leak when rio_add_device() fails
Message-ID: <2025122135-shudder-corrosive-480a@gregkh>
References: <20251221120538.947670-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221120538.947670-1-lihaoxiang@isrc.iscas.ac.cn>

On Sun, Dec 21, 2025 at 08:05:38PM +0800, Haoxiang Li wrote:
> If rio_add_device() fails, call rio_free_net() to unregister
> the net device registered by rio_add_net().
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 995cfeca972b..4a804b4ad6f7 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1789,6 +1789,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
>  	err = rio_add_device(rdev);
>  	if (err) {
>  		put_device(&rdev->dev);
> +		rio_free_net(net);
>  		return err;

Are you sure this is right?  You aren't checking that rio_add_net() was
actually called.  How was this tested?  How was this found?  What tool
was used to find it?

thanks,

greg k-h

