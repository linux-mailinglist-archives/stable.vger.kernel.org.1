Return-Path: <stable+bounces-223665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIgnNH/TrmlhJAIAu9opvQ
	(envelope-from <stable+bounces-223665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:04:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B623A3EA
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34318307F2B8
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348F3CF691;
	Mon,  9 Mar 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="keMzQ0tB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6Nj2OZUz"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CCA3C2791
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065017; cv=none; b=XPzg0WV3r3t7N+gpzbiK8cdXKnJUdyXYIOorVg7SZYbxWCF1Fxv/U+AtxmIsnXfZ2VoGBtqhUg7gdNNGpVV9kqc/t3QZQemLlsNUvTsaIVlCny2WUK5/540TADAiaQMFNXTtJivSs7nlOTlmrXeyaNXykCayJnuU4vbY+dj2j28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065017; c=relaxed/simple;
	bh=PjIx7F6IiYCZT0mt02vo8IQ10v4c2Rmm/+/e1Q66M0U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HUmg2CTQ0mXwCv2F4vJtT/t0CGwVZy/YvyjsrsiZqvLjLtUGn8Tjuo9AF0G9AoxTUXXoe++ariB41x91DRMUzNSNBO/Zh37rx4pg1DIwrJq8KcoogJXuE5SW1UMPLO8rB3Xv0/2eY7nLB3yPU5Paw+LBO8yy9foqNan1RVSIRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=keMzQ0tB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6Nj2OZUz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F3307A0095;
	Mon,  9 Mar 2026 10:03:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 09 Mar 2026 10:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1773065014; x=1773151414; bh=Jes1SutFgV
	Xjvcl9puNhc+lr/V+O/JXTZaIn92q899I=; b=keMzQ0tBDdAwvHnktyp2U0/Mpx
	IFoqpLCBP+QwAZ2o3LmsfYVVLCDwjQ+cfsO7bs2s/Vq+DL4VW8HHwtRn5YDsDpba
	DPT4Vao60wAQaVetuPRDhd5kIQy+SU+6agid/Bu510EE5MVfhgUEPcVGr7oL0EOZ
	4SNhg0huAs2L1J8zZXgEKkZ3+k0KcKoJgLBAdaynwFB1XCAs4w+jOYBCR+rq5v63
	pyRJLuPi6/CDJnH4NY43FMOu7lXoHwL90WEJHb+/2U3mWzMmc1GXQPhn7uacCK7H
	kD6+XemSxPTHk3ZkFpo+gk1zLMyNwzLfNp9IFTTyIz8hZs5KRj0/xgKqLhuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773065014; x=1773151414; bh=Jes1SutFgVXjvcl9puNhc+lr/V+O/JXTZaI
	n92q899I=; b=6Nj2OZUzeDdzXE8Qpk069C1Tmcubvu0X1mktZe8qeqe8ZfVbaDu
	4UHWXT+nXCA86ZWVFx6lWXDjw/3NgneyYQVMCQzu2eKar3P8UdmI6WXQtdJbZSH1
	kUnGO4N2ThHQIVGqxE6lmzLuS2O6HIHwRRJH4tHS/qMRo061RE9njLTUbbQ8kO0/
	OusXyR6b/h1YyMiUKAOPXswN6jU55BgWfTEEZTBlvEyvCRJWTZQEv3qtKu8sTEp4
	dQVAaUHXF5PaXvpOgDQ0QvU6eYJFHorqr2X1+/utN+7ropP8Kc908jJif2twidif
	yGPRkYrwoCacG9u2pOnLohJsqkaSia8ueBQ==
X-ME-Sender: <xms:NtOuacBcRVymT4FOLxi_ZK6zzvhEipp9mVDO6S5U6qx9oQu0kmgpJQ>
    <xme:NtOuaVi-C_9OZfW1i1qpwkV0_-GW9x6qP7Vgmq8942GNHroV-iDno6BYKIG8cjf8_
    2dOiv-thSttGtl2dM_ggg071UAhM8jqC3fpoJ3qujbVYpSaC-31FaM>
X-ME-Received: <xmr:NtOuaUkpDVzamTeEd9oGPmhEFqNAMSN7ci2Bc2wr4URea1WCuFX4ZnyxE55mkPuDKeG2TVru_2zmEUQ5b_ns8NjLMLoR2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfvffhufgtgfesthejredttddvjeenucfhrhhomhepfdeurghrrhihucfm
    rdcupfgrthhhrghnfdcuoegsrghrrhihnhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephedvhedvgeffheetteegveegfeekjedtvedtkedtledvvdejleduueehfeff
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    grrhhrhihnsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdp
    rhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhdrkh
    hlvghinhgvqdhkohgvnhhighesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:NtOuaRo4Hjt98MZGC9WfeEzg-XAX8zgz6IcwQtpGVqTrXZhtdOxJHw>
    <xmx:NtOuadF0fkPlfhRqNxaPfVJPccZoJQXJrB0wl3AqWI-45bl8ycZUAQ>
    <xmx:NtOuadzQDZdlJ90Nmr8Q5OjZbsNx8U-Fycbg89b9Cq9btIvzxs4m2A>
    <xmx:NtOuaSqpQpVrsjuhODT0zJ3fwcf9sShtSUI9V1PYFPDQZ1Rgw3PKiA>
    <xmx:NtOuaR7XA3PrK3S-M4A2vSgYdc3dNVK7YyJ8AewF95o5sYO1JUhRAjzT>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 10:03:34 -0400 (EDT)
Message-ID: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
Date: Mon, 9 Mar 2026 07:03:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
From: "Barry K. Nathan" <barryn@pobox.com>
Subject: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3A5B623A3EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-223665-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Action: no action

To be very clear, I want to emphasize up front that this is regarding
the *current 5.10.y queue*, and not any 5.10.y release. This does not
affect any currently released 5.10.y kernel.

When I apply the current 5.10.y queue on top of 5.10.252, the result
is a kernel that consistently freezes on shutdown, both when running
directly on my Lenovo ThinkPad T14 Gen 1 (Debian 12 bookworm running on
an Intel Core i5-10310U) and when running in a virt-manager VM (I didn't
put much thought into it and just happened to pick a Debian 13 trixie VM
for my testing).

(Just once in my testing, there was a visible kernel panic, but there
was also screen corruption, and it looks to me like it might've frozen
up partway through the panic being printed on the screen, so I'm not
sure how useful it would be. I did take a photo so I guess I could
post it up somewhere if it might be useful, or maybe I'll try to type
it in from the photo later today or tomorrow.)

I bisected manually, and it turned out to be this patch:
"driver core: platform: use bus_type functions"
(driver-core-platform-use-bus_type-functions.patch)

If I apply all of the patches in queue-5.10/series up to but not
including that patch, the resulting kernel shuts down fine. Once I add
that patch, the kernel freezes at shutdown.

Please let me know if there's anything else I should try, or any other
info I should try to provide. (The problem does not occur on any of
the recent stable releases, nor does it happen on 7.0-rc3.)

-- 
-Barry K. Nathan  <barryn@pobox.com>


