Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762407694D9
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjGaL34 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 07:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGaL3m (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 07:29:42 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722BC3
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 04:29:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B9BAB6017F;
        Mon, 31 Jul 2023 13:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690802962; bh=V7qZ/lGDTE84zbXU5Mv16xwNjX6SJA5QwSTBbz5XfM4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hPe71ff0p13YHZWl9O8FC+xu3GcIA0e1yBvQESq1cARPyy758fWG498YQp4ciz7g1
         ZELX87Mf+99snXvLOGk79reovM2+fOBYsA0PqsyjhU75xjEomDiBRmBBcIk5uve7S3
         aJ04X4pVv5b44lGpI7Bkcz4IeVO3JCkD+Fc1rtoqtW7W4RGWs+x0FA7GqTDCnbplBt
         4VkVGpU7Jpkik3m6CdwA7JDcwmK5pEw1xPrNQBcqX0ITHnpxwP4JZDxgGKgAR3Xw7O
         LSLi6h8WxY12wXPIUdztElwvDEu4VJwXZmX9jcA+86PHyD+XRGq9jJzefA171oc/+V
         tDa2sVXyWl1Vw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L3QfFNpjtPKd; Mon, 31 Jul 2023 13:29:20 +0200 (CEST)
Received: from [10.0.2.76] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 5F44660173;
        Mon, 31 Jul 2023 13:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690802960; bh=V7qZ/lGDTE84zbXU5Mv16xwNjX6SJA5QwSTBbz5XfM4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dZ8rF+KC6G/6j6R4ZO5mtGmjMCMxNfcb3Apua/KYg95JNaBTh+5mATrIlVsZR8unI
         NUMslbvxrnmCgN1W8DL9/9E9vux/u+Rs1DrshDF4IbpQVU3JFcnhS3PGSU4bVnIktW
         a4Fj8Aqa5NTx8itu6E7b33VS/FMweGbS1pzCMrxZ4EopbAOpH1i06edQgpdovk3K/b
         4VAag2Gv6tnqOqW3HzX2YND69q00mxj+3Z9A8NKdlyg8cUjfq6g2kC+yv66khLG4ZG
         TVj2oRLJUAqfiQFIgCJDpdGYZ42ZWgvYW7T5fQ/0aHe0Lrl1Op1gRdDyeonHy5XWxL
         TrWx694XfWZBA==
Message-ID: <a09b4fa3-d6dc-b7a9-f815-d6f43211910b@alu.unizg.hr>
Date:   Mon, 31 Jul 2023 13:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v5 1/3] test_firmware: prevent race conditions by a
 correct implementation of locking
Content-Language: en-US, hr
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>
References: <1a2a428f-71ab-1154-bd50-05c82eb05817@alu.unizg.hr>
 <ZMb3Yf4km8NTeMZj@bombadil.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMb3Yf4km8NTeMZj@bombadil.infradead.org>
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

On 31.7.2023. 1:50, Luis Chamberlain wrote:
> On Sat, Jul 29, 2023 at 11:17:45AM +0200, Mirsad Todorovac wrote:
>> ---
>> v5.1
>>   resending to v5.4 stable branch verbatim according to Luis Chamberlain instruction
> 
> If this is a backport of an upstream patch you must mention the commit
> ID at the top. After
> 
> For instance, here is a random commit from v5.15.y branch for stable:
> 
> bpf: Add selftests to cover packet access corner cases
>          
> commit b560b21f71eb4ef9dfc7c8ec1d0e4d7f9aa54b51 upstream.
> 
> <the upstream commit log>

Hello,

I have reviewed the module again and I found no new weaknesses, so it is only
a backport from the same commit in torvalds, master, 6.4, 6.1, 5.15 and
5.10 trees/branches.

This is a bit confusing and I am doing this for the first time. In fact, there
was probably a glitch in the patchwork because the comment to the
Cc: stable@vger.kernel.org said "# 5.4" ...

However, I do not know which commit ID to refer to:

torvalds 4acfe3dfde685a5a9eaec5555351918e2d7266a1
master   4acfe3dfde685a5a9eaec5555351918e2d7266a1
6.4      4acfe3dfde685a5a9eaec5555351918e2d7266a1
6.1      6111f0add6ffc93612d4abe9fec002319102b1c0
5.15     bfb0b366e8ec23d9a9851898d81c829166b8c17b
5.10     af36f35074b10dda0516cfc63d209accd4ef4d17

Each of the branches 6.4, 6.1, 5.15 and 5.10 appear to have a different commit
ID.

Probably the right commit ID should be:

test_firmware: prevent race conditions by a correct implementation of locking

commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 master

Will the patchwork figure this out or should I RESEND with a clean slate?

But first I would appreciate a confirmation that I did it right this time ...

Thanks,
Mirsad

> If you make modifications to the patch to apply to v5.4.y which
> otherwise would let the patch apply you need to specify that in
> the commit log, you could do that after your signed-off-by, for
> instance you can:
> 
> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> [made some x, y and z changes to ensure it applies to v5.4.y]
> 
> If this is a new commit for a fix not yet merged on Linus tree
> then your description quoted above does not make it clear.
> 
>    Luis

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

