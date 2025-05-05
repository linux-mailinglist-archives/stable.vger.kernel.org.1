Return-Path: <stable+bounces-139717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EAAA9777
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4418A18835FB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE44425DD16;
	Mon,  5 May 2025 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tubrorf5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1513C25D538;
	Mon,  5 May 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458741; cv=none; b=Jm6i3LzjZbW/OLPPiO/QcnUEK80iC5hmZT8YmlrlvUbIC0KUhQKhRk1F7WdNmw5tq4HsbSLyS44KSWjxXbDxmei98u4mKUbcy//O7Ni0n97zm8JJQwxWVTPjKbxteucblWum+0Ji5RXSIyGez2Vel1O4CO/BMmAZibDZRkRoaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458741; c=relaxed/simple;
	bh=k3cMIRpP9MAdOLr6JvQVd+B72Rzr+z/tx0HNQDqxZW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPtN/MBOqjK3pRfzcfFHXHTMSQO1vfrhFlyDL4YXXFM31M3PcfEfdmK3bGJowbBeJ7KbesM0tPVHvyLd/gEISbH8kaKAClC1xx5FIrqVms16V99tlFhfiML3YhjZ1SgiL5c+O5sUGXbJOlYnLTBD0m50sAtUL3Y45NCBkM+LmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tubrorf5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-309e54e469cso243844a91.1;
        Mon, 05 May 2025 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746458739; x=1747063539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3cMIRpP9MAdOLr6JvQVd+B72Rzr+z/tx0HNQDqxZW4=;
        b=Tubrorf5kKJ75I7OoqGNnEJbDGVPRWJaPLHq45y3IKBNHCEBMgYpUYsVtrLPAepSBd
         PNE0iqG1N8PLDbRSbp2UbJ+83pqsNPqHY0pcdZGnlXH3l/D/wrJIGQ3VCIv7tTOkL8RH
         3UsLdcSzVnAlMZNM3l9c9+/v1tOjZ5kkj2gZW8D7UwXAdzJqC4nFf3C20tC3rAnO9PKA
         hOJbzrV4NGdCknrA7e8/jITrw7fq0uXDZgrBjin4I3vSO1vCXV0G01kmqNch5bHLNgkb
         GCUetTpodAn+s452VzC+WgMJcGA+ImH/GlvboUlfH57R+D081wb1SlC8CSXte5LnuYWs
         Ae8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458739; x=1747063539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3cMIRpP9MAdOLr6JvQVd+B72Rzr+z/tx0HNQDqxZW4=;
        b=u2A1uHn14JOnTm0FJpyF2JbS/mQK87XF8A31v3MGB1KBOOZEqGg6vXYN5cx4QPEdow
         5uRYIBAud2cOkytmPe9mt0e55T+KaNCYSs4nZxEgWQ4qmrxr0SKCsMx+gavogxntopV1
         k8PYZtkIggfUDwBiP+jreZKEVBk+SwtvAIZdhGsz3KJJpUW0+wJ/H7+aN/Yzo5fffBOJ
         orfvcmb4M+y1popuPtBCTlQbA4z2//FZ8xFWAsAtn8bm0EEyNOew0s9I1NuJMIUKb3LK
         AGkyXlWDLXJzK92QJLpP/2mSWb+ibtS3sfOvGBPgq4QMAgSX7q6dL2Vh9iii0Jit6cbg
         eSxg==
X-Forwarded-Encrypted: i=1; AJvYcCU4NtS7bE+cFvPtgB8Hc6pvU7dIX1Lmnh1l+j7jfcpBn3lGgTMo8BxwBElUofgIY+sI4+V8JUKR@vger.kernel.org, AJvYcCVsAmvRkCHQbcSViqFNj1SHmyZLILP4UbIBKs9RGgIfzYKQJeH/cFPZ3qt/5RmkbGnhni99q1qkDiK9ZJI=@vger.kernel.org, AJvYcCWRhSWmtN24d9peGN92CMyhJSfmtR85UOINqBYzjXMKFGBtFmmSQaGdUjnIuMpW4ZO1TrazGBemn7/7/+fA25c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPZ3nXeLqUcxnSiar4z+ZTp1BD58rmG9/Kxl3Syit3MrPPVMy
	frMWeUWE29PpK7iWUAtMMnL8KZeGvOxNN1EDK+tXjvFq/FLUkXGzH5FXd+Uwql8L/QzaVU7o0Sz
	9DHu+FOEj4G/pV3lkESR+9X+62wmGHUoY95U=
X-Gm-Gg: ASbGncsTA3Gl2p7EadSwJJnWESp8ij5KVAlvX/kazoTwTNI/sye7Oikvr0HgSHI7UT8
	TEz01IlL2L3j7ccZOXDSoS+v2WV40LJM/AfqISzBlcKjaRKdqhp2AnRp/4+8ANIEqd1BGM2voxw
	UWeXRmYuDzbRnARKoc4fXCjw==
X-Google-Smtp-Source: AGHT+IHRVyTkZMEkrjl1tb+xhWRz+XOO/RG+ywEWuBKUhWxMwlE4Nfhg6SesSBOEedXa+f/GB+dArhcsLbsvmsYMM00=
X-Received: by 2002:a17:90b:1642:b0:30a:28e2:a003 with SMTP id
 98e67ed59e1d1-30a4e621a86mr7214089a91.3.1746458739173; Mon, 05 May 2025
 08:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502140237.1659624-1-ojeda@kernel.org> <20250502140237.1659624-3-ojeda@kernel.org>
 <aBiDd43KSHJJqpge@google.com>
In-Reply-To: <aBiDd43KSHJJqpge@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 5 May 2025 17:25:25 +0200
X-Gm-Features: ATxdqUHjO9VoZGiGMnlK5x2FmYOBWwyCMKRYdIXPOYP7wkN06j2ETlj7lPMEaGo
Message-ID: <CANiq72nLLQcuMou_zLTiDggpnS9pLySax8QSNxD9mU27eZNPUw@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: clean Rust 1.87.0's `clippy::ptr_eq` lints
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> For the list file, it might be nice to import core::ptr instead of using
> the full path each time. Or maybe just disable this lint.

Since they confirmed they will backport it, I will disable it locally
when applying so that it is a smaller change, and then we can
remove/revert the `allow` afterwards if all goes well.

For the other one, it is a single line already anyway, so it does not
matter much.

Cheers,
Miguel

