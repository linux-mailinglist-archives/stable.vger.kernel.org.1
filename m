Return-Path: <stable+bounces-214518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPBIIMbOhGk45QMAu9opvQ
	(envelope-from <stable+bounces-214518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:09:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A2F5ADD
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54C5302AC20
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5843901D;
	Thu,  5 Feb 2026 17:05:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA3122339;
	Thu,  5 Feb 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311106; cv=none; b=uu1VUWKRHN8mNka0ISuYMYBMvRdMdpS0zSJP6ihD7jngrkSECuOQtNGGAbUpPNx1a2xB/M4NVKMo2IhZMFCPkO2HD2l7cBtL+k1Bi9L9xsUnwmlJ7oRragOsG98mgqVSDw6EfHdANGh+l7SXJHBnDcdQd+8rrilOlK9u7jJhJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311106; c=relaxed/simple;
	bh=yeo2wB04oGFPCgyn3vFEiz2R8Iukuc+Up7EtscG+zJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzcrnLsBcx/nuFi/iV32le8jLIQmqqrQgbBxvpNrQq+rXSTwCapOp3xGfl4xGK65PGt1XWgofbVKMgJSRZRqdFs8oVbl50nqOhMmYFgx0OjJ1QIbNJylahSuXCTt32l6LERCCSYuOmL7AU4uaFVnOp+fG+62u+08lu4MZMy+El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1vo2mu-003uwf-35;
	Thu, 05 Feb 2026 17:05:04 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1vo2ms-00000001gxP-47hH;
	Thu, 05 Feb 2026 18:05:02 +0100
Message-ID: <ec318a7c1b9a06836b8694a1b63e187d3f53bd80.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 050/161] selftests/net: convert fib-onlink-tests.sh
 to run it in unique namespace
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, David Ahern <dsahern@kernel.org>, Hangbin Liu
	 <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin
	 <sashal@kernel.org>
Date: Thu, 05 Feb 2026 18:04:57 +0100
In-Reply-To: <20260204143853.562371909@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
	 <20260204143853.562371909@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RivGEGcaunz9EBHkBTBK"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DMARC_NA(0.00)[decadent.org.uk];
	TAGGED_FROM(0.00)[bounces-214518-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:mid]
X-Rspamd-Queue-Id: DD0A2F5ADD
X-Rspamd-Action: no action


--=-RivGEGcaunz9EBHkBTBK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 15:38 +0100, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Hangbin Liu <liuhangbin@gmail.com>
>=20
> [ Upstream commit 3a06833b2adc0a902f2469ad4ce41ccd64f1f3ab ]
[...]
> Stable-dep-of: 4f5f148dd7c0 ("selftests: net: fib-onlink-tests: Convert t=
o use namespaces by default")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/selftests/net/fib-onlink-tests.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/test=
ing/selftests/net/fib-onlink-tests.sh
> index c287b90b8af80..ec2d6ceb1f08d 100755
> --- a/tools/testing/selftests/net/fib-onlink-tests.sh
> +++ b/tools/testing/selftests/net/fib-onlink-tests.sh
> @@ -3,6 +3,7 @@
> =20
>  # IPv4 and IPv6 onlink tests
> =20
> +source lib.sh
[...]

tools/testing/selftests/net/lib.sh doesn't exist in 5.10, so this can't
work.

Ben.

--=20
Ben Hutchings
Horngren's Observation:
              Among economists, the real world is often a special case.

--=-RivGEGcaunz9EBHkBTBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmmEzbkACgkQ57/I7JWG
EQnqtA/9FZb+WK5U6IEaPob+b4oC/gZnLdRPjTzqo5hRBWDupfRpFgjIfHyy9hzZ
tRKFCWCY7eqO1Fn+5YE0Q2jccDHWjKSMrTHivYBMca2SLa1hK+wCDKzmAjgV7wNu
+oskWgLOQwduoGSg1o/3CcW6yTkOaQWPOfqUGIjIPgfUTpMHxt3WYiaN3QDatwDp
h5+xdcN7mxnlfwgUkIkWnp8pXG3gTOAhfvBcGmOA7KfEqJO+9RWKF0qdF8CqXH4B
FoGhPsFEppvgEXtY0yl/QJrXEnvemsvQsMx79ICqV3ifdjkYu+cp9G9iVZqY2nS+
3Vk21TosqiyS6XuBx0XCPGvQayPHg45YkM9cP9zTPpCbjHvV/2CG0aENxFnC8tVW
Mk9hMXFFec4SxuBJtaR7gGB4CLxHAqrY70zK6e07xT2+dx8TT/uoUrwknW6/wVXW
yLVRDV3YPFE10x37sloWnqC4vYH5PApiIhajDM6hEycQFwxZEu2KKqRBSDFxcA1D
Au4LkQxEYFyPi/BlgvordThYIbrJn+kai13cBwPEGPICHVeeZUX8hwOrdPZOMpg7
qEIpB6H4LQcKLDcvinUQpY37iTBu7u0yl/HUtcksmNTYkD6tBEfwRRj6XtpEkYNJ
S4rX3DCj9U4RubZAVCUl5seGm0E7Z8liljXseDqD5TeBbYNynPM=
=5ofZ
-----END PGP SIGNATURE-----

--=-RivGEGcaunz9EBHkBTBK--

