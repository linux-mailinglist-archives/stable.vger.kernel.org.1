Return-Path: <stable+bounces-108195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F6A0927F
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 14:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7793A9A88
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AE320E331;
	Fri, 10 Jan 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="fG5ICY40"
X-Original-To: stable@vger.kernel.org
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD620DD71
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517009; cv=none; b=eRYpn9jpBZckFVillQkaRVjTne/rfRWTmYtPxjp5ofaRIkKAdJBR2vWCJml1u6noWrgfUmFmujwg+/oiSkfHyEO6PNZ1t1mTOUNoUUZmwXMoWzR2kkv8pp5Rn4Ee74oGNoiA72YHyZMpE7b8GY4tsUbTsb0Yeo8ORjoseKnGWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517009; c=relaxed/simple;
	bh=YJ755cDs+D875wWnarRFX9kBWozuIJhH2j3k/5Ovgz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EKxeqKNp7RRngEf0TJaCFXS0BQJWqlVyF6xnNhg+k9Asa/52XiI1XN44Rg3w2IVHtiNdEXCZXvKMFBaYPfJp6BeDsbtMFAgps2/5JfOAqw8QoGaIKs7SWho154OmihMRrV3INy8dyFesLIEhQm9B1+4iQe0zTtwfe3eX6/2YT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=fG5ICY40; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop (unknown [IPv6:2001:4646:fb05:0:ad82:2c09:779f:8848])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id C49D22266EA;
	Fri, 10 Jan 2025 13:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1736516408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7VT1CASTILdcekWmkvd1KQ0cV341wJHTu62CXzb1NpA=;
	b=fG5ICY40w4dIFz1Lrw2nwl+h8WDpTRMxQNeEUMEyg2fAQ5JQ+0unGVNCZ/GukfssWVqwZ7
	Uvuj1DGDEni6jZsTwSzdNJ3Qdh5oDzR04oTvpr8hoG7l2JKUhhnv7iv5LvoEf9Zy7mrOFv
	sfELz0IQnaW/fpOKm4iUjiWrHbB44v8=
Date: Fri, 10 Jan 2025 14:40:04 +0100
From: Natanael Copa <ncopa@alpinelinux.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Subject: regression in 6.6.70:  kexec_core.c:1075:(.text+0x1bffd0):
 undefined reference to `machine_crash_shutdown'
Message-ID: <20250110144004.1fca120a@ncopa-desktop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-alpine-linux-musl)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

When updating the Alpine Linux kernel to 6.6.70 I bumped into a new compile error:

  LD      .tmp_vmlinux.kallsyms1
ld: vmlinux.o: in function `__crash_kexec':
/home/ncopa/aports/main/linux-lts/src/linux-6.6/kernel/kexec_core.c:1075:(.text+0x1bffd0): undefined reference to `machine_crash_shutdown'
ld: vmlinux.o: in function `do_kexec_load':
/home/ncopa/aports/main/linux-lts/src/linux-6.6/kernel/kexec.c:166:(.text+0x1c1b4e): undefined reference to `arch_kexec_protect_crashkres'
ld: /home/ncopa/aports/main/linux-lts/src/linux-6.6/kernel/kexec.c:105:(.text+0x1c1b94): undefined reference to `arch_kexec_unprotect_crashkres'
make[2]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/scripts/Makefile.vmlinux:37: vmlinux] Error 1
make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:1164: vmlinux] Error 2
make: ***
[/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:234:
__sub-make] Error 2


$ grep -E '(CRASH_CORE|_KEXEC)' .config
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_KEXEC_JUMP is not set
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y


Looking at the git history I notice this commit:

> From e5b1574a8ca28c40cf53eda43f6c3b016ed41e27 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 24 Jan 2024 13:12:46 +0800
> Subject: x86, crash: wrap crash dumping code into crash related ifdefs
>
> [ Upstream commit a4eeb2176d89fdf2785851521577b94b31690a60 ]
>
> Now crash codes under kernel/ folder has been split out from kexec
> code, crash dumping can be separated from kexec reboot in config
> items on x86 with some adjustments.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.6.y&id=e5b1574a8ca28c40cf53eda43f6c3b016ed41e27

So a wild guess is that the commit(s) that splits out crash codes under
kernel/ directory from kexec code also needs to be backported to
linux-6.6.y?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.12.y&id=02aff8480533817a29e820729360866441d7403d

Thanks!

-nc

