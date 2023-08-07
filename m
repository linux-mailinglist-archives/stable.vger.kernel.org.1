Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C1771867
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 04:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHGCj4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 22:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjHGCjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 22:39:55 -0400
Received: from out-81.mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D55FA
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 19:39:53 -0700 (PDT)
Message-ID: <5d44e45b-cb85-b878-f21d-d0b508c3b696@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691375991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hnInpweKZLBkHKIXgZGAhqJI9/CXpILz8h/AYQFzW0=;
        b=vbTvrcu/gFXyM8bRPaWFXDzALqidtwTte3s8rMZhmclzD9y3biLxbDlMe9x2GD2nQiE6J6
        eitlvgNG0xPjLheVH431n30UgZADuq7DSTLvn4FhIdKUG8zXXx4YyIGbv0ZCsDHnh9gsSk
        msoj1iwQGXSHcqqbFVsL8iBF9Zuo6lA=
Date:   Mon, 7 Aug 2023 10:39:44 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 5.10 0/2] Fix xfs/179 for 5.10 stable
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     amir73il@gmail.com, dchinner@redhat.com, yangx.jy@fujitsu.com,
        linux-xfs@vger.kernel.org, stable@vger.kernel.org
References: <20230803093652.7119-1-guoqing.jiang@linux.dev>
 <20230804154757.GI11352@frogsfrogsfrogs>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230804154757.GI11352@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 8/4/23 23:47, Darrick J. Wong wrote:
> On Thu, Aug 03, 2023 at 05:36:50PM +0800, Guoqing Jiang wrote:
>> Hi,
>>
>> With the two patches applied, xfs/179 can pass in 5.10.188. Otherwise I got
>>
>> [root@localhost xfstests]# ./check xfs/179
>> FSTYP         -- xfs (non-debug)
>> PLATFORM      -- Linux/x86_64 localhost 5.10.188-default #14 SMP Thu Aug 3 15:23:19 CST 2023
>> MKFS_OPTIONS  -- -f /dev/loop1
>> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/scratch
>>
>> xfs/179 1s ... [failed, exit status 1]- output mismatch (see /root/xfstests/results//xfs/179.out.bad)
>>      --- tests/xfs/179.out	2023-07-13 16:12:27.000000000 +0800
>>      +++ /root/xfstests/results//xfs/179.out.bad	2023-08-03 16:55:38.173787911 +0800
>>      @@ -8,3 +8,5 @@
>>       Check scratch fs
>>       Remove reflinked files
>>       Check scratch fs
>>      +xfs_repair fails
>>      +(see /root/xfstests/results//xfs/179.full for details)
>>      ...
>>      (Run 'diff -u /root/xfstests/tests/xfs/179.out /root/xfstests/results//xfs/179.out.bad'  to see the entire diff)
>>
>> HINT: You _MAY_ be missing kernel fix:
>>        b25d1984aa88 xfs: estimate post-merge refcounts correctly
>>
>> Ran: xfs/179
>> Failures: xfs/179
>> Failed 1 of 1 tests
>>
>> Please review if they are approriate for 5.10 stable.
> Seems fine to me, but ... there is no maintainer for 5.10; is your
> employer willing to support this LTS kernel?

Hi Darrick,

Thanks for your review! I think Amir is the maintainer for 5.10 😉. I 
can help
if needed since our kernel is heavily based on 5.10 stable. We also run 
tests
against 5.10 stable, that is why I send fixes patches for it.

Hi Greg,

Could you consider add the two to your list? Thank you!

Regards,
Guoqing
