Return-Path: <stable+bounces-266630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nap/HLcTMmrcuQUAu9opvQ
	(envelope-from <stable+bounces-266630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:25:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 799706964BA
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 05:25:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iQeCZFo+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266630-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266630-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92563003722
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35130DEB5;
	Wed, 17 Jun 2026 03:25:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48E2D2488;
	Wed, 17 Jun 2026 03:25:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781666738; cv=none; b=TATOtj1Ic116mMem5rrgmpOB8F2qb/yXWbaIGG30wDZYjyNueexEa41Way/Goa2sRxyRywWRaLXQhy9KWRLN9Ju7MZTfbW6QfxSfC15hYXhQCn+VL7fs80JJ6EP+wIAIcrtCGanfBhE4PC/8VvUmVctmnN1NbwjaByWKlAq2wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781666738; c=relaxed/simple;
	bh=ajBIolQ6LDOctEdoRq2od/QuBcUipCgrBkt+1ne+BxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcGUtZVuyie+PjXt+SuiqHz5J8NOqIsCJdJ2Cg+GKKhQUAu49leF8ZSUjodtSZafKSzQMuEhTxfyDzNOlWU7bYYVXhvDb+YL3m34GE65GfyWi0c2xpC9T0JlEWpS2XWZtnv2cpfOXK5UBtia5hVm8+i04QzDO9mC15Rrqj2qc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQeCZFo+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C981F000E9;
	Wed, 17 Jun 2026 03:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781666737;
	bh=rG57W1MO2nHpbFzCuSNvonU1eaTHOfMztvUqA0ANsSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iQeCZFo+FN3kbrZ3dPsZCE1pwroMOQAkWB7GbtiwiTdrd5VJhq5veJAw2CdWAtS3o
	 +8kcmpqpWkD/sXiN08bDrjIvPduNiNojOnaEoNmme1OA2bQq5ULF3uZPS/Se+Aw58p
	 XqJR2BJ55n8tZFm9xrd+vjIFmZlpo0qhDTW7GkB0q9tXgW0+HlHl/1SLmfb/6FDREY
	 b3bCTyN97o6v04ONsu8+4gYPt6hCODXiBOe1Xu9BYE682BXK8NsrNUUwFVGH4Qy1C3
	 +C09entxqDmMeYxL9kzq9LqhDhgRYglQv5nm3FZfo1aTksYphvOu+4gYmYYTEVgjs9
	 d2fM+aVxXHGLA==
Message-ID: <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
Date: Wed, 17 Jun 2026 12:25:25 +0900
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260616193929.2394119-1-rdunlap@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QpOL9oPbQYZGbrAD0iVZeOPy"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266630-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 799706964BA

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QpOL9oPbQYZGbrAD0iVZeOPy
Content-Type: multipart/mixed; boundary="------------jONvN0C0jCddOYxZde3BKxJo";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org, "kees@kernel.org" <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Message-ID: <48840fb6-8c33-4e4a-9951-aa603576357e@kernel.org>
Subject: Re: [PATCH] slab: recognize @GFP parameter as optional in kernel-doc
References: <20260616193929.2394119-1-rdunlap@infradead.org>
In-Reply-To: <20260616193929.2394119-1-rdunlap@infradead.org>

--------------jONvN0C0jCddOYxZde3BKxJo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

[+Cc Kees and Jonathan]

On 6/17/26 4:39 AM, Randy Dunlap wrote:
> Since the @GFP parameter in kmalloc_obj() etc. is now optional, change
> the kernel-doc to indicate that it is optional. This avoids kernel-doc
> warnings:
>=20
> WARNING: include/linux/slab.h:1101 Excess function parameter 'GFP' desc=
ription in 'kmalloc_obj'
> WARNING: include/linux/slab.h:1113 Excess function parameter 'GFP' desc=
ription in 'kmalloc_objs'
> WARNING: include/linux/slab.h:1128 Excess function parameter 'GFP' desc=
ription in 'kmalloc_flex'
>=20
> Fixes: e19e1b480ac7 ("add default_gfp() helper macro and use it in the =
new *alloc_obj() helpers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---

I think there is no better way to specify an optional parameter, so:
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

By the way, the doc should probably say that it is GFP_KERNEL when it is
not specified?

> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
>=20
>  include/linux/slab.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --- linux-next-20260615.orig/include/linux/slab.h
> +++ linux-next-20260615/include/linux/slab.h
> @@ -1094,7 +1094,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>  /**
>   * kmalloc_obj - Allocate a single instance of the given type
>   * @VAR_OR_TYPE: Variable or type to allocate.
> - * @GFP: GFP flags for the allocation.
> + * @...: GFP flags for the allocation.
>   *
>   * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or N=
ULL
>   * on failure.
> @@ -1106,7 +1106,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>   * kmalloc_objs - Allocate an array of the given type
>   * @VAR_OR_TYPE: Variable or type to allocate an array of.
>   * @COUNT: How many elements in the array.
> - * @GFP: GFP flags for the allocation.
> + * @...: GFP flags for the allocation.
>   *
>   * Returns: newly allocated pointer to array of @VAR_OR_TYPE on succes=
s,
>   * or NULL on failure.
> @@ -1119,7 +1119,7 @@ void *kmalloc_nolock(size_t size, gfp_t
>   * @VAR_OR_TYPE: Variable or type to allocate (with its flex array).
>   * @FAM: The name of the flexible array member of the structure.
>   * @COUNT: How many flexible array member elements are desired.
> - * @GFP: GFP flags for the allocation.
> + * @...: GFP flags for the allocation.
>   *
>   * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL o=
n
>   * failure. If @FAM has been annotated with __counted_by(), the alloca=
tion

--=20
Cheers,
Harry / Hyeonggon

--------------jONvN0C0jCddOYxZde3BKxJo--

--------------QpOL9oPbQYZGbrAD0iVZeOPy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajITpQAKCRCGXBN6rc5S
1lS0AQC3hp/oL8t9UoXUGcoyQT5XDRzDiaFWoy7VveAHQqbuvwD/S93XEIJXHccp
0NONbGxKhiry/w/7p/MXj5JCMx4sRg4=
=Rv36
-----END PGP SIGNATURE-----

--------------QpOL9oPbQYZGbrAD0iVZeOPy--

