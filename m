Return-Path: <stable+bounces-233773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL70J7n51Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:46:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160D3B7B23
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A989C3010D8F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9528A3FA;
	Wed,  8 Apr 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QML+uYz5"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69223504B;
	Wed,  8 Apr 2026 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630773; cv=none; b=QZpsGZcUuK9jqQxFPkoV2qYZgaC3HkvS9EnFWU+yBiwtznIHwoBb5aAh1081LZimaPtQTxb8iFsNO4fOwPDujlYlZRI6Km//97KW8PDTVGz9WyimoLjmjvvNElln7zO7qX0t1XmTaX2vd5zRdDJG+ntfmdHBN/3uLDoUunXwu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630773; c=relaxed/simple;
	bh=WV1htalpC97uteDfgKBsPHFKXo52MLYjoKpeO8pF5vE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnW/ABYUBVSa+jbcvxPLmlHuiBNv5NZkKFet6+UF/kdteFiqvwBla9tNx3efmL24megIt5q7mCk64tZMjlb2SbdNi3alB25BU35mrnTNSepZFA3jO4u1kZuoZZqO0Gw1JOUKyBmRvLs95AJSi9KF9JjwO8e4zHt/0T8juJfhZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QML+uYz5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tW4C7DNp4jf59b9gY7OTd32/8qvxX8VgEA1if3v+Irc=;
	t=1775630772; x=1776840372; b=QML+uYz5SlTNBpTn++OUVGk08jSScXt5bBFDdHjBdHxeksD
	WraMvhEQmZvGe1SBlJvFLQzC6EtT+lw9nnXIOm1DY41rvi2Q+K3V+l0aJVOe8ueoWtA4rwOaOp4/B
	GblBxVsTyRdio4gLSpuSkKbAQSt4Srk/OLk9e5QjCMfLd21JcQXBRXiqKNUBc7LuI8En462Ogx+ie
	UOGc8V/Cr7SDIMWsmO9BU2FJZRkRfC8VvVhvSzt8CzLa5UCrFcNKa38AKyK1jjISapfkfjWgG4C7j
	ZcTOa8nSs0UakoQlKXWiOcz79wN9WErSdXjgkbA1oX2ILq7u+kq0BlTzKG24vcjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wAMfu-0000000E2kS-1G7r;
	Wed, 08 Apr 2026 08:46:06 +0200
Message-ID: <a2efd8145cfbc207fef5884e93d09f787811becb.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: drivers: call kernel_strrchr() explicitly in
 cow_user.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Bommarito <michael.bommarito@gmail.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 08 Apr 2026 08:46:04 +0200
In-Reply-To: <20260407181528.879358-1-michael.bommarito@gmail.com> (sfid-20260407_201538_551551_67B5DCE6)
References: <20260407164435.726012-1-michael.bommarito@gmail.com>
	 <20260407181528.879358-1-michael.bommarito@gmail.com>
	 (sfid-20260407_201538_551551_67B5DCE6)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233773-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nod.at,cambridgegreys.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 0160D3B7B23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 14:15 -0400, Michael Bommarito wrote:
> Building ARCH=3Dum on a host with glibc >=3D 2.43 fails:
>=20
>   arch/um/drivers/cow_user.c:156:17: error: implicit declaration of
>   function 'strrchr' [-Wimplicit-function-declaration]
>=20
> cow_user.o is a host-side helper (compiled with -D__UM_HOST__) that
> calls strrchr().  It inherits the global -Dstrrchr=3Dkernel_strrchr
> remap from arch/um/Makefile, which is intentionally kept in
> USER_CFLAGS to prevent libc/kernel symbol clashes.
>=20
> This combination was harmless until glibc 2.43, which added (glibc
> commit cd748a63ab1a, "Implement C23 const-preserving standard library
> macros"):
>=20
>   #define strrchr(S,C) __glibc_const_generic(S, const char *, strrchr(S, =
C))
>=20
> The glibc function-like macro replaces the -D object-like macro.  The
> inner strrchr token in the expansion is protected from recursive
> expansion, so it refers to the bare symbol strrchr -- but the header
> declaration was already rewritten to kernel_strrchr by the -D.  The
> result is an implicit-declaration error.
>=20
> The global -Dstrrchr=3Dkernel_strrchr remap was originally added in
> commit 2c51a4bc0233 ("um: fix strrchr() problems") to resolve a
> linker clash when both CONFIG_STATIC_LINK and CONFIG_UML_NET_VDE are
> set.  Recently, commit a74b6c0e53a6 ("um: Don't rename vmap to
> kernel_vmap") trimmed the now-obsolete vmap remap and updated the
> comment in arch/um/Makefile to explicitly call out
> -Dstrrchr=3Dkernel_strrchr as one of the remaps that still prevents
> libc symbol clashes.  That global remap stays in place.
>=20
> Rather than exempting cow_user.o from the remap at build time, call
> kernel_strrchr() explicitly in the source.  This is slightly more
> honest about which strrchr the code wants (the kernel's, as it has
> been since 2011), sidesteps the interaction with glibc's C23 macro
> entirely, avoids adding a new libc strrchr dependency to the UML
> binary, and is robust to future C23 const-preserving macros for
> strchr, memchr, strstr, etc.
>=20
> cow_user.o is built whenever CONFIG_BLK_DEV_UBD=3Dy (the standard UML
> block device), so this affects most non-trivial UML configurations.
> cow_user.c is the only file under arch/um/ that calls strrchr(), so
> no other translation units need changes.
>=20
> Standalone reproducer (fails on glibc >=3D 2.43, succeeds on older):
>=20
>   printf '#include <string.h>\nvoid f(void) { char *p =3D strrchr("foo", =
47); }\n' \
>     | gcc -c -Dstrrchr=3Dkernel_strrchr -x c - -o /dev/null
>=20
> Tested on:
>   - Host:   Ubuntu, glibc 2.43-2ubuntu1, gcc 15.2.0
>   - Kernel: v7.0-rc6 (3aae9383f42f); verified that neither
>             arch/um/drivers/Makefile nor arch/um/drivers/cow_user.c
>             changed between rc6 and rc7, so the fix applies and
>             behaves identically on both
>   - Build:  ARCH=3Dum defconfig + CONFIG_BLK_DEV_UBD=3Dy, clean compile
>             with no warnings
>   - nm:     cow_user.o references 'U kernel_strrchr' (not libc
>             strrchr), and the final linux binary has no
>             strrchr@GLIBC_2.2.5 symbol anywhere; kernel_strrchr is
>             defined exactly once by lib/string.o and
>             EXPORT_SYMBOL'd
>   - Boot:   UML boots to Debian bookworm multi-user and graphical
>             targets with a COW overlay (ubd0=3Dcow,backing), which
>             exercises the patched absolutize() -> kernel_strrchr()
>             code path in cow_user.c
>=20
> AI coding tools (Claude Code with Opus 4.6, and Codex with GPT-5.4)
> assisted with debugging, test design, and drafting; the author
> manually reviewed every line and executed every build and boot test
> on the host.  Full disclosure was posted with v1; a shorter summary
> is in the Assisted-by: trailers below.

I think you should remove about 75% of that commit message, much of it
is noise, and some of it is simply wrong (in particular, "exempting
cow_user.o" really ever only existed in your earlier patch.)

Try without an LLM perhaps.

johannes

