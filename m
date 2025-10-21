Return-Path: <stable+bounces-188391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CFFBF7E40
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C283358AC9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B434B67A;
	Tue, 21 Oct 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHsPEzhv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F02355810
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067528; cv=none; b=UlsrBcL6Kqoc//rF02p2lkobSs0zM/m9bVlHoWEEI0nA/HYuRT9Fyj8YaKCOHbSVV+vBn9LohbgBXF7y7kUncMZOgsyScQpyBVp0ZLvdoScMR/GbKHYejlQ/Dw73/bYVGYZJVqeNLRq14B1xSHdTUByAM1AdDf+VvX+DbX8R2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067528; c=relaxed/simple;
	bh=Ibl9ipy62JVcPBrthO993ocd5vWDT0JLzxK8s7HQuv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxtn6d2EyebMQevkw1rCeReiooPFCZoKClgY0BHqThTSJTA3rKgpUHPTaBMvIsSBS2RR36Ny8B35JqpJG6zonpEH5Sup6K1636VM4BXp949+iTW9eYlHvbnuMp/8DY41b6pLnd2+k6/w+o58GNMQJVk/Tc1dHS3DOatOLpXpIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHsPEzhv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29094f23eedso7961345ad.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067524; x=1761672324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAf3KsXjFc/zQP1AJm1wtfxbLUgTjyr2ky6pgjmz4cM=;
        b=KHsPEzhv9PnazcsMOs4hlJE2Vl9HIhNLf8vHqExNLD0kAG1qxJEsv27tm22+J8O8wj
         RkjkRjC/jDM/qFsoL5b5t362+AobWncAZnCeVwaPk+z6D74+1OfKyHGiG1lLTtCOF+30
         jkcBWIFuthLXPY770OFpr5VmMA0DTW4cMgsyHD2UmA2HTzWZHoZ89+rLE7PbKC4OiUs6
         bnlYvxhe42RjZDMGBxVS6aSPaNqB/Q5AJzInEN3O7O2fCdz2GHHptArB/6xxFK6+Y/FE
         r5r+EpJxRTudLOLlO+RH9mlwbUlm/Pzn+TU0W05YFHE11RqSDAMx2EBogC8hBBn3Lps7
         9dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067524; x=1761672324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAf3KsXjFc/zQP1AJm1wtfxbLUgTjyr2ky6pgjmz4cM=;
        b=JD+JRmB2iw82Elmd8LCkzoBGlNmGJHZCAjkcBm7T7nVjHUE100rtcMUFHCkQ9fSFIZ
         7YI/zwaBwkjZqQgCfa6V9wBQ24tkZExR7XIu4rhvtGcFRLARGlDGV1wnNcdm4XDy/M/k
         fFlk8zAAHIAqeRsFRk0pfw6dq1HgnkGPzq8Gr/osByVbMfo3vXvAN6lhjb9EOdoUDg3t
         HiYNBOX3Sps1UkqFfApkp0+zdectEE8RQzqGs+/3sRJRSu8Dyn/lb0jYe8SP5AuqSGxd
         Mq18k2dSh61u+ZXwgE9wyjk0yAPFw8wmI1jPlpC3ho6IcepCWlcGZyH3pxOXKxvVNyDD
         QEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNjorCqVQJ0JLBHMMVJgEozNPFYsm3Ptyb+ZKlVXPtBdLu6nSuXiKrhsBuf9H7tU7efTQOlXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6W0QQu0WvQPEcfUQJPBGORW5TNetPmIulxBYEo2Jz6/t80Rc
	mxrBXrdy9djMSc6d5rlwdcO96hIwCDGfh+zaCx2zCRcMgKZ1ZwDdAL+W18Cvys1tj3jj68Bbqg9
	8eDZ+QUdM91na5DVTHgRrcKsnnZU5GuM=
X-Gm-Gg: ASbGnctLu/TTGvXBeXhijn1LqulIShRtd0G2B5St1qAlmO/6gDn1yxH6jkXoGTwJTxh
	WVy2ueWy6z5eb4ZOC6Y3n0QwBAme1HWhiFEFb9kYfBxSxyfST3envZ3cFEYPCasVRsrDrr7Mb41
	0tX0lCn2oIwgglPeCLSpIcTA88yXlI0ykya/X8eemL3qxvV6XJ4L35TDNBne7zAT2Lqj5g7J2Lk
	z/Wqm+hE+KI0kIK+UkmREr3dTTxGuJS34KHfWAmavd2wxcI+SzRygfe73SXWjfhCsa9KQWQXBsF
	z1e64fmms+JiNXkhaPBLNsBLkHvjjmQBMMozzu7rpI2tYgIaBYLsZl2PRQpxd6EQY/U4rnwGTxG
	gTMtgTMAeIsa/eA==
X-Google-Smtp-Source: AGHT+IEWfCg0E0bwVttDNG0lql3yRpvV7id4seM/oa5UH+1sTXW5x3SO7M6tk+NNwv6wlch2bqa+yfg2OXtAPVMMHAk=
X-Received: by 2002:a17:902:dace:b0:267:bd8d:1b6 with SMTP id
 d9443c01a7336-292d3fbc72cmr30865725ad.6.1761067523987; Tue, 21 Oct 2025
 10:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020714.2511718-1-ojeda@kernel.org> <20251020105154.GR3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251020105154.GR3419281@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 19:25:11 +0200
X-Gm-Features: AS18NWCYSZSyVH4h_NBns8SoCWBqHms6Y7SdEmcHUYKM5xtVUbbF7ERZLvXjKs4
Message-ID: <CANiq72n_AnCJYw6R2XecapW9wZqs_Saa4t8BNgrPub2u9=9_xA@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
To: Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:19=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> I'll go stick it in tip/objtool/core; but I gotta ask, where are we with
> the toolchain support for noreturn?

Thanks Peter!

We discussed it with upstream Rust, and they understood the need, so
we may get something like `--emit=3Dnoreturn` or similar, but it is
still open (and not too high in the priority list since we can survive
with this for now and we have other things that we really need them to
get stabilized etc. But if you feel it should be prioritized more,
please let me know).

I have the status under "Export (somehow) a list of all noreturn symbols." =
at:

    https://github.com/Rust-for-Linux/linux/issues/355

In particular, Gary proposed an alternative during those discussions:

    "Gary proposed reading DWARF instead and wrote a quick Rust script
for it via object and gimli, though DWARF would need to be available
or generated on the fly just for that (and we cannot commit a fixed
list since the kernel config may change and we support several Rust
versions and so on):
https://gist.github.com/nbdd0121/449692570622c2f46a29ad9f47c3379a."

Cheers,
Miguel

