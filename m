Return-Path: <stable+bounces-224905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iENuFlgAs2mQRQAAu9opvQ
	(envelope-from <stable+bounces-224905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:05:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D03BF276FAB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0473E320B56B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598733E347;
	Thu, 12 Mar 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbxDsa/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD732BE043;
	Thu, 12 Mar 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338488; cv=none; b=SEIlDsvsn6kvcOR7j1jVAWKU1sGHgKJiHpm8RL4XTScMmaPPVNUVo3MMcj2+KjPSbnwaxxpwqTR/0NHvYYoUL7aynyda8+77n+tWzpWLBqPtO4PXSYaa2/RHm4UCx2KkqRFQHy1vHxg4zBlVOb9GYRS95F7C5aBx3b5rYA0nz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338488; c=relaxed/simple;
	bh=OSzRLFN/O+oARU9QCcrSlaMvdDHHRKYudUhwaCmYKXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldGZh3QiFVYiMeAEZOPOIIgCqiRuXi8r9II6Rh6PtIw+43hh21p+L2OsTUD+paMqI3hvf55BRHGGw7E1DOVX0xqS/L86wxfzbJYQBISNYEDn5bdSdibLIITTTDY2IYTtmz/yI/5TNua9BhZxFGkdc/oYX2P2qMLuNTR/FpikgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbxDsa/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F50EC4CEF7;
	Thu, 12 Mar 2026 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773338487;
	bh=OSzRLFN/O+oARU9QCcrSlaMvdDHHRKYudUhwaCmYKXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbxDsa/82t2/tn++3U6n4t9JBwfH7xOxwADsSHdTwaLtwVMbaUAX46M2Iy5W4GPvK
	 dt8PGdQ87WZdrPiZuriIs6z5NON1/8E8BxMTxbE6B3xDUF6pS264nmMPpw/NU9mvBp
	 jFujHHl2YyKAwTUIms6oKi+R5Pe3EHSD7qpe+/XBY1imLYzBMx5viJtoya7OEEF6Ve
	 8KaKOlqWKaiKY4yRZlGKXuHx9Vl7ThQVfsOXVfv2OopMXa/rLWKNgaTW1QvZcuGmGG
	 7t4XOJ6UDhYONWh7dLLyYoBKDoWcbJaweE90phlYZ66IGf23MZiT9zoNA7DppO+Xe2
	 E/i7zBZfdqcVg==
Date: Thu, 12 Mar 2026 18:01:24 +0000
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: microchip: fail auto-update probe if no
 flash found
Message-ID: <20260312-distress-figure-e05517910026@spud>
References: <20260303-emphatic-roundness-8fe5cd8c3159@spud>
 <20260310-gyration-smasher-1eb31125b2b6@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DKurcfiHx8r5qs5K"
Content-Disposition: inline
In-Reply-To: <20260310-gyration-smasher-1eb31125b2b6@spud>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224905-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D03BF276FAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--DKurcfiHx8r5qs5K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 06:24:11PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> On Tue, 03 Mar 2026 11:24:06 +0000, Conor Dooley wrote:
> > There's no point letting the driver probe if there is no flash, as
> > trying to do a firmware upload will fail. Move the code that attempts
> > to get the flash from firmware upload to probe, and let it emit a
> > message to users stating why auto-update is not supported.
> > The code currently could have a problem if there's a flash in
> > devicetree, but the system controller driver fails to get a pointer to
> > it from the mtd subsystem, which will cause
> > mpfs_sys_controller_get_flash() to return an error. Check for errors and
> > null, instead of just null, in the new clause.
> >=20
> > [...]
>=20
> Applied to riscv-soc-fixes, thanks!
>=20
> [1/1] firmware: microchip: fail auto-update probe if no flash found
>       https://git.kernel.org/conor/c/c30b2509164f

My CI started whinging about this..
Probably needs to be:
commit 8fc167b47d48d3653639d026cc3f657f6c78ab4d
Author: Conor Dooley <conor.dooley@microchip.com>
Date:   Thu Mar 12 18:00:01 2026 +0000

    firmware: microchip: auto-update: silence error print when flash not fo=
und
   =20
    Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmwa=
re/microchip/mpfs-auto-update.c
index 0105c55ed7f37..8fc3749d4a709 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -424,9 +424,10 @@ static int mpfs_auto_update_probe(struct platform_devi=
ce *pdev)
 				     "Could not register as a sub device of the system controller\n");
=20
 	priv->flash =3D mpfs_sys_controller_get_flash(priv->sys_controller);
-	if (IS_ERR_OR_NULL(priv->flash))
-		return dev_err_probe(dev, -ENODEV,
-				     "No flash connected to the system controller, auto-update not sup=
ported\n");
+	if (IS_ERR_OR_NULL(priv->flash)) {
+		dev_dbg(dev, "No flash connected to the system controller, auto-update n=
ot supported\n");
+		return -ENODEV;
+	}
=20
 	priv->dev =3D dev;
 	platform_set_drvdata(pdev, priv);


--DKurcfiHx8r5qs5K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabL/dAAKCRB4tDGHoIJi
0nIFAQCsTwy1NI0n231g4yLIMo9S2hTDrZiTE2HbmorJLJkLAQEAprS2DQKLze43
jHIP7MAm39UKt8Kf06T8nwfZXfNrBAU=
=yvGr
-----END PGP SIGNATURE-----

--DKurcfiHx8r5qs5K--

