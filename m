Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97276FA53A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjEHKHL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjEHKHK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:07:10 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C9D1735
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:09 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 348A77kK048641;
        Mon, 8 May 2023 19:07:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Mon, 08 May 2023 19:07:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 348A71m2048614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 May 2023 19:07:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c9738f09-b2a2-a8a0-ebee-ba4a3563f475@I-love.SAKURA.ne.jp>
Date:   Mon, 8 May 2023 19:06:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4.14.y] mm/page_alloc: fix potential deadlock on
 zonelist_update_seq seqlock
To:     Greg KH <greg@kroah.com>, Petr Mladek <pmladek@suse.com>
Cc:     stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <2023042455-skinless-muzzle-1c50@gregkh>
 <20230507145629.4250-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <2023050828-asleep-semicolon-240e@gregkh>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2023050828-asleep-semicolon-240e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023/05/08 15:56, Greg KH wrote:
> On Sun, May 07, 2023 at 11:56:29PM +0900, Tetsuo Handa wrote:
>> commit 1007843a91909a4995ee78a538f62d8665705b66 upstream.
> 
> For obvious reasons, we can't just apply this to 4.14.y.  Please provide
> fixes for all other stable trees as well so that you do not have a
> regression when updating to a newer kernel.
> 
> I'll drop this from my review queue for now and wait for all of the
> backported versions.

5.15+ stable kernels already have the upstream patch applied.

Only 4.14/4.19/5.4/5.10 stable kernels failed to apply the upstream patch
due to the need to append include/linux/printk.h part. I want to hear
whether Petr Mladek is happy with this partial printk.h backport
( https://lkml.kernel.org/r/ZC0298t3o6+TyASH@alley ) before I spam
everyone with the same change for 4.19/5.4/5.10.

