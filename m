Return-Path: <stable+bounces-217707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPQuKXINnGly/QMAu9opvQ
	(envelope-from <stable+bounces-217707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:18:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C8172F9A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2AF13009B14
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0AF344DAE;
	Mon, 23 Feb 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od8D7jdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C8417DE36;
	Mon, 23 Feb 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834733; cv=none; b=SZmyi8S4V+yIlciQ+4rd1p/lQwt5DEuHmAjo7fwNIK2FGBDgtqIEyEad21FapAMONs97BXrqraPUUY+FozkKrLbjsOIkZgoseY8pZpMPCVKkhPdtPoBuBdaG+LD72xLYzXL7j3OpShguBSev20eKs9dbsDKYovytAksn0lpmOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834733; c=relaxed/simple;
	bh=mfi2oIDXNC1HeAdz8FltvcXDHo2fg6vdS90o6q5YbVM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Bc7ddZhukQsCQSFFCE9PscK1bnZu8s2WeT8UaUWBCAUL3DN77vRr4BCOPgvg77RGi6qUuxS6MbH1zdR29REKOebk6SxUQDbAFricwCEDOkXelEPZbuAYMeXSXtuFPHqMcDE11GfVWd5zkvAZh6DcquFGtYYc0V08t3fI4F78Vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od8D7jdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE270C116C6;
	Mon, 23 Feb 2026 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771834733;
	bh=mfi2oIDXNC1HeAdz8FltvcXDHo2fg6vdS90o6q5YbVM=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=od8D7jdW7TFsA+JB6QfJ2xsO67R7VAugMTfRmqNDSI7mN+E8B2btyjyCFEFhb9b+s
	 fLdO+k+OXWCFbv0RubweEW+mB/kC97QA1sAHe9CPo6Si1gh4Jbsv/YZq9ymqxsrBdC
	 84GY8nmrFmXw6HXr+i5vrCkUNx1AKnocG7TxA/wWdP6azdf7hQJKmwoFPIANXjNScg
	 sliuYuOGm3H0iH9IzJfbh3ur775I4a93YYRiAxxgLqj+f4h9Ej+mDesUeMj9a6hDL4
	 0izYKEsVNyqib0e1brhpuDgBzs6h/Y01HDSVAUn8jmXOE1Im44NRVbj5AHH7Z+1bv1
	 n2VPW98pf8/UQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ccacc5352b054326ba4c60c385f192b499ae4e18e1c3c67f98baab600635;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 23 Feb 2026 09:18:49 +0100
Message-Id: <DGM6ZPOT1WCR.157JI0LW4W3E8@kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sst: Fix write enable before AAI
 sequence
Cc: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <linux-kernel@vger.kernel.org>, "Sanjaikumar V S"
 <sanjaikumar.vs@dicortech.com>, <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Sanjaikumar V S" <sanjaikumarvs@gmail.com>,
 <linux-mtd@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.0
References: <20260220094236.28-1-sanjaikumarvs@gmail.com>
 <20260220094236.28-2-sanjaikumarvs@gmail.com>
In-Reply-To: <20260220094236.28-2-sanjaikumarvs@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217707-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB8C8172F9A
X-Rspamd-Action: no action

--ccacc5352b054326ba4c60c385f192b499ae4e18e1c3c67f98baab600635
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Feb 20, 2026 at 10:42 AM CET, Sanjaikumar V S wrote:
> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
>
> When writing to SST flash starting at an odd address, a single byte is
> first programmed using the byte program (BP) command. After this
> operation completes, the flash hardware automatically clears the Write
> Enable Latch (WEL) bit.
>
> If an AAI (Auto Address Increment) word program sequence follows, it
> requires WEL to be set. Without re-enabling writes, the AAI sequence
> fails.
>
> Add spi_nor_write_enable() after the odd-address byte program, but only
> when an AAI sequence will follow (len > 2 bytes remaining).
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

Very strange. If that is correct, it actually never worked
correctly.

Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")

You've said, you didn't test this. Shouldn't it be pretty easy to
write to an odd offset? Also, from reading the code, it looks like
if write ends on an odd offset, it doesn't work either?

> ---
>  drivers/mtd/spi-nor/sst.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> index 175211fe6a5e..fe714e6d0914 100644
> --- a/drivers/mtd/spi-nor/sst.c
> +++ b/drivers/mtd/spi-nor/sst.c
> @@ -210,6 +210,13 @@ static int sst_nor_write(struct mtd_info *mtd, loff_=
t to, size_t len,
> =20
>  		to++;
>  		actual++;
> +
> +		/* BP clears WEL, re-enable if AAI sequence follows */
> +		if (actual < len - 1) {

For brevity, I'd drop the repeated condition and just do the
write_enable unconditionally.

-michael

> +			ret =3D spi_nor_write_enable(nor);
> +			if (ret)
> +				goto out;
> +		}
>  	}
> =20
>  	/* Write out most of the data here. */


--ccacc5352b054326ba4c60c385f192b499ae4e18e1c3c67f98baab600635
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaZwNaRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gLsQGApjeWKQX5yJH4CBKLSNiWdTrh4NTbDWUt
lptAM8AtNMVx31LV6DaadYlN0foO+Y4IAYDaz0UUpx1XRDDBfte/N9aQlQhPeA4I
06h0L+1+WOBKvarpcFSW3Cu6R3D1PmZgD1Y=
=kEFN
-----END PGP SIGNATURE-----

--ccacc5352b054326ba4c60c385f192b499ae4e18e1c3c67f98baab600635--

