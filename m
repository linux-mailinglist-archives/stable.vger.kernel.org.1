Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5567C9147
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 01:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMXWR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 19:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 19:22:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A1BB
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 16:22:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b2018a11efso1112171b3a.0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697239334; x=1697844134; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKcBvgIFtbgHLCV0rKiHCMXiTHe2UYdDSn99gqrNr+8=;
        b=EIblkzEDKM5I2W0pGOiKoahnMVxaAHR6OORwcHtuQCIOc5lwj+fC8g6KmB6IpcDv59
         i5M09D6ft1PY5vvWUpN2V3pEnWvFUlLgx9kEpJXN0ZbNRS+L8dHFv2gqlhrOqTP9G5yJ
         /z6AqPr2ZzrgWJUr5KHvAWYr3fcck7IdWAG4m9QgdkjtSO7k1OFSh2xYttcNTwFvGlIs
         8OUELv9FPG+UDP7bT2ivbixesSCxZK4N684onzo+IdU1yz+BgIK9IlUMt/mpqCNrc91l
         QK9RmQM91+6wTMSvoirYCyREH7Nd1JCH4k2FVOmohvaeYJnGc7A+0e3Ekk2nSnMEcWoK
         dRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697239334; x=1697844134;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKcBvgIFtbgHLCV0rKiHCMXiTHe2UYdDSn99gqrNr+8=;
        b=viyFyNwMZS2PoplDgg5+c7blxhdG9V3QY/mUcqs3Ci6pm2i0wKVlcyoca/Uh9wku/9
         Ku2xE+CfIhYUon6Et8baSyGj/qB7uFX189YzORvbv5zBx3AbqKS+qkpO0moTOQKYjWFZ
         tmOF1Zy89hycrMermdxf8UAOL30Ty2S+hnEDGDgo7bdV6pfHUqcGb5ociJq1SxkBdc3j
         cmqlH7ijPJUl3G5SCUYkUAw9pNyJh/yyAqJ8fmCcucFtv5usAiTDwl2UL08HxFFH8VSI
         ReoAG6ELCB+8m30ZZ6IXpUfHTVW9Iyy7pYIdWs9sWkA/g8kI7WWMyHrYZAOq3NZpPvgc
         +EyQ==
X-Gm-Message-State: AOJu0YxFf2QVYlJX0LlTooN8yf4xicNgg00z3ilUZVEiQojah/0qKMdv
        CXd5166apWBVopPFTA91qp0on0LR1v2LZ1Wy2clGbL90l+g=
X-Google-Smtp-Source: AGHT+IEYVMACSNSQj+OmyP9X0D8HnJbH/rDjgelx6tz5RK7p8fVjIDIa8ga7xfmtFkIT3z25K3hJuWF/u0nn0yGWdQQ=
X-Received: by 2002:a05:6a20:12c9:b0:15c:b7ba:6a4d with SMTP id
 v9-20020a056a2012c900b0015cb7ba6a4dmr33518381pzg.50.1697239333962; Fri, 13
 Oct 2023 16:22:13 -0700 (PDT)
MIME-Version: 1.0
From:   Younes Manton <younes.m@gmail.com>
Date:   Fri, 13 Oct 2023 19:22:02 -0400
Message-ID: <CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com>
Subject: Request backport of "perf inject: Fix GEN_ELF_TEXT_OFFSET for jit"
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The following commit:

[babd04386b1df8c364cdaa39ac0e54349502e1e5] perf jit: Include program
header in ELF files

introduced a bug in perf that causes samples to be attributed to the
wrong instructions in the annotated assembly output of `perf report`
and `perf annotate`.

The following commit:

[89b15d00527b7825ff19130ed83478e80e3fae99] perf inject: Fix
GEN_ELF_TEXT_OFFSET for jit

fixes the bug.

Buggy commit is present in 4.19, 5.4, 5.10, and 5.15. The fix is in
6.1, 6.4, and 6.5. Can it also be backported to at least the 5.x
kernels, if not 4.19?

The output looks very confusing when parts of the code one expects to
accumulate ticks don't and other parts that shouldn't be executed at
all accumulate ticks.

I opened https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2020197
and was directed here, hopefully I understood the request correctly.
Thank you.
