Return-Path: <stable+bounces-254857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCjBK7wnGGqZeQgAu9opvQ
	(envelope-from <stable+bounces-254857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:32:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2E5F1528
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BFA53033FB4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814B3E314B;
	Thu, 28 May 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DGZHyiKS"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49933B6ED
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967798; cv=none; b=SgAvuvuisdILEeO2JBsD87RyIiI30xTLR0MuzEKk0dMmvLqvx0OsmxpZyT0MsrxwaGtsPxNjdNhic4KercXjBHng3geP+ASp2OEsOw8RYGM09yJ5O+auKWPdBdDe6VMrrDT/MevMZlL8LRA84WTZUEvznGiuieswqC9T6QrXRm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967798; c=relaxed/simple;
	bh=d4/S7BBuqO7ARu857zJRHcGEXpCJo+9F77oQs8DM03c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbh8dkekThcVHgUdDJ7+wKe3aD8rED/zzgTbeBakBddTw7hKyuq5jmjA2OuGkvnE5TypiYBuNqPV2XouqfOHDR0OQy4n84n2/LfL8UpbRGFjc+0Ao6BbZ0mQZYAefEOaBCcab2R5KsSPdeO6TFpE8HnXN4bsAoiEClC5iDQDEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DGZHyiKS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kmjleUiy5g9QOKH2PrzgT0WA1c6fzqKHfVU/d9ZsNRw=; b=DGZHyiKSu9xUWPClHP1d6z/8QC
	cbXWRBw7nwYgFvQCA09bFLzV0n4LalqUOfhHBcO5NN3TaRCzdaaAGTTKnfnMbt0v6EOJte+r2lwir
	FzsPqE3wYdh7N3XxA3Kqyij+rkaTIJoXn36ywuQ+hdLKJbsI0l8BTZBX90C9wK1u0zapwf3MQjPTu
	7tvIQBTkT96IawhLLqegdLxwewS7zqX/8y5pTQETfQIEWJG/+QDGHVNILmjIRbGt8mxx+gU/E8a0D
	k9yGn2eSjBuW0rVdZbaCn31W2UVCPr4i80SVR8HBEjY+AzUCeqCNHOgKpwiwlrh/BZfQubnx9gXdQ
	JV+mbYOg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wSYvs-00407c-1v;
	Thu, 28 May 2026 11:29:48 +0000
Date: Thu, 28 May 2026 13:29:47 +0200
From: Ben Hutchings <benh@debian.org>
To: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
	Ido Schimmel <idosch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 5.10] selftests: forwarding: lib: Add helpers for checksum
 handling
Message-ID: <ahgnK2FarjRafL_J@decadent.org.uk>
References: <20260228181736.1605592-142-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PY1tJc6DmTlcx05L"
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
	TAGGED_FROM(0.00)[bounces-254857-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[decadent.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,blackwall.org:email,nvidia.com:email]
X-Rspamd-Queue-Id: 0DE2E5F1528
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--PY1tJc6DmTlcx05L
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
[bwh: Backported to 5.10: adjust context]
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/testing/selftests/net/forwarding/lib.sh | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/=
selftests/net/forwarding/lib.sh
index dfb41db7fbe4..2825c779ef30 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1298,3 +1298,59 @@ tcpdump_show()
 {
 	tcpdump -e -n -r $capfile 2>&1
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

--PY1tJc6DmTlcx05L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoYJyYACgkQ57/I7JWG
EQlFPQ//SMZsBynbLU397Y05ss9WGGSotS/HE/aXCvF4PYxdx1RxtufIS4uR8wYJ
hN9lN12BmUpzPiC/AEA0mi7XCzYl6bMMuJn+fpnHHgAd/ZBd04IETkOBAvIeZmzc
pC7FCyfl56RxTShDNMmxLComJ0VNomAblxHVhfC8HAZ8+Ivsw0TmGzG7Fetj1YmW
6OoiShGMMEfvd0vuXaB42bSsEWo0R3bD1Zq8kCrL0AVA6FGwBF/pxgfYxndgUqQd
2qcvJLLKL5Golm8uJyNgBsoMjoyEKGe7OaZCAxqfUIypRckU2OAG0LE0PjlUEa0K
wZjh43DVjm+yXlndLXYysAAVtXuJqBDytH2dO65/QOoRoyHla0idVgUFwwoDOZiw
5KodjaS65q4rxw246BpFf2rkWlY/XGiEEMqclwOxfMg5JsHQAGZC0UxoP23r8lPs
5DxvA5N1fNfP6JuLKauZdAntoWuvzFK5SvZgHeZpgibMm0d9Raj29hoNMAQ06Cms
dCSDWI/iLxY1Zh+Sb2uTkt+20lbQoYy+ZkQsMaOffkEJZ7mviWCH+dHRpXLGT2ZN
RzKaRPyv+ovDkJdYIffYMkhL7JEstYQUni2MoJUFts4DlCV6N+eFj4g+16fxj1+j
eIFWvPutFIOSYzGkteForpRNHkBpPKgFkppsd7EvVdknIquTejk=
=t1Zq
-----END PGP SIGNATURE-----

--PY1tJc6DmTlcx05L--

