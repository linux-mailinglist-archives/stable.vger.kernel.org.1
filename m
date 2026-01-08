Return-Path: <stable+bounces-206320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BEAD031B2
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D683008F80
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CE426EC9;
	Thu,  8 Jan 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QJmEf5xa"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AE3D667E;
	Thu,  8 Jan 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767870883; cv=none; b=KbhoLnHZWyFB5euZjzb0bmbI+K3qyPusdxnpVghnlmaPL626ZN/c+xU5IOyaNvvBDUorPLhPDoLF3uHqkHDl6Im+veDDmS86eBSiFQ97kiz8oeMw481I+n3V+/R1xKwPiRUtX2ud24DRkYKAONOkpihB3SfaNU/F/448RpVZu4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767870883; c=relaxed/simple;
	bh=ywgoonqrHEulCSTxd2vQbUsmE3aTMGyUzZCUyxMj/qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaWdMXUoR7sCTqSUduPOOgWQPfE5Q4xIBGQDIuByBTcsFfaN+KxwDVlwavCQTsS2VYHL9oWnUS2JkAe070Tpx6Sby4TKUOgCmcZ87uuLzyWEMu6jtHJxI8Yjc1DJIu73JdtyU7I2RBZHS1l0MIJoMq2CJHnxuYcVN5qMDxiNNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QJmEf5xa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6089xbdW011316;
	Thu, 8 Jan 2026 11:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VOrHBz
	WPYvLqCnour3T5CPii1OlReIp2gg08NbPqsxE=; b=QJmEf5xaNI8LhBXQvy3vtP
	vNGW0kjNlbKIEuBxeWI/pLwt7RCnHdoB+vA2rNDnzbAoYiBoWExjlz9U75w821lX
	B5Ot5PhTfeisSuN2huPFJVW5CKBMMnj++JK6sQeGu5UhYyA98jVllZwgjl9rMQjA
	/ri8glSjsv/g4B0lIIyXdWgT/6GmgDnKZGGCy2nOpwxlL6vVGoD7yPNdyh51+MD+
	DprwiaAuEbSH+8nx+uxniwMEq7AblOXepw4QGG/kMYCqZEeKA6MBoxfBij+TnNIo
	GQ3Fo0xBQTu6NtroXspW+9dgyHlUHqVAHXQ6MApbj7MAKr4+E88JOZbHRJJJoofw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkcr1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 11:14:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 608BE64b013346;
	Thu, 8 Jan 2026 11:14:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhkcr1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 11:14:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6088DhBb015242;
	Thu, 8 Jan 2026 11:14:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdespn14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 11:14:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 608BE3j827722362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Jan 2026 11:14:03 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA0C658059;
	Thu,  8 Jan 2026 11:14:03 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D84F58058;
	Thu,  8 Jan 2026 11:13:59 +0000 (GMT)
Received: from [9.109.209.83] (unknown [9.109.209.83])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Jan 2026 11:13:59 +0000 (GMT)
Message-ID: <ebbc7ae7-2eb5-4b92-99e9-549c289b995c@linux.ibm.com>
Date: Thu, 8 Jan 2026 16:43:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/pseries: Fix MSI-X allocation failure when
 quota is exceeded
To: Nilay Shroff <nilay@linux.ibm.com>, Nam Cao <namcao@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        gautam@linux.ibm.com, Gregory Joyce <gjoyce@ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260107100230.1466093-1-namcao@linutronix.de>
 <1fda7021-ec31-40ed-bfd8-e0e9b657662f@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <1fda7021-ec31-40ed-bfd8-e0e9b657662f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695f917e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=LTgroE_r0Rx6dzEudaAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z2DVWXM9WqHD0m2emh8IGzZxxO4ughpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA3MyBTYWx0ZWRfX/kKWLhLK2qmZ
 Y/83TiBiyihaKZVf6Tip3PbKjUKMLLblw+b/l06NPydiH8WSgHh9TmjlW0zIq4KdJjwSF7xjCeC
 0mkzDL0ivyc6CzfJizZT68gBEUOSHy6SrpWHmgko+i+bpb2ZyAcMUQhnVig5Vu/gjDdvfrb5tGG
 MRAc9u2D4nAzEsPCSIAhdSH0yCO3AjVYDnxY4c/LzakoT6I/P6+cx2nScP0a2r8I2lAliAh2VYK
 1GQTIeYGhZJaieuxROrXMSgD5zZJjhnVFtxvdMwECYE3oEgDpoPSUN/YEr9DN03YHPCKKhmREXG
 nQCl8Aa4OqyDwXdluH+Su2OsdKvoTnHe3owj/XHXaKcztBk9hfkMMV+eNOHM3Kfemin7k86rnka
 XZ4H0vqV+HO1iLgm/AknnYz5iF3U4erOob4i0fKHI5rnxnkjnAeTrZwa+4Kt/Rrtrw3CyeuDIla
 N2HRHFcDeH7NhG/Q39A==
X-Proofpoint-GUID: 7PQIpYKgEczd8DbcgUQj5Dfwg4HDregf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601080073


On 1/7/26 7:55 PM, Nilay Shroff wrote:
>
> On 1/7/26 3:32 PM, Nam Cao wrote:
>> Nilay reported that since commit daaa574aba6f ("powerpc/pseries/msi: Switch
>> to msi_create_parent_irq_domain()"), the NVMe driver cannot enable MSI-X
>> when the device's MSI-X table size is larger than the firmware's MSI quota
>> for the device.
>>
>> This is because the commit changes how rtas_prepare_msi_irqs() is called:
>>
>>    - Before, it is called when interrupts are allocated at the global
>>      interrupt domain with nvec_in being the number of allocated interrupts.
>>      rtas_prepare_msi_irqs() can return a positive number and the allocation
>>      will be retried.
>>
>>    - Now, it is called at the creation of per-device interrupt domain with
>>      nvec_in being the number of interrupts that the device supports. If
>>      rtas_prepare_msi_irqs() returns positive, domain creation just fails.
>>
>> For Nilay's NVMe driver case, rtas_prepare_msi_irqs() returns a positive
>> number (the quota). This causes per-device interrupt domain creation to
>> fail and thus the NVMe driver cannot enable MSI-X.
>>
>> Rework to make this scenario works again:
>>
>>    - pseries_msi_ops_prepare() only prepares as many interrupts as the quota
>>      permit.
>>
>>    - pseries_irq_domain_alloc() fails if the device's quota is exceeded.
>>
>> Now, if the quota is exceeded, pseries_msi_ops_prepare() will only prepare
>> as allowed by the quota. If device drivers attempt to allocate more
>> interrupts than the quota permits, pseries_irq_domain_alloc() will return
>> an error code and msi_handle_pci_fail() will allow device drivers a retry.
>>
>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>> Closes: https://lore.kernel.org/linuxppc-dev/6af2c4c2-97f6-4758-be33-256638ef39e5@linux.ibm.com/
>> Fixes: daaa574aba6f ("powerpc/pseries/msi: Switch to msi_create_parent_irq_domain()")
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> Acked-by: Nilay Shroff <nilay@linux.ibm.com>
>> Cc: stable@vger.kernel.org
>> ---
>> v2:
>>    - change pseries_msi_ops_prepare()'s allocation logic to match the
>>      original logic in __pci_enable_msix_range()
>>
>>    - fix up Nilay's email address
>> ---
>>   arch/powerpc/platforms/pseries/msi.c | 44 ++++++++++++++++++++++++++--
>>   1 file changed, 41 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
>> index a82aaa786e9e..edc30cda5dbc 100644
>> --- a/arch/powerpc/platforms/pseries/msi.c
>> +++ b/arch/powerpc/platforms/pseries/msi.c
>> @@ -19,6 +19,11 @@
>>   
>>   #include "pseries.h"
>>   
>> +struct pseries_msi_device {
>> +	unsigned int msi_quota;
>> +	unsigned int msi_used;
>> +};
>> +
>>   static int query_token, change_token;
>>   
>>   #define RTAS_QUERY_FN		0
>> @@ -433,8 +438,28 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
>>   	struct msi_domain_info *info = domain->host_data;
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	int type = (info->flags & MSI_FLAG_PCI_MSIX) ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
>> +	int ret;
>> +
>> +	struct pseries_msi_device *pseries_dev __free(kfree)
>> +		= kmalloc(sizeof(*pseries_dev), GFP_KERNEL);
>> +	if (!pseries_dev)
>> +		return -ENOMEM;
>> +
>> +	while (1) {
>> +		ret = rtas_prepare_msi_irqs(pdev, nvec, type, arg);
>> +		if (!ret)
>> +			break;
>> +		else if (ret > 0)
>> +			nvec = ret;
>> +		else
>> +			return ret;
>> +	}
>>   
>> -	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
>> +	pseries_dev->msi_quota = nvec;
>> +	pseries_dev->msi_used = 0;
>> +
>> +	arg->scratchpad[0].ptr = no_free_ptr(pseries_dev);
>> +	return 0;
>>   }
>>   
>>   /*
>> @@ -443,9 +468,13 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
>>    */
>>   static void pseries_msi_ops_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
>>   {
>> +	struct pseries_msi_device *pseries_dev = arg->scratchpad[0].ptr;
>>   	struct pci_dev *pdev = to_pci_dev(domain->dev);
>>   
>>   	rtas_disable_msi(pdev);
>> +
>> +	WARN_ON(pseries_dev->msi_used);
>> +	kfree(pseries_dev);
>>   }
>>   
>>   static void pseries_msi_shutdown(struct irq_data *d)
>> @@ -546,12 +575,18 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>>   				    unsigned int nr_irqs, void *arg)
>>   {
>>   	struct pci_controller *phb = domain->host_data;
>> +	struct pseries_msi_device *pseries_dev;
>>   	msi_alloc_info_t *info = arg;
>>   	struct msi_desc *desc = info->desc;
>>   	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);
>>   	int hwirq;
>>   	int i, ret;
>>   
>> +	pseries_dev = info->scratchpad[0].ptr;
>> +
>> +	if (pseries_dev->msi_used + nr_irqs > pseries_dev->msi_quota)
>> +		return -ENOSPC;
>> +
>>   	hwirq = rtas_query_irq_number(pci_get_pdn(pdev), desc->msi_index);
>>   	if (hwirq < 0) {
>>   		dev_err(&pdev->dev, "Failed to query HW IRQ: %d\n", hwirq);
>> @@ -567,9 +602,10 @@ static int pseries_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
>>   			goto out;
>>   
>>   		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
>> -					      &pseries_msi_irq_chip, domain->host_data);
>> +					      &pseries_msi_irq_chip, pseries_dev);
>>   	}
>>   
>> +	pseries_dev->msi_used++;
>>   	return 0;
>>   
>>   out:
>> @@ -582,9 +618,11 @@ static void pseries_irq_domain_free(struct irq_domain *domain, unsigned int virq
>>   				    unsigned int nr_irqs)
>>   {
>>   	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
>> -	struct pci_controller *phb = irq_data_get_irq_chip_data(d);
>> +	struct pseries_msi_device *pseries_dev = irq_data_get_irq_chip_data(d);
>> +	struct pci_controller *phb = domain->host_data;
>>   
>>   	pr_debug("%s bridge %pOF %d #%d\n", __func__, phb->dn, virq, nr_irqs);
>> +	pseries_dev->msi_used -= nr_irqs;
>>   	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>>   }
>>   
> I just tested this change on my system using the latest mainline kernel and it works
> well for me. So with that, please fell free to add,
>
> Tested-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks will pull this in.
Maddy

>

