Return-Path: <stable+bounces-216645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI/oCUo/kml8sQEAu9opvQ
	(envelope-from <stable+bounces-216645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 22:48:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2213FD02
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 22:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACA7E3011079
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2AE309EEE;
	Sun, 15 Feb 2026 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nLGda3Vz"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506DB1494C3
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771192135; cv=none; b=JsMHFFu+ZF1LHvBQXPvnCDa/sCEVLKblJ1yr/MPnJ0lHvRVet5juNqrpO3I3SXI1uFjCKUaR/uHELxxEAwj9SG2pg2p0oNwh/o+AI6kO6ByRx+c3G2etSN4C5TYo006XMiGADhqmMB7G5lMOYFFi4f5POU/vSPTR5ojRbihRJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771192135; c=relaxed/simple;
	bh=QJw44MwvpOuGRv3GT8g3Dmz6RLDQVI45QEd/BEkgkGo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QbSZGoX6oLFf/4h17tXgOLu1RlWPcOMnCOE6wnxE3PYbCGMGizf4oXjms2ord8BcG3ccwvnQPPrygM15XLcVvQxx1f1/KOMzBDUFKd+d806dIJvzXQj+oy3wyFC1eiz+Mb09cQfC+EJ85J+5P1PxhFA9mbwRvrICuszISqgaD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nLGda3Vz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771192122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98u/mhEqw/mlD21bgRdDI+M2Mw8p79SKwci4AWwqc9s=;
	b=nLGda3Vzr5Y5NM5gJVHotmPxaWHDgePF6zCsEFeovvzIdPqJYOMW19qUuGfzdT0wYmzpe9
	YxdTYmunGjeNjmbKJAkCtf7+cN+4AQ7U8nELfjj5s6fryPRsui7iGe+i/v9mXcHSyQLS8W
	9T29ib2rctwBUsNvk/DyjXBiXDb+c0s=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix OTP sysfs read and error
 handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAFXKEHbCrp57ruvCF2TXXcnoJF93Z5bdUd7Nt5WtM9_abtc66w@mail.gmail.com>
Date: Sun, 15 Feb 2026 22:48:07 +0100
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
Message-Id: <2E9C85C9-AD05-4BB3-A945-5ADECCB5C7E4@linux.dev>
References: <20260215124125.465162-2-thorsten.blum@linux.dev>
 <CAFXKEHbCrp57ruvCF2TXXcnoJF93Z5bdUd7Nt5WtM9_abtc66w@mail.gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216645-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9A2213FD02
X-Rspamd-Action: no action

On 15. Feb 2026, at 22:09, Lothar Rubusch wrote:
> I tried to verify your patch on hardware today, unfortunately it did
> not work for me.
>=20
> My setup works with current atsha204a module in the below described =
way. When
> trying to dump the OTP zone on exactly the same hardware with a =
patched module,
> it only prints '0' and nothing more, see below.
>=20
> [...]

Hi Lothar,

thank you for your feedback. I made a small mistake in the return value
where I forgot to add the previous length 'len'. Sorry about that!

Unfortunately, I don't have the hardware right now to test this - could
you try if it works with the following change?

Thanks,
Thorsten


diff --git a/drivers/crypto/atmel-sha204a.c =
b/drivers/crypto/atmel-sha204a.c
index 793c8d739a0a..431672517dba 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -134,7 +134,7 @@ static ssize_t otp_show(struct device *dev,

	for (i =3D 0; i < OTP_ZONE_SIZE; i++)
		len +=3D sysfs_emit_at(buf, len, "%02X", otp[i]);
-	return sysfs_emit_at(buf, len, "\n");
+	return len + sysfs_emit_at(buf, len, "\n");
}
static DEVICE_ATTR_RO(otp);


