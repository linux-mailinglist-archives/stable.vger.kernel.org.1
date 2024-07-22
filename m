Return-Path: <stable+bounces-60678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E28938DBC
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751F9281A8F
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100216C876;
	Mon, 22 Jul 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMjtZfYd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1416A94F
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645867; cv=none; b=SQwwJdvM/yF0YzH+tfFiYvbzS4PqcZ9tmSn9S83o6T3OQZejg3yDOeNm3AqhcGD7aO+h+23jlntrYeoQaVJIdueoi7AATFROUAWEbG5AuWcpVPS05rRT1HljkCEcIU5UgsP13Byipl3qgcV0ihPVnjKKTy3aIPS62sIjC+YcLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645867; c=relaxed/simple;
	bh=haqflt8x3jSnpNCu5jIiqagI6dEE5eBn+xf1bw5atBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QromgoYzlO7kzgU5436v21DGezGeUiZjaJ4fRxFXz/Ux0h6qjGMO1NVEGoYBdmqC08y7+CXRZp+qmiPGzyTIdRG8cQ+jy2j1bHwcCGsvEzg6TLPK9MC/VVEot4YrtpALBb+bNkiUt5pEAU9GKf43iLT6BuzUITOJO5dIrZElUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UMjtZfYd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36887ca3da2so1643263f8f.2
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721645864; x=1722250664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ODjTpicd4m2zr4DwT7zrtDEMSSzcbc69tUjbmcV7c=;
        b=UMjtZfYdjwT1VoUmGWz/3rgSdDjopAxaasohMFChgPDAJT8imKc9j+lRbIpon1B9Za
         riHqmOL8uA/cfU15/IdXOWRQf6yim+ZqzK6cWgnh9gPoa3b3oE0+Awha2fkLyHgL2EyC
         xMKR+nuyrvEK6oshWhJTOadvDQU9F/gOW6n9hXFLsl1TYGKnJ23Kqq8VA2PZ/yz4M/uD
         oeISt1Ahhr4/x1heKpvXTV9CjiCgMO2V3gHNOEFRwhsB5s7KsP8EowLqKF4/39KS+81j
         dFkhxs2v/AcD43kF9kkD/phXnRj/XJlktUp1VGkSjf1ooYZO7O7MJgoT2373TXWYwWRA
         KN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645864; x=1722250664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0ODjTpicd4m2zr4DwT7zrtDEMSSzcbc69tUjbmcV7c=;
        b=XuxRWkMSaunxDolvEBKtImUwcG0KEXdo4KZSNjsE0sTrV86kDQDelSXl3e16dA/EaH
         SCYGcoXLpMOMHyIeU6NNpTigxa5HgREIeP8XhnhgMrMqHyD3t92KknaNArH8I57FL/7s
         sE0MQoN+Fec4Znwz2p8RP2Ue//mbGnKCGBiRJqN/eL3aWceMmnBxuriYKI6I3jG1H7dQ
         We9Z7lbG3CFsK40SmOvnwT2tvwWO8F/tbaFz0hsANYQqYPz3ovAsqSKtpYLIKW13+LVG
         D+Jsjq1Aj6TFZLR9fdGNSip7GmEpyKWGIFYr57nkX/zwWPFiEmGDADDfoufyzUWx/eBV
         BXPw==
X-Forwarded-Encrypted: i=1; AJvYcCWDdN3DjJJ4vnBu0MEZ7FEbeiNhcK+lDZJkrzl82XGnPdz0W+QLWgTTiBJ8PJMWnM+cRo1sYKGBGecCKFccD2j51uBrdgMN
X-Gm-Message-State: AOJu0Yxmf4z/jD44m8loBFAug99H1YHHJdaCEHLovTltL2kt6Bwu+GN+
	wNRyBWfRjqTAfXVdwDtjCmwNKP77cIDrFf164UF7IPa9t1P8af6ETuagQfvCF4Qv3cOe1GtmMnD
	mkscWwsO0MYt1gkiQx59Ds1yUn6u3TnV7RlAw
X-Google-Smtp-Source: AGHT+IGbbn8hTDpTxgC41P72NNiUMy0Tx8UmdvDkjWcBbdPjYIGsTHUwOTuwYjnoBQc08K7nS60rKwo0jBpITT/Wr4o=
X-Received: by 2002:a5d:630e:0:b0:367:998a:87b3 with SMTP id
 ffacd0b85a97d-369bbbc0796mr4050235f8f.28.1721645863630; Mon, 22 Jul 2024
 03:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000601513061d51ea72@google.com> <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
In-Reply-To: <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jul 2024 12:57:31 +0200
Message-ID: <CAH5fLgjP2uOJRKCpFrwGn7X3Gw=r=wCibejp59JhupDX+QA5fg@mail.gmail.com>
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
To: Todd Kjos <tkjos@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org, 
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 7:40=E2=80=AFPM Todd Kjos <tkjos@google.com> wrote:
>
> On Mon, Jul 15, 2024 at 9:29=E2=80=AFPM Carlos Llamas <cmllamas@google.co=
m> wrote:
> >         /* 0 is reserved for the context manager */
> > -       if (node =3D=3D proc->context->binder_context_mgr_node) {
> > -               *desc =3D 0;
> > -               return 0;
> > -       }
> > +       offset =3D (node =3D=3D proc->context->binder_context_mgr_node)=
 ? 0 : 1;
>
> If context manager doesn't need to be bit 0 anymore, then why do we
> bother to prefer bit 0? Does it matter?
>
> It would simplify the code below if the offset is always 0 since you
> wouldn't need an offset at all.

Userspace assumes that sending a message to handle 0 means that the
current context manager receives it. If we assign anything that is not
the context manager to bit 0, then libbinder will send ctxmgr messages
to random other processes. I don't think libbinder handles the case
where context manager is restarted well at all. Most likely, if we hit
this condition in real life, processes that had a non-zero refcount to
the context manager will lose the ability to interact with ctxmgr
until they are restarted.

I think this patch just needs to make sure that this scenario doesn't
lead to a UAF in the kernel. Ensuring that userspace handles it
gracefully is another matter.

Alice

