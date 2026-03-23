Return-Path: <stable+bounces-227957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC/9Jv8hwWmTQwQAu9opvQ
	(envelope-from <stable+bounces-227957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:20:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6FD2F11A3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8C98300723B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AFC396591;
	Mon, 23 Mar 2026 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eljj9MaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349B33D4E9;
	Mon, 23 Mar 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264811; cv=none; b=Qba1fXYEdP7G1gClEFkIDbxMul03YHQB9ruVylmVo6Mcn+8RZb5s5UVqrF78o5TJmJ4ETpzXe5VLv2dxDwersbB9kM9A1IVBeTq5oSvfjX2NMJ40olfkrd8S4GYpehLad3eN+LaaLo1FCKfMcxfxlnkB90Zwq+kCW20bJBmVHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264811; c=relaxed/simple;
	bh=ucPxq4MhQ/2IACYN9iIMa41DTWkZt6a8czUjSOoJNqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD5ZBqhZhlUq1SAot7aSnlzxn+qmByijh3sAdXPKnqcOe9vjJHRuMFlBAXnts8nRKSmCS+hW29vKEXqGvDe7egZpokStLt9RBOVa1Uc0jnQnZjLlWT4bmPZz3i8uELTOaVDXi1sAo45+GkZrN/jJj7paOV3VTXecY4uopTWNgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eljj9MaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8497EC4CEF7;
	Mon, 23 Mar 2026 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774264810;
	bh=ucPxq4MhQ/2IACYN9iIMa41DTWkZt6a8czUjSOoJNqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eljj9MaNLx8dYHx5x83gvBOh1ZnaeVhCAelrLjkIVHRYK17eg6qUpgCRxFkc49TQy
	 XeFN2iXHv5ndf3cbVtCJv3gW/8nZXeRc+jKS0O3dkgHo4GVxI4dRP3j7dxlVqtmufN
	 F+8ASBr+VXxDO1FJdv80F+NCrfmvHvMSl4+y+CS3pDVjB8fN8YtFKf12+G7CmXgNYt
	 qgzQj57JwLiVgV78rLIeXncTgKslyyAnz88kF2K6EJe8LbwhPPBYiGMhJI61T5F13U
	 ISOwpYZlDbu9JX9zxY9+8//j3UoxatmgKVXAfBx3HgvmcYKzWfbEFuJFwd9awdaD5W
	 mZGlPH+SBArGw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4dKK-00000003YDx-13gR;
	Mon, 23 Mar 2026 12:20:08 +0100
Date: Mon, 23 Mar 2026 12:20:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: imx: fix use-after-free on unbind
Message-ID: <acEh6KiKMfBehoZO@hovoldconsulting.com>
References: <20260323104948.844583-1-johan@kernel.org>
 <20260323104948.844583-2-johan@kernel.org>
 <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xZzs3D3fDX3rWI82"
Content-Disposition: inline
In-Reply-To: <20260323-demonic-worthy-guillemot-c2abb8-mkl@pengutronix.de>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-227957-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 9A6FD2F11A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--xZzs3D3fDX3rWI82
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:00:59PM +0100, Marc Kleine-Budde wrote:
> On 23.03.2026 11:49:44, Johan Hovold wrote:
> > The SPI subsystem frees the controller and any subsystem allocated
> > driver data as part of deregistration (unless the allocation is device
> > managed).
> >
> > Take another reference before deregistering the controller so that the
> > driver data is not freed until the driver is done with it.
>=20
> Would re-ordering the spi_imx_remove() function be an alternative fix?
> I.e. call spi_unregister_controller() last?

No, the controller needs to be deregistered before disabling clocks and
releasing other resources.

Johan

--xZzs3D3fDX3rWI82
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCacEh5RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQC8XNwux9ZQjVngD/UJ9xqbLQsffC0D42O4yV
kcZDv4KQf38+ROZgn2yfN7MBAPnjStlo1chLbY+9ifpvKfekxDp+6umoSkSbe9ab
HrcE
=+OZL
-----END PGP SIGNATURE-----

--xZzs3D3fDX3rWI82--

