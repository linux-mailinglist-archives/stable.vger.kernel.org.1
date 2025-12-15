Return-Path: <stable+bounces-201017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A51CBD38D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B66333009B4E
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE07329E7B;
	Mon, 15 Dec 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jeplvTGJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ddHFp3GO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA426B098
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791719; cv=none; b=QAUzdezvuHupfN5bGyVsG/NP2jktvYijeTFLdGnGEOQR8H6EHgpno1Nl2FcJNkABbaw+QoCM2VwSmmvyqZjs+f6pV4W9R1eVunYOXBjKJ+Sep5ju3hYvaqyScNLLvbufHuARkIK7BOeHTN4GFLa/2v9UfyAQRfCG2xFqAXHvKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791719; c=relaxed/simple;
	bh=Nj8GPZ6uoKw+x7i1doLqsnYHK38xhiQXxy5O3+30Z0A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XU2y/z2jf6QtnJCzwOH11wYpYHiPuStJCXmnJHBXFhoBXLBS6NB8zCsoZfAmfI5o1LAZby5i5Hj91J6uYTG7K56klyVna92vXTb1d1P+ntZiHFnPY5XQrSvBlqkFXjQMs22tnUvyf+uZ7e8lHke99G7W6IBr30Y1RMIujnwe5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jeplvTGJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ddHFp3GO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF96Kb73102798
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OGnfak5uOuqAZte6zQqK9T5NfG9mhJT79UnM6uJ7jSM=; b=jeplvTGJi8L2vsXO
	yIgP7ylxwHFy117mR6PNhlTI2MS3S1TTngN393FSj1PgmbH91k25ZW53ZwOZe8VL
	6LtcQZ9eKgqcvv181dOEdOxHcCSer8al4YeLJO8R7CgzbeB+gd6XS/yzBU/DhJo0
	F97Ek61Psp4ESATu6qL8hgycVsyudLPHPf7Bfd5Ahq/RX5rVFQ5Kcvn4noPrFABs
	yEZBcjuXg7RgewW+EXvtevHPLz8cEib6yOo/9bc4/68ECYVlvRlUvHY9YDBtSKos
	l/CLs5wQLITw7W6nhR/Qv75SYCQjOggN1NWLnB3/FWw4JA7XjTn1G72R5hCk5Les
	00pEjw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b119am19a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 09:41:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1d2aa793fso69737761cf.3
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 01:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765791716; x=1766396516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OGnfak5uOuqAZte6zQqK9T5NfG9mhJT79UnM6uJ7jSM=;
        b=ddHFp3GOJUk9rV9pjAdnMoWn2x6WZTgbCySTpOXyZYAwoouy5gtHXF5WkpgahuM777
         8SZ5BNHKLZNi6XXJRtRnhdWXWnvynT0doFD8e6I8RO3Xqtez0V5zB2EXLs3IU0pi/N7C
         NpsURnLGA1ok5gRTuy5GylKdgnFXx+zvn7Sd9rPUQDuvZJJ+FjyAsyrRgQW1DaJ1uzfC
         9xxMnLEmoNL3OjKwwvK/Wbr2JbqSfK5bhGQdvTPqoQ5PXcPjfy8p5UpyJewT3WslWtMP
         cIcZ62hVKOCmYEhSaO/nrU4t5cWufzikIfcK78fyYnAhyGCRfzAMGWf8J4LwK2F0ngcK
         gpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765791716; x=1766396516;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGnfak5uOuqAZte6zQqK9T5NfG9mhJT79UnM6uJ7jSM=;
        b=fDNQaOPdpz/xan0XCxB6SAS370YdytTnVzDTZbwF1OPR98SwkSdnEKFuQDX+Whlek2
         7Oit972+7MA39a9IMHviaj5NqIPg2aDodBgWdwBeZwEMkVii9XOOKTdwRWuNPSGvn1NB
         rWoCYhTBCUCZjQuDRTNFKkBe8ZbYYhOYl+cfFcIS/7QXaRThNNJOUy2Cd4SbHSZycIR9
         4KC2X5TiBmOJCFirf+93KxrhxngmIEgt6GZf/IV1FNxckym7pNqyeiMwSAjfgxVQCwB6
         Ru7cDoJvv+OhmCOiK6PG6BkSJ9HDr/jjHiccj5ilXpe2ZJ0xrIlmqDpmeXkl24m21YAC
         GXMA==
X-Gm-Message-State: AOJu0YxoSJhPJbdoOSCHb+EDvuAhCXqDEOhIFB9IWmnfLB1PpKXSqcdY
	Z+s/ZE581i/YzOH+ZXl3J45Mq1px1QmqgpUsH2xuYnZbjOFsvb3X775CoJozDdKg0St5qSynsYu
	7Pd6FG+4GABQvayhig7RH+tnDWLEMS3uAlHV7vch648C+mnL3rn5I+4Xn+ew=
X-Gm-Gg: AY/fxX7LiQ03hmSHVmopxc0ofmwVj44pKsMtf4VeHsNMP+ecS70djjggPFtJBH1V9NL
	4E2RQF+QjBOgA/yjEa9znRKKkCxgeUT//MJwimKxQMlJzfZri8+/ri30P3lwMoUoItHvYFgl7WJ
	mcrmwDYR+MaHTgZDjCK58/KTAbt9qH+3lDee/0nWYyYvRoTC1XmBosJBsp2btxa6sqOpRSezy1n
	YvIbeY+YanwVbRhMwB0wlqEqDzMT4eNH4Ctj24c0byYIAIk+rOVJj6UZxixk00Jp9D2PsIP0sPG
	9qfAfzfQ5RaRlLLLXJn2ErRrpSthNfiLcMpl31YhnUWRHJP5+GSvSqQQccG48nv+cjY1JZalLkN
	MESdadr3Cjc83Y9kodSpMWRiQZs+u
X-Received: by 2002:a05:622a:14d3:b0:4ed:142:ed5d with SMTP id d75a77b69052e-4f1d059d45dmr131821701cf.50.1765791715926;
        Mon, 15 Dec 2025 01:41:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8+eWYtKNF9zdpDcKlGS//TTmKKK6wKOKcVcXfqVgpnoaNFfj7ADT7jdoLvMyn4NVswwhVSQ==
X-Received: by 2002:a05:622a:14d3:b0:4ed:142:ed5d with SMTP id d75a77b69052e-4f1d059d45dmr131821581cf.50.1765791715459;
        Mon, 15 Dec 2025 01:41:55 -0800 (PST)
Received: from [10.40.99.10] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ed80dsm1350625366b.16.2025.12.15.01.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 01:41:54 -0800 (PST)
Message-ID: <0f92d42d-5df8-423b-82a4-7fa9342d69ef@oss.qualcomm.com>
Date: Mon, 15 Dec 2025 10:41:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
 <2025121502-amenity-ragged-720c@gregkh>
 <b78aadb1-d2ca-459c-8078-b1cd9a500398@oss.qualcomm.com>
 <2025121500-portside-coleslaw-915b@gregkh>
Content-Language: en-US, nl
In-Reply-To: <2025121500-portside-coleslaw-915b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA4MiBTYWx0ZWRfX6iU4hTEI+jrj
 wxVr/tniE0nIAX+vL4XuxXaNG5Dg/ZBD4zV9kFU8nr54shEcuRHjB0TqTk6XCAW/M12A29b/KKv
 0AvNmwHyQwuJAfVFTLCCSYj3SBvhzvmwqDD6TbQ3LylDVD/xoFxXPlFL3ttNLA1F1zu6CQU0enF
 eghXnYjH9AWAVcfMFTjwrTD73I2Zy8Lu6EDomGhcFSGolNTqwSeOO+HiuRA8UpDBqjJkwvPMIGD
 AKtqJ3lDd3G/5HCCOpisLGkYFOoWIKqbJ1PAUoOEwzNlxt56p7xY+PebQhFObz9QmtmpWHwXCL8
 CULAS2rxmRgruAJazksY4XMYozGLBFxfb4uOAPyVtNVp6ymkisMOwTuYuvb3ejNzFgwZeKbtAco
 O3rWMPeFvJQfEQkdgy0sr1o2FrTEjg==
X-Authority-Analysis: v=2.4 cv=LNFrgZW9 c=1 sm=1 tr=0 ts=693fd7e4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=e872BdUrp-yoDkOv7gMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 8Wmvo2fIj3f-f8-wylpqe6qvseeyliJ6
X-Proofpoint-ORIG-GUID: 8Wmvo2fIj3f-f8-wylpqe6qvseeyliJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150082

Hi Greg,

On 15-Dec-25 10:05 AM, Greg KH wrote:
> On Mon, Dec 15, 2025 at 09:15:17AM +0100, Hans de Goede wrote:
>> Hi greg,
>>
>> On 15-Dec-25 9:12 AM, Greg KH wrote:
>>> On Sun, Dec 14, 2025 at 10:53:36AM +0100, Hans de Goede wrote:
>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.
>>>>
>>>> SI hardware doesn't support pasids, user mode queues, or
>>>> KIQ/MES so there is no need for this.  Doing so results in
>>>> a segfault as these callbacks are non-existent for SI.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
>>>> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
>>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> What kernel tree(s) should this go to?
>>
>> This fixes a regression introduced in at least 6.17.y (6.17.11)
>> and 6.18.y (6.18.1). So it should at least go to those branches.
> 
> But that commit is in 6.19-rc1, not anything older.
> 
>> If any other branches also have gotten commit f3854e04b708
>> backported then those should get this too.
> 
> I don't see that commit in any stable tree, what am I missing?

Ah, I see now the Fixes tag in the original fix (which I cherry
picked) is wrong and does not point to the canonical commit id as
merged into Torvalds tree, sorry.

This is b4a7f4e7ad2b120a94f3111f92a11520052c762d  ("drm/amdgpu:
attach tlb fence to the PTs update") in Torvalds' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4a7f4e7ad2b120a94f3111f92a11520052c762d

and this actually made it into the v6.18 tag (vs being introduced
in 6.18.1 as I originally thought).

This is also in 6.17.11 as 23316ed02c228b52f871050f98a155f3d566c450

https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/gpu/drm/amd?h=linux-6.17.y&id=23316ed02c228b52f871050f98a155f3d566c450

FWIW I don't see it in 6.12.y (and I did not look further back).

Regards,

Hans


