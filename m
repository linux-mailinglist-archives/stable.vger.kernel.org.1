Return-Path: <stable+bounces-56325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F4D923754
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910501F22924
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C99814E2C0;
	Tue,  2 Jul 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jP+RXYQw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Torcqpyw"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531914B97A;
	Tue,  2 Jul 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909632; cv=none; b=B3/I2mlaYA1P3J/AbBjdTyvHiN9YMzdbuHqXFLj5dYhtt9uTW2W/Pw7LHpWcKhJ5nxOKRtNbD+4e4VdX9up4iZNNwWDfCxtyfzONgjiYiU9Qr7LbsCN/BSblNyXZuqghE85AsIIdt4RbMN0qcBEw0MuO9kotu5zdMjcYrBK+j9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909632; c=relaxed/simple;
	bh=PRySXSFCbxHtx58UjrptcfEnraeCzlPK0ot+Gg/BgwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAIkbfxMCxLxkuBThV4lyA7yQKQEEj/wOk089Fe4YCK17rJg3AprRvVRDKbgqdlx78fI0ZMjkQSJbPIq7EbrIgLf/3DeOfn8HzDIdla6rypnnZho8mgbi7D+foS2JgnOq1HDct8UAdIiAlaqQp2M2lbyqpgKiHL90qvbhVyeMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jP+RXYQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Torcqpyw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 010FC1380510;
	Tue,  2 Jul 2024 04:40:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Jul 2024 04:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1719909628;
	 x=1719996028; bh=P3GLh2Lv4oINHn0Q+FIJeSWAi2vKxzDmr2bqQNGp+2I=; b=
	jP+RXYQw5tcoo/97So2Yr04qsYexhsKvWJu37bGxzIq9n5reFrwH748edfH7d1J4
	MZwf2p5sws4M6oEslbilLzT2btEPGVbzTGKiJiYTLvEeftrded2UneswjALlCqyH
	HJUYn4Mhky+OtKMccJ6pvWfGkzpTyZPXLD0XEtNcMtTLInWuD/+e1jzO2ZJUZqiM
	fCMgbbxznurcSIVbBeXPs2L/7lYkY52JRfnIJL4oM1z2nbC98uEDVHkaz7JVtIFt
	Qrm1kCuaVl4ZNVvyA9d/4KwJHwg6CvzszF3346P3WIMGjQ0ZMOfEq0F8ocWmRMfe
	EtVtkrXOhZ/gM9cOTneX/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719909628; x=
	1719996028; bh=P3GLh2Lv4oINHn0Q+FIJeSWAi2vKxzDmr2bqQNGp+2I=; b=T
	orcqpywE4LvzFlN5LFpVyvs3BKE1zxSi+3IxwXDpe5w1iStBFyJEXFIvwa2Wex+p
	hQ4ekYezkOB5KzVqVK+JVDqSJ3Wzda/yb+SMDj/P4xb8MGvGlDQGA8+RkPLYbC1W
	3cRljv+P7ro/VXKeKp1wZrrQT8mQUqV1BRSmonu2ACPF/i8AtgjrECr8z/1ZTHnB
	QFf3hFFLF/dFSGeVps7CcaxpQqmnsinbiJHFajvfxRps6554l9zV7vNygBkvj7A5
	dv4aJTaDbnUfiBwibuKP748ksrmR94M2okzY5KDR55DYt9LeaS3ewTRrNZfKxscG
	Rwx2SnozkXFqvYGHsW3uA==
X-ME-Sender: <xms:-7yDZr9qOalkCF00tRmDb5MWSiASh6HfCB89pXmCvBudsqQl7i_zyQ>
    <xme:-7yDZnspZPUcNu2nvZh-9BefDpGDFIDNc8-9XgPhruayfhKBhGMYzQW57KYEy68FY
    b83e-5P37MRtw>
X-ME-Received: <xmr:-7yDZpCDrleLObxx5wfwRMgesHYFOiX9FLYjDekTl16PphEbP8u_RTvzrUk7LZkbsBf6EFXw8yIv1N5nw_gkX6EYWpPnEqASL1mImQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleekhe
    ejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:-7yDZnfQJI1-cfUCN1yb2iJTbk3nFe-4tvmkDDayFt5CB9pfKRQnRw>
    <xmx:-7yDZgNx78dQJZg2aCGKxAhuQP23_RA953swdiJlrsXV-ogS09ITWQ>
    <xmx:-7yDZplsJooHdFW5Ug_k3FVbSWaXyrvzRekqkrvxZpNwop_zIMfISg>
    <xmx:-7yDZqtEl5UtxNsgVGJVSbMQyBdg-05xOBVKJ2WQeqfY3FRh9GjeOA>
    <xmx:_LyDZnndDzfJsh7xctfN5r_duqHO0VYtrf0cN7G_tR6tUPxFeqJ84kat>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 04:40:26 -0400 (EDT)
Date: Tue, 2 Jul 2024 10:40:23 +0200
From: Greg KH <greg@kroah.com>
To: Li Nan <linan666@huaweicloud.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Jens Axboe <axboe@kernel.dk>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: Patch "md: Fix overflow in is_mddev_idle" has been added to the
 6.9-stable tree
Message-ID: <2024070215-tipped-sureness-c678@gregkh>
References: <20240630022346.2608108-1-sashal@kernel.org>
 <3b0a2464-115f-b588-ca14-bbd74d7eb761@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b0a2464-115f-b588-ca14-bbd74d7eb761@huaweicloud.com>

On Mon, Jul 01, 2024 at 09:22:30AM +0800, Li Nan wrote:
> 
> 在 2024/6/30 10:23, Sasha Levin 写道:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      md: Fix overflow in is_mddev_idle
> > 
> > to the 6.9-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       md-fix-overflow-in-is_mddev_idle.patch
> > and it can be found in the queue-6.9 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> 
> This patch is reverted by 504fbcffea649cad69111e7597081dd8adc3b395. It
> should not be added to the stable tree.

Now dropped, thanks.

greg k-h

