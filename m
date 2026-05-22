Return-Path: <stable+bounces-253823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GakFuubEGpuawYAu9opvQ
	(envelope-from <stable+bounces-253823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:09:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 560565B8D76
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 737C630418E4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD0349CEC;
	Fri, 22 May 2026 17:48:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547702110E
	for <stable@vger.kernel.org>; Fri, 22 May 2026 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472129; cv=none; b=R8vg+frw2WgjSX033rdS6uigNDKx8EMrC5nLMjLIpJ/sRaFwfXHlZBWaGPVQfrygMNm2WHDKG9gJ1oWeZigfe1LfD+aU10SFAtSkQVMRO0vKQxQbuiw4RYIDlbmqGUZNpBFkEZkz804XDPkqE6fUu3pyioGFwYdM1PM/gmjLkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472129; c=relaxed/simple;
	bh=YwoEY9qFWX03GTWi119w0KN27TZolZw4zXrjKGDu6Qc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=VXGMsEvVuHsxAnCZ+bdpEP2N60z52WhynTrH1/F1o95a/Vz5UUf8zD89DIu+J6KoTN6ShRx2WE+eGWOQEnvnia0kHJft7mjRRzPoPrM9rebFUF1ddnZLUO1500FlWElrEmsHtbGQR+vSBqmMaNvI0wwGIgI0wYjclYGHzZL02wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wQTZB-001a3v-1b;
	Fri, 22 May 2026 17:21:44 +0000
Received: from ben by deadeye with local (Exim 4.99.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1wQTZA-00000002IfJ-031I;
	Fri, 22 May 2026 19:21:44 +0200
Message-ID: <a785911d711bee40be215dad119f9922e014aead.camel@decadent.org.uk>
Subject: [6.6] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
From: Ben Hutchings <ben@decadent.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>
Date: Fri, 22 May 2026 19:21:39 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0UhKTOYY0J9kInWMWv0+"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253823-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DMARC_NA(0.00)[decadent.org.uk];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben@decadent.org.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 560565B8D76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-0UhKTOYY0J9kInWMWv0+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I looked at the backport of commit 8f6a5356a33 queued for 6.6, and it's
not quite right.  The change that is supposed to be applied at the end
of skb_gro_receive_list() is wrongly being applied at the end of
skb_gro_receive() in the backport.

In 6.6 the skb_gro_receive_list() function does exist and it seems like
the same change should be applied, but the function is in
net/ipv4/udp_offload.c and not net/core/gro.c.

Ben.

--=20
Ben Hutchings
Larkinson's Law: All laws are basically false.

--=-0UhKTOYY0J9kInWMWv0+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoQkKMACgkQ57/I7JWG
EQk+IA/8DKXuf3BdZSUN2Wnwg1SUnbyZxKt4ETJUKKVOhoAI10hmvD2CdpNO5Uc0
mP4v8lncx13hoZV9kqiJ8krfqIY4bG1rWjgM1qiPjvjjCk5or6sU+HfpAVYbXaWb
xNW3BYyF9fmUYhnMJVnHhW1PZ10el/c60XxbK7SEz16Qemn349Ztg0E+C31cQ8Nl
cjwDJdMCo6mv4OxilflSOaOCM6NJeFKlK8dcSxqV4Mogc3rwmtymhMEJLUTxr4v7
POo6aVLQwFrgLyVDKeot53KqRW/p12ZjlbKIoxNjCFUdNcfskEhqGn+1yGEYyKLe
jX1D34JzL74EktlBNPsBbDu/HQRNNU1CpZAZlR1/v9wToDeS55bAx5BxlFdeT7+2
2qAm/HaFSLoYq68jvL5JVWP0Dcdo0627dZsIxNk51eJZj9HmS+S0ssWDIuyYCnG3
yqd1fGTqv8g0dpqDpAOwKVP3CzYmHNdXj2pqwNjHbEdeaFKwoG9l9WhH3h7pn1Ea
T0IjMwMf1Y4Ea3aKevhSWlh5hTqdGLybOW03dfy32FNbTkIw+FKgVsav2+SlKBhy
4gRwCzvd63Tle7gpAPrrSLtCd47WzwvNboHx4AhA2+dn0Xl4rfYSniZAJ5ogvjw9
XI+Xjjf40xw3GmOZSXVIOYRfUYqJRDpFeXYkxOfWfdXkNz3kB3I=
=/+2z
-----END PGP SIGNATURE-----

--=-0UhKTOYY0J9kInWMWv0+--

