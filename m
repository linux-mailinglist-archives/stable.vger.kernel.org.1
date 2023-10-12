Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1177C74ED
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347410AbjJLRiV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347419AbjJLRiJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:38:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A710E9
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:36:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274C1C433C8;
        Thu, 12 Oct 2023 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697132174;
        bh=7x2NEMvw8tVNqC5DHRWew5RNqKUSmHvoRdZR4wl3lhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wg5P++rlIIO0xA210B+v5eaqg/qszkdA33aIiPWy/j06pA54xUTRe41wbKChJK7Xn
         gUbIaN46ILs2joocLTDenjHYUjieCUvNQZ1fu67kfw4z7Ypv0+LSd28slgKsz2VuHq
         Eecc4SWGJev6+M/wx9V0jG39G7ZZX9cCvPBvyqqE=
Date:   Thu, 12 Oct 2023 19:36:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] ipc: replace costly bailout check in
 sysvipc_find_ipc()
Message-ID: <2023101219-gave-shadily-bed3@gregkh>
References: <aaa0d2cc-832d-4b57-a06d-0d1fa77a4b03@denx.de>
 <20231012011341.111660-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012011341.111660-1-aquini@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11, 2023 at 09:13:41PM -0400, Rafael Aquini wrote:
> commit 20401d1058f3f841f35a594ac2fc1293710e55b9 upstream
> 
> This is CVE-2021-3669
> 
> sysvipc_find_ipc() was left with a costly way to check if the offset
> position fed to it is bigger than the total number of IPC IDs in use.  So
> much so that the time it takes to iterate over /proc/sysvipc/* files grows
> exponentially for a custom benchmark that creates "N" SYSV shm segments
> and then times the read of /proc/sysvipc/shm (milliseconds):
> 
>     12 msecs to read   1024 segs from /proc/sysvipc/shm
>     18 msecs to read   2048 segs from /proc/sysvipc/shm
>     65 msecs to read   4096 segs from /proc/sysvipc/shm
>    325 msecs to read   8192 segs from /proc/sysvipc/shm
>   1303 msecs to read  16384 segs from /proc/sysvipc/shm
>   5182 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> The root problem lies with the loop that computes the total amount of ids
> in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> "ids->in_use".  That is a quite inneficient way to get to the maximum
> index in the id lookup table, specially when that value is already
> provided by struct ipc_ids.max_idx.
> 
> This patch follows up on the optimization introduced via commit
> 15df03c879836 ("sysvipc: make get_maxid O(1) again") and gets rid of the
> aforementioned costly loop replacing it by a simpler checkpoint based on
> ipc_get_maxidx() returned value, which allows for a smooth linear increase
> in time complexity for the same custom benchmark:
> 
>      2 msecs to read   1024 segs from /proc/sysvipc/shm
>      2 msecs to read   2048 segs from /proc/sysvipc/shm
>      4 msecs to read   4096 segs from /proc/sysvipc/shm
>      9 msecs to read   8192 segs from /proc/sysvipc/shm
>     19 msecs to read  16384 segs from /proc/sysvipc/shm
>     39 msecs to read  32768 segs from /proc/sysvipc/shm
> 
> Link: https://lkml.kernel.org/r/20210809203554.1562989-1-aquini@redhat.com
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
> Acked-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: Waiman Long <llong@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Marek, you did not sign off on this patch, why not?

And how did you test this?  Are you sure it's really needed?  Is that
cve actually valid and something that you have had problems with in the
real world?

thanks,

greg k-h
