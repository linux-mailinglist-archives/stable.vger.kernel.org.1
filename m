Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D27566E4
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGQOzl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGQOzk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 10:55:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE1E5E
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 07:55:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso41794185e9.2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689605738; x=1692197738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Um60IdY38/2nhVfyy77ENnW9T+svIRdvrShke75yihw=;
        b=eS/YWMV6F838wXoTzt/721gnZF0/xCazCzu6yvfUo0StfscUK94di+0EnVwtH8gyTC
         AcxECF9YBnK81IatsuuJynHCudTrPY4/+G1/QMBxtvoi7IdFc3hcLJ+l1zafPCi+7NSl
         HDy/Egp7pzOdWV/JawDisC7jL+hqYR7FbOXurgoCoGcshXOaGDd0vBctJRjSYYSAJ51x
         kIuX2RjD1EWlQTL3ENSIJYSNXyPXRVT8XhLk/CcKUhcaCkNxLetd8TsNf1o5Aqv1RPAs
         Vj3fsV2Grvf9hcLdWyDAigB410ZxrTxRyyt9IwHn/N6LVEH6niOs6AI6m1+i2Gnd5SZk
         V5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605738; x=1692197738;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Um60IdY38/2nhVfyy77ENnW9T+svIRdvrShke75yihw=;
        b=k1F2gb5vp77IfS3UVI0kHniNyd/BZpDZZE4vP90sbq+/LnsZzrTShHDQJVHxtxSHJ/
         NZKejd4ZNH1MyDzTFdvEzXBbR6gUnSnd0tI2jQepcDrdeum0bLL+epTMbmG8eRmp5Z9P
         hKPKklAinYo39FRnTAHLzic6BfWMIROTppUAxOrZxRNqNrrIAT2fiJ9ERSFjbJFTssy+
         glXA7mzqK/Eylr6+F5h1c99R9zGs/W29FMoLQ2suAx9N3FATFzmLl4RnUkKA4DefNuOL
         CuNrH1L9dc0i/wiuuT2H2wiEJKgKA+LT4KH/MpSBOk5JCc8vzMlnundP3Vigzgb0p2SW
         U2Yg==
X-Gm-Message-State: ABy/qLbG6zv8wSxYljUM9vnjBPc9f0Mh3CU+9ca/lheQ2Iqk2Oj9QW5k
        DnzBaNth9MQrt0FGBtSau1o=
X-Google-Smtp-Source: APBJJlGvRYR13hf7d/i0WWbCC7X8x6Anxex+0/bRAaDUEe7/NUzkmeIDvoDDI4i2u7FMXXNkCqEaQw==
X-Received: by 2002:a7b:c3d0:0:b0:3fb:b890:128e with SMTP id t16-20020a7bc3d0000000b003fbb890128emr9628611wmj.33.1689605737772;
        Mon, 17 Jul 2023 07:55:37 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003fb225d414fsm8087143wmi.21.2023.07.17.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:55:37 -0700 (PDT)
Message-ID: <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Luiz Capitulino <luizcap@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com
Date:   Mon, 17 Jul 2023 17:55:35 +0300
In-Reply-To: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 2023-07-17 at 09:04 -0400, Luiz Capitulino wrote:
> Hi,
>=20
> The upstream commit below is backported to 5.10.186, 5.15.120 and 6.1.36:
>=20
> """
> commit ecdf985d7615356b78241fdb159c091830ed0380
> Author: Eduard Zingerman <eddyz87@gmail.com>
> Date:   Wed Feb 15 01:20:27 2023 +0200
>=20
>      bpf: track immediate values written to stack by BPF_ST instruction
> """
>=20
> This commit is causing the following bpf:test_verifier kselftest to fail:
>=20
> """
> # #760/p precise: ST insn causing spi > allocated_stack FAIL
> """
>=20

I can reproduce the error on 6.1.36 but don't understand what's causing it =
yet.
The log is suspiciously different from master, will comment later today.

> Since this test didn't fail before ecdf985d76 backport, the question is
> if this is a test bug or if this commit introduced a regression.
>=20
> I haven't checked if this failure is present in latest Linus tree because
> I was unable to build & run the bpf kselftests in an older distro.
>=20
> Also, there some important details about running the bpf kselftests
> in 5.10 and 5.15:
>=20
> * On 5.10, bpf kselftest build is broken. The following upstream
> commit needs to be cherry-picked for it to build & run:
>=20
> """
> commit 4237e9f4a96228ccc8a7abe5e4b30834323cd353
> Author: Gilad Reti <gilad.reti@gmail.com>
> Date:   Wed Jan 13 07:38:08 2021 +0200
>=20
>      selftests/bpf: Add verifier test for PTR_TO_MEM spill
> """
>=20
> * On 5.15.120 there's one additional test that's failing, but I didn't
> debug this one:
>=20
> """
> #150/p calls: trigger reg2btf_ids[reg=E2=86=92type] for reg=E2=86=92type =
> __BPF_REG_TYPE_MAX FAIL
> FAIL
> """
>=20
> * On 5.11 onwards, building and running bpf tests is disabled by
> default by commit 7a6eb7c34a78498742b5f82543b7a68c1c443329, so I wonder
> if we want to backport this to 5.10 as well?
>=20
> Thanks!
>=20
> - Luiz
>=20

