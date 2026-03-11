Return-Path: <stable+bounces-224637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHwnHWjasGmHnwIAu9opvQ
	(envelope-from <stable+bounces-224637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:58:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F825B333
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF6C30B2644
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50550347538;
	Wed, 11 Mar 2026 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OIFuDbC2";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OIFuDbC2"
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC63290BA;
	Wed, 11 Mar 2026 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197893; cv=none; b=nuZGmSUd6C1iCmwcaebMDENzlg39ch7OBkSd/Z3NZCl0MAq9Dqt1a0xAH08kslniDL6gti92s/4KNm9iyF+ozU8dvkWmGVIqTHOZYW3ZTRvLNfFsKEnIuPSlOAtYApgaeAsLgtsuvAgBDuvpGGSOdK0jiq0BB06dy7n7wN2kzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197893; c=relaxed/simple;
	bh=NjpOQrpdsn8Fx7BCpaR7E9HghxFuVi8WOv3Lb3TklfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Syp8lU6y6zC05Dbh2czqI906zui4Z4av7qwlXz0nptGkfaCuc5pDk1Lid2BcgHAOk8ilRUcwQhpU6NXOj5TuIGgxZ094bJesO9zkn+FfsefTaNMFGacXu/xHpjG+Y2DafgU22MaYxrTxGcglz3qpoNn6lerNzA3myy1ToCgYt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OIFuDbC2; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OIFuDbC2; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b36C7PXQWMtROHC3akP80A02jao7I70/cN0HO+5yrzc=;
	b=OIFuDbC2xS7Rgm+I36JhjfBBuNlrExfOc4b/6nZu5Eci5l3+fQS/kU6c0nfyQEGA12kX/Y7Hm
	Q4fnrBYIxytCYBOb9gfPVNmdxJt8Tvf2GHBr2Fdo4Eecx+kEiQ1JtKfbeg5YZs6XhpMHGRf3AdS
	dsh0tpvrdex5MaKPf2KuYUQ=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fVwQT2ZJ0z1BFwD;
	Wed, 11 Mar 2026 10:57:21 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b36C7PXQWMtROHC3akP80A02jao7I70/cN0HO+5yrzc=;
	b=OIFuDbC2xS7Rgm+I36JhjfBBuNlrExfOc4b/6nZu5Eci5l3+fQS/kU6c0nfyQEGA12kX/Y7Hm
	Q4fnrBYIxytCYBOb9gfPVNmdxJt8Tvf2GHBr2Fdo4Eecx+kEiQ1JtKfbeg5YZs6XhpMHGRf3AdS
	dsh0tpvrdex5MaKPf2KuYUQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fVwJc46ySz12LFG;
	Wed, 11 Mar 2026 10:52:16 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B67A2012A;
	Wed, 11 Mar 2026 10:57:52 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 10:57:50 +0800
Message-ID: <f2bf1055-ae5f-44bb-9bd4-8888099933fb@huawei.com>
Date: Wed, 11 Mar 2026 10:57:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_acpi_id() on non-x86
To: Bjorn Helgaas <helgaas@kernel.org>
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
	<sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Wei Huang <wei.huang2@amd.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260310175305.GA730372@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260310175305.GA730372@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: DB3F825B333
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224637-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[61];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/11/2026 1:53 AM, Bjorn Helgaas wrote:
> On Tue, Mar 10, 2026 at 11:20:48AM +0800, Chengwen Feng wrote:
>> To unify the CPU ACPI ID retrieval interface across architectures,
>> rename the existing get_acpi_id_for_cpu() function to
>> acpi_get_cpu_acpi_id() on arm64/riscv/loongarch platforms.
>>
>> This is a pure rename with no functional change, preparing for a
>> consistent ACPI Processor UID retrieval interface across all ACPI-enabled
>> platforms.
> 
> Really a question for the ACPI folks, but my preferences would be:
> 
>   - Simpler name for the interface, e.g., "acpi_get_cpu_id()"

OK, and how about add u-, like: acpi_get_cpu_uid()

> 
>   - Single prototype in generic header, e.g., include/linux/acpi.h

OK

> 
>   - Split the x86 part to a separate patch and maybe (a tangent, but
>     looks dubious to me) figure out whether/why xen needs xen_vcpu_id
>     to be ACPI CPU IDs

OK for a separate patch for x86.

Btw: the x86 implementation in 2/2 commit may has problem, please see the reply in 2/2 for detail.

> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>  arch/arm64/include/asm/acpi.h      |  4 ++--
>>  arch/loongarch/include/asm/acpi.h  |  2 +-
>>  arch/riscv/include/asm/acpi.h      |  2 +-
>>  arch/riscv/kernel/acpi_numa.c      |  2 +-
>>  drivers/acpi/pptt.c                | 16 ++++++++--------
>>  drivers/acpi/riscv/rhct.c          |  2 +-
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
>>  7 files changed, 15 insertions(+), 15 deletions(-)
> 


