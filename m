Return-Path: <stable+bounces-211471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPzwG3ZJdWm8DQEAu9opvQ
	(envelope-from <stable+bounces-211471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 23:36:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F787F22F
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD25300D158
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B2A2690F9;
	Sat, 24 Jan 2026 22:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un2dWhKi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B922A4E1
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769294187; cv=pass; b=UuVX89yT44Y9MbH5D3a9t8Aa2+3MVaSchIznbl45Ma3f4XGKxtL58DG+qmfL8nA8XOHXgac76NGxy57WU7iN2Z8HTNmOi6t4pedEY5xCTM2+LpSXy7Zv0PinJ6HN2ZIfsZqml0atzJSSg+ADLMVL7DXqN1hOgoK25HVIyj9eIRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769294187; c=relaxed/simple;
	bh=MDZHCBmNyKSj2trZMG6rXLK8H8ITeqaNYXW0RIxzJcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrKvk2IjzBZdCf8Kd8eILaGSFJPm3oepGq5mVr3sGlfHEgg7L9hov0UAzBL4uaCA0CJdg05Ro+YfAB/tFD8dMjS+n3BrAP59lzs7KMdq5mAwdvCvSCfyTFKbgeeQO/aJGUNDviIAYRdbjnoxeNZvuUv96H/1AxC4I8YIvBsStxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=un2dWhKi; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43590777e22so1979115f8f.3
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 14:36:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769294184; cv=none;
        d=google.com; s=arc-20240605;
        b=imazyZU2Lq5gH/x5i2ans+50s+GTZhR4CjCo5Nq6y4/sM0fVp/7e+krn+fAx5yfY5K
         NsAk6tv1WUSj0Mdxg0kwgCETdLPXCVm6Wwugn+ayYJZPuCU1eTlAYWFuAfH7gJQry5YI
         fFq2g42XthWiOqXKp7WPCwe1UtZFJZIjOY5aJcEi25ip8Se1AK7PwegUaRLHrPEXnUJw
         Dzd3QWhq8Ri6RS3JjJWoB2fyqEBVT4xwqvnijLyrsG1nxTmwJH5H0aeCxPGNaPvAulFj
         VK5vzHLhvRfkwNjWZNJiX8cSVKuxy7Gp4L0MNletbFUd74x7cROSr+SB0kUVScfGvQrE
         1Nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8GmRSJGgMQjWndTIp/YQNxJh3VQ1FIOSVbF43GphX20=;
        fh=plOqDH3TrgjMMVfwRg42UM27Tv6FGAZ1R2uicQwWsX0=;
        b=Oikx25/4t7rPvFv5o7tZx5n9sEpJkCtglPoPa2k9EV2DYQbOj8igTYV/XNJIl2pxEX
         hyt6aE2bhyT1FpWnthtmRKd9vhaW1ADL1tVdSzDERL6dRTuepTwfFwhi8rwkxmxol//y
         h3KeVD9keFkpcCa2pj7zPPw1xw1xjvJPB/2KN09b1e9GY0unc2N3L45AJMfYhb9NWr06
         NWvtLQe4fARHkzGBKk7D+eUR5wnPC44pTe85nXJJNz13/KGoRfoW0sudTXH/bV5/W1wr
         VOK9f5SW14NASKn/MbEDDmCL6MFY9x0Uhmjq74k9BwX2GQOmmffJtzLA+BJUYy9RXpDp
         6+rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769294184; x=1769898984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GmRSJGgMQjWndTIp/YQNxJh3VQ1FIOSVbF43GphX20=;
        b=un2dWhKirTY7aeXJ3zgODxjra0WbJdlbPkCW+HcIPL6GNrveBSpqzEUxKHAFkyLwvG
         A9QbspVP0/vIZKP4kASOsyF2v4DSvwSs36YFRGI/bft1WY/B+iwYhUUo+1V+KPaNx65/
         HP3bH9tuIXU1T/wcDYZ1EdqGPbNZ8Hw1QM3CSIjPEPmJVOk1X4i1jRFehE8f/dpl02ZA
         5wseLDHfnXx5M8gKWeJrkA4l75hSNputeKoTVPtqX6yI5hN/eRLYSC1CQKF52G6AClAx
         HbhiJ/gT7m8nKHzIFgHaxrDfM1uAaiqkL0HJLvQl+q6jvdpVK+93iiJuty2nWMLOp2kG
         gSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769294184; x=1769898984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GmRSJGgMQjWndTIp/YQNxJh3VQ1FIOSVbF43GphX20=;
        b=sbLcEx13Xu4VXvAOpDpHEB8bXRsyhOsWLGWtEyh8Edr8QmWxlNk4I1QL2XyAubheTy
         v8svO4eCrCvsuo4i5jwBHsVDFgvOZ6I86TvQtQxeOxD+SxZRHQG+9T5L4/l2FJbbn2dY
         A9bMBbsBc8WEHdVIuzwnEvA7VW5UJN6x7eEoSOmOSouc2ng3yNrTxPa3DhN6wG/xb6qp
         C+HvNyIhkjmr569soTv1qfOlZAtstHSV1bixENwMJ5sue7z7JMLbGEQjmdSaVtP61cWN
         YhFQo/Su3AszH4IJWGsxdOZE0Mjw4q9xCCCzXC/bcW8IoBS35Q7KwFeD7SuyL+j5TyzN
         17Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUSVQDXtECANcCQf6FZdtpy8xYlxVEBNfL9/0oYbmlMkcmeifDDg4xt7GV/Yd0ITAXlpIpQda0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4koVvnbtD/ZpIUE4WCQnvf5t5mOdHeNqhib1M7WleHJ43xmJ8
	nB//QvYBpZjNsWJhLoKCeyCuXswtkUNAUciwDJovzeMSqoLfTHl8rvmtaEDipCDuy34wI96VmtZ
	wgA05ylvkqWwaCEZr02b+0qqLoH9c6vvgNofuBWAg
X-Gm-Gg: AZuq6aISdlnq4TK4ZYF/taiCQ6UCMv2e21+ny3siPBOVdmaTgLSiGdVYBo+ujX1INlF
	Yc7TvwtdGW6D4Zfjydy720T+1yYpZGJzi9ZcV+5vFmxkhHpfccuRLduemSLSGGwJE0zr0OfvVSO
	tE4iH6WigMyporZVAwUG2eD05Tlrd2RTXOWD7Dmi+TwtQunheLRWXnM5lgtR5V2BqOSFORuPMDn
	KyZK3JWOYF8PnDtA8HBoNG3dGbkQjDqyXuuVREMR9qU8GKz7sgfVzl+AUOaR+UH/qdIIEQlbrlY
	6sIZ6zf/3YfKUU3f6WTAQbHjeQ==
X-Received: by 2002:a05:6000:2285:b0:435:9abb:2e16 with SMTP id
 ffacd0b85a97d-435ca198a84mr6427f8f.45.1769294184410; Sat, 24 Jan 2026
 14:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124160948.67508-1-ojeda@kernel.org>
In-Reply-To: <20260124160948.67508-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 24 Jan 2026 23:36:12 +0100
X-Gm-Features: AZwV_Qg9RXX0-BW1n_ujo5ycjvRSxyutcP-OISjietqPr7ZWjFo28f7XnyPFETc
Message-ID: <CAH5fLggeH68Z+C2XFf4ONzRBu9HYcvJptz3UM1zUKd90v1g1cg@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: depend on `COMMON_CLK` to fix build error
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211471-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[collabora.com,lists.freedesktop.org,gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2F787F22F
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 5:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Tyr needs `CONFIG_COMMON_CLK` to build:
>
>     error[E0432]: unresolved import `kernel::clk::Clk`
>      --> drivers/gpu/drm/tyr/driver.rs:3:5
>       |
>     3 | use kernel::clk::Clk;
>       |     ^^^^^^^^^^^^^^^^ no `Clk` in `clk`
>
>     error[E0432]: unresolved import `kernel::clk::OptionalClk`
>      --> drivers/gpu/drm/tyr/driver.rs:4:5
>       |
>     4 | use kernel::clk::OptionalClk;
>       |     ^^^^^^^^^^^^^^^^^^^^^^^^ no `OptionalClk` in `clk`
>
> Thus add the dependency to fix it.
>
> Fixes: cf4fd52e3236 ("rust: drm: Introduce the Tyr driver for Arm Mali GP=
Us")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thanks Miguel. Since the drm fixes PR for this week was already sent I
think we can just include this in drm-rust-next.

Though, if you plan a fixes PR for this cycle, you're also welcome to
include this patch with my ack.
Acked-by: Alice Ryhl <aliceryhl@google.com>

Alice

