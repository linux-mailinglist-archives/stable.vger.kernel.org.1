Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341CB76CBFE
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 13:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjHBLrf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjHBLrc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 07:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF52D52
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 04:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1537361938
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 11:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0CC433C8;
        Wed,  2 Aug 2023 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690976848;
        bh=K9r/3d3ME9GyCdmN337VcoYWUOmD8gOB0i1XuyaSSpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOlQb0ic8rWar+Prh+p3gMXN3yF+QODgqtGUiQNP39TCBCalNnQD7XCI6gJQs6WaZ
         SD4t0sP4atje5i7r0If2TKlCfqsTzS1t4v0kURT5vj7pCK353iyJitSEMpfUT2RTnx
         bPpCEMCl1Hsj9WYqeFM+7eicvc8/JMTOavhiFraU=
Date:   Wed, 2 Aug 2023 13:47:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cixi Geng <cixi.geng@linux.dev>
Cc:     peterz@infradead.org, stable@vger.kernel.org, enlin.mu@unisoc.com
Subject: Re: [PATCH] perf: Fix function pointer case
Message-ID: <2023080214-unneeded-wireless-3508@gregkh>
References: <20230802114053.3613-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802114053.3613-1-cixi.geng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 02, 2023 at 07:40:53PM +0800, Cixi Geng wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> commit 1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574 upstream.
> With the advent of CFI it is no longer acceptible to cast function
> pointers.
> 
> The robot complains thusly:
> 
>   kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  kernel/events/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

What stable tree(s) is this for?

