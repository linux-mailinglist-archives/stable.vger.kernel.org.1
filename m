Return-Path: <stable+bounces-20487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C53859C64
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 07:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC00281569
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDA220315;
	Mon, 19 Feb 2024 06:53:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DC1CD38
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325599; cv=none; b=PsIjflbhF6hDCclFX4nUEb7A6w7kMj2CSN4BXTlHpPqTL1Wl2cZZbR+I2nDba5WoDlrvn8f2Qwp9HTg5BGWUxqSC8kxOZ5a33QlA70vnOY722d75EJ5+EnkfFs2/VbX5tG151jAP7kExovCLL6V1pfOROod1VodAL4CSCpbKzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325599; c=relaxed/simple;
	bh=K8ZpNXNFqXvSiEd6ygUKFI6adXh7Ii5M+58kgA95ZvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C3Bsul0sBmkgHi/aDeXVGZ5gZbH2Dc8jk2WRwVawQ4hD8zCEmh5teGYIFMzQ3H8+Diq9RIwiHe3n2eOBe2R1oxwbbbmguwOCOyEYtvQnXajcNc4M2XDtRQF1t6epoRL87eFG8y+xiUGqdup/Z5oZ4MBH+NyQGvahr3Z4Q2r0rIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TdY8p0T0cz1X2l8;
	Mon, 19 Feb 2024 14:51:06 +0800 (CST)
Received: from canpemm100005.china.huawei.com (unknown [7.192.105.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 595451A0172;
	Mon, 19 Feb 2024 14:53:13 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 14:53:13 +0800
Received: from [10.67.110.72] (10.67.110.72) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 14:53:12 +0800
Message-ID: <aeb81303-95c5-030b-4541-92dd9506d10d@huawei.com>
Date: Mon, 19 Feb 2024 14:53:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 5.10.y 0/5] Backport call_on_irq_stack to fix scs
 overwritten in irq_stack_entry
To: Ard Biesheuvel <ardb@kernel.org>
CC: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<xiujianfeng@huawei.com>, <liaochang1@huawei.com>
References: <20240218023055.145519-1-xiangyang3@huawei.com>
 <CAMj1kXFbveXgHvk1jEs1Q4kE=Tak08cDYpebwEgKehhwYf9j4A@mail.gmail.com>
From: Xiang Yang <xiangyang3@huawei.com>
In-Reply-To: <CAMj1kXFbveXgHvk1jEs1Q4kE=Tak08cDYpebwEgKehhwYf9j4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)

Thanks, I will send a v2 with the revert patch.

在 2024/2/18 18:06, Ard Biesheuvel 写道:
> On Sun, 18 Feb 2024 at 03:33, Xiang Yang <xiangyang3@huawei.com> wrote:
>>
>> The shadow call stack for irq now stored in current task's thread info
>> may restored incorrectly, so backport call_on_irq_stack from mainline to
>> fix it.
>>
>> Ard Biesheuvel (1):
>>   arm64: Stash shadow stack pointer in the task struct on interrupt
>>
>> Mark Rutland (3):
>>   arm64: entry: move arm64_preempt_schedule_irq to entry-common.c
>>   arm64: entry: add a call_on_irq_stack helper
>>   arm64: entry: convert IRQ+FIQ handlers to C
>>
>> Xiang Yang (1):
>>   Revert "arm64: Stash shadow stack pointer in the task struct on
>>     interrupt"
>>
> 
> Backporting this was a mistake. Not only was the backport flawed, the
> original issue (stashing the shadow call stack pointer onto the normal
> stack) was not even present, at least not to the same extent.
> 
> Stashing the shadow call stack pointer in register X24 works around
> the original issue, except for the case where a hardirq is taken while
> softirqs are being processed. In this case, X24 will be preserved on
> the stack by the hardirq handling logic, and restored after.
> Theoretically, that creates a window where the shadow call stack
> pointer could be corrupted deliberately, but it seems unlikely to me
> that this is exploitable in practice.
> 
> So in the light of this, I think doing only the revert here should be
> sufficient, and there is no need for the other backports in this
> series.
> .

