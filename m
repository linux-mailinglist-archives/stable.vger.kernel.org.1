Return-Path: <stable+bounces-195118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF9C6AA41
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D9723A3F28
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E83730DA;
	Tue, 18 Nov 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqwcb0P4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE322A1D5
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482867; cv=none; b=fGgTjmGpRJUHnH+pQRoLioHyjLY89I18+hj2130bVHGn7+mvAQ/KcSxlmO3/jI0Gy6qAE/uMnnPWfUzp+YTCqOmwwaqI7I+9m/p0/oHKZ/qORCi2OWh6/uK5rrlp7auQ8CuaBSm86+jQxvVoAPOxGlSvzpEaRus5w45dl/NJvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482867; c=relaxed/simple;
	bh=faOfBULiO6Qp0WVmE8McFWL4GEnAP8ye2ZQBGtxMog4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppA6T/AxTec+IlXdxYqrKcNcge/FkuoKeUwzyQbrwNGpgdXDdzM0LiPPmX/u61OxPCGHZli54iInadLGcVgfAknuUTSj22Iy68hmsQgJ7d84LAWhDqNZaPbWWqQkwFPEuUgepONDAuAZf6pOAa82Gr/UIFn3o4IRZzc0jmOmGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zqwcb0P4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7baa5787440so235367b3a.0
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763482865; x=1764087665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faOfBULiO6Qp0WVmE8McFWL4GEnAP8ye2ZQBGtxMog4=;
        b=Zqwcb0P48+Opg0PaoHzGH2nKmoyDyyWA0N0PNFgCZOOvSciSj3ry1FttgSdglPBrLu
         OvABB3L07dtuewiVowNYjlByh7RpAr2ZENjqlwK8K5b6nbe2CsalMtbjLWt+qQn7I+qP
         p0evDGvas187GEDn4kAZShlo1qDSOjoJlKWiO6ova8+TadWigOgVTkCPOG2rcotHtH7C
         UfQpu+AHtSbVZCssdbrPNPaQuWsHvevEsxO8ss+k8JhTuBvI1QUt40iUmWvjvT+tgn0z
         Xqc5Gz+Ouvx/1vYgVcKShvUxqGgLGR9JtSBlTwyrMAYot+lJRjK+TlDP6ZkKFIugUIWX
         UhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482865; x=1764087665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=faOfBULiO6Qp0WVmE8McFWL4GEnAP8ye2ZQBGtxMog4=;
        b=vINs79kFei6PQIwvbtD4a/pNnTXkKLLQg0JvsACFl2CVsBijMgkpfcU8WxKp3AJ1ox
         2U2V+KSFuU2lxUcekPQg5MhvjaGsZwF2cUhpXxSQq8YY6avwDajcu7hE3SXA/foVVX3s
         Fk3PZ5CEI8RBV/QF7bfZYnj2a5mMahlueLAvExgaWhHgPpX95vvdpBXfqRwlq73QA5hb
         BzUOMN7TgcNI9q2U0ipWH0HtDksgfG5ie1PfZKh3uzB0/5nonC5lxfb3Pt/xgvkvYjpm
         UB05mF1aM4PbpQkQgu/SMxr3iSib01Fx3NWNfam1rsRalwgvvcPNwYUmkMOQrHN9PNlB
         Yqrw==
X-Forwarded-Encrypted: i=1; AJvYcCUFvezodQKa7RS2c+9hHUHh9MlKlk3Mz60uG9P29o9vh/U5l6HUd3srzcyvqFq4pnChcwkgIaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmS0EPd8CAZhM3sPL2sLnnTvtAd3GD8tibsr3ZKCdgWgW/JWVl
	tP7JQ7PxhWF8mKyeQJtjtoAC436WGbNhHCdMSEfdkQfQ2edg6uOM6Ht0XhTxGgU7tQCkPEJLorU
	DOvPxiMb/vaLGyxHL2aWln+TAnnRkaic=
X-Gm-Gg: ASbGnctYcq507yveA/jE6O3KBHQUtBNQvbv0LVMd7T4ultOAuTZ1ikYRzeFiy8jqVVR
	TrLmUWql3tQwwUH7l2cQETIPCE60I6+VT+gQEEmFK/m+u0nv32dF1S9+UG3QTjLP7M/lCt/nrbA
	gBNnFTi7XhTI+2tgL5UGynJC9oJbDFI2UfhDR6N+iFSvWCuuuWMbRALU1446CaINZSCKjV3E+gV
	aBTg2LwX/gGliFXPuVIxqQ1H3ZUCcFGuJz+Ty20wD0HuPEJbKik+kvuxKtArvCW7VvBIABnbZsx
	OYE5Htg2BJUDTu1zQDeNZi3CB5PPvFI9vAFDEltqiaKvbT5tC5Z+iNPI63xoI8+Mq65P1cye3n+
	0s0vnPXUPxCaBag==
X-Google-Smtp-Source: AGHT+IFVRdNsejBm6GKYlYca1Ngn1yJHjVdLnMU26Ia9C7PKBAIRtq1oGRAnFqiiyXtONzw3uw69CCzFP8m6+uCM7y0=
X-Received: by 2002:a05:7022:ea46:10b0:11b:65e:f33 with SMTP id
 a92af1059eb24-11c78ddf633mr1026663c88.1.1763482864497; Tue, 18 Nov 2025
 08:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <20251118145741.1042013-1-gprocida@google.com>
In-Reply-To: <20251118145741.1042013-1-gprocida@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Nov 2025 17:20:50 +0100
X-Gm-Features: AWmQ_bnVmxUteFT3dr5VfpkhZiAQKyOG1ub40EZh79PVRCrhks9ZqnFaWxh_hDc
Message-ID: <CANiq72nsU1YH3ihkaTiVjF_YUZY2nSKbc7j3xLTcHDC-4-Y5iQ@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Giuliano Procida <gprocida@google.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 3:58=E2=80=AFPM Giuliano Procida <gprocida@google.c=
om> wrote:
>
> This results in the -T foo option being ignored in the case there were
> no symbols. I think it would be better, consistent with the
> documentation and expectations, for the file to be produced empty.
>
> This means that just the for loop should be skipped, say by adding the
> condition there with &&.
>
> If you disagree, then please update the documentation to match the new
> behaviour.

Sounds reasonable. If there were users relying on that, then it may be
best to keep the behavior as it was. But up to the maintainers what
would make the most sense here of course (moving Sami to the To:).

Since the commit is in mainline and it seems you already thought about
the solution, I imagine a patch would be welcome.

Thanks!

Cheers,
Miguel

