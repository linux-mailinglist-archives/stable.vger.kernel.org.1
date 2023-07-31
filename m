Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3076A149
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 21:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGaTbT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGaTbS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 15:31:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D1199A
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:31:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe383c1a26so2025431e87.1
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690831874; x=1691436674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ANccUczuCdN/Ctbbd+CLowkmR/s9+vGuLKhYUkmLMiM=;
        b=g3DHojZdzR4AtFnafLgXcdiYZhs/PUZV9eFNZwj2qDJmppmTMxtgdctVcFk+XYdSuS
         39bdNJZN0ISfpf9OF29Z1NG1w9zDF+12g/Jy+AmtYLP6t2W/nrETrFfc5sCh9LEB9O2W
         fWSPBg1/18olsNfxyLiexST/xgjfElDpEJEMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690831874; x=1691436674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANccUczuCdN/Ctbbd+CLowkmR/s9+vGuLKhYUkmLMiM=;
        b=MRr0yxz27/POhGSSpXGxHlWxR4DrEWRRqDMonnzLkjDCliAX6Q1XT+ZjtMEPO6juoU
         7i+0wi7nxS0nt/UtnS8ntxDx/s0SVA9Na8hSvgAnjUr3poj7VkaUtHqqQXhM62tgDmfq
         EHYI+yTLMmwxPTGPyaGbKcp2FsG3qpvoSi2vh8uDsbvjjJt9xdW8sQy24/YQOKt88hgW
         6sWUAFbObGDFG5MSMWvWDiqvvvJKZDWSjJ0ekvAIWQgDOacx3qmj+kDnP/uo3Ee8AYBL
         RUE+9gS8OaQLM3sG53/JgUxOEqYoSJcnHq7r+cw9DeDJV1lcWXeNn3dEjNaXeQ2ogNK3
         I8ZQ==
X-Gm-Message-State: ABy/qLa2LIl5Vb0bflrPmUwcHve/SYRemD43S8ps38qn/8jm+RafTm04
        blE0X2fWXe4epm97vU9kUC5BkJvPZ1IHFLR3jMxuK2Ze
X-Google-Smtp-Source: APBJJlEW2j76tlAnucoWMLDVbOGWckpdFCR2ITPTafeasfKaVADo1+hyN+Os62roOFWy4CerJr0QDQ==
X-Received: by 2002:a05:6512:718:b0:4fb:8939:d95c with SMTP id b24-20020a056512071800b004fb8939d95cmr470248lfs.30.1690831873999;
        Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id er7-20020a05651248c700b004fdc0f2caafsm2205833lfb.48.2023.07.31.12.31.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so7879571e87.2
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:31:13 -0700 (PDT)
X-Received: by 2002:ac2:5931:0:b0:4fb:92df:a27b with SMTP id
 v17-20020ac25931000000b004fb92dfa27bmr523833lfi.39.1690831873036; Mon, 31 Jul
 2023 12:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
In-Reply-To: <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:30:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Message-ID: <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 31 Jul 2023 at 12:18, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> > Is there some way to just see "this is a fTPM"?
>
> How many fTPM implementations are there?  We're talking like less than 5
> right?  Maybe just check against a static list when
> calling tpm_add_hwrng().

Sounds sane. But I was hoping for some direct way to just query "are
you a firmware SMI hook, or real hardware".

It would be lovely to avoid the list, because maybe AMD does - or in
the past have done - discrete TPM hardware?  So it might not be as
easy as just checking against the manufacturer..

That said, maybe it really doesn't matter. I'm perfectly fine with
just the "check for AMD as a manufacturer" too.

In fact, I'd be perfectly happy with not using the TPM for run-time
randomness at all, and purely doing it for the bootup entropy, which
is where I feel it matters a lot m ore.

> I've had some discussions today with a variety of people on this problem
> and there is no advantage to get RNG through the fTPM over RDRAND.

Ack.

And that's true even if you _trust_ the fTPM.

That said, I see no real downside to using the TPM (whether firmware
or discrete) to just add to the boot-time "we'll gather entropy for
our random number generator from any source".

So it's purely the runtime randomness where I feel that the upside
just isn't there, and the downsides are real.

                  Linus
