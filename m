Return-Path: <stable+bounces-111989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D34A2543D
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C51649FF
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14520ADE4;
	Mon,  3 Feb 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xCgwH2us";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tDqUNebF"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102F206F3A;
	Mon,  3 Feb 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570588; cv=none; b=NbbAEVcK1p7iYPqjIwJuIOq6yFQYPe5npA1LVUFot4BrFECCIeG66jjh9psyjxSl3HCG78GBvfBBS6JntKb0hYP2BjXUJFH943Izh/hjeh+Zh8DSL32QOPD9OBPSbGDLQq6uVv/Do2+KA9wjECa3t1YZQsJPSgXxFm09Em6hlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570588; c=relaxed/simple;
	bh=2Im47tyY0OLAFV2dGWEPhjsciAHY/8qN3psUBo9yMzE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=scfLq4njJW9AKQRinKY/9C7+Zt9y1sCR6H3ljQHa9LvtBV7deIH29UIWjVWCXWW79+5LIonGXKrh19v6JmLqMOyEoyMh+gGByHrHL288OiQztAXK7LvrRCzpU+cy/tmRofYxqyc/rG8ii9/70vkoXBYB64eGktNRmG7LQBfSx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xCgwH2us; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tDqUNebF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCA0211400DF;
	Mon,  3 Feb 2025 03:16:25 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 03:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738570585;
	 x=1738656985; bh=pwRQ96cNN5emwssiv0Lkx4BzFl1xLvexcr5FtbOIjYs=; b=
	xCgwH2usz4ouH3lCrMO27HOLXKTjRrIXcnPqUVap9feYikvK3kHtmrlCzh/R+T7/
	hwIqxjrmBpCrrAnUvjij10EIwrETG79oDYJvfI9XQDrlW+WqrfZf5dqc0eGu0QkT
	GjwFz4HDv8xlRIX7cCGAGas1QTTylf0sJz+dj3i23bSB0VXVNIIRM/AnZmSVqW3x
	YWZG+bCj+dc1MRUqCIBEW7QBg7MBJF121n+1YK2OWWlxi5p76LUxboxPD/JUD6dk
	k+NeofxlEJih9dAggWW1eSaM3foj76pTnA8WkSRp8Jhsw+IAkDFATIwwy44PibA0
	LzQwD6cgmvjXg7eGFGVNzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738570585; x=
	1738656985; bh=pwRQ96cNN5emwssiv0Lkx4BzFl1xLvexcr5FtbOIjYs=; b=t
	DqUNebFEzH8bT/DnnXANpxQIxVxEVq6RP/8Iaj2KLP8vK8SRB3DojtOE92lQQnem
	Bau2qQU8apkomEcyO06mWazfOlobwfp9N+/xrgD9k9zSJYJDHx9muUlR4d4i5+vR
	4YtTgEzI7c5mMow9X0Js5b0ifW/mhtg9G2MRZIlpZcsiMvaToG9K3aKSUDIHoX2U
	LRAmUTx0iLThU8f8GB9G2ifkZn9pmksleg5lYU31mh1fBOgkQ4wX4F9TnKCUh0Sk
	0Z8lwP0YaAOu5uoP2NTQvdsjP1iS6cYfLMGXYSSwwCBv+pusTX3QEoz8WPGx+tpK
	7uso7JTVWgojtDKqxxt2Q==
X-ME-Sender: <xms:WXugZzuDYQrEGpmqMnoPbXxxrU8flg0hRl6BkQINPCQqYyySZ-GAUQ>
    <xme:WXugZ0f-xXNFASz2ekBD4IYAB-KPwL-vOPc0_YPRBd7cRv2eN2aajUchrQtWJD0t9
    wl1RoolwskI5AwTpic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghvihgvrhesjhgrvhhighhonh
    drtghomhdprhgtphhtthhopehjvghnshdrfihikhhlrghnuggvrheslhhinhgrrhhordho
    rhhgpdhrtghpthhtohepjhgvrhhomhgvrdhfohhrihhsshhivghrsehlihhnrghrohdroh
    hrghdprhgtphhtthhopehsuhhmihhtrdhgrghrgheslhhinhgrrhhordhorhhgpdhrtghp
    thhtohepohhpqdhtvggvsehlihhsthhsrdhtrhhushhtvggufhhirhhmfigrrhgvrdhorh
    hgpdhrtghpthhtohepuggrnhhnvghnsggvrhhgsehtihdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WXugZ2xmlSBKHSbM6g9vL9WlFBKhliO7DWtuGZHP-qkRcfS_vgBlFw>
    <xmx:WXugZyMQFXI8f_6BJeL6Mwi01eLCDGrg29VIA5YA8w-p3znCVkjXyQ>
    <xmx:WXugZz8V__UOYyRl9xDPWllTnRW162zo1TG5z3i4i_E0Ii2DoS_jsA>
    <xmx:WXugZyVCraOMR1hvr06kkjjo3gRboH-1BmFRui0jSgy2DnWotEm5nA>
    <xmx:WXugZ0Oo17sI6OA6kCX0vOfDRm3QDSAnjLqsB0Me4ioWHlWdflr-A-7y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DD9D2220072; Mon,  3 Feb 2025 03:16:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 09:16:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sumit Garg" <sumit.garg@linaro.org>,
 "Jens Wiklander" <jens.wiklander@linaro.org>
Cc: op-tee@lists.trustedfirmware.org,
 "Jerome Forissier" <jerome.forissier@linaro.org>, dannenberg@ti.com,
 javier@javigon.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <15a801d6-2274-4772-bbe3-5d2083b91b64@app.fastmail.com>
In-Reply-To: <20250203080030.384929-1-sumit.garg@linaro.org>
References: <20250203080030.384929-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 3, 2025, at 09:00, Sumit Garg wrote:
> OP-TEE supplicant is a user-space daemon and it's possible for it
> being hung or crashed or killed in the middle of processing an OP-TEE
> RPC call. It becomes more complicated when there is incorrect shutdown
> ordering of the supplicant process vs the OP-TEE client application which
> can eventually lead to system hang-up waiting for the closure of the
> client application.
>
> Allow the client process waiting in kernel for supplicant response to
> be killed rather than indefinitetly waiting in an unkillable state.

It would be good to mention that the existing version ends up in
a busy-loop here because of the broken wait_for_completion_interruptible()
loop.

A normal uninterruptible wait should not have resulted in the hung-task
watchdog getting triggered, but the endless loop would.

> +	if (wait_for_completion_killable(&req->c)) {
> +		if (!mutex_lock_killable(&supp->mutex))	{
>  			if (req->in_queue) {

Using mutex_trylock() here is probably clearer than
mutex_lock_killable(), since a task that is already in the
process of getting killed won't ever wait for the mutex.
mutex_lock_killable() does try to get the lock first though
if nobody else holds it already, which is the same as trylock.

     Arnd

