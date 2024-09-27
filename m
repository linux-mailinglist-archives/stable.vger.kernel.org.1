Return-Path: <stable+bounces-77848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F7987C3C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 02:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E101F2405C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030B101F7;
	Fri, 27 Sep 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbNSHQ7K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982D4C98
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727398141; cv=none; b=LXvHA+r2oepeBXFkoPMUlV5HYDunWIvVoT/oyykEZ9ftLKnrehl818VFw6lfWmalG8uhV07bmeZ2irPxlGnzfy+MizRJKDwsKzbAyXMu2txL6phfYSuDV753C2W45/ScSMRrH+K7rOOahp2Vo/OAKupGoN/vloBVdKKhg2FOUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727398141; c=relaxed/simple;
	bh=iY/t+3OozCaP73WTM0TyA7rGwJvmolvARYy3nfPx/DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8bJCt3949yukNxADX38hyolaZmHf08rXxeshpx2DBnJ18cLQ43zyOwBHqZ6sojq78+e7O2pfoYbsu2Ncsm6IL6knSOVR5ko2poXMHDYm4kOZks7C46C/OYbX621LxEj+An6Iof77nzdVR1UCnWyUBF0sUUQJO/qMbjUgpiQdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbNSHQ7K; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so1214270a91.3
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 17:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727398139; x=1728002939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NlIqPw2RTrEGU033VxGxvlzPh2cm7rrP5Tz27iXdWc=;
        b=HbNSHQ7KmmroPsboXmBuBfGJZDLklzKksivy9BFGioCwkD6SzybqDccTNZIquGdTlp
         9cXagY1Mm18E1Jp52zc2mHhWeHCZ3NX//6vDhRgaj8Ye8mSr+2d+iAByKXtOMxSTynSP
         wwUsTwE6IrnlmIy87MWi50474PnVx2TKNQNDW5IteZUQQmLNCpQiGZR9yFESDKARehA9
         LJDRtB2X/ltlO2efKL14PA2ti/9p+lAZ4E86j3uUHhvJQhY3jaOIJ8Pege/+lAQNTUgZ
         ssIRZZqD3LwjczRpKfterHMr9rdMqQr7xSz3KsVrQsZHBIfR2CQWgrsBapk3PRkzcdFn
         5KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727398139; x=1728002939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NlIqPw2RTrEGU033VxGxvlzPh2cm7rrP5Tz27iXdWc=;
        b=Wm6/QktpZmsV9oDBDO0WXcqAkuqHIj+CZtdV0T9UJ7rlFKYybpWV7R5W3cqEYEehnR
         Gq716ZmIqpGSp4D/PRipXVU6u61nLgXxJNGgyI1YA6z2j+ia9sVOJ83U6ryYy3UCYK1P
         nGnSECo0tQQP5SVnJD4sW6dh9uuq3Nx5DtYiCodkIa2OG0kbNsaHVf7lU9is026Tw/oJ
         Eby+Yd1wED4NxueI8PJ/ernnvQHgqPcQhT4hYWP4xwK/rypOIzFmQyvljVlO+vecX4+4
         5JnX4XM882W8rMIJ+rhQc0dZv4yWkO/NCHmlPoHUqrBXyKwubFVeBx2lJ3wbEDWi1LHa
         VsKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtuRXAvAMO46qqdIUhGcWCEV78TOcF/I1RJoqdXEGzdu3EUnMW5rYIprBKboiojPUjWwxXeSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVGo/xXVylyKSQC63k4RtAFMbbadRWWMLN/ynKYov5XnLp7YP
	hQann4zsERHS+eHlwYMDaF6Ygh+qqNgUEMP1NA7j7FqV+9NE5ErTSci97BZCdG8d91IKWApnW83
	AaT4oruT3v6hpH5bvSFuybuTlaeDEkQ1HYnLV
X-Google-Smtp-Source: AGHT+IGNoRPqV3cnZXRVwVexIjMSvYV3WbX3ssiB/HUaVeBJudab4ib2Leryc3NXno32SiuOM+41R8a9J9z2bV3ICbI=
X-Received: by 2002:a17:90a:df01:b0:2e0:82bf:1aa2 with SMTP id
 98e67ed59e1d1-2e0b89a46b1mr1720687a91.7.1727398139229; Thu, 26 Sep 2024
 17:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-7-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 26 Sep 2024 17:48:47 -0700
Message-ID: <CAHRSSEzj2UWrLBdUuFpcDwkyW_4R1Q46nZK49guqWhAPr8nqJQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:36=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Alice points out that binder_request_freeze_notification() should not
> return EINVAL when the relevant node is dead [1]. The node can die at
> any point even if the user input is valid. Instead, allow the request
> to be allocated but skip the initial notification for dead nodes. This
> avoids propagating unnecessary errors back to userspace.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6=
RWWUNKKyJC_Q@mail.gmail.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 73dc6cbc1681..415fc9759249 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_pr=
oc *proc,
>  {
>         struct binder_ref_freeze *freeze;
>         struct binder_ref *ref;
> -       bool is_frozen;
>
>         freeze =3D kzalloc(sizeof(*freeze), GFP_KERNEL);
>         if (!freeze)
> @@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binder_=
proc *proc,
>         }
>
>         binder_node_lock(ref->node);
> -
> -       if (ref->freeze || !ref->node->proc) {
> -               binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFI=
CATION %s\n",
> -                                 proc->pid, thread->pid,
> -                                 ref->freeze ? "already set" : "dead nod=
e");
> +       if (ref->freeze) {
> +               binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION a=
lready set\n",
> +                                 proc->pid, thread->pid);
>                 binder_node_unlock(ref->node);
>                 binder_proc_unlock(proc);
>                 kfree(freeze);
>                 return -EINVAL;
>         }
> -       binder_inner_proc_lock(ref->node->proc);
> -       is_frozen =3D ref->node->proc->is_frozen;
> -       binder_inner_proc_unlock(ref->node->proc);
>
>         binder_stats_created(BINDER_STAT_FREEZE);
>         INIT_LIST_HEAD(&freeze->work.entry);
>         freeze->cookie =3D handle_cookie->cookie;
>         freeze->work.type =3D BINDER_WORK_FROZEN_BINDER;
> -       freeze->is_frozen =3D is_frozen;
> -
>         ref->freeze =3D freeze;
>
> -       binder_inner_proc_lock(proc);
> -       binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
> -       binder_wakeup_proc_ilocked(proc);
> -       binder_inner_proc_unlock(proc);
> +       if (ref->node->proc) {
> +               binder_inner_proc_lock(ref->node->proc);
> +               freeze->is_frozen =3D ref->node->proc->is_frozen;
> +               binder_inner_proc_unlock(ref->node->proc);
> +
> +               binder_inner_proc_lock(proc);
> +               binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
> +               binder_wakeup_proc_ilocked(proc);
> +               binder_inner_proc_unlock(proc);
> +       }
>
>         binder_node_unlock(ref->node);
>         binder_proc_unlock(proc);
> --
> 2.46.1.824.gd892dcdcdd-goog
>

