Return-Path: <stable+bounces-165148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA046B154AB
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DF07A7A30
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86B1E0E1F;
	Tue, 29 Jul 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="B+8M0juU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jW0kfIOO"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BE79D2
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753824622; cv=none; b=pDyaiwIQK6lBcTKI2wpsP6AqHA1AMeVYRx84Cyj4faxiW+7J6w+FbaPGqIdpWzLGkCgH8nXmFclfCymTl/A0DOtMBcxFWPZ2IsIiAAllj+Zz7bMVcacnWgLVXjIR0heLUwev4VuvzNkCNiavs1Cz32zfhYfsueKveDpNS6PcKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753824622; c=relaxed/simple;
	bh=6pTBhaynRXsgIq7eO5p1hGVdudIcyg4X6kThYZSax8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/3v5bWb6T6yKZhPc9JKtkfL1LV9WKaXhdDfcje08t5/ZQ/sXUnwiezWj5mhT3GwnY0Cgmyqb5LdB7mr4z2VXdD9tvqHW5bryXuZwaO8bfxjslw35mICADc5EJuozxn2pGxlramWpPdONv31ecYd8PnAz3gY1RATyqDDxUitmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=B+8M0juU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jW0kfIOO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F9747A0657;
	Tue, 29 Jul 2025 17:30:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 29 Jul 2025 17:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1753824618; x=
	1753911018; bh=61s1PkULoQ6+1LJn1aB/gkVlWzY5N0zLGgVyib6Y/1A=; b=B
	+8M0juU2bTVbibe8tBPfwRhjmlmd6GaO35XdpOurhQyu18odHKaO3fo91ZNvidIF
	7woEevLWK9APuyPFgUWdiMz8RCPcUVuj/gIM8ZcergHnCPnNuRa9GzfCX0IlkTbh
	KF5nyzX7fB9v40pRGaQMcHNwIFm6SB+7lWHd62Uc+J0Xigqf7lIdT7EJtZhiNrUG
	CkO2Rro/+Tss2cDe46PvPbINxokdf8TH0KUrNf8SZFqy3BJQmwyymeVBHwLunFAA
	8d1HHhhYCKUK1JE+CYnjr8XzHNR3asO2pKN+fGDcznxx9ce9szr226cqRSAryws8
	vsRUsQeGHFHiQDeXGpbgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753824618; x=1753911018; bh=61s1PkULoQ6+1LJn1aB/gkVlWzY5N0zLGgV
	yib6Y/1A=; b=jW0kfIOOy5URfLF+Np4dXlehmXdX2By/MDwJCX2PbI1jYWleAve
	jAAPajQliN0SA5gtxlZKx8wTMLr2OWKPwSmoxKhXBJBCGSnAAXcMfE0iTreBXxlp
	DuLcIUsz3yixkl/BycwebMI49HKMYaBMiqfxhkw4BOYTDnRj7NIgj9UWRWZB3qEF
	SaypQWWYS1f6vz+y4IEUxdNx/94q9sM14GFNhvz1VqAkfzn4zLV/Apno1USaQB4+
	tOECXiz9Bn+oSV1OJ9fm9Y4gj/IzjFouBUnzW4imDabOGWtgZW0Yk2j084uayNg0
	hd/t3K73HZ1A/QwEt76kmnwgCv8q6om884Q==
X-ME-Sender: <xms:aT2JaHXAxEcldSCwTxJ6JOoJbXHCYUT-fX1f3gmBX7cvcYROrhnkXA>
    <xme:aT2JaKIddaOO0b0yr9-E7oIrovhzMHT7x0rXKy1x_dGksBy_N3DbDTW1p0v-pgRma
    -siwR8I36uCUG2PhQE>
X-ME-Received: <xmr:aT2JaP839XcM4xc3fa4cPyahc1L-1SzzILQg9Jk8RaZxQ4Wwkh-svZc-vYb5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeliedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeghffftdevudfgkeffjedvieeilefhtefffeefgfehvdevhfejjedvkeef
    leeggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhn
    vghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhn
    uhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhht
    sehsvggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:aT2JaFInDdK0G9X0phOzFbP1C3kvcQiXyn8wRYaDYHJ3-Ckug5Zmxw>
    <xmx:aT2JaMm3G-t0EMHzT90NY6I6kZhLrRj1UdWKs1x44Jz6ljNVTuUJpA>
    <xmx:aT2JaBPqIkV0gKqysDNrtPLEMAxebF4_5eqPwJpBGJgP3bDj6nJbzg>
    <xmx:aT2JaK2i2yxj5LLk2qvDG0vg1lfz5P9da3Eo1WWEchnJkY9jQoXaLQ>
    <xmx:aj2JaLyOBM9jDBXcufSf8gU__fQP7cZy7vWUvXbIK92x2Jz5NBgBD9gw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 17:30:17 -0400 (EDT)
Date: Tue, 29 Jul 2025 23:30:14 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 6.12.y 1/2] xfrm: delete x->tunnel as we delete x
Message-ID: <aIk9Zl0Fy4x8Z768@krikkit>
References: <2025072924-postbox-exorcism-f636@gregkh>
 <20250729211153.2893984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729211153.2893984-1-sashal@kernel.org>

Hi Sasha/Greg,

2025-07-29, 17:11:52 -0400, Sasha Levin wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> [ Upstream commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd ]


2025-07-29, 17:11:53 -0400, Sasha Levin wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> [ Upstream commit 2a198bbec6913ae1c90ec963750003c6213668c7 ]


Can you wait a bit before taking those 2 patches into stable? A couple
of syzbot reports landed today, one is definitely related to this
series [1], the others probably are as well [2][3]. The patches should
be dropped from all stable branches for now.

[1] https://lore.kernel.org/netdev/6888736f.a00a0220.b12ec.00ca.GAE@google.com/
[2] https://lore.kernel.org/netdev/68887370.a00a0220.b12ec.00cb.GAE@google.com/
[3] https://lore.kernel.org/netdev/68887370.a00a0220.b12ec.00cc.GAE@google.com/

Thanks,

-- 
Sabrina

