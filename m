Return-Path: <stable+bounces-41793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A78B693C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 05:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013A5283DE1
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 03:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009C10A1D;
	Tue, 30 Apr 2024 03:52:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B1DDA6
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 03:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714449124; cv=none; b=B5MPi9iL1u41QUnPQbY9IPrqZZLYORdOk3hf+Ze53yk7/wN0yIdB0r0Nq3OgNAncSYOoxH5T1vCIUhU8vJZ3yJWhQ9a0MmyLJoxojJCS+xYcQyGH668JY5a2q/KXJe7nu1iB/9lsXY7Z6vIORX6sc9b2gwn4OziryRR2eGelT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714449124; c=relaxed/simple;
	bh=1RVRx6cvAej+t0Gx5zPiZI6lRFGQp07U8KSyOjbk+TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9xJfRHe/2WJM/zauEcon9EcV19zlvrM6m7a0r4PAWKbeh/ZK0nMQiWB8EdX95cFeZMpMzhkw6GSUryOkIWgrIk1S8qnG7NnlwLBiqrCtvNzrfP7J89AjlBFOvKUgRM6AaIMra2RkXxkD3A/8zhii9xpTn4gB+8IOyoNexJVj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.1.103] (unknown [120.221.12.99])
	by APP-05 (Coremail) with SMTP id zQCowAC3vADZajBm_MtxBw--.37512S2;
	Tue, 30 Apr 2024 11:51:53 +0800 (CST)
Message-ID: <7f976727-3ad8-4071-9a91-4a32a01abd32@iscas.ac.cn>
Date: Tue, 30 Apr 2024 11:51:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "riscv: kdump: fix crashkernel reserving
 problem on RISC-V"
To: Baoquan He <bhe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Chen Jiahao <chenjiahao16@huawei.com>
References: <20240430032403.19562-1-xingmingzheng@iscas.ac.cn>
 <ZjBoBYwdPMyPDGhG@MiWiFi-R3L-srv>
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <ZjBoBYwdPMyPDGhG@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAC3vADZajBm_MtxBw--.37512S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWrAF1rAF1fGrykKry5CFg_yoW8Zw4fpr
	48Can0yFZYkr97GaySyrW7ua4FqasYvry3uwsFy34fXFsFqryrKwn0qF43WryDWr4Fgry0
	vFWq9r1v9r1Fy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyIb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JV
	WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU45EfUUUUU
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiBgwDCmYwL+HHqAABs1

On 4/30/24 11:39, Baoquan He wrote:
> On 04/30/24 at 11:24am, Mingzheng Xing wrote:
>> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which was
>> mistakenly added into v6.6.y and the commit corresponding to the 'Fixes:'
>> tag is invalid. For more information, see link [1].
>>
>> This will result in the loss of Crashkernel data in /proc/iomem, and kdump
>> failed:
>>
>> ```
>> Memory for crashkernel is not reserved
>> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
>> Then try to loading kdump kernel
>> ```
>>
>> After revert, kdump works fine. Tested on QEMU riscv.
>>
>> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Chen Jiahao <chenjiahao16@huawei.com>
>> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> 
> Ack. This is necessary for v6.6.y stable branch.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 

Thanks,

Hi, Greg. This is for the 6.6.y branch only.

>> ---
>>
>> v1 -> v2:
>>
>> - Changed the commit message
>> - Added Cc:
>>
>> v1:
>> https://lore.kernel.org/stable/20240416085647.14376-1-xingmingzheng@iscas.ac.cn
>>
>>  arch/riscv/kernel/setup.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index aac853ae4eb74..e600aab116a40 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -173,6 +173,19 @@ static void __init init_resources(void)
>>  	if (ret < 0)
>>  		goto error;
>>  
>> +#ifdef CONFIG_KEXEC_CORE
>> +	if (crashk_res.start != crashk_res.end) {
>> +		ret = add_resource(&iomem_resource, &crashk_res);
>> +		if (ret < 0)
>> +			goto error;
>> +	}
>> +	if (crashk_low_res.start != crashk_low_res.end) {
>> +		ret = add_resource(&iomem_resource, &crashk_low_res);
>> +		if (ret < 0)
>> +			goto error;
>> +	}
>> +#endif
>> +
>>  #ifdef CONFIG_CRASH_DUMP
>>  	if (elfcorehdr_size > 0) {
>>  		elfcorehdr_res.start = elfcorehdr_addr;
>> -- 
>> 2.34.1
>>


