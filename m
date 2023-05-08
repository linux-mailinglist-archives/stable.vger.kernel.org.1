Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319E06FB4E6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjEHQQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjEHQQg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 12:16:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DDF49EE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:16:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f2548256d0so295785e9.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683562592; x=1686154592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPrcBb2Ah0kfOoaFszvDkHKeVnCaFX5eQKXoC29Tzm8=;
        b=7a026Pqh7GkM9PJFh1N/RqFv9MCaJ76Vn0sLpxnUhuQXnFScIwh8xXjLjL3pRuOp31
         QhIvYBUWT9TVEptFtFteta78AdLwfnBPjIONsiwAxHpT3nDpC9e4mhTIO/6+2aHT1Uh1
         Lb7scZfXXpDjHch6ARYEdiqozKOtW4pl57z6hPjf63j5tPxUCYV7nkZ9pvCsj4kHRiey
         K00Z+14yjuvVya5MXoDG8a0e27Khpy1PDe6/RGphW8b/JEZZB0JPj43bCmYE3zJ9VVR9
         fwy4QJaMVuct1ztQv8THE59zXE5MMHSGYmvoZVe5C7mDcQPqiG6WXQUtRx1qttIBo1yr
         avAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683562592; x=1686154592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPrcBb2Ah0kfOoaFszvDkHKeVnCaFX5eQKXoC29Tzm8=;
        b=CGWsPXkjDyczxDyKU/OE0gMCaPnWn7dkLMUadGv4wBVi52oIAqBMqhZELZaIEMxkhL
         i58dr3PXLwTp6bn/hVrrLjLOuyFAjLXozGdrXrAKEELfi+FO3kXud4Hq+fV61ytm+RoR
         zz4sUBQNPXYvMf6tLKklZjoUbaDstSthRkevPP3QxW/z9NZqfMVEpmH2gU/GAunuFCQH
         O9wQ3Kc4ycXs8EbTCr8lHZ7+nuELTDftjahUrdku0tu8+XGEycJ2iS01jsk6AoXIuF3L
         ZMVxqSzdGaRY3R3sVhb9gRaXzhcJvDkgoyReSDu9m2y6Mkd0u5NMzbzlf/XPwD9PSK9b
         DEcw==
X-Gm-Message-State: AC+VfDwy/vS5USH0Z7eaRWBUmYsakfD/JuQbTK1KFcAPfC8hiEZdA4lE
        D4opQcVl9FeH3w0yuK8P8Z5yi4kmhzB3tM/hfQrOjg==
X-Google-Smtp-Source: ACHHUZ5hFRkJ5iedrb7N0JePgc5+ke55o/q2Hh5UpZffH2mYawRXdkataqjtbiL0ZQIMWnAgWk+A0oe3hbHyu9q23Jk=
X-Received: by 2002:a05:600c:1d02:b0:3f4:2594:118a with SMTP id
 l2-20020a05600c1d0200b003f42594118amr235605wms.2.1683562592077; Mon, 08 May
 2023 09:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230508140206.283708-1-kan.liang@linux.intel.com>
In-Reply-To: <20230508140206.283708-1-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 8 May 2023 09:16:20 -0700
Message-ID: <CABPqkBSczJqEbA8M0HCdeqjddgDqpxapJYVYNuAS+EifJ+v+Dg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on SPR
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 8, 2023 at 7:05=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The number of CHAs from the discovery table on some SPR variants is
> incorrect, because of a firmware issue. An accurate number can be read
> from the MSR UNC_CBO_CONFIG.
>
> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server C=
HA support")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Tested-by: Stephane Eranian <eranian@google.com>

>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/events/intel/uncore_snbep.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index 7d1199554fe3..54abd93828bf 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6138,6 +6138,7 @@ static struct intel_uncore_type spr_uncore_mdf =3D =
{
>  };
>
>  #define UNCORE_SPR_NUM_UNCORE_TYPES            12
> +#define UNCORE_SPR_CHA                         0
>  #define UNCORE_SPR_IIO                         1
>  #define UNCORE_SPR_IMC                         6
>  #define UNCORE_SPR_UPI                         8
> @@ -6448,12 +6449,22 @@ static int uncore_type_max_boxes(struct intel_unc=
ore_type **types,
>         return max + 1;
>  }
>
> +#define SPR_MSR_UNC_CBO_CONFIG         0x2FFE
> +
>  void spr_uncore_cpu_init(void)
>  {
> +       struct intel_uncore_type *type;
> +       u64 num_cbo;
> +
>         uncore_msr_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MSR,
>                                                 UNCORE_SPR_MSR_EXTRA_UNCO=
RES,
>                                                 spr_msr_uncores);
>
> +       type =3D uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CH=
A);
> +       if (type) {
> +               rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
> +               type->num_boxes =3D num_cbo;
> +       }
>         spr_uncore_iio_free_running.num_boxes =3D uncore_type_max_boxes(u=
ncore_msr_uncores, UNCORE_SPR_IIO);
>  }
>
> --
> 2.35.1
>
