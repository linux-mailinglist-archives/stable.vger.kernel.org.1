Return-Path: <stable+bounces-112118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658AA26CCA
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 08:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E69C3A9157
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031512063D9;
	Tue,  4 Feb 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qjeMwYFj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TB1PaAug"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97F17C219;
	Tue,  4 Feb 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655128; cv=none; b=EHJ//Q3nlhEKLRP2wxWk0UFy43EshINKkKFCln5DOsDpQsy2yWnyDtXWPXZU0/e+iert+ax/EBkDHnDViGRnShc3oEeM3mm7SlgRZtEs3zrocYk+A7LWpDO1cRheoWEFsASdQg2eqQ6mkRH+wQ2OdZB9iO1AMrbQe5/uQ4ygeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655128; c=relaxed/simple;
	bh=NLp4Ef02iMFlE79EnOuq1UtXSinzztT8NHbPh4O2uPQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o5EI3v4sIuLzh+3NNq6idpuPQLBdJF7tBgJD320hlSGkPRkbvjwO7y4AezlsWAZtPaP6r/yNP+GftzZEDRMjF9zpW9yDEbZBnwr9xVMpqcaKh/+MnksGjVVArXamJQl9RyAyqTkKFE/Y+vpRkobUF2ocoRhGAuGRkRQBjf1a6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qjeMwYFj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TB1PaAug; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A61E25401CD;
	Tue,  4 Feb 2025 02:45:24 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 04 Feb 2025 02:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738655123;
	 x=1738741523; bh=NwCcxkyDiW3Ar/Dx3fLdady2zCZ+TYYCBD5Xv5YmYf8=; b=
	qjeMwYFj3CitIzTqTcF+Uwu0ab01uWc0SRknWyAaZoOd2t9U+IiWoKMh/tEqJVkG
	fm7BjujchEbq2Y4fNMsblgbH5aTrTm0PXu5kfucRXceP9u4ylxwOvKdecxAWtN8h
	1CwLG1Zpg4Kgser01dScJMjVNCQPd6AKASF4TVobl29FQTartup8cCTMwPtjFNtT
	XqEVq4bUguH05KPUU0RanGoC1yNBKwUSR/9dopnCkORLsC7nOIxugu0AwkGFe4Wy
	D87yTmihrpxLsk+qBTvWRo4aBhJ2tJh2zo5K6VwoxRpqGsjIhDgG8QF7qLbmAe86
	t7PNzXKLrVtGD8Hr0PUccg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738655123; x=
	1738741523; bh=NwCcxkyDiW3Ar/Dx3fLdady2zCZ+TYYCBD5Xv5YmYf8=; b=T
	B1PaAugzl9SjAVpJoUQvkp7Qzc6hXb0lYn0rEJGhaJ156iylTYPmICMCbmvsdELC
	Uvss/Y23LTnOPq7PTlfnKsnwgJqcWsQLTGaeuouheyc10H8kjiFKIBuhSS8/Wygh
	eXUVmkUulaOeCLt6JSwz9koVQpVdobBupGO5DBCsROLi7tY0DamKMBcGbKLBQq/M
	EKkpmEW+WzhfEl0JKJv2iN92eQfcXdvrsygK52IsFLezoECrBeZpNeWUqxmee/Aj
	Vm+JgJO+r76SN73zvdLR8R2cGBpf4psnQM60SYAFRJBoveS8bgMaYJ2YOAwGYFK6
	YODuuJ0cGkv/pNHJXjIEA==
X-ME-Sender: <xms:k8WhZ7i36GXyYZ1mmDD1AfVyRAVbxpqjdpdH7p7-WpQxk7FLUWDcEw>
    <xme:k8WhZ4Clu66vfHBQAOl9SW7nHUkLzHbfUqRd194CzIZpkez6YCmfhwGi65viAsLM8
    vEJYENpWao9T9QurcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:k8WhZ7HP9oUVrVq6fLZjsn_CKB3ysYc61EJ-E8eBdOBLIR7jtiyC1g>
    <xmx:k8WhZ4TgvgIVnT457thMAAUEC25Y5Xj2WIixzlLvpi_KKbfVcXWPzQ>
    <xmx:k8WhZ4z071ZTM0asUGSF7xx0BWHfc2_jEjkuPQTJPj2ccu1eTCaz4Q>
    <xmx:k8WhZ-6D1_Mbp7jvoLaBbmXy0FMJHngmtu70iqoQK2feeFNopZ5rZw>
    <xmx:k8WhZ7yPWcVN4TTa_TRYYQiaC9QJEPuIdq4zRJC5QkJn0vtD41syyDDX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 650652220072; Tue,  4 Feb 2025 02:45:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Feb 2025 08:45:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sumit Garg" <sumit.garg@linaro.org>,
 "Jens Wiklander" <jens.wiklander@linaro.org>
Cc: op-tee@lists.trustedfirmware.org,
 "Jerome Forissier" <jerome.forissier@linaro.org>, dannenberg@ti.com,
 javier@javigon.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <60cd3fcc-5d21-4b98-9a81-f5fbec2099fc@app.fastmail.com>
In-Reply-To: <20250204073418.491016-1-sumit.garg@linaro.org>
References: <20250204073418.491016-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v3] tee: optee: Fix supplicant wait loop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 4, 2025, at 08:34, Sumit Garg wrote:
> OP-TEE supplicant is a user-space daemon and it's possible for it
> be hung or crashed or killed in the middle of processing an OP-TEE
> RPC call. It becomes more complicated when there is incorrect shutdown
> ordering of the supplicant process vs the OP-TEE client application which
> can eventually lead to system hang-up waiting for the closure of the
> client application.
>
> Allow the client process waiting in kernel for supplicant response to
> be killed rather than indefinitely waiting in an unkillable state. Also,
> a normal uninterruptible wait should not have resulted in the hung-task
> watchdog getting triggered, but the endless loop would.
>
> This fixes issues observed during system reboot/shutdown when supplicant
> got hung for some reason or gets crashed/killed which lead to client
> getting hung in an unkillable state. It in turn lead to system being in
> hung up state requiring hard power off/on to recover.
>
> Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Jens, I assume you'll pick it up and send me a pull request, but
I can also pick it up directly if you have nothing else.

     Arnd

