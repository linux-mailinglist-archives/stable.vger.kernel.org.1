Return-Path: <stable+bounces-76597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2A97B222
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD4B28404D
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92511188584;
	Tue, 17 Sep 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REkev21b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C6183CB7;
	Tue, 17 Sep 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586803; cv=none; b=R6hb07ptLckxaqnUBDR0nFpQxfyOe69I6IY7L4AiQLZD51wbZaJwQHqBneK4PfufGDDzdNIeWs6Aw/HHgDwmnWaCccMX0zMKkONJyYzAYww2gX4jWXOm1OZ6VRA4/B62OtvMCmvxb/atyRH6SpgSoqMxOLBC554KFUCgWx1Jywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586803; c=relaxed/simple;
	bh=1Y09J/5W6IHV5VTgs8vwAGfTMn4lqzG5/gPcakv1nfQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=j8X0gf7EefsU/sxL0EF+Ym1btqr6pFMSQRXDzlXiqv2HHWqezeHTv0k9yAVQ/eiE2JMA4BQuaGtF8JxBxDwQagHub2itf+rs8YrPT4/SR1o/GqKUcGszGue8RumnHVKS9mn2I/XxP9g2Kgs+MiBB3jGAjdI5nr2+6j/Gz3f7+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REkev21b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E70AC4CEC5;
	Tue, 17 Sep 2024 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726586803;
	bh=1Y09J/5W6IHV5VTgs8vwAGfTMn4lqzG5/gPcakv1nfQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=REkev21bgewL0wukX5RNcZfTF3QJT//wBxJvlGd5u0itFEboL9HIyJ/y+I+Sfa9bJ
	 UghplBhcRX2nUwlwuffRQHIc+/3Azl/VJQxLmFgYaVAliK7+QYRJsw83YywwDavOxR
	 /6dsnU/paby0LKCyImt3YZmAW9H6FGmWW9Cmt60AbbTU/Ryqj3pQMY5OQtGfnoVlAR
	 EPEKos2FaqiinGWPJLq8th+h11fCsAdiEnUVq1ZNFsM2Yu1feGK6SahaPJ1Xzpx8h9
	 VcnhGiUtwY0S86MLQ5u2nb/OTqjmB/1QSJi0FbELZaIeRptdConr/r45oB2gDPa1lz
	 EZoaFmu8MTsdQ==
Date: Tue, 17 Sep 2024 17:26:40 +0200
From: Conor Dooley <conor@kernel.org>
To: Gary Guo <gary@garyguo.net>
CC: Jason Montleon <jmontleo@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Fix building rust when using GCC toolchain
User-Agent: K-9 Mail for Android
In-Reply-To: <20240917142950.48d800ac@eugeo>
References: <20240917000848.720765-1-jmontleo@redhat.com> <20240917000848.720765-2-jmontleo@redhat.com> <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org> <20240917142950.48d800ac@eugeo>
Message-ID: <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 September 2024 15:29:50 GMT+02:00, Gary Guo <gary@garyguo=2Enet> wro=
te:
>On Tue, 17 Sep 2024 10:35:12 +0100
>Conor Dooley <conor@kernel=2Eorg> wrote:
>
>> On 17 September 2024 01:08:48 IST, Jason Montleon <jmontleo@redhat=2Eco=
m> wrote:
>> >Clang does not support '-mno-riscv-attribute' resulting in the error
>> >error: unknown argument: '-mno-riscv-attribute' =20
>>=20
>> This appears to conflict with your subject, which cities gcc, but I sus=
pect that's due to poor wording of the body of the commit message than a mi=
stake in the subject=2E
>> I'd rather disable rust on riscv when building with gcc, I've never bee=
n satisfied with the interaction between gcc and rustc's libclang w=2Er=2Et=
=2E extensions=2E
>>=20
>> Cheers,
>> Conor=2E
>
>Hi Conor,
>
>What happens is that when building against GCC, Kbuild gathers flag
>assuming CC is GCC, but bindgen uses clang instead=2E In this case, the
>CC is GCC and all C code is built by GCC=2E We have a filtering mechanism
>to only give bindgen (libclang) flags that it can understand=2E

Yes, but unfortunately I already knew how it worked=2E It's not flags I am=
 worried about, it is extensions=2E
Even using a libclang that doesn't match clang could be a problem, but we =
can at least declare that unsupported=2E
Not digging it out on an airport bus, but we discussed the lack of GCC sup=
port on the original patch adding riscv, and decided against it=2E

>
>While I do think this is a bit fragile, this is what I think all
>distros that enable Rust use=2E They still prefer to build C code with
>GCC=2E So I hope we can still keep that option around=2E
>
>Best,
>Gary
>
>
>>=20
>> >
>> >Not setting BINDGEN_TARGET_riscv results in the in the error
>> >error: unsupported argument 'medany' to option '-mcmodel=3D' for targe=
t \
>> >'unknown'
>> >error: unknown target triple 'unknown'
>> >
>> >Signed-off-by: Jason Montleon <jmontleo@redhat=2Ecom>
>> >Cc: stable@vger=2Ekernel=2Eorg
>> >---
>> > rust/Makefile | 3 ++-
>> > 1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/rust/Makefile b/rust/Makefile
>> >index f168d2c98a15=2E=2E73eceaaae61e 100644
>> >--- a/rust/Makefile
>> >+++ b/rust/Makefile
>> >@@ -228,11 +228,12 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387 -mp=
referred-stack-boundary=3D% \
>> > 	-fzero-call-used-regs=3D% -fno-stack-clash-protection \
>> > 	-fno-inline-functions-called-once -fsanitize=3Dbounds-strict \
>> > 	-fstrict-flex-arrays=3D% -fmin-function-alignment=3D% \
>> >-	--param=3D% --param asan-%
>> >+	--param=3D% --param asan-% -mno-riscv-attribute
>> >=20
>> > # Derived from `scripts/Makefile=2Eclang`=2E
>> > BINDGEN_TARGET_x86	:=3D x86_64-linux-gnu
>> > BINDGEN_TARGET_arm64	:=3D aarch64-linux-gnu
>> >+BINDGEN_TARGET_riscv	:=3D riscv64-linux-gnu
>> > BINDGEN_TARGET		:=3D $(BINDGEN_TARGET_$(SRCARCH))
>> >=20
>> > # All warnings are inhibited since GCC builds are very experimental,
>> >
>> >base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8 =20
>

