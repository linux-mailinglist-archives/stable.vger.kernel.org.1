Return-Path: <stable+bounces-266642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5tfcIbstMmrWwAUAu9opvQ
	(envelope-from <stable+bounces-266642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 07:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D626F696948
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 07:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jJPz6v23;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266642-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266642-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB8230477CA
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F037EFEB;
	Wed, 17 Jun 2026 05:16:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0C34E779;
	Wed, 17 Jun 2026 05:16:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781673393; cv=none; b=evnTApeYGWTBL0VTnRg2NMbMFb2Q8ZMt9IptH02iBQ7RLLvGRPZSQ41gD8Yqcmd/jAr8E4cGuG8pB1ihCCu73lzhIpqt5dD5cQV0ggll5CQir9nnac7FV7hSGbwoHmQXwFi6I5hB3YJ0OcvqXcqz0ntsm/hxHMYb4jBH97UtBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781673393; c=relaxed/simple;
	bh=6KGiEtazipY/39iDkfm+y77g3nW6CZ+XWApOSnKBhZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpEobZbWyZttCfuBIh7rAjVvwheQeCgYmFlHW0/QepQNpG+rDu4mkoPyAiSDpskVIpAQCb6C7oTSnsj9w/49f/DDczl6gStbWt963nPbBZF3ykDoK1OR/8zUodUICqRb48yI/VQ4jc9T1xRNjUnlOEtvXfO7K+lAscr0Xfb2UKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJPz6v23; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A032C1F000E9;
	Wed, 17 Jun 2026 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781673391;
	bh=optTuxDRVX4Xxh/GiuxV8bViN9w6npI10kFhBkpLDZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jJPz6v231XAaES5dnkAcxqwBCRaMnEAbtpwWk0x28tofsgfttjRWn4csRhQBz9X+W
	 bczer+7z2xxBhKCCIZf5jUeOsruXrhrFCdlf0skBgdY3VAP03C23nRxRe6RJiLKQju
	 2/6Bo/bDbAypqU+0DWZXpVIy86ZWcYtfmPVH9EhlZq6CihD7tLJSvBdAtDREbcyNKT
	 t+xqUOcjvZjP2aKqlEnaXR1BtWsyYd+gmNKQpnGMQaMYNGIG4bx/gmDaL8B6McuOtK
	 NAxnXbsDdquftgOfUEIN+PkGXdAVo3ACGoD7LNDRvgMPJYWL4/rFRraQmhM45b5hNS
	 NXVMHmr1v1LgA==
Message-ID: <7ab220a8-2bec-4b00-8bf5-e76dff93fe13@kernel.org>
Date: Wed, 17 Jun 2026 14:16:28 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20260616193929.2394119-1-rdunlap@infradead.org>
 <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
 <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bKJ2JvUyLmi0aUgh8ALxlOvy"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[harry@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:linux-kernel@vger.kernel.org,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:stable@vger.kernel.org,m:kees@kernel.org,m:corbet@lwn.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORWARDED(0.00)[lists@lfdr.de];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D626F696948

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bKJ2JvUyLmi0aUgh8ALxlOvy
Content-Type: multipart/mixed; boundary="------------bC0iEyxP5mx28kx8B10PvWrQ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Message-ID: <7ab220a8-2bec-4b00-8bf5-e76dff93fe13@kernel.org>
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
References: <20260616193929.2394119-1-rdunlap@infradead.org>
 <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
 <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>
In-Reply-To: <79c90e12-c157-4d91-a7a4-54225d876d56@infradead.org>

--------------bC0iEyxP5mx28kx8B10PvWrQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/17/26 1:38 PM, Randy Dunlap wrote:
> On 6/16/26 8:25 PM, Harry Yoo wrote:
>> [+Cc Kees and Jonathan]
>>
>> On 6/17/26 4:39 AM, Randy Dunlap wrote:
>>> Since the @GFP parameter in kmalloc_obj() etc. is now optional, chang=
e
>>> the kernel-doc to indicate that it is optional. This avoids kernel-do=
c
>>> warnings:
>>>
>>> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' de=
scription in 'kmalloc_obj'
>>> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' de=
scription in 'kmalloc_objs'
>>> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' de=
scription in 'kmalloc_flex'
>>>
>>> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in th=
e new *alloc_obj() helpers")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>
>> I think there is no better way to specify an optional parameter, so:
>> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
>>
>> By the way, the doc should probably say that it is GFP_KERNEL when it =
is
>> not specified?
>=20
> How about (in general):
>=20
>  * @...: optional GFP flags for the allocation (GFP_KERNEL when not spe=
cified)
>=20
> ?

Looks good to me!

--=20
Cheers,
Harry / Hyeonggon

--------------bC0iEyxP5mx28kx8B10PvWrQ--

--------------bKJ2JvUyLmi0aUgh8ALxlOvy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajItrAAKCRCGXBN6rc5S
1o+vAP95308qeS2ZXYZ01jII/8FeugApGaKtmElPaVAE0mdMGwD/UrVY7d+FhpVZ
oIbAqvpYj+xMZ97HA2ZObgrk2Eg1JA4=
=JwhS
-----END PGP SIGNATURE-----

--------------bKJ2JvUyLmi0aUgh8ALxlOvy--

