Return-Path: <stable+bounces-245441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IyRAbMQA2qX0AEAu9opvQ
	(envelope-from <stable+bounces-245441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:36:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE651F6EA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C45333094AE0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544734D90A8;
	Tue, 12 May 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="eYY847tS"
X-Original-To: stable@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD0395AF6;
	Tue, 12 May 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585483; cv=none; b=T3b5YpRGCnb1FNyfOW87HZOpnfG6KNPMY0ctA4AEiU9hNLGHZTSgN9HuP8tQ7lw/J2yyytN1i8rniCqOgHC9VlVsl48N7f7dg9yV56bPyc+/C/z6AFnpYNg/P4oXqr1nCFvz7sM8ExlAX9RignDAQxRTRBbCoetA19jcdQLuoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585483; c=relaxed/simple;
	bh=XtUJ6qBwxO2Rn1AJCda81DbPfgbhENtaLiwVfeJM51Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uovtow0Kbehew5dS47+6i8ayJkL6ehz8hFc13dkpP0tOsBhTigNaVDwUl8OdAmPxSh1cAmQrPwsgAyIYXOpYatRMFnbsXh37Cpw/PyHuF9UcL5Vr4D49zIjxf//oJz+qkmT2yXHNqARtw2rK8a3OzrdBaqQmnwJe9NqDq1VvLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=eYY847tS; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 45CF381730;
	Tue, 12 May 2026 14:31:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp) with ESMTPSA id CVILvd5SQW20-68VUTRwm;
	Tue, 12 May 2026 14:31:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1778585475; bh=eZt4aFxb1+Jo9ssbYqsova7An6JKh8iGv7IMeAuTii8=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=eYY847tS0UiPtBJuTq1GuWULtWTzJ9h+Wa6n08i79XpGyHdY22zJjP3ThNL81eE/t
	 KWIjy+VBdZvokv2Rm1AijLtbrnR35ix5k3tFkM1PtdLNN/bSOSPRDtQzennuT9Qrss
	 m+mjGzJXTlTOvx4mLu/x1vAZSYv0jZ2zLSOTm4Po=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <411cf098d63bde936dea9197217025012eac7daf.camel@maquefel.me>
Subject: Re: [PATCH] spi: ep93xx: fix error pointer deref after DMA setup
 failure
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 12 May 2026 14:31:12 +0300
In-Reply-To: <20260512074849.915143-1-johan@kernel.org>
References: <20260512074849.915143-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A3FE651F6EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[maquefel.me:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245441-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[maquefel.me: no valid DMARC record];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[maquefel.me:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.shubin@maquefel.me,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 09:48 +0200, Johan Hovold wrote:
> The driver falls back to PIO mode if DMA setup fails during probe.
>=20
> Make sure to the clear the DMA channel pointers on setup failure to
> avoid dereferencing an error pointer on later probe errors or driver
> unbind.
>=20
> This issue was flagged by Sashiko when reviewing a devres allocation
> conversion patch.
>=20
> Fixes: e79e7c2df627 ("spi: ep93xx: add DT support for Cirrus EP93xx")
> Link:
> https://sashiko.dev/#/patchset/20260429091333.165363-1-johan%40kernel.org=
?part=3D10
> Cc: stable@vger.kernel.org	# 6.12
> Cc: Nikita Shubin <nikita.shubin@maquefel.me>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Nikita Shubin <nikita.shubin@maquefel.me>

> ---
> =C2=A0drivers/spi/spi-ep93xx.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index db50018050e5..f716c9607be4 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -582,12 +582,14 @@ static int ep93xx_spi_setup_dma(struct device
> *dev, struct ep93xx_spi *espi)
> =C2=A0	espi->dma_rx =3D dma_request_chan(dev, "rx");
> =C2=A0	if (IS_ERR(espi->dma_rx)) {
> =C2=A0		ret =3D dev_err_probe(dev, PTR_ERR(espi->dma_rx), "rx
> DMA setup failed");
> +		espi->dma_rx =3D NULL;
> =C2=A0		goto fail_free_page;
> =C2=A0	}
> =C2=A0
> =C2=A0	espi->dma_tx =3D dma_request_chan(dev, "tx");
> =C2=A0	if (IS_ERR(espi->dma_tx)) {
> =C2=A0		ret =3D dev_err_probe(dev, PTR_ERR(espi->dma_tx), "tx
> DMA setup failed");
> +		espi->dma_tx =3D NULL;
> =C2=A0		goto fail_release_rx;
> =C2=A0	}
> =C2=A0

