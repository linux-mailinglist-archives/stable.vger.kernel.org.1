Return-Path: <stable+bounces-249391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA1zMyNqC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:36:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B007572EFA
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90ACC3056526
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2B390986;
	Mon, 18 May 2026 19:32:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD8390995
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132734; cv=none; b=HOI2wSZrhACyalSOMJJ/QYRQCHQ2VJuLFelBw+1q0zsfzmJuIPSJXwdHSdt8HfPdKXq+230x+UL2aahpeKUlViZlRf7YkXdi0uQAPIOYveErQPdJYnajfv3CFqER5f9MTnMTBntncKC0XTOM1wpOcOBH33eZQ1i8DRUcbLtf41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132734; c=relaxed/simple;
	bh=weo+MBRG/g1PNMDtnZKYbZc6wxN9ad89bpvSP5ejePw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QRbXP9+xv8Sp7x8CQQcbt3vHyB/6Iux067yTNKnDaX2TLZas31g7YegxaXG7ReKv8MhDBzMGwPRES6OCMUtf14X5eHERT2THwIuokRNzShT9xfdQv96QUgQttUdvdwN57UeqPusqdvNLHa6Cxf/m1ERL4D8krSTkghEzUfQpS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (1.5.5.2.4.d.e.f.f.f.5.f.9.d.6.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a:6d9:f5ff:fed4:2551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D04AA342655;
	Mon, 18 May 2026 19:32:10 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org,  ardb@kernel.org,
  herbert@gondor.apana.org.au,  patches@lists.linux.dev,
  stable@vger.kernel.org,  dist-kernel@gentoo.org,  kernel@gentoo.org
Subject: Re: [PATCH 6.6 404/474] crypto: nx - Migrate to scomp API
In-Reply-To: <20260518155236.reply-0001@kernel.org>
Organization: Gentoo
References: <87y0hha5dw.fsf@gentoo.org> <20260518155236.reply-0001@kernel.org>
User-Agent: mu4e 1.14.1; emacs 31.0.60
Date: Mon, 18 May 2026 20:32:07 +0100
Message-ID: <87lddgbjk8.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-2.96 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gentoo.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249391-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@gentoo.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B007572EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--=-=-=
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> On Sun, May 17, 2026, Sam James wrote:
>> This fails to build. I think it's this patch. I did try figure out why
>> but I couldn't spot it when comparing branches (and all other branches
>> are fine).
>>
>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.140/work/linux-6.6/drivers/crypto/nx/nx-common-pseries.c:1023:35:
>> error: initialization of 'void * (*)(struct crypto_scomp *)' from
>> incompatible pointer type 'void * (*)(void)'
>> [-Wincompatible-pointer-types]
>
> Thanks Sam. The root cause is that upstream 980b5705f4e7 ("crypto: nx -
> Migrate to scomp API") was written against the post-v6.6 simplified
> scomp API (alloc_ctx(void) / free_ctx(void *)), whereas v6.6 still uses
> the older alloc_ctx(struct crypto_scomp *tfm) / free_ctx(struct
> crypto_scomp *, void *) prototypes. The migration was pulled in as
> Stable-dep-of for adb3faf2db1a, but that fix does not actually require
> the scomp migration.

Thank you!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEBBAEWCgCpFiEEJaa7iN2bdkxrVUHCc4QJ9SDfkZAFAmoLaTgbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQyNUE2QkI4OEREOUI3NjRDNkI1NTQx
QzI3Mzg0MDlGNTIwREY5MTkwDxxzYW1AZ2VudG9vLm9yZwAKCRBzhAn1IN+RkPqq
AP0Q1MFpmEp7hmHn5aMz1kxObp/RpPi/9pCdO2OiTzN6CQD/YmIhP8XbdAMJlsl/
USF4rnN3UH35o+lLGNkWIgE/XQw=
=iZ8l
-----END PGP SIGNATURE-----
--=-=-=--

