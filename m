Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A54769661
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjGaMdF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjGaMc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:32:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435E137
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:32:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A35886017F;
        Mon, 31 Jul 2023 14:32:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690806774; bh=oNzU1/WcSQC10wzqukdJqz4sVOzntAuFLdVZG3Qyc7k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T0LZ+MsAOnT/jY+pmH3s6BYYEVEmS7pUD1dxjfen9rZlSgeYRxinBBL0TTrWThbWL
         LUtRKgkJJZROVsuVBSUurTQuCPIV6ubim6A5DIuMDxzYbWqhV1GMlREHB+S6cAN5uu
         eoB27Mj24HswVGMcbb3wq2QW9zHeE5wJMOK+bPdECHqQw8M35izM5XrU2ftcF35NCG
         R3GxK7bGNtgEhZvt7FO5+uJJTaaRM9DSs+3tTWvr+Nj/RS6q154hPOBDnJPA6QHrO0
         QiC/bckvkt8pgXtAXIHZa4LnSL5hlebiksSas+6QaTAuMze0Ty1UFoAbmZvomWd/Qs
         ISfDa0E4uE17A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3bRMmCwHNsUf; Mon, 31 Jul 2023 14:32:52 +0200 (CEST)
Received: from [10.0.2.76] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 2C5B160173;
        Mon, 31 Jul 2023 14:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690806772; bh=oNzU1/WcSQC10wzqukdJqz4sVOzntAuFLdVZG3Qyc7k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KPe0F4CxN6fYy3hAr+pKxM/YvXhBV3hceSA+f7fprA/QLImDZyloTT/Ti2lmDW7aO
         /Vmyjhdae1qcQslBIR5NkUSwUOCKEw53kLLseCRfMs63tKcSIEZ1l5cKBgys8I/wmI
         L6zaWxnFywtki5SFc5BgukOF740Fn30YYvkI7uObGWWyRqQlagwX2hW4FlsJ5R0hs0
         Mo71x1tzFq3ikg+hrj+DNLefPvVtCWatZteR9fWTmYWZQFlaEXarsXpryFOfBTyhs7
         F2NYNaiYDO2tgE1YaSKHgCgnk+wLqYCa4f0SqHyukeGfGOBAM0HAcSMK49uEn6f7SA
         OqY6EEaw3VvgA==
Message-ID: <44ab3617-dbd5-ff8d-0323-28ef9cc322c2@alu.unizg.hr>
Date:   Mon, 31 Jul 2023 14:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v5 1/3] test_firmware: prevent race conditions by a
 correct implementation of locking
Content-Language: en-US, hr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <1a2a428f-71ab-1154-bd50-05c82eb05817@alu.unizg.hr>
 <ZMb3Yf4km8NTeMZj@bombadil.infradead.org>
 <a09b4fa3-d6dc-b7a9-f815-d6f43211910b@alu.unizg.hr>
 <2023073147-sleeve-regular-46cd@gregkh>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023073147-sleeve-regular-46cd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 31.7.2023. 13:33, Greg Kroah-Hartman wrote:
> On Mon, Jul 31, 2023 at 01:29:19PM +0200, Mirsad Todorovac wrote:
>> On 31.7.2023. 1:50, Luis Chamberlain wrote:
>>> On Sat, Jul 29, 2023 at 11:17:45AM +0200, Mirsad Todorovac wrote:
>>>> ---
>>>> v5.1
>>>>    resending to v5.4 stable branch verbatim according to Luis Chamberlain instruction
>>>
>>> If this is a backport of an upstream patch you must mention the commit
>>> ID at the top. After
>>>
>>> For instance, here is a random commit from v5.15.y branch for stable:
>>>
>>> bpf: Add selftests to cover packet access corner cases
>>> commit b560b21f71eb4ef9dfc7c8ec1d0e4d7f9aa54b51 upstream.
>>>
>>> <the upstream commit log>
>>
>> Hello,
>>
>> I have reviewed the module again and I found no new weaknesses, so it is only
>> a backport from the same commit in torvalds, master, 6.4, 6.1, 5.15 and
>> 5.10 trees/branches.
>>
>> This is a bit confusing and I am doing this for the first time. In fact, there
>> was probably a glitch in the patchwork because the comment to the
>> Cc: stable@vger.kernel.org said "# 5.4" ...
>>
>> However, I do not know which commit ID to refer to:
>>
>> torvalds 4acfe3dfde685a5a9eaec5555351918e2d7266a1
>> master   4acfe3dfde685a5a9eaec5555351918e2d7266a1
>> 6.4      4acfe3dfde685a5a9eaec5555351918e2d7266a1
>> 6.1      6111f0add6ffc93612d4abe9fec002319102b1c0
>> 5.15     bfb0b366e8ec23d9a9851898d81c829166b8c17b
>> 5.10     af36f35074b10dda0516cfc63d209accd4ef4d17
>>
>> Each of the branches 6.4, 6.1, 5.15 and 5.10 appear to have a different commit
>> ID.
>>
>> Probably the right commit ID should be:
>>
>> test_firmware: prevent race conditions by a correct implementation of locking
>>
>> commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 master
>>
>> Will the patchwork figure this out or should I RESEND with a clean slate?
>>
>> But first I would appreciate a confirmation that I did it right this time ...
> 
> I don't understand at all what you are trying to do here.
> 
> Is this a patch for Linus's tree?  If so, great, let's apply it there.
> 
> Is this a patch for the stable kernel(s)?  If so, great, what is the git
> id in Linus's tree and what stable kernel(s) should it be applied to?
> 
> That's all we need to know and right now, I have no idea...
> 
> confused,
> 
> greg k-h

Hi, Mr. Greg,

PLEASE NOTE!

I've just checked the diff against the 5.4 stable branch, and simply applying it won't
suffice, because it fails, so I need to manually backport the 5.10 commit to the 5.4 branch.

This is the job for the patch developer, and I would have done it earlier if I was aware
that the patch didn't apply to the 5.4 branch out-of-the-box. Rather naively I assumed
that the patch will apply automagically to 5.4 as it does to 5.10+. As they say, assumption
is the mother of all screwups.

Apologies for the confusion and your lost time.

* * *

The problem is that the patch was meant to be applied to 5.10 onwards, but 5.4 branch omitted it.

The patch is already in the torvalds tree and stable master, 6.4, 6.1, 5.15 and 5.10.

I wanted to see why the 5.4 included only two out of series of three patches for test_firmware:

2023-05-31 48e156023059e57a8fc68b498439832f7600ffff test_firmware: fix the memory leak of the allocated firmware buffer
2023-05-31 be37bed754ed90b2655382f93f9724b3c1aae847 test_firmware: fix a memory leak with reqs buffer
2023-05-31 4acfe3dfde685a5a9eaec5555351918e2d7266a1 test_firmware: prevent race conditions by a correct implementation of locking

So, the last patch didn't propagate to 5.4 stable branch.

Now we know why exactly.

 From the pragmatic point of view, it would suffice to apply the commit

"4acfe3dfde685a5a9eaec5555351918e2d7266a1 test_firmware: prevent race conditions by a correct implementation of locking"

to the 5.4 stable branch.

Kind regards,
Mirsad Todorovac

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

