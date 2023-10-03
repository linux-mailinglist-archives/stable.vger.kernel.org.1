Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4157B604A
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 07:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJCFOV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 01:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjJCFOU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 01:14:20 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D81AC
        for <stable@vger.kernel.org>; Mon,  2 Oct 2023 22:14:17 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-45281e0b1cbso282883137.0
        for <stable@vger.kernel.org>; Mon, 02 Oct 2023 22:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696310056; x=1696914856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JcX9BuJjaiepsCc/K2xd0kJsje6C35pIxuJO4bAB8SM=;
        b=fxwLuiYp49nTCZO1D4tbs55LZVs/xBuElIM/AEAqPM8yQgrINkYuzKVDT0yMTOoEoB
         D0Yf04I28fEJjpnFGXWx5Y5wGgq0g4c/WsJ1PMoQ3VitUfKxGQtFj7lhTMV7TJoiz47X
         RIqC4V3HnfSnMe/uzHfjwxljesuGG8H8FdGOJSpyqXWUkPK+g2HGctS+rlbEP98yd5f2
         kyt1H+YZiuMw1Gjp8Q++0x00hLzGC7+vq/FCDFRDeiR+L3HQ7vHfoBBdDitpzTia/P5Q
         BjXHOmQI1iLZHWHI7yNmkJ4ygVVF18016VBJWvbxwizf3ca6kw2K2+FYeaiolQm+JGD/
         x3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696310056; x=1696914856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JcX9BuJjaiepsCc/K2xd0kJsje6C35pIxuJO4bAB8SM=;
        b=FLsxtmjeq9sO/MxWlAcR9DoBZbf44We8Nsv+q9Lq3uXzzSvjmiftOymZW3DcvoGmvc
         Z/21wUKkih93d2cV9TFQYPayVoPrXLDlaFA00VznCZm/kpxOuqXSGEnkHatRR42tpzFt
         WMyzmTvV05tItB9m/y54F0T7yNzorvg8csvomYN1gSxnppUK+dg/qzZkxlVuCB8x9Qbo
         2PiDyZOgJ7Ek1WkkRSa4tMbqgr9bJ0srES3qp4JCo5gMmxf9E5USuMrqWj6yM6ngF6nE
         5ze5PH9q0J3mw5jJXPANzllks6Y2GStzIfm3UymHvaHd83mdGAeSTS0WrolyZXnlRGBB
         hNiQ==
X-Gm-Message-State: AOJu0Yy+qRySw2qdWFpjUsm/+5E9TWSMD1/1Gx1YgzYxnU2gxp8nbDd6
        kmsEzi7XAoEjhAYjqA7lbE8mILONJIzKFnNexvPbGw==
X-Google-Smtp-Source: AGHT+IGOKoeWl6XmOgisTkSrtm1nJp+bKxBS1P6cXdXA8Rl47GYEU3jNe/ZWRYD1ziFjc5Zj6YIY8cIEoKBEWk/nSWM=
X-Received: by 2002:a67:ef9b:0:b0:452:72ec:27ea with SMTP id
 r27-20020a67ef9b000000b0045272ec27eamr11944940vsp.23.1696310056568; Mon, 02
 Oct 2023 22:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <0a535fc59c3ec89b52ef76574232fab8457ebd7e.1695970674.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <0a535fc59c3ec89b52ef76574232fab8457ebd7e.1695970674.git.Rijo-john.Thomas@amd.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 3 Oct 2023 10:44:05 +0530
Message-ID: <CAFA6WYN9xHUmxrJJM_o1P-gcfYS=UrBQXEO7w4Nt9g=xErbxrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        op-tee@lists.trustedfirmware.org,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 29 Sept 2023 at 12:30, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> There is a potential race condition in amdtee_close_session that may
> cause use-after-free in amdtee_open_session. For instance, if a session
> has refcount == 1, and one thread tries to free this session via:
>
>     kref_put(&sess->refcount, destroy_session);
>
> the reference count will get decremented, and the next step would be to
> call destroy_session(). However, if in another thread,
> amdtee_open_session() is called before destroy_session() has completed
> execution, alloc_session() may return 'sess' that will be freed up
> later in destroy_session() leading to use-after-free in
> amdtee_open_session.
>
> To fix this issue, treat decrement of sess->refcount and removal of
> 'sess' from session list in destroy_session() as a critical section, so
> that it is executed atomically.
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
> v2:
> * Introduced kref_put_mutex() as suggested by Sumit Garg.
>
>  drivers/tee/amdtee/core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 372d64756ed6..3c15f6a9e91c 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
>         return rc;
>  }
>
> +/* mutex must be held by caller */
>  static void destroy_session(struct kref *ref)
>  {
>         struct amdtee_session *sess = container_of(ref, struct amdtee_session,
>                                                    refcount);
>
> -       mutex_lock(&session_list_mutex);
>         list_del(&sess->list_node);
>         mutex_unlock(&session_list_mutex);
>         kfree(sess);
> @@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
>         if (arg->ret != TEEC_SUCCESS) {
>                 pr_err("open_session failed %d\n", arg->ret);
>                 handle_unload_ta(ta_handle);
> -               kref_put(&sess->refcount, destroy_session);
> +               kref_put_mutex(&sess->refcount, destroy_session,
> +                              &session_list_mutex);
>                 goto out;
>         }
>
> @@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
>                 handle_close_session(ta_handle, session_info);
>                 handle_unload_ta(ta_handle);
> -               kref_put(&sess->refcount, destroy_session);
> +               kref_put_mutex(&sess->refcount, destroy_session,
> +                              &session_list_mutex);
>                 rc = -ENOMEM;
>                 goto out;
>         }
> @@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>         handle_close_session(ta_handle, session_info);
>         handle_unload_ta(ta_handle);
>
> -       kref_put(&sess->refcount, destroy_session);
> +       kref_put_mutex(&sess->refcount, destroy_session, &session_list_mutex);
>
>         return 0;
>  }
> --
> 2.25.1
>
