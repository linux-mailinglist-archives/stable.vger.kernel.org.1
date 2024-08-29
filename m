Return-Path: <stable+bounces-71538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02396964BC8
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350B51C230AB
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D661B3737;
	Thu, 29 Aug 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="u+s3YqA5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhF833Hz"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08D1B1402
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949335; cv=none; b=Ex7t/QCgGnxBHCsT2OjE/vbuBEGzlBIZFGzcbW3/Ka1naMU414J8Xb4LdC83EwGSz3pTbsmdeFM2BoFi/iqTS9oLlFG0l+ehZ+rcXpErU1YQCA3LFYv1oCcMunKHu21uW5QYnlX+COBpKPlZqNHcyxqQISQsvd94pU7r1JARooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949335; c=relaxed/simple;
	bh=s6i9k7ksGo1NQ2z68qZa0leXY5fx6WRQpOuKgCFrEE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL/qevcRbQioEG2V5bjSlMJ9ulHPX6QakHCj/S/pEVP1RiANuan8Y5ga4HStdsSs0TnPk5THQNxal3T1NDRcVTcbO835M71aRmMWb8j9s6RVdbAohU0xp75kI8xUMat/XUaxInSmgxgg6asINrmdMFdeTXNZ1EHkSSAf9/4DaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=u+s3YqA5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhF833Hz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 30B94138FC6F;
	Thu, 29 Aug 2024 12:35:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 29 Aug 2024 12:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724949332; x=1725035732; bh=hekZab7Cpc
	tDLvC1E1e+reE7UOtjxvKmREX8kISZhfc=; b=u+s3YqA5rXwALQP/Md1iXWl6CM
	L3JooVNHKwllkTKWGDi7/WXipInXQeOX3gu/8tnK2qRd++UU5nlCOXBNb1/9MB8z
	MkQZ0QoaHtWI0U4eq08VClwQAPUQNgah64R8D9l4i6uZqNr/pm3pzxt92+FJQCK6
	YdvNldE2PPfj3b2SgY1B+Tkejx5wVa3mDCDbREN6F2AZpOsy0cTtLeUxNUIEusyr
	gKMl/S3mTWvcL0kEzyez7FXjLpMyWo13SILc4WLBU9W6r2nsy29Xa93NIey6FGUu
	atiw6Vxd9uQqKaVu74j5Zwd7gnyqxLoYAd/1y1EcLHJs/Mw20UYoJXfvX8mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724949332; x=1725035732; bh=hekZab7CpctDLvC1E1e+reE7UOtj
	xvKmREX8kISZhfc=; b=UhF833Hz2cB2inNrSx/vnZpDN/9QmG9AGjwK3OVsCq93
	54rmWSdaIhoWt9Fz6YVaqxPv/gJsWdv1TIHRw6fAjCauU76Q9n1bYnss9ABcJQLA
	Q2/GZk2vHhZEo69JGGXqjcGHOFYUYOPN1FNmYhLiMqwQ844A3hRfuMN5h5oHCzno
	Wd0Yn6UMvbW9rt8F6m/2fz6MiGfa5QN2ZPLr9m7PWpRBRS2OIz97XuXSPQfnnyJA
	Xa41pbEWKpTrfrRmPNGmTI6JsoN1RMpSVyzvFasF0GqDqNy10OAS4Nqat9QFygyY
	Zi4iuH5qq0QagBSHYs6dCfgHhZVxt8wc51om7dpQrA==
X-ME-Sender: <xms:VKPQZgBnr47UWHOadXtIuak2utEnIkx0CvSjBORXJbYXMM9FRecdDg>
    <xme:VKPQZij3LpNFi1tPFaiw24yoBI5z2MIdwkdWkDk_TnC_QdipHDleOQ6UHC-qYzQg8
    io1n2x6L8_b4Q>
X-ME-Received: <xmr:VKPQZjmETV0PEW3sRrjnbwPIy-hOtvdMMjbxnY7qgEY0BXtz3EFLUYGEDk8Nl289t6xZdKm79U-XLvJGOlgp6pytZh_XWUpfjsYVgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    dquddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhm
    pefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrh
    hnpeevffehjeekteehlefhheejfeeujefhgefffeffhfefjeejgfeviefhfefhteevteen
    ucffohhmrghinhepnhhishhtrdhgohhvpdhkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdr
    tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    ephhhsihhmvghlihgvrhgvrdhophgvnhhsohhurhgtvgesfihithgvkhhiohdrtghomhdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VKPQZmzuO_Z_XLKyhFdWqXt9MxEn4j68oe6Bq4RpjXlvrSUo8SwqCA>
    <xmx:VKPQZlRQjV9EPGB7ZMQvrEOU5OjdvWflFw-EVnkUJ3LP0XY_IK81Yw>
    <xmx:VKPQZhZIrQvzSDX4uOMdYnti4-6pNmXRts0V23VAC908F-J22TaJpQ>
    <xmx:VKPQZuQGcaJQw45U6sv7NIc-1kv-d0qoXtNhKQCJS0tINbLyPyuIcA>
    <xmx:VKPQZjMOvxNDCZ3aKjbMBZ3IXkHNqzXVL42S9MHje25Le68PblptnBgl>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 12:35:31 -0400 (EDT)
Date: Thu, 29 Aug 2024 18:35:25 +0200
From: Greg KH <greg@kroah.com>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4.19 0/1] Fix CVE-2021-3493
Message-ID: <2024082943-sprinkled-stinky-46d1@gregkh>
References: <20240829162631.19391-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829162631.19391-1-hsimeliere.opensource@witekio.com>

On Thu, Aug 29, 2024 at 06:26:20PM +0200, hsimeliere.opensource@witekio.com wrote:
> 
> https://nvd.nist.gov/vuln/detail/CVE-2021-3493
> 

This "bug" was only applicable to Ubuntu kernel releases, why are you
thinking that it should be backported to kernel.org releases?

Please only send us fixes that are relevant for our kernel trees.

thanks,

greg k-h

