Return-Path: <stable+bounces-232730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLdDL/DdzGm0XAYAu9opvQ
	(envelope-from <stable+bounces-232730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:57:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65C37728A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79966301C04C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE54382F07;
	Wed,  1 Apr 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPv/Y1YC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671836EAA8;
	Wed,  1 Apr 2026 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033833; cv=none; b=TQE7tVkVVO/JAhql69qkAUViWG+vqFyTqcM5hwhp6vZw4pzi2XWsux1rUhKEoM23JT5I/qmO/8yNNvfV9Su2hZV+5xG9d8ruA6gsmojhJX7KbYjUMk8dt2oLQvZwDFiBqEg2NPH1X9gMR1KkoZm6jL1PyviMpjfssGC6C177d34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033833; c=relaxed/simple;
	bh=HFqB/PAbyCZ2H+Qy8HsiLXNyTHciRpm9ySdIFFZdpmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP0f2G9nXdCREPtLiJfuVCoj9O8AVJlZcvXjGA+YMJgeb63X1r9lrXQjdHWgQ7f4joFP24le6vORv2TorrdyGKFt1mv4RoMk6vcwK+Je5bAG8jZKXntCVkHUm0TH5MHLqKX7ufjOpJNgmfUuCNzNc16NONm05lIOthlPbWULbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPv/Y1YC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB02FC4CEF7;
	Wed,  1 Apr 2026 08:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775033832;
	bh=HFqB/PAbyCZ2H+Qy8HsiLXNyTHciRpm9ySdIFFZdpmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPv/Y1YCdRdUKsMmJ3Ro3bep/bA2BXJF0llJRD5hF0nQSfrmOgPeBNTNAGzZ53oAW
	 nApSkhw+kqpaxACBfNT5j376+9TyLpkcJdM1Q0w6K7ij0d4Q4ZsRNsP0l6iOIaXX62
	 zLEhV16DrwazjfGUCqESQ9Hvkzz73NSs62pInOFWZjT9DjY+BEffQeFjj8KwR7GidZ
	 MN7V22ZuYwgj17jSpThMz1eHyaiF+HRuN+/rtX+MvWZiDIFKlXs3jV1PAI8QFGmeVg
	 fifdBhphQ5bC9FAdzE+dlvM87fm7LMWfoAvuE+piLPZ+zX4o5w++C1b4QMfA3fGzRl
	 feJMqkLAcNyvg==
Date: Wed, 1 Apr 2026 09:57:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Songsong Zhang <U2FsdGVkX1@gmail.com>
Subject: Re: [PATCH v2] riscv: misaligned: Make enabling delegation depend on
 NONPORTABLE
Message-ID: <20260401-revocable-tropical-2f52d14e787d@spud>
References: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hpiXizl6p0EYn3K4"
Content-Disposition: inline
In-Reply-To: <20260401-riscv-misaligned-dont-delegate-v2-1-5014a288c097@iscas.ac.cn>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rivosinc.com,kernel.org,dabbelt.com,ghiti.fr,ventanamicro.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-232730-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 4C65C37728A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hpiXizl6p0EYn3K4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 09:53:17AM +0800, Vivian Wang wrote:
> The unaligned access emulation code in Linux has various deficiencies.
> For example, it doesn't emulate vector instructions [1] [2], and doesn't
> emulate KVM guest accesses. Therefore, requesting misaligned exception
> delegation with SBI FWFT actually regresses vector instructions' and KVM
> guests' behavior.
>=20
> Until Linux can handle it properly, guard these sbi_fwft_set() calls
> behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends on
> NONPORTABLE. Those who are sure that this wouldn't be a problem can
> enable this option, perhaps getting better performance.
>=20
> The rest of the existing code proceeds as before, except as if
> SBI_FWFT_MISALIGNED_EXC_DELEG is not available, to handle any remaining
> address misaligned exceptions on a best-effort basis. The KVM SBI FWFT
> implementation is also not touched, but it is disabled if the firmware
> emulates unaligned accesses.
>=20
> Cc: stable@vger.kernel.org
> Fixes: cf5a8abc6560 ("riscv: misaligned: request misaligned exception fro=
m SBI")
> Reported-by: Songsong Zhang <U2FsdGVkX1@gmail.com> # KVM
> Link: https://lore.kernel.org/linux-riscv/38ce44c1-08cf-4e3f-8ade-20da224=
f529c@iscas.ac.cn/ [1]
> Link: https://lore.kernel.org/linux-riscv/b3cfcdac-0337-4db0-a611-258f286=
8855f@iscas.ac.cn/ [2]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--hpiXizl6p0EYn3K4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaczd5AAKCRB4tDGHoIJi
0gJNAQD9puXaqMoYlOgb9l0qTA1VVkfJWqp34EhIpn/V/x3TNwEArFjrRZBufhrk
HNKCnm8VYHwn6OpEBmTjirdSrRQeAAA=
=gCbu
-----END PGP SIGNATURE-----

--hpiXizl6p0EYn3K4--

