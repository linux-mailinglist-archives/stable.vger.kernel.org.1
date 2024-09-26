Return-Path: <stable+bounces-77832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D5987A9C
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED25C28346D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2B18754F;
	Thu, 26 Sep 2024 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNY7D4YN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2837186285;
	Thu, 26 Sep 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385537; cv=none; b=Y77Yflg9fwT0lF29Ym3XJIqZ/DveubV2C3xYcoM2Kerq9psg4ep7Woo6VTpOEtsz27/e7nsd3qIWkjrAkjhoqGI9vak1ccbh9pQidLq/3k37UI4/xyz8YMQKzi4v1+U1QWoGaqbpl353qY16Vz5nXRUixfF1QnjqJmGoAfzeD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385537; c=relaxed/simple;
	bh=LGh5AsLI6sNnLV9SP7iQOLWKOrIBJ3RbUytzbBRYuHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gd4aqlOZVi8NNoFrZeiY28tdRslSUJNvqoW6TF/am6OUvw2F/bdw3flDTYMDtPPaAq/hDFjf780j8aEzTYlYJL7f1ns8gY8/oxJRPJDXr/cFrbGmd1WsS/3QAql31zO0QaRuZjyUD3mqBJK5jK65VA+EyQ9T6pLhiIkHITqGcr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNY7D4YN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0a47fda44so167003a91.1;
        Thu, 26 Sep 2024 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727385535; x=1727990335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGh5AsLI6sNnLV9SP7iQOLWKOrIBJ3RbUytzbBRYuHk=;
        b=aNY7D4YNqMeYhfSNUZ8Bj6EQ1OmFWZSyOJ2HJ+Cs9EftHrRSlnZOzjUdoKKabhGST0
         JzzYJFT7F7IQhVrIV0OeEYX73LxUycdWVlyFfFxFhQ7i8nqtY5uH9hvnIVlFgL1pSCO4
         g1/22mPkmebW0J6Du7kBGe4d8LFiBTxAXv/jTQDbH4D2LN9ehmbbgx9gRIa5UujuLbae
         XuNa5XA8N0aaDa6nf2aKuef4uoW0QOILpQfJqZiXEZ+unAD9XnOseDe7eT1GeGY/slwV
         uMlga4nFe/wb/0a77dziGH0MuDLvqGVPZ+NBWhrpHmpSscnXf+v0Gult7/L3B1zAFRdK
         4Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727385535; x=1727990335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGh5AsLI6sNnLV9SP7iQOLWKOrIBJ3RbUytzbBRYuHk=;
        b=hDmNOl9nuUQZfNF/OqKFQJJfivEo8V02bGuXBO+8qb1mqzmtkgeEFxXMLHj+RMBz3E
         IYHGtcS7JaZOqumpjJllu8uml7D57f0CdX90cZR75d1SO1Mf5SmVqB19NiChA6Mnajly
         CJY9cL40l55MYY+mTko6DdwhZqGNgwuFga8v9anKuGd2uNtZCsnqwwTReY6Y79J0QkZc
         FARdtidtuB42m891uCOLnG7wYQaRninIPcsKnVzwxxakloq62k6acEeUUb7VcJuNOBGb
         a8EEeqr5pqKNTl7uuAvTOwdbA5Uj9oCDiw6dSoymiJf9gDpqzpkPyitBXI1NRk6h3xEw
         dEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFXkINVgquy3YVg6fsLcqiSIUaYAbatPkiNcd3/zG5+/2ohcW/pHIVdiq09PsxuILUTfs2GGvIgrBEGMU=@vger.kernel.org, AJvYcCUrhswl38WcdTDhG4eQRg756Pmxc9r6idtmFzuX4E2qi95guW5XCzrlwlV2g/du+xB+8Hqn6laL@vger.kernel.org, AJvYcCVQVbisLzOyGFcBQsCq2m0oYVEu96PxKXtTQCesNdgv5+faHEGe8qxv5booP+ZUYIHJdWCJOFhbwWxvk5vT9HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqFGOiYRYt22QXEq1t55pePg1Cdc2o4f+97fZY5DRKOBM0yeo
	MAjQPGMNgAfy8Y9YbA8MQF/wdUyjxXGOEKgTBWjHxQSVpxt5yOivBFcPwM416B2JeqADxk/l9yq
	1ue/8ng9x4ZDMgMDMDGxs2XYEuWI=
X-Google-Smtp-Source: AGHT+IGFtmXJkGXxZMp0hLont/4szEaqvFF8nPib6ydvuDhzQc3QsxRdvYh7ZnuMYvt371eM5bxZUq+fjBGol09742c=
X-Received: by 2002:a17:90a:ee87:b0:2e0:9d3d:3666 with SMTP id
 98e67ed59e1d1-2e0b87701a0mr542895a91.2.1727385535065; Thu, 26 Sep 2024
 14:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com>
In-Reply-To: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:18:41 +0200
Message-ID: <CANiq72mTnHNTzCX_FtSp53cjUj0rF-yCAoShN77RotMcz0L4Hw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: require `T: Sync` for `LockedBy::access`
To: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The `LockedBy::access` method only requires a shared reference to the
> owner, so if we have shared access to the `LockedBy` from several
> threads at once, then two threads could call `access` in parallel and
> both obtain a shared reference to the inner value. Thus, require that
> `T: Sync` when calling the `access` method.
>
> An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
> This patch does not choose that approach as it gives up the ability to
> use `LockedBy` with `!Sync` types, which is okay as long as you only use
> `access_mut`.
>
> Cc: stable@vger.kernel.org
> Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` with Boqun's Suggested-by -- thanks!

Cheers,
Miguel

