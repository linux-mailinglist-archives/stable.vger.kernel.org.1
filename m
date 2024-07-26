Return-Path: <stable+bounces-61814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3FC93CD88
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 07:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A567B1C2158E
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540E282E5;
	Fri, 26 Jul 2024 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mE61mDQY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTCWxpXC"
X-Original-To: stable@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D222616
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971430; cv=none; b=ISaNlfq3fUmkIDQfbep7uetABWmGH1l9Jb6utk/GLDQ0p7qywtgQ3MFqQkkHGvFFR1HECcho3lqvnhkG8N5R4qbdfqyVBZOD26saSiLaD/hfrYoQlY7qB9ZG/SFdy0I0b6DR87UfzH4jAjZSg/Ctdt5+J32Kl1Yb+7urSnk5Ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971430; c=relaxed/simple;
	bh=AOMga+QXIJcizlIqjDVqG6gouK0P7Eeb+aARy+O6qr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkZrKNkGmgp/3L9Pb7YY4wxzCJ8BUVBUYS5kjKTTtZnxHPcnrj83zLISGsRREDibnylKelFfG22TSJp3Te1uU2D/WogXUmMR7d5YD37q7fIAN6888vOVs7QgUfBcTaagzHQUQ0im2oWzPb/5oyKkBA0wu2a2rE0yHbxmj0o0/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=mE61mDQY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTCWxpXC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3714811401E2;
	Fri, 26 Jul 2024 01:23:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 01:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721971427;
	 x=1722057827; bh=fs6ITWHvtLFVJPJ3eJOt5nsCh1O6Urzsody7+Jhc6Ps=; b=
	mE61mDQY/CWKivLywAcHAxVtr5la7eR7xSRZGpmDDvJPN3vFOiE37LgwSpxuC9nj
	+o+i00xW3C+z5MLgt2Lw+7c06sLE7P/66ZCITBsAiKZEFSEI62X6o/KfHiPnavk0
	fJ1fmP0DqZuP6jmCgG/cfAmoKc+abU6B4dCWNDPIXmZdevo0I26H9G+rCMWlDHTH
	Ad/ZSoJORHGBNCd6inp0qFN78KEI73844Mir6gI5h1s45I9d3n9ap0AghoFN+Zt5
	jZSzR/zAmfLdqusyb93Ccmdw4EJFLvJewtmFU88PbRVcVmvCfNCdr38W6EF5ZnRI
	mqv1sFYdpUW4MYX1+xfRLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721971427; x=
	1722057827; bh=fs6ITWHvtLFVJPJ3eJOt5nsCh1O6Urzsody7+Jhc6Ps=; b=K
	TCWxpXCdWmizlUekedf5ei0FSJo7XwKNj413nWURdKWrfqLAyjudJm8XIhoNWMym
	V7gxz1QHsWiLwIuAOi8kQ6q82orTpOuj3AA8VxGsvWZZUnyl73Zl4cB2zDn4/9MP
	dbkfbYSd2NNrfm/m+9qFqeTrlhJsLXYPWKi+9RFAD4y7MRd41Bml0jYs6GPjHkMc
	te8wjahNOroDTWP+mAmoeLkkfaDrBYLrGERey92NmN718KZp6aYSLoapNzmtC33w
	5LQ4Ef6sIXMq03a7B4QLCXyRXhMDNQ+ffZ9bZIviB6KX+ODHK6bT55nq7z0zTVdJ
	b+DED7GZ1ATK4rAhX4dwg==
X-ME-Sender: <xms:4jKjZsHgSr1yXXdwAfClgXiplysH5i-zT1e7jMNSQWlxGlMDdEVvlA>
    <xme:4jKjZlU0sbYgQOvJHkTWFraqZ7u15LClJpR5DA196xOw0yYYa5iHYoVBksBtzvyCr
    lovkLyf7bJ4uQ>
X-ME-Received: <xmr:4jKjZmL-M-pn4JiKPwkPrpUUkLlLbH1X7be5X2gWkgPaV3_i6QlYWY4NmiS1plAJzCIOg30IaZN4HUJEXucOMZhjs52BXNi-21jK7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepvddtie
    eitedtgeeuieffteevteeufefhgefhuddtteeuhfeujeduleegvdelteevnecuffhomhgr
    ihhnpehmgihitgdrtghomhdrthifpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:4jKjZuHH6jGhK7bv0AXlJVtzrrPWXrB_VSf2BNcfig8_tqKopPR5Kg>
    <xmx:4jKjZiUFO85K56jAvgK6dQFFwjWPU_h7XHaXjDkPDYJcDqp81uB_4A>
    <xmx:4jKjZhMLwyrDYumOAtD3w_txgSAkqqZmvbJ17KXNWw1QXojG1o0sUg>
    <xmx:4jKjZp1aIJP8AoYPDwQgHt65dne8VH5QsZyX4ZHWX1MCs99UQL3i_g>
    <xmx:4zKjZjs8vDHf072dloU1l3v8gLRDdfljB3mRuMXSxF_0pDns_Hu1G8TD>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 01:23:45 -0400 (EDT)
Date: Fri, 26 Jul 2024 07:23:42 +0200
From: Greg KH <greg@kroah.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: kunchichiang@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org, Jaime Liao <jaimeliao@mxic.com.tw>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5.10.y v2] mtd: spinand: macronix: Add support for
 serial NAND flash
Message-ID: <2024072659-pavement-alienate-e629@gregkh>
References: <20240717090126.467511-1-linchengming884@gmail.com>
 <2024072359-suitcase-statutory-b7e4@gregkh>
 <CAAyq3Sb+D_+F5qX9HQ=EZkhm44RDf4BG4EuzDE6W_R9+Av8j-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAyq3Sb+D_+F5qX9HQ=EZkhm44RDf4BG4EuzDE6W_R9+Av8j-A@mail.gmail.com>

On Fri, Jul 26, 2024 at 09:15:54AM +0800, Cheng Ming Lin wrote:
> Hi,
> 
> Greg KH <greg@kroah.com> 於 2024年7月23日 週二 下午9:36寫道：
> >
> > On Wed, Jul 17, 2024 at 05:01:26PM +0800, Cheng Ming Lin wrote:
> > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > >
> > > [ Upstream commit c374839f9b4475173e536d1eaddff45cb481dbdf ]
> > >
> > > Macronix NAND Flash devices are available in different configurations
> > > and densities.
> > >
> > > MX"35" means SPI NAND
> > > MX35"LF"/"UF" , LF means 3V and UF meands 1.8V
> > > MX35LF"2G" , 2G means 2Gbits
> > > MX35LF2G"E4"/"24"/"14",
> > > E4 means internal ECC and Quad I/O(x4)
> > > 24 means 8-bit ecc requirement and Quad I/O(x4)
> > > 14 means 4-bit ecc requirement and Quad I/O(x4)
> > >
> > > MX35LF2G14AC is 3V 2Gbit serial NAND flash device
> > > (without on-die ECC)
> > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7926/MX35LF2G14AC,%203V,%202Gb,%20v1.1.pdf
> > >
> > > MX35UF4G24AD/MX35UF2G24AD/MX35UF1G24AD is 1.8V 4Gbit serial NAND flash device
> > > (without on-die ECC)
> > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7980/MX35UF4G24AD,%201.8V,%204Gb,%20v0.00.pdf
> > >
> > > MX35UF4GE4AD/MX35UF2GE4AD/MX35UF1GE4AD are 1.8V 4G/2Gbit serial
> > > NAND flash device with 8-bit on-die ECC
> > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7983/MX35UF4GE4AD,%201.8V,%204Gb,%20v0.00.pdf
> > >
> > > MX35UF2GE4AC/MX35UF1GE4AC are 1.8V 2G/1Gbit serial
> > > NAND flash device with 8-bit on-die ECC
> > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7974/MX35UF2GE4AC,%201.8V,%202Gb,%20v1.0.pdf
> > >
> > > MX35UF2G14AC/MX35UF1G14AC are 1.8V 2G/1Gbit serial
> > > NAND flash device (without on-die ECC)
> > > https://www.mxic.com.tw/Lists/Datasheet/Attachments/7931/MX35UF2G14AC,%201.8V,%202Gb,%20v1.1.pdf
> > >
> > > Validated via normal(default) and QUAD mode by read, erase, read back,
> > > on Xilinx Zynq PicoZed FPGA board which included Macronix
> > > SPI Host(drivers/spi/spi-mxic.c).
> > >
> > > Cc: stable@vger.kernel.org # 5.10.y
> > > Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > > Signed-off-by: Jaime Liao <jaimeliao@mxic.com.tw>
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Link: https://lore.kernel.org/linux-mtd/1621475108-22523-1-git-send-email-jaimeliao@mxic.com.tw
> > > ---
> > >  drivers/mtd/nand/spi/macronix.c | 110 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 110 insertions(+)
> >
> > This is already in the 5.10.y tree, why are you asking for it to be
> > applied again?
> >
> 
> I accidentally sent the wrong patch, which has already been applied to LTS.
> I would like to inquire about the possibility of reverting this patch.

Revert what, the one that is in the tree already?  If you need/want it
reverted, please submit a patch to do so along with the reasoning, like
any other change that is submitted here.

thanks,

greg k-h

