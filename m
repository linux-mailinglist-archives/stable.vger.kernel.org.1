Return-Path: <stable+bounces-244257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCmmNVc7+mlZLAMAu9opvQ
	(envelope-from <stable+bounces-244257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:47:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE274D2DAA
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE5AF3054F4A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BAD4963B8;
	Tue,  5 May 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="i5f2hbyJ"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D34A341F
	for <stable@vger.kernel.org>; Tue,  5 May 2026 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006721; cv=none; b=l4GwbkFctERACyh1q1spkKOzDK+qHYWvnF7fbBHcuBabVO7IkKOwvBuiZ4Rw/NHrlu28os8/zRWa3Aosri19XvmnR1Yn04atyW9XN/kQT0ITkpMOq64qBGl92EyKR3r75Aa4rTEtWfZvqedtcRf8yJAbo1yD6I3AfGCi7o78Ryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006721; c=relaxed/simple;
	bh=iV+FqaZYkVuau7UWTy+Lf/bB2fwRC9oLeAYPXQzrm6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VEeMm4EFV65C1w/kJuqPfjv/BoLCbMvsqfR5g3VsLkK4lT4pAWKxY8lJmGTGMI2Nz9zyK1gds5xcZE9749ohBVegpAHPznIHTu33C58bECCb3q3TXwIG7ASbYE0rLMS6QkHObyADpb4uWsJLJuzv6GD7x6P3+D/HJgrHc2pEeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=i5f2hbyJ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NkdjHjbL3u13LXUCbwCMIAA14HpmA0Llm99NgW5sonE=; b=i5f2hbyJlUWvKZhSy0KlG8tsGn
	8ANEcNstJ9RlBgc5mbZjmaT3McHmLBVnI8Kmrr+Jq2LF7ypIug6N3juf614j7I/Oe/Fv+4i4HxgJY
	3+IFGX0uWtyXY4LQfSG8GTqVc5fu5nguBaAduU5mP44yA3KBQ0VWycgPWXqHf+J+pGmQqlC46+Rwf
	PF7BEYm9LwriDRKIZDxrnCMou7aZs3zBeUKjAy0hO/2C+P5Uuwx1x4KwTPgCuvM/0eInnQk8tSiYl
	wulAN7Hceh1s2TijpjooJH+SFp4jIOWuByv3dlBMkvb/ndgo02MOs7mi7Beo92MktPQSXzGYVgxVD
	uK0TUgsA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wKKld-0030ka-2H;
	Tue, 05 May 2026 18:45:14 +0000
Date: Tue, 5 May 2026 20:45:12 +0200
From: Ben Hutchings <benh@debian.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 1130365@bugs.debian.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org, linux-parport@lists.infradead.org
Subject: [PATCH] parport: Fix race between port and client registration
Message-ID: <afo6uBv68GDevbMD@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oFaP8Rm7b43qwgz2"
Content-Disposition: inline
X-Debian-User: benh
X-Rspamd-Queue-Id: 3AE274D2DAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244257-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]


--oFaP8Rm7b43qwgz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The parport subsystem registers port devices before they are fully
initialised, resulting in a race condition where client drivers such
as lp can attach to ports that are not completely initialised or even
being torn down.

When the port and client drivers are built as modules and loaded
around the same time during boot, this occasionally results in a
crash.  I was able to make this happen reliably in a VM with a
PC-style parallel port by patching parport_pc to fail probing:

> --- a/drivers/parport/parport_pc.c
> +++ b/drivers/parport/parport_pc.c
> @@ -2069,7 +2069,7 @@ static struct parport *__parport_pc_probe_port(unsi=
gned long int base,
>  	if (!p)
>  		goto out3;
>
> -	base_res =3D request_region(base, 3, p->name);
> +	base_res =3D NULL;
>  	if (!base_res)
>  		goto out4;
>

and then running:

    while true; do
        modprobe lp & modprobe parport_pc
	wait
	rmmod lp parport_pc
    done

for a few seconds.

In the long term I think port registration should be changed to put
the call to device_add() inside parport_announce_port(), but since the
latter currently cannot fail this will require changing all port
drivers.

For now, add a flag to indicate whether a port has been "announced"
and only try to attach client drivers to ports when the flag is set.

Fixes: 6fa45a226897 ("parport: add device-model to parport subsystem")
Closes: https://bugs.debian.org/1130365
Closes: https://lore.kernel.org/all/6ba903ad-9897-42bb-8c2d-337385cc3746@mo=
lgen.mpg.de/
Cc: stable@vger.kernel.org
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 drivers/parport/share.c | 11 +++++++++--
 include/linux/parport.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index ba5292828703..eb0977ca1605 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -214,10 +214,14 @@ static void get_lowlevel_driver(void)
 static int port_check(struct device *dev, void *dev_drv)
 {
 	struct parport_driver *drv =3D dev_drv;
+	struct parport *port;
=20
 	/* only send ports, do not send other devices connected to bus */
-	if (is_parport(dev))
-		drv->match_port(to_parport_dev(dev));
+	if (is_parport(dev)) {
+		port =3D to_parport_dev(dev);
+		if (test_bit(PARPORT_ANNOUNCED, &port->devflags))
+			drv->match_port(port);
+	}
 	return 0;
 }
=20
@@ -532,6 +536,7 @@ void parport_announce_port(struct parport *port)
 		if (slave)
 			attach_driver_chain(slave);
 	}
+	set_bit(PARPORT_ANNOUNCED, &port->devflags);
 	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(parport_announce_port);
@@ -561,6 +566,8 @@ void parport_remove_port(struct parport *port)
=20
 	mutex_lock(&registration_lock);
=20
+	clear_bit(PARPORT_ANNOUNCED, &port->devflags);
+
 	/* Spread the word. */
 	detach_driver_chain(port);
=20
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 464c2ad28039..f64cb0676e3b 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -240,6 +240,7 @@ struct parport {
=20
 	unsigned long devflags;
 #define PARPORT_DEVPROC_REGISTERED	0
+#define PARPORT_ANNOUNCED		1
 	struct pardevice *proc_device;	/* Currently register proc device */
=20
 	struct list_head full_list;

--oFaP8Rm7b43qwgz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmn6OrMACgkQ57/I7JWG
EQniyg/8DI/t3+V54LsZso7KV7VFI2qO5/U9uutYBkJYOMhj5wpB+kR/71ohenmk
EjhgWRpR3GIbJIN0s05byQ/OC4x8h32erkE1KUx0exOYu8KT908R1u0fBgHqCBvv
FV7dEwI+K3UxGO5vXy/9A6XrunutzCDX4q0sFi4KmZQEYKDjnT4JPzxu2JGaBu8r
/kKrBpbf2LeN82p+gD+gPrn2oYNxlCnQQcR00TiUQPI/JxjLWXPLqtWKF9tHjGRh
aPCCqb8Is+lsnDciVrqZPJiZ/EU+bKOmZdyK2G1SNXkrljbmOFbHAisLLu3dKHe2
WuyCJxCosscX5S9+0bsrb93MASHJl6DuvD0aiqNXYe+BnKSHy7FvomqvG/ip+txQ
4rEc0chyTFchuNgtHNVPsury3fQPsKI6t+T36uk5GXscyuG5etwwKn+beFokRUgm
WFwkhzRPyaSHBrAsu/0Uo63ROyMssVYpxd+cMpe+GS9f4jgZ2rbp2X8CHokJy5mV
jMtiKzTUvAbkfKEog5U8qH/1SImtzJaGlIbfZwvKjyLnntlBGk8Keg70isj5wR2G
Dy6xutqLb5GteAXzc1jCawn/DJnxFfexzF1aiU0i0nRWPf2j6LV5j5LL3lZVTL1k
TQn1ZK96QyYb0pz0njlSEr84AyWUZcbg7mCMqi64/5rwcSf1Bts=
=0DIu
-----END PGP SIGNATURE-----

--oFaP8Rm7b43qwgz2--

