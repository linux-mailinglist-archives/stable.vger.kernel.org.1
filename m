Return-Path: <stable+bounces-114224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E829A2BF66
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630453A9CB9
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8B1DD886;
	Fri,  7 Feb 2025 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/sGvnfM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2D1A238C
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920907; cv=none; b=Qh7TpUtaJA3tqaBKkzmjOwAYRgq7MGJlq1JvKI/c13KPki2sKTlIJ5fSlWxcRHM6J/DTVOQbt+qdQ8UIaVFQKp+2EpCbDOBmu4z0+DlE1bpm3rfbXr1ZlhG/FcY8ZsJtfOigwzSY1uHRplG8j7G/ZL2JD0ECrROUnxc6EzG8WMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920907; c=relaxed/simple;
	bh=WpzvF9szQZoGnzPsK8JGH5qUWtlXbF0BSAjLUqm0mEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hR9gqFc+c63KT2+G84j9yDcbmwsGIUtCRonXIhZi2mrLXWliLYF27r+e6MFBROsQt9RA/SOcT6j3ShiQzo/rGTdu16fv89hvwT56BG5itBI3P0svIBAJ4q+fdGJQr+TnNxSXD5wP0DTFBLDz6WZ6vJOxtNOR+S7UqkaGetFMZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/sGvnfM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso18214415e9.0
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 01:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738920903; x=1739525703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2480EBnA/WUX+Abw4NwvBh7SdyU1bom5NZ1qUtPF8aE=;
        b=m/sGvnfMW24DT6nhxOhfOe1h1xQyRFlRZfe6ftk1GPuJN9Nt73iAsFSwlJcW6AUotf
         qXedEdlVtR+47n37WKPEU1ccA05rf6XDlw/p3QAOk0HnjSg4ybbpOboSVoRolmCud1tF
         2ZYOaDsxLo7T33yTWDCgWthrsZXPBgCazkQFyb/gJ8s1mq/e/RhHETveHjP7u16cDq5R
         0JgPVEJKwREsmjsDo1wnN3H0ohO+xLEdp7KzRpeOzojpMEqa1FfGZTxYcB0IlZ7Q2m8L
         1WaW5vPY3G6t5hqIKxzAOcB8VeZg2T7X2QH7ocvbnSM+KuYeRAs2K1Jf9mvK2VofAfZT
         toIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738920903; x=1739525703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2480EBnA/WUX+Abw4NwvBh7SdyU1bom5NZ1qUtPF8aE=;
        b=vrvQnDgHep52kmjiLhwI389eedahIL4UeygYDCOm893Qubk3x5ZRf5VZUOvYeaeA6k
         0q2AOgisefRxCFFyRP/LCUJI7Xctl+weiDsLFG6+XEDXi1iIyZOlC6hfCs7kwpfaXQO8
         M8LeCRFzbKnPXnywtwDZJleIP6+PxXW4Wozvo5MiBnVRt89GbqHpxCKhUZ8fQJdQc5La
         nDyiYc/P7AOPLPUp+J3/JXcZSQcQM5VMk30G49S/g/+tgtMi+aT6fwh3PrL3TbQ5cKt9
         g0N0Krk/DEcQ84MmYp2q7Phdz06lV8Z+irODNN+TPXNbpxF8y1VwjHPnIkFuYPehpdwq
         OLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrqUoJ75oaeTLW/XqjwsCYaAsPeqzqUBx9HddWH1HnQ7Kr4C4dtHsfJGLrUDC4wUF7Dyo/vm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJn4IJRJT4KEpljSKJnhJBlehjF9daFoggKR8NPMpK/Y9EMBN
	U4UsQKaSdB94swbft8yTAw39S772F0WrGeR5BdauHnO+UCHw6aDM74H2L4g8VllAhs9EddLn41Z
	7/cZ/LMwP2BXmXXW5h6mpCx36lQccg8ddLYUm
X-Gm-Gg: ASbGncsn8OvGrsWgb6THfVdmC1sY3q6je3m0EgQQhVuGO8uZ0hCMsxjUOvEiHQhJtXN
	puB8YGtJAl4LBvZbbXKw22SNnmPhPNWB9hzHpjdvUFmNLSHdpSpAvJN1l+P7TTvX59V79u8ccDw
	gpkwGz0OQ8CkkYrVp+M4KbZy1bA90=
X-Google-Smtp-Source: AGHT+IGhUSNu9zvLoiFSofDY0OMxcNSFAl8TddmlA05himP+cOcm5XjI5yjsyVV0T3Kj//6iMl8vsfnlp3YycnJZYfQ=
X-Received: by 2002:a05:600c:1d96:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-43924991035mr24650525e9.16.1738920903421; Fri, 07 Feb 2025
 01:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206232022.599998-1-ojeda@kernel.org>
In-Reply-To: <20250206232022.599998-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 7 Feb 2025 10:34:51 +0100
X-Gm-Features: AWEUYZmEX6j_hGQINsn4AjZPTMCvx9Pp7UkxCKUDf-6T5E1oNpjkEWdcnoNHXT4
Message-ID: <CAH5fLgiJDrNPe4hT4HrpC+bcskWtBcZdcvAfdnqpY1eTHVWk0A@mail.gmail.com>
Subject: Re: [PATCH] rust: rbtree: fix overindented list item
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Yutaro Ohno <yutaro.ono.418@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:20=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.86.0 (to be released 2025-04-03), Clippy will have
> a new lint, `doc_overindented_list_items` [1], which catches cases of
> overindented list items.
>
> The lint has been added by Yutaro Ohno, based on feedback from the kernel
> [2] on a patch that fixed a similar case -- commit 0c5928deada1 ("rust:
> block: fix formatting in GenDisk doc").
>
> Clippy reports a single case in the kernel, apart from the one already
> fixed in the commit above:
>
>     error: doc list item overindented
>         --> rust/kernel/rbtree.rs:1152:5
>          |
>     1152 | ///     null, it is a pointer to the root of the [`RBTree`].
>          |     ^^^^ help: try using `  ` (2 spaces)
>          |
>          =3D help: for further information visit https://rust-lang.github=
.io/rust-clippy/master/index.html#doc_overindented_list_items
>          =3D note: `-D clippy::doc-overindented-list-items` implied by `-=
D warnings`
>          =3D help: to override `-D warnings` add `#[allow(clippy::doc_ove=
rindented_list_items)]`
>
> Thus clean it up.
>
> Cc: Yutaro Ohno <yutaro.ono.418@gmail.com>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only (Rust is =
pinned in older LTSs).
> Fixes: a335e9591404 ("rust: rbtree: add `RBTree::entry`")
> Link: https://github.com/rust-lang/rust-clippy/pull/13711 [1]
> Link: https://github.com/rust-lang/rust-clippy/issues/13601 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

