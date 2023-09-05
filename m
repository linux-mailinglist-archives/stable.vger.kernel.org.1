Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578C07924BE
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjIEP7h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353742AbjIEHtj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 03:49:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40288CCF
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 00:49:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RfyMG4WNDz4f3m6r
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 15:49:30 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KaF3fZk61SmCQ--.12953S3;
        Tue, 05 Sep 2023 15:49:29 +0800 (CST)
Message-ID: <b1f154a9-0f05-f82d-d6ec-cb56ac2ca5ea@huaweicloud.com>
Date:   Tue, 5 Sep 2023 15:49:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5.10 1/1] udf: Handle error when adding extent to a file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Nan <linan666@huaweicloud.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, stable@vger.kernel.org,
        Jan Kara <jack@suse.com>, lvc-project@linuxtesting.org,
        Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>
References: <20230815113453.2213555-1-VEfanov@ispras.ru>
 <4c28f962-0830-1138-7b91-ef6685a56afa@huaweicloud.com>
 <2023090520-dwelled-dullness-c3c5@gregkh>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <2023090520-dwelled-dullness-c3c5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KaF3fZk61SmCQ--.12953S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYq7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
        6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
        kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
        Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvE
        ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I
        8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0E
        jII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


在 2023/9/5 15:14, Greg Kroah-Hartman 写道:
> On Tue, Sep 05, 2023 at 02:57:48PM +0800, Li Nan wrote:
>> Hi Greg,
>>
>> Our syzbot found the this issue on v5.10, could you please pick it up
>> for v5.10?
> 
> What issue?  Pick what up?
> 
> There's no context here :(
> .

I am so sorry I forgot to attach the patch. The patch is:
https://lore.kernel.org/all/20230815113453.2213555-1-VEfanov@ispras.ru/

It fix the bug:
https://patchew.org/linux/20230120091028.1591622-1-VEfanov@ispras.ru/

-- 
Thanks,
Nan

