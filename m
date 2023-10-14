Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0F7C956A
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNQie (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjJNQid (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 12:38:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB5A2
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 09:38:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A447C433C7;
        Sat, 14 Oct 2023 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697301512;
        bh=dQl9TCXt5svBQVtYqasP/N4wA3dmmtMMr95KqnKCpBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdghomp3Z9RG4TlaeSmr0v+p3iPiQHIB/+APF+QA7P/fdbUc5vnoUjPfX69L6y5+H
         yTUxm1AaKuhh+EGJOKUXRqiTa8sr7uk6ANw96HnM/qXMX7PB1j7XsUqXJY4vyrWX31
         oGk9wseeFuV/pF8OF48zUXR4LATW057vy39Qm0wVoeiwfkH/m6pdP8aQnRKnTMB/w9
         2OeQgRYUlJkkHlu7jg+rLX96TVaQX13zG4VZBqYOutyPFzp58iv2SYL6m5kuhVWmCa
         iUd5F7k7wm90eBpALcqEiu8D2pU1An7DPUiuaRQ24+yLL4w/JIj1hoB4kWEtCr/n/i
         Dn2eioPpqAw3A==
Date:   Sat, 14 Oct 2023 12:38:30 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Younes Manton <younes.m@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: Request backport of "perf inject: Fix GEN_ELF_TEXT_OFFSET for
 jit"
Message-ID: <ZSrEBsL38S6rXTkX@sashalap>
References: <CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 13, 2023 at 07:22:02PM -0400, Younes Manton wrote:
>The following commit:
>
>[babd04386b1df8c364cdaa39ac0e54349502e1e5] perf jit: Include program
>header in ELF files
>
>introduced a bug in perf that causes samples to be attributed to the
>wrong instructions in the annotated assembly output of `perf report`
>and `perf annotate`.
>
>The following commit:
>
>[89b15d00527b7825ff19130ed83478e80e3fae99] perf inject: Fix
>GEN_ELF_TEXT_OFFSET for jit
>
>fixes the bug.
>
>Buggy commit is present in 4.19, 5.4, 5.10, and 5.15. The fix is in
>6.1, 6.4, and 6.5. Can it also be backported to at least the 5.x
>kernels, if not 4.19?
>
>The output looks very confusing when parts of the code one expects to
>accumulate ticks don't and other parts that shouldn't be executed at
>all accumulate ticks.
>
>I opened https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2020197
>and was directed here, hopefully I understood the request correctly.
>Thank you.

Queued up, thanks.

-- 
Thanks,
Sasha
