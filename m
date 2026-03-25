Return-Path: <stable+bounces-230377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lc1OqUixGmZwgQAu9opvQ
	(envelope-from <stable+bounces-230377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:00:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A18232A369
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CABA0300B9E7
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAE402B8E;
	Wed, 25 Mar 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gprVEQ92"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5940626B
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461601; cv=none; b=ei26Q665c4Cxtvlb5C3FhVQyIr+RkayBv16iqOBKnaZVdcslXMW7AqMXG6skZHgxDG3Jsmsh0DbmsMG1T1Avjbghic+Z3SmrL0OMe2jMMtGznS/l40RIVj6/UJULvbmoycpXz7kZDYTBVG4oUtnuU/dMuce8tcncLIhTvDXmhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461601; c=relaxed/simple;
	bh=AEi6C7pbuv927YEnReJ4fM3wPCr1yqiU5dS9guDE30A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iqvm/ToFtSZdwt+YqF0dvGdIFPoXtsrfAhK+jR7Bv0j0Tgk+xUPtn424cJT8soRbcbiMmpawJJz0/y18BOC3fL+NzzpbaeiV++tNqPJSv9FrrRFQuXWtA+vs0GaVIgQ9fynZNE8/emnNouTHb/QFIGVxu74IcrXwXm8oCrbljKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gprVEQ92; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P9KXmX3640057;
	Wed, 25 Mar 2026 17:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H24rz3
	DEIfcIP/AazTnPtuWcItY8Vl+U2/MMWlSk+NU=; b=gprVEQ92rcuMNi/5xLt8Wd
	+PfCRWOu5OpUVF2ZFWommX2CAjSaUxmW+BPbwtAoba4E5Tf59FSqiqlUUP4hJrYE
	FrUlgTTZ+vYLFgTMS27UBgNf9wQAJJoytP6UK8I254Q2c8CZu6YeZZemPjvawL1z
	9tDryj0XAd3D6kma2piD2xJ9lWFfkujjMrvN7YiJpm15FdMr+wFx5oH871ZwILkw
	ATjF5JPK87MErXaw2UcEsSgBDLuCZ8D/8Odgs82N5eZxLNC0qGq1sHE764672kDT
	RVE0L9KLdZTXQ11WppYzHlDp/yxUEUT0+qGM6JFSRjomQjIUYvB26TTapalVUzYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky08v7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:59:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PH8pnh004399;
	Wed, 25 Mar 2026 17:59:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c27cwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:59:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHxsaZ29295220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:59:54 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E09EF5803F;
	Wed, 25 Mar 2026 17:59:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2640A58054;
	Wed, 25 Mar 2026 17:59:50 +0000 (GMT)
Received: from [9.39.25.125] (unknown [9.39.25.125])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:59:49 +0000 (GMT)
Message-ID: <a6ee70c8-e350-43dc-a188-e33b70ca047d@linux.ibm.com>
Date: Wed, 25 Mar 2026 23:29:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
 <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
 <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
 <6171f849-4164-4fd5-b31e-79c08df936c2@linux.ibm.com>
 <6b2d502d-08ef-4008-8399-f5630de2385c@amd.com>
 <cbbc63ba-0c21-4fd9-b701-d79356b75d12@amd.com>
 <79783c4d-13cb-4ae9-b2ba-45c066fb515a@linux.ibm.com>
 <f54a9107-a19f-47b8-83ee-6ebe0d305499@amd.com>
 <00db9c57-9d16-4123-8e2c-b9251aa702ad@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <00db9c57-9d16-4123-8e2c-b9251aa702ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyOSBTYWx0ZWRfX50dG+MjqkT1A
 BsVodQipM9y5640MP8Ec/Y7aUeQd20rZERkwfPz0XrcdvULDlUvX8rgc/3NhH80R1EMw1UkNFHy
 Zpbe7aSeYVXV0S+r3s1+GeKAszqwttJHxVCct9xIFo8YDnTtADw1SMvUwBHyps1cGngCt7jmw8u
 h/rOIrZRwuvpMeqBRl4UTcK+Cf6u3XB4JgUJKi3faz1l145A4AKYnxMEVgVIXIpt/wI/fIbmYIV
 Rnem28kq/3C0Xl+JcryYWcaL3rBAhu4UlfhKLc9bQ3rg7SN8np9qjE/Wdre/wzEk+CTl9S5Pk12
 69u3zE9fFkDv6HshPvU5fz61YkvOUtCq9fV+oeyljhEvhM2oQWrMjdqh3qzfIylSFkANo/iAGvz
 RptvyZfjPqQwtV07wRjrB4TsqKyf7STD7Dusw6EQmmkb0eg0o3udwwFBae3tvqvCbSq00yPsPbR
 V6bZ/dxEjwv4XH6FMVA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c4229b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ollYYA0SzF1M6iY1_W8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ekjZwXEy9GgvTq3WbrXk0jI6skmz2Kuq
X-Proofpoint-GUID: kM32Gd8ZLGdEom41q2w1sYfJ--8yTsty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250129
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230377-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[amd.com,lists.freedesktop.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7A18232A369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/25/26 11:24 PM, Kuehling, Felix wrote:
>
> On 2026-03-25 06:29, Christian König wrote:
>>> Hi @Christian @Felix
>>>
>>> Thanks for the review.
>>>
>>> I have made the suggested change. I am now reserving 64 KB
>>> in the  address space for the trap, while allocating
>>> only 8 KB for both 4K and 64K page sizes. With this change,
>>> I am no longer seeing crashes on either 4K or 64K systems.
>>>
>>> Does this approach look reasonable to you?
>> Looks correct to me, but Felix clearly has the last word on that.
>
> That works for me as well.


Thank you , Felix. I will incorporate this change and post an updated 
version.

-Donet


>
> Thanks,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index bb276c0ad06d..d5b7061556ba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE          (2ULL << 20)
>>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev) 
>>>  (AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>                                                   - 
>>> AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE           (2ULL << 12)
>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE           (1ULL << 16)
>>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev) 
>>> (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>                                                   - 
>>> AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>   #define AMDGPU_VA_RESERVED_BOTTOM              (1ULL << 16)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index e5b56412931b..035687a17d89 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -102,8 +102,8 @@
>>>    * The first chunk is the TBA used for the CWSR ISA code. The second
>>>    * chunk is used as TMA for user-mode trap handler setup in 
>>> daisy-chain mode.
>>>    */
>>> -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>>> -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
>>> +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
>>> +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
>>>
>>>   #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE               \
>>>          (KFD_MAX_NUM_OF_PROCESSES *

