Return-Path: <stable+bounces-233536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEAgHYnV1GnuxwcAu9opvQ
	(envelope-from <stable+bounces-233536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D53AC6C2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B2CE300B588
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD93A6EFD;
	Tue,  7 Apr 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Puk6Pn+6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C3165F16;
	Tue,  7 Apr 2026 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555972; cv=none; b=Y1SauwZS4113yc8LV3eyKCnUKBUqZUYzVq530nqZIpyP8NAOde46BE+XFg8R0GN2zKL4bENt7tH5aOBAAXSKJlXj6TZr7CH4AJkX2NQor230t0BZZErUkYA7ywR6wH7ZgSIfnAdDxfIxzl3tQTNM+3ckALNrjN2lboRG20Yi/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555972; c=relaxed/simple;
	bh=V7dF87fncBrIBPhMvslOmlIIRRx0HRF0W5u7fCnMmgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkZye2ftbB0gkOOsgqLVx8LTrNQAkiQsTYd6Xkko95vFNa+G7F1iIXvE+V3ifAF8cCJM+Om4qqPF8vwMh1Dk8eVcyw0OpQgC4bAguTGpzMPfmS9Cmky4r1hb+++9aM/qPKwhIPtpEhHA7DkfKHDuzATAuCnC2z1tCYkbJxr5e/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Puk6Pn+6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LlseA2210133;
	Tue, 7 Apr 2026 09:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hUnQYV
	FzqeElTPpSbXCMf7HEQKj/iCXWXPiwA32M7aI=; b=Puk6Pn+62MN2qWS/AEhawm
	Sfqes9v1uox4e0yUZkIMZqSn+as9VZL7O3XmRqBvaRA5U2NshbSKIT/3NT4mxikD
	8exT9ReoJEJmgzR1RFGeSF6ZIMxVgVE5/86qvVxV0UC9IRbmCFnqAz9q1UkkQrWr
	eWBRLCUH4J/kJ27IG9GowZiwVSvKyyDQbkMjMm9wFWnT/au6TEzH9E5qU0+oHfWl
	RzFOzccok/cFCsb0PKpffqLyG434u6FaRXNpFvvylRkgqR4xkBR2i82T8ywYgETB
	+rpw3zUEuWqRGTlt+Nx80ZH2gPrQQ9g/56hhtOeevHRk9br/AvYF3OcIFy8y1eqA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ha2cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 09:59:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63793csl026642;
	Tue, 7 Apr 2026 09:59:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7sxs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 09:59:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6379xLX955574960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 09:59:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F3E92004B;
	Tue,  7 Apr 2026 09:59:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 846FF20040;
	Tue,  7 Apr 2026 09:59:19 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 09:59:19 +0000 (GMT)
Message-ID: <401693ba-1455-4b45-8596-b81625f01201@linux.ibm.com>
Date: Tue, 7 Apr 2026 15:29:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com> <adRIwaLxqIoIDkTF@Rk>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <adRIwaLxqIoIDkTF@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5MCBTYWx0ZWRfX6q2Jtyyu9Zh3
 8vZ+HoEfti5xd6SzuEd1PUZ9QKIBzmaP4UTTrcJrz0xaXZE+4jX5H9Q0j99HzkcUdz7FaQrvhS0
 2iSTsR7ktQ9biJZLjWwClcO1v4kb/ajyAfktI+6FW3kLJ2to5yUj3Fxjw23FUnzIJ4oN2YHHfdU
 FhEG3LL0jBHr4yB9/WF75kyNW/ZjOGB0NyfmHSIlBKJcgH9QhkvJuWcDYhMJbzgirI+orwS5AIF
 AsqoPIOy63MFx20m617wnsAYIo83KO5bCNig0Wy/YyBSlSqsjcMODRTGpBLtpNxHAjvcF4VGaM2
 DXGYVjfFSJjvRYyuMCLfLRRpLJh6/xdKtBlwX5FIT3zOzhKMEykZlda3H8wfGZ3cxAw3jXIsYvu
 tmLhexxA9670qQ0/MsC+VpLdl1NMitHC/kqLi7HyQfZAZ/bN9JQraKIHX5Sxi3Mn1hIDoc7t549
 a6cNx7MDXUTZ9QJ5uhQ==
X-Proofpoint-GUID: qGC9GfQZc394f28t0Z1rc4BpjzPtxu0J
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d4d57c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=c92rfblmAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8
 a=Uie23QXBFDTAevBk0ggA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: qGC9GfQZc394f28t0Z1rc4BpjzPtxu0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070090
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233536-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 151D53AC6C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 07/04/26 06:14, Coiby Xu wrote:
> On Fri, Apr 03, 2026 at 07:48:29PM +0530, Sourabh Jain wrote:
>> Hello Coiby,
>
> Hi Sourabh,
>
>>
>> On 03/04/26 15:31, Coiby Xu wrote:
>>> If kexec_add_buffer fails, keys_header will be freed. And depending on
>>> /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>> following two problems if the kexec_file_load syscall is called again,
>>>   1. Double free of keys_header if reuse=false
>>>   2. UAF of keys_header if reuse=true
>>>
>>> Address these problems by setting keys_header to NULL after freeing
>>> kbuf.buffer and re-building keys_header when necessary respectively.
>>>
>>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>> reserved memory")
>>> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for 
>>> CPU/memory hot-plugging")
>>> Cc: stable@vger.kernel.org
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>>> ---
>>>  kernel/crash_dump_dm_crypt.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/crash_dump_dm_crypt.c 
>>> b/kernel/crash_dump_dm_crypt.c
>>> index a20d4097744a..92eebef27156 100644
>>> --- a/kernel/crash_dump_dm_crypt.c
>>> +++ b/kernel/crash_dump_dm_crypt.c
>>> @@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>          return -ENOENT;
>>>      }
>>> -    if (!is_dm_key_reused) {
>>> +    if (!is_dm_key_reused || !keys_header) {
>>>          image->dm_crypt_keys_addr = 0;
>>>          r = build_keys_header();
>>>          if (r)
>>> @@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>      r = kexec_add_buffer(&kbuf);
>>>      if (r) {
>>>          kvfree((void *)kbuf.buffer);
>>> +        keys_header = NULL;
>>>          return r;
>>>      }
>>>      image->dm_crypt_keys_addr = kbuf.mem;
>>>
>>> base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
>>
>> Sashiko raised seven concerns on this patch. Most of them are
>> not directly related to the changes introduced here, but I
>> think they can be addressed along with this fix.
>>
>> https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com 
>>
>
> Thanks for pointing me to the Sashiko's code review and also sharing
> your meticulous analysis!
>
>>
>>
>> 1. build_keys_header() does not release key_header memory on
>>    error. This can cause incorrect keys to be loaded for the
>>    kdump kernel in subsequent system calls.
>>
>> Can be addressed by releasing keys_header on error path.
>
> I'll address this issue! Thanks for the suggestion!
>
>>
>> 2–3. get_keys_header_size() uses key_count to find the size of
>> key_header buffer, which can lead to out-of-bounds access
>> at two places.
>>   a. Around kexec_add_buffer()
>>   b. In build_keys_header()
>>
>> I think there is one more place where this applies is:
>>   c. In get_keys_from_kdump_reserved_memory() at memcpy
>>
>> I agree with solution provided by Sashiko of using 
>> keys_header->total_keys
>> instead.
>
> Thanks for showing me where out-of-bounds accesses can happen! I'll do
> some testing to see if using keys_header->total_keys is sufficient.
>
>>
>> 4. get_keys_from_kdump_reserved_memory() may run into issues
>>    if kexec_crash_image->dm_crypt_keys_addr is larger than a
>>    page size during memcpy. Because kmap_local_page only maps
>>    one page.
>>
>> How about moving this in a loop and do map and copy page by page?
>
> Yeah, looping over the pages should be a robust solution.
>
>>
>> 5. Related to releasing the keyring_ref reference count, but
>>    I did not fully understand this concern.
>
> My latest test already covers the case where there are two keys to
> iterate over. I'll dig more into keyring_ref to see if Sashiko's
> concerns is valid.
>
>>
>> 6. restore_dm_crypt_keys_to_thread_keyring() does not release
>>    previously allocated keys_header, leading to a memory leak.
>
> Thanks for raising the concern! Although we can assume the system will
> reboot soon after vmcore dumping is finished, it's better to free
> keys_header.
>
>>
>> As per kdump.rst, restore was introduced to handle CPU and
>> memory hotplug cases. Is it needed when there is no in-kernel
>> update to the kdump image on CPU or memory hotplug events?
>>
>> But in that case, we rely on a udev rule to reload the kdump image
>> again.
>>
>> I am confused about when exactly we need to restore.
>
> To clarify, reuse other than restore is needed for non in-kernel update
> when handing CPU/memory hotplugging. Yes, a udev rule is also needed in
> this case.

Below commit explains how the reuse is utilized:

commit 9ebfa8dcaea77a8ef02d0f9478717a138b0ad828
Author: Coiby Xu <coxu@redhat.com>
Date:   Fri May 2 09:12:38 2025 +0800

     crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging

It got it now. This is helpful when kdump needs to be reloaded due to
CPU/memory hotplug events using the kexec_file_load system call,
but only when CONFIG_CRASH_HOTPLUG is not enabled.

IIUC this feature is not support on crash image loaded using kexec_load 
syscall, right?


- Sourabh Jain


