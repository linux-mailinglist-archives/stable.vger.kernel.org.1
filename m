Return-Path: <stable+bounces-194596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A83C51A03
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B66123485E8
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666D30214C;
	Wed, 12 Nov 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irVTe6IW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C92F0696
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942960; cv=none; b=VfG7JQu9rBvnWJmLSK/vFLqcDfDHDP4PBkWVpzCqufElornXwEKauJLG2Tm0JFjeLloNrPtcpIRvIkB81TGTg0NXkECdTaOT8fHC2CaXjq3HKXq6e2tUoFR4/HVcGcm2fIlPOrfuuzYRUCzuJX77oSvFIUnwW0PDPFz4lDPV83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942960; c=relaxed/simple;
	bh=YPNEHX5E1EAY+3JT9FxU7dtFxSUrM3ua4vlSvyYLYVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzTVB9q0NsLFE7y8j72PEC0uZjPdVG7gZF/XgXWTC43jhUlCHQgw13KzW3wU5ssjZiznEaQ+vTTF0zObMWPzoR8DL/y9DNz/eCGN9Eiy1Q1L5MTn92apxrn4Xe3yjWxMRG7uzVYleuSjnwRXJEMumHYhN0kdbgrKaT2Q4SkKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irVTe6IW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29806bd4776so706785ad.0
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762942958; x=1763547758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0B276sCmGuKPqViJUBQ4DCZOBYFMswfLTqrPr8TLG8=;
        b=irVTe6IWHxqBKPgIas1Zkm+IxkM3V/6e/25RcdG8xk9VoJc4nf0Xy9xsP7/ZxKJNRD
         304wflt3AHsL4xGOLr4SoLkUCCTvIgygy8ma7fh7mWqo4yx0lNaSbNZWlqobsR3rQ9AO
         4Cp9ImIBrmxFXUvuQTLCLeOCRNzNRT+j+bwWdDGiXdw6FqqW7UgGy/ie92pMDjHaMp1H
         6BPLqf+ZeOnOH+dB/ldEMD2TUM8qicoFIFzdwOYyFD3+opy7M59K49FDzZAUqKeDQ734
         0H3SOEljD4Il629Ssk07dxbKi6Wp2fAsA03cjYys0T++Wj+l/YTeEUQAcyxFUBVsbhIi
         7iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942958; x=1763547758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0B276sCmGuKPqViJUBQ4DCZOBYFMswfLTqrPr8TLG8=;
        b=sh2wdxaJgWkdSYdBj9Pb151qu4EFueiHq6U4Mapu8DaxeWPs23dHCie6b+n3QGc1e/
         AN1UabHzGfkgpq0+c2wpqz/2/Pt8w9Az58dEca1DNMZzAVpwDnyuXlrugCbiNTZz2Xzb
         henyA2XR86ergpbH8jGY/yK9kfwAiKD7zx77rLQXYVzZnPUmDDWp97F8Rnvbt62N3d85
         3dIONGWSU0BB1nTmtJ+vbROhLINshahtuGRk9vhgalzN4hSkKBI+0Merssjji5XoC8Kv
         ZRb65Ng5LxF7b65Yup6L6RRwonp78gvlxKnfUYDuXDZNWgi60shL5NFA3CG4rJSs4ApV
         6avQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMrUNcqjOSsRx+YMeJQCnWq7TaDd8XtomAjfAuUQZmZk/rRdxBE0fIH1P8tALkCDI8m+YKMgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+psczi7AMVikYp/s6HpaHyS5EsxXrNyfAAVQZYpeuiFkoprfq
	UKCGQZDt9Xk5MPpCxLYIUZCPuZySD0/QgIWvqBNyJXd0h1dT9njvDYjmG9emhI19kOKzU3Z2jc6
	GT5vPMaqKLHQ9PU8NkSEwHqVl7GigCHI=
X-Gm-Gg: ASbGnctJLzA0v1bzTnq/e44PVnw7tQJG2F3wJTDOK0Kgmu+20v3L7kXGIIOpbUyAagh
	j7gCYuAk8OPLJ0EOwXXgKub6SKJwmt4obXqg1y/kK3XQKqNGAHMekyH0FK7774CQwYkRz537P9L
	jHeCtpeyvHIfBeHWjBQufODYWamLuVOE9ZUkxLiXBcqG9tDGRLwmsQsxiEsP7hmccjn3j6YtzAC
	kyo9bzo+CKUY50V7LAPlkfZO/Xzi0kMz+jb1ZgxtVnYgd49url6+5D+mmlLUZPGJZnqCHgF6+F8
	XH2ieK3bihv+eJeDx39JmMgda+GnKXpML+0v+DDKzWKiJr5I7LjB9qeWiZPAIoFMues67xX4m7N
	ccCWcVYPn1XX3Xg==
X-Google-Smtp-Source: AGHT+IEZoSqjm0t6zN10oagsZyaGUA55TrpgWglstnMOybFlUdjZoMdhp86GzVPanaCUu6r0dqbnhK9HIk5xK9dXxsA=
X-Received: by 2002:a17:903:18e:b0:297:fe4e:d368 with SMTP id
 d9443c01a7336-2984ee3ba7dmr18188305ad.11.1762942957656; Wed, 12 Nov 2025
 02:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
In-Reply-To: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:22:25 +0100
X-Gm-Features: AWmQ_blKg4cu-v3P781ZJkYF9Gq3eqlBz7dX5cAIvvyUp8LMI-DCXNtY1gWIHsU
Message-ID: <CANiq72kCxh=Zen_fRrU8dVffGpNtsfNwMO1agC+muHd8ixMTpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rust_binder: fix unsoundness due to combining
 List::remove with mem:take
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 3:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
>       rust_binder: fix race condition on death_list
>       rust_binder: avoid mem::take on delivered_deaths
>       rust: list: add warning to List::remove docs about mem::take

Greg et al.: please let me know if you are not taking the last one
together with the fixes (so that I pick it up). Otherwise, if you do:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

