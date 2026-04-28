Return-Path: <stable+bounces-241538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHW1Dl6M8GkuUwEAu9opvQ
	(envelope-from <stable+bounces-241538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:30:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899B482A7D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 353FC302B055
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9B3E559C;
	Tue, 28 Apr 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVemluUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CFF3E557D;
	Tue, 28 Apr 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371504; cv=none; b=idcVr9iO++50EmvfgscZJlVzdMwKTxfNJ8zUUowZQ2BPsP8bcitykrEWPgrmry47nSWIeHoVc3fBSZbQfvdZcKBpmHVDkX5HbkL5h3IgEfIWe0mN8LV95SX1/CIIhKKzBru+IkuQ0ph/We9quQFcymKew+mJPEg4KJQfAwOXj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371504; c=relaxed/simple;
	bh=/IixdDMiEf6l+3+Y/vERm1hC/tsP5pn8ut57x2lup+4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=B8yE8FZv0ysvXf9aIw960pqfBNmOIbNuxR7ccAvXflV694SanUIEim1zjkwXiX6WXdAORS01C/4atLLLKzgxJwsEryLj+TawTdCOGPtkPmiR3Ku0s3YcJysdD1jlxO3roo8BeoUUgj43uza0GZoGkGaeoNfh0+io/L+W5d1tyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVemluUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB14FC2BCAF;
	Tue, 28 Apr 2026 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777371503;
	bh=/IixdDMiEf6l+3+Y/vERm1hC/tsP5pn8ut57x2lup+4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qVemluUYRSbRbB+jeTHcLHXfVd0fWVePHTR7D6EO1tbYHqRMbxroM8029raU8KGsg
	 ypnd63LwnL7BEHTr0KFMNBBDSvKmkEflTA9ksd1Cx8g00b6UDvliI6mlVZeeUtLF4g
	 N2OrJ+eqSpcovEpMPhItU/qR3Qovi4ASRSSVCt+dJjF+p2D3aXHlfIfMteRqJNQANW
	 WU4n2exmEJEOc5pEb+OAZ1XZ32f8bESrWvTxs2Iyr1gXul7qQ098SYy5ydU8f5GVJ4
	 d0IiiK1p8k1f05JhyTIfCtBXRGS+lQW5qOMORNbLgZFTNH41p+WMC0qe2ZJhmSYiiL
	 KBXWsWpglW6lg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BAC7DF40082;
	Tue, 28 Apr 2026 06:18:21 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 28 Apr 2026 06:18:21 -0400
X-ME-Sender: <xms:bYnwaXcJmsECddzwi7UwtfuDBg3_l8GEaJLjfVVJGgqAfuR9oNMMmg>
    <xme:bYnwaYDFWZp0KZNoAkk-CJM6FtmXLX0CdG0SSqmglVA3Tsc5pKHgIR5cG3unv15In
    YhqBFZgSmZWTLLPx96cSG3Z1a0mBWe35Bgu_zhn8NOzdGYMxjmciX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepkeevteduteehkeekteeugfdvvdekudevffejvddtueehuedvueegudfhtdet
    hfdunecuffhomhgrihhnpehmvghtiiguohifugdrtghomhdpmhhitghrohgthhhiphdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    rhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeelqd
    effedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgu
    rdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhgvrh
    gsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehkrggs
    vghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsfieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepthhhohhrshhtvghnrdgslhhumheslhhinhhugidruggvvhdp
    rhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrg
    guvggrugdrohhrghdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhho
    tghhihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigoh
    hnrdguvghv
X-ME-Proxy: <xmx:bYnwaUt31HIys7vPt9YU4LopGzBpnow_vORtPpBl32hzavV72d-Eiw>
    <xmx:bYnwaVIgjmgTPj7A1M09K_1WyhLnOMj9DqdC0Bm4Z0Yvqjfa267QsA>
    <xmx:bYnwaYa8nOTdbjaUgkJsRTCvKQKohu3p5EkpzZMSN_oUaFOIOPnv0g>
    <xmx:bYnwaYnwJFhxqjJ8Zy0G2oztVSCZXq9Vwh37Zuu475ECLPQAWlBtJg>
    <xmx:bYnwaWUIjGOUqoXxHFUT8s_8kAXaZaLHvFZ-BoMMcX7jY6CRwmWuZEQp>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 99D7A700065; Tue, 28 Apr 2026 06:18:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2026 12:18:01 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 "Linus Walleij" <linusw@kernel.org>
Cc: stable@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <e1157e91-9a08-43c7-834d-cc6f3799b16a@app.fastmail.com>
In-Reply-To: <20260428101430.514838-3-thorsten.blum@linux.dev>
References: <20260428101430.514838-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH v2] crypto: atmel-sha204a - drop hwrng quality reduction for
 ATSHA204A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4899B482A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241538-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,metzdowd.com:url,microchip.com:url,linux.dev:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Tue, 28 Apr 2026, at 12:14, Thorsten Blum wrote:
> Commit 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to
> lowest possible") reduced the hwrng quality to 1 based on a review by
> Bill Cox [1]. However, despite its title, the review only tested the
> ATSHA204, not the ATSHA204A.
>
> In the same thread, Atmel engineer Landon Cox wrote "this behavior has
> been eliminated entirely"[2] in the ATSHA204A and "this problem does not
> affect the ATECC108 or the ATECC108A (or the ATSHA204A)"[3].
>
> According to the official ATSHA204A datasheet [4], the device contains a
> high-quality hardware RNG that combines its output with an internal seed
> value stored in EEPROM or SRAM to generate random numbers. The device
> also implements all security functions using SHA-256, and the driver
> uses the chip's Random command in seed-update mode.
>
> Keep 'quality = 1' for ATSHA204, but drop the explicit hwrng quality
> reduction for ATSHA204A and fall back to the hwrng core default.
>
> [1] 
> https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
> [2] 
> https://www.metzdowd.com/pipermail/cryptography/2014-December/023852.html
> [3] 
> https://www.metzdowd.com/pipermail/cryptography/2014-December/023886.html
> [4] 
> https://ww1.microchip.com/downloads/en/DeviceDoc/ATSHA204A-Data-Sheet-40002025A.pdf
>
> Fixes: 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to 
> lowest possible")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

