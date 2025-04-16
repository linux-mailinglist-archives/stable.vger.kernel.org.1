Return-Path: <stable+bounces-132830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDAA8B228
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F63190511E
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 07:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3C418C03F;
	Wed, 16 Apr 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3g3f6Ia"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E551B6CEF
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788678; cv=none; b=HuUrwdqKjblikbrIrrDZJbT94a9fC24VGmrlF0ZzMTWIgF+wnHBPkUC9srDdaxs+hQo7chcoxEXSK5BETaKHskeT/Gh1H7c90r3sllClXKFHuJAxF8d2laAkKKWvaXR7jCtk3lbPrQLNHQnPm/FF8vIZS318mC5YZFs2QXHE+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788678; c=relaxed/simple;
	bh=52tobB9aVR3Qsia5hFyH/RC5H9SHG3yCX/cPEM3UW84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PO9V4lOb0k0BKaB4UaFlvsW/kCRu5U/ly55+bWSyi8tvirmcpnHtWHD1Y54WAR6X+BrlMqev3W7HfbUEs+MuzVJWuwQ8Cdr4p6oGEiN/wh6qwfrXzFbVud2Cby60996U/9Ri9O/xaC6g7/QjPME8AbJanm/27TRh69+oK2tGDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3g3f6Ia; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G7JPTg002366
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 07:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2w89vGpkfTEaljX2/r8/RTQfbplPGmagWgiqCDEol00=; b=i3g3f6Ia+TrArJ7S
	z3y3sibx8dorZJ3Ywglctq7o1q8wltOu6au/8ZnawazYSoVChwOPI3/eXdwkH5xT
	J4Q/5xkq45H8ZllN3M8xAUKLrDhUqaArYfq1JwKwaha36EnuVS0gP4yKqAcWfXky
	Y8DKIRjyDJlBEGJT+644+ylLNFgqL1e/YJ3cpMHaHqhUCM7zH88VQuQR490vTPIp
	35e6V8jUTERq554T6fj+v9W5EevASpdQJkI+SZebqQuJB7yQtioExqIPKpB11tob
	foNbnRwwE9wsgIHxeIaJuY3O15SCKbB2GAvwlRnp2Vx919XFD2M6QkPw96KI0i4P
	G/TvJQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbptgsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 07:31:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af423fb4f0eso4033820a12.0
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 00:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744788675; x=1745393475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2w89vGpkfTEaljX2/r8/RTQfbplPGmagWgiqCDEol00=;
        b=nbJv41he4lsSLrW/06/6xoSXfmifX2EsJKGyk+AozpiDJzUKH73KVuG02o4ApsyorP
         dpZBb2ulBrP6Y3zpNATN2lj8LZB+k3qnoo70hgTkqjS9GI+/ZoW4UCrybpb0MwrxZUKL
         JDwTiwLfQkvAPPNg5/ujIlN3ChxCcApXTISh77lZvQtKXWHW1uS76aRwVTuf6j/ILxRM
         QBX7PmRHnRnuQL03RbVaCcQ+lavj10EdwJ2mn21H6eFQDU3x6eT6hHanDHJzEL9Env7v
         zzu8zL2SjL5qt99N0ERbvbWmKPZ6OTEUcvW5UupdWcsn82cFWtaQ9WkHJIV3bdKHeA7N
         NgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgEK2Og9RxHHkiyGPYGvRXI7XrGzNgWD41/JkSxwjTH5+sGEXIsUjvUzD0J7MzWJP/QCq/5Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwijeLsUqAnHiYSpVosfirCVjiJytz1D2yZTsy29JG6s/zRD3MX
	JhvtOLU2u2HTnUjN3jxa9lEYoTDBeCfqGakqu92te3DMBuS9JrQjLnfe9ZFkURw1dP/EDa8gJF7
	6QBFWRCrar3pf3IHnoOqmN2wsWZn9Tr6WoTkW3zSVbRycj8Uf/pVP57Q=
X-Gm-Gg: ASbGncsf/P2v2SggcLvSZkTlXbJMcz/TAa1MYyV3OVsas9O+k1MZqNjPJJM0GF0gS/l
	o7myQIP5IIapd8h7MFYkHaSU+eq3Fs7tEzvzHZSsGIUSCX8rydFXDjG8EHghruBAhLlqKGaV8A6
	HunfYdN5tSqH6N+6PSbWCBnCXKz5LY50vAtazPq95j0dapAPlJyVDV3ka9AiAWS4tQtYpZdXFS6
	6BzMq8y4sbQtvxVHkR+qZfzjJGjEvEapj6Ceak7zhq+4iqq7xk6vSemeyHeff+1dpg4Oa2LV6Sn
	JQdYlnXB0rfmEfD4KK008wuJu070U3WbDAUrtmctIEK8kSZ6Jyw6EYmq9bvV0zCkt+xrd2OpefU
	=
X-Received: by 2002:a17:903:8c5:b0:224:2201:84da with SMTP id d9443c01a7336-22c358bfac3mr11304535ad.6.1744788674956;
        Wed, 16 Apr 2025 00:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDuibO2JKTCT3Kz4ZJmNuPGdoj9ujKAJsdhPJYkAl5Fe3ro1Bmm2ILzr9fr30xpZSFqRyeew==
X-Received: by 2002:a17:903:8c5:b0:224:2201:84da with SMTP id d9443c01a7336-22c358bfac3mr11304235ad.6.1744788674524;
        Wed, 16 Apr 2025 00:31:14 -0700 (PDT)
Received: from [10.133.33.156] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc93f1sm7334045ad.192.2025.04.16.00.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 00:31:14 -0700 (PDT)
Message-ID: <4c5f9d38-ae5d-4599-bd9d-785f6eff48f9@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 15:31:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 084/731] wifi: ath11k: update channel list in reg
 notifier instead reg worker
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev, Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sasha Levin
 <sashal@kernel.org>, Jilao He <jilao@qti.qualcomm.com>,
        quic_bqiang@quicinc.com
References: <20250408104914.247897328@linuxfoundation.org>
 <20250408104916.224926328@linuxfoundation.org>
 <5cd9db3f-4abf-4b66-b401-633508e905ac@kernel.org>
 <49b98882-6a69-48b8-af0c-01f78373d0ef@quicinc.com>
Content-Language: en-US
In-Reply-To: <49b98882-6a69-48b8-af0c-01f78373d0ef@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gXgJ9TUy7QZP0tikhCqd3Ockr4UHaoSh
X-Proofpoint-GUID: gXgJ9TUy7QZP0tikhCqd3Ockr4UHaoSh
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=67ff5cc3 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=R9OM0nUHbm-oojPVeEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160059


On 4/15/2025 10:55 AM, Kang Yang wrote:
>
>
> On 4/14/2025 1:59 PM, Jiri Slaby wrote:
>> On 08. 04. 25, 12:39, Greg Kroah-Hartman wrote:
>>> 6.14-stable review patch.  If anyone has any objections, please let 
>>> me know.
>>>
>>> ------------------
>>>
>>> From: Wen Gong <quic_wgong@quicinc.com>
>>>
>>> [ Upstream commit 933ab187e679e6fbdeea1835ae39efcc59c022d2 ]
>>>
>>> Currently when ath11k gets a new channel list, it will be processed
>>> according to the following steps:
>>> 1. update new channel list to cfg80211 and queue reg_work.
>>> 2. cfg80211 handles new channel list during reg_work.
>>> 3. update cfg80211's handled channel list to firmware by
>>> ath11k_reg_update_chan_list().
>>>
>>> But ath11k will immediately execute step 3 after reg_work is just
>>> queued. Since step 2 is asynchronous, cfg80211 may not have completed
>>> handling the new channel list, which may leading to an out-of-bounds
>>> write error:
>>> BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
>>> Call Trace:
>>>      ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
>>>      kfree+0x109/0x3a0
>>>      ath11k_regd_update+0x1cf/0x350 [ath11k]
>>>      ath11k_regd_update_work+0x14/0x20 [ath11k]
>>>      process_one_work+0xe35/0x14c0
>>>
>>> Should ensure step 2 is completely done before executing step 3. Thus
>>> Wen raised patch[1]. When flag NL80211_REGDOM_SET_BY_DRIVER is set,
>>> cfg80211 will notify ath11k after step 2 is done.
>>>
>>> So enable the flag NL80211_REGDOM_SET_BY_DRIVER then cfg80211 will
>>> notify ath11k after step 2 is done. At this time, there will be no
>>> KASAN bug during the execution of the step 3.
>>>
>>> [1] https://patchwork.kernel.org/project/linux-wireless/ 
>>> patch/20230201065313.27203-1-quic_wgong@quicinc.com/
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125- 
>>> QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>
>>> Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory 
>>> update in ath11k_regd_update()")
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>> Reviewed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
>>> Link: https://patch.msgid.link/20250117061737.1921-2- 
>>> quic_kangyang@quicinc.com
>>> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/reg.c | 22 +++++++++++++++-------
>>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/ 
>>> wireless/ath/ath11k/reg.c
>>> index b0f289784dd3a..7bfe47ad62a07 100644
>>> --- a/drivers/net/wireless/ath/ath11k/reg.c
>>> +++ b/drivers/net/wireless/ath/ath11k/reg.c
>>> @@ -1,7 +1,7 @@
>>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>>   /*
>>>    * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>>    */
>>>   #include <linux/rtnetlink.h>
>>> @@ -55,6 +55,19 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct 
>>> regulatory_request *request)
>>>       ath11k_dbg(ar->ab, ATH11K_DBG_REG,
>>>              "Regulatory Notification received for %s\n", 
>>> wiphy_name(wiphy));
>>> +    if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
>>> +        ath11k_dbg(ar->ab, ATH11K_DBG_REG,
>>> +               "driver initiated regd update\n");
>>> +        if (ar->state != ATH11K_STATE_ON)
>>> +            return;
>>> +
>>> +        ret = ath11k_reg_update_chan_list(ar, true);
>>> +        if (ret)
>>> +            ath11k_warn(ar->ab, "failed to update channel list: 
>>> %d\n", ret);
>>> +
>>> +        return;
>>> +    }
>>
>> I suspect this causes stalls for me.
>>
>> Workqueues are waiting for rtnl_lock:
>>> Showing busy workqueues and worker pools:
>>> workqueue events_unbound: flags=0x2
>>>   pwq 64: cpus=0-15 flags=0x4 nice=0 active=1 refcnt=2
>>>     in-flight: 107692:linkwatch_event
>>> workqueue netns: flags=0x6000a
>>>   pwq 64: cpus=0-15 flags=0x4 nice=0 active=1 refcnt=18
>>>     in-flight: 107676:cleanup_net workqueue pm: flags=0x4
>>>   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=5 refcnt=6
>>>     in-flight: 107843:pm_runtime_work ,100179:pm_runtime_work 
>>> ,50846:pm_runtime_work ,107845:pm_runtime_work ,107652:pm_runtime_work
>>> workqueue ipv6_addrconf: flags=0x6000a
>>>   pwq 64: cpus=0-15 flags=0x4 nice=0 active=1 refcnt=18
>>>     in-flight: 107705:addrconf_dad_work
>>
>> While the above reg_notifier is stuck too:
>>
>>  > workqueue events: flags=0x0
>>  >   pwq 14: cpus=3 node=0 flags=0x0 nice=0 active=1 refcnt=2
>>  >     in-flight: 107807:reg_todo [cfg80211]
>>
>> waiting for:
>>> Workqueue: events reg_todo [cfg80211]
>>> Call Trace:
>>>  <TASK>
>>>  __schedule+0x437/0x1470
>>>  schedule+0x27/0xf0
>>>  schedule_timeout+0x73/0xe0
>>>  __wait_for_common+0x8e/0x1c0
>>>  ath11k_reg_update_chan_list+0x23c/0x290 [ath11k 
>>> 30c4a145118dc3331f552d6275ec7d6272671444]
>>>  ath11k_reg_notifier+0x5a/0x80 [ath11k 
>>> 30c4a145118dc3331f552d6275ec7d6272671444]
>>>  reg_process_self_managed_hint+0x170/0x1b0 [cfg80211 
>>> 2571f504aa68d55c11440c869062c668de1a2dce]
>>>  reg_process_self_managed_hints+0x47/0xf0 [cfg80211 
>>> 2571f504aa68d55c11440c869062c668de1a2dce]
>>>  reg_todo+0x207/0x290 [cfg80211 
>>> 2571f504aa68d55c11440c869062c668de1a2dce]
>>>  process_one_work+0x17b/0x330
>>>  worker_thread+0x2ce/0x3f0
>>
>>
>> Is stable missing some backport or is this a problem in 6.15-rc too?
>>
>> /me looking...
>>
>> Ah, what about:
>> commit 02aae8e2f957adc1b15b6b8055316f8a154ac3f5
>> Author: Wen Gong <quic_wgong@quicinc.com>
>> Date:   Fri Jan 17 14:17:37 2025 +0800
>>
>>      wifi: ath11k: update channel list in worker when wait flag is set
>>
>> ?
>
>
> Yes, please add this patch. It will minimize the occupation time of 
> rtnl_lock.
>
> You can retry and check if this warning will show again.
>
>

Hi, Jiri, Greg:

     Have you added this patch and verified it?

     May i know when this patch will be merged into 6.14 if everything 
is OK?



>
>>
>> thanks,
>

