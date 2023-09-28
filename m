Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16B7B2064
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjI1PFd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjI1PFc (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 11:05:32 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFB1B8
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 08:05:26 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57bab8676f9so4643749eaf.3
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695913526; x=1696518326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10tpg/kDZqguMRr784ntEUQX0v75quYnrD94gsDzLMI=;
        b=qfs4Pd+T2ufLHa5XKL8r1X8y7E6CwwaitS4zbGtTNSz396NaVRdbqAV0QuU9E7i2LA
         A3Kk1fOBlZ4vTuWisXushO5Pfn86vg6AuEaS3OBXZ7YrYGkc/4OypGBlCafZ7YhItt7r
         0i9b3CdoIm/GcyDIfUlmq0KdvTmIW0aCP0OA6SWp8KFUeZneK1aEiEwtKHdwsr5PRXbS
         BKbaHxOy43sug3zHdLjlIRc0yVwFEk6TfX7M9HddQgcaGVqZuA+v8wCXBpSuWK0bejKV
         fQmNuYVmOBtmd/khYdYHpw7woA4l3lwCeF+vUMJe4xntorUcCrwkbHMNmR51BRvmN+yf
         ZP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913526; x=1696518326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10tpg/kDZqguMRr784ntEUQX0v75quYnrD94gsDzLMI=;
        b=g6lb+TDiLTzHMIckGdnEPmqXzfz8Krioqufc9KlSQQF9zsVo/ABd0cu/fhzP89cgqf
         8Fd4oUfrtdMDX2rU2n3c5APiiOuJWw9B9TdfegaLGoMRR2T9FgFyHnH5KSA8tQUHDojG
         iH0SIX7TtKwATwi6LuJ+X48ShA3LA85yX0lfGg8k5rVqM5WIVVprbH0nlD1u7nOCx65w
         /jUnjJ4O22OAQb537Y9IKAYLkWptm8TgsP1Nkk1PBxwgSagU+8eOoq3gpiOMcha/50av
         bDokg7xvQ8M4QEmJkHEV9VEjTUPywWo+iIh6s3fYUUqZLuhSDrSNg+Yd1tnC0A6mSQ4J
         PC1w==
X-Gm-Message-State: AOJu0Yx86PfhyGGagVBWpajhax5aAl3ou2G3i6lS72PRuWDn6FUV6Bib
        o/PO22ZPzTZBeoxilO/44fLYdDC0NK/eXznEKdZZWw==
X-Google-Smtp-Source: AGHT+IFOTmIegFdxE1pbBvydjcCObLlcOwcaEPzRI+iCsCZ4Xe1JvI7Hf1yJIzRhEcbhggR869qCF2qyHb0SKR3t3Lc=
X-Received: by 2002:a05:6358:928:b0:14c:e2d3:fb2e with SMTP id
 r40-20020a056358092800b0014ce2d3fb2emr1620140rwi.0.1695913525998; Thu, 28 Sep
 2023 08:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <6a829fb24c6b680275a08edf883ee458a9cab011.1695365438.git.Rijo-john.Thomas@amd.com>
In-Reply-To: <6a829fb24c6b680275a08edf883ee458a9cab011.1695365438.git.Rijo-john.Thomas@amd.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 Sep 2023 20:35:14 +0530
Message-ID: <CAFA6WYOk3M1EH1KPf4w=qYaQRF6Y_cnNWimJGTyiAdEokiNMKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
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

Hi Rijo,

On Fri, 22 Sept 2023 at 12:26, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
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
> To fix this issue, treat decrement of sess->refcount and invocation of
> destroy_session() as a single critical section, so that it is executed
> atomically.
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 372d64756ed6..04cee03bec9d 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -217,14 +217,13 @@ static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
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
> -       mutex_unlock(&session_list_mutex);
>         kfree(sess);
>  }
>
> @@ -272,7 +271,9 @@ int amdtee_open_session(struct tee_context *ctx,
>         if (arg->ret != TEEC_SUCCESS) {
>                 pr_err("open_session failed %d\n", arg->ret);
>                 handle_unload_ta(ta_handle);
> +               mutex_lock(&session_list_mutex);
>                 kref_put(&sess->refcount, destroy_session);

How about you rather use kref_put_mutex() here and then keep the
mutex_unlock() within the destroy_session()?

> +               mutex_unlock(&session_list_mutex);
>                 goto out;
>         }
>
> @@ -290,7 +291,9 @@ int amdtee_open_session(struct tee_context *ctx,
>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
>                 handle_close_session(ta_handle, session_info);
>                 handle_unload_ta(ta_handle);
> +               mutex_lock(&session_list_mutex);
>                 kref_put(&sess->refcount, destroy_session);

Ditto.

> +               mutex_unlock(&session_list_mutex);
>                 rc = -ENOMEM;
>                 goto out;
>         }
> @@ -331,7 +334,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>         handle_close_session(ta_handle, session_info);
>         handle_unload_ta(ta_handle);
>
> +       mutex_lock(&session_list_mutex);
>         kref_put(&sess->refcount, destroy_session);

Ditto.

-Sumit

> +       mutex_unlock(&session_list_mutex);
>
>         return 0;
>  }
> --
> 2.25.1
>
