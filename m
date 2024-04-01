Return-Path: <stable+bounces-33955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A840D893CFE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63935281847
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591951021;
	Mon,  1 Apr 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaT7KJT/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F751037
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985918; cv=none; b=Uqm4MvUEE1Smxx7l7rfMWgvDwFQClBb9c/+jl/Nn5kHwJ0MfjQlGegOrBOpwz6mOxWAfk4aI7weZV529LCwR7f2TmbuQlzyyCK1vz5XDy+ykStTh1fJEDOGh8MKdsKU53nMLHfaQ261gNswTYUVBMY2Zd+jAPKXXuk8RPuGwtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985918; c=relaxed/simple;
	bh=PsEE1108kvpa8YanXZIj/YdUlfyR+lpAv9Ufy9e5XtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoVcuwP7lMjZh3+Ai8XqirrZuGTYMTtOvWDKoyYpQS1G0M6VpCIkVMs3dPevRpdshc5aFGdKnskYRHcyQf04fdWkNxVfksnjjB4I4pGCgb7XE+42eAk5TYAmD1Knw7Hf0DRQKr7WfIPuu4fawbNs/LZXf7mXSSfi6WEs2a1jaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaT7KJT/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430d3fcc511so910801cf.1
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711985916; x=1712590716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4AycDE/T6cr3W2e85C1kucuC/DEHLZ52msufmx6S98=;
        b=PaT7KJT/DIw7ZqdC4qe8TWTnMFfACKWhHuppO5dYJGrBQ/5tIRmT84qWLYZaSwKvuy
         MHndvhl3QqruKjmsPK4nskd0Iiul4gxEoTdwSquS8ujkIlBa3c8e06eM0B2BuVBqfaSE
         qx/WkQRu08iL53rlBc8vuoiruxfOwxC4UKKmZfKBRmxbxgZnb123u+5QFcUKNcuWNwXE
         LPayRUJBhe0kqkP/7IQiWQEeeuQ2uW2/HthVw9qLNJ1P4b+csWnjWn2Cd2F+4OXrAj7/
         rJb/PAh+j21JfJJ5btGK6Rzda5KMcL+KunEmIiRMQDFhtYWrF+M0on+/wTt0zLrH3uu/
         MQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711985916; x=1712590716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4AycDE/T6cr3W2e85C1kucuC/DEHLZ52msufmx6S98=;
        b=ZhxRyrguKxmxMHfuwjavxP7lkmy8xReGmtdtA9IswNVBdOKaPwM1AjFOtegx5FZ+5m
         mkrJayxjfwUEzLFyPW73mwif7246Xx/XUvVrhT0ohKb44sv+KBTS6G3st80vwX9FTkr7
         MuxYqRW1FxvOIUMhL7MpQHv8adBaqpeEhvaMFiP4znTQclgRX1OGmFAx26UJ1kaqV2Om
         8VW9hz0ZSVmEl72ou40qhS63Om1XP0jpvGwERMkuIHGE64bGr6+jxJvuWpxmjIdbrv4n
         i08NP4dsMrH9HyM4WxJP8tbFXo/UZOCFN9V+fGUyWoNkcu0dm4IhaHnep0t+r6UmdaqQ
         ZA7w==
X-Forwarded-Encrypted: i=1; AJvYcCWhqjYPofrVMO/m2N7k9fyH2s6mN9+ywweY7J95RDPYbp8h8xvSkHlGKWyjBlUitW2YaM5v7KELqU7amSyLiKxmiHJyeJOo
X-Gm-Message-State: AOJu0YyvLQ9Fji4b0s92gB7kW7Mezq2Uk7rrvZQavYK7D0jPRrKvhhXP
	5Vo+MC90Mx09AJ4u9L4kbNsoPBPTbI/V4XME/GwKz+ashCCchHezmtix4bsM12wGk5Q0nmFyvtl
	CMTW+hjDbBMJ94SMCnazcacUeCy1ZKeXK0iEO
X-Google-Smtp-Source: AGHT+IEspBZs20MXwI01o1zV6AmUkuhUEO9loBbhxdAHKLk0Eyxu82Rc7db63HNft1WWS3U+KfLaAGqwdFJaRRSktsM=
X-Received: by 2002:a05:622a:1cc8:b0:431:378a:c862 with SMTP id
 bc8-20020a05622a1cc800b00431378ac862mr865536qtb.27.1711985915876; Mon, 01 Apr
 2024 08:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330190115.1877819-1-cmllamas@google.com>
In-Reply-To: <20240330190115.1877819-1-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Mon, 1 Apr 2024 08:38:20 -0700
Message-ID: <CAHRSSExq7UkD1D4Q632hf0a6f=jB1O2zhUrrgY6tudtxnynU5g@mail.gmail.com>
Subject: Re: [PATCH] binder: check offset alignment in binder_get_object()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 12:01=E2=80=AFPM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> Commit 6d98eb95b450 ("binder: avoid potential data leakage when copying
> txn") introduced changes to how binder objects are copied. In doing so,
> it unintentionally removed an offset alignment check done through calls
> to binder_alloc_copy_from_buffer() -> check_buffer().
>
> These calls were replaced in binder_get_object() with copy_from_user(),
> so now an explicit offset alignment check is needed here. This avoids
> later complications when unwinding the objects gets harder.
>
> It is worth noting this check existed prior to commit 7a67a39320df
> ("binder: add function to copy binder object from buffer"), likely
> removed due to redundancy at the time.
>
> Fixes: 6d98eb95b450 ("binder: avoid potential data leakage when copying t=
xn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index bad28cf42010..dd6923d37931 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1708,8 +1708,10 @@ static size_t binder_get_object(struct binder_proc=
 *proc,
>         size_t object_size =3D 0;
>
>         read_size =3D min_t(size_t, sizeof(*object), buffer->data_size - =
offset);
> -       if (offset > buffer->data_size || read_size < sizeof(*hdr))
> +       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
> +           !IS_ALIGNED(offset, sizeof(u32)))
>                 return 0;
> +
>         if (u) {
>                 if (copy_from_user(object, u + offset, read_size))
>                         return 0;
> --
> 2.44.0.478.gd926399ef9-goog
>

