Return-Path: <stable+bounces-112002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F205A25767
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B871885890
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34459201100;
	Mon,  3 Feb 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kWIHqiqL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAsLZRYb"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9D2010E1;
	Mon,  3 Feb 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580017; cv=none; b=uw9SGcI/SkXCPhMAwOB8g5WiXqHwvtVycT10mcMHthTeI00fe00OUVri3htQWnOI9NWv62bagt4L+zudgW4SoGQCoMQK5Ge0LMxJcuy4d/mG+4jT0+t5FxXY8vsS2RpmvYHNIVysN33kNeMZJLJ9gv+Ob9mPBszTfQFENscd0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580017; c=relaxed/simple;
	bh=YjfaQMuiotSBYmqR39Ih2PixqmJpdkXko6xcc2Vc3S4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Zc57W9grGwuk4zn4V7PwBRZ732fPc3kGXisO+7Zv6sy4iDKf7iELMt1qJiFi0kRkcpO67BPYgKAgU1NO1GsJPiKj6wzYytaTHg4DVlZSMozU+Sc6Ki/C9byQkh1VHmDFd6pNqqpuX3GYBcg3nl/kve0NS3rcqsA+6FNm/H5Sc2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kWIHqiqL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAsLZRYb; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBCF411400B9;
	Mon,  3 Feb 2025 05:53:32 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 03 Feb 2025 05:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738580012;
	 x=1738666412; bh=fno2d7xBQTHyGEag7JukI6+jFsxK1yZ6n1t7uINgMOE=; b=
	kWIHqiqLhQ95YW0+xYY7duHqkRQfUW/mPbwBrI0bTJWV70k28squMgziHVg8BGgA
	jL7ILlKS0nj5LmOL0ucGPzgLYrpcYcnMTkon05jmZbZciQgXkA4xJuqz6dmKIGX6
	BntrbQzCqYGx3jiY/RXYHRCuHPjAN62nt5sEL3GIn79MjUU1r0VykR71r+8QiRPe
	UE1WVmaVtifubM19L75sj9MfgXXrW9FY2/XtXu0akRQfxNEj/GCpz80yT2bLOBGn
	+dPqAKJt7w7zj9vFNuqUljjk1tlWvdydGvbeg2hkxZzjU9vWz18KwuxxBRStZAjy
	YZ1oMasaepRBL6PBZ2hdIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738580012; x=
	1738666412; bh=fno2d7xBQTHyGEag7JukI6+jFsxK1yZ6n1t7uINgMOE=; b=h
	AsLZRYb3BgDEBRC2xuZ54cxzGG9lkf91hXIXSq5s/oOGcMaaIf8DrpoDAAvBy1g9
	lEhZ9dVUXReMT2hEoUjALrtBASkjunUw0MVS8zbratMjFi+ZhmiDPQFlCTXXQdXJ
	EjWnrahJMmfE56pHf1asCJF1UvHK67hJdpgqgBDi+qtiLWqJ6RzCqi2MsUJC1ThO
	uGJ/B45SloGMmTmJB8No8iUF7x2knVc8/JsudpxnJvn1+/M1nTvHX6Fwd0h7Qvo+
	4diIucAqLGWwbbMc1wBb4dVbEG3qSS7mssPwOJIr0WzB3BVefsdZErGXNAaY2vOR
	v6xTPzNH8At7Y6OkCLVlg==
X-ME-Sender: <xms:LKCgZ_L3WuG86QFyCfwl02Lv7wdc7hrd3HW2VOnIucAeJ7DLOay6Ag>
    <xme:LKCgZzIajWV2P1Bew85XCDP_kTU5K9tIn9SN9gUFrfvQE4n04c7lSkIdR6NLXC8EZ
    gVQnnMlrFw4HBS6-p0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrghvihgvrhesjhgrvhhighhonh
    drtghomhdprhgtphhtthhopehjvghnshdrfihikhhlrghnuggvrheslhhinhgrrhhordho
    rhhgpdhrtghpthhtohepjhgvrhhomhgvrdhfohhrihhsshhivghrsehlihhnrghrohdroh
    hrghdprhgtphhtthhopehsuhhmihhtrdhgrghrgheslhhinhgrrhhordhorhhgpdhrtghp
    thhtohepohhpqdhtvggvsehlihhsthhsrdhtrhhushhtvggufhhirhhmfigrrhgvrdhorh
    hgpdhrtghpthhtohepuggrnhhnvghnsggvrhhgsehtihdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LKCgZ3trFXzDywekajzC6KSJCUk5rpoxjVZBD1i-0kI-cMyxISItwQ>
    <xmx:LKCgZ4ax9hdu8fcBLGtUAr7ERouQWDKogy2G3rwpygzG288R4I7_7Q>
    <xmx:LKCgZ2a-U-9DyMwx03q56FLZNPfrxJ0VruxeE07i1mYqojTLJT4W-A>
    <xmx:LKCgZ8BRpp5xKu-uFLW5kYOhWofzM84b8h-hn_plNmulhnx3C3zSww>
    <xmx:LKCgZ-6UGXQqN8lFXJry4VN8p24F0IRu5TMgmrqLdHFCgQXupc2ImbLA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6AE2F2220072; Mon,  3 Feb 2025 05:53:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 11:53:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@linaro.org>,
 "Sumit Garg" <sumit.garg@linaro.org>
Cc: op-tee@lists.trustedfirmware.org,
 "Jerome Forissier" <jerome.forissier@linaro.org>, dannenberg@ti.com,
 javier@javigon.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <65aedfdf-0a13-445d-956c-6945f1b49681@app.fastmail.com>
In-Reply-To: 
 <CAHUa44FXzL-MZ5y7x6qrsn3GJR=1oR8bbRVCv6ZTvDRoQmENEg@mail.gmail.com>
References: <20250203080030.384929-1-sumit.garg@linaro.org>
 <CAHUa44FXzL-MZ5y7x6qrsn3GJR=1oR8bbRVCv6ZTvDRoQmENEg@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025, at 10:31, Jens Wiklander wrote:
> On Mon, Feb 3, 2025 at 9:00=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:

> Why not mutex_lock()? If we fail to acquire the mutex here, we will
> quite likely free the req list item below at the end of this function
> while it remains in the list.

Right, I had mentioned mutex_lock_killable in an earlier reply,
as I didn't know exactly where it hang. If we know that the
wait_event_interruptible() was causing the hang, then the
normal mutex_lock should be fine.

     Arnd

