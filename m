Return-Path: <stable+bounces-159315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63CAF75F8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F583B4652
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C662E6D25;
	Thu,  3 Jul 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DYwxko1P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NptWg52a"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965B176ADE;
	Thu,  3 Jul 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550119; cv=none; b=n4qzu/MlGXg6kfxcK8UvUAnrWG8SmZYDssiCdn4i3pPRmJQ2YaTJ1fjNtNLh0zsBOHzoTFf0CNEBM6ZhOMa/wfERlq9fYka4/FiRE5tZDPpp279sRgQR74Ov+Aq5mFg2nRFuazOyMKNEvaVf4km2ZLZZ83P2KDdn+fAvGW4jryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550119; c=relaxed/simple;
	bh=WnKxo7Pr2dAqCibzDh87R5uqN2naOh2unTSRmdwdDOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTgrgj7sr2rY2EjnmvFbeRxNlAesXUFkHOxc0isUJZKFrVUEY0a3mrMIEhBJKmg6sR1fot3sY6z09XhguZOzwdNSQb2uZLM0E8QVhiYZGpCR8tq9yqzGuv5q/gOUXL7kw9Vv3EQSlwtCj3ZNVbhdcEedViPDlxjCw9VUfj+YClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DYwxko1P; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NptWg52a reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1751550115; x=1783086115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=04qYGKXctFAZ3e5+Qm8FZ6hK/vJxUFD2rK/A5VS3svY=;
  b=DYwxko1PAz3Acj5M3xuWRSo1YrUKTliiTSFa8WbxpQasfwXdj5N/6H74
   iI/fL1i2NbOru7jOnOeFIkb2CnwFgrRJfjCDTQvkxj2O1kTCeGkFJn94n
   pRelywAV4fh0ZGHqzncSwIs/C39dL/DQNqO/yk+wifyRXVaRIJAbzJ6Jy
   ZDKwsFB85z51nGdqfJUES+6aNyl1YVZcoFhL+I7xpBOJvFrNgINGcioe7
   Bk/VR4PkIrLL90KNZz1QmvY38uh6B66Q5mvjLItfsr6fm4Flwg+M0cRGl
   kSgdi6PC6QxM7oI05n1Q+Fb2E0ssKWWV1aCZ4vTBGdioLIOfXeEvzAehm
   A==;
X-CSE-ConnectionGUID: QoxKM4g1RseAF++DkGCgAA==
X-CSE-MsgGUID: 8fICYet0SzWZ3FWt/bzHeA==
X-IronPort-AV: E=Sophos;i="6.16,284,1744063200"; 
   d="scan'208";a="45010991"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 03 Jul 2025 15:41:46 +0200
X-CheckPoint: {6866889A-12-4FC15ADB-CD71293B}
X-MAIL-CPID: 7E9CD1FEF2A5839123F58A657BCB8A76_0
X-Control-Analysis: str=0001.0A006399.686688BF.0033,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03A1A161869;
	Thu,  3 Jul 2025 15:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1751550102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04qYGKXctFAZ3e5+Qm8FZ6hK/vJxUFD2rK/A5VS3svY=;
	b=NptWg52abfzeSToTSQmYoKJAZLV7kwBaXq3ncy0XzG1W8xulY2lg+0zDoqDA8i+oLRGleu
	pRYCZXRM5vHbg7v8eY6wvQtbspgfaGErcrMRFh+Z/ip2Hk6iQUjPocf9EDIaYyY0xIbpEO
	IphiGndW4kAJARGsCNLzkh5hQiAvi80Pnm77KXkZmGLy484EKfy1oTrE7/KuC3ovBfq1HY
	PNnDimssMw3skITQynyc7QIqtjt5B+TkSl1K2ceeifjgAfrGTYcyFimopMV4YCIlSUX86z
	LJNC7d4RILfaegRXAnida3ad7CASpi9e+YQU8tdATIqHgNgXr0UgyLLrde6L6g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Steffen =?ISO-8859-1?Q?B=E4tz?= <steffen@innosonix.de>,
 stable@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Steffen =?ISO-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Subject: Re: [PATCH v3] nvmem: imx-ocotp: fix MAC address byte length
Date: Thu, 03 Jul 2025 15:41:40 +0200
Message-ID: <2665065.Lt9SDvczpP@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250623171003.1875027-1-steffen@innosonix.de>
References: <20250623171003.1875027-1-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Montag, 23. Juni 2025, 19:09:55 CEST schrieb Steffen B=E4tz:
> The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
> extension of the "mac-address" cell from 6 to 8 bytes due to word_size
> of 4 bytes.
>=20
> Thus, the required byte swap for the mac-address of the full buffer lengt=
h,
> caused an trucation of the read mac-address.
> From the original address 70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14
>=20
> After swapping only the first 6 bytes, the mac-address is correctly passed
> to the upper layers.
>=20
> Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Steffen B=E4tz <steffen@innosonix.de>

Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Thanks

> ---
> v3:
> - replace magic number 6 with ETH_ALEN
> - Fix misleading indentation and properly group 'mac-address' statements
> v2:
> - Add Cc: stable@vger.kernel.org as requested by Greg KH's patch bot
>  drivers/nvmem/imx-ocotp-ele.c | 6 +++++-
>  drivers/nvmem/imx-ocotp.c     | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
> index ca6dd71d8a2e..9ef01c91dfa6 100644
> --- a/drivers/nvmem/imx-ocotp-ele.c
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/if_ether.h>	/* ETH_ALEN */
> =20
>  enum fuse_type {
>  	FUSE_FSB =3D BIT(0),
> @@ -118,9 +119,12 @@ static int imx_ocotp_cell_pp(void *context, const ch=
ar *id, int index,
>  	int i;
> =20
>  	/* Deal with some post processing of nvmem cell data */
> -	if (id && !strcmp(id, "mac-address"))
> +	if (id && !strcmp(id, "mac-address")) {
> +		if (bytes > ETH_ALEN)
> +			bytes =3D ETH_ALEN;
>  		for (i =3D 0; i < bytes / 2; i++)
>  			swap(buf[i], buf[bytes - i - 1]);
> +	}
> =20
>  	return 0;
>  }
> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
> index 79dd4fda0329..1343cafc37cc 100644
> --- a/drivers/nvmem/imx-ocotp.c
> +++ b/drivers/nvmem/imx-ocotp.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/if_ether.h>	/* ETH_ALEN */
> =20
>  #define IMX_OCOTP_OFFSET_B0W0		0x400 /* Offset from base address of the
>  					       * OTP Bank0 Word0
> @@ -227,9 +228,12 @@ static int imx_ocotp_cell_pp(void *context, const ch=
ar *id, int index,
>  	int i;
> =20
>  	/* Deal with some post processing of nvmem cell data */
> -	if (id && !strcmp(id, "mac-address"))
> +	if (id && !strcmp(id, "mac-address")) {
> +		if (bytes > ETH_ALEN)
> +			bytes =3D ETH_ALEN;
>  		for (i =3D 0; i < bytes / 2; i++)
>  			swap(buf[i], buf[bytes - i - 1]);
> +	}
> =20
>  	return 0;
>  }
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



