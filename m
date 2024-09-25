Return-Path: <stable+bounces-77063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6248984F88
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 02:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F9F28504D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43A522A;
	Wed, 25 Sep 2024 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3nflN8xn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6CDDA1
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727225018; cv=none; b=SV2PDCxqHmfua3dVdxx/3aeqDIlHc5fM3RbIx0aF0MwKse1PKUl5AqA7eNt5ecfNkc3ywsqVt94A2OMu2h/+bjN/45NZwA+sUMxgSUW2ulfZa9/X1JIwAHwQcELP3HbMuwdBQwCbj4JXaq0YNHVqSfX4HjvPjFG7lrfEEJ8fmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727225018; c=relaxed/simple;
	bh=6oo9UyDI6tNCy/vrVg6StxlpjEhhMXYGLaO2tjUMhsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8xs0zzVjA+DkDzjxoWxz6Am2QwAB3Vxe7prH0e3s4IFjMmpw/qAEnbsSCb4ek+kpzbM36wj7RqNgA4xoWuTDN/M2wwDPaxO9hpo1bFnVyo/uqHLo2YTx6pmvpH0P9sZ4M1RWhDtvcGbdUVQr2AmMBojGHyFYicwEqxK9mbX0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3nflN8xn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-718816be6cbso4667956b3a.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727225016; x=1727829816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2SReWVorwb9BWpqJC6qNKm25K4EtD3lyA2IEQidVNI=;
        b=3nflN8xns7tW6l9QtWnmmus+LG2JH7lYHxWVFu/4+ZlxsiK+9CJcES9xLNtEINSxx6
         MX2Hp//Qop9vY9oTO25sEdu0S7M4RE9UMyJe/Nr91zCspg00L8QAn5L7HplxX+OAhEYI
         S/rajt9MeGseQCc8rQzLrBiX18AVWst/FPvCfYzeNSpiaKLqr5CbDEwtKSz3pVZ4EXv1
         Rjc7JGft6xvukcxBxqhBUehL3ETbrOs48Ybt2gEhnj4EdfHPixrUOyoKiH1ExTg+HNK5
         sQ9dXqjJQC3ag2AKSJ4dEYxCjFTvFJsZ0AKspkuOm+M41Ya/ZHiL0ZC/PeIzOfL96g0j
         u4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727225016; x=1727829816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2SReWVorwb9BWpqJC6qNKm25K4EtD3lyA2IEQidVNI=;
        b=fSRNl7CHHJ9EMKj0X5Uv3TsoAWUC5sbw/c85i6WgyVvEWU0aiwNg2c6cI9JGgNTPHr
         PJeV3OC21oGT8qYA1ZWjbOUNr39ThUIOs1KBjqmbtuywNnpuF9z7h/U3dO0DeDiwXOWM
         uNLfRGyGndduE7Rb2JEXrbga+8HxHYDLkA6bPpnG6iLg518FTXkz5B+AN5qnuzaiJijb
         7VQbRjHlpEkgUlGy0uhsc8BU/w38H77o4TSQLC/Qcm4H3d4BB4sww3XIJn1r9qE1ap6p
         c0aGkuG93GYmxQW4azKge+wWJP/X8O1I9qzL/4O5FvI2PV2LGnmSPl2898bV8gxeaa+P
         Hcfw==
X-Forwarded-Encrypted: i=1; AJvYcCUxuHTl5sIAHWb5TxM8nbUsz1YakZyBjcCkLu0shwwdWp1YV7Tr4NQjWyW9wyCPMTAsfRxM9dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcfYqxr2t296TT2NnwJEUoaorttWVljXHwK7+0awXXr6dUN8fD
	63CC/QruVgO79BWtLOuMQ8lCHOknrO2m197DpBWK6VvmX1iqFQ177Jke0PRzz3ixqnmFl339PKa
	vFZqZlpCZKmvKMh8Rqh0vMBrHcOTLshDYMReGCFNo4MEephOXrPdX
X-Google-Smtp-Source: AGHT+IHHQJ/z9cde/B0xUGfpIZrdRHInqr7GqCqDy9WJH7CGrc1yAUxLThy1XDUDtNcSSsKNo1YXM/QOvjfHR8vCAlY=
X-Received: by 2002:a05:6a00:2351:b0:717:86ea:d010 with SMTP id
 d2e1a72fcca58-71b0ac43cb9mr1347871b3a.21.1727225016022; Tue, 24 Sep 2024
 17:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-5-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-5-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Tue, 24 Sep 2024 17:43:19 -0700
Message-ID: <CAHRSSEw8Y=ZnPvGaBKf9H7ohV-fhub0fZW96T4dHy_F=JsCJeg@mail.gmail.com>
Subject: Re: [PATCH 4/4] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:44=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
> entries and it shows up as "unknown work" when logged:
>
>   proc 649
>   context binder-test
>     thread 649: l 00 need_return 0 tr 0
>     ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
>     unknown work: type 10
>
> This patch add the freeze work type and is now logged as such:
>
>   proc 637
>   context binder-test
>     thread 637: l 00 need_return 0 tr 0
>     ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
>     has frozen binder
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d955135ee37a..2be9f3559ed7 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_fi=
le *m,
>         case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
>                 seq_printf(m, "%shas cleared death notification\n", prefi=
x);
>                 break;
> +       case BINDER_WORK_FROZEN_BINDER:
> +               seq_printf(m, "%shas frozen binder\n", prefix);
> +               break;
>         default:
>                 seq_printf(m, "%sunknown work: type %d\n", prefix, w->typ=
e);
>                 break;
> --
> 2.46.0.792.g87dc391469-goog
>

