Return-Path: <stable+bounces-255074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH12KGiAGGpPkggAu9opvQ
	(envelope-from <stable+bounces-255074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:50:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE115F5E6D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91AD53026220
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEBE3FCB2A;
	Thu, 28 May 2026 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VMjSVWPL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnYHJ+HE"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDF352034;
	Thu, 28 May 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990282; cv=none; b=apsArKsMXYViuWmcyAAytCUdleexARB0rdrb6fSZua9E3jtFJl35TrrpWOW1l7vhcKo3mQLhg3GHGoAyviKAD0Jkq5xiKOam/af8GN8bXquPJ+0jCCy1sOFQWvexTG3NFsUfLCK8XD/yO58AZ6OSWUOawfdiT+whjcycRQ3W9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990282; c=relaxed/simple;
	bh=veJ7mwLr0PMh7m/C13btr+rFqXEZ8+dyazWfcFoueC0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BzYz8xypNR/mKNRhkT7lodhEA0FeNoZuvYhlvac1DIR0cEidXmhC1x6rP1WgsrhDqHzsyABCsDqBJI6XVS906vPbzSHVQwZ8F22Dz3oRstK4tJoQMfXGTBbe98aRrr6WDdyPHGTsVx+hAuthe0ok9hqtWcDqhrAi7jj7sTF+Ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VMjSVWPL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnYHJ+HE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 263D31D000CD;
	Thu, 28 May 2026 13:44:39 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 13:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779990278;
	 x=1780076678; bh=Tv0GvQR9LdZ5J0jYYwa7d5Uyc3AKXGH4YOdKXhneO1E=; b=
	VMjSVWPL8CUZrqTgfYcdXq0OhW1qOrR7LGZ0yymaQR/b6wnZvPfCcaxMs+tTofKH
	+6mktGBcwvopUmyKalcWWWnho7cK2c1CMnIHN62lteDcIwwYy+58KIPg4k+UZjQq
	vXQOcB134YHNp3ARtK/9ruo2UJLtdAXbY8TiaffBqzlfrPBd4QgzaoJ/GnQrkX9t
	2k5M5tYzX5jpkWgyxnfrwFQnfbO1gCvpEzK4RQ8fM+5pKDK6X79On7DIzrmAboHI
	oTGG35a7FcN32YLGYrPGrIzZupJsRSTk4BC1DL7nSdV4NMQXwH+bwcafiUsI/sFU
	H0Oi6y2qavKt2nmOyAWGGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779990278; x=
	1780076678; bh=Tv0GvQR9LdZ5J0jYYwa7d5Uyc3AKXGH4YOdKXhneO1E=; b=O
	nYHJ+HEBGfLSfgR9faVDKYA8WIGs9nU/m/0xvz7zotzmDQXMc1ARN9fAePngamQR
	28vmC1ViYoV2/om90T5XGjig8gFIOOaGzcUwVcq0FuripuVOyuwzzqZoVvEmSZDH
	1JD0cF3zVW8B9DTmE+L0b9N0xbpq8HxzBl2FPVSXFaxyZwIFvz9WMq5WhnXYbZuV
	96/WqJiDKYHWSAdMrL6ulE9q97ZzlBtAqkTQCkkFiY0SHbwhVeEb+SUWdzycPvN8
	8IjvLGQS8BNJE72+mhcj/AQzwTMe+OhZoz5YO94JEgISdLg+8BZuOIGkCM8hn0Ch
	N/k8SG8RlvpIT9a9F5duA==
X-ME-Sender: <xms:BX8YasIjzB6KaaZdxw9LUYG7v3wzUEDo7VuOxxeXOtN0PGtUGW8gJA>
    <xme:BX8Yam9ZcpMLau2S9VvEv6L3k-6SMc3eODzZCRUqM54fuHb6sTFxEzuMtDGgsDgiX
    7MlmNa5Lf4UA0oBWCcYRoiutSMkA028W3Z8nAxGZcT5DVM9cMsMDQ>
X-ME-Proxy-Cause: dmFkZTF15I2exDPtkrKztTne1NwFdgpQPX5RZHaMMfMA6gF6Y5BggLL1zRpelnKTMY3yBh
    R4wK9fwRoM7FrpSRvU2kUe/PJ8DEF0RJTiCet1Z3XZOzfJlAmAGguJwZ3Y4LdKWe5Ra1yt
    9Ank0wim2jQFH2IFOytzTNjNHGkn/Ae5k6iQRP/tXLhPqbG8hKldvfnu/5P4vgFmVlmTMS
    BLtSPVuZTPKbPlWJ9cLE8wplnT3mnotXJHkmv1+aPYsyy7a4tAyjiqHt+HVE0kLYH4AZ6C
    DNvtXHbwrbMim+efkocyZJvr+xOlXiy/azm8os8X9/hZer9SH/YJGVQBkADn5xfDHxnJQp
    wJbURRQfherRUAUXf6wVRJ3WwV9FbzJVFfZ5Oi+cIxTVkeKBQyd6BgZkFuuI28mvWfQryr
    YGa9xvBG7hJYWjUxRyb1ubjL1A/k+dlMbcS/cbIvnM1lVXSInksjQtr+P2X+apzPUbZTr/
    n2+clI183YNFxm9WcrZTH/p+5lDRsmgn36EWEuyvlKsUnO8oOcqECQwPNmWn91gnoW9fUH
    gN+yhtIPSMfvYV7PZ4LqqwYpvMkEG6Z2j/1goh8mHe3vMuvSXNLnnH3PxZ0CxbFQNo0jtF
    W7FUHfNKhUlQ2eAXdkMiECxHvTc0sHzdXmPWgFPVJMudAkKb99TH0ATU5nSg
X-ME-Proxy: <xmx:BX8YaitXoGv-ZZWow7DNa4wJSssqKd9hxZ8Kt0EeZWYeTLNwZAKuEg>
    <xmx:BX8YapD857mxD0bNTG9yFGDr_4EswW0hL6ukkwFYli7cxEZ6gbs6eg>
    <xmx:BX8YatB_-o-aj2Jt4p9laqnWNyjpMJp6UrdisKEHTWBjeBEQA0BK9w>
    <xmx:BX8YajodPLvCsEJrEAzYFDDZFCVvcDzzBYbLXdmE3dA6naFcSj7mIA>
    <xmx:Bn8YasNTWmvzM6wFwlhtzIQhrUiK3Ip3ud0OXdwgZBvctZSd8x0XW6Jb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98AE6182007A; Thu, 28 May 2026 13:44:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR8ZB97ino5k
Date: Thu, 28 May 2026 19:44:17 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Peter Griffin" <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
Message-Id: <a1629d9d-0357-42a3-aef8-c8d1cfa5ad39@app.fastmail.com>
In-Reply-To: 
 <20260505-acpm-fixes-sashiko-reports-v5-4-43b5ee7f1674@linaro.org>
References: 
 <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
 <20260505-acpm-fixes-sashiko-reports-v5-4-43b5ee7f1674@linaro.org>
Subject: Re: [PATCH v5 4/7] firmware: samsung: acpm: Add memory barrier before
 advancing RX pointer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255074-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:dkim]
X-Rspamd-Queue-Id: 1FE115F5E6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 5, 2026, at 15:13, Tudor Ambarus wrote:
> Sashiko identified a silent data corruption in [1].
>
> In acpm_get_rx(), the driver reads the response payload from SRAM using
> __ioread32_copy() and subsequently updates the hardware RX rear pointer
> via writel().
>
> On weakly ordered architectures like ARM64, writel() provides a write
> memory barrier (wmb()), which strictly orders prior writes against
> subsequent writes. However, it does not order prior reads against
> subsequent writes. Consequently, the CPU is permitted to reorder the
> writel() store to become globally visible before the payload reads
> have completed.

I am very confused by this after seeing it in the Exynos fixes pull
request. How would anything get reordered here? What I see is that

- The SRAM is device memory, so any access to it is architecturally
  ordered against other accesses to the same device. Even on
  architectures that don't guarantee this, Linux I/O accessors
  do.

- The __ioread32_copy() writes data from MMIO into main memory,
  and the store into main memory is guaranteed to be both before
  the final writel() (because of the implied __iowmb()) and
  after the read (because of the data dependency).

- The smp_store_release() in addition orders the write into
  rx_data->completed after the previous memory asccesses and
  before the writel().

> If this reordering occurs, the firmware may observe the updated rear
> pointer, assume the queue slot is available, and overwrite the SRAM
> payload while the kernel is still actively reading from it, leading
> to silent data corruption.

It is possible that I'm still missing the point here, but it
very much sounds like you trusted a chatbot over trying to
understand what is actually going on. Can you explain a
sceneario where the barrier actually makes a difference,
and what the corresponding barrier operation on the other
side is?

     Arnd

