Return-Path: <stable+bounces-60785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EEC93A1A3
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C14B1F229E7
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D481534E7;
	Tue, 23 Jul 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HwxqS7xX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tIy9CQqW"
X-Original-To: stable@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D128208A0
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741792; cv=none; b=BOdbvY6LTOTYDUAFzs8iPNHs0HHzqOx4+AA0cj+Gb3h4MW1XJBtK3e2dUkWBWPPoheFQwl1UKsa6C5eRdJ5XAtpCHnXLJdFvg9daFBcEXxp7EQB/9WUVUDi7oEeHnogn2gQrdOeY9+qTABhrkh+lOTUHUSwAj6t5YcVijiZHOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741792; c=relaxed/simple;
	bh=jCdVqwho++rzY8P1vQ0YVhghkmTBcO7P0uF12lRebks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r23XaqGl9TthApT9ypdvXPRp8FXjB0sk3vOPkWXuWIsEOol81invHZiHYZ4aEf7PbYo9iMasKKdXhlzPOONDN5XOgGT1m6itGKZb1LkFxfcAILWN06HChgenDlRZiipazfb/b3D1a2ZndP1/ddUsXcLyY5jk/sFH378Oqm2hcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HwxqS7xX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tIy9CQqW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 48D961140302;
	Tue, 23 Jul 2024 09:36:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 23 Jul 2024 09:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721741788; x=1721828188; bh=4YC86AQreN
	tSBpCTZX7ZSfkQJBtYoZfDmfj1GmyfHr4=; b=HwxqS7xXcav9jjaSPkBCj5qxFj
	5PXfkn9SfdbNNp7inCnEvpDnsUaF+OC4giahmUK68mnlm/SoFkV7Yjm8ATJnrK7g
	FhjRUBM/eT4Ew6AVhYToFLxjRt7lnMqqUtoeu1zXXJQtw9KFusxgWvwAz/KDa80F
	W0DEsECKuWm23/rfdGUmQT4zpR2CVFZT32c45uyopcTPXt7UwPa+eY2q133r+ca4
	GN0pqMhX1QrRflH+oeinxCYDuL117wJIOWfY+bxe5veulWXd3TEIotRpJYz1As8m
	aBMBpZBRP5wXBft17c9agis0CwONfD2EG4KMlxGow3j7G5s8uLBCYIONFSYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721741788; x=1721828188; bh=4YC86AQreNtSBpCTZX7ZSfkQJBtY
	oZfDmfj1GmyfHr4=; b=tIy9CQqW824nhLR3J0S5CjZ4KRRS0Y9b3PMapHtX5KRm
	MK1wjdJpFtRK/gyhQcDcRh3u3ArXAtxWKIi0JQ6mjaa/y5KqvwyRic1no0jcNdzv
	aDjFg1utg+AXyg+Nczu6yrU3elBOmT1/HQGhHmoizzSMN1bgn0+cN3MHyYxlD16a
	dv3Fb0qMUEz7hRoxecErQIIyjGm0Mt8TTRL3N9eJaKppkO2UClQDALpNSN4bfNJb
	g0ymeo7HJlmXJ5oB8EzSCmVUaSuitmwNNpXb5l8bGc/QeshqS8BZmyUtou8yjQzH
	5g3Roe/Y8oJK0Bl9jJBfyhCX0g0IJIVk3nMZv9WTzw==
X-ME-Sender: <xms:27GfZrfUVCCivhKv9gFluwbvvCci9fP546fBuPfLrcRg61ZT4uxCAQ>
    <xme:27GfZhMY5Q1aUe0SK826hHCUa-g96oG9NCzcn9K2S19-4EX_V_Tx3M6Zg4VuDF4_q
    GpoCF9e2FXYRQ>
X-ME-Received: <xmr:27GfZkiqEGFgy-IwO74IIKzB_9uBeXSh-ELNOJbpu8y2Zz91MyyHVxJvecFSoWE0_YD_omXpLGUSu-G113ftKBJEAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfegfe
    egheevkeeutdekjeduudegueffleeluedtheegveevkeffjeeiteeuueenucffohhmrghi
    nhepmhigihgtrdgtohhmrdhtfidpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:27GfZs-cWPz7M1O7FkbPnoOgbLmphInZH7xrMFBSb54Csyro4EzKEg>
    <xmx:27GfZnuCtFtlgyifta0juff2CeYg8xbiy3EKLfdp8zEKEtY04oxKBg>
    <xmx:27GfZrGsYK2fsF8FZXjvC5KSHd2oLNL45hwv5Q0JsUVig4a70kynww>
    <xmx:27GfZuMeGtEA2zEmvh_cmILjp_IWbhQ6prz_JtDEowSX1QGLb7JRhQ>
    <xmx:3LGfZgGeZxGuBP2z-oBRcWmVRsrcoGqcqYGPxfYkRckuDcYSpS50FBWZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 09:36:27 -0400 (EDT)
Date: Tue, 23 Jul 2024 15:36:25 +0200
From: Greg KH <greg@kroah.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: kunchichiang@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5.10.y v2] mtd: spinand: macronix: Add support for
 serial NAND flash
Message-ID: <2024072359-suitcase-statutory-b7e4@gregkh>
References: <20240717090126.467511-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717090126.467511-1-linchengming884@gmail.com>

On Wed, Jul 17, 2024 at 05:01:26PM +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> [ Upstream commit c374839f9b4475173e536d1eaddff45cb481dbdf ]
> 
> Macronix NAND Flash devices are available in different configurations
> and densities.
> 
> MX"35" means SPI NAND
> MX35"LF"/"UF" , LF means 3V and UF meands 1.8V
> MX35LF"2G" , 2G means 2Gbits
> MX35LF2G"E4"/"24"/"14",
> E4 means internal ECC and Quad I/O(x4)
> 24 means 8-bit ecc requirement and Quad I/O(x4)
> 14 means 4-bit ecc requirement and Quad I/O(x4)
> 
> MX35LF2G14AC is 3V 2Gbit serial NAND flash device
> (without on-die ECC)
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/7926/MX35LF2G14AC,%203V,%202Gb,%20v1.1.pdf
> 
> MX35UF4G24AD/MX35UF2G24AD/MX35UF1G24AD is 1.8V 4Gbit serial NAND flash device
> (without on-die ECC)
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/7980/MX35UF4G24AD,%201.8V,%204Gb,%20v0.00.pdf
> 
> MX35UF4GE4AD/MX35UF2GE4AD/MX35UF1GE4AD are 1.8V 4G/2Gbit serial
> NAND flash device with 8-bit on-die ECC
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/7983/MX35UF4GE4AD,%201.8V,%204Gb,%20v0.00.pdf
> 
> MX35UF2GE4AC/MX35UF1GE4AC are 1.8V 2G/1Gbit serial
> NAND flash device with 8-bit on-die ECC
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/7974/MX35UF2GE4AC,%201.8V,%202Gb,%20v1.0.pdf
> 
> MX35UF2G14AC/MX35UF1G14AC are 1.8V 2G/1Gbit serial
> NAND flash device (without on-die ECC)
> https://www.mxic.com.tw/Lists/Datasheet/Attachments/7931/MX35UF2G14AC,%201.8V,%202Gb,%20v1.1.pdf
> 
> Validated via normal(default) and QUAD mode by read, erase, read back,
> on Xilinx Zynq PicoZed FPGA board which included Macronix
> SPI Host(drivers/spi/spi-mxic.c).
> 
> Cc: stable@vger.kernel.org # 5.10.y
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> Signed-off-by: Jaime Liao <jaimeliao@mxic.com.tw>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Link: https://lore.kernel.org/linux-mtd/1621475108-22523-1-git-send-email-jaimeliao@mxic.com.tw
> ---
>  drivers/mtd/nand/spi/macronix.c | 110 ++++++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)

This is already in the 5.10.y tree, why are you asking for it to be
applied again?

confused,

greg k-h

