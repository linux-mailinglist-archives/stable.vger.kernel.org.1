Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC29B78E0A0
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 22:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbjH3U2L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbjH3U14 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 16:27:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052E559A
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 13:26:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34df9c2748eso26025ab.0
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693427091; x=1694031891; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neliSw7qoh+YUhiPFUyH0EEqS3rYdeTkzSKzjqUjw8A=;
        b=IJdPCyHWXCHo2ElXDD02RleXwRQajypw/d2JWppvA7EHbO+JpMUQqq22rTiJuKt6ao
         1633Axr/ADHAT1UQbFhPJJrydsZ6fkeCtQ/xGBYZ5DyiTxAHV+srldYsxW/6Vp+ZbM/t
         8ytwf35RekkDZdzpSlsBKaQMR03p+6tn0NJI3lsjWk76dWvACeXytOu+ABSdTdxEFt6k
         GMC0n7AH8SInh/wKfDgrkkfm9RqOxwMUC5SLnMfUdQ+4RDwbXzVDif5J/xZQ6PAJTyQ9
         Muhc4Fu9qTGv5MZmvxvik5+rKXmapz52NgR4PIBX1DD9g+Z3M0clEGR97KeF1bx23uW1
         +tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427091; x=1694031891;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neliSw7qoh+YUhiPFUyH0EEqS3rYdeTkzSKzjqUjw8A=;
        b=V+RyAfKY2l/xzqnu0FcZGfgPk2XlfI2Y9b7mIpbYdZV1qu796HEKjXgOOI8X6HPMJ0
         GeVgPeaOfJWFgF+rjsZ87MLZCq6gtdM1hq/ruTEUcnVRPtE6bpAClSbfazsAB+Whxu/8
         lWQy8cajXZKkrYjbAP2B+7SMaqrUDqF/ZybbgkhhBP+X5XLDMIyCef5gVTuy3AqmlMMx
         Yv0ioQtTR0RpuEsWiIkM/x95P1fLKMNXa/mWDtUrbDKwam8eP3k2ja8t8tjW88KzSl9R
         QQije1N5dn6m5wH8O/zx6V6skazGCt6OywRm1ExI0SHO8RMBH9ziXCYwqV6l7UzYq8Qc
         VkSQ==
X-Gm-Message-State: AOJu0YyZ003cNmUzTRqcjL3okzREkTQEm+MiZLFLFXTcVeojaL76c1id
        eUofh7Lvw5mSGNqe2eswuDrMBuZx7g/leMHDeWsEfw==
X-Google-Smtp-Source: AGHT+IEtPBJyW+fxDSwfhZLVKMbrw+fx+hC8DUP+9B7LnqUilulxgXIOq0VIs7hNfhDbzxT0E54wrg==
X-Received: by 2002:a17:902:e551:b0:1c1:efe5:cce5 with SMTP id n17-20020a170902e55100b001c1efe5cce5mr28280plf.3.1693422989246;
        Wed, 30 Aug 2023 12:16:29 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b0068a0922b1f0sm10343368pfn.137.2023.08.30.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:16:28 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Raits <igor.raits@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1561
 __cfsb_csd_unthrottle+0x149/0x160
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
Date:   Wed, 30 Aug 2023 12:16:24 -0700
In-Reply-To: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com> (Bagas Sanjaya's
        message of "Wed, 30 Aug 2023 07:37:49 +0700")
Message-ID: <xm26cyz4ibnb.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
>> Hello, we recently got a few kernel crashes with following backtrace. Happened on 6.4.12 (and 6.4.11 I think) but did not happen (I think) on 6.4.4.
>> 
>> [293790.928007] ------------[ cut here ]------------
>> [293790.929905] rq->clock_update_flags & RQCF_ACT_SKIP
>> [293790.929919] WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1561 __cfsb_csd_unthrottle+0x149/0x160
>> [293790.933694] Modules linked in: [...]
>> [293790.946262] Unloaded tainted modules: edac_mce_amd(E):1
>> [293790.956625] CPU: 13 PID: 3837105 Comm: QueryWorker-30f Tainted: G        W   E      6.4.12-1.gdc.el9.x86_64 #1
>> [293790.957963] Hardware name: RDO OpenStack Compute/RHEL, BIOS edk2-20230301gitf80f052277c8-2.el9 03/01/2023
>> [293790.959681] RIP: 0010:__cfsb_csd_unthrottle+0x149/0x160
>
> See Bugzilla for the full thread.
>
> Anyway, I'm adding this regression to regzbot:
>
> #regzbot introduced: ebb83d84e49b54 https://bugzilla.kernel.org/show_bug.cgi?id=217843
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217843

The code in question is literally "rq_lock; update_rq_clock;
rq_clock_start_loop_update (the warning)", which suggests to me that
RQCF_ACT_SKIP is somehow leaking from somewhere else?
