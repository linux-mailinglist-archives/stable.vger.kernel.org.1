Return-Path: <stable+bounces-145709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64603ABE409
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0AF7A4BC7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86C27FD50;
	Tue, 20 May 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymwj+OuI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3D248F75;
	Tue, 20 May 2025 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770614; cv=none; b=RAvEvrIdOb5og/r0p8NEnyhbiaMN6ZjG9GOla3j2cGWjUnX6641P4gKXp+6sqzXal5ya3CuBmuROGlVajmsqtqj88+Twbc4MJSmzXBEBhyk6Lca1rXgTbNTeuClKjqQ988V6EAvz0Jw2m+MF3sExy3F5IY8pv9THmFP61wElLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770614; c=relaxed/simple;
	bh=SwiwaSdg4eQ4oxNyBzoukE5k+V15JbB2nsJEKxCXjVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lz4EYzOyS9pQAoE/mMWGvTyBEhU4SJlt04Q9IRRpx4D4QDfy30tjXwAqRnUxJ7aC+/mWh6NbqUf36rcFEvEs+RKbwsnNu/RQshT0VqQbpVLmaKCA3XKpdwgmlwo6kjS9jFKjSwcC0IDov+COFXCYxBA/MF3u0wrPUyMMG3hyYzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ymwj+OuI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ba912ba1so5617255ad.2;
        Tue, 20 May 2025 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747770612; x=1748375412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwiwaSdg4eQ4oxNyBzoukE5k+V15JbB2nsJEKxCXjVE=;
        b=Ymwj+OuIOozD3ONqijb8ZHfsY28/N6YldYrAIMdcXcN7ELev5vEVrJacrSRJCs+QgC
         WXVhlEkT45UGymdqo4XdbPZvsggjJ41jUYenkEGm9OB+s49sJMgRcQnCsnAPVp1t/14/
         WFgD9ibfGuYkWsczp77naIeyXAr0/sJlR5G5u8+pEpM/TsMXVHWS8EFoe7FcXc44RIH4
         0ahjMZXS6RlObdq9qlDywHmnHcJhhfbUE3Ux86n0GgDKH8DlQSTuhUF8mB9AJ2Huefjr
         DP1rSZSu6DyJ24UVeAStXYDl7pdvd0t/3ApGEGyCwkArY9vI6QV8nLeJmZsAuqmgQE/z
         AKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747770612; x=1748375412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwiwaSdg4eQ4oxNyBzoukE5k+V15JbB2nsJEKxCXjVE=;
        b=tBnKVX92v+cD8B/PnDun1JVrWpHTJ1N3I70OmYa37yh96Jg8EZZ1lwq3ZWxAJcYPxu
         I+d7qIR++Rk/sqMJOUTYKhnWmM8Rjj+IbOZIy64wQZLbAsEBbDypK9FderWuLiUgYUpt
         8umSTE/Yf486AS7mJQzzFtpcQOuzFayo+o3WbulLKiU9VpHm51pAK9AKeqbyzJqgD6Wd
         s5Xls/OoD9gWZPQD7G0GPjn5czWvd3FjtYlaq+7wlxNTW0/A2Wyj/8j0JVW+WvVV5PPy
         CYkkXhmU4IChcLgflC9qRwQ5Ad4xJOXkA8Z+VUmoJq2TF03guTBy/nEHaY1hm4IH48hH
         ghBw==
X-Forwarded-Encrypted: i=1; AJvYcCUtJYTA05VxiXUaRWk9mkzl9IvkYqs4zfgYuT+nmd2keb/CzTY/rK07Q8GqBXAvLE0QmgWHJ7C2wdeFvayOO8E=@vger.kernel.org, AJvYcCV4wCnc8GlIlP9QbADHItq0feMLMqr/6re++Jttq5L+JMzd1L5j9Gk7NkbhQagGX6jYTTdXdZhywOYDXk8=@vger.kernel.org, AJvYcCVc8L7tHZUvU4GMPpWfKWjJgLV3deupFeHYUul2hM6jm8kq/E+cZv+zmzy0Ck4bkLKOfKvFg63R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vuIRWUn4UIJ6ZkTSpiO6h6ymHbEG30L4J/xXe24zOPu4TL0n
	FnQwk9cQarRfTRG3MtTNUaccMzYFIWz5vlDFWfzd5KBWVcHgafJQEI348eRxyfAuGQ8+12kY+Ni
	jzH++lQFq98sBdZqze+Kr7Gbljz413hU=
X-Gm-Gg: ASbGncsKhJJKNyBPs66OHncuu3xUX3aRlS10v1AFOyrAZE8woqAtZVZe+nHG5Gbooo0
	l4nmbmauoVD0KDQcOQDosrdxNFWgeeoZqMjcO1B+LyfxjH7y2x2Qvcpyh2wNFXm1vRhyWnVLlMS
	QBTeBHuMkqCnC8ZeoqaByQBI8jzhv/HW6h
X-Google-Smtp-Source: AGHT+IH/GtxXV7pO420TBwvo67pv/+vuSvNQns2cFPY0rjC4suXw7a7ox5Jd3eZobSFtn1EIW9pudsE+oeNIvVQpERQ=
X-Received: by 2002:a17:902:cf07:b0:220:e1e6:446e with SMTP id
 d9443c01a7336-231d437f0damr92624395ad.1.1747770612110; Tue, 20 May 2025
 12:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502140237.1659624-1-ojeda@kernel.org> <20250502140237.1659624-2-ojeda@kernel.org>
 <20250513180757.GA1295002@joelnvbox>
In-Reply-To: <20250513180757.GA1295002@joelnvbox>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 May 2025 21:49:58 +0200
X-Gm-Features: AX0GCFuOY7Kz9DRWzUOglkPbmrM_Bcksvg1f806Qs5Umb82adzvopIRqYuPJnhw
Message-ID: <CANiq72=kkejAwQJLYNjN=25Qf7qr801_Gr9zCZXJTEF9Ou54gQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] objtool/rust: add one more `noreturn` Rust function
 for Rust 1.87.0
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, ttabi@nvidia.com, 
	acourbot@nvidia.com, jhubbard@nvidia.com, apopple@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 8:08=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Any thoughts on how to fix the warning?

For future reference, this gets fixed with
https://lore.kernel.org/rust-for-linux/20250520185555.825242-1-ojeda@kernel=
.org/

I hope that helps (and apologies for the delay, a bunch of us were in
RustWeek :)

Cheers,
Miguel

