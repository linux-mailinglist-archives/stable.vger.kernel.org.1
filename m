Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC076FEA6
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHDKm7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHDKmy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341B46B2
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8150161F71
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A68C433C8;
        Fri,  4 Aug 2023 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691145772;
        bh=M3GwSTsf1pXl/olcYLRzMx/u2C5eqkwW/T641rvxhKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvmoW9pSZ4JrDg0o7jfI/aS32e65Xo6cZY7PLCiyT1nVVBIdLuDLDcaE7Vqq+YB1V
         HiASngX4KBTT3wtMm2Q639LQu9yL8RJ7DK8awgyO0rndgm8UTKy6wE4MIRv/6mXvg1
         zzXF8ntFR51ILHP2B/+PUZ21kd2SV4h9cT9/GY8U=
Date:   Fri, 4 Aug 2023 12:42:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cixi.geng@linux.dev
Cc:     peterz@infradead.org, stable@vger.kernel.org, enlin.mu@unisoc.com
Subject: Re: [PATCH] perf: Fix function pointer case
Message-ID: <2023080443-lance-bolt-0e7b@gregkh>
References: <2023080214-unneeded-wireless-3508@gregkh>
 <20230802114053.3613-1-cixi.geng@linux.dev>
 <840c9ebf1d741de735b3a1d882364ff0f3904bdd@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <840c9ebf1d741de735b3a1d882364ff0f3904bdd@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 03, 2023 at 01:28:32AM +0000, cixi.geng@linux.dev wrote:
> 2023年8月2日 19:47, "Greg KH" <gregkh@linuxfoundation.org> 写到:
> 
> 
> > 
> > On Wed, Aug 02, 2023 at 07:40:53PM +0800, Cixi Geng wrote:
> > 
> > > 
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >  
> > >  commit 1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574 upstream.
> > >  With the advent of CFI it is no longer acceptible to cast function
> > >  pointers.
> > >  
> > >  The robot complains thusly:
> > >  
> > >  kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type
> > >  
> > >  Reported-by: kernel test robot <lkp@intel.com>
> > >  Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >  Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > >  ---
> > >  kernel/events/core.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > 
> > What stable tree(s) is this for?
> >
> Hi Greg
> I want to apply this patch for linux-5.15-y and linux-6.1-y, 
> the other stable trees not requred for me, thanks!

Now queued up, thanks.

greg k-h
