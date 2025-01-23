Return-Path: <stable+bounces-110334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E1FA1ABB1
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 22:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5031E167FF7
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715201C1F15;
	Thu, 23 Jan 2025 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bEZe1REO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpYrm4n2"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1798BF8;
	Thu, 23 Jan 2025 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666679; cv=none; b=mP/mdLpJjF48UCmzt3T9DzwYibSO0BN/afV10oAR6UHC98uyfEPMhrFItrXa00gbl+9ho6vBtfrMydvaF1Dh+43o7Ju4ph0ot8LxBXn3T8UZmwuUlhJWluNBYZVS0IZzv0GBqBCNyLyqNJayOovOAlbaKPR1wgMtIqqMKHr64Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666679; c=relaxed/simple;
	bh=riY5dX0faRw1ElfQnuQha4U1OGsAsB4SSMDw4Kve8K8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aPWzZlE4ozu4TXGZkPo+lzS71+RNxi0Gy+JwxItAk1lPYb3WCSYo//zPt8kGE0PbWSqiNjKaybXifxtcVzpPdHccIvlb5IB5lQkYL/LBv5LQw4ocFu+LLM0iIYfCEFsQM+Vl2kUFQ1h1xZkoJZamV7yK9qG+i11tUKGztqmqKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bEZe1REO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpYrm4n2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4E1F25400FA;
	Thu, 23 Jan 2025 16:11:13 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 23 Jan 2025 16:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737666673;
	 x=1737753073; bh=se24KTg+4wVh18lcJfGNX/LiUgDuiQs7KVLGQSDzoXs=; b=
	bEZe1REODAW4YnFQ14oKlvisbkrCo05MDFkTqzQgAJsNm6CJneGS7YKL5recexoQ
	NCsZ0qdBdkJD2+0MzP+RnTRvo1p6MzUuCowJSuwLvKkDmoYCdHrvuuI3NOzi9qGP
	zRJhc1GBPpVZG0cNoWQgM3okhf41ewBBQaxDAZLrFFnPPUVS9Vq/91yIf3IwEbfW
	etDDIlxiniocKLmT9os7/IjLA6hNR5SeDXy1WjBej+fnJ/xf5Uo0/OGqX/j+ACee
	CODm/GlINyEt5/N64N+B6AK7onlt0OgEMAJNOERfTlYQu+Kp9C3TfzcBB5Y14CHE
	suA1qzazOVaeaYdfAXJWlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737666673; x=
	1737753073; bh=se24KTg+4wVh18lcJfGNX/LiUgDuiQs7KVLGQSDzoXs=; b=E
	pYrm4n26efU72o7hs69lFr2ZTUzFxtI3rvs/nHhyDKIcUAGczob+Teofgb67T0R/
	uQyGjbgEWfqnZ06bxbg1S1zVBzy9+a3Whe7mfo7+9IOackL1j1rs6+AAvdXVfA4s
	Z4D5KMfOLZn93HCCeCx4bBY0/yWYqXO0p8N4Y0/F4BQ0lXPCb+XuGf9PMa6qLsFX
	JRbwJFs39oTEa+SFWNx/UXM81cBTqQzXp0vwsbWNkguj8cXLp7HexkCNgc7HlECc
	Tf+8RGt41PjxVdx7mRLC3KAwvdp6IENbcKvE8QMzdPyBzrAvQIc584TwqZDFhOFV
	Gi0kBCnjdq8DLQZDeKBoQ==
X-ME-Sender: <xms:cbCSZxzedH1oVgKWeRKNneBQOkRJsRizZGI0FdtSQ8mEk5XuWQjmmw>
    <xme:cbCSZxTWFbxgnCBjkFUEw9Xxdg05VoMHJAxtYtCxQ0V41-asUPKJ9SRkmaH7hCxWl
    ZN_tuYX8v0msGllsfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehgohhrtghunhhovhesghhmrghilhdrtghomhdprhgt
    phhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfhhrvgguvghr
    ihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghnug
    hrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:cbCSZ7V2cl22SC8HO_TAwDYYcsJARyhE1EEV0LfkGVsfy6ISCtTWAw>
    <xmx:cbCSZziVIkqwsTre6VGmQ9nFQSe6DPBLwHMBbLCF9nhZDmOJ_lE5Bg>
    <xmx:cbCSZzCdrf6hhGIQDhwA9cNelwZqfge6eNuzw7izT2HuqrS_RF18OQ>
    <xmx:cbCSZ8KpS3T3cWPssQbvYrEle9fMFz8x45mZhw8hXWdrJNeURg14Sg>
    <xmx:cbCSZ7b4Ial2c8bPAuy9R6COm4DhjxxI4QrjHI-72j4cpTejFZR7gqoJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2E392220072; Thu, 23 Jan 2025 16:11:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jan 2025 22:10:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Richard Cochran" <richardcochran@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "John Stultz" <johnstul@us.ibm.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Cyrill Gorcunov" <gorcunov@gmail.com>, stable@vger.kernel.org
Message-Id: <1ba5d3a4-7931-455b-a3ce-85a968a7cb10@app.fastmail.com>
In-Reply-To: <82861179-dfd5-4330-86cb-048d124487b0@t-8ch.de>
References: 
 <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
 <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>
 <Z5Ebh4pbOUGh64BS@hoboy.vegasvil.org>
 <0ecf1a72-d6ae-46ab-ad20-c088c6888747@app.fastmail.com>
 <82861179-dfd5-4330-86cb-048d124487b0@t-8ch.de>
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025, at 17:22, Thomas Wei=C3=9Fschuh wrote:
> On 2025-01-22 18:15:13+0100, Arnd Bergmann wrote:
>> A simpler variant of the patch would move the switch/case logic
>> into posix_clock_compat_ioctl() and avoid the extra function
>> pointer, simply calling posix_clock_ioctl() with the modified
>> argument.
>
> That would work, but be a layering violation.
> Or a "compat_mode" argument to ptp_ioctl()
>
> I'm fine with either approach.

You don't even need to add an argument, just use
in_compat_syscall() to check for compat mode inside
of the ioctl handler. If CONFIG_COMPAT is disabled, that
gets optimized out through dead-code-elimination.

      Arnd

