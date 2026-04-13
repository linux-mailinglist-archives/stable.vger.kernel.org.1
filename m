Return-Path: <stable+bounces-235933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNEaMOOR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:49:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9E3E7EB8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24073012C7F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043231FC101;
	Mon, 13 Apr 2026 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bschu.de header.i=@bschu.de header.b="da6eBM9Z"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD632D063E;
	Mon, 13 Apr 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062930; cv=none; b=tCZOyKhpjBPxw7rM2Jt3K8aze7hrSMoFkF5A2JgENXip95v2l7dTFz7ChdL+fObWOJMT3PGOZn4QhNaBGrpuhN4DkQg/OPI66j3gH9/FyRXKqrIEuFUIc5ZeXcEk55aN12TQ/vEJJ3ZipNzfJDKSYmP1E4hxmCak3YIHkv/Xu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062930; c=relaxed/simple;
	bh=G00sfWvgnFmN1RJzoAP+P1viqnzTx6BVSPm1ly9IT6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=na6ImNXlQ2TvpAkn3U1v44x0A7QrFtid8aIaUuBEjZcMp3sTA0nGcxMhvUAlCqvLhHrVAHAVal8ZG0lZHHNLZuwQ0KlLyfHNt1fCtuPEp9HINvjKafItf7po240MgPubTvw6VVPfAFQnQMPJtF/wN8fpPPThZej7RURr/oUc2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bschu.de; spf=pass smtp.mailfrom=bschu.de; dkim=pass (2048-bit key) header.d=bschu.de header.i=@bschu.de header.b=da6eBM9Z; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bschu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bschu.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fvJ063q3Yz9tf6;
	Mon, 13 Apr 2026 08:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bschu.de; s=MBO0001;
	t=1776062918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G00sfWvgnFmN1RJzoAP+P1viqnzTx6BVSPm1ly9IT6o=;
	b=da6eBM9ZniPnguDp4JbzYSHsekDfOXVF6aNgLqReNr9Z2jq4jVUz2wUL+TEOreaNk3tnzB
	cFYHEtFtQ5RQN8PWKysp/7n2BDPcbuQqa6EO4y4bUDKlh05HKBpUa5LFexNR7c33LYP/RO
	AarHlPo5qXLbdp8q3Zn59r/KL8d6cwewgSsF7v3WgU1QMhdZKNFu7b+UTaaIlTNYveKImn
	sz3suGsbH0k88ZNv/j4GoPdNi9yWtzAo3NkHC8OqATDv57kTE7J5oOQiQisBgRuY05eaZG
	sXZA85YbpD0W3jUXSsvqqtIML7eM0WPPBsJilOV6X9GKUBlfeahnEGbdYogSQg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of bernd@bschu.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=bernd@bschu.de
Message-ID: <286f43aba56ab3052e5e9412625387d07afb802d.camel@bschu.de>
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
From: Bernd Schumacher <bernd@bschu.de>
To: Lukas Wunner <lukas@wunner.de>, "Alexandre N." <an.tech@mailo.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>, 
	1131025@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, regressions@lists.linux.dev,
 stable@vger.kernel.org, 	linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson	 <alex@shazbot.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 08:48:33 +0200
In-Reply-To: <adxlr9lWBTZIQMev@wunner.de>
References: <aclRwznwq6KpA2qA@wunner.de>
	 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
	 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
	 <ac0Y85OShbK6mHEV@monoceros>
	 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
	 <ac19pxEZKvQuQwFV@wunner.de>
	 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
	 <ac_VqcBbKRDkHp69@wunner.de>
	 <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
	 <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com>
	 <adxlr9lWBTZIQMev@wunner.de>
Autocrypt: addr=bernd@bschu.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-47JS6f+aPw6OLQPftc97"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bschu.de,none];
	R_DKIM_ALLOW(-0.20)[bschu.de:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235933-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[bschu.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bschu.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bschu.de:dkim,bschu.de:mid]
X-Rspamd-Queue-Id: 28A9E3E7EB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-47JS6f+aPw6OLQPftc97
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, dem 13.04.2026 um 05:40 +0200 schrieb Lukas Wunner:
> Could both of you, Alexandre and Bernd, give that patch a spin
> to see if it fixes the issue?
I confirm, the patch applied to 6.12.73 works for me.
I also have saved the dmesg (if you need it, please ask for it)
Thanks!
Bernd

--=-47JS6f+aPw6OLQPftc97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx5NNNf+H1Sb3l9vqxRmiDRIUYfcFAmnckcEACgkQxRmiDRIU
Yfckaw/8Dc0j7px+O86wzLK/jBFxi92XGrOBvD4stVbVz0mQtbLRKwg3ZYrgbMcr
jskcuxVjpYRyjXXiAZ3Rnx1QMGtWYPv94a+JY+L43tsBjQATki5ipbLOPixbQXF7
CQmqtDkheW5mU5lhJaOiiaSd4nHHvsF/0tlF6oOHZncy2ajfDNj1Z58uJRonvwSC
tZKaA+zSJWdu3D9tc1/O39Nm46CoBNVk88VDvUBH7MOKpvxIWqt+cbVXJJY2BfM0
0/5v3smuwfKAheeEyPGQMt4z8pdurN8YSKhNzf7w1To6pvPKFKTEobQXC4Tz1gJF
Yl/EqZKDHi/KuKgmMcJid9peKdubRH2QmhfxPD4IBLuz01QpA4HZFq3R8eC9G9s7
hz6B7hXEl/kG2qQQVVPoV50bJPlAnOaOUWwU31HXMjk5cgnuFF3guJkLfQidXRix
DQ0I/m57DvO3He8+RG1uQ9IQDbpTThNPXtienECuD0GBPVLLYbvNKUGyqso+GM56
Rlkf9bRN0bhY7NbZPg4QhOJQzyG1pjoH6QgZeOJTQeOL8UziGevNhHvW/WlDimBl
rWfiZ3w5gLIFpdTozTDBd/016T5P7J6BraxLoF3TuXstNxBtqesXloSA47CdN9Wd
/QoD7LHrbJzLiGYZaYwRtSvylc9tNQ1XBhbo6iJceSX7c5UFRhY=
=z7J+
-----END PGP SIGNATURE-----

--=-47JS6f+aPw6OLQPftc97--

