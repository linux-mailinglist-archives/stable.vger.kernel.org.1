Return-Path: <stable+bounces-233059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIPbBZeWzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:17:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5C438BBB2
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF50D3008C93
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4D3EF649;
	Thu,  2 Apr 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UerAOqT1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70133C2787;
	Thu,  2 Apr 2026 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146620; cv=none; b=FkkDOkY+ywyPuOk6v3bt2TiHNhqmMPU2yRC+vcMtFH1u1jiou7nZnI34Xu+XeNdeolyLITa05m7jBnKB/yeZNLYSfo13xOMWwsiMH/D5nHVd5sOTLeA/HY0UVV7NYnBGVUUOIfgV98LJP3xTW7BNGJZmtSFxvqwhtTGz7BsRhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146620; c=relaxed/simple;
	bh=zYdSCkd1k9TT+brRx9yNputgCGXY5SKz6pKEPjyOCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFDa/YU6b6qeZgFxm4KQzmEFv4R0l0rHzwlnhYUW0FTSjvAsa92Zqcxzq62MwR5YIv1W0c64X8sNtRb074Kd5Fkti82dunIKOPEh9zAbKaqaFTRM3/qfG2ylpT2JR3I1EkcFRU63oCI8V3kP459MgvMGxHJNz89x385ZqxG3K1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UerAOqT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0763DC116C6;
	Thu,  2 Apr 2026 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775146620;
	bh=zYdSCkd1k9TT+brRx9yNputgCGXY5SKz6pKEPjyOCE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UerAOqT1XmiMw/awWnw5zBJCC4BQ/L9itj0CngV3F7wLIlQYBynRQgZaY6uzl2IZt
	 9bbK5QcBsl5zRhO0LzN4IZZMqe0b6ey2cxNDvyFzQaqdfX6O9je52fEZxxPrFd78dy
	 rZKTI3cNK3k8z33UM0FQR6TfCOMtFcQw47T49Ov4cp7Kc2eCNHu1cJTUfNTtPweNXy
	 36/EcRx7BUmnx1tZOdi2T46gQQ+zIA5BjTnWLVsPvHbSfELyCx5sn+1UEBlQnPtimV
	 QQr9fWYRq75bqAsCY5oJUi4hOxFpWsk2OqNhgaxRkHs5plB/vKT0gF1bWbnytOFnT4
	 nxoVJhcU9uWFA==
Date: Thu, 2 Apr 2026 17:16:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fpga: microchip-spi: add bounds checks in
 mpf_ops_parse_header()
Message-ID: <20260402-gloomy-entire-42a7a407a5e5@spud>
References: <20260402125446.3776153-3-sebasjosue84@gmail.com>
 <20260402153752.3793055-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nHwyQHrHtz2BM09A"
Content-Disposition: inline
In-Reply-To: <20260402153752.3793055-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233059-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E5C438BBB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--nHwyQHrHtz2BM09A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 09:37:52AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
>=20
> mpf_ops_parse_header() reads several fields from the bitstream file
> and uses them as offsets and sizes without validating them against the
> buffer size, leading to multiple out-of-bounds read vulnerabilities:
>=20
> 1. There is no check that count is large enough to read header_size
>    at MPF_HEADER_SIZE_OFFSET (24). Add a minimum count check.
>=20
> 2. When header_size (u8 from file) is 0, the expression
>    *(buf + header_size - 1) reads one byte before the buffer.
>    Return -EINVAL since retrying with a larger buffer cannot fix
>    a zero header_size.
>=20
> 3. In the block lookup loop, block_id_offset and block_start_offset
>    advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
>    blocks_num (u8) controlling the count. With a small buffer, these
>    offsets exceed count, causing OOB reads via get_unaligned_le32().
>    Return -EAGAIN since a larger buffer may resolve the issue.
>=20
> 4. components_size_start (from file) and component_size_byte_num
>    (derived from components_num, u16 from file) are used as offsets
>    into buf without validation, allowing arbitrary OOB reads.
>=20
> Add bounds checks for all four cases.
>=20
> Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manage=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/fpga/microchip-spi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 6134cea..00fa2d6 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -115,7 +115,13 @@ static int mpf_ops_parse_header(struct fpga_manager =
*mgr,
>  		return -EINVAL;
>  	}
> =20
> +	if (count < MPF_HEADER_SIZE_OFFSET + 1)
> +		return -EINVAL;
> +
>  	header_size =3D *(buf + MPF_HEADER_SIZE_OFFSET);
> +	if (!header_size)
> +		return -EINVAL;
> +
>  	if (header_size > count) {
>  		info->header_size =3D header_size;
>  		return -EAGAIN;
> @@ -139,6 +145,10 @@ static int mpf_ops_parse_header(struct fpga_manager =
*mgr,
>  	bitstream_start =3D 0;
> =20
>  	while (blocks_num--) {
> +		if (block_id_offset >=3D count ||
> +		    block_start_offset + sizeof(u32) > count)
> +			return -EAGAIN;
> +
>  		block_id =3D *(buf + block_id_offset);
>  		block_start =3D get_unaligned_le32(buf + block_start_offset);
> =20
> @@ -183,6 +193,10 @@ static int mpf_ops_parse_header(struct fpga_manager =
*mgr,
>  		component_size_byte_off =3D
>  			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
> =20
> +		if (components_size_start + component_size_byte_num +
> +		    sizeof(u32) > count)
> +			return -EINVAL;

I didn't mention it explicitly, but it kinda follows from the other
comment, do we not just want to ask for a bigger buffer here too?

> +
>  		component_size =3D get_unaligned_le32(buf +
>  						    components_size_start +
>  						    component_size_byte_num);
> --=20
> 2.43.0
>=20

--nHwyQHrHtz2BM09A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCac6WeAAKCRB4tDGHoIJi
0rm1AQC66r/q8WU6qGIMzt06cggSa+6KAcXYD9t0YLmWB6uS/wEA9spj0s1TfIY6
UdB61NgKH0IaAQAwtaWM6B2nT0SNbgc=
=Afcc
-----END PGP SIGNATURE-----

--nHwyQHrHtz2BM09A--

