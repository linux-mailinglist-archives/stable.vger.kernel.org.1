Return-Path: <stable+bounces-38011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81589FF5F
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 20:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A731F29CF4
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306D17F385;
	Wed, 10 Apr 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OWTRqp9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1SVnxgv"
X-Original-To: stable@vger.kernel.org
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF1168DC;
	Wed, 10 Apr 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772159; cv=none; b=HmAbsFwB883IhtcxSTQeU0506Os6iyV8MQVpYPxKMC55snJ2NFo2U/Zj+FXEeKS61hHP13qBQ7tjBuLrTeNGaXV41SrUyw7XPChdCBVuC4vg2EHGoKZjlTpGa0iRYnmnc4Hyp6HWHk3Ui110lk26E8Jww4WO0ByWMDIM+0Av1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772159; c=relaxed/simple;
	bh=mmflYIeLFfZFjKHyKfkl9MZClho18bCOL5WKZR1USlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj0RTgiCp05c5sgWGjYA95WrEHpSL2nwvtSigd44xIauBF/3EYjE4oDNj2DqpPygK0rIq/T2H3KZ/dxHn2Zv/X3GUmWwxappnzmIpiLWH3Z62smBxR5q9GgqCYUn8WLI61P2KG17ezxM4WFuxlKoW1ouAln/pk3DJy6Db1MAXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OWTRqp9O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1SVnxgv; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 965041C000E5;
	Wed, 10 Apr 2024 14:02:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 Apr 2024 14:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712772154; x=1712858554; bh=YertHYiXkl
	pQluikonf6IgljfvBl94hixkNDFTaI/fM=; b=OWTRqp9OQGAiIGiRwGBcu2yRl1
	GUQKqKJarBiTmj7/QDni0Wlbzn5ofHbXxWHv+Gi1u4lRt/p7IuD+9NvNqQv2GOzr
	/tM/VlzFvGIK8HoNOH3XURNV0g1wxmd9D1289e9p1oT+Vv3ufQyDL28gTWLPaKDT
	Xp4qHliw2OgOkeGz0Miw1XCLSxJu1Mkr3NLkDyx7Xdvs+BAxwe1BOzqCY2gguoXy
	pYwv9bvx7rfI37X4KGYFoPzEZvdcqZE7P904arOX/md3WcbTiGUTHZp35kprnq9l
	pnBgmEwaevXsyJMqLeTFmWH/ARrWcBbBrz4tOFFA8E0TEq7kxbHjBx2MV4vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712772154; x=1712858554; bh=YertHYiXklpQluikonf6IgljfvBl
	94hixkNDFTaI/fM=; b=N1SVnxgvn2W8d0UdSl8/d9z1aanvw35HlGkHnjskUvh8
	cjxpUH3RbInjgcm7uqjh1EhoUfSDjasJvnhoP4RNvYknT86/01LCLxphOodIKu7q
	+drK5xjKnMNyYRX/LI2QvQ/jy9RdI7J+aNaqlpohzXsZ01nPflhj8yXamVSWYvJW
	vufjiGT1AHWKZCHGSgf4i7LrzK49b8ezDrPfTj+QR38nKgjZ8Qj/um4ycJ5wd0p1
	Rxo45UoG/F/e+j/t6Och8OO2aqTfjMr2i4WjM2vL8FhEpQY1SCnfBZN/Zw+QKYjv
	RqvGO1wlIIvKdAJ/uV/LD0/Z7kGl4G9hZjm8ZUn+QA==
X-ME-Sender: <xms:OtQWZiPfZ_YIPFHA4pQqLCVKtY8O3MQ_1RCgOgz-8U_BxdByWt3dxQ>
    <xme:OtQWZg-Q7ZLaMB4-2wzK4tLlTsPucKSn8c9JD8EPBvG7pLbjBqe_-NZ2SFVDxoRrF
    evagdD3c0CQWA>
X-ME-Received: <xmr:OtQWZpQoyMXqZ-g9KMaOPgiHQytC2ZWgOAWs_77uKUPRs0uB24DC-Ot-bwQTh6bDQ4iTZes4NTn_j5g5eqHNlib0qzRQD1dDVKA13A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:OtQWZiurARBEfZ9CAjiQzRGzVv9n3FNDdhScid1Bw7Cfn5HQSyD4Kw>
    <xmx:OtQWZqdHZqJDApPDNpB5GJbgp_S1FuSXqW4K08VvW9Twxe84HoWZLQ>
    <xmx:OtQWZm0ox2qgglZs4Z-c5V2Bz0HuglKMHuAFnPnjts3wQ2yh1j5AtA>
    <xmx:OtQWZu-1N6LZdyS6gDUdMGo08Xt3MT-0bptShvOwCGFcs9p0rLHUAA>
    <xmx:OtQWZtWkyc8yc3R6TvZP6F4zmykMVavVdoC_zK23EuhgbcPyMNWCDWiP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 14:02:33 -0400 (EDT)
Date: Wed, 10 Apr 2024 20:02:32 +0200
From: Greg KH <greg@kroah.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	buddyjojo06@outlook.com, Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
Message-ID: <2024041016-scope-unfair-2b6a@gregkh>
References: <20240410155728.1729320-1-sashal@kernel.org>
 <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>

On Wed, Apr 10, 2024 at 07:58:40PM +0200, Konrad Dybcio wrote:
> 
> 
> On 4/10/24 17:57, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S
> 
> autosel has been reeaaaaaly going over the top lately, particularly
> with dts patches.. I'm not sure adding support for a device is
> something that should go to stable

Simple device ids and quirks have always been stable material.

thanks,

greg k-h

