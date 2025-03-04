Return-Path: <stable+bounces-120210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E385A4D555
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 08:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662837A4141
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 07:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB961F867F;
	Tue,  4 Mar 2025 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hihqECuf"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3131F76A8;
	Tue,  4 Mar 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074578; cv=none; b=Nj/+eJwz1Lm6FcnP/JbnMLXc11DZbMLHHi0+VngbSDwUEFokhiohcvyegMIPNMxVYd4aQWnW3dlzNAUz7prDX9TRL4vke7amzxvMtmCGufOAWMAI/r9MOnRMF9/7XEWAyGk8YhbOIpDnkyqrL6qKJng7taSYZ/pX8vk3Le+jDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074578; c=relaxed/simple;
	bh=0c/JgpmJ1xTs7JmUkSsvLVns0tnoWAn8saEOOAw9J1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXoLyFm5s6Z9qo0uMUibqoRjClXhymG5VPLMnxPBejzEw5q1/f37v0Wk4lTfjN5lgnhbRsaoaLYqoClqqsrDWwXAEUbEYatV2smqZy6dM/YLvJ5nRjET7T8vMGwIZ7TUldyPLnGZLur9sCWS2x5ClVactluP2GDkRum2T7cyUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hihqECuf; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1741074568;
	bh=zIfEwkuAD57F3pZZRAjdPIKbEPJpjqKvEDPzL5jBHrg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hihqECuf0P5oDT+4STeTsnZtLmnDYfVQXfuJMdd+ckCsztu+KGwHfcRyf/9XcGORe
	 SNqLlCFwPSUefVuPIfN0ZwPCSW6pFMqsD2Abw3iflLyQwHW3FnwaYFNAiHdm1TmHj3
	 j5UW0GlDTiQ77K56nW0HUTpL2arb0ibRKRqxzUCs=
Received: from [192.168.124.9] (unknown [113.200.174.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4316865901;
	Tue,  4 Mar 2025 02:49:25 -0500 (EST)
Message-ID: <aab657d72a3ee578e5c7a09c6c044e0d5c5add9a.camel@xry111.site>
Subject: Re: [PATCH] rust: Fix enabling Rust and building with GCC for
 LoongArch
From: Xi Ruoyao <xry111@xry111.site>
To: WANG Rui <wangrui@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich	 <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	loongarch@lists.linux.dev,
 loongson-kernel@lists.loongnix.cn, 	stable@vger.kernel.org
Date: Tue, 04 Mar 2025 15:49:22 +0800
In-Reply-To: <20250304073554.20869-1-wangrui@loongson.cn>
References: <20250304073554.20869-1-wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 15:35 +0800, WANG Rui wrote:
> This patch fixes a build issue on LoongArch when Rust is enabled and
> compiled with GCC by explicitly setting the bindgen target and skipping
> C flags that Clang doesn't support.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
> =C2=A0rust/Makefile | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/Makefile b/rust/Makefile
> index ea3849eb78f6..2c57c624fe7d 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -232,7 +232,8 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387 -mprefer=
red-stack-boundary=3D% \
> =C2=A0	-mfunction-return=3Dthunk-extern -mrecord-mcount -mabi=3Dlp64 \
> =C2=A0	-mindirect-branch-cs-prefix -mstack-protector-guard% -mtraceback=
=3Dno \
> =C2=A0	-mno-pointers-to-nested-functions -mno-string \
> -	-mno-strict-align -mstrict-align \
> +	-mno-strict-align -mstrict-align -mdirect-extern-access \
> +	-mexplicit-relocs -mno-check-zero-division \

Hmm I'm wondering if we can just drop -mno-check-zero-division from
cflags-y: for all GCC releases it's the default at either -O2 or -Os,
and AFAIK we don't support other optimization levels.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

