Return-Path: <stable+bounces-217993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePo9GD4enml+TgQAu9opvQ
	(envelope-from <stable+bounces-217993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:55:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC12A18CF5A
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECD730626E1
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF4F34106A;
	Tue, 24 Feb 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="NkIHMyES"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357633EB09;
	Tue, 24 Feb 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970106; cv=none; b=D0tB33Jx0J3+S1REP9eBQSx+ZRwqtZEMd6LTkZUekvkvUBeQ70MmeEWshej4pwjQGcAIi+34hVRIh28sL/+2xE+JpAX2+Ta752v8gX0ZRtv5GaRRyNENORPsTdbHxrOzdRnazbD8IyKtJ+UymPXALeoVLqnZ5OulEGGfcb82FMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970106; c=relaxed/simple;
	bh=afA7V50ksPYNPfqs09jb5oocLAPlmh1XWGQtRoOGqeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayhRqEW8NV3IQhimFRP74rXIkhk9Tzebnc9MbNuXs0Qa/rxnrfvE2Ono+pI6YJSYELmo4YsKdaNS1kx0KV+U183j/KLsK5TJXUpS+Su28beCMZz5NzDkoWtduxyN5IoVJk1h2Papo/gpJxn8ggQEAgISngYJ4bwsVPhxIW3mOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=NkIHMyES; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771970084; x=1772574884; i=deller@gmx.de;
	bh=afA7V50ksPYNPfqs09jb5oocLAPlmh1XWGQtRoOGqeE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NkIHMyESc/mOMb5dZtM9GtkdO39JeuMEOlSZwEX+dabVXEgmABB3sBvsPhuFV3mG
	 kUhOb0me/G0uyrPIx9+4GqQrNmF/Wc+KRaweDggoQ47kwWbiTqMYV59asJM1gKbeS
	 bkjwp63JbDe4XZMWUKnDzkikdpH/WuL58y4d7bB2tXh8o73NJMUgU+V+6cZTny1Gj
	 TlQrNA18Z3hVNqn2a3EOvi+9THa3/46MmCdEgKO9vp03X8MM/fkPOgtaP63GIHzGo
	 EbpXfmYGrE+n+4YVAnjIGnGsHysBZpDg27WX8OcMDJm8KmD5Shvpc4o4RwOsXrWZx
	 xCUSLrQ+RFEhHdXdJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY6Cb-1wE3Ld2xNF-00KBcU; Tue, 24
 Feb 2026 22:54:44 +0100
Message-ID: <02b68611-5bd4-4349-b6cb-33993d3fbbea@gmx.de>
Date: Tue, 24 Feb 2026 22:54:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "printk, vt, fbcon: Remove console_conditional_schedule()"
 has been added to the 6.12-stable tree
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260221163924.4117536-1-sashal@kernel.org>
 <40d3252f-22c1-4a24-83ae-68de825807d4@gmx.de>
 <20260223065448.xshEaalA@linutronix.de>
 <ba3c30bd-5fe3-4774-b7ad-5c8335893fa7@gmx.de>
 <20260224165601.2GtTLfmh@linutronix.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260224165601.2GtTLfmh@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kw5nPS7wYIH0XlgG9ZWXMkvdGURNU4l7aUSvY5ykNfyh14ycyYy
 2BbpI1/YyXlV6fbO8ISeJY1StYyIGFkPsY8QE8+IiWsdM/1hbVfzu8WPO0gObQ9VFY9eY4K
 fnVmXkLGFDPwERoXQLeAxXXZADupXqSFgfX0R1/WAT/lr4QcvXs18srOmrw2/Nn6fI5vp8s
 lQKTizN6w8CHoTvLWK2qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qNOwzfUf77s=;WfbM8tkV31EQ2WawzJqLW7OnvD2
 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
 anHKSsZZRvjVuNorq6zxyyI9BLhNZ
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217993-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: BC12A18CF5A
X-Rspamd-Action: no action

On 2/24/26 17:56, Sebastian Andrzej Siewior wrote:
> On 2026-02-23 10:01:23 [+0100], Helge Deller wrote:
>> Hello Sebastian,
> Hi Helge,
>=20
>> Just to be sure: I assume you want this patch backported:
>> 8e9bf8b9e8c0 ("printk, vt, fbcon: Remove console_conditional_schedule()=
")
>> Not the other ones starting with "fbcon". Right?
>> So, we talk about one patch only.
>=20
> Correct, only this one.
>=20
>>> One idea would be to make the removed functions a NOP in the PREEMPT_R=
T
>>> case if you prefer not to backport it at all.
>> I'm not generally against backporting the patch above.
>> I'm only hesitant, because can we really be sure it will not produce
>> any lockups in the older kernel either?
>=20
> Not without trying. There is this scheduling point since v4.5-rc1 and
> this should go to v6.12+ and based on this I don't see any problem with
> it. Older kernel will be v6.12, v6.18 and v6.19.
>=20
>> If you think it's safe, I too prefer to backport it as is.
>=20
> Okay. Then a backport as is it is :)

Ok, fine with me.
Sasha, can you please re-add (in case you dropped it already): ?
8e9bf8b9e8c0 ("printk, vt, fbcon: Remove console_conditional_schedule()")

Thanks,
Helge

