Return-Path: <stable+bounces-77846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAE987C2C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 02:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3172DB240DD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05A8749C;
	Fri, 27 Sep 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3pz/ZwS2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BB2582
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727397261; cv=none; b=aWf3ruEkRDbrMthWoA0CVqHUAIWEpEyjJC0qdJKym+/l0ml+UnvkDgrqZrAhZ0aQQv4i+KnwlEa0Iy4pH+QPGRmNO++pM33JV3jWzV6YiuEUMbyF2JlIh0N7Ia4kFiycHZ3xFeAEhP2if4O1jbuwS9S6j6VrkWeF+YZXJ/AuOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727397261; c=relaxed/simple;
	bh=p+Y4dRmN73V4XXbhuXhuTz6H7JBOIuTlX2LKJsBXVWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIh5SGMF01EAcHKfpVtoW0Ci2+cwzH186UHI//uRtdj/RCflYpRunrs1Fso53mPSMQhULDbb1OS6OyxNvy1Upqg7Fm4tfn3FsABn4PrwY2JtNlP/2qY+O5VSe14oToc3giM9ENbvvZpGOBUHF2O/JE9MpwcdQit13KHhD+Q7xmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3pz/ZwS2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1155441a12.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727397259; x=1728002059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAa75KbDqhJjx81DIDS15qaRvhgsnet+lGj3+ZM2t0A=;
        b=3pz/ZwS2bSrGapi7pgBHdQWZLoA0gyzCyV6T3Nk5Ygasbs9FQJ9zo9rAFDnkvh/63T
         2QphW1mII0nS+GoqfoBrdnGhd+raaDVwlNRKNYFr0LfeLod9RWonyu+mirt2rj/o2GKi
         hCZv9lhmmzMpZed493/8l2hFFFYgWeN6pF9UhH2/iN4+1U3ioJSOWdbewnsa7eEFwEnH
         dAXHALLeytjL9SGBdce1Ul0YNUVp6oqATiXRI9XMT0nniPgupCu5pmlHVG0jwdkfNeu0
         w2okzs2qV02FSkrvHUJFGtEEFFHQbqw8Qx0aEhg1+j/IC/ema7ZZD0i9KJvMNgGgSdjy
         vLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727397259; x=1728002059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAa75KbDqhJjx81DIDS15qaRvhgsnet+lGj3+ZM2t0A=;
        b=cG4lF29xw4mqUrIqyKnc4tskZuUT7LIh7S8ZZj5N06e6zsE8hdjPZKIyDHknkruc0m
         J8nvpSeqmQyAo8qO1fdLB3ydXLa1QwVtSb/IrnLhUeQAZVd5c9Q2/1QlmyLnwLRl1Xi9
         3Ue+WygJ5LTc7GvEYy+9ykbuPuUWo9Y6wfTUnO1qWoiw22GJ8kZVh6P90TKcRxOjafbU
         VLfF0gQjJmPe6AqKpPIixabZ8tBEnKMNIsw1B9eoM4I/0vVhkB3mVVo2wpiqFaZhB+Cu
         Rda7R57iGND3sDyLZFWQCrLqWwSJYZScEjPI0aIgp6ka14utZCNS8a8l/WjVYLo56Izt
         fuqA==
X-Forwarded-Encrypted: i=1; AJvYcCVPkm0NebOCXSGtf35Jv8N1ngoNIIQyAh4mrefX8zr6MXgPSYJQi+LXwQ+iA2flZJ/4PypP114=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaa7M+DPOTHkAXq79jhAaX2XkqWC4Ufs8vPqw3l9ZUcvwzvxKS
	XN0YRkxPF5dN0aB7gUUwTAK1tlFNvES0Q03cvIWqroovQu21lkSIjMlKja4OnMq8CFbljVCmp/o
	HOZGR/t27daDrK6DDVAYEo23El9MR6sy1pCTC
X-Google-Smtp-Source: AGHT+IHQj7kaciFRp3wcKf/ExRdN+4TN7oaZukCduLsvkGSAeeeVgdNIhWzjO78CznXKmFNH7ByssFgcRN2I9grS0fA=
X-Received: by 2002:a17:90a:6784:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2e0b89e22f5mr1687315a91.9.1727397258838; Thu, 26 Sep 2024
 17:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-6-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-6-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 26 Sep 2024 17:34:04 -0700
Message-ID: <CAHRSSEzvTX6OMb_2kVZbKJhFPy8m8q3OPOQsxuOPGupsJUduWw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] binder: fix BINDER_WORK_CLEAR_FREEZE_NOTIFICATION
 debug logs
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
> proc 699
> context binder-test
>   thread 699: l 00 need_return 0 tr 0
>   ref 25: desc 1 node 20 s 1 w 0 d 00000000c03e09a3
>   unknown work: type 11
>
> proc 640
> context binder-test
>   thread 640: l 00 need_return 0 tr 0
>   ref 8: desc 1 node 3 s 1 w 0 d 000000002bb493e1
>   has cleared freeze notification
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 2be9f3559ed7..73dc6cbc1681 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6411,6 +6411,9 @@ static void print_binder_work_ilocked(struct seq_fi=
le *m,
>         case BINDER_WORK_FROZEN_BINDER:
>                 seq_printf(m, "%shas frozen binder\n", prefix);
>                 break;
> +       case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION:
> +               seq_printf(m, "%shas cleared freeze notification\n", pref=
ix);
> +               break;
>         default:
>                 seq_printf(m, "%sunknown work: type %d\n", prefix, w->typ=
e);
>                 break;
> --
> 2.46.1.824.gd892dcdcdd-goog
>

