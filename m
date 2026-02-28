Return-Path: <stable+bounces-220059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGW+BmC8omkS5QQAu9opvQ
	(envelope-from <stable+bounces-220059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 10:58:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6691C1D68
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 090C63031309
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A29396D3D;
	Sat, 28 Feb 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mvZ04meN"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE0361665
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772272718; cv=none; b=fsqF5IuBZE/TZfuX2Yo855iInMIFlHeTAVIoBHyDd0f70QpaU62Rv07TPM1xOhjaLLKaTPzh1w4vAFPN93HJ3wn59hF5/DOV3T5syXY+h3FJeaoA8CaB4ZhnMKCV5uMSKQ543HAT5GHENA3cyfUS0BHY/riR1BPhqUbos7eKx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772272718; c=relaxed/simple;
	bh=A2jVfZe3xMr7+UYdFllfKxH9v1wa03LIgfyKGzTURUA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QdlZtDGdq0gaUPYvhlmXSE+jUkB/LohMDqdfAiHh3OByxSVZwPQFkfOphBhk13c2d4uebBtNRcJCrA5Zq3nuW00WZPl+4APqbAqpVPbdhCIMLUnzlXG5DVlsgKOdoBbwJRzw8r9+USTsM7lhbrQL5OGx9cXZwMr5elfiX5Ul7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mvZ04meN; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772272705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+ZD0E/Be2DkeoGJSTMXxYgl8VB2e+o0QP4h5bIji8A=;
	b=mvZ04meN/UBkJwE1Q9w6856JK0QYUvTooBgrFSSmSVjY0Rab63Nj0smQneIHTi/m+ZsX/G
	tLoFBvisCyMxVuHOwRMM2VgdYXnaaNsmyo6/25xo2T/0KQrhC6peeRGa1NUKKdIXYv4ahC
	L9Jbs8p78GYmX43/p6kMxoqBMC2JKfs=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix error codes in OTP reads
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aaKr1E1mPOgxo0JL@gondor.apana.org.au>
Date: Sat, 28 Feb 2026 10:57:51 +0100
Cc: "David S. Miller" <davem@davemloft.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 stable@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <21D21541-8B24-47CA-9BFE-CC3B287CCB3A@linux.dev>
References: <20260215205152.518472-3-thorsten.blum@linux.dev>
 <aaKr1E1mPOgxo0JL@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220059-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,microchip.com,bootlin.com,tuxon.dev,gmail.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: AD6691C1D68
X-Rspamd-Action: no action

On 28. Feb 2026, at 09:48, Herbert Xu wrote:
> On Sun, Feb 15, 2026 at 09:51:53PM +0100, Thorsten Blum wrote:
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
>> Compile-tested only.
>> ---
>> drivers/crypto/atmel-i2c.c     | 4 ++--
>> drivers/crypto/atmel-sha204a.c | 7 ++++---
>> 2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> Patch applied.  Thanks.

Hi Herbert,

I also submitted [1], which combines this patch here and patch [2] after
Lothar suggested to squash them. Feel free to apply them separately or
together. Just FYI.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/lkml/20260224225547.683713-2-thorsten.blum@linux.d=
ev/
[2] =
https://lore.kernel.org/lkml/20260220133135.1122081-2-thorsten.blum@linux.=
dev/


