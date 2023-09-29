Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61D77B3737
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjI2Ps2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 29 Sep 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2Ps1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 29 Sep 2023 11:48:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803CDB4
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 08:48:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so108703365ad.0
        for <stable@vger.kernel.org>; Fri, 29 Sep 2023 08:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696002505; x=1696607305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHMp50cB4ZdvpcshTa5CAlEa1+mL8NJsLojoOMgbH7Y=;
        b=K7Rs6VlkuHgHcebD8VKnZ/xSSaRwu9doWbhst0ArkJs/1Wxv/3t3sIHPLbpmzlaf9A
         SpXloWJ2OsIKtD433JKP5wrCayuDFgXATsOwhSDVSS1Xc2BxPPMk1XlljWet+gUN94Rr
         a4j/+rrfXHQ4TFfcbr6QmnYaKs/kJPDeQ1PkmLDQS64VNw9vXW8KqJYREZwFvXl1Ak6N
         X/xvdcvRRSk2K9t17DlwZQV1cR6Pzn4Sl4W6iSyZpFJrUvvGrXdLmqf3PaI89zXN4ruy
         Qh/ZrswanCY18D4xzKFdjonhtkSfp9nkMPZErnSeFDM52Al6Yx+UUaQet3T+ZJheb44F
         lxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696002505; x=1696607305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHMp50cB4ZdvpcshTa5CAlEa1+mL8NJsLojoOMgbH7Y=;
        b=cyGm4tZZcAL9QK6W56Xv8MVlNCyC8ST2DjhUdm877JBcn+0VODUIN7sdn/YQewD9Z8
         kGZXJG2MmLwUMD6StzhI20Dee+PC0Ib0X1GZWhTFioYizVHk+S9lkMRV9SSYBKzaherv
         NJd7FOsw9lXFZOgvaUg/5ZE4j2pdYV348DczH49uZKbk5/aBycNyuw0DzNWVY4VSo3QT
         4l5p2Q+5sXqsbDDvAaUDB2q5ILaLpSO8o0AowJiIRo6gMd3UUYhZ9xwpHn8h73NZHN7x
         q5zIV0ic4l6v2Rtj8l4C220FSRhaA0NSFk73NAJmt+OJEr87xl7FAZy9ORJLrZxz+KM3
         fkkg==
X-Gm-Message-State: AOJu0YzQ2Syz3/S8WgUsTUIWmcpOIxFjtej/c+y1Uc3473gisZiW+ez4
        RyO/G5VIolHkjk6KSAg545co/Q==
X-Google-Smtp-Source: AGHT+IGSW6rybcodqhav5Eb1CSZvfRX8hwpUHhP+LFazOegwW0oC3aPtjIvmXKXi3WS6FM8+P929nQ==
X-Received: by 2002:a17:902:ed01:b0:1c5:ed6e:2534 with SMTP id b1-20020a170902ed0100b001c5ed6e2534mr4325547pld.26.1696002504749;
        Fri, 29 Sep 2023 08:48:24 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:141c:4ec5:6338:4001])
        by smtp.gmail.com with ESMTPSA id be8-20020a170902aa0800b001c3ea6073e0sm16985487plb.37.2023.09.29.08.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:48:24 -0700 (PDT)
Date:   Fri, 29 Sep 2023 08:48:19 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Clark <robdclark@chromium.org>, llvm@lists.linux.dev
Subject: Re: Build failure in v5.15.133
Message-ID: <ZRbxw45Cc5wHXRXZ@google.com>
References: <e56ced8d-d09d-469b-80df-0cc2bdd943f4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e56ced8d-d09d-469b-80df-0cc2bdd943f4@roeck-us.net>
X-Spam-Status: No, score=-15.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 27, 2023 at 06:37:10AM -0700, Guenter Roeck wrote:
> Hi,
> 
> I see the following build failure with v5.15.133.
> 
> Build reference: v5.15.133
> Compiler version: aarch64-linux-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
> 
> Building arm64:allnoconfig ... passed
> Building arm64:tinyconfig ... passed
> Building arm64:defconfig ... failed
> --------------
> Error log:
> drivers/interconnect/core.c: In function 'icc_init':
> drivers/interconnect/core.c:1148:9: error: implicit declaration of function 'fs_reclaim_acquire' [-Werror=implicit-function-declaration]
>  1148 |         fs_reclaim_acquire(GFP_KERNEL);
>       |         ^~~~~~~~~~~~~~~~~~
> drivers/interconnect/core.c:1150:9: error: implicit declaration of function 'fs_reclaim_release' [-Werror=implicit-function-declaration]
>  1150 |         fs_reclaim_release(GFP_KERNEL);
>       |         ^~~~~~~~~~~~~~~~~~
> 
> This also affects alpha:allmodconfig and m68k:allmodconfig. The problem
> was introduced with 'interconnect: Teach lockdep about icc_bw_lock order'.
> 
> #include <linux/sched/mm.h> is missing. Presumably that is included
> indirectly in the upstream kernel, but I wasn't able to determine which
> commit added it.
> 
> Guenter

Thanks for the report, our CI is also pretty red for ARCH=arm64
linux-5.15.y builds. Also one ARCH=arm build we have that's using
Alpine's config is hitting the same issue.  Making note of this with our
ML CC'ed so that other folks don't potentially re-triage. Happy to hear
there's already a fix inbound.
