Return-Path: <stable+bounces-77871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B04987F3F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF33C1F229B4
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD0177991;
	Fri, 27 Sep 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUv5TyLU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C7165EED
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421567; cv=none; b=cDEs4GsHZRTUBu7GXKoo5zpEcCW6WEMUz0EXRyAOobS7MIw/8ZI4sdXMJW1CN5j89hqrvEpUPWGJ1+nVUPTIjNXk1JdvwjSypHOrmsn9Q1pi6qcWVEGSuKSOgUXvSzQG8yPGtdlQiJVJRPC17yJNgtajEhzkoatned1S1da4OeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421567; c=relaxed/simple;
	bh=+LzaWjPm7GYS4ClcPcZDUGrDO1Ef/UvvMkMUilhTcV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcTQ7cRqMg9zKVvxwDj2+DYy47Ny2zqLcpAcqlyKHcTryZtKVioSa5TczYbE3x8Z/DiU1Fgyp9pP+QDrTYW2dHhTaLmRU0bTwM+ECciO3Xpru6izh9JRD/7wzNCNIazoxp/R29fAjjjr7S8fbFYip6hJBZvnU+o5SFfVNACycP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUv5TyLU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso56442f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727421564; x=1728026364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsWmxM/pizk5STQ8hxv/SQOUbip6yEiFmeKo7SGjTR0=;
        b=PUv5TyLUNiQHMWiZbIrCNlxFKQKRoDP3AKTGG0aKZ02hcA2QoNTxxjM3L9BydQkviB
         t8ioRhNbYjtDPSOV2Onidcp5BRC2+OTkOf4njEtA11SSvTQyVJu0H/KH5TQWl7//u1qz
         yOQnenZzlv/h6PxBlgXOAyDEELrWI8wb29uSlSTvwT+V5i7yEz/E3QujPOPDADuXnbde
         ZMm8B8kz4JNzWKz2zCGKcPuRtmQLjYKZ2YysQ8CPJaOCAbkZuoqX7xwW2xBjg9KeAW2W
         3JsUe7jiSzGZiHEd3gEOz71s7Kbtcwxc+cTQyK32WBhlpKl4vIjkQs9dtoohn5+iD8bn
         lZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421564; x=1728026364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsWmxM/pizk5STQ8hxv/SQOUbip6yEiFmeKo7SGjTR0=;
        b=paonNxVzqf0NtP37OyjPb71NT+tsyWxi9CduTF5cePeKXlirvfnyB2kBLe0v/c6xy7
         vpYKQe51J75KUI4DKjvduOulAB/mnPwKMz6FYl4dngjtFwAKW7NNHExNIBlzf3E98A0C
         gKV4aZ6zsKNeCDJoAUZWlEFRPWfi5OlHdMA6IBuNv3wm1qCss8Irr/w2prZxjguAOift
         7VDbpYAkvLDq1cKxN9aCkMlof2uxrcNCyKkjGzN963piMjs+Rd/2UsqSoiMfzF8osIGf
         FkgR057hnrg99gdDCMLWwINAu95qiEnR9XcUQ4AT12IhXOZuHYz2EuQIKfCNqlmZWMXo
         V+fg==
X-Forwarded-Encrypted: i=1; AJvYcCUkFvy/SFCnEa1uoU0MP6+ZVyKNIecrZx2oxyVFqkWHtgp9HrPboEG+JTjL8OpuxH78Z3d2x0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ramcMrc8QFW0lKzkD+ip9ZsUgqUcdhYqUN6zUm2sXxouCpjk
	w3LmASccGoH94B2TF7R/y6tq5EBL//HkdPLTXsrSdiybbuU7pfq4EK/LykGPumEq1S4DU0UrdRT
	AC09AMugYJsWWtbaqP8nfASqgnTl6+rLFoFQZ
X-Google-Smtp-Source: AGHT+IGbqV+7LHAovIbkqm3Kg/XVEY3AlSu4eifPD4xqxKxH0tn1ynrzcwnFRwSXqxMrWZFvOn3GrOfRngqjpnDvIHQ=
X-Received: by 2002:adf:fed2:0:b0:37c:d174:b056 with SMTP id
 ffacd0b85a97d-37cd5ad2014mr1211988f8f.23.1727421564232; Fri, 27 Sep 2024
 00:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-7-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-7-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:19:12 +0200
Message-ID: <CAH5fLggS7C4QdmDFqEy5KARUj+4oNWfstyno3d43joG5haysDw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
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

This is not a problem with your change ... but, why exactly are we
scheduling the BINDER_WORK_FROZEN_BINDER right after creating it? For
death notications, we only schedule it immediately if the process is
dead. So shouldn't we only schedule it if the process is not frozen?

And if the answer is that frozen notifications are always sent
immediately to notify about the current state, then we should also
send one for a dead process ... maybe. I guess a dead process is not
frozen?

> +       }
>
>         binder_node_unlock(ref->node);
>         binder_proc_unlock(proc);
> --
> 2.46.1.824.gd892dcdcdd-goog
>

