Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39C37B6F75
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 19:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJCRSo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 13:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjJCRSn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 13:18:43 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77E5B0
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 10:18:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65af8d30b33so257156d6.1
        for <stable@vger.kernel.org>; Tue, 03 Oct 2023 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696353519; x=1696958319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR+LzcOsWe5o7C55KvgeLgyC5UugjXBR7+grahrSdD4=;
        b=X35rorxgm7I/Q6ST7z7AdejGjih+9mFppH8FCOczrMDwsqLB07LRrkRbuyR0v9uZqs
         THy0vNqlfe+fDxxS7c/k5qx10anRibcurKaCkXFUEhogw/g6m9Vhdd4oygeE3X2l3nQc
         utnXsyRukuCHVSf1NWzZeS6sQ6Z1sJ4CeG9UHCBQLmGMbEs3KnagPUJBcV0vzGGwJbw5
         dTRIDc+xh0xYPF6u6RpbUXmP5ORqqlJRRyGj4E8HPbGb6WG2ndrb5Swb/Igh36vy3bwF
         l4BlGUnJuWy/J+b+HbQ+CJXgmNGv+fmNC8TO/y8OYcABCqp5XbJBoLnrY1rdbFoP0tdd
         5zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353519; x=1696958319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR+LzcOsWe5o7C55KvgeLgyC5UugjXBR7+grahrSdD4=;
        b=LAzcKuOdxWjCmsVJYxSkMmJSEQIAI5W8C8oaopqWiEDTr4Lr2hjEOkFzmYqr1CcXRT
         v9t6ooo+1nUl8QAQ0G/rmfCgDev0FGqdC9xhRtaGDn6ndwWAVUyaxqeuIYEgK612YbHl
         ye6RquA1FWCJlyBJ38CK2YkHCFtM7oHJyUzsVLEeVBedUv5J+JEaQ3Q/DuphGITaErzl
         Cd7PGpiadM8DCj/r9hQ4Lb0LIqxZCZR44YZ9XpGUIOvOB3y1XoWS7LZpy/GHasP6cY2r
         vGC5aq2XU/et2u5nTxrbjg9XorwRqeRH67HtW5csc3Uzav7V4A2ppKl7jPqu9mcrBr18
         vAdw==
X-Gm-Message-State: AOJu0YyYlwXg98ekIK2fwzANrMhGtnMoJXsVf59PVxsC+l8Hs4dAR+yC
        EeEg+6U848OhHR9Cjd8jwcOBVy0YIN0topg5HT4+jA==
X-Google-Smtp-Source: AGHT+IFJGJ3O+FiyXs6ht2zkV2aewucJG1Rba3k4Ae0h6AX4cXMLktEIXK2fKtnFyCJDgBw9/DFj0rI9BDTEWQX8YLM=
X-Received: by 2002:a05:6214:3018:b0:64c:2339:ec8c with SMTP id
 ke24-20020a056214301800b0064c2339ec8cmr3703754qvb.13.1696353518775; Tue, 03
 Oct 2023 10:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <0a535fc59c3ec89b52ef76574232fab8457ebd7e.1695970674.git.Rijo-john.Thomas@amd.com>
 <CAFA6WYN9xHUmxrJJM_o1P-gcfYS=UrBQXEO7w4Nt9g=xErbxrQ@mail.gmail.com>
In-Reply-To: <CAFA6WYN9xHUmxrJJM_o1P-gcfYS=UrBQXEO7w4Nt9g=xErbxrQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 3 Oct 2023 19:18:27 +0200
Message-ID: <CAHUa44HLnuuv2k+rVsMecHwDPFYD8yViVKn++fnqT99UEG0_Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        op-tee@lists.trustedfirmware.org,
        Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Nimesh Easow <nimesh.easow@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 3, 2023 at 7:14=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Fri, 29 Sept 2023 at 12:30, Rijo Thomas <Rijo-john.Thomas@amd.com> wro=
te:
> >
> > There is a potential race condition in amdtee_close_session that may
> > cause use-after-free in amdtee_open_session. For instance, if a session
> > has refcount =3D=3D 1, and one thread tries to free this session via:
> >
> >     kref_put(&sess->refcount, destroy_session);
> >
> > the reference count will get decremented, and the next step would be to
> > call destroy_session(). However, if in another thread,
> > amdtee_open_session() is called before destroy_session() has completed
> > execution, alloc_session() may return 'sess' that will be freed up
> > later in destroy_session() leading to use-after-free in
> > amdtee_open_session.
> >
> > To fix this issue, treat decrement of sess->refcount and removal of
> > 'sess' from session list in destroy_session() as a critical section, so
> > that it is executed atomically.
> >
> > Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> > ---
> > v2:
> > * Introduced kref_put_mutex() as suggested by Sumit Garg.
> >
> >  drivers/tee/amdtee/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> > index 372d64756ed6..3c15f6a9e91c 100644
> > --- a/drivers/tee/amdtee/core.c
> > +++ b/drivers/tee/amdtee/core.c
> > @@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx=
, void *ptr, void **ta,
> >         return rc;
> >  }
> >
> > +/* mutex must be held by caller */
> >  static void destroy_session(struct kref *ref)
> >  {
> >         struct amdtee_session *sess =3D container_of(ref, struct amdtee=
_session,
> >                                                    refcount);
> >
> > -       mutex_lock(&session_list_mutex);
> >         list_del(&sess->list_node);
> >         mutex_unlock(&session_list_mutex);
> >         kfree(sess);
> > @@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
> >         if (arg->ret !=3D TEEC_SUCCESS) {
> >                 pr_err("open_session failed %d\n", arg->ret);
> >                 handle_unload_ta(ta_handle);
> > -               kref_put(&sess->refcount, destroy_session);
> > +               kref_put_mutex(&sess->refcount, destroy_session,
> > +                              &session_list_mutex);
> >                 goto out;
> >         }
> >
> > @@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
> >                 pr_err("reached maximum session count %d\n", TEE_NUM_SE=
SSIONS);
> >                 handle_close_session(ta_handle, session_info);
> >                 handle_unload_ta(ta_handle);
> > -               kref_put(&sess->refcount, destroy_session);
> > +               kref_put_mutex(&sess->refcount, destroy_session,
> > +                              &session_list_mutex);
> >                 rc =3D -ENOMEM;
> >                 goto out;
> >         }
> > @@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u=
32 session)
> >         handle_close_session(ta_handle, session_info);
> >         handle_unload_ta(ta_handle);
> >
> > -       kref_put(&sess->refcount, destroy_session);
> > +       kref_put_mutex(&sess->refcount, destroy_session, &session_list_=
mutex);
> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >
