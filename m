Return-Path: <stable+bounces-254860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O8qCxooGGrneggAu9opvQ
	(envelope-from <stable+bounces-254860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:33:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E69785F153E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8E4830058E0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8E3E0C5E;
	Thu, 28 May 2026 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JxrRc4P/"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37B3BE653
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968021; cv=none; b=WN2U+lZ438SPjVQleFAw+edR7D+GXLAHIKJaJHjMz0uCJNX48Vq1eGVjzQJrAdfp/sQJz1dxtHrHVrQFAkSHdHPXTMr9g/SJ9fuKZQQ/swE83yDXEC4+b7dZMidFG0gxdh/ZqIDgms29T90V0dWn8WG9M6b714nC5f1QSnjcdmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968021; c=relaxed/simple;
	bh=5cHrnLfEd4OH10ypOjiMmfYW0DUko0fsm3xo+I3Mjo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLEQWhqjFlXpn+HPjxH5iLcq4iYNccRM0L99AYb6t2cULQKms1kTXQNq9vt+CPCLgVFCTUyMfHnPKALOQneOOBOrl8kVPRiIpOsrgO37blmjB499vII1WLiB6L0n7EQvMmROjq9RhcZmoB2/ecIICfgfa9J5YFtZHuNuO7Wz3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JxrRc4P/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RHfhuMGyISOZsafGiURTWmETfGFg8UMVVzg53tOcbEQ=; b=JxrRc4P/ipqFMR7xQy+1FB8FNl
	hv59Iy45ZNV7vyalIKF35N2MBIww6U6YPlVq+vL78ZdzAXOEC8F6cpMV3W1jwn3yjnWvIwCL6vBqz
	4TfCEGETHP/KGVYlKe0qm6WaeG5DNkw/e6lReGcF+YmEUUpx8fVwvvkyNffKQeqEm4RXJODozmrtE
	mGuqH3wXF9mxaHIEDgMl2qXW/vA2w4w/W+Y9Mpph43G/jhb/31RI9D+O+i9mpYjYMC5egh6gRM5wO
	Kcs7SVFoe94d/FH1MbKSYhg8j+WM8dL9qheKckCUp/L8hsZjXNgyeBsuBxK5zRqw9CBqitreb/R0w
	g1N3u9gg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYzX-0040Cy-1R;
	Thu, 28 May 2026 11:33:35 +0000
Date: Thu, 28 May 2026 13:33:34 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Subject: [PATCH 6.1] selftests: forwarding: lib: Add helpers for checksum
 handling
Message-ID: <ahgoDv7vIhnWbeGJ@decadent.org.uk>
References: <20260228181736.1605592-142-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KGCmL6LMOWLnxIEh"
Content-Disposition: inline
In-Reply-To: <20260228181736.1605592-142-sashal@kernel.org>
X-Debian-User: benh
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254860-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benh@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,decadent.org.uk:mid,nvidia.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: E69785F153E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--KGCmL6LMOWLnxIEh
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
[bwh: Backported to 6,1: adjust context]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/=
selftests/net/forwarding/lib.sh
index 06027772cf79..48d913341af2 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1701,3 +1701,59 @@ hw_stats_monitor_test()
=20
 	log_test "${type}_stats notifications"
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

--KGCmL6LMOWLnxIEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYKA0ACgkQ57/I7JWG
EQnvhQ/8Cd6CyQWZ6GU8cBukVvUHlUhn5V6SsnFDaqiIvdBpFdi1mkNNN91gedvH
Er3vA3dJknBAsc/RcGjyxKoNj8Hf/EIIE4hJF/Hfogw8RD2i9OgSyEuUc3J+PlQq
ITX5uBr6Xu/ufpha9XoCqGz4mxex8mq3fUsuWDKvIN89oBnFQdGzcghgnV1T8Jog
Jajc2a87LjvO2wag/G8E3zF0S1bol6xF5PudZMAC+ljp9qFiADqeUVnZFYjPg7GL
9C13dAOtoFIFzL7rgJpe19wymnK9DZ0zevLKgRx7oaoaJVeGKZZjkdnT4RWGUE6x
Ug5y5Kr60fI79zoR9uCfqdYhSIQ4X9g9U42/Dlktml+ttdXctSX6WNHr0jyGS7uh
xBDqVkRY/nx3ZCMMfzhs4M9nayCUIi5CU8UMR39E+NuVZI+H7zJYyaymDmhr4VD7
esB5GumhlIlKKad9j7rgnxQCTKIAnQ1rOMndMNREtlqVOjRFZPJUsBJeby/cU3nS
P3vXQrHX9KoPOA4kYzU+e0UhjcyyA7CO380qciXDKCBeoqDHaYFD85XMLW/DAvMU
3L/mRpU5cFEXAvQ4J28bHJHXE6lFFcumdrcA4nJiSnFY1Z1AEMa4Izy1Zk/mpCxI
Ma59frDqFcZQ2Woy2AFUGx/TWxdyphTaRPx3MFyl6TUO+SrCTb8=
=KKXz
-----END PGP SIGNATURE-----

--KGCmL6LMOWLnxIEh--

