Return-Path: <stable+bounces-92172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD77E9C4992
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C552825F0
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A61BC9F4;
	Mon, 11 Nov 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jschaer.ch header.i=@jschaer.ch header.b="NasI9f2A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jwg3PZoG"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89943224FD
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731366617; cv=none; b=Tiwj+N+kDZ12qREYSxg1FFX29rM2An5Lo7uoTQI1L9qfEiysynoAR7y1yGtMrGTKfBxpUY/ulqVwwhiXzLu/iy7XMTQfFYexvMlARfQYdyWDfeUJyKliJN37pr8YTvnBLOTUyCNvq0xbwsMCA62sIgYwSL6GMW5B7q2yChyNv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731366617; c=relaxed/simple;
	bh=apuYF3oDpBIGN0gjxNgqgHdrFLMKj6BE+M13T0lne88=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VNoU8jW/b0jlFDG+nvDpw5x9coGeoXHcioBTq0WaiowMiiCM8xj/WqKhdfp5B9rXdLY+LUu6uQsAyXUlSEdfAGT8m5remqSPoLKJDhDrDsRgpP0sTGaUDa5sxIwvOVSosex2x4xOHId+XACUCUh3NXhKPl8cQZHGhCKrBDkftaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jschaer.ch; spf=pass smtp.mailfrom=jschaer.ch; dkim=pass (2048-bit key) header.d=jschaer.ch header.i=@jschaer.ch header.b=NasI9f2A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jwg3PZoG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jschaer.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jschaer.ch
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F14811401FA;
	Mon, 11 Nov 2024 18:10:13 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-06.internal (MEProxy); Mon, 11 Nov 2024 18:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jschaer.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731366613;
	 x=1731453013; bh=6b/+JKq2QIzd4ACB7YyaL+JhStMctV4ECBY+IscJCMo=; b=
	NasI9f2ARYEWWU0EmiUPjJFdDt13VC8zWw0lLRZc8EU7aGijNxP/M2U65CiIuA6k
	4R6TaI4BMWATKaJVAbHZ5jKqmP01/uoJECFAStAr9IWW3JRfCVDR+vYP4bPGWw1Y
	AgsHjY1vr86DOrrD5kJQbVbqybJuMUgF8jJKv2Ojl8FdGpLa/Lnjwzyv4HoCR27W
	0PQbyI+158qENTwnjx4LofwKz36TOqqBpOxAm3wgaFbsYDdSVvjYHlnlv+jT6jYc
	aGzb7UtgWGQ+upK9/wgUUCvyplSCTI8LNeVzIPxkyXR344+osKgvoHVt+jY1suPh
	dgpGO2COoZEWtfNmbb6caw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731366613; x=
	1731453013; bh=6b/+JKq2QIzd4ACB7YyaL+JhStMctV4ECBY+IscJCMo=; b=J
	wg3PZoG3eF3VLo42jm1id9+bN0UvDg1euDGhQBNKKlR8epWTAvTSuoQNY/+ieeB7
	eoypVq9M+ArbJ/irjQtheFm7km2YHox1THyRKl3j02OueAlVMiz1Ppm6o/hxS1Yl
	1L9MhAEwqk9Ld1zRNr3MCgVwR9Mn7PbGwxnt63+b91lduW5lYQsFxR01S/GW9l0m
	Cljy6QXZKNDBXvB4MoTmGzCLKSTfI2SVK1auJS2ijDL48/TpGAXx3PmXN/kOAdLk
	Yqrq29qJKV/MezUzQd5sq1YFUvihU8+cBn+1cl2opI8AMi/7bgQbzmjbu9ci+qz9
	nqNkU2nHdb8EFnN/irQtA==
X-ME-Sender: <xms:1I4yZ-Y15QfaQWqQF6uNlpspNTXlfeDI4a6aaclblcXjZDVO16JMQA>
    <xme:1I4yZxazArfSPbGEXr5is1NdtXguMPZb_N5vDS-bwVNGZR9qHNoE9rmBhsJQZrZ65
    8n6iBAyM8H9LlvoSw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredtjeen
    ucfhrhhomheplfgrnhcuufgthhomrhcuoehjrghnsehjshgthhgrvghrrdgthheqnecugg
    ftrfgrthhtvghrnhephefhhfeuffegtdeuvddugeefhfdtleffveetleekveelvdekfeeu
    ffduvdduveelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgr
    nhesjhhstghhrggvrhdrtghhpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvrhgvgiesphgvrhgvgidrtgiipdhrtghpthhtohepthhifigrihesshhushgvrdgtoh
    hmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1I4yZ49ctHzdSQoZBQdfNF1nqMlofbvUIbH4V1HSR5cQ3f-8vqqVhg>
    <xmx:1I4yZwpPq77kCTJnm2lmXo00V-JrZC738mVAOLzyRCk2BMLNzuBM0A>
    <xmx:1I4yZ5pnb92ZxgPYPc9LpNjlJIJlFypP1pLqaG12abf-PPe2iO620A>
    <xmx:1I4yZ-QUYu5gpydbzy-6H8sm3bzNJAJVllm-1RR94W2-Hzyz80bd-Q>
    <xmx:1Y4yZwWzOiy23JBNquTvKeccasSXR68lgwUIx4vHIM8AAHWvOrGbL33Y>
Feedback-ID: ie67446dc:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8DC21C20066; Mon, 11 Nov 2024 18:10:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 00:09:52 +0100
From: =?UTF-8?Q?Jan_Sch=C3=A4r?= <jan@jschaer.ch>
To: stable@vger.kernel.org, "Sasha Levin" <sashal@kernel.org>
Cc: "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>
Message-Id: <9e71164a-d69e-401a-a1ea-9ef2fc6f6e02@app.fastmail.com>
In-Reply-To: <20241111170021.1580083-1-sashal@kernel.org>
References: <20241111170021.1580083-1-sashal@kernel.org>
Subject: Re: Patch "ALSA: usb-audio: Support jack detection on Dell dock" has been
 added to the 5.15-stable tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Mo, 11. Nov 2024, um 18:00, schrieb Sasha Levin:
> This is a note to let you know that I've just added the patch titled
>
>     ALSA: usb-audio: Support jack detection on Dell dock
>
> to the 5.15-stable tree which can be found at:
>     
> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      alsa-usb-audio-support-jack-detection-on-dell-dock.patch
> and it can be found in the queue-5.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I think it's fine to add the WD19 patch (upstream commit 4413665dd6c5) to newer stable trees which already have the WD15 patch (upstream commit 4b8ea38fabab), as Greg has already done. That patch just adds a new USB ID for an already existing feature.

But I'm not sure if it's a good idea to also add the WD15 patch to the older stable trees. This is a feature, not a bug fix, and the device works fine without it. The only thing is that you may have to manually select the audio input and output.

And, the jack detection feature only works (with both WD15 and WD19) if you also have alsa-ucm-conf at least 1.2.7.2 installed, which was released 2022-07-08 [1]. All these older kernels were released before that. I doubt that there are many people who have a new enough alsa-ucm-conf installed, and simultaneously one of these old kernels, and would benefit from this.

Jan

[1] https://github.com/alsa-project/alsa-ucm-conf/releases/tag/v1.2.7.2

