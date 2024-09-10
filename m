Return-Path: <stable+bounces-75651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A1F9738B2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3D11C212E9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8414F12C;
	Tue, 10 Sep 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsvtzrK+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B55757EB
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975192; cv=none; b=m007ZF9e5ZoYSizFc7ZkpZ/moIB+j7HgtmFiCDsQqU157uHkRH7gDL8sMD/WQlIt5FFNKLt9ULlnSTj/DTRroHTNS+A6V1RpKwrjwRb222YJ477NLnDWlIGLC1A5ylYjcFeUDmbsfk7FBf1VGVnbt619M5HikUxt+E0uzzYpRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975192; c=relaxed/simple;
	bh=LKZb64kL2IL/0EjB8mVF/EDgVmwMcNSouBQsGFeSjBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s94VM7i6FyCd+1tRSPUHs09UepH00BfAMr2mdbx5TGopSeqdffkUiR3d236fsabD92zLTMWZ/QKV8B/7MEoGB6EjUuqW1/Hp9r8GABLYX/m4s6e4ff7yJnM5RS6LXp+FP+wbMrHmlbXbVfQxlwet2wgs3PAPlVhTwaVRVonNl58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsvtzrK+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-717931bdb24so442231b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725975190; x=1726579990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRQqM7q00JaV7t0nQiha09YCJYOF9iYtqaIexHFZDIA=;
        b=nsvtzrK+x2pNIW3PEomLUivi8+UizJOiCKCuiBt487kie/qrpUZsz+hYLST/cgVysN
         c/rxMmCkNzFXk4LN2ILc90kemwaCnTNOR9EiF+NQFSYYNzbZsYHLM+9ogfI6gk9jkbjS
         deIejPp1x5wYrMSJZWa7nb+4b7rMM7aC8RTnZSrBloyTf2PJvCpJfS/+2YR8+ne2Xlx+
         ux82zgA6RmvJCY3AjqxuHk+rq7tvbG/jICdKGJyzM1Ea3KL1tk7wAGQibHlPbXGTdMcp
         Blq7JTw4AalsHgqFJG8vl2iatYvzNZeN+50CcnCrOldTuNkw14lU4iAXTxqnI9MQJ4D2
         T9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725975190; x=1726579990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRQqM7q00JaV7t0nQiha09YCJYOF9iYtqaIexHFZDIA=;
        b=mfnWFZys9TFSBBfH9ubEs7axQFVDtlGCtZW59OcbsNbk7o1Rc9qJjTeM8sHClyk3am
         PePmqaE6iSLG4do54RY8UBbl391T2KdtYppalx0b/HAdXPNrhX20qiRlemjfrDkShPKc
         jJuREMV6T90OkwNNPJsr+AmpCtVarScjCE5O8BqMlDnTdOKar+jLGmDkJArTFNUYvs2X
         XsW1EZMAHnUEoatCaPYy4fwdoFXe0/gxew4sezqTqwq+YzOIJ+2pkqzjK5bSu2mv4UP0
         QVuLeOV9lb/fxKEBco6T9n9ooma+t9HuFn2I/mGWP0/h2hDsdIdc1eu0agP3TPecWTGI
         z0tg==
X-Forwarded-Encrypted: i=1; AJvYcCVdp2M5GneWmZ8kXpxJT+tRuwu/Sn7Rfv8lioxn/paRvKLtUPKDaQNcVQP8kkhpHqXrJuwAjys=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPgH4in6DgI3jnrFrXi6oz7PfWLfUK7eFVmy5H+aFsIlGzscZ
	VVsGRpUoCpP6zTKFIbushl7nXVM+mlrwyPa7aYvZ2vAneynfr3EvmeGdXLausV7jlaaeacU3xM2
	OO6WpOel3J0VLYI5qFUlgiV1JBCw=
X-Google-Smtp-Source: AGHT+IF3+V5H1YEoLgXoKtliBp4ULsvoTreI7caf1iTTYD25l4oH1MNrPzq0lPSrLAefbyE1/xd2tGEnt+LE40cbuZ0=
X-Received: by 2002:a05:6a00:c8f:b0:70d:2c09:45ff with SMTP id
 d2e1a72fcca58-718d5f92983mr8086158b3a.4.1725975189879; Tue, 10 Sep 2024
 06:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024090831-camera-backlands-a643@gregkh> <ZuAfjlv1cp79-NTV@boqun-archlinux>
In-Reply-To: <ZuAfjlv1cp79-NTV@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Sep 2024 15:32:57 +0200
Message-ID: <CANiq72muvaSOT2Ah8ZnFFRrkM-RRXXi9N5e=aP5YLCtSC2ro2w@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: provide correct provenance
 when constructing" failed to apply to 6.1-stable tree
To: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: aliceryhl@google.com, benno.lossin@proton.me, gary@garyguo.net, 
	ojeda@kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> > Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> > Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make O=
paque::get const")
> As Gary mentioned:
>
>         https://lore.kernel.org/stable/20240910105557.7ada99d1.gary@garyg=
uo.net/
>
> `Opaque` doesn't exist in 6.1. We could use `UnsafeCell` here to replace
> `Opaque`. I will send a backport patch later today if needed.

+1 -- Greg/Sasha: for context, this is the one I asked about using
Option 3 since otherwise the list of cherry-picks for 6.1 would be
quite long.

Boqun: yeah, if you want to send the targeted backport, then that
would be great. Otherwise I will do it in a few days. Thanks!

Cheers,
Miguel

