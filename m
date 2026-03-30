Return-Path: <stable+bounces-231214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCm0EuBzymmB9AUAu9opvQ
	(envelope-from <stable+bounces-231214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD635B88B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CAF33005648
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFD33D332C;
	Mon, 30 Mar 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV84wDS9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC83D1CA2;
	Mon, 30 Mar 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875554; cv=none; b=BjOSmlG3HZn8BWQiDNJAHQphjB9fkSf0XBBGwgb4KnQQ3rMqAq5Leo8qW/TVDtEtReHYMSBnl2Levnl5CALkrdDELlnGGXPlc6nAxnHx64m03/CaHxBfti01r6aljtf8XpI5qLxeOJN3sWDZ7e7PrACJ+fTkQfl9z2aLdujz4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875554; c=relaxed/simple;
	bh=2nMZ/t93heba7Ewg6MwnlysL3ltrvhPtua6z1ntkAXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5LPkKqbfWU4rU4rKk77aHnup0yg+pPQlVso1eDyO4Gwk/OApqLWtWpl9v+NdQYG0b4DjEiLniZBZtrDW8TKsGXS9aIHY30K4SCjKWe2Ee2WM/bcj1dQUi4EVtSUJypWiTWHV5rFcGUxpBAb9MYy9qB0aHv/LDPQWdPbpMN54H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV84wDS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08037C4CEF7;
	Mon, 30 Mar 2026 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875553;
	bh=2nMZ/t93heba7Ewg6MwnlysL3ltrvhPtua6z1ntkAXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cV84wDS9qjq2QosI85WvoM+eX6kEAZLrkGtKGJmESZT9PCbZXAOpqkw0zbhXstKR/
	 2aSfUQ+T3N0eZIiQ/ECNEeOCnhB3v4Q8/OAQNM89ehi0rQ3BjYDfmx6+z+jqP7rqMx
	 AUCbivu0IScofz8qFq+zIAPE8fafAc+1001PpgFeOTUqWYoK6FBCldtuAv6k7u4gPL
	 TQuQXIYlFAeozuLBFcHc0nM0ybk0IEr6wb91X9XnLVzDMgNqZ3zqPHmH0GeALQg47Q
	 5BRknXvT2RDwRmemFOEiyoRzImWAGtQpU2T9nZPRcBAiNKzCQr+KdYKM7zx/5S/xNZ
	 GxJt4743eppuA==
Date: Mon, 30 Mar 2026 13:59:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Songsong Zhang <U2FsdGVkX1@gmail.com>
Subject: Re: [PATCH] riscv: misaligned: Make enabling delegation depend on
 BROKEN
Message-ID: <20260330-sensation-pronounce-98f8b14836ed@spud>
References: <20260330-riscv-misaligned-dont-delegate-v1-1-68b089b306c3@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iWQWbSmWWiEp/KUt"
Content-Disposition: inline
In-Reply-To: <20260330-riscv-misaligned-dont-delegate-v1-1-68b089b306c3@iscas.ac.cn>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[rivosinc.com,kernel.org,dabbelt.com,ghiti.fr,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231214-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DFD635B88B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--iWQWbSmWWiEp/KUt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 02:47:15PM +0800, Vivian Wang wrote:
> The unaligned access emulation code in Linux has various deficiencies.
> For example, it doesn't emulate vector instructions [1], and doesn't
> emulate KVM guest accesses. Therefore, requesting misaligned exception
> delegation with SBI FWFT actually regresses userspace and KVM guest
> behavior. Until Linux can handle it properly, guard these sbi_fwft_set()
> calls behind RISCV_SBI_FWFT_DELEGATE_MISALIGNED, which in turn depends
> on BROKEN.
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
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
> Cl=E9ment: Sorry to call what you did broken, but it really is breaking
> on real hardware out there. I think this is the right way for now.
> ---
>  arch/riscv/Kconfig                   | 14 ++++++++++++++
>  arch/riscv/kernel/traps_misaligned.c |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 90c531e6abf5..8ad1f13c170e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -941,6 +941,20 @@ config RISCV_VECTOR_MISALIGNED
>  	help
>  	  Enable detecting support for vector misaligned loads and stores.
> =20
> +config RISCV_SBI_FWFT_DELEGATE_MISALIGNED
> +	bool "Request firmware delegation of unaligned access exceptions"
> +	depends on RISCV_SBI
> +	depends on BROKEN

Making it hard to enable I think makes a lot of sense, given the issues
you're reporting but I tacking on BROKEN will remove effectively all
build coverage of it* and will definitely stop almost anyone using it.
Should it be just made NONPORTABLE with the text about being incomplete
expanded a wee bit to say what is broken so that people can make a
decision?

Cheers,
Conor.

*it's like 10 lines, probably an irrelevant concern.


> +	help
> +	  Use SBI FWFT to request delegation of load address misaligned and
> +	  store address misaligned exceptions, if possible, and prefer Linux
> +	  kernel emulation of these accesses to firmware emulation.
> +
> +	  Since the Linux kernel's emulation is incomplete, enabling this may
> +	  cause unexpected userspace and KVM guest crashes.
> +
> +	  If you don't know what to do here, say N.
> +
>  choice
>  	prompt "Unaligned Accesses Support"
>  	default RISCV_PROBE_UNALIGNED_ACCESS
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> index 2a27d3ff4ac6..81b7682e6c6d 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -584,7 +584,7 @@ static int cpu_online_check_unaligned_access_emulated=
(unsigned int cpu)
> =20
>  static bool misaligned_traps_delegated;
> =20
> -#ifdef CONFIG_RISCV_SBI
> +#if defined(CONFIG_RISCV_SBI_FWFT_DELEGATE_MISALIGNED)
> =20
>  static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
>  {
>=20
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260330-riscv-misaligned-dont-delegate-3cf98c76ee08
>=20
> Best regards,
> --=20
> Vivian "dramforever" Wang
>=20

--iWQWbSmWWiEp/KUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacpznQAKCRB4tDGHoIJi
0hkBAQDLloJ2fsCkxVn1n0lWLGYSOeBvS86X8gtY70GiztI0rAD8CbWMLIRmoLSw
E2fmbtPFRc4u5kgT7YeYGqXCoGiiBAE=
=aHnI
-----END PGP SIGNATURE-----

--iWQWbSmWWiEp/KUt--

