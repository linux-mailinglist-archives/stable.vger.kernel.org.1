Return-Path: <stable+bounces-132362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6EA873CD
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 22:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306EC18815B7
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81B1EDA22;
	Sun, 13 Apr 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekQqTnwm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AD17B425;
	Sun, 13 Apr 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744575676; cv=none; b=ensRfr5boQhjyDCZIGZSEASW87v9pWIaIuliK3lyVcewPSP0Yu7P9266o+5LoVdIdhGQYzeS7lHOMxd5hE3jdJ0wRa1VAF8pOguNVmAisshkaZvRvlDxpE8MbrrymbyfHmzcLcu7evcB363YregMl9S4dLA7YdlR+FXooskn35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744575676; c=relaxed/simple;
	bh=wQojJBXzJlTHOpAXpbc1jTR7Ss/PzQRN0e82ejpEgU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXb50Ojn2JYmZVV0ncGj5KgHa6XZXpiuQSNPAT7vlmEOPOGhMhUprok85kzoS+h1PjNyqRSncc6W9rUR3PCdFXo3ywQvhPoiclYH1KqiBEmSVV+Kaa2uI1vgG/ifVfvPkanMHlnbQgn2omwwOUc/Gk3xWICdfARd3XJOYzalVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekQqTnwm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so726353a91.2;
        Sun, 13 Apr 2025 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744575674; x=1745180474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQojJBXzJlTHOpAXpbc1jTR7Ss/PzQRN0e82ejpEgU0=;
        b=ekQqTnwmb6Lx2PteEuv1VdEm68LkAVBjnJiecDktQxwp0dHDe8T9Mdgw50CZ6pydOJ
         fTuLrScVjkSNq4uuk/yvku9WeHewDVmkNDMZon8Upzjdk698Qf5cAVqYsgrO72D7JGXp
         Rz52RDe6nlcgKD/A8+krInQzSVYG5CzsGpKNOylK21M7CnzL/aWkVGd91T7FXv+3FR0o
         Nyt41V00VuBSlNBKyYlqqFXGnrZLCIGF1++pHxl93uIUypk64L7p9fbNS3SZKto6sY1a
         nkQ8Xs85lsL47DBIWxEllTWUxGNyaAw1menunFL6hqTLa7T0KBNWGy0DfXBI/gjhT1MI
         2PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744575674; x=1745180474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQojJBXzJlTHOpAXpbc1jTR7Ss/PzQRN0e82ejpEgU0=;
        b=V1J52f2RBPpYE/5gdWfKM+wLn7HS1xWkcBDQqMgd+if8OyoR+Z3Na5q0SZ/4HbNDKx
         SUM6DPqo9BbLn+GbP3ucc3orfS9l/DvDsukbjEN4cqYm8FTxz+9zyqe1ybe43Mi7VJBc
         kdHVbNe451FzvUcAlSr1Hw90rZMmvq/jKRJC91apXQo2ES45itAsx9OWnJvGGUe4aEel
         S7ZoyvXZ15Vt/YRYdEhZfxv4IpBT8YoZBgmkOfvjGWkFIF0i3hlOVeSQNZvtqkCkEn8m
         OKz24AasAdgJhrTU4Kbw6NCw8ZuvvAgBb3A+aJh3b33HiU672p1jQbqw1uLlUjlx904D
         Kfag==
X-Forwarded-Encrypted: i=1; AJvYcCUbmfQBrK6VxOyAvhO9CAdjOTb/tKZAWSIUgaJuf6VSvqsrXOo1oj4HbK2E5FiGvJGsE/qhDUsyz3DHHPM=@vger.kernel.org, AJvYcCW1P1zMy9Pj+q7ZLXoL3UEsivWxvii52ujG8hqJa79ghv2Ju+/qTaX0JID/v9P0IHfxGGM8NO6n@vger.kernel.org, AJvYcCWJC5aRPsO8h2GHjLxaHuFbH/LOCP0oJdLAaWluiBbD7hGiiX+n1ioAyze5PUhkWSBJp5yNQpUHT1y5RB13F/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDKeSgRcqhBW1qLCwPZ0RlqRptU4hC/dZFfet/R0SSLveOxxiU
	NS425Ps0l4WrexVeZEsn+w3rcCMXu5Rr/AkTMcDhYhNtwoVi8UQHpxwxV+j/73d8ZVtjVrjycKU
	u6jnJzjHf/Rw5EjDKXSCvRjVsluw=
X-Gm-Gg: ASbGncsYneCjgEu5GcYjogJ+aYbfE7kZNkKH0jfvPJqG52UVZFazDzeNrrTQKr5ACy4
	MrTBBPRW19VZzbpYdRQelvjj3OM+IFU8yJKBqBDLaOwa+FzTKQG52v1YMEtDoN7CMWHGdKG6nj/
	evs4iGwr9LkQ0KQjelDJwlUHvVk91aT/Cu
X-Google-Smtp-Source: AGHT+IHgC/aFHrf625tyae7K7J2fuI+kFnrOeyX1zk71aY4lL5CN1XCHDAVntE6UxNra5dZY9rZcYCPgabyfDINUTnM=
X-Received: by 2002:a17:90b:390e:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-308273f3592mr4946965a91.5.1744575673973; Sun, 13 Apr 2025
 13:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>
In-Reply-To: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Apr 2025 22:21:01 +0200
X-Gm-Features: ATxdqUEbJUZabY5ly0oKwSmSo00qbXw56zoRY0ep3Vfv-E42xwj8kfluLC02Tl8
Message-ID: <CANiq72kJ+tv-P6+Yq7Bg+J73q93m+EKV_4E-GR=sdY5KRgCs6w@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Use `ffi::c_char` type in firmware abstraction `FwFunc`
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 9:27=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> The `FwFunc` struct contains an function with a char pointer argument,
> for which a `*const u8` pointer was used. This is not really the
> "proper" type for this, so use a `*const kernel::ffi::c_char` pointer
> instead.

If I don't take it:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

