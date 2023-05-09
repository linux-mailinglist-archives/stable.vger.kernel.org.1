Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FA6FC227
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjEII4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjEIIz6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 04:55:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4E13D
        for <stable@vger.kernel.org>; Tue,  9 May 2023 01:55:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 755AD21A87;
        Tue,  9 May 2023 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683622555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6hikBIfTZSyz+xqTqQ4pac2h8RGp+iR8bvm7Wdsgzzg=;
        b=AulmF9wofXRvCqTRQdSTAVYYqo1f8+2MCv3Pld+V+hJRfmIsSNdEIVuRI1hVbiyl9/lWxB
        608LV7J+TE6D9OVf8JOdSp37Ktn0LHkXXtbhqGwidB1K4nlljwnEesAA978LylLxvT9Mn/
        KboySJDYsgRO1XW7waCqpAxmgzPAm9M=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B322E2C141;
        Tue,  9 May 2023 08:55:52 +0000 (UTC)
Date:   Tue, 9 May 2023 10:55:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <greg@kroah.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4.14.y] mm/page_alloc: fix potential deadlock on
 zonelist_update_seq seqlock
Message-ID: <ZFoKlZARGm1GPPLK@alley>
References: <2023042455-skinless-muzzle-1c50@gregkh>
 <20230507145629.4250-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <2023050828-asleep-semicolon-240e@gregkh>
 <c9738f09-b2a2-a8a0-ebee-ba4a3563f475@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9738f09-b2a2-a8a0-ebee-ba4a3563f475@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon 2023-05-08 19:06:59, Tetsuo Handa wrote:
> On 2023/05/08 15:56, Greg KH wrote:
> > On Sun, May 07, 2023 at 11:56:29PM +0900, Tetsuo Handa wrote:
> >> commit 1007843a91909a4995ee78a538f62d8665705b66 upstream.
> > 
> > For obvious reasons, we can't just apply this to 4.14.y.  Please provide
> > fixes for all other stable trees as well so that you do not have a
> > regression when updating to a newer kernel.
> > 
> > I'll drop this from my review queue for now and wait for all of the
> > backported versions.
> 
> 5.15+ stable kernels already have the upstream patch applied.
> 
> Only 4.14/4.19/5.4/5.10 stable kernels failed to apply the upstream patch
> due to the need to append include/linux/printk.h part. I want to hear
> whether Petr Mladek is happy with this partial printk.h backport
> ( https://lkml.kernel.org/r/ZC0298t3o6+TyASH@alley ) before I spam
> everyone with the same change for 4.19/5.4/5.10.

The partial backport of the printk_deferred_enter/exit definitions
looks fine to me.

I am just not sure what is the preferred way of adding this to
stable trees.

Tetsuo merged the partial backport with the mm fix.
Alternative solution would be to add the partial backport
as a separate patch. Anyway, the commit message should mention
the original commit 85e3e7fbbb720b9897f ("printk: remove
NMI tracking").

Best Regards,
Petr
