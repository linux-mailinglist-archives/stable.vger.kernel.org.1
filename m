Return-Path: <stable+bounces-227431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMB9DXi+vGlz2gIAu9opvQ
	(envelope-from <stable+bounces-227431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:26:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F5C2D5938
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA51307EECB
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13D2E0B48;
	Fri, 20 Mar 2026 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PzyvQYqy"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18429ACC5;
	Fri, 20 Mar 2026 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773977198; cv=none; b=atAaL32n+jkSvt7bVbLfDjn3SpS+WxvGe81z1hS9LjPQbdPvHRjwdUqLqMP5D50Bmi9N1RviVBiPkUHSU9D0P6nWsBo8Wcsftl1ZfNRGnX8kv5si5eoSHaV5MW+/ckEH0jLKhYf7XHrBQ/FyUGrORlPDFS3zDP+WYtEwUiF5hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773977198; c=relaxed/simple;
	bh=xh+ffbb2oaNHZsmPafLZjYdLct4e+SO5Mig7THEgVVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mIgZxr5MEX5sMXxAGhdbVvGFfOrDV/sb+S7NEqilT0u8KYKfuXs22StEe9pSVlcK6Cmg+OMvTwj0m5ADnht9FQbHXdXi0OadhXuZ7MUuOy2flW0bsA8Bhf/sNDRfHSDB/ZKsLRWBQUDhZwWAWm6a65jjU+ZzJf/cvS+VDLwJ9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PzyvQYqy; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3LiHuocNrG9VyhQSPGsfxkLqow8jinLscyafTJUH7n0=;
	b=PzyvQYqytsSSptjXyQJXJSFxg0IsfMHvz47ITRg5ssR326CVuLSufayFGG12zYgBkkQvJa9KB
	JV6YGyDu/jcmqj8yhrn0VgSgQUJ+FE1fdp4aXgqP1j+6e0GjQLxYAFTO3TjEwrZXKdnbrJr1nvU
	oTV5X1+VOGWBf29jt2KHEOw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fcSWp0crhz1T4Fg;
	Fri, 20 Mar 2026 11:21:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B830440569;
	Fri, 20 Mar 2026 11:26:33 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 11:26:31 +0800
Message-ID: <823d8281-f01c-4ed1-94ed-17869b2c7526@huawei.com>
Date: Fri, 20 Mar 2026 11:26:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/7] PCI/TPH: Fix get cpu steer-tag fail on ARM64
 platform
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
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
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
References: <20260319183219.GA519221@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260319183219.GA519221@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_GT_50(0.00)[70];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-227431-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: D1F5C2D5938
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/2026 2:32 AM, Bjorn Helgaas wrote:
> Let's make the subject a little more specific, e.g.,
> 
>   PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM

done in v10

> 
> On Thu, Mar 19, 2026 at 02:57:35PM +0800, Chengwen Feng wrote:
>> pcie_tph_get_cpu_st() is broken on ARM64:
>> 1. pcie_tph_get_cpu_st() passes cpu_uid to the PCI ACPI DSM method.
>>    cpu_uid should be the ACPI Processor UID [1].
>> 2. In BNXT, pcie_tph_get_cpu_st() is passed a cpu_uid obtained via
>>    cpumask_first(irq->cpu_mask) - the logical CPU ID of a CPU core,
>>    generated and managed by kernel (e.g., [0,255] for a system  with 256
>>    logical CPU cores).
>> 3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
>>    MADT table, and this UID may not match the kernel's logical CPU ID.
>>    When this occurs, the mismatch results in the wrong CPU steer-tag.
>> 4. On AMD x86 the logical CPU ID is identical to the ACPI Processor UID
>>    so the mismatch is not seen.
>>
>> Resolution:
>> 1. Use acpi_get_cpu_uid() in pcie_tph_get_cpu_st() to translate from
>>    logical CPU ID to ACPI Processor UID needed for the DSM call.
>> 2. Rename pcie_tpu_get_cpu_st() parameter from cpu_uid to cpu to
>>    reflect that it is a logical CPU_ID.
> 
> And simplify this, e.g.,
> 
>   pcie_tph_get_cpu_st() uses the Query Cache Locality Features _DSM
>   [1] to retrieve the TPH Steering Tag for memory associated with the
>   CPU identified by its "cpu_uid" parameter, a Linux logical CPU ID.
> 
>   The _DSM requires a ACPI Processor UID, which pcie_tph_get_cpu_st()
>   previously assumed was the same as the Linux logical CPU ID.  This
>   is true on x86 but not on arm64, so pcie_tph_get_cpu_st() failed on
>   arm64.
> 
>   Convert the Linux logical CPU ID to the ACPI Processor UID with
>   acpi_get_cpu_uid() before passing it to the _DSM.
> 
> If there's a specific error message from BNXT or similar that is a
> symptom of this problem, it'd be nice to include that.  Or if the
> problem was just poor performance because the _DSM returned the wrong
> Steering Tag, you could say something like:
> 
>   ... so pcie_tph_get_cpu_st() returned the wrong Steering Tag,
>   resulting in poor network performance.

It is indeed simplified, done in v10

> 
>> [1] According to ECN_TPH-ST_Revision_20200924
>>     (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
>>     is defined as: "If the target is a processor, then this field
>>     represents the ACPI Processor UID of the processor as specified in
>>     the MADT. If the target is a processor container, then this field
>>     represents the ACPI Processor UID of the processor container as
>>     specified in the PPTT."
>>
>> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> The patch looks good to me.  Thanks for all your work on this!
> 
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks Bjorn for your review and kind words! I really appreciate it.

> 
>> ---
>>  Documentation/PCI/tph.rst |  4 ++--
>>  drivers/pci/tph.c         | 16 +++++++++++-----
>>  include/linux/pci-tph.h   |  4 ++--
>>  3 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
>> index e8993be64fd6..b6cf22b9bd90 100644
>> --- a/Documentation/PCI/tph.rst
>> +++ b/Documentation/PCI/tph.rst
>> @@ -79,10 +79,10 @@ To retrieve a Steering Tag for a target memory associated with a specific
>>  CPU, use the following function::
>>  
>>    int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type type,
>> -                          unsigned int cpu_uid, u16 *tag);
>> +                          unsigned int cpu, u16 *tag);
>>  
>>  The `type` argument is used to specify the memory type, either volatile
>> -or persistent, of the target memory. The `cpu_uid` argument specifies the
>> +or persistent, of the target memory. The `cpu` argument specifies the
>>  CPU where the memory is associated to.
>>  
>>  After the ST value is retrieved, the device driver can use the following
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index ca4f97be7538..b67c9ad14bda 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -236,21 +236,27 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
>>   * with a specific CPU
>>   * @pdev: PCI device
>>   * @mem_type: target memory type (volatile or persistent RAM)
>> - * @cpu_uid: associated CPU id
>> + * @cpu: associated CPU id
>>   * @tag: Steering Tag to be returned
>>   *
>>   * Return the Steering Tag for a target memory that is associated with a
>> - * specific CPU as indicated by cpu_uid.
>> + * specific CPU as indicated by cpu.
>>   *
>>   * Return: 0 if success, otherwise negative value (-errno)
>>   */
>>  int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>> -			unsigned int cpu_uid, u16 *tag)
>> +			unsigned int cpu, u16 *tag)
>>  {
>>  #ifdef CONFIG_ACPI
>>  	struct pci_dev *rp;
>>  	acpi_handle rp_acpi_handle;
>>  	union st_info info;
>> +	u32 cpu_uid;
>> +	int ret;
>> +
>> +	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
>> +	if (ret != 0)
>> +		return ret;
>>  
>>  	rp = pcie_find_root_port(pdev);
>>  	if (!rp || !rp->bus || !rp->bus->bridge)
>> @@ -265,9 +271,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>  
>>  	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
>>  
>> -	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
>> +	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
>>  		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
>> -		cpu_uid, *tag);
>> +		cpu, *tag);
>>  
>>  	return 0;
>>  #else
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index ba28140ce670..be68cd17f2f8 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -25,7 +25,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>  			  unsigned int index, u16 tag);
>>  int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>  			enum tph_mem_type mem_type,
>> -			unsigned int cpu_uid, u16 *tag);
>> +			unsigned int cpu, u16 *tag);
>>  void pcie_disable_tph(struct pci_dev *pdev);
>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>> @@ -36,7 +36,7 @@ static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>  { return -EINVAL; }
>>  static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>  				      enum tph_mem_type mem_type,
>> -				      unsigned int cpu_uid, u16 *tag)
>> +				      unsigned int cpu, u16 *tag)
>>  { return -EINVAL; }
>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>> -- 
>> 2.17.1
>>
> 


