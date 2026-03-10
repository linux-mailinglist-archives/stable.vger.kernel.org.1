Return-Path: <stable+bounces-223748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIVxJoqPr2kragIAu9opvQ
	(envelope-from <stable+bounces-223748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:27:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A53244CB0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A85DC3029277
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD7385501;
	Tue, 10 Mar 2026 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JMGQzxtp"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E33B95EB;
	Tue, 10 Mar 2026 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113224; cv=none; b=FTrmk9adOFFAEHVgNnJgVcf52IIe7/XjLAKLQcGiLLwrcbMgBOB3RhGrRCuKb+83Xsgj0lOZyWmGsHCbSCVjy97YqevLB8RXsDnKHSEkdkpb5829l2ruatRdy+5xw5zB5FzvtvEtrKDqY98vrpuzQ+lTuGJBWP0/ITqZoXdKlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113224; c=relaxed/simple;
	bh=yW90WBE5vHlQ0ILflkKA0EzAkVqqkahdkxfWXAVXiOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gUWyioLxx9qpmzGoGP96zv0nYXC2HpJE8g14MkByYhV4rYL/V8Jh8cH3fnKMO+LOyYHdDPNXU0bAGaaT97L0fsqBRFjaXaKba9rBHN55/R3a5AD1mC56WCdalGSgd0xBF7yw1wDacrZRSAIdhCLXSJC17Q9XFISmbwKk2+TPyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JMGQzxtp; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NKl0BL5gWneRy8oIc5rSW3swGX1sxqPqZIAu8m6vIHM=;
	b=JMGQzxtpI9ePIXzWXzTcLVJ8WSm8gzVHohQ7nVAsmJYNnlqGlbBNIzIP4if/tct67FLFXmq4s
	7x9HWkKBcIo0SxFLA/Kofp5K/NDpWOmjJkrafmsqF0f2aOvcS9D5PymjzeE2Ri247hLkh8UJfuJ
	OfjvEF+n7jcvjLsUPd+3rzc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fVK0g6k9nz12LCw;
	Tue, 10 Mar 2026 11:21:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CB1B404AD;
	Tue, 10 Mar 2026 11:27:00 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 11:26:59 +0800
Message-ID: <3e5d9fd9-af73-4f58-88ac-0c5c75bec14c@huawei.com>
Date: Tue, 10 Mar 2026 11:26:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix get cpu steer-tag fail on ARM64 platform
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<wei.huang2@amd.com>, <Eric.VanTassell@amd.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>,
	<linux-riscv@lists.infradead.org>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260309041659.18815-1-fengchengwen@huawei.com>
 <20260309102835.000037ad@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260309102835.000037ad@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 56A53244CB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-223748-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/2026 6:28 PM, Jonathan Cameron wrote:
> On Mon, 9 Mar 2026 12:16:56 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> This patchset addresses the issue where retrieving the CPU steer-tag
>> fails on ARM64 platforms. The first commit is a pure renaming of the
>> ACPI CPU ID retrieval interface (no functional changes), which serves
>> as preparation for the second commit that implements the core fix for
>> the steer-tag retrieval logic.
> 
> Hi,
> 
> For future reference, please keep same lists +CC on every patch
> (for a small series, send everything to everyone who gets any patch).
> For me at least, that led to my filter putting patch 1 in a totally different
> place from the rest and some confusion.
> 
> Also, don't send in reply to a previous version. Just start a new email
> thread.  That both avoids deep nesting in email clients and generally
> ensures your series ends up in the right place if people are sorting
> by time of sending.

Thanks Jonathan for the reminder, v5 has been sent with all of your comments.

Thanks again

> 
> No need to resend this time unless others ask for it. 
> 
> Thanks,
> 
> Jonathan
> 
>>
>> ---
>> Changes in v4:
>> - Split the rename into a separate commit.
>>
>> Changes in v3:
>> - Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
>>   than add one new API.
>>
>> Changes in v2:
>> - Add ECN _DSM reference doc name and its URL.
>> - Separate implement acpi_get_cpu_acpi_id() in each arch which supports
>>   ACPI.
>> - Refine commit-log.
>>
>> Chengwen Feng (2):
>>   ACPI: Rename get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() on
>>     non-x86
>>   PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
>>
>>  Documentation/PCI/tph.rst          |  4 ++--
>>  arch/arm64/include/asm/acpi.h      |  4 ++--
>>  arch/loongarch/include/asm/acpi.h  |  2 +-
>>  arch/riscv/include/asm/acpi.h      |  2 +-
>>  arch/riscv/kernel/acpi_numa.c      |  2 +-
>>  arch/x86/include/asm/acpi.h        |  2 ++
>>  arch/x86/kernel/cpu/common.c       |  8 ++++++++
>>  drivers/acpi/pptt.c                | 16 ++++++++--------
>>  drivers/acpi/riscv/rhct.c          |  2 +-
>>  drivers/pci/tph.c                  | 11 ++++++-----
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
>>  include/linux/pci-tph.h            |  4 ++--
>>  12 files changed, 35 insertions(+), 24 deletions(-)
>>
> 


