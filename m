Return-Path: <stable+bounces-179683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF0B58E18
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 07:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50A2320FE3
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 05:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60E2DAFAA;
	Tue, 16 Sep 2025 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZIIWg39"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA659221DAD;
	Tue, 16 Sep 2025 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001881; cv=none; b=DouNZ83jz7yo7udqwTIV+plFpjSIV54NEd6n631TrxzGly+LWZ/2TbV4KkcKXOvw7rOy7BRnpEJSQ8HPDn3mnYzvjD2Kv8dPJ5z+1OYoWC9yeBfW3WvZs2zkV7g7vfdVSlBn52CVxpEoEjm4qdslBY2ezIvqoR0dSUk7uBIEXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001881; c=relaxed/simple;
	bh=GOvPbzq9dY/FzbYpF7NQUdMvLRGlwu3UfHnUlsJK2j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsybqqB/SfAzEif0vL4zYQP5h6hNVLOoBnDgHRyqc04rmCauF7d1ZeidejQc5sCBOZZfjW+k7s+oBMCgKWMTLIGvkRkNy0R9Jb8IqyL0lb4hST87qGzMkWspXs9/9lEllIEDs/oekfYRf7xLAWoMJYr54I2+EzEauULUjmGX4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZIIWg39; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G38QFB017396;
	Tue, 16 Sep 2025 05:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ccT1bC
	7lYbAG6exxdO3CkV7Hot/4KAxkJYvN55BT0zo=; b=OZIIWg39Dwp/vQG8Ux0lVN
	sdJ9ZFaqVu7FThJv7doPD24vzEt6thLBDI+fM14u5YeBZGwpI5rHa0SH7/1ft9Ui
	xvrxs0I4OJy0ODpGcImX+SzHamtticZiaVdGb1KRCp2lEX+9w3otUtVZ4KL7Uwvo
	tX1wQbrc53kpsXzE+ibQCXq4/mLm1ofjslAAqOwoMbLecW1e39gOfc5YvRx2jL8E
	lHIeXqMB875hgFSsKJpXGADWX1zL4jLE5sEYlbXsMt4EujxxCVwiXGM/wKsrcpWf
	1YjJXoFPQV5MujyMbKR8GTWkxIVTgwrxtcXKhX9HKT+EmGXIKNU77FeZoh4E6cng
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g53584e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 05:50:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58G5ouVf002958;
	Tue, 16 Sep 2025 05:50:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g53584d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 05:50:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58G5mWKK005963;
	Tue, 16 Sep 2025 05:50:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu2ha3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 05:50:56 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58G5otru30868196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 05:50:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F4205805A;
	Tue, 16 Sep 2025 05:50:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB6D15805C;
	Tue, 16 Sep 2025 05:50:50 +0000 (GMT)
Received: from [9.109.215.183] (unknown [9.109.215.183])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 05:50:50 +0000 (GMT)
Message-ID: <7dcfab94-753a-4e60-b350-2a5f09613c34@linux.ibm.com>
Date: Tue, 16 Sep 2025 11:20:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
To: Sasha Levin <sashal@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Wei Yang <richard.weiyang@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
 <20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
 <aMjohar0r-nffx9V@laps>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <aMjohar0r-nffx9V@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LFh1igVw5leCDBK86GUUJvHhLChJTO9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfXxgQQSHweHzxG
 k4h/GPcfLMPV+IWwJfSpfOJ5dqvba4B1kx+E70IFyvGtvJ5KtiCCkfA17s9bbUouirXhtOHk4A1
 zaYjzVN1lJljVEwl6wcH9t+7AY/XCfvOxx83to2rbgbM58JjsipA9kA0xMEh3k8HGtmWvWIfnUH
 MyDxY4++iDrvzHSAPPy5Yi08x1RpWD9vU7iwZ/WZFX+luJYMzHLKiZX247L8U1Nt6idkSgE/b1Q
 mUBY40pydAOq7FSnbF0reezdz1b6kuWWm8dFM6s7MNc+LDCmSu4hY8yxb4bUZXMuNy1irY4QXuu
 biBou/V8OM/olt9BDyyhz0yC0WvPdP3fweG2DlabevyT7NMHs5E7F/rmnO5QyHjqOgsFurlxf+4
 MofpqGRH
X-Proofpoint-ORIG-GUID: FdAcikb9w6k-2Q621R_EORuMfP_2YG66
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c8fac1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=PrHmRqyh15Ml7F08pAgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086


On 9/16/25 10:03 AM, Sasha Levin wrote:
> On Mon, Sep 15, 2025 at 04:42:48PM -0700, Andrew Morton wrote:
>> On Mon, 15 Sep 2025 20:33:04 +0530 Donet Tom <donettom@linux.ibm.com> 
>> wrote:
>>
>>> Currently, the KSM-related counters in `mm_struct`, such as
>>> `ksm_merging_pages`, `ksm_rmap_items`, and `ksm_zero_pages`, are
>>> inherited by the child process during fork. This results in 
>>> inconsistent
>>> accounting.
>>>
>>> When a process uses KSM, identical pages are merged and an rmap item is
>>> created for each merged page. The `ksm_merging_pages` and
>>> `ksm_rmap_items` counters are updated accordingly. However, after a
>>> fork, these counters are copied to the child while the corresponding
>>> rmap items are not. As a result, when the child later triggers an
>>> unmerge, there are no rmap items present in the child, so the counters
>>> remain stale, leading to incorrect accounting.
>>>
>>> A similar issue exists with `ksm_zero_pages`, which maintains both a
>>> global counter and a per-process counter. During fork, the per-process
>>> counter is inherited by the child, but the global counter is not
>>> incremented. Since the child also references zero pages, the global
>>> counter should be updated as well. Otherwise, during zero-page unmerge,
>>> both the global and per-process counters are decremented, causing the
>>> global counter to become inconsistent.
>>>
>>> To fix this, ksm_merging_pages and ksm_rmap_items are reset to 0
>>> during fork, and the global ksm_zero_pages counter is updated with the
>>> per-process ksm_zero_pages value inherited by the child. This ensures
>>> that KSM statistics remain accurate and reflect the activity of each
>>> process correctly.
>>>
>>> Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
>>
>> Linux-v5.19
>>
>>> Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each 
>>> process")
>>
>> Linux-v6.1
>>
>>> Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
>>
>> Linux-v6.10
>>
>>> cc: stable@vger.kernel.org # v6.6
>>
>> So how was Linux-v6.6 arrived at?
>
> e2942062e01d is in v6.6, not in v6.10 - I suspect that this is why the 
> "# v6.6"
> part was added.


Yes, e2942062e01d is in v6.6, which is why I mentioned that we need to 
backport it up to v6.6.


>
>> I think the most important use for Fixes: is to tell the -stable
>> maintainers which kernel version(s) we believe should receive the
>> patch.  So listing multiple Fixes: targets just causes confusion.
>
> Right - there's no way of communicating if all the commits listed in 
> multiple
> Fixes tags should exist in the tree, or any one of them, for the new 
> fix to be
> applicable.
>

