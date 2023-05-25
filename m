Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E825710D4D
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjEYNgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbjEYNgI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 09:36:08 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE33A13A
        for <stable@vger.kernel.org>; Thu, 25 May 2023 06:36:02 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-456f7ea8694so185218e0c.0
        for <stable@vger.kernel.org>; Thu, 25 May 2023 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685021762; x=1687613762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ov9l8FL7BwYwKqG7H5oyY0frtOe8uhygiLSX6k8PTbI=;
        b=FTGnmwc/8XuVxw8RRrNUkhtbD1OmLbPoXEWEuxveBCQE1e4MEAMCAMzeS2w3tD0MlC
         OCc7FUarJb2g2hJ+RlEquLLDByg6UsKYwOaf+b2gSBxiar8useuctrOZSNt//fTQDF2W
         BgwZ8TY8c9BYqTdrGw11hb/IrxpWMubofw3e0Fk4WvIR8QbM4mDDEgnLU3zqZ71CFBAI
         jz10RAtTyXDso74IZ2isDf0HgAtJvEVeoZ8qnUSr9QyVgWID2EgySX0/7feflWsFO9iX
         5/2M9ooFpuSbwsAQvjVQ4aRsUlcv55SWImpxppNIkxW2sX0ugX/wJcnOUdBi12iQPzgO
         On9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685021762; x=1687613762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ov9l8FL7BwYwKqG7H5oyY0frtOe8uhygiLSX6k8PTbI=;
        b=NcPtQxZdUYrmyVHBpxGtY7i5J+QMQ3+GHrvQ/YVDNrvE0BoNEWl32IvbqVXFb2nU70
         zArW63c9X29iLtypvGTrGtbhZdVjtb/QZfuhHGpjMJQYckAbxutHeHERAAhgtvYgxuzS
         iisgBa4aIpN5yq17WMTHO4SbenQ8bsJNvMFR/mp9VkcIg+lJEeNgGuUQoD4q18YXbRCO
         UCmF4IurE4OJRslD5jE0OvMVjEohjg6IhDtUHeeIdLhVJIqK1u06Wv19u5acszV7AQAt
         Ny+ndaWyBDD5dmmI6Yra8P6Q3yhsLrPaEdWDMRjMgFizstpWh6fi8C3rzynRIY83wXgd
         L1iQ==
X-Gm-Message-State: AC+VfDwqR+/jhvtjEXnf/EtIcTdvkUacQ7NlXDKNrAxLKkul31QPG12a
        KFjxGZQAzRNgFYmIILxhwu6RbEmoX6sgtVfQ18iklQ==
X-Google-Smtp-Source: ACHHUZ6hEQ45lbwXx+G6ezAhs9WCYK6b2/hR5Ysgv/EhTEfLG4ICjMUwPmh9Da0tdUB8On5X47OsUHjbWWRnS06hQFE=
X-Received: by 2002:a1f:43d5:0:b0:440:4058:936e with SMTP id
 q204-20020a1f43d5000000b004404058936emr6477554vka.12.1685021761798; Thu, 25
 May 2023 06:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
 <20230516134447.GB30894@willie-the-truck> <20230522164117.GA6342@willie-the-truck>
In-Reply-To: <20230522164117.GA6342@willie-the-truck>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 May 2023 19:05:49 +0530
Message-ID: <CA+G9fYs2y4RvOEOJ2qwX=O98j7sgkQJ+jZucd28wPUj6L-vN2A@mail.gmail.com>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in fpsimd_release_task
To:     Will Deacon <will@kernel.org>
Cc:     broonie@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 22 May 2023 at 22:11, Will Deacon <will@kernel.org> wrote:
>
> Naresh,
>
> On Tue, May 16, 2023 at 02:44:49PM +0100, Will Deacon wrote:
> > On Tue, May 16, 2023 at 11:58:40AM +0530, Naresh Kamboju wrote:
> > > Following kernel BUG noticed while running selftests arm64 fp-stress
> > > running stable rc kernel versions 6.1.29-rc1 and 6.3.3-rc1.
> >
> > Is there a known-good build so that we could attempt a bisection?
>
> FWIW, I've been trying (and failing) all day to reproduce this in QEMU.
> I matched the same VL configuration as you have in the fastmodel and
> tried enabling additional memory debugging options too, but I'm yet to
> see a kfence splat (or any other splat fwiw).

Thanks for trying it out.
I have shared log [Log link] below on Linux next-20230314 which is the
starting point of BUG that we started noticing and that is raw log showing
FVP log with all -C details.

>
> How often do you see this?

Our CI system running  selftests: arm64 - subtests by using
./run_kselftest.sh -c arm64

With full selftests: arm64 the probability of occurrence is 40%.

On Linux next this fp-stress BUG: has been happening *intermittently* from
next-20230314 dated March 14, 2023.
On Linux stable-rc it started happening on 6.3.2-rc1 and 6.1.28-rc2.

More details (on previous email),
- https://lore.kernel.org/all/CA+G9fYtZjGomLjDi+Vf-hdcLpKPKbPmn4nwoPXvn24SG2hEJMg@mail.gmail.com/

- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230314/testrun/15566007/suite/log-parser-test/test/check-kernel-bug-
9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/details/

Log link:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230314/testrun/15566007/suite/log-parser-test/test/check-kernel-bug-9588df685892e898be8969def31c5aa074b2faada33f12ebc88fd7e7b52893cd/log


>
> Will
