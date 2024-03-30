Return-Path: <stable+bounces-33840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E173892C07
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE2283AB1
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E83A1C2;
	Sat, 30 Mar 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bbofwrgr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rhc+L6LC"
X-Original-To: stable@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D72335D8
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815947; cv=none; b=apvu74mG6P/GGADsbHx5tJ5mUVMuQKUrtBAEihMNqNAxmADgSmbznV9/EYM/spSNpmg8IIowoRulwIRIr6fT793+/0xxd1OhgtPd8lvkyk44NzHPwKUvhj3PGLDEVXfnuCyT4kgrYcsmUyx6Cp3R8FwExw1W2ya7oLeZ0Yo4t2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815947; c=relaxed/simple;
	bh=3xcaOhn8D9Exi2tJWGMytl0xKlu2RCZnH/yUlBorvYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJK05WKv5LhAxS9ks3+JTC1Porxjkz0GpdHwW4NuFtsfqNIYxx3uiBEt7Yy8s5Ayc49v7GcCLTWbowSnf6zfru+juSu7OQtz+fiWmugk/JoRvIHiMVa7wJaHFAiT+s5LJCAGWu0DxH5VNLssseetfNjF8FMiZiJ2j0Fpr2Ik3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=bbofwrgr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rhc+L6LC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E4E213800C9;
	Sat, 30 Mar 2024 12:25:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 30 Mar 2024 12:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711815944; x=1711902344; bh=6EmT5VAqAf
	VZEI7t418sTxwaqRhYXuC8xtP73kRinY0=; b=bbofwrgrvDVnvxLRyVZpMTtBre
	3+lEQCq38uqaevFNaFjo3X06pEayq8lgfhDzevGBduZp1J/RqVgaVbkgBhxk+67K
	Fk7Qjb+xwo4hmACFQHbUwyzGh5w2Ww0HNUlVjSkQSNA+lUSf0EZpU45wKkL5YnMq
	XczmaFq7ej1XSVmxlR/wUQgDxjfFTjF+/yPQY/YgjwkUwLrmX/lorGkR0/Gt9ze+
	wOp549tMOGkSu7TLn0Jhwqjr0gY5dYRpbWwCXGukWpvequy7DWYocYlDTdp96NRM
	rH68WGa/vNCVj1qHK8f9G/K9lW4lPQ6KBWWqRnTuaOhehTsE4LRAF37qGXKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711815944; x=1711902344; bh=6EmT5VAqAfVZEI7t418sTxwaqRhY
	XuC8xtP73kRinY0=; b=Rhc+L6LCWGlBcpLNVsythswcQ8UCZ4CEFaqn5l3aiPG5
	5AlUqcVAAozkYzxfFdHYQRc6mCiuPb2ViLA7QmnxZgs6dYl/wrw/ZvTobbJloGGV
	0yc0HQPqEqj8vbHw3ggRREfEn/jkY+ZVpu2movy/FJDc/9o9mGlgx+9Dg/MT89CU
	7LsdZGkId3Z+vLnP5yBGOTf7dmlntsF2icCMDSjXboCFu7FbZEwEjJ0sZjwUtBip
	a7zN8g52WxeQgFOV4H4ix//kWz94u9I+EqUQTPkAuDWfyvmcFH1L4ugbAMsYLnFa
	3af6wZhq3heyZVFQXUR4pCEU5dBe0Udti+dfCe+6jg==
X-ME-Sender: <xms:CD0IZo7qHYm5ud-w8sI3o-_P4Fg9pIcQUqVDOr8JTSqFBZdKMXcGHA>
    <xme:CD0IZp6OVukFKzxDtcfANQHKDReRe-026cZxgxnNUq-j1cu9vSpcFewi2O-XeVamU
    dwjqVJRj6Fv6Q>
X-ME-Received: <xmr:CD0IZncFBZMW2SNIsWQOZxaDNMHIkedSbUPfpWikce5EKobk5sTs-RyIs5DEnsWP7FjqFOiBwsYEOdzx_7VDfCvRtRNa8-ErlCpEZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvhedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepudeife
    evhefhvddtiefhvdevhfelleefieeffeekieeggfethfdvudetfeetffeknecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:CD0IZtKpo5zL4Ly0kX66J7ClYcJuLjkJ_Uilui4iiqIWBprAuh7GFg>
    <xmx:CD0IZsK-HaL8HueTW5PRVJUrZ6hnFrheWCVEhV1TMftQMa25iqUbBA>
    <xmx:CD0IZuwgy1eS7W_CZipm5RyNmfrbFqwUNGCXGPcjJpy_GYh2OyHFXw>
    <xmx:CD0IZgKePlX7CC_4OR2s5HH_5iZ6exObJsGFaCMaoS9i4EtNMuoH_Q>
    <xmx:CD0IZvaUw8724KLq5Qg-lgG5ChNlWA67Sya8maJpXROgAzQDJQ6YAg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Mar 2024 12:25:43 -0400 (EDT)
Date: Sat, 30 Mar 2024 17:25:40 +0100
From: Greg KH <greg@kroah.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org, John Audia <therealgraysky@proton.me>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: Backport "mtd: spinand: Add support for 5-byte IDs" to 6.6, 6.7
 and 6.8
Message-ID: <2024033034-volley-grout-f835@gregkh>
References: <de171eb5-3e95-4529-9228-9a4ed526ed46@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de171eb5-3e95-4529-9228-9a4ed526ed46@hauke-m.de>

On Sat, Mar 30, 2024 at 02:49:56PM +0100, Hauke Mehrtens wrote:
> Hi,
> 
> Please backport the following commit back to the Linux stable kernels 6.6,
> 6.7 and 6.8:
> 
> commit 34a956739d295de6010cdaafeed698ccbba87ea4
> Author: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Date:   Thu Jan 25 22:01:07 2024 +0200
> 
>     mtd: spinand: Add support for 5-byte IDs
> 
>     E.g. ESMT chips will return an identification code with a length of 5
>     bytes. In order to prevent ambiguity, flash chips would actually need to
>     return IDs that are up to 17 or more bytes long due to JEDEC's
>     continuation scheme. I understand that if a manufacturer ID is located
>     in bank N of JEDEC's database (there are currently 16 banks), N - 1
>     continuation codes (7Fh) need to be added to the identification code
>     (comprising of manufacturer ID and device ID). However, most flash chip
>     manufacturers don't seem to implement this (correctly).
> 
>     Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>     Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
>     Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
>     Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>     Link:
> https://lore.kernel.org/linux-mtd/20240125200108.24374-2-ezra@easyb.ch
> 
> 
> This will fix a regression introduced between Linux kernel 6.6.22 and 6.6.23
> in OpenWrt. The esmt NAND flash is not detected any more:
> <3>[    0.885607] spi-nand spi0.0: unknown raw ID c8017f7f
> <4>[    0.890852] spi-nand: probe of spi0.0 failed with error -524
> See: https://github.com/openwrt/openwrt/pull/14992
> 
> 
> The following commit was backported to 6.6.22, but the commit it depends on
> was not backported.
> commit 4bd14b2fd8a83a2f5220ba4ef323f741e11bfdfd
> Author: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Date:   Thu Jan 25 22:01:08 2024 +0200
> 
>     mtd: spinand: esmt: Extend IDs to 5 bytes

Now queued up, thanks.

greg k-h

