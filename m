Return-Path: <stable+bounces-132268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F3A86064
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97180164940
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E501F417A;
	Fri, 11 Apr 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZD75URx5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA61E89C;
	Fri, 11 Apr 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381099; cv=none; b=jPnnC8UlfeyCtru1TM8vNaq4H5OdCr3952/3KLDD+47aVKlbv9oRrqXCYnMtAf72NYAP4gZVMyv0+uYlvPC++4/uLK5CVJ9CyZc91fYGUi+CPCDN3WXaxTJvydMLt+Q1Yagm0Of10MeyzwxJt004egzLg5eGCRKiIlO2XHKnrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381099; c=relaxed/simple;
	bh=fuLmkbGQ9AE0lEuqX0lr8BR1lAWRQLYNrT8LVsLS2dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7Hbi79bylOkxijV2TXWgasbV3IT+iZT6414GehX65efxPqn/3bDdkEvRMqr3xMborii0oElMYZVDZ9+lOVIBos9ioxsUEIAiFTJEw7l8i8GArZZ3OvgYRvLfpOJUAL51KqHb3LDigVnlLgwFWJ77g06SyqdzpX95x6B0YSugiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZD75URx5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso313334a91.1;
        Fri, 11 Apr 2025 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744381097; x=1744985897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuLmkbGQ9AE0lEuqX0lr8BR1lAWRQLYNrT8LVsLS2dU=;
        b=ZD75URx5A8K/1xGGQJDhuYKRSYTVmXPSBnUvjkLG5GHVbMpU/diSwtGkv2HIz8fXQv
         XZofO74aDGJ8lMLCwWHMhGr0OsVItPHDGRYCn4W+sGtS3oFMDX1HGsiGYuuneYfsEdtE
         Emx3WCUhTK4eZHjKihPvlVw7YqrECWj6Mv9m1EvUIsfdKqdExUam7sOyWsonJ53fcQDg
         yYQI4eT1IbD9y3qpxctyI1WluKUtlGE/GtP2rOUDiitrJGkIVHo/CpI+LRthaaXCBSxC
         uQK0kCnw/Jy/KynKPOExlvO/HPrDrsBCIwE9c4tjoZy15g0qi7jiheekRU5zJYOs+EIR
         oAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744381097; x=1744985897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuLmkbGQ9AE0lEuqX0lr8BR1lAWRQLYNrT8LVsLS2dU=;
        b=Ddxm0i0euVZhciVIl91yYf7cAsoTrhUWZNOJlFkWggS4+RJyLw8y+ycXXFK4V58AIl
         XMPs6tpMaKUOcpVtdkB7V4GIFuhuzsljrf7DMVXeObqeidlWeqf+u2dZI+0mxviOtsPg
         lLuV9exxcoZLt/my0dr6NSLhT7jzUm341dPjMW5gIe13wwUL0pAum4qhsipV6Me/qm1v
         r9oCWRXFOr0Pc02GD1cMH3uOr5tOrixt3u8BNUKkBUDaMx6Zg0F2TLlsoEvjqc7BwYdN
         owkdDCist5jLBb1/nLolkBahi0cdJHKi4/2syFx4mpFjAiEOsM9yqWu71NPWSRpwJcRC
         JZKw==
X-Forwarded-Encrypted: i=1; AJvYcCU/Aep6PQkMN3YyaqKCz04jKSvKW4J8LQm8bOYKF4rddt+RiCql1MEV5y0D9EXUW3cqwg+HzUMjktt8oZyNvK4=@vger.kernel.org, AJvYcCVv/yKK/FqWSm2lrAKpCUW//6FiVTC4QsQdb869l2ojDWSDKL5K1U4R09UWQ7NS7eGRrWB0OARt@vger.kernel.org, AJvYcCXPnE0g5xA6C9vgXmrxTM9VDl8Ls4agvGWknm+jaSTZi3zCIcERm+M+tH2xcFvyTO6Ish0N/5mwOjHH+qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmkI9GBEtp/MPY2iznxfif295JfuW3m2OZTD/jVWW96KbQ5As
	dT3ha4UhfI4lcyc4VjNBoDhTp8L3ylkDWdiXwVqMFWe/7q0+lnZiYLQmvtaGIdf2uiu6V09DlO6
	rNDR1EXAul25XZONnhFhfKe1hSTk=
X-Gm-Gg: ASbGnct6fReGZ674R9PoGbBZGFQOS78XsUxqOrn3W3qFAu4gRPgdbj2fBz7VnJio9iL
	O57z+MBavklaX6m8UdU/EnPvbI8a7gCan6MpDcgvnJcfe9pcPuC6WI/8Idbb46Gkwaa1NJeCSH0
	QLPhtXsmtWXg31W747awwqUw==
X-Google-Smtp-Source: AGHT+IGn2B8Sk/8cQPoHh8yzlKy3DAGcSM68xE89Bdl+hrr2Ja7Epy8cWbpV8fXFQV3WDb4HuYV3tkpZ7TgbxMiCmL4=
X-Received: by 2002:a17:90b:3912:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30823624fa5mr1618122a91.1.1744381097389; Fri, 11 Apr 2025
 07:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-rust_arm_fix_fw_abstaction-v1-1-0a9e598451c6@gmail.com>
 <D93TIWHR8EZM.25205EFWBLJLM@proton.me> <CANiq72kc4gzfieD-FjuWfELRDXXD2vLgPv4wqk3nt4pjdPQ=qg@mail.gmail.com>
In-Reply-To: <CANiq72kc4gzfieD-FjuWfELRDXXD2vLgPv4wqk3nt4pjdPQ=qg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Apr 2025 16:18:03 +0200
X-Gm-Features: ATxdqUEiLtXgDKUXmiwfmi4EnlT6ig8SgUDhLxUqtMdesasU2J2pJNPsiK-qjQY
Message-ID: <CANiq72=+mYOd-v6W+oZ1hpqRXWn1qdKOuLwTgoafwNViWABj_A@mail.gmail.com>
Subject: Re: [PATCH] rust: fix building firmware abstraction on 32bit arm
To: Benno Lossin <benno.lossin@proton.me>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:15=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> In 6.6, C `char` changed to unsigned, but `core::ffi::c_char` is
> signed (in x86_64 at least).

By 6.6, I meant since 6.6.y LTS (since that is the one I remember due
to backports), the actual change happened earlier but after 6.1.y LTS.

Cheers,
Miguel

