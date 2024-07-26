Return-Path: <stable+bounces-61879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E689793D48F
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F83B1F246DB
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037341E4B0;
	Fri, 26 Jul 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eRJRUllh"
X-Original-To: stable@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989F1E51E
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001734; cv=none; b=kpdJwzhZEmjgB8scr2V3SZajgsmhwBJl/NTwPruZ/pY7G6TsXK5lv7A7nywsmD9QuNgobXPaLqJHU3cN594rI1mYd3i3VL9VD4Uek2+YWFmJgg7LlYYJs65Qy8XhDzNUuBdj/fN/LVi0nqOc5Ok/YbGm/pct2AAff7Hya2X8Fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001734; c=relaxed/simple;
	bh=NuxrDd08oxpGA/iDcxcDeDZstw8aOvOLlU46OJM4+3w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F545F/QZurXkQTZgHSw7KyNbT9EehckUU04AgXZ+tq+UUPXp+2sHMFLXgYg0WSBG45oEwuXFg/5S2zLkmB0/RXwVxHGfIoNi6F/VW1r/vWw21whCSFj+qU+bixMVMehJzj80HYN5JxXuJF6vMDlu5mvZ2AYEbUWxcFI8yOX3R0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eRJRUllh; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722001729; x=1722260929;
	bh=WNGQcazdRzXhTEpv3IK9H/qSJJAy41fdpgM/1qIp9nk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eRJRUllhHfVHPVIWTyQVPaFF580AMw0SkhPuJHhYsiIPXiJsXY37dyK8vXLBBXixu
	 9WBSF6v+zbA46Q6YAA6jMPscOSZYEUrm1sMWXhbTnvURvWSvGpzVfLI0OAUqagifbC
	 7zE9zz5sz1cmQGW/TRLonftNWunP1V0A1NegdFMbC9jqG7xIGHzmCv7U/gDL8Twdqi
	 9YE+bP3pGHE3JH3E/6/hEcCl5ipcg1FjPRwpUJj1QRvUfsPPRAYoVR4Xetb7Hkm94h
	 zi9QAbU/6kuzUJPOMsYA99x2j+LhgKaXT8HiE77cQDBsTOz6P+o/RKh0UL7wye2wrz
	 pQHzE173mOKdA==
Date: Fri, 26 Jul 2024 13:48:44 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Tj <tj.iam.tj@proton.me>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] arm64: v6.8: cmdline param >= 146 chars kills kernel
Message-ID: <JsQ4W_o2R1NfPFTCCJjjksPED-8TuWGr796GMNeUMAdCh-2NSB_16x6TXcEecXwIfgzVxHzeB_-PMQnvQuDo0gmYE_lye0rC5KkbkDgkUqM=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 8a8c3b671c2a501482d279322c3317270d26a70c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This is v6.8 specific; v6.9 is reported as not affected (due to
extensive code refactoring).

Commit dc3f5aae0638 reworked how early cmdline CPU feature parsing
is done, and converted to using memcmp() in preparation for the move to
the pi minimal C standard library.
As a result it caused a regression where-by a parameter >=3D 146
characters on the kernel command line would cause a silent panic with no
console clues as to why.
It is due to memcmp() in include/linux/fortify-string.h detecting an
attempted out-of-bounds read. The cause itself is subtle.

arch/arm64/kernel/idreg-override.c::__parse_cmdline() compares the
struct aliases entries with each parameter via memcmp().

#define FTR_ALIAS_NAME_LEN 30
#define FTR_ALIAS_OPTION_LEN 116
...
static const struct {
char alias[FTR_ALIAS_NAME_LEN];
char feature[FTR_ALIAS_OPTION_LEN];
} aliases[]

Each element is 146 characters. When a parameter is also 146 characters
the call looks like memcmp(buf, aliases[i].alias, len+1) where len is
the equivalent of strlen(buf) and +1 to compare including the trailing
NUL.

That triggers the fortified memcmp()'s:

if (p_size < size || q_size < size)
fortify_panic(__func__);

where q_size =3D=3D 146, size =3D=3D 147

The solution here is to not call memcmp() at all unless the two strings
have the same length.

Initially reported in Ubuntu (and confirmed to affect Debian and
Mainline):

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2069534

Signed-off-by: Tj <tj.iam.tj@proton.me>
---
 arch/arm64/kernel/idreg-override.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-o=
verride.c
index e30fd9e32ef3a..9d2c120f378ae 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -308,7 +308,8 @@ static __init void __parse_cmdline(const char *cmdline,=
 bool parse_aliases)
 =09=09match_options(buf);
=20
 =09=09for (i =3D 0; parse_aliases && i < ARRAY_SIZE(aliases); i++)
-=09=09=09if (!memcmp(buf, aliases[i].alias, len + 1))
+=09=09=09if (len =3D=3D strlen(aliases[i].alias) &&
+=09=09=09    !memcmp(buf, aliases[i].alias, len + 1))
 =09=09=09=09__parse_cmdline(aliases[i].feature, false);
 =09} while (1);
 }
--=20
2.39.2

