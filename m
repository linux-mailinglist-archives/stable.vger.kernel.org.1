Return-Path: <stable+bounces-225233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKSFMdx2s2mwWgAAu9opvQ
	(envelope-from <stable+bounces-225233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:30:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6689C27CC22
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C271330FA891
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBBD34107D;
	Fri, 13 Mar 2026 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2MIeAfhQ"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE963093B5;
	Fri, 13 Mar 2026 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369025; cv=none; b=XIJrnO7bR2GbP3umsRt3jfkdhvZcC4mq6mkUyRUcbi3o7T0gR89xifGgdD4CiMIjVxQAKvQwu8pVA+dt6WUp28KIkfS4rl/+noK9x1CwOw6DbJKDBkLhiIoVmSDFe0lanqOI3FffgC1z/V6jxmKQ1m8gRUUj24H3Xpa5fvKRlg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369025; c=relaxed/simple;
	bh=W/foNPav97/R1NSG+CGx/D58xEyvpkNi6medIrP+C6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tbrPB7aYjqvVIBGgSIiLHAGL3Moezh2hbGjsLMDp8mm3Ct8Q0+yipsJ14RpaHFAPM/Pu91SHjjLF/hBdge8Gx0M1FHGUOXOQWB8Q9SSyUAvUj2nq5bQtn8r/rRT7J/FOkekSXXtN4eCRMUBTGVtBiPyEoId9/ZmZ+2jP5FFFHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2MIeAfhQ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CVkB4K6yegSE+n79ThisbSxU7cMPDcr1n6IOBQnBrIM=;
	b=2MIeAfhQxyTndrqGx6t5o31MFsRiG77XtXY34XUO7DkiajhwGBA/mw3XKKYJw98GhroY7x9oR
	ZDuUg+PHLgfHz6ntw9twsM8tzX3A2VuZkh9UNQOhbLPswsT/Z5MluwK4Fi4c98OhfzTrgVYMsZA
	OvT6o9I1lcIszGmULdjTf3M=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fX7bw5Z58znTwX;
	Fri, 13 Mar 2026 10:24:44 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 847034048B;
	Fri, 13 Mar 2026 10:30:19 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 10:30:17 +0800
Message-ID: <699a428a-6271-4369-83f4-8b1f2e1bfa42@huawei.com>
Date: Fri, 13 Mar 2026 10:30:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_uid() on non-x86
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
	<kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, Sunil V L
	<sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Kees Cook
	<kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Sean Christopherson
	<seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Thomas Huth <thuth@redhat.com>, Thorsten Blum
	<thorsten.blum@linux.dev>, Kevin Loughlin <kevinloughlin@google.com>, Zheyun
 Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>, "Ahmed S .
 Darwish" <darwi@linutronix.de>, Sohil Mehta <sohil.mehta@intel.com>, Ilkka
 Koskinen <ilkka@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>,
	James Clark <james.clark@linaro.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
	<wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <punit.agrawal@oss.qualcomm.com>,
	<guohanjun@huawei.com>, <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
	<chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
	<wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
	<heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260312072316.4806-1-fengchengwen@huawei.com>
 <20260312072316.4806-2-fengchengwen@huawei.com>
 <20260312110742.00002716@huawei.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260312110742.00002716@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225233-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[69];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6689C27CC22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/2026 7:07 PM, Jonathan Cameron wrote:
> On Thu, 12 Mar 2026 15:23:14 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> To unify the CPU ACPI ID retrieval interface across architectures,
>> rename the existing get_acpi_id_for_cpu() function to
>> acpi_get_cpu_uid() on arm64/riscv/loongarch platforms.
>>
>> This is a pure rename with no functional change, preparing for a
> 
> It's not just a rename.  This should mention that the addition of error
> checks and hence the resulting signature change.

Sorry for overlooking this, it has already been fixed in v7.
And v7 also fix below review comments.

Thanks

> 
>> consistent ACPI Processor UID retrieval interface across all ACPI-enabled
>> platforms.
>>
>> Note: Move the ARM64-specific get_cpu_for_acpi_id() implementation to
>>       arch/arm64/kernel/acpi_numa.c to fix compilation errors from
>>       circular header dependencies introduced by the rename.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> From a reread, a few minor style consistency things inline.
> 

...

> 


