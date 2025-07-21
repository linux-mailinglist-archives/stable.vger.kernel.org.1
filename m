Return-Path: <stable+bounces-163579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E5B0C4F3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F631895FD9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45662957BA;
	Mon, 21 Jul 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="h7Hb6PFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeM3usid"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA929E109;
	Mon, 21 Jul 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103714; cv=none; b=C2rh2VOe52ZkkenSVZ2HPGQgXHbZ1QS+9uVC1hridZTQ86t4E4hIJxMVwXMOghZP9R++p7ZWhVHdncjWMJKmEBbYJcS7NdQ9sfBO3XJNsziX98nibGN2FpNTJ9Nmk5OCgBG2cB4x+QV9akLoiIvJZug1zw+PlrMka6W5r3tNEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103714; c=relaxed/simple;
	bh=wZX+g/qFFYog0yxqsApUOpwW0XohIO8+6gk6jWAxSx0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WgDDTPkOpW5BwonX2fKSBNjPkQIkYwHuaXnk+JupV/kYQdR4w+xlzHSRBmNyOkWnGSQ0U5EFnK1PXpYq55Jl1c1S+grcsN11jh9HJ8rmI1fhSCdOxKcUr7EtgH0J62sHvZcCq53JctsqGSinAUYSGI8QSs9mgETa7NVURHfgLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=h7Hb6PFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UeM3usid; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 878147A01A6;
	Mon, 21 Jul 2025 09:15:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 21 Jul 2025 09:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753103711;
	 x=1753190111; bh=Eep9UxLH4N6S0SdUWRY2n/ob62ZeJSPUIkTme/Hrclo=; b=
	h7Hb6PFT1oLppOezsGm+Pkn4zsnFYrtsvAFVibEAxAAVa63dWWmwXuMpXTuzmov6
	my0Vk/eGMrp2sf4w1IumiDPbF1D+XFpIpFKLQ7bnwJphmY6fqtfHNqyD8DfAzxev
	dq8bQrLkovPzJNBCT5w06X0u8s5xWz3A9Kis5EBCNAymK6ZYisfqkx1068w+sIUj
	7VPir3iIsfGZbKgWz8Roxv3xQl0E0KFJtaMP0xuTr/v08oNznhtZSdfG6vMXDoNP
	5+yXpviBypEtAlD686SYN0YowZ6O67KmqVom0o5J69oooki/MEuUhkUybj73sv+k
	RzuAWHQsUl9eN9x+T5CgDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753103711; x=
	1753190111; bh=Eep9UxLH4N6S0SdUWRY2n/ob62ZeJSPUIkTme/Hrclo=; b=U
	eM3usidlu9t3ZFaZ1IaMGzBWNpPsDLEbbmdZz7UqKrK3fiHTF33E/vAU25kXrG2P
	u1II52SFG/3+nbXfYbsyL5qMvBatqn/SJ9KvOoXmRfpYvDhDP1E73wVQdQKDr4PY
	nJzwIqj6rDBImtgT7EcWyY0MWA2+aLDp+o7J3wKDaZdxO+pssOCeAbca5Or4dCrc
	OYqcDLJ49o0UWaKoECS7j2FknSZH22KzveokpcN2FQFy5Ak7VOIR1ugpcloksNEU
	KQjJ0T5qAf0mi2iU8r2QuHc8gFBgEGh6iWxx1PACyTHun4yVcCHYoDrgTNQIAwUZ
	4dcz3dLUJct/X19yCva0g==
X-ME-Sender: <xms:Xj1-aGXRsG4H7BtHqpEQ4xUCfdqqkgR4Em9E_ftAKH81T8hhnuQn7Q>
    <xme:Xj1-aCkCfOSCKs4gpzPfOiip2Oj0WGwRwwFBd1oXVQKlVCVjUv1GwKiSbPh553hlk
    -Wdrrw212yZaLe1ync>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhgrsehffh
    iflhhlrdgthhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlhihuuggvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:Xj1-aMfEMwjbAdwSavdmPj1CLD49P4VgvQNWm2Xvy443JFl181qJJw>
    <xmx:Xj1-aFkJUgjn5KMQBNpIvDGXnV57KS4NF7SryVRSKqATeWa63gq9Tw>
    <xmx:Xj1-aDH1LQpPo1vXLaRXMJrZ_YJ1DMFCJm7E1fRAK_zEwc3V7Xljaw>
    <xmx:Xj1-aN5HSxKC1e-enDfe6HyrRHX9SY84gynCqrhF-xzzdsVjI8xDoA>
    <xmx:Xz1-aLr7paP33Q1p6ccdq-eii51UlIVqm-1xjFLdQDiw2cPV8vsuf9Ap>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8095700065; Mon, 21 Jul 2025 09:15:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8cdcc59f6e1786e2
Date: Mon, 21 Jul 2025 15:14:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: "Lyude Paul" <lyude@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Message-Id: <b32c7957-6827-45a5-860b-f28baedd9f60@app.fastmail.com>
In-Reply-To: <20250721124923.811224-1-sashal@kernel.org>
References: <20250721124923.811224-1-sashal@kernel.org>
Subject: Re: Patch "drm/nouveau: check ioctl command codes better" has been added to
 the 6.15-stable tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 21, 2025, at 14:49, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     drm/nouveau: check ioctl command codes better
>
> to the 6.15-stable tree which can be found at:
>     
> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      drm-nouveau-check-ioctl-command-codes-better.patch
> and it can be found in the queue-6.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I got a regression report for this patch today, please don't backport
it yet.

     Arnd

