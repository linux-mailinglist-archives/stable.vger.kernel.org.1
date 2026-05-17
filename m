Return-Path: <stable+bounces-249126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKqsJpv9CWqqvwQAu9opvQ
	(envelope-from <stable+bounces-249126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:40:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527F562AC0
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 247F830053C5
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3534E774;
	Sun, 17 May 2026 17:37:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CA49659
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039420; cv=none; b=FynDHuFRYaHChTU1nrJ/va1JO2JuvVLhqlW+YZ7LfxZgX4A4c80N/vXzMsbNjh7RS3TjpjF2gi9DBhyCN5nj1Ir/zaduvIX/Nu4V/uCF4+VgMQ7h6Cps33hjqQOS22UfPq1Nr7yFfDEYMvtwCzjbrqwjMg+lMppWeslu6vnERVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039420; c=relaxed/simple;
	bh=PN7KJHGCytWXOOJvTmKMVmlGax4OWyRapLMOkVBqsjY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=t0L7sAcEsuV5qi6QTSdyGPin2YmL0QlLF5WYj3Ua0P+VylayJBQSc3KQk5SpQmMtiZwp028VBJCYg7Eh5JSmBR19y3WcA85cqlTn6001csRu+qrps9/ANAtOXpfVrqZrLZQoiF51QE6ohUyPdc3A7MDHNXkNW5IfoyHbrQiqcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (1.5.5.2.4.d.e.f.f.f.5.f.9.d.6.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a:6d9:f5ff:fed4:2551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 71E9A3424C4;
	Sun, 17 May 2026 17:36:57 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org,patches@lists.linux.dev,sashal@kernel.org,stable@vger.kernel.org,
 kernel@gentoo.org, dist-kernel@gentoo.org
Subject: Re: [PATCH 6.18 160/188] papr-hvpipe: convert
 papr_hvpipe_dev_create_handle() to FD_PREPARE()
In-Reply-To: <20260515154700.798003472@linuxfoundation.org>
Organization: Gentoo
User-Agent: mu4e 1.14.1; emacs 31.0.60
Date: Sun, 17 May 2026 18:36:53 +0100
Message-ID: <87cxyuq6oa.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 2527F562AC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.46 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gentoo.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-249126-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@gentoo.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This fails to build:

/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-6.18/arch/powe=
rpc/platforms/pseries/papr-hvpipe.c: In function =E2=80=98papr_hvpipe_dev_c=
reate_handle=E2=80=99:
/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-6.18/arch/powe=
rpc/platforms/pseries/papr-hvpipe.c:513:9: error: implicit declaration of f=
unction =E2=80=98FD_PREPARE=E2=80=99 [-Wimplicit-function-declaration]
  513 |         FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
      |         ^~~~~~~~~~
/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-6.18/arch/powe=
rpc/platforms/pseries/papr-hvpipe.c:513:20: error: =E2=80=98fdf=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98fd=E2=80=99?
  513 |         FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
      |                    ^~~
      |                    fd
/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-6.18/arch/powe=
rpc/platforms/pseries/papr-hvpipe.c:513:20: note: each undeclared identifie=
r is reported only once for each function it appears in
/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-6.18/arch/powe=
rpc/platforms/pseries/papr-hvpipe.c:532:16: error: implicit declaration of =
function =E2=80=98fd_publish=E2=80=99 [-Wimplicit-function-declaration]
  532 |         return fd_publish(fdf);
      |                ^~~~~~~~~~
make[6]: *** [/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-=
6.18/scripts/Makefile.build:287: arch/powerpc/platforms/pseries/papr-hvpipe=
.o] Error 1
make[5]: *** [/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-=
6.18/scripts/Makefile.build:544: arch/powerpc/platforms/pseries] Error 2
make[4]: *** [/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-=
6.18/scripts/Makefile.build:544: arch/powerpc/platforms] Error 2
make[3]: ***
[/var/tmp/portage/sys-kernel/gentoo-kernel-6.18.32/work/linux-6.18/scripts/=
Makefile.build:544:
arch/powerpc] Error 2

FD_PREPARE doesn't exist in 6.18, it's from:

commit 011703a9acd76edc7c85d80dbccb6e50dba53aad
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Sun Nov 23 17:33:19 2025 +0100
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Fri Nov 28 12:42:23 2025 +0100

    file: add FD_{ADD,PREPARE}()

sam

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEBBAEWCgCpFiEEJaa7iN2bdkxrVUHCc4QJ9SDfkZAFAmoJ/LUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQyNUE2QkI4OEREOUI3NjRDNkI1NTQx
QzI3Mzg0MDlGNTIwREY5MTkwDxxzYW1AZ2VudG9vLm9yZwAKCRBzhAn1IN+RkIWR
AQDlXMpRv+pVsg7RHX4yDHW0uOrVAzLWzGp6TKmqZxSJwgD/dfQNcFMe/UxMHSRA
yg8+I+Vk8gcU/kYmSZ2lzr5qCgI=
=cuWc
-----END PGP SIGNATURE-----
--=-=-=--

