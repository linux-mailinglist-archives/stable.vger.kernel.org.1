Return-Path: <stable+bounces-100416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F939EB0A0
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 13:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B57283F4A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E261A08BC;
	Tue, 10 Dec 2024 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Xw43OCuk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDlxT86H"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3D23DE9A;
	Tue, 10 Dec 2024 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833100; cv=none; b=l9Af9nPRYkryRd2gGtMRp2aRdHfT5OUPc7sDd9iLN7clHyfba+Asbdtt+Avo+dV9GY26Z42iu4Qxb0zepmfu2KKiupnQordXoiIB51yfGEmOoC1xxZeTMPOOgS5w/CqGFWtoogKTmmX8jOCIB856dMeXs92k5p9nlnGb3N8povg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833100; c=relaxed/simple;
	bh=FCZOczfax3b0srq8MsTB8gaEyin8ts9KGBJtHmaz9vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6XH4oeS5NVJorSuzfgBULEmUR0KUJ0VLJyVJ7JCNzjboe4CStCGIg13FNgUsLMrJRnKtoyqXGD8E+DSpzRKBPIWIa2dJGFiLK2pnwL1Iwsj68yvFDkwKe9af88ErXZFCV0VW81lEmIt3OCxLbIaEaqkKLIyQgdAm+nHCGnApXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Xw43OCuk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDlxT86H; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AFC42254017A;
	Tue, 10 Dec 2024 07:18:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 10 Dec 2024 07:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733833096; x=1733919496; bh=/30lcFdB4k
	+wBG2d2YP8/aST+8qNSoeiLYW/N5TZ5ak=; b=Xw43OCukgIpmxel4vRfZ/RUZFJ
	GxLxBjRe41EAkv/iguFLAquGsCBbpWU0yevklajFoSAH9kDNA9V711z3+hiI7shW
	ZJF9ty3tYwL/tN0LYYwo501c368gIPJlIv3PnGaIvVgrLVQ3vN3ct4gcaVk1OlYM
	UienJlTM5lTYolw9hxJNA2l4mypg6Z9NOrDui8UPXDycCEGvy7NZ+yMsUB8GWY8p
	+zy9W/fqN3hbN3LIEWduYyVlFymcGBaUQQRODXwG3s6diR8T/MjyGWLU5L7+2fVd
	aLKJgt220rvGZKTLnaS3JI3admvlT5DFt9CLk34vAj57xX7y/FSzTjhLTVOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733833096; x=1733919496; bh=/30lcFdB4k+wBG2d2YP8/aST+8qNSoeiLYW
	/N5TZ5ak=; b=IDlxT86HhoCLjE3UZhSMUIHRxQTwI8CX+rwiRpBmYTdDLQv0iOq
	dJIVniOiEQylOv5PvnE+C1eYbE4Pq6NQy352v2zuMoQdm6N7Zu3cF9aCyLu8ipJh
	BIGqxU2wsFVnCbFD9h2pS3kvEmOD6zWjQ30q8TTwqZM7NgqD06stB1PRz9yB+5uj
	i0Vssc8+Gvfb03SYEfFy2r1ji8I+sEHwBsPiR78CJH3qoNuZPxLNvdMZ/L2pYtgr
	dFOUqYA889S2RiMR3Q5ksBUpXragZW7A9Ug00pEp1kZTGMETzym0N3uaMMwzFpe1
	mBVW+Ism+t5fZNp+7gz4STz33Pj9l+XChGA==
X-ME-Sender: <xms:hjFYZ2QkQvfzpFX4xcPR5bKNCwK20pFR43MR3RiSYCk6_ltbuSJwlQ>
    <xme:hjFYZ7xyAUAv7bMS46NFS7_KDyl6hZSPIr8jeGaRmnK8CmH_LHcrox4MadEDFpzUZ
    GGCCMlqSnGKLg>
X-ME-Received: <xmr:hjFYZz0aY1ILh1eRWpynf6VrzFISZZKlYIT_lxGTFUl9p3veiAM_rr9WbBkNqvXXWNbNomp24ilVOECj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleev
    tddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhosg
    hinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvqdgtohhmmhhithhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhgpdhrtghpthhtoheprh
    hosggutghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopeihohhnghdrfihusehm
    vgguihgrthgvkhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghgghesghhmrg
    hilhdrtghomhdprhgtphhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhr
    vghgnhhosegtohhllhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:hjFYZyBm5HjT3MK7NiSvbrtiuZZdcCWqGt_7A3CU6Q5VE5Jm2WNHVA>
    <xmx:hjFYZ_j_w866ZU-iKmVNywYKmFrnR9A55ZWDzhGYmKPenoEWt5qwLw>
    <xmx:hjFYZ-po86o89tFtZTtQsQXWqBZg9U-pACtfl34XOl7g2Py671Un8A>
    <xmx:hjFYZyh5O5ANdeYulR-iK8J7lauvWd1p9A1HvUP2Y7z2fP5F630Npw>
    <xmx:iDFYZ62_yrrCfmTLsZBD734DTVbDWa7l7vWNw3xDmYDAEXGploNcz-ob>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:18:14 -0500 (EST)
Date: Tue, 10 Dec 2024 13:17:38 +0100
From: Greg KH <greg@kroah.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robdclark@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: Patch "iommu: Clean up open-coded ownership checks" has been
 added to the 6.6-stable tree
Message-ID: <2024121015-duke-dispose-ecec@gregkh>
References: <20241209112746.3166260-1-sashal@kernel.org>
 <cc3b7d5d-bd98-4813-b5ea-71bd019c014e@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3b7d5d-bd98-4813-b5ea-71bd019c014e@arm.com>

On Tue, Dec 10, 2024 at 12:09:42PM +0000, Robin Murphy wrote:
> On 2024-12-09 11:27 am, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      iommu: Clean up open-coded ownership checks
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       iommu-clean-up-open-coded-ownership-checks.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Unless you're also going to backport the rest of the larger redesign which
> makes this commit message true, I don't think this is appropriate.

It's needed because of:

> >      Stable-dep-of: 229e6ee43d2a ("iommu/arm-smmu: Defer probe of clients after smmu device bound")

That commit.

Is this still not relevant?

thanks,

greg k-h

