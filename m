Return-Path: <stable+bounces-59275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C4A930DF4
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 08:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B98B20E00
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A1513B5BD;
	Mon, 15 Jul 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GL7H2A/L"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A01E89C;
	Mon, 15 Jul 2024 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721024907; cv=none; b=FmXbtsEw6hafu+JHqLqV1cTQe3DT2Sh+sJFVvu0YSRmBRcYmIRL++uKtZyxpMG9ogU8dIvx7m3pOHOItolMS7XLmTe+fkpdgWaR+exsAlhFLp4N6hMe0ZukmZqThAcrn1VVxozM4GCY5ODkdO+20CBMnxkrfR8UZ7GyLxk7vQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721024907; c=relaxed/simple;
	bh=1ui7m0wnZgbZbs3LRTofPwGk5YJJjt7ZygWjX48dkig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aw2H6xYTNHl6fihyx4LAQXJy1uUYYy0ujvTRn6bpAFTLDQMnxOvN+ceUv9WNxselpKPzwf/pVHj6+vszhB7w1Bl6TvwdAfWxXD2yUjv9ywW3HRfWYfxas/SNX3BBjF07M3diNH8AdoFz3P4b0CWpbW4FQzmeKmXLzOf2PjePs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=GL7H2A/L; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721024898;
	bh=KZWRvgNI83laV2F/9Mh/JT1YiwEidnu8a2gddrR2jXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GL7H2A/LMD7T6pGRLCkTdluoSPF/bS5gO+megwXUQLtEIxKRPFeGNa1AjCyM5VMMe
	 a2zvCY28BHSxsie71f92TOlt4daSidppNss4EjIhjAt/Clwtpioolv6SAzIcgFXDpp
	 Uw+X9l1Fm1RcYnREoPDD1VFt77tAFjhBIwNQ4+SK+GX2qyFAUniFHkg9wK2nUu2UwS
	 +deEPqAw1vSPDaR/z/wMHv6tL7+KhPItcy4EpHZ27U37oVIjvUTxcJHz6uZ/WhViiX
	 3N5jLPMVFYyHNPg4Jy4lJjq+jzO69C8jdT4mLEIfPgJswpqVZcn9EhvB+96FeVpu3B
	 L/bkHU04KinxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WMshd3Z4Dz4wbh;
	Mon, 15 Jul 2024 16:28:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ma Ke <make24@iscas.ac.cn>, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ma Ke
 <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
In-Reply-To: <20240715025442.3229209-1-make24@iscas.ac.cn>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
Date: Mon, 15 Jul 2024 16:28:15 +1000
Message-ID: <87y163w4n4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ma Ke <make24@iscas.ac.cn> writes:
> In read_handle(), of_get_address() may return NULL if getting address and
> size of the node failed. When of_read_number() uses prop to handle
> conversions between different byte orders, it could lead to a null pointer
> dereference. Add NULL check to fix potential issue.
>
> Found by static analysis.
>
> Cc: stable@vger.kernel.org
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v4:
> - modified vulnerability description according to suggestions, making the=
=20
> process of static analysis of vulnerabilities clearer. No active research=
=20
> on developer behavior.
> Changes in v3:
> - fixed up the changelog text as suggestions.
> Changes in v2:
> - added an explanation of how the potential vulnerability was discovered,
> but not meet the description specification requirements.
> ---
>  drivers/misc/cxl/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> index bcc005dff1c0..d8dbb3723951 100644
> --- a/drivers/misc/cxl/of.c
> +++ b/drivers/misc/cxl/of.c
> @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *han=
dle)
>=20=20
>  	/* Get address and size of the node */
>  	prop =3D of_get_address(np, 0, &size, NULL);
> -	if (size)
> +	if (!prop || size)
>  		return -EINVAL;
>=20=20
>  	/* Helper to read a big number; size is in cells (not bytes) */

If you expand the context this could just use of_property_read_reg(),
something like below.

cheers


diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
index bcc005dff1c0..a184855b2a7b 100644
--- a/drivers/misc/cxl/of.c
+++ b/drivers/misc/cxl/of.c
@@ -53,16 +53,15 @@ static const __be64 *read_prop64_dword(const struct dev=
ice_node *np,
=20
 static int read_handle(struct device_node *np, u64 *handle)
 {
-	const __be32 *prop;
 	u64 size;
+=09
+	if (of_property_read_reg(np, 0, handle, &size))
+		return -EINVAL;
=20
-	/* Get address and size of the node */
-	prop =3D of_get_address(np, 0, &size, NULL);
+	// Size must be zero per PAPR+ v2.13 =C2=A7 C.6.19
 	if (size)
 		return -EINVAL;
=20
-	/* Helper to read a big number; size is in cells (not bytes) */
-	*handle =3D of_read_number(prop, of_n_addr_cells(np));
 	return 0;
 }
=20

