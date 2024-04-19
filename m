Return-Path: <stable+bounces-40310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40C28AB337
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222321C20912
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 16:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6EC1327EC;
	Fri, 19 Apr 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b="LBEbeLZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out.a16n.net (smtp-out.a16n.net [87.98.181.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9206130E4F;
	Fri, 19 Apr 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.181.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543487; cv=none; b=NhNZ8Whh1iOCvcBZtd/2W5P9PXzQukoYzJwCZVK9S88NW8YeuUkb9diPAV5gzNlmWt1TkgPBC/SVZHmgERFXX+2f7G9Zc/g9IyrcQ70JvmJO8KguaoMRGNK4/OQosirkj2xBj3Py3MfVmz2eE5CAi8MTA3oiheYiM7zkDmVC2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543487; c=relaxed/simple;
	bh=Rcg/4O1A9uKCuNadXucsbBu9FuV6I1CCOfD83WpZN04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MrPSRjylxs8aNGecOgiKsc/4jX9VLyXrfu2hkJLvl4v9soqcU2kLwBEzprjuegvT18oUqKZzglzXR9RqXgzdAmpAjIBOITuLoPugfuq8CWKttG1pEkYob3uU3nMFm25Vr1cy1E0o/GosWQhr1ukm6WnmNTKl4YLitkaJq9V8p2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net; spf=pass smtp.mailfrom=a16n.net; dkim=pass (2048-bit key) header.d=a16n.net header.i=@a16n.net header.b=LBEbeLZg; arc=none smtp.client-ip=87.98.181.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=a16n.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a16n.net
Received: from server.a16n.net (server.a16n.net [82.65.98.121])
	by smtp-out.a16n.net (Postfix) with ESMTP id E7B69460567;
	Fri, 19 Apr 2024 18:17:47 +0200 (CEST)
Received: from ws.localdomain (unknown [192.168.13.254])
	by server.a16n.net (Postfix) with ESMTPSA id 0EE7880105E;
	Fri, 19 Apr 2024 18:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a16n.net; s=a16n;
	t=1713543468; bh=+UZZtAwCL23Ar3uMWUNZyNfVNCG9S/hYoySIwbZwiVI=;
	h=From:To:Cc:Subject:Date;
	b=LBEbeLZghWz9xhllGCeTwaR/+bOcJE9WEq639c7V+SZDpGnVej22RTwyJ2eaLKA+M
	 7mgb12HNN8LNwtvTRseqwcT90XZu/VqyJhdgehD4NoC+A/8OOe64breBV8n6kDgkVz
	 YnZNgeMfymX1So6qDeT28V7dOv5V6Mbxqn9qWEk8t8HOmB+RMixEMg+vI2Dg9bKs+E
	 kNVyv6dwaJPbnX0fGbCFlNfxi2u2JEwSzVeCAaKOUTGMrSuuMd+owEZLQKbB5zz9EE
	 3qzCsh24L3z3loVcSLLRcTbxjPOiy1lVE8+3mSoL9fJf+2lYx65oeZVDy1pViXQQlb
	 rRw3naip054WA==
Received: by ws.localdomain (Postfix, from userid 1000)
	id DFBAD20682; Fri, 19 Apr 2024 18:17:47 +0200 (CEST)
From: =?utf-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net v2] net: b44: set pause params only when interface is up
Date: Fri, 19 Apr 2024 18:17:47 +0200
Message-ID: <875xwd1g44.fsf@a16n.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

This patch fixes a kernel panic when using netifd.
Could you please apply it also to linux-5.15.y at least?

TIA and kind regards,
=2D-=20
           Peter

--=-=-=
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: inline;
 filename=0001-net-b44-set-pause-params-only-when-interface-is-up.patch
Content-Transfer-Encoding: quoted-printable

b44_free_rings() accesses b44::rx_buffers (and ::tx_buffers)
unconditionally, but b44::rx_buffers is only valid when the
device is up (they get allocated in b44_open(), and deallocated
again in b44_close()), any other time these is just a NULL pointers.

So if you try to change the pause params while the network interface
is disabled/administratively down, everything explodes (which likely
netifd tries to do).

Link: https://github.com/openwrt/openwrt/issues/13789
Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)
Reported-by: Peter M=C3=BCnster <pm@a16n.net>
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Vaclav Svoboda <svoboda@neng.cz>
Tested-by: Peter M=C3=BCnster <pm@a16n.net>
Signed-off-by: Peter M=C3=BCnster <pm@a16n.net>
=2D--
 drivers/net/ethernet/broadcom/b44.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/bro=
adcom/b44.c
index 3e4fb3c3e834..1be6d14030bc 100644
=2D-- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2009,12 +2009,14 @@ static int b44_set_pauseparam(struct net_device *de=
v,
 		bp->flags |=3D B44_FLAG_TX_PAUSE;
 	else
 		bp->flags &=3D ~B44_FLAG_TX_PAUSE;
=2D	if (bp->flags & B44_FLAG_PAUSE_AUTO) {
=2D		b44_halt(bp);
=2D		b44_init_rings(bp);
=2D		b44_init_hw(bp, B44_FULL_RESET);
=2D	} else {
=2D		__b44_set_flow_ctrl(bp, bp->flags);
+	if (netif_running(dev)) {
+		if (bp->flags & B44_FLAG_PAUSE_AUTO) {
+			b44_halt(bp);
+			b44_init_rings(bp);
+			b44_init_hw(bp, B44_FULL_RESET);
+		} else {
+			__b44_set_flow_ctrl(bp, bp->flags);
+		}
 	}
 	spin_unlock_irq(&bp->lock);
=20
=2D-=20
2.35.3


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iGoEARECACoWIQS/5hHRBUjla4uZVXU6jitvQ7HLaAUCZiKZKwwccG1AYTE2bi5u
ZXQACgkQOo4rb0Oxy2iZiACg0go5ovemuI35J9R0fbyuCvesuEQAnRyAfT0Yq26d
P0fMGyjgrQGsQ9gs
=xlbt
-----END PGP SIGNATURE-----
--==-=-=--

