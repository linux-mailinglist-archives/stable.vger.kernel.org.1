Return-Path: <stable+bounces-254859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMsLJQkpGGrneggAu9opvQ
	(envelope-from <stable+bounces-254859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:37:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167045F1613
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E0E53038A7B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15136389E1F;
	Thu, 28 May 2026 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UwZ15KgD"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232519D093
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968008; cv=none; b=EL/CeG1CdbXmWNZAITOQBQz5d62D9ykL3WakjG7RncYv9qLRQ52uZDDtY25myzZx/bKXJQ0Q6PT9RcGqePlulJ8XYdqC7XfJqH3psnoKQwy3azZQ2myP1/4NuMKlVQWHZ0MAcNgVbj9oHfvjaYUmgSasb89bYHJEu53z7xjC8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968008; c=relaxed/simple;
	bh=hI3h7BS2acOHnkxwL+8YYp6p9bPxSTNauOz6ZP5ti7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCmNyVTOcNvgnqhWDRiI5DUy1XdCFeLaRqSG6fbzCzMyfoaMQ5li+AAtzyZrHDW+W+PUTzHj2ImHGzF/nAUwsvfPdGwPHY/zPhKu+9ArXq5Inbf7aiw3kBmQEOBawvacGU127J5ZZ8GGkb2SHgqHNYOx3c2n4QyM2sxa2z6fOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UwZ15KgD; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oD3gMH16VPtaCsGD/mjmikL+r5Tt3zPpkAamACesS9g=; b=UwZ15KgDuAg6tw0cL3r6ga0a2N
	Ep9oQfN+ASrHWVOitnwNO1bfF1/QGyAORSsN2YwmIuYUANK9s4oFn/oEc+zbU13+YO39rK/wUBhNn
	J7R87d1zgA2fENzrFqrLWQ7928dRcvhC/TVRY2Igd2COktlrvHw6BA6LI5nk2INAciTTlZ7GZLCyg
	en70wZusw04i/1Ri4G91XNFFzzcgfggzWipnXK0myinm1//f5pJJxahaQ27rXlogKKjg8QITWGqc/
	yD3Pr5snWB7OPoNk+/ybwQKUKl9Zf1glEG0mf4mC+x7NnrAcaX0SCe9G/+6R5ujut1pwbLCKFQVM2
	DKdS5A6g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYzB-0040Ci-1Q;
	Thu, 28 May 2026 11:33:13 +0000
Date: Thu, 28 May 2026 13:33:11 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Subject: [PATCH 5.15] selftests: forwarding: lib: Add helpers for checksum
 handling
Message-ID: <ahgn9yc4SFsqMAWq@decadent.org.uk>
References: <20260228181736.1605592-142-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtqXDgqclN/C9Njm"
Content-Disposition: inline
In-Reply-To: <20260228181736.1605592-142-sashal@kernel.org>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254859-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,decadent.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email]
X-Rspamd-Queue-Id: 167045F1613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--jtqXDgqclN/C9Njm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Petr Machata <petrm@nvidia.com>

commit 952e0ee38c7215c45192d8c899acd1830873f28b upstream.

In order to generate IGMPv3 and MLDv2 packets on the fly, we will need
helpers to calculate the packet checksum.

The approach presented in this patch revolves around payload templates
for mausezahn. These are mausezahn-like payload strings (01:23:45:...)
with possibly one 2-byte sequence replaced with the word PAYLOAD. The
main function is payload_template_calc_checksum(), which calculates
RFC 1071 checksum of the message. There are further helpers to then
convert the checksum to the payload format, and to expand it.

For IPv6, MLDv2 message checksum is computed using a pseudoheader that
differs from the header used in the payload itself. The fact that the
two messages are different means that the checksum needs to be
returned as a separate quantity, instead of being expanded in-place in
the payload itself. Furthermore, the pseudoheader includes a length of
the message. Much like the checksum, this needs to be expanded in
mausezahn format. And likewise for number of addresses for (S,G)
entries. Thus we have several places where a computed quantity needs
to be presented in the payload format. Add a helper u16_to_bytes(),
which will be used in all these cases.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 02cb2e6bacbb ("selftests: forwarding: vxlan_bridge_1d: fix t=
est failure with br_netfilter enabled")
[bwh: Backported to 5.15: adjust context]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/=
selftests/net/forwarding/lib.sh
index 83e8f9466d62..c570d8f65a0c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1491,3 +1491,59 @@ brmcast_check_sg_state()
 		check_err_fail $should_fail $? "Entry $src has blocked flag"
 	done
 }
+
+u16_to_bytes()
+{
+	local u16=3D$1; shift
+
+	printf "%04x" $u16 | sed 's/^/000/;s/^.*\(..\)\(..\)$/\1:\2/'
+}
+
+# Given a mausezahn-formatted payload (colon-separated bytes given as %02x=
),
+# possibly with a keyword CHECKSUM stashed where a 16-bit checksum should =
be,
+# calculate checksum as per RFC 1071, assuming the CHECKSUM field (if any)
+# stands for 00:00.
+payload_template_calc_checksum()
+{
+	local payload=3D$1; shift
+
+	(
+	    # Set input radix.
+	    echo "16i"
+	    # Push zero for the initial checksum.
+	    echo 0
+
+	    # Pad the payload with a terminating 00: in case we get an odd
+	    # number of bytes.
+	    echo "${payload%:}:00:" |
+		sed 's/CHECKSUM/00:00/g' |
+		tr '[:lower:]' '[:upper:]' |
+		# Add the word to the checksum.
+		sed 's/\(..\):\(..\):/\1\2+\n/g' |
+		# Strip the extra odd byte we pushed if left unconverted.
+		sed 's/\(..\):$//'
+
+	    echo "10000 ~ +"	# Calculate and add carry.
+	    echo "FFFF r - p"	# Bit-flip and print.
+	) |
+	    dc |
+	    tr '[:upper:]' '[:lower:]'
+}
+
+payload_template_expand_checksum()
+{
+	local payload=3D$1; shift
+	local checksum=3D$1; shift
+
+	local ckbytes=3D$(u16_to_bytes $checksum)
+
+	echo "$payload" | sed "s/CHECKSUM/$ckbytes/g"
+}
+
+payload_template_nbytes()
+{
+	local payload=3D$1; shift
+
+	payload_template_expand_checksum "${payload%:}" 0 |
+		sed 's/:/\n/g' | wc -l
+}

--jtqXDgqclN/C9Njm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYJ/cACgkQ57/I7JWG
EQkfiw/+Mafy6Y8Ohu44eKo5EBh8ILsltSjLzIUoJuyDKpvBsSssFeBwB41TN2dV
k/xbFxgr4laNn4MfcXRQdFUZWcxh/HC24xWOXqYXu8nFNF1WgeI5QFaGc1AQvaZG
oyPOsnLfsULpn3hpxs4rpOD1mieO38KVw+nBbhYjOIAjjBet7gaB+kGczs+bVh0a
csO5hfHWRhb4mB901mtjZ0cEItzjyvISVvVdOAin82xB2hKohBhJylWUhW3cGO5M
4LMx6LEw7x9/hT8DmSeO+V2pQDCvgCYezomGWKnv8VY6ukcXAhEAN0DNqYFmU3Al
L5FHrqeOOTHtmy70nz8EwSQIjVSj4b9m1QtYCaTL3cN+b1iLBAslo6n9ISBQ9rPY
Vz+IKUL6P/68mLnH2J4ysnqhQ556eEUbOQ0OYuqNwTTCSm8RK0+2aqkp/lrTYaN/
JzD+KX+O/uvwgqEgZPd4pCQdyw05ZRvPiZO5VCheVxvZgeO7KTNfOu1UaTQ7gkZQ
UO5+VB5imncrpUIbpvLJ0yS3z4vELPVuwK3hdyGeDSyVJ3/VLlpdyoPBZTOXs2jS
2buZ5KROSdsMHYSh62Ts+ymytUEO9K4FnmPPsGHHkNwXq0jBihXLjr4BkvlJ6/+Y
IJE55FKMFCS5tTwyCN/GX4ioW21CXvQ2aAUMFIo4G5PgyNCOhAo=
=0eJ+
-----END PGP SIGNATURE-----

--jtqXDgqclN/C9Njm--

