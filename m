Return-Path: <stable+bounces-114179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF7A2B4F8
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8193C18853CF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469E22FF2B;
	Thu,  6 Feb 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUxnEkF7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88E15B99E;
	Thu,  6 Feb 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880637; cv=none; b=nH7z8ph3Gf1lUkMC3Fd4l4SXBYv209a1DCo+wl1ojU5IrRxYvSuARsL2iHJSWfOmF6TU+H0PVf+HpL7MUjIjnBvx1iydkL02mf+g6m9wwMS2Ee++B9sjABtDi86aqIRmn7spUG1Fz8+iURQNOtyNOzKcte3tuMgsHCTNcs+KQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880637; c=relaxed/simple;
	bh=IS06I5U0xdVjXFHNYM6SRnQFWnEVy2bqzrx1q4c+/ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dw8SW8EykhJywptO/2i2VwE72oeeiJrjaMLPC87OD36tVzIdbk/AWr/tUhsiOM+xCECajMbY8HOOELUEV8A/Txq6SErsnRbxcaK+MZqAsK56h8mrv7nLirfqrnY6UuLwn2JsAopRlKikeyrISsnSFFUbRw8UXQOuxL4aDcsQAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUxnEkF7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa102a6106so222749a91.0;
        Thu, 06 Feb 2025 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738880635; x=1739485435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS06I5U0xdVjXFHNYM6SRnQFWnEVy2bqzrx1q4c+/ds=;
        b=TUxnEkF7DGNOFEs5g+Q7Q00tJz+BOnR+sEmkNQ78+KAJVJBH8lkUmvNwLk+7OrIp+T
         Ein16lyShx8SAF+24xEwZ4yq6dJYMcz8GDzOVV2qVmsunPHLDcHFkb3EPFsOMkSlCxoK
         fjgBmf4muH0xqjrq7LQpxOB7ARE3RsL9VukjqvNJ/UskZ+bNTmZEL9Vv6Xgd5uxnz82f
         fJ95RFMDB3BQ3BsMCTzH4rT8lEj5LCxeDgStY9GGXoObVvvxqnAlo/6DGfn9qgP11VW8
         sKJIf+OMKCb9whoRUBm3fGx6sIGWw7hlRqep9vXxmc/RpTlxKSa8S42LUjzjODCPn2Me
         sq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738880635; x=1739485435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS06I5U0xdVjXFHNYM6SRnQFWnEVy2bqzrx1q4c+/ds=;
        b=aX4n/Bk4P5+fXz7mQE3X+cBKS7lfh7VZSwNdqiUASaYhGll0mhZSgMJ0nA4VPjly/q
         5GQPMScGhstZTVb6Ez1UA/5L4h7F4qiDJ8VdWUNCS3Y4b/2qgII51hvP85UebBovBcv5
         Ty6JyvSssEGE9jSRR4cZfqSNCJ/yDOhU/bRKaApEhE7F6SgZYu4kG+G1krrlec3QKTuI
         HuhOXd1uq/y8bRsrhwCmqd+ydGkIf+MI7LLCYXQ1f31CvMgocQ5Yo5sb9iHzeE0PeTd8
         VNB3fRqpZUJn3cggP38I+gvHjqhpxZryjTna+KuegBXTvzpGQyjI5AnFk0ANUv1p2UhM
         +Upw==
X-Forwarded-Encrypted: i=1; AJvYcCU4J42CmQZhNZ7OYNyoxXZmyfbF6JFPjphYQtb5iYhJh+MTgJpRmCmAALaes8DRVdRg7XL+5HMG@vger.kernel.org, AJvYcCXDjW5gBccFPwUVbz8JFvZHeTW8GDwyJpZM8FzWjSOhe7KZAW3w9o3JSQf04XweP3l6E3E+tdU6deLiv2o=@vger.kernel.org, AJvYcCXouwMGurKDcyxC3IoVTdQcU/tmc9cI3dXFTZBnFsEceuLss+NMGgTCeft9E8CQRSlCeJpnBqyuZDv5h8od7QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+gLtFNLD5NfDelJxrQYd1PvhYq5EIj+sjXgoL2oQ8O3/HwZz
	T4lg4akSWIsGXRSY5pgTusv+BpqrAGkKXCr46B0yhlHr+lnKimkJc7wGQIlZ8G5TztRvrG4cCnA
	FhYwUiUpm13gJY4XV+hYYByLawtT2urFwkqQ=
X-Gm-Gg: ASbGnctyc3YGlUJ9rgUy6kF+B/S+z6gSV6xjdkA+qax39XVb222xke9NNY9c9d+gQlY
	D0K/e90u7tCUNzt7WwojguBRKVUwN6DO/+nSOhEtedtPicKh5SPZPmhG3pjtovXwkGWoXYcs9
X-Google-Smtp-Source: AGHT+IG9SCuXHttUG1K4uZ9sgNfkDjQbd2RfkChJLOxYwTTEA6GyQPkoVKG1M20Dtiyd4iqgUwAhGCeFpgbE45ZfjYY=
X-Received: by 2002:a17:90b:1b44:b0:2ea:956b:deab with SMTP id
 98e67ed59e1d1-2fa2453100emr455019a91.4.1738880635082; Thu, 06 Feb 2025
 14:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
 <CANiq72kv_wE_ESNsW9qDiwnJkaoFb+WERJ6p796TCPAdK838Fw@mail.gmail.com> <4ab2efaf-867a-4b8a-8e4a-193f8218dd33@intel.com>
In-Reply-To: <4ab2efaf-867a-4b8a-8e4a-193f8218dd33@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Feb 2025 23:23:42 +0100
X-Gm-Features: AWEUYZmRxOjvPPyaibtJQh9LKpnRat36mvXX_IWG3jDmqy8dT0gvCzQxMYYWI28
Message-ID: <CANiq72kYzZ5T0Y1PMmz8dcu5FEwuS+xkUPprnw-qawy1WHEMsA@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: set rustc-abi=x86-softfloat on rustc>=1.86.0
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alice Ryhl <aliceryhl@google.com>, x86@kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 9:58=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> Are you saying you'd prefer that we pick this up on the x86 side? I'm
> totally happy to do that, and it's obviously patching x86-specific
> sections of the rust scripts.
>
> If I'm understanding the ask.... Just curious though, what makes that
> preferable? It's in a rust-specific file
> (scripts/generate_rust_target.rs) and I'd guess that it'd be easier to
> take it through the rust tree since it's more likely to collide with
> stuff there and also be closer to the folks that can competently resolve
> any merge problems.

I typically say something like that when I feel I may be overstepping
-- I don't want other subsystems to feel that they are being skipped.
For x86 I have so far taken things myself, since it was the first Rust
arch (so it was an exceptional case), but perhaps you wanted to start
handling things on your own etc.

I am happy either way, of course. Your Acked-by's would be very welcome!

Cheers,
Miguel

