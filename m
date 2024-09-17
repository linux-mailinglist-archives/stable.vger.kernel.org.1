Return-Path: <stable+bounces-76565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB50997AE09
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CB91F22518
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91B15DBC1;
	Tue, 17 Sep 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUVXw6eT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFB15C14F;
	Tue, 17 Sep 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565714; cv=none; b=LzYRxgfENjc+r4BCVDXGU7TUNz4fL87Y7kQ3AifUK8vvXv3aFndLvrgKyBhuel0hQwy7OyIs+p88qddMe6VZ4eBiiOgHZlMKJ8SqHmLfZV8mNMMmPVXXmvWbZt9ys15IjfNSp+feX8O2FnJxT5yQMARya26C9OCmFMkfTvm5418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565714; c=relaxed/simple;
	bh=PfJ9IgurPxHVn2dgYlngAdmfQ/I7auHTbr2Guw965jA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OYjxiCcg0iR5Ys5XH+u9iSyxuCwJpG+PT96VKXFUkGBbe/sW61t/y6XDdCBJjYyxvFWEzJyUFF1sDHPUW6ACHr/AN4B4xtFW7PSm0Zu44IVsVM9LBj4WSkWVUtAV+3qdTqz31onRn4XA488GdJa9YZRWhqkV1bcgEA/jo+h9puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUVXw6eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC12C4CEC6;
	Tue, 17 Sep 2024 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726565714;
	bh=PfJ9IgurPxHVn2dgYlngAdmfQ/I7auHTbr2Guw965jA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WUVXw6eTeOZVPT/qy8RMHzZbSiMGuAj/1j40338IWQutXqep87QiXE2LEPk4miHy5
	 iB3K2l0LQonIHL81kZtrndWOLciTgCv8RRlecysCGahx+QR3UPhSHbJEfTXnETmPw4
	 LIyG9T9IgVyMZtu58vfISrXy6XXYRXY/Im9DdFpYFKduKbGJ04EwJI+1Q0iK9/3uAB
	 L11jQcy14nh9kvbk6wK/sNNHxF/t56WclkNzSUqyN/G3cttnOlBdOq/Ecdr40YCfc1
	 Rk5MMVscdMW9t2aLzE7ittDOPIENEjb2evLByXakxji2u6jfpBFOLsDjCAb3BdjCKB
	 QLEp4A/3I4asA==
Date: Tue, 17 Sep 2024 10:35:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason Montleon <jmontleo@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com
CC: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix building rust when using GCC toolchain
User-Agent: K-9 Mail for Android
In-Reply-To: <20240917000848.720765-2-jmontleo@redhat.com>
References: <20240917000848.720765-1-jmontleo@redhat.com> <20240917000848.720765-2-jmontleo@redhat.com>
Message-ID: <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 September 2024 01:08:48 IST, Jason Montleon <jmontleo@redhat=2Ecom> =
wrote:
>Clang does not support '-mno-riscv-attribute' resulting in the error
>error: unknown argument: '-mno-riscv-attribute'

This appears to conflict with your subject, which cities gcc, but I suspec=
t that's due to poor wording of the body of the commit message than a mista=
ke in the subject=2E
I'd rather disable rust on riscv when building with gcc, I've never been s=
atisfied with the interaction between gcc and rustc's libclang w=2Er=2Et=2E=
 extensions=2E

Cheers,
Conor=2E

>
>Not setting BINDGEN_TARGET_riscv results in the in the error
>error: unsupported argument 'medany' to option '-mcmodel=3D' for target \
>'unknown'
>error: unknown target triple 'unknown'
>
>Signed-off-by: Jason Montleon <jmontleo@redhat=2Ecom>
>Cc: stable@vger=2Ekernel=2Eorg
>---
> rust/Makefile | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/rust/Makefile b/rust/Makefile
>index f168d2c98a15=2E=2E73eceaaae61e 100644
>--- a/rust/Makefile
>+++ b/rust/Makefile
>@@ -228,11 +228,12 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387 -mpref=
erred-stack-boundary=3D% \
> 	-fzero-call-used-regs=3D% -fno-stack-clash-protection \
> 	-fno-inline-functions-called-once -fsanitize=3Dbounds-strict \
> 	-fstrict-flex-arrays=3D% -fmin-function-alignment=3D% \
>-	--param=3D% --param asan-%
>+	--param=3D% --param asan-% -mno-riscv-attribute
>=20
> # Derived from `scripts/Makefile=2Eclang`=2E
> BINDGEN_TARGET_x86	:=3D x86_64-linux-gnu
> BINDGEN_TARGET_arm64	:=3D aarch64-linux-gnu
>+BINDGEN_TARGET_riscv	:=3D riscv64-linux-gnu
> BINDGEN_TARGET		:=3D $(BINDGEN_TARGET_$(SRCARCH))
>=20
> # All warnings are inhibited since GCC builds are very experimental,
>
>base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8

