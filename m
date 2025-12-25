Return-Path: <stable+bounces-203400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1ACDDB24
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9E9300E039
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B92F363C;
	Thu, 25 Dec 2025 10:56:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BEA2EF660
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766660214; cv=none; b=pZUEwY5ialTSgAWWcMXnobmgTy94Mu/BH5TU9I+DslxbhwtngTN8aVuaH7vQOwa7EDs+26/uMpWic34aTnF7L3XnlcGFVhHVrdz/N1w60niQ4u6UCK4zzzXCm+iNrEdyqqzIDCmilRaFx486wYF51ray7feN/Mm3TJn8NJJ+d7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766660214; c=relaxed/simple;
	bh=eFbut5nAN7rrRMS4SqAMeEfkLh1m9dUq3ogTrvoWozc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iPhSIXOYTpJASqc5EJeJKt12t5450nYuQXb8bg6dYvAkeWDgyxgT/xYCpEqhVm8NZXPfJHkDHPIFnMHPYZLvWvz/UvlpTgUefvKzHPgMPvV32k2fI6sHo5/B9PZssAbVNloJVxeMmj30Sxhfoj8VTPVW8FMO9E5VtrOYtaHrN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Thu, 25 Dec 2025 11:48:03 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: stable@vger.kernel.org, Martin Nybo Andersen <tweek@tweek.dk>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: 6.1 Backport request: fbf5892df21a ("kbuild: Use CRC32 and a 1MiB
 dictionary for XZ compressed modules")
Message-ID: <1766658651@msgid.manchmal.in-ulm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oBRzUKyk30MIRPFu"
Content-Disposition: inline


--oBRzUKyk30MIRPFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

please backport

commit fbf5892df21a8ccfcb2fda0fd65bc3169c89ed28
Author: Martin Nybo Andersen <tweek@tweek.dk>
Date:   Fri Sep 15 12:15:39 2023 +0200

    kbuild: Use CRC32 and a 1MiB dictionary for XZ compressed modules

    Kmod is now (since kmod commit 09c9f8c5df04 ("libkmod: Use kernel
    decompression when available")) using the kernel decompressor, when
    loading compressed modules.

    However, the kernel XZ decompressor is XZ Embedded, which doesn't
    handle CRC64 and dictionaries larger than 1MiB.

    Use CRC32 and 1MiB dictionary when XZ compressing and installing
    kernel modules.

to the 6.1 stable kernel, and possibly older ones as well.

The commit message actually has it all, so just my story: There's a
hardware that has or had issues with never kernels (no time to check),
my kernel for this board is usually static. But after building a kernel
with xz-compressed modules, they wouldn't load but trigger
"decompression failed with status 6". Investigation led to a CRC64 check
for these files, and eventually to the above commit.

The commit applies (with an offset), the resulting modules work as
expected.

Kernel 6.6 and newer already have that commit. Older kernels could
possibly benefit from this as well, I haven't checked.

Kind regards,

    Christoph

--oBRzUKyk30MIRPFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmlNFl4ACgkQxCxY61kU
kv2uzxAA1gB2k+QJ2nWN7UstlzIdW4wJZ9nBdWDPPb1azm8XhQVlEqEldjT/ie62
6ulwcEo+aegx5cRbm6fjTSWDK8yxUFMii9qOXuDQWYO8/nTlxG4rRKX3J8l2sjCb
YzjGSJQSk4fe0SjXKxljlulJAx6pD8dw798hF27VhpFGuAN+h09uRAUEQhFKysWD
QqIfhO++AzTDrW+BDDoQFGRJzqvlJmkNHCK+jAeD8N4zuMBlkbM0CzH2skDQ3XOj
EONM79j1vdorwExjJC9wTr0w8rlJRkOceEiTinZh8pHFESIVPqpCs9cVaNDXGWmk
jyyWHunMhqKyTk13wcGRCT++XbtMW5Ah85WjfvQ7jZR8B3YBfMrIw1vXrkq9gp6f
rfRybPAHn8jz8MClayy0CM1VY5BFhCI89NoMXM7fAMRDII/Bc8jcCMz7ptcRcWyp
mV/L0Ake3n11BIkLi+xAgg2OoY8afphi6y9sMXLR9KNJu6TF5UmwKmwqAvhYclRb
Uk2BDojzyzxD2wYMbBtBai97H/xK9mh9rmGm703wQ6wSgFmPxit9bT48/Kksg5dR
fJlD3Y0bveDVHNmZzjYxPAv34mxBnFABirqG4/O5r9CKIlKorbFJH9dVHmn3XFRw
X4Q3ZuSfrWIc/kU+Rhz6kqJCTmczHFBFlofbHUEvdjveCY5/L6E=
=kBOd
-----END PGP SIGNATURE-----

--oBRzUKyk30MIRPFu--

