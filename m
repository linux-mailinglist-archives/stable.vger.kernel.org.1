Return-Path: <stable+bounces-247456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KVZG0fPBmqAoAIAu9opvQ
	(envelope-from <stable+bounces-247456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:46:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8154ACB7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAA2930C74DE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903C3E4C62;
	Fri, 15 May 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bmyvvfRk"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAB3EFD31
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830790; cv=none; b=Ysf1Zt3oxGEmCh67pfcyOcgNlDfldMKbDuxRMQtIunPNpnUFeT85w9jmoNInAnc9bALUNuKV15s4EMMOP/YL80JIergHqm7txqpDHQlibTWgqxS5T2IaLJaieFIvonGuOel1Kn66a8zfHib+LFKjGQGHTGTPtEpXiRIQtkLb5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830790; c=relaxed/simple;
	bh=COeeSQ4HBB9/BG6ve5zA6gs2cPugLa8ZnA9WEVnNDhY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rz11oYXHdVeg1yZs5eWJfsFMUGFzVDkWdnEwCOwHzdoQY21ZTmzwa+l1Kewg7NzW1FBUlwccwIYioB6ngm1Mc6GRoMj01oFID7xEkgYZSFg7EVfi0CjE1x9ASTXzQxRYThc6RUjdf7MkiCM/fQqTcXyekpTlC+mSyyS6Jps7OBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bmyvvfRk; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:In-Reply-To:References:Cc
	:To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cmk16AkaDXfjXuIBv9eAftFKyKIIEP3YBYUKSqjPpk8=; b=bmyvvfRkxI1zqZYS4bd5I088oe
	V1porSCg0M0O3EnUlyPxxCyvN0UXu74J/39tAAA+Gufbex3jIL/hg2lZIqDecqX8f6V8i6LMIlflX
	q94EEK7hKrBM265qzxVBZ4ZhzDhitDuqaDsZTn5BFVMmsCLb2F1Z487kVfhxvjcI+j50q1fRJ31pL
	LCyjDx+k0P1ULzk6u7zJBkVu8UkeJUWc3Vvcnnf8UEi0cuaI4oKGv+jSfDiEM1EhZgmU3gptquNhw
	rEb308hIg9a5E0tFS44ysqTZNNjrg4jEHh/ogK2lxluFmcrVy4ORUz/oWE3ypOYY1uJZZZdU18zAg
	1tvLw/pQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.96)
	(envelope-from <ukleinek@debian.org>)
	id 1wNn94-004ZRE-0Y;
	Fri, 15 May 2026 07:39:42 +0000
Message-ID: <4cfc6feb-7344-4b52-88f4-d010c61a4266@debian.org>
Date: Fri, 15 May 2026 09:39:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y] ptrace: slightly saner 'get_dumpable()' logic
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Qualys Security Advisory <qsa@qualys.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>
References: <20260515073404.2974912-2-ukleinek@debian.org>
Content-Language: en-US, de-DE
In-Reply-To: <20260515073404.2974912-2-ukleinek@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jDa98R0v9PC3VKGu4b7CrPlI"
X-Debian-User: ukleinek
X-Rspamd-Queue-Id: E1B8154ACB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247456-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualys.com:email]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jDa98R0v9PC3VKGu4b7CrPlI
Content-Type: multipart/mixed; boundary="------------Eb0rolOMNS009if3yWjBskhh";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Qualys Security Advisory <qsa@qualys.com>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>
Message-ID: <4cfc6feb-7344-4b52-88f4-d010c61a4266@debian.org>
Subject: Re: [PATCH 7.0.y] ptrace: slightly saner 'get_dumpable()' logic
References: <20260515073404.2974912-2-ukleinek@debian.org>
In-Reply-To: <20260515073404.2974912-2-ukleinek@debian.org>

--------------Eb0rolOMNS009if3yWjBskhh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,


On 2026-05-15 09:33, Uwe Kleine-K=C3=B6nig wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>

oops, I forgot:

	commit 31e62c2ebbfdc3fe3dbdf5e02c92a9dc67087a3a upstream.

here.

> The 'dumpability' of a task is fundamentally about the memory image of
> the task - the concept comes from whether it can core dump or not - and=

> makes no sense when you don't have an associated mm.
>=20
> And almost all users do in fact use it only for the case where the task=

> has a mm pointer.
>=20
> But we have one odd special case: ptrace_may_access() uses 'dumpable' t=
o
> check various other things entirely independently of the MM (typically
> explicitly using flags like PTRACE_MODE_READ_FSCREDS).  Including for
> threads that no longer have a VM (and maybe never did, like most kernel=

> threads).
>=20
> It's not what this flag was designed for, but it is what it is.
>=20
> The ptrace code does check that the uid/gid matches, so you do have to
> be uid-0 to see kernel thread details, but this means that the
> traditional "drop capabilities" model doesn't make any difference for
> this all.
>=20
> Make it all make a *bit* more sense by saying that if you don't have a
> MM pointer, we'll use a cached "last dumpability" flag if the thread
> ever had a MM (it will be zero for kernel threads since it is never
> set), and require a proper CAP_SYS_PTRACE capability to override.
>=20
> Reported-by: Qualys Security Advisory <qsa@qualys.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>

--------------Eb0rolOMNS009if3yWjBskhh--

--------------jDa98R0v9PC3VKGu4b7CrPlI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoGzboACgkQj4D7WH0S
/k7BJgf+IsGmcc1sEf17qtW31f2GqS0tGQ63fs9yXvduYv+tvIXnf+Nj0OKNAp9l
ZtEmlIVaqET/kVijsm9A65vDsTguD9wRoKKw3JiM8y8Ec4asIPnk/Z1Ig/CjObdd
wCJB3glaP8FtD+gNBzflHU+GBtERml7jsxQuMTQIzm2hGbIlXeEuh8YHaTL18CrA
76hJrc+LmCF0FDdUJDxlADWClF8F9BZwrqgcnWoY86XO/1RrZH9Rvxbv6MuoA1B6
asSEj7ynnj/aQ+QSyOU2anQYCGMKMJEVnVYUVVs6DrMdyFsq8pIsUgSV2sk6ciuj
0JNbDQJIlNuWukluCf1Fk2rq29fy4Q==
=IspS
-----END PGP SIGNATURE-----

--------------jDa98R0v9PC3VKGu4b7CrPlI--

