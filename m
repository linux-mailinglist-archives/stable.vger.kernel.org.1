Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52419754D33
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGPDUp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 15 Jul 2023 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPDUn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 15 Jul 2023 23:20:43 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41816EE
        for <stable@vger.kernel.org>; Sat, 15 Jul 2023 20:20:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R3VpT0vXmz4f3jMw
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 11:20:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK8CYrNkrLpMOA--.65121S3;
        Sun, 16 Jul 2023 11:20:35 +0800 (CST)
Subject: Re: Build failures / crashes in stable queue branches
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <897ebb05-5a1f-e353-8877-49721c52d065@roeck-us.net>
 <20230715154923.GA2193946@google.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <907909df-d64f-e40a-0c9c-fc5c225a235c@huaweicloud.com>
Date:   Sun, 16 Jul 2023 11:20:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230715154923.GA2193946@google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK8CYrNkrLpMOA--.65121S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1UZr4ruw4kAF43GrWxZwb_yoW8GF4kpF
        93J39Ikr1UXr4Iywn7Zr1ftw1jq34rGrWrXwnxGrWruFW2yr13Zrs2qryv9Fy2q3ykKa9F
        g3W5Cas8JFWDXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

ÔÚ 2023/07/15 23:49, Joel Fernandes Ð´µÀ:
> Hi Yu,
> 
> On Fri, Jul 14, 2023 at 03:21:46AM -0700, Guenter Roeck wrote:
> [..]
>> ---------
>> 6.1.y:
>>
>> Build reference: v6.1.38-393-gb6386e7314b4
>> Compiler version: alpha-linux-gcc (GCC) 11.4.0
>> Assembler version: GNU assembler (GNU Binutils) 2.40
>>
>> Building alpha:allmodconfig ... failed
>> Building m68k:allmodconfig ... failed
>> --------------
>> Error log:
>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> In file included from block/genhd.c:28:
>> block/genhd.c: In function 'disk_release':
>> include/linux/blktrace_api.h:88:57: error: statement with no effect [-Werror=unused-value]
>>     88 | # define blk_trace_remove(q)                            (-ENOTTY)
>>        |                                                         ^
>> block/genhd.c:1185:9: note: in expansion of macro 'blk_trace_remove'
>>   1185 |         blk_trace_remove(disk->queue);
> 
> 6.1 stable is broken and gives build warning without:
> 
> cbe7cff4a76b ("blktrace: use inline function for blk_trace_remove() while blktrace is disabled")
> 
> Could you please submit it to stable for 6.1? (I could have done that but it
> looks like you already backported related patches so its best for you to do
> it, thanks for your help!).

Thanks for the notice, however, I'll suggest to revert this patch for
now, because there are follow up fixes that is not applied yet.

Kuai
> 
> thanks,
> 
>   - Joel
> 
> .
> 

