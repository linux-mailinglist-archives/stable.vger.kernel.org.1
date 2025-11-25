Return-Path: <stable+bounces-196905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70AC853E2
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACB53B18E9
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289723817D;
	Tue, 25 Nov 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="CB5FluiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0QIjbBa"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE722D9ED;
	Tue, 25 Nov 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078586; cv=none; b=nAYiSRpO9Sdgw+tQXkDnh6SJ+Yphx6exMDctlWoD/0QTDLnXJHi6Bb3DH1f/EIAKDykzQv3Db5vBbAYlmZUUme83c6tBzzez/1jeVbzTT3K+5awjOnB4q7Dh0jXk47vaXMpU4VxD7+WVh64n7VwOg1znfq/Y47Vvxz7cbL5X5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078586; c=relaxed/simple;
	bh=ntC8L8bzslhLIg3qF+wfGwwLw6rXBs0Pz+3oaMKdDno=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kNbWxcS+iwzm8eMLNXvTHmweopJ5CxCMwTsf38WuWQjqr8K0Vth3cAos7B1AODqaAgE89nbCaDzB979E72D+AQXm6/uMBXvwGbhdxOgm0LpKe20gpyh9PLP1yDcKXSNa/xlbcFM0iZLkkvK0ZP/iU+U/C7yE6RD6SMeyxQ8tjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=CB5FluiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0QIjbBa; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F5861D00255;
	Tue, 25 Nov 2025 08:49:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-03.internal (MEProxy); Tue, 25 Nov 2025 08:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764078583;
	 x=1764164983; bh=ntC8L8bzslhLIg3qF+wfGwwLw6rXBs0Pz+3oaMKdDno=; b=
	CB5FluiMmqInWbRVdKpHDUf8T74lf8goWOKSbvi3WN7XRHscFjubuN2/pFKN2o2N
	sgn+4NN9NPvmYGs5bOLrQLi/MT7l0ZcU2XXxmDgUKLg26Ty6411dHbQLBByf+03g
	+8uhKjgzOb2zUmxqnAOSDk0zxUBxmxolmmvxcWY+zfD4Iow3RGUgQXDmC8cS+RZh
	6qS4My3MrdlPEBPUhI2xQJIaDTrvg+ipWCv+ma9uIDviijGH6xsXy/S2ySZLSp/V
	rXWAk0WUzc3gpd5/e8Ud8arSlPe+CUlTWkKehLCjae1+N0BEWo/HALI6sdXXyuzu
	IsDCPMy3tjI/nDCpE5usuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764078583; x=
	1764164983; bh=ntC8L8bzslhLIg3qF+wfGwwLw6rXBs0Pz+3oaMKdDno=; b=e
	0QIjbBaE4VaSblDA9prVEuYyAgSgVfcoBOCuoUIHRc0wd2Vpc4X8Xfn6p4qCIaWg
	BlAK3N35nTN9DWnvUXxGZ78RVHhcqGSoIgwnWxRaFTU03w2K3wfyAB/ooIiOXLJr
	mx2aiNMIJeSEI1u5mVrc6a5qsDY82qAdGrxSsoWag67Lmcu7vfHUD+50JRUVl+Xj
	TDb/vU210VLFzesnsTzgV73wJX0QczC5x1T7HyFZxNt4zir0VXQpQhB2iUNmk5J/
	wtn25ztIsNyxn2LwdZ9GuHj66F4v93gOf485fQs7YMgM17UCovG6lI1Lua21oZFM
	FIgMDYSU5Hhg2e50yvs8g==
X-ME-Sender: <xms:9rMlaWNtdj6LLu11gdOoQzasf2q5bDNDGevaydoG5a0P8M8Ope682A>
    <xme:9rMlafxYhovnHgsgmTZZt1gcpmGwfmsiwJgqd04dvMAuRom9FqxV7gjF3TZtqIoou
    ydkVHES1uleN0TVYUZMOebILaXvnUXqPjHmMizwLxGrwMnxeZZ5NMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhirgig
    uhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhephfethfdutdeigeelueeitddtheehudevffejtedtkedvueei
    tddujeefieejieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvg
    hlrdgtohhmpdhrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhooh
    hnghgrrhgthheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthhgvnhhh
    uhgrtggriheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlihiguhgvfhgvnhhgse
    hlohhonhhgshhonhdrtghnpdhrtghpthhtohepfigrnhhgrhhuiheslhhoohhnghhsohhn
    rdgtnhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9rMlacwLdL2xMPWJ_yGzh_9CB8qZGThH0no9fCCFpbh0X8LvR2PTzg>
    <xmx:9rMlaYdehHecAdLA1g07z1RPVZcKVWn80mHScXhwdmvA6YfqYoUIgA>
    <xmx:9rMlaZ5LOJA5XEP1ISrzLLpxKtwuJ43eY4bsVnaqIfPjbBMfR2ta1w>
    <xmx:9rMlaVKsCBjIdGTQs6VTLrFwjXpIIToBwe4_2GfxpH3lnRd5L9SF7g>
    <xmx:97MlaaJBay1Zv_jCWeuTAlYBELwv5bypqiS4iybgOgqxub-0vzEJvIfX>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 941FD1EA0066; Tue, 25 Nov 2025 08:49:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Nov 2025 21:49:22 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, "Xuefeng Li" <lixuefeng@loongson.cn>,
 "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
 linux-kernel@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel test robot" <lkp@intel.com>, "Rui Wang" <wangrui@loongson.cn>
Message-Id: <9c732952-2ff6-4672-ab9a-76ac8590bf88@app.fastmail.com>
In-Reply-To: <20251125082559.488612-1-chenhuacai@loongson.cn>
References: <20251125082559.488612-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] LoongArch: Fix build errors for CONFIG_RANDSTRUCT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 25 Nov 2025, at 4:25 PM, Huacai Chen wrote:
> When CONFIG_RANDSTRUCT enabled, members of task_struct are randomized.
> There is a chance that TASK_STACK_CANARY be out of 12bit immediate's
> range and causes build errors. TASK_STACK_CANARY is naturally aligned,
> so fix it by replacing ld.d/st.d with ldptr.d/stptr.d which have 14bit
> immediates.

Hi Huacai,

What about 32bit build in this case?

Thanks
Jiaxun

>

