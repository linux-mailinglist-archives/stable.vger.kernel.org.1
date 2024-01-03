Return-Path: <stable+bounces-9276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E482315C
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0771F24115
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2321B29B;
	Wed,  3 Jan 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in04.sg header.i=@in04.sg header.b="b5yJFOBo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s4vkkhq/"
X-Original-To: stable@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A01BDCD
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=in04.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in04.sg
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id E5ED23200A55;
	Wed,  3 Jan 2024 11:37:23 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute6.internal (MEProxy); Wed, 03 Jan 2024 11:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in04.sg; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704299843; x=1704386243; bh=lsenOKM6E5
	ZQT+IlSbjIollNcvJ205DzjQcPU3TEv0U=; b=b5yJFOBoLswMkZfXkaH/k/bY5g
	T7+1+p9OdeBs55g9cDUPvRE4TygbswS48IaOnIA58Q6r3cZIEniuMTAUmpeP8JqU
	uQoa7JRXH5PbWRq3p/OZ73ake946Np/fs9VRiSu382Uq72PyK3vBFWBoQ1EKzizV
	Fkl8sdVKA3GpfHtcBvlD+2HaInCg1hl5/Fw4vBJdZIhPS1hvi8TzU6slJUpE0Zlc
	JiyhoOXrBdyeHASf23nHpkgAgTbkng/4eT13EAqXyrl+ORhWJ7UIfmCFfgVdHtlF
	I0/RMYu673Q+JzuD9H9l3r/ScdppO7Sdzo/Vtt4m3ZKCPx4j8SyKnOzsaJsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704299843; x=1704386243; bh=lsenOKM6E5ZQT+IlSbjIollNcvJ2
	05DzjQcPU3TEv0U=; b=s4vkkhq/P5gINc3VLpjg9M/4qH0v92uh0gIBxpdpDpjU
	BBOOUBHW3s4MJK4N6dBvqn9mwaGY/3Gtant23YJX94qjejNk3rDr6dPl4eq1Updm
	PGp9mSxlfGCbh5fU6HNiVT/4WoEeQG8z3bhGglZeRkcG1P9VptuoyuML6QgRGdyJ
	RRmv2iK/RSK/GqmbwN0eSbyFGR5AkQLeCyY11J3xDbGYyHHr0Tv13H93PNOsMjOH
	68sPesWa/YvJqiTWdT0r4U7TKNYfYmf0GDgdRE2M0Ed1ofwf/K3PbsMSs0zyXjxq
	f41rxzzejH1uSJnO5/0AAV0jGbYwJ6wVkSy/85Hk3w==
X-ME-Sender: <xms:Q42VZdTbhUNWTr0mkZ5Ybc8iFdqREapmYvGCle3SQ72V2PBVV8K_eA>
    <xme:Q42VZWwt5cr3BwN_xdXqBrBpwkiQ5J_Ke1As5Sn-h9CSshBfaf7gzXgA79Jqp8RP9
    cPSTQzJX-0oZwkdlHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvfgv
    vgcujfgrohcuhggvihdfuceorghnghgvlhhslhesihhntdegrdhsgheqnecuggftrfgrth
    htvghrnheptefgheffgeeukeeltdeugeegueekleettdfgleeujeevhfdutdfhueetieel
    hffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnghgvlhhslhesihhntdegrdhsgh
X-ME-Proxy: <xmx:Q42VZS23U8nMnv9EIiBagaw-RvZrP4snR9vZSRf-0kt78N4aQEBbeg>
    <xmx:Q42VZVDYlhcRm64tCJk8PafHN0S0pHzG8lqSW8u26YWMfamFkTn3kg>
    <xmx:Q42VZWi-lZco26KzZuK4XrNsN80EITcVAAfE1sRRfDDDYo7GdZ5lTA>
    <xmx:Q42VZcchIZNucNXfY28uHYxyS4UxZImRHYR1XU6mNYJ0r7dOVyvT_A>
Feedback-ID: id6914741:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0098DA6007A; Wed,  3 Jan 2024 11:37:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69224c8f-8190-4f7c-871f-267dc66f36b1@app.fastmail.com>
In-Reply-To: <12353213.O9o76ZdvQC@pwmachine>
References: <2023102922-handwrite-unpopular-0e1d@gregkh>
 <20231220170016.23654-1-angelsl@in04.sg>
 <279de9e4-502c-49f1-be7f-c203134fbaae@app.fastmail.com>
 <12353213.O9o76ZdvQC@pwmachine>
Date: Thu, 04 Jan 2024 00:37:27 +0800
From: "Tee Hao Wei" <angelsl@in04.sg>
To: "Francis Laniel" <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] tracing/kprobes: Fix symbol counting logic by looking at
 modules as well
Content-Type: text/plain

On Tue, 2 Jan 2024, at 16:46, Francis Laniel wrote:
> Feel free to send me this updated patch privately, so I can also test it to 
> ensure everything is correct before sending again to stable.

Thanks for the offer! I think the patch should be good now.. 

-- 
Hao Wei

