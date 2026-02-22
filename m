Return-Path: <stable+bounces-217679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jq9LGqtim2nrywMAu9opvQ
	(envelope-from <stable+bounces-217679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 21:10:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9B170457
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 21:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20D8300BDA1
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 20:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02335B639;
	Sun, 22 Feb 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HtyXJS95"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EB352C29
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771791014; cv=none; b=GdBw6ih23MSL1MfXD7i8lxK3fhKXi0u09wLCmDqskRsrp/iknkY34OGcF4xtyB6OxIQfd3s2Au/u6YPpQz/vNdvjoSub2kPmfijFzt825psh4W/6+Mpn1ALG2fVYbiUiAX9IAuVrmxAVTawr9oL5Fc9yuPvPTYvfPSXgOe9BPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771791014; c=relaxed/simple;
	bh=iqifWwyjTFXTIyqM0oQ0Up5yDaCs0JAGxow5W/xD4fk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AIDAw2/flx6CtAcSEnRzf9xKkC89pBVb+/69gCungbM86G82vvhYtdt1N84TMduelYFcgOjejCJVAQ2Kf9i2C4RougMNANwS+OeyOeltSSvCFMKc0gfoam/IPOKGlijU2dphofzZAFH8HEbvAX95dHaeXhNG477y4a8lzBJkWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HtyXJS95; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771791008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5/Rd3t51ulL2jFj2PIuw2mldaS4mUMnXa7fZq+qDTU=;
	b=HtyXJS95iLIvZpEwYhy/cJ1s9QItwZQidbLXFje43L+iVIb4y2QpgRgk2PYH2FfHgcJssh
	gFGIrdelKpdbIGrFTeLDI69DiQDB9SB06p82SI16SpsbMVbl+sGPFcJTHY/FeCbbSsQF+j
	zopLHP9sOV+4xYL4aWXQDIYKdxXHiRc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix error codes in OTP reads
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAFXKEHZ9TTZMdzKr8_5UesUdajGoQNm_u_paakggtGONbzjPcQ@mail.gmail.com>
Date: Sun, 22 Feb 2026 21:10:02 +0100
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 stable@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B6971FE-BE8B-47F7-9FB3-E32D554FC19A@linux.dev>
References: <20260215205152.518472-3-thorsten.blum@linux.dev>
 <CAFXKEHZ9TTZMdzKr8_5UesUdajGoQNm_u_paakggtGONbzjPcQ@mail.gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217679-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0A9B170457
X-Rspamd-Action: no action

On 22. Feb 2026, at 18:03, Lothar Rubusch wrote:
> On Sun, Feb 15, 2026 at 9:52=E2=80=AFPM Thorsten Blum wrote:
>> Return -EINVAL from atmel_i2c_init_read_otp_cmd() on invalid =
addresses
>> instead of -1. Since the OTP zone is accessed in 4-byte blocks, valid
>> addresses range from 0 to OTP_ZONE_SIZE / 4 - 1. Fix the bounds check
>> accordingly.
>>=20
>> In atmel_sha204a_otp_read(), propagate the actual error code from
>> atmel_i2c_init_read_otp_cmd() instead of -1. Also, return -EIO =
instead
>> of -EINVAL when the device is not ready.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp =
zone")
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> [...]
>>=20
>> @@ -106,7 +107,7 @@ static int atmel_sha204a_otp_read(struct =
i2c_client *client, u16 addr, u8 *otp)
>>=20
>>    if (cmd.data[0] =3D=3D 0xff) {
>>            dev_err(&client->dev, "failed, device not ready\n");
>> -               return -EINVAL;
>> +               return -EIO;
> The cmd.data holding 0xff here is not a bus error. AFAIR it can have
> to do with the locking state, pre-initialization,
> typically the atmel watchdog kicked in / timeout, etc - so the
> response is invalid, although hardware connection (I2C) is
> supposed to work. Currently the caller of this function does not
> distinguish anyway.
>=20
> But why is EIO preferable here, over EINVAL?

AFAIK, -EINVAL is used for invalid arguments or bad input passed by the
caller, which is why the address range check returns -EINVAL.

-EIO signals an I/O error or communication failure, e.g., the caller
passed a valid address, but the device isn't ready yet, for whatever
reason. Maybe -EAGAIN or -EBUSY instead? -EIO seemed like the most
reasonable choice to me.

Since the error code will be propagated by my other patch [1], now would
probably be a good time to adjust it.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/lkml/20260216074552.656814-1-thorsten.blum@linux.d=
ev/


