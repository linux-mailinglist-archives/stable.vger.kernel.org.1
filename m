Return-Path: <stable+bounces-230684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI1uGyWwxmmiNgUAu9opvQ
	(envelope-from <stable+bounces-230684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:28:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737CF3476DE
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A107D306A237
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190F349AFF;
	Fri, 27 Mar 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV5jcNu7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4026344DBE;
	Fri, 27 Mar 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628208; cv=none; b=htwc2j43HfM/mWjTZtkLjIiEPKdrXqwS+WzVreAevCLbDWuSCWR211XWMo8BKW0aZVmQdEJSE1XR0wV+e0uKPlsgh1+OqniO4F9hXIvbLdcj97YJKnm7zyYaIdp5K3EX7btwvAE0J5Yso9ZS3Y1PV91GFf9BhIZbvNr5wCdf6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628208; c=relaxed/simple;
	bh=p2wleutj7gYEYfqp8wsNQmb3yrUSIIBHZbHzlnxTN5A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=O8wjGoSE6PZ75mI4SbpsCiehmCVS9/bkPylwcRI4f1gfOLSWeiDB2q6wvsIW2qDEj3pkNVoY2AK/JhsDh9DBwvhjEEW8So+vEg9vEojAd7Aiip7SBkG+4b9syeAgSdpotD455xp2FPXM9AHrGYY+dFn2uiEfcsPE1cve4hX0YFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV5jcNu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C68C19423;
	Fri, 27 Mar 2026 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774628208;
	bh=p2wleutj7gYEYfqp8wsNQmb3yrUSIIBHZbHzlnxTN5A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oV5jcNu7B3nZNgmXLr3Vc7aVLmTnX8EUEnEy1cIyNM6XhHUi8fRRdNVdBPFEXXODl
	 CtU0DLSdwLJ6JPGhQHZ3rjI82dQDnUJwnS5MbiMGLZOkcYE/des8/sIa/hOq+yozma
	 WSveCldB6ufdCm1BOMwzavc+NYfh/fgGWwBCbHglW4KIIlQfCp4gc8T4N/iGphYVAv
	 JPmDvq5wKSJTgBk0VbEREN3Rzi67eMqNigYVwOzOdpyUiyoa9fTCwRlmn8rECmhyuX
	 RgQHBR4na15gW12P6DEou8Nx7Qnp/jLhi0kFnhO1xcxs3XVBEfn/oCRT6bxuik3/+a
	 4LPXhN5wQjvOg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 265E6F4007D;
	Fri, 27 Mar 2026 12:16:47 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 12:16:47 -0400
X-ME-Sender: <xms:b63GaSRXrszDK3bDzO9S3kKeO1327y6mb_aYjedxXhy5OFBbXs5Tpw>
    <xme:b63GaSlGRDGOMG9SDQW1ZOuIk5P6v_4FY3Hw-y8qmp27bDvlScQpD4QUh6VgY1njz
    JjA0NHPrHzp_CznsRnMIscFgf8RohRK2Wu7oqzqIw6fy0NlJSPvjes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpth
    htohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthihtshho
    sehmihhtrdgvughupdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhgrshhonhesiiigvdgtgedrtghomh
X-ME-Proxy: <xmx:b63GadRIBGDKkWIN2_sNHX1maNujxNbIqePdwMAaQ7QJ90N96bSZQw>
    <xmx:b63GaSx4aZf3P_-qr42msW8cSjti93XvTS15PWyF0qz0I73yy5VIwg>
    <xmx:b63GaVADM63lSwYTvgPmHqzMiJoY--t8BVtDM39WmcpYBx_GpgnTIw>
    <xmx:b63GaWEpJjQCV0LUYL-yn8HsoMqF8W11FU0X2BNUlDZoUBPWAbB0Zw>
    <xmx:b63GaUOZ9keqjeQZKesXMaq5ALXUMKH-Ht6nNkv_4Ue1ooWQPHL5_Th6>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F3E7F700069; Fri, 27 Mar 2026 12:16:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6qQJ9sHejL-
Date: Fri, 27 Mar 2026 17:16:26 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, "Theodore Ts'o" <tytso@mit.edu>,
 stable@vger.kernel.org
Message-Id: <dd050a2d-a7fb-41db-9c03-c5e601c752cc@app.fastmail.com>
In-Reply-To: <20260326032920.39408-1-ebiggers@kernel.org>
References: <20260326032920.39408-1-ebiggers@kernel.org>
Subject: Re: [PATCH] lib/crypto: chacha - Zeroize permuted_state before it leaves scope
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230684-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 737CF3476DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Thu, 26 Mar 2026, at 04:29, Eric Biggers wrote:
> Since the ChaCha permutation is invertible, the local variable
> 'permuted_state' is sufficient to compute the original 'state', and thus
> the key, even after the permutation has been done.
>
> While the kernel is quite inconsistent about zeroizing secrets on the
> stack (and some prominent userspace crypto libraries don't bother at all
> since it's not guaranteed to work anyway), the kernel does try to do it
> as a best practice, especially in cases involving the RNG.
>
> Thus, explicitly zeroize 'permuted_state' before it goes out of scope.
>
> Fixes: c08d0e647305 ("crypto: chacha20 - Add a generic ChaCha20 stream 
> cipher implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> This patch is targeting libcrypto-fixes
>
>  lib/crypto/chacha-block-generic.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

