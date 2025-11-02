Return-Path: <stable+bounces-192092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D44C29866
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 23:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5414B4E3770
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB78242D86;
	Sun,  2 Nov 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRIlvc47"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A955155757
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122045; cv=none; b=bNGjwTb2p+3Ws1LnSrzkDablPCBmYS0XpVprrxhee+4IB+Y5rzj2E9wx7T8RUTowZanxNLnkusB4f5//VPVXCUy2M9xCF8z9hCdYZBiwN5D79WM5PgS/hXF1pC1dAqvGxRkLiFNYWZCqluoMhUZULxmt11tFwBWKHWhgHAFri0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122045; c=relaxed/simple;
	bh=vZO3PHgqOIKSLpT1XNcnJgC5AHDehu62cqI6I9Q+irs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRnFBayHM0jCF5RAWXGkjvydHEfVhur6BrwQHwANAUa/4saQyYBOPps2sS2ULIDiwEVSj0OTegCrC2N7OIozU4uGxbKzjCZzoR1m+h8PcyvNBb3JS1uDpgQmyCp4uo27heyphNlJEMH97qqqnYM++7stPiM9edPQo/xfIUE+VNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRIlvc47; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3404904539dso779848a91.2
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762122043; x=1762726843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyIK1ilUw35FUA5u8sORs0QLERPXEburx1e7TliwGA0=;
        b=XRIlvc47qQ7umPfWUO2c42T32g0sr94QhalBA7UUGlLP3KN9x1V+CpHybwuBBsiAxV
         33GCGeEV50MuhPnypIQ+q3znQ68EAYqt48F2xL2zjngOGceTs5pL9A65s8/d3ZQIfXhL
         wb7Uw2jbMQu45k5vNybiu5roqCPVz1Yl57emtXDRBLaPrUms1dPyRK7KjPPkoZQP0ZU9
         8NBBkQ1evIKdBK+EmxWuitfOswAb/HnuZoGEkNVsvksFLwebrdixX58ood9AKrQeecZD
         QXxEE6kUpWoowhSVH92DHDDY29Ub+SOCHalCTQNkCKHA/8ufy6rcY90xGLeftjo1pRz+
         q48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122043; x=1762726843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyIK1ilUw35FUA5u8sORs0QLERPXEburx1e7TliwGA0=;
        b=qdAupin8jkX0VOgrBFeDaKhc2ioxu2nPq3tEq/vIca2b08lFYESPSsvI/JJnv8be3J
         81AH0cNuzOGvE/qJOe9qwb3wtLe6ArZ1aP0uQy2+skXlEiGNAvpWvpEqpPo1ac/SApsl
         A/qDktsZqSKvCVNFPO5im3tyCq4vu/ZgAFt42CtuMzhw7DiqThnatWuRVnu21qTFVEHn
         OC5aRayigWGqryx5jNqPkj5ZSBDq2o3t/dgwfpys7pNdx+9Ah95K3IgnriQaKkytWx67
         YhGvSdZ3jHzgZY6GyjnJzlsjcUvHkMxEuVUOWHElgN+0+n6G1p1EIZCwqy6TNLOPE/YA
         V/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWfzvWk64/ShfPz3/ncSgSUCMCLchz4ySLgoPdlF3h0rwoHfiGFxSFtuqRyUnuzuR5R9X4pbS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpjCwyFmhLbll97+S0KEQZiYakL/s3MBLmtMNVKkuIn/UKZ6kU
	hjSkX1oOBQfWX0pwwpWBpCjAqhS4VwU+F/j1y2G6Z00sVzWH4nQzg1FqoFCgdNEmF9lzcod6O14
	6eBV/63vjD7V2/k94Hrzax4ZEpbFOc70=
X-Gm-Gg: ASbGncu7EcCHsm9taqyBIbPBsX3wnO3iQ+eoCBC5AJ5wD+2Ygv3NptmISpTgNSb96BF
	aAT9vu9afl6FReV3JBo43ZYLxVBLqaK2V2PywmtSAK4ALNbtVp+UsH4QopH1/TLVn8m7HeGvZuJ
	6z5YB/4enzyjU1yf2401XRb9sItmfTtZIVNr2t05tN1c5hR9Azx9RnSPYM5flut0un1X8mpU7AZ
	DPm3hnIpfFulBTdEjCHRVKnLLsxneKclVa4Zx/GRGIFk4u35wo/BkJy9IGHK98XMgQ5LLqyhJwW
	tS41T/ZrcyCMrsGJCnnoNVVR49LejECRcoflrO7ZapRwUu0zoUj4AI/jzLvsBhOKnt8rZLoqDvA
	ejZA=
X-Google-Smtp-Source: AGHT+IG0gQL4wpqk/N4eVevZ6EiRRAV29O6T0xOWLIHtqG3MysFxyrTz0rHu6gvrEfX+GEpHUZmKMf3I7Bn4K3wt4cg=
X-Received: by 2002:a17:903:2346:b0:295:586a:7644 with SMTP id
 d9443c01a7336-295586a77ecmr35979015ad.9.1762122042760; Sun, 02 Nov 2025
 14:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029073344.349341-1-ojeda@kernel.org>
In-Reply-To: <20251029073344.349341-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Nov 2025 23:20:29 +0100
X-Gm-Features: AWmQ_bl3OkSjDsxEokBQbHWG2tBRxHmsdbaPCFuCFuWjjrdm7lQYLIM3Vzk9M-g
Message-ID: <CANiq72mKjZfR5jfzra-EEDx1BVJ23iwJgRHuFf+3wJh+iE=T1A@mail.gmail.com>
Subject: Re: [PATCH] rust: condvar: fix broken intra-doc link
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:34=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The future move of pin-init to `syn` uncovers the following broken
> intra-doc link:
>
>     error: unresolved link to `crate::pin_init`
>       --> rust/kernel/sync/condvar.rs:39:40
>        |
>     39 | /// instances is with the [`pin_init`](crate::pin_init!) and [`n=
ew_condvar`] macros.
>        |                                        ^^^^^^^^^^^^^^^^ no item =
named `pin_init` in module `kernel`
>        |
>        =3D note: `-D rustdoc::broken-intra-doc-links` implied by `-D warn=
ings`
>        =3D help: to override `-D warnings` add `#[allow(rustdoc::broken_i=
ntra_doc_links)]`
>
> Currently, when rendered, the link points to a literal `crate::pin_init!`
> URL.
>
> Thus fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: 129e97be8e28 ("rust: pin-init: fix documentation links")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

