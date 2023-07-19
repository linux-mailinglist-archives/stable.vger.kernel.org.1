Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2C758ABB
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 03:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGSBQ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 21:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSBQ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 21:16:27 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC0D12F
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 18:16:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R5Hvm098rz4f3khY
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 09:16:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgA30JNlObdk95suOQ--.45464S3;
        Wed, 19 Jul 2023 09:16:22 +0800 (CST)
Subject: Re: Build failures / crashes in stable queue branches
To:     Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com>
 <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
 <2023071625-parsnip-pursuable-b5c8@gregkh>
 <da595585-4929-2c21-7e48-f9f8cdad6cf7@joelfernandes.org>
 <2023071840-hatchling-fiction-65a8@gregkh>
 <CAEXW_YR801_BhsevD0UjbXpt47H82=uX2oqcLoCo9pdW2NYOjw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <af66a503-cc85-5690-0f17-708efafe338f@huaweicloud.com>
Date:   Wed, 19 Jul 2023 09:16:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEXW_YR801_BhsevD0UjbXpt47H82=uX2oqcLoCo9pdW2NYOjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JNlObdk95suOQ--.45464S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48WF1kWFyDur1rAry7Jrb_yoW5Wr1DpF
        W3JanIkF4UJr47twn2vw1YqF1Ut3y5JFW5XwnxJr1rZF4qvry5urn7Xr4j9Fy2yr18Kry0
        qr4UtasxXFyUX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

在 2023/07/19 1:14, Joel Fernandes 写道:
> On Tue, Jul 18, 2023 at 10:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Jul 18, 2023 at 09:52:45AM -0400, Joel Fernandes wrote:
>>> On 7/16/23 10:30, Greg KH wrote:
>>>> On Sun, Jul 16, 2023 at 11:20:33AM +0800, Yu Kuai wrote:
>>>>> Hi,
>>>>>
>>>>> 在 2023/07/15 23:49, Joel Fernandes 写道:
>>>>>> Hi Yu,
>>>>>>
>>>>>> On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
>>>>>> [..]
>>>>>>> ---------
>>>>>>> 6.1.y:
>>>>>>>
>>>>>>> Build reference: v6.1.38-393-gb6386e7314b4
>>>>>>> Compiler version: alpha-linux-gcc (GCC) 11.4.0
>>>>>>> Assembler version: GNU assembler (GNU Binutils) 2.40
>>>>>>>
>>>>>>> Building alpha:allmodconfig ... failed
>>>>>>> Building m68k:allmodconfig ... failed
>>>>>>> --------------
>>>>>>> Error log:
>>>>>>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>>>>>>> In file included from block/genhd.c:28:
>>>>>>> block/genhd.c: In function 'disk_release':
>>>>>>> include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
>>>>>>>       88 | # define blk_trace_remove(q)                            (-ENOTTY)
>>>>>>>          |                                                         ^
>>>>>>> block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
>>>>>>>     1185 |         blk_trace_remove(disk->queue);
>>>>>>
>>>>>> 6.1 stable is broken and gives build warning without:
>>>>>>
>>>>>> cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove() while blktrace is disabled")
>>>>>>
>>>>>> Could you please submit it to stable for 6.1? (I could have done that but it
>>>>>> looks like you already backported related patches so its best for you to do
>>>>>> it, thanks for your help!).
>>>>>
>>>>> Thanks for the notice, however, I'll suggest to revert this patch for
>>>>> now, because there are follow up fixes that is not applied yet.
>>>>
>>>> Which specific patch should be dropped?
>>>>
>>>
>>> Yu: Ping? ;-). Are you suggesting the original set be reverted, or Greg
>>> apply the above fix? Let us please keep 6.1 stable unbroken. ;-)
>>>
>>> Apologies for my noise if the issue has already been resolved.
>>
>> I think it has been resolved, but testing against the latest -rc release
>> I sent out yesterday would be appreciated.
> 
> Great.  Sure, I am going to run it today.

Sorry about the trouble, currently this patch will cause that scsi host
module can't be unloaded, and there are follow up fixes for this:

https://lore.kernel.org/all/20230621160111.1433521-1-yukuai1@huaweicloud.com/
https://lore.kernel.org/all/20230705024001.177585-1-yukuai1@huaweicloud.com/

The second patch is not applied yet, either revert the original patch or
apply the above fix to stable as well.

Thanks,
Kuai
> 
> 
>   - Joel
> .
> 

