Return-Path: <stable+bounces-194515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A2C4F5A2
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CFB18C2983
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5983A5E8A;
	Tue, 11 Nov 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5/KQwCr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356C3A1CED
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884015; cv=none; b=EpwiuX2DWEOJg/TG0abYMeUERGHo4jRLgxvoLKXpxQn+yyvu3i+hWZ2eNzuElSI4UsqV59/5ObBioIzvOc0TjWeA6QQNrMFPwSkCfAIoywOi6n+TnuoA2g4vId+6caNdfnwVUI+anOBwWmpDVLhEgJU5Z0u66OwvEw2SfsnoQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884015; c=relaxed/simple;
	bh=dXCcz2L4q31xz9e5q2d/z2JUmJTdawzaCmsByQjKrds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKjbKIgfer8zVzwVFEa2PUglW3oollwrzH4utzshkrbzAWdNzaLoopfWezwTfuppfQm0EBtf/AAXjopxnHOI4wM2epe/coL+f5BwBjRKLGCi+/HR6huLbEPZViaAMD4VBLnSACYJq6FEIFgtCd9/maZIxVBi8Y4RNNQjHch5AQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5/KQwCr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b272a4ca78so6739185a.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762884013; x=1763488813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KxRP4BPLYg7Tcb5XFgRONVcpYRfVdnfnI154y4Yq/E=;
        b=E5/KQwCrp+LobwJ4940nqDSGyrkMndrBIKCUM0t1AbNW2tj0mECnWzQNj14vSAE297
         jv+8dTLD7KM0oGZDwQQex4fq/Hxp7a7JdQEGvp73XwRdnzqBBo62PImvDMMq703K3OP8
         uux0vJIs8Vkh8UtyRZ4QiMCXXh8pjUfkp33t59HVKbWyCGe0YA3ywHW9jM5tSdrJAIXQ
         zFc8Dpw8Ofbdayzp4sCvqLfY2y1p/FRUhw+VP77xrv1A22ikPAEHoR89buVcDlLH+MvM
         4Sdaiw/dewUDp3gWSHzKMbey6vpcqXjgFFSmIHgF9RpqtlHuYFqBLm5H40QRgGsXm/PQ
         Xb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884013; x=1763488813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KxRP4BPLYg7Tcb5XFgRONVcpYRfVdnfnI154y4Yq/E=;
        b=a8t4X6I++I3M3I+kQQBs6qfLY4vQtB2cBvzcJZ7tcCnom1tTTYaQ6sZF4U0JTairaf
         wtz4DXxI+w4Yufy922os94qol/EJdsJEmx/W7dcz+OWzIJnKtlbGirVe6UT4VffIvQa2
         pVFFaMEFfiO1zCbZeUZjlHJkbrRV4s4AMONyFScYYS2JvfnKl0zK+Gy7231edVBDJANq
         zchzcKyxhclSJoUfJJZkH8RdfBOjOkV5tAUA49mm7iKNh0TS3FASGNyoIq4Jp6yj6RfQ
         5sSrYybrjOYNiqBVXECgR9qYjsRm3OYunIbg59SGdlDo1cMshRAjhYq8qkSL+g4wWNb6
         moDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgg7pR/etI+m8XsJpo6r3eWa2c/YSy7jZmc6c0SA5uEper/WnHr4qVavikgj2wDceJT0WIDz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuWElOG691Rn+yCOkr1Yr6zyYGaSJx88qM7qnhv3hGx9c7MHU
	7z/MqCRj3UIoxSlpKjF9w0xlqVj+6f+W91wbJVe17KKVULEBg7iV3KCtxKr2Rx2YnbU7aepgnY0
	adOsXVLqq0SqM4kSmuv+U4KjhWhghmtkrh85K
X-Gm-Gg: ASbGncu8u1oXqMZE8EW550rR0cZMu3+KEpsIT1UltsJ++4PLhX8TXFhCfWTR6AC9A+D
	Nj+q7XkojAM6wxqrHMzK4DYsH2wudAFgEcGthXjF0MhEtkEEFG3hkC9ZAALbXoj8fi4f8+JqvGv
	GWOK2rOXI9X3MlWseekJwibNkhq7xoT3V5cmW8gfN9q73LpP3BLj00isdlod66HTfwW3XiMv0xi
	IPSP9D/dJ6EZUFUgcTouAEHbrXXHvxoRRbJz4zUCFJpTvRcCsIu6jKzI1b0Fu8dxWds/nHLI1SH
	HotRMD39dyn66WfR5WbalQMHpw==
X-Google-Smtp-Source: AGHT+IFLq0Lki7jHlkNoIxYgbT6xqtNZap/JJ68GL0AjhoJshZE9QMAIwE01KqPdAocx5GY5AONDAufa+H/OPmUsVJs=
X-Received: by 2002:a05:620a:4693:b0:8a2:e35f:90 with SMTP id
 af79cd13be357-8b29b7687damr16285185a.30.1762884012467; Tue, 11 Nov 2025
 10:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010220738.3674538-1-joannelkoong@gmail.com>
 <20251010220738.3674538-2-joannelkoong@gmail.com> <CAJfpegtCiEGxnnvQE=6K_otzhCkB4+SVLV74_nP4Oj4S_yeKPw@mail.gmail.com>
In-Reply-To: <CAJfpegtCiEGxnnvQE=6K_otzhCkB4+SVLV74_nP4Oj4S_yeKPw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 11 Nov 2025 10:00:01 -0800
X-Gm-Features: AWmQ_blP5IEHZXanvkZ8IXnlaNvJ9844PhLdQ0zdI5WqxQKyJUCDIsWPG6XziKw
Message-ID: <CAJnrk1Z859dq=Yx_Q2PLTcemNJrDCgV9h=4hFEde793jDwA3Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, osandov@fb.com, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:08=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sat, 11 Oct 2025 at 00:08, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > @@ -110,7 +110,9 @@ static void fuse_file_put(struct fuse_file *ff, boo=
l sync)
> >                         fuse_file_io_release(ff, ra->inode);
> >
> >                 if (!args) {
> > -                       /* Do nothing when server does not implement 'o=
pen' */
> > +                       /* Do nothing when server does not implement 'o=
pendir' */
> > +               } else if (!isdir && ff->fm->fc->no_open) {
>
> How about (args->opcode =3D=3D FUSE_RELEASE && ff->fm->fc->no_open) inste=
ad?
>
> I think it's more readable here and also removes the need for multiple
> bool args, which can confusing.
>
> No need to resend if you agree, I'll apply with this change.

That's a great idea. I agree, using args->opcode =3D=3D FUSE_RELEASE is
much better.

Thanks,
Joanne
>
> Thanks,
> Miklos

