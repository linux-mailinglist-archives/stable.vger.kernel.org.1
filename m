Return-Path: <stable+bounces-67466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E1950303
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B411F22830
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C019CCE6;
	Tue, 13 Aug 2024 10:53:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B219AD6A;
	Tue, 13 Aug 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546387; cv=none; b=qO+onkX93I2DLXrE79OgD0PwWK2TFXsCfKRMi+3jmnAmil/QzH4YV2iGicqwCcx/ahIzTK808Hhww/gi3g/V6+CdoLoTcc5xhgO0xLmwZNsqULbl/uUxg/MlyauB/l9o3QJFeWUOckRnNZjTnwUTon6HzlAXiu8K7p37PiM4erQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546387; c=relaxed/simple;
	bh=T6g62YpEekCI1rH9Nwkq3kpgd4jTgMz2DiZupGh+tNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P6gsjtgsx0kf35zCR71TuXH9AMpYahKqlO8fXF3DINQr5uZ96+LVs1d8rzNXJiM3RLLA8DsjcfCMevVSaLRmrvwR4XMCRIOXB4rJqwJK6O/eKtUyllBD3qmsRUXWIYXfIvxdTHC6J31eBda8qPZEUJi7kADvGzhPofNY62FfLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wjp5M6jz1z20l3s;
	Tue, 13 Aug 2024 18:48:23 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C49DE1401E9;
	Tue, 13 Aug 2024 18:52:56 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 18:52:56 +0800
Message-ID: <71736d6d-a218-185b-4dab-e8c0cd1e8a9d@huawei.com>
Date: Tue, 13 Aug 2024 18:52:55 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5.10 v2] powerpc: Avoid nmi_enter/nmi_exit in real mode
 interrupt.
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
	<mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
	<christophe.leroy@csgroup.eu>, <mahesh@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20240806071616.1671691-1-ruanjinjie@huawei.com>
 <2024081318-onion-record-fdc7@gregkh>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2024081318-onion-record-fdc7@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/13 18:47, Greg KH wrote:
> On Tue, Aug 06, 2024 at 07:16:16AM +0000, Jinjie Ruan wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>>
>> [ Upstream commit 0db880fc865ffb522141ced4bfa66c12ab1fbb70 ]
>>
>> nmi_enter()/nmi_exit() touches per cpu variables which can lead to kernel
>> crash when invoked during real mode interrupt handling (e.g. early HMI/MCE
>> interrupt handler) if percpu allocation comes from vmalloc area.
>>
>> Early HMI/MCE handlers are called through DEFINE_INTERRUPT_HANDLER_NMI()
>> wrapper which invokes nmi_enter/nmi_exit calls. We don't see any issue when
>> percpu allocation is from the embedded first chunk. However with
>> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there are chances where percpu
>> allocation can come from the vmalloc area.
>>
>> With kernel command line "percpu_alloc=page" we can force percpu allocation
>> to come from vmalloc area and can see kernel crash in machine_check_early:
>>
>> [    1.215714] NIP [c000000000e49eb4] rcu_nmi_enter+0x24/0x110
>> [    1.215717] LR [c0000000000461a0] machine_check_early+0xf0/0x2c0
>> [    1.215719] --- interrupt: 200
>> [    1.215720] [c000000fffd73180] [0000000000000000] 0x0 (unreliable)
>> [    1.215722] [c000000fffd731b0] [0000000000000000] 0x0
>> [    1.215724] [c000000fffd73210] [c000000000008364] machine_check_early_common+0x134/0x1f8
>>
>> Fix this by avoiding use of nmi_enter()/nmi_exit() in real mode if percpu
>> first chunk is not embedded.
>>
>> CVE-2024-42126
>> Cc: stable@vger.kernel.org#5.10.x
>> Cc: gregkh@linuxfoundation.org
>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Tested-by: Shirisha Ganta <shirisha@linux.ibm.com>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> Link: https://msgid.link/20240410043006.81577-1-mahesh@linux.ibm.com
>> [ Conflicts in arch/powerpc/include/asm/interrupt.h
>>   because machine_check_early() and machine_check_exception()
>>   has been refactored. ]
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v2:
>> - Also fix for CONFIG_PPC_BOOK3S_64 not enabled.
>> - Add Upstream.
>> - Cc stable@vger.kernel.org.
> 
> You forgot a 5.15.y version, which is of course required if we were to
> take a 5.10.y version :(
> 
> Please resubmit both.

Sorry for forgetting the 5.15.y, I'll resend it sooner, thank you!

> 
> thanks,
> 
> greg k-h

