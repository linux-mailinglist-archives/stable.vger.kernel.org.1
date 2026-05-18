Return-Path: <stable+bounces-249211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGcvIt/FCmqa7wQAu9opvQ
	(envelope-from <stable+bounces-249211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E425682F8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F45D30391FF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5F03CDBC3;
	Mon, 18 May 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1+1MuJda"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5A1917CD;
	Mon, 18 May 2026 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090088; cv=none; b=tC+12aE7gDT4aJeWmVy5wrKjvWIto9QuBXaPI4FZChEuKn5vP/wmkWEf4QEsoEgP4tXkQ9Tl1T77aDXzGrS87C9a6osBNx7+hKKnagX9d6SWUnsi1JApu9Bi+uug69Oq6bW4PPCTd4SFmezviQflSs0o3dIZrp15iV7sH21rAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090088; c=relaxed/simple;
	bh=gi+72vOlCya6gZpMiaYCiwdqc9vnu+woPeGgkaqrOgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIlRtVYpY7aSc2jlnYGH9P2D7IvnQ+yWjr33OO/m2DnNURHaEIm/f++tqJf27nVPNOvfRUe7fNkZVm0WkZH0vYasO+RepfhuwE47R6Rq6liZFusw3ZIwn3tRZjJa2AL/NDC+DHQjIrPOL0V7Bfp+r58JsWnYPPJBXB2A1rhLpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1+1MuJda; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 00B564E42CE4;
	Mon, 18 May 2026 07:41:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C5DB6602B8;
	Mon, 18 May 2026 07:41:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 757A011AF8605;
	Mon, 18 May 2026 09:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779090084; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TTl6Zp3jTooHfoT3hkV2wY3cCaUWlMcTouaeSxFe3/Q=;
	b=1+1MuJdacp5YpXOUSRQngdxSmhFjU94ICIXlxt8VHZPNNCDDE/BQxguig/2IiSl7jpzA2U
	hGEXldUOnQTV4XChuIzmqErJygDes2cCvSWQMqISq43geoZf8SSDP+EWBr4lGYjExZl0XR
	bI3TNkLsMd8yQiG9hH4Sj2TH7uDNM+7+NxMK80zQExlGsb9UPoA8gNoDVx6dndYG/TBwhJ
	QxJXOiB005zws3QWXD63AtKJKuiv43QGyIUH11FzpfUYVYOgIF7FvsftVlQpKYiPlr3PiK
	sGFVBkFMiD48aIC0Dz369uRotnyKffVluqAuido8LFSl6fM6iLGuEn7GEyfzMQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmem: layouts: Make the fixed-layout driver
 optional
In-Reply-To: <20260515-mathieu-nvmem-fixed-layout-v2-2-8ac215dd4016@bootlin.com>
	(Mathieu Dubois-Briand's message of "Fri, 15 May 2026 13:56:57 +0200")
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
	<20260515-mathieu-nvmem-fixed-layout-v2-2-8ac215dd4016@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 18 May 2026 09:41:23 +0200
Message-ID: <87cxytupuk.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A0E425682F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-249211-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi Mathieu,

On 15/05/2026 at 13:56:57 +02, Mathieu Dubois-Briand <mathieu.dubois-briand=
@bootlin.com> wrote:

> The fixed-layout support is now managed by a separate driver, so we can
> make this support optional. This aligns with the approach taken for
> other layout drivers.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/nvmem/core.c           | 1 +
>  drivers/nvmem/layouts/Kconfig  | 8 ++++++++
>  drivers/nvmem/layouts/Makefile | 2 +-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 0ec4924c4bda..594180d4b889 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -834,6 +834,7 @@ int nvmem_add_cells_from_dt(struct nvmem_device *nvme=
m, struct device_node *np)
>=20=20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(nvmem_add_cells_from_dt);
>=20=20
>  static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
>  {
> diff --git a/drivers/nvmem/layouts/Kconfig b/drivers/nvmem/layouts/Kconfig
> index 5e586dfebe47..f823d56210a3 100644
> --- a/drivers/nvmem/layouts/Kconfig
> +++ b/drivers/nvmem/layouts/Kconfig
> @@ -8,6 +8,14 @@ if NVMEM_LAYOUTS
>=20=20
>  menu "Layout Types"
>=20=20
> +config NVMEM_LAYOUT_FIXED_LAYOUT
> +	tristate "Fixed layout support"
> +	help
> +	  Say Y here to enable support for NVMEM fixed layout, which provides a
> +	  way to describe memory cells with fixed offsets and sizes.
> +
> +	  If unsure, say N.

This will break existing default configurations, and most of them rely
on the fixed layout. I believe this entry should default to =3Dy.

Thanks,
Miqu=C3=A8l

