Return-Path: <stable+bounces-254978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPlMFHc/GGqahwgAu9opvQ
	(envelope-from <stable+bounces-254978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:13:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF01F5F287F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D96304E0F7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3A23D4133;
	Thu, 28 May 2026 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="A0belgQQ"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC93E3C76
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973688; cv=none; b=JIXihNxpzGNCcmqU+c/ZGHEbgKSUD5IRZ5xKvo/4nJ8BAemMxGSHSn1YrWacbeHbhrABZ0e5HLM19rxZj2d0uHD4P7hoWRmRkiQGTSzmCWH0sPDIK/+8v+2kkRsn/2qPjI58AOKLIKLcIIReSEDnSSGcnFq+ze4LXAaFVMjOj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973688; c=relaxed/simple;
	bh=U5FzoB7musyFQqaPEjNF1/UUXBLzRb3OJ43kcBzZ+yo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JAvRkIAgFrCbTu5DvcmvkOiYeog3slyn07thpHv53QbhgZBoROefkuw+Xs6OO2cbTwu0ATklDSyDLijPX71NuYhR1SyThmXDLzv6XWTN+Ul1NuRzNEga3LTh8tfSQhMHKGUfKUKblIc3EZwycpqsuaUqyZmbwrwVCfcqDGpIc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=A0belgQQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=4awUi+FK7z/5xriki3bh3p0U6E0KCZYG8Smwp+Ve1Gk=; b=A0belgQQfK0O+sgHy4JjrRi6kX
	K9Tx/RI/VzzD6BafbSoehBNjkwn9KNYc+IWwh9jLkQzx1YM/6qJC9XFnFv+872ZybqJDWchSSeyO4
	1XLS4Jq/eJlvY2Tw5NPPg4Fp2zWkuaome8QiiwwzDmVyqYr/h5m/EB02Ze63ItwXaCB8TQo7SxE0d
	CW6WBZd1rfOclNauWaIrKVwsgEf5dDGjA8Fdv11ny8DisQBeFoZzd9nUg/+C6IuO4jGV+Z9CrOB7y
	nsAeP11JnyHpKfmHViEhPD51k1Q7cUlHcJ7Lz55+lS6yUmY8IFlwwi4W1BOtRzrMmhBh/BxXiYZ3k
	0gZs38iQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSaSu-0043mU-0v;
	Thu, 28 May 2026 13:08:00 +0000
Date: Thu, 28 May 2026 15:07:58 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 5.10] phy: renesas: rcar-gen3-usb2: Fix msleep() in atomic
 context
Message-ID: <ahg-Lvu0ywzUT9mZ@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IMNzU06fJPSmfjL2"
Content-Disposition: inline
In-Reply-To: <d5dde03f796af3efcdabcbadb604e8981268ae5c.camel@decadent.org.uk>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254978-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,decadent.org.uk:mid]
X-Rspamd-Queue-Id: AF01F5F287F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--IMNzU06fJPSmfjL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The backport of commit 55a387ebb921 "phy: renesas: rcar-gen3-usb2:
Lock around hardware registers and driver data" to 5.10 was not quite
right.  The upstream version converted an msleep() call to mdelay() in
rcar_gen3_init_otg(), which now runs in atomic context, but this
change was missing from the backport.  Fix that.

Fixes: 0f86a559900f ("phy: renesas: rcar-gen3-usb2: Lock around hardware re=
gisters and driver data")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas=
/phy-rcar-gen3-usb2.c
index 5166a115879e..90f2a0e5b2aa 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -386,7 +386,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *c=
h)
 	val =3D readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
=20
-	msleep(20);
+	mdelay(20);
=20
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);

--IMNzU06fJPSmfjL2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYPioACgkQ57/I7JWG
EQl1sQ//cgAdvRQgQguS/CyXcs42Og2rmDNmg5Ej2sIQjhHYRZG7Unoh7L2ERL9D
c6B2fahPVB0DjGCFOA1Z5UGJyACbl/sYAOePXn8u6gdPd5g98hursotDBp/kdIqA
i8J4j/HttUmI+W/ePUsm8An8Qb8lPsCBnL95O551oHGVgG0Qi/cf3h764Ob7hYi1
C0I3Tat23j4+CBdNytEkzIwaQBg6i8Ybu7gnWZ8lkdFzjVUZCzLjolu8w/kUMxyH
uqwF81HSuiUHwetiv+W63GTtUWvpEyAM6wLdKlQNocBnfgofcJpk6zG3H9fzXFEP
yTzpcnrY2Smam82MBRnQ5S3CJFVJTPwGp/BAPQxnzsnnCCBp8f3kRxYGu7RiY7/N
tm+djwnNCQkiggvDPoRtGFS4Ofdv/WTAZLP5g/4ORonTmspcYzHppHBkha/MNk0J
HsF4vFUs2vHLwIOW0bjKETJef/CEySgGoYC7TGeTejGpyVg1OzOxoQTOPmblJDvK
Nqvagom6BsbaAltdPlfA5hgROx5TNRcJsJlU+VPVe/A+0vbZIQYEJyxufuk+u+/v
rq2cjIfPy+oHgk6BqDTLXAf9JKtFTVe7yqw1niw6KqQGHOQsQPe5cPW5WjRtJEWA
JTbG3SL5z6oY0fwYaYjfr5M/8ubs7A3H7KuEWQ9P13rzQWbZY2M=
=bhQt
-----END PGP SIGNATURE-----

--IMNzU06fJPSmfjL2--

