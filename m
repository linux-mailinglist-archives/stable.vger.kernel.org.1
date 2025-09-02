Return-Path: <stable+bounces-176988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EB6B3FD74
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884014E296D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABA2F6175;
	Tue,  2 Sep 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="b+tqgRQc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKRqOp5B"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BD2F6572;
	Tue,  2 Sep 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811524; cv=none; b=DokDAPTQosGzAywTESLKITSVJgAUBWhOllP3mTLoWwHAvzHd+cyj85ytP4RjNBzgVuLWFJgde4P6dn/0+QLpfEwJnZbLcbBTzb/31AQpy+2nmSWkehvLvuBRAgrfe8p1OpLiBuBT5CFWitf03YdVTEXWsKTzIFAl7z24To6SORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811524; c=relaxed/simple;
	bh=9gyG1h1hU4t7r1+n8CeUTTfxyM1MciEAa1MhBc0Uq94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhQjU3qt9ArpeJux1LJDWfzoEq9aR6qxo4O7TiAhK6ZrrtX2XOGMQtzayvujrQiEBnr999RWLf9sDvm7kF3vPOQDdcsdq/NshSbwJbIzuOhFtIoYhJgCKLxgpfQkM3t3TNnwxg1v5K+BewtzVp9q8Vv7enZq3xRrTQyfBlcHh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=b+tqgRQc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKRqOp5B; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EABBD1D003DF;
	Tue,  2 Sep 2025 07:12:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 07:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756811520; x=1756897920; bh=oEo1sWgdkR
	2fZhoRJGUyuXK1ZJMYy56xS5462AcuqWU=; b=b+tqgRQc4K6gdhWLjoaea7XOUV
	fAEJdZ2jncRoEbyT/KtenkiFW3+yvGlVljH4Mu9gvVYxna+0Q5Iy9sX4P5daRMA5
	LAGDMN2Se4eeGrF+psTSFHaG+3uNxiSAUHuxDwDqBVnGL7579uq2i78ZTnw+/DvO
	cue7x/vO6858r/rWuU2Qu3TLO8qrlS3g2oJH+3M/jzpXrIGudt+cOf5nTnx9bPkF
	TtYW6WoaySXdMFRE4KMqe7Ocf9RtiYXmmA9ARXFPg27TRpPKVvThRVIONykHdiqq
	0foLb3U+gp6k0W5tIYP/EiX1mer0o9zG+w175yIzrCf0z3qeOjyugYV5dPEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756811520; x=1756897920; bh=oEo1sWgdkR2fZhoRJGUyuXK1ZJMYy56xS54
	62AcuqWU=; b=nKRqOp5BDMmp/mBkMYWZeq+Mi3dyRuAzHrJL/X+os12To1IxPeu
	SwlrUGWqa3RfjYo1uDHtMVBdMwM+nugDxBeQy1OYLe/BKblrf7Uc3cyEjGIrFJjy
	5V59Voiysx5krWk73tNj4nq27liArdrMX+s2pX2cKtQ/In26wVtIsm/aD9KtEyfv
	cBqyj+PmzCbhtkbXUeqIuDWJHSp1tSsnScQBZvG5ocaVaPoVte31R46RSl6uSHIl
	+mo9s7EjwHdqmFxQalKH+RwW8kySl4c5OVBmqYwpocAVMCVA28lzEUiboZfOx5sj
	hfZoY/gNGsF21G4NxTxakFKYQtJZ+ZkhhAQ==
X-ME-Sender: <xms:ANG2aIvmH1oCPeY8AV8SYCOmEqnn6uHhwu4z88T7-OevQhkkuCaGXw>
    <xme:ANG2aEYQBa9pr3fRW8zzsfGPP5xUJymJ1v0xfyPYrknNtgpKR7DhoR4mnz_97HJZG
    vIJekvyg3Pokg>
X-ME-Received: <xmr:ANG2aP1E-flSGOtnCwhz6bUBVBy-2psPYrP46uPDCiOB8mWth4LskB1at3Qelc_tfWiHBaXYA0Iybp3-azTF2oK2j5oSTyiNKw3jUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffjuceo
    ghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeekiedvteegvdejtd
    elteegleejvddtlefhkeekkeevueevffegudeuueekueejheenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggp
    rhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkuh
    hsrdgvlhhfrhhinhhgseifvggsrdguvgdprhgtphhtthhopehlihhnmhhqtddtieesghhm
    rghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhpihgvrhgrlhhishhisehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnihgtohesfhhluhignhhitgdrnhgvth
X-ME-Proxy: <xmx:ANG2aOsdPcPpJLHyjT40ro1QXbndF-dr1an_SUjW_Z4rsZo5cDan2g>
    <xmx:ANG2aLCuHL_3wywpqO0E60ZryZzcJfdeRvpLp64D4jsctfPTCtraTA>
    <xmx:ANG2aJaLE-k8bHWShoVrOWJri64Q-9PCzUH_A7OF291Lyw0gvoDMpg>
    <xmx:ANG2aF-StkIaeR7X33OrPcjcr0VH7JbtlHpH8A4UZdgHQDBz8vWPcA>
    <xmx:ANG2aAssAn3okZJMZz94gWllIqlILfdRUlxYtj2xRu0yEpkiW6IDj275>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:11:59 -0400 (EDT)
Date: Tue, 2 Sep 2025 13:11:58 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Miaoqian Lin <linmq006@gmail.com>, kernel-janitors@vger.kernel.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] drivers: bus: fix device node reference leak in
 __cci_ace_get_port
Message-ID: <2025090254-taste-december-f544@gregkh>
References: <20250902074353.2401060-1-linmq006@gmail.com>
 <cbda4163-6211-4c81-be99-634b842a349a@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbda4163-6211-4c81-be99-634b842a349a@web.de>

On Tue, Sep 02, 2025 at 11:44:10AM +0200, Markus Elfring wrote:
> > Add missing of_node_put() call to release
> > the device node reference obtained via of_parse_phandle().
> 
> 1. You may occasionally put more than 58 characters into text lines
>    of such a change description.
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n638
> 
> 2. Would you like to increase the application of scope-based resource management?
>    https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/of.h#L138
> 
> 3. How do you think about to append parentheses to the function name
>    in the summary phrase?
> 


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

