Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5496979C884
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjILHsM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjILHsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 03:48:12 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E0E79
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 00:48:08 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 43D9561E5FE01;
        Tue, 12 Sep 2023 09:47:41 +0200 (CEST)
From:   Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20230619102141.541044823@linuxfoundation.org>
 <20230619102143.987013167@linuxfoundation.org>
 <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
 <2023091117-unripe-ceremony-c29a@gregkh>
Message-ID: <1be4b005-edfe-5faa-4907-f1e9738cc43a@molgen.mpg.de>
Date:   Tue, 12 Sep 2023 09:47:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <2023091117-unripe-ceremony-c29a@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 9/11/23 15:54, Greg Kroah-Hartman wrote:
> On Mon, Sep 11, 2023 at 03:47:01PM +0200, Donald Buczek wrote:
>> On 6/19/23 12:30 PM, Greg Kroah-Hartman wrote:
>>> From: Stephen Hemminger <stephen@networkplumber.org>
>>>
>>> commit 1202cdd665315c525b5237e96e0bedc76d7e754f upstream.
>>>
>>> DECnet is an obsolete network protocol that receives more attention
>>> from kernel janitors than users. It belongs in computer protocol
>>> history museum not in Linux kernel.
>> [...]
>>
>> May I ask, how and why this patch made it into the stable kernels?
>>
>> Did this patch "fix a real bug that bothers people?"
> 
> Yes.

That's a rather short answer.

I can see there might be good reasons, for example some required global/api/coccinelle/tooling change and nobody sees the need and has the time to resolve conflicts in dead code. But that's just guessing. A pointer to or a few words about the need for this specific change might have helped me to understand this example better.

>> No, we don't use DECNET since 25 years or so. But still any change of kconfig patterns bothers us.
> 
> We have never guaranteed that Kconfig options will never change in
> stable kernel releases, sorry.

I didn't want to imply that and I don't expect it.

It's just _if_ stable really gradually opens up to anything (like code removals, backports of new features, heuristically or AI selected patches, performance patches) it IMO loses its function and we could as well follow mainline, which, I think, is what you are recommending anyway.

We've had bad surprises with more or less every mainline releases while updates in a stable series could be trusted to go 99% without thinking. Keeping productions systems on some latest stable gave us the time to identifying and fix problems with newer series before making it the designated series for all systems. This worked well.

If the policy of stable gradually changes, that's tough luck for us. I wouldn't complain but it would be good to know. And maybe Documentation/process/stable-kernel-rules.rs should be reviewed.

If, on the other hand, my impression is just plain wrong or the changes are exceptional because of current challenges like the cpu hardware related problems and the indent is to stick to the strict policy, it would be good to know, too.

Best

  Donald

> This happens all the time with things
> being removed, and fixes happening to add new ones for various reasons
> as you have seen.
> 
>> We automatically build each released kernel and our config evolves automatically following a `cp config-mpi .config && make olddefconfig && make savedefconfig && cp defconfig config-mpi && git commit -m"Update for new kernel version" config-mpi` pattern.
> 
> You might want to manually check this as well, because as you have seen,
> sometimes things are added that you need to keep things working properly
> (like the spectre/meltdown-like fixes.)
> 
> thanks,
> 
> greg k-h

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
