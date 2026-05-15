Return-Path: <stable+bounces-247400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNnyMau/BmqMnQIAu9opvQ
	(envelope-from <stable+bounces-247400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:39:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF654A0F8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 618803019476
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0714382F1F;
	Fri, 15 May 2026 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fY5KILLG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V2XkxaRQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DD33B951
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827176; cv=none; b=PR4KQJCDBMhs73ip+IkyIMwbYaoGC+ApG/bopmDkf845ONlDEKw6+doL5MUE9ShvzBPwgF4KKFdtuBCy4XCaK2fBN57Ua2SqhiJ92n/FElvfMU1XXICp/uDJwddQ6O49Unl4Vdek+zb0nKr3Zks1XmqtEU6xouZPJRtqskj+tQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827176; c=relaxed/simple;
	bh=UoKL1iVfccKojdCih8dTQdQ6c2I1ZzQDM2RG7usJpoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQyosdoJLElg7kaU4vfIgXmi7a/rOZoRuiGxyLY58b/dyaaJUifM/m0/bvWsemLlZkdTx0vYERg+JGJWhKAEHktE9IkDh/oiHNWmdH+DAupAL6uv4gX8Sxl5lliv57KYtrSkS/Dnw8cqrxxV9w+VIYg1cZq7SI2hrPLGmcUXi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fY5KILLG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V2XkxaRQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5Ei3i3795697
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JOLE131bcicG5PKOMByp2XiRYzJK1mHFyKZYnU5OtAY=; b=fY5KILLGfYghV3uj
	0i2tmUarTPnr3T73M2VXyN4diQy1+JbyorwKkbd/zeTM7ATeA0QOQqFfLxGHiLiu
	Dqp1dc97RSV4D+Y5OICmgGlUWWxPA4uCJaAcvuHN3myRv7emKQ8okJaXWDaV7aYx
	0ARpUeNZetORBVN1UKFm1ZFkyAt1wH9YHF6uA0UEWICJ7Ra9ZoewOtUG+u4au+WJ
	KW4mYff3/zv2fjXM9XJhLp0qkRbnAd0E1cCRlGwyxUotDXzX/rOox+qmx65zbf0j
	W8gjw0WFWYlZPSUliHXd3SOwkLWRUauKv857/RGqNaaEUed/y5cSzgueVoUTnRau
	RXg5RQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ssxae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:39:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2babbeff9e4so7255665ad.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778827173; x=1779431973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOLE131bcicG5PKOMByp2XiRYzJK1mHFyKZYnU5OtAY=;
        b=V2XkxaRQk1qa/ue4ogwOkNZUm4JK/h/0gmplwOG0sVFKNVdoUWy1q262z7EKwrtUft
         Cj3rQBfkWeXrK024/MFN3Txm17qNU3s3NOjOsx707BHNoQ4duPyYBTHkgg3ZhlgW+WlX
         yvsSP+DnSIsam2YxWmqIB7T8uE3iKOghRXTHiIo+pvXbWAte3BZVMX4rrF+U8pOYQgBX
         S5eFgbdYXnt5Rcz1BvFx1Rz0Jkiqw7D2C+URiN37Wn11SdNQn28/2S1JSPQ7xDQKGttb
         h1jfrZc70SWt3lky5+C1mCfvkO2UoVboodIq1L0FBTAVrkvHJQcvCOD29uGVwFVdFz8d
         mphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827173; x=1779431973;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOLE131bcicG5PKOMByp2XiRYzJK1mHFyKZYnU5OtAY=;
        b=sU9UkxPL0TbRxnWXIuIEqJXnVrhfCFOcbS+FX5vDW8UlRGvk2OwcTzQsCWru732X/P
         QzSTGA9ZObT+n2KP4qB1FlOvzoJIwqF5gjF+y5ogNJgvONFSZUM2miiQBig8SSTSQXhp
         0JZyQJs+LSUbNbEBVyHjGjXCyVDr1ToUX8CReTx/gDEwPjS0+Ypu6JktgPhbv3C39doD
         urQyWp9eHZIoyh9m6UryuYyivXGJDmc60WmLGhsROC6dpbZ4BMjirUbioIiDpdX0Zo06
         nQ5KiSD6fohNVTs1KBsBDBCC94YjqCFgtbKE07ko/7a0KJpYsF4BNTPs/qNcXgJ4HU+L
         TKsg==
X-Forwarded-Encrypted: i=1; AFNElJ/2U+VZBUgLUFzKQFZVWtKDR1Qwcrh7DNNge74rFj3D14fYmsR99bDuywwB9kNEwNHmxbVh25I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UpEm3pr16KjDdbTtLCOUlBjZaSH9w0bU/s6hFHTL0zGXFOsK
	XJJZhFZ01dkskdO82MwUU/4QPSu/GR6YkIjiXcp7GjhtmQ5bhcw9IC5EozcYEm8BcTwiQh4pOd7
	1oZbHiVI5OR0wbc1OOUuRoynqT7iRkwFfouPta3J9tNI4dQA45Po4Iz+4GoU=
X-Gm-Gg: Acq92OEFLTJfDjxiuP1CA3wpTJ9G8vkf2wkN4sdGz/fu0eAsgwB8Zoc8ioLcphG83TY
	fkhD/9jmsV4qyr+LphfxPxVfrX8GkvRVTt6eq849StnF803Eo+JNc26vKVSn9AAOztOYElSj1or
	6223/p1bhIQmlqlzgad9wE63PRKZGQ2dK9xxOwLKslashJiSdYYgOLNKPHu5ZlBjjTc3YlZ8UnE
	7YtwCf0JT5W2tuCE3x0VhCNYwHQ9XDU48ikeFXYN/nzP4+D6EImKXVOFG2A4zUtGV8TZuMbwsl4
	o6JtAqJuBT3Sgf0njepKzQ8M6gcYgebWqtSQiCQ3i9U/Qa6d6Jnx563op2dJg7B32IJx+GpD7Hf
	xD2xZRK6KuZyGlQAmvbQ36GvYfuUTgT2D1Q/Uo3Km/FaEQ24HQsJq8y08neo6viBCr37icQ6C5k
	7WIPkW+aLVvyDJM7rjoA==
X-Received: by 2002:a17:903:1aef:b0:2b4:64cf:e8f8 with SMTP id d9443c01a7336-2bd526ce672mr66930515ad.2.1778827173105;
        Thu, 14 May 2026 23:39:33 -0700 (PDT)
X-Received: by 2002:a17:903:1aef:b0:2b4:64cf:e8f8 with SMTP id d9443c01a7336-2bd526ce672mr66930195ad.2.1778827172576;
        Thu, 14 May 2026 23:39:32 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd60275sm44600585ad.7.2026.05.14.23.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 23:39:32 -0700 (PDT)
Message-ID: <5bb180ea-d970-4cf0-8d01-620cbdb7be9e@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:39:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <20260507070808.367442-1-jtornosm@redhat.com>
 <20260514061841.9517-1-jtornosm@redhat.com>
 <95bff017-3554-425f-ad8e-767f9cbe1277@oss.qualcomm.com>
 <c2523379-ab12-47e1-a0d0-ef6073deaf11@oss.qualcomm.com>
 <fdff6264-9c35-4c77-bab2-6db9125d77af@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fdff6264-9c35-4c77-bab2-6db9125d77af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA2NCBTYWx0ZWRfXzvmqO7hRMcpN
 xdDQlVHuLn1CtSNzBympCarGPtfUfCP3c1iuyWxoUGh9d0TCg8sTgJ1scPK4NeA7wFA3aEIk+yw
 Z6y5u7Zq1ex+oXTP1SYYK++eOpwWUlFKARMqJ69kVGF5k7NSEfOyEgsPKwtfmMDEX1o92fo9T8S
 1bEZVXfRR06oVr6ENeWxRC5AVxsIyXzjHaAs1YluDP0/a25j0kUL9NTn6xrG2VKDfwHcTVU5xJ8
 5tAa5aW8wyp+6wYJyFyK5idVZ3O9Osl0yOZa0HHpaQpr3t4hyF0ZIpf7AeshFD7aUF7QF6WVbD8
 Is1BWuW/7YkvvMcbQybdkkfesOD6e4zlHwQKojU1hIHW25Qd+NIq0XERtfKn7jJ9jU3MV61UOh+
 YQGaocQFkcjkbXprerjnoIdNJ6GSPWjfufFHUjmdMEzPCp81WFZVLbk53tlqD15KSRkQbdBSe7t
 tGdHNnKIrYeU9vZj6+w==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a06bfa6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=XMJksOS74nNapH2Mx7QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: tFT5Ty2U5NbJY4XLittfUIDk07uWP7Ve
X-Proofpoint-ORIG-GUID: tFT5Ty2U5NbJY4XLittfUIDk07uWP7Ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150064
X-Rspamd-Queue-Id: 3DAF654A0F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247400-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/15/2026 10:27 AM, Rameshkumar Sundaram wrote:
> On 5/14/2026 1:45 PM, Baochen Qiang wrote:
>>
>>
>> On 5/14/2026 2:55 PM, Rameshkumar Sundaram wrote:
>>> On 5/14/2026 11:48 AM, Jose Ignacio Tornos Martinez wrote:
>>>> Hello Rameshkumar,
>>>>
>>>>> I agree that setting tx_status to NULL makes ath11k_dp_free() more
>>>>> defensive, and it matches the ath12k fix.
>>>> Ok, I agree too.
>>>>
>>>>> However, i am still wondering how the second ath11k_dp_free() is reached
>>>>> if ATH11K_FLAG_QMI_FAIL is set.
>>>>>
>>>>> In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
>>>>> qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:
>>>>>
>>>>>       ath11k_pci_remove()
>>>>>         ath11k_core_deinit()
>>>>>           ath11k_core_soc_destroy()
>>>>>             ath11k_dp_free()
>>>>>
>>>>> should not run.
>>>>>
>>>>> So if the double free is still reproducible with QMI_FAIL set (with the
>>>>> change i proposed), either the flag is not actually set in this failure
>>>>> case, or there is another path calling ath11k_dp_free() ?
>>>> Let me try to clarify the issue more.
>>>> There are two error actions:
>>>> - First the previous error. I reproduce the situation as I commented: running
>>>> in a VM the default upstream kernel (with this card using PCI passthrough),
>>>> since this is always failing. Let me show the logs in this situation:
>>>> [   15.906564] ath11k_pci 0000:07:00.0: BAR 0 [mem 0xfdc00000-0xfddfffff 64bit]: assigned
>>>> [   15.926520] ath11k_pci 0000:07:00.0: MSI vectors: 32
>>>> [   15.928572] ath11k_pci 0000:07:00.0: wcn6855 hw2.0
>>>> [   16.984192] ath11k_pci 0000:07:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id
>>>> 0x400c0200
>>>> [   16.984351] ath11k_pci 0000:07:00.0: fw_version 0x11088c35 fw_build_timestamp
>>>> 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>>>> [   18.186971] ath11k_pci 0000:07:00.0: failed to receive control response completion,
>>>> polling..
>>>> [   19.211036] ath11k_pci 0000:07:00.0: Service connect timeout
>>>> [   19.211815] ath11k_pci 0000:07:00.0: failed to connect to HTT: -110
>>>> [   19.214181] ath11k_pci 0000:07:00.0: failed to start core: -110
>>>> [   19.531989] ath11k_pci 0000:07:00.0: firmware crashed: MHI_CB_EE_RDDM
>>>> [   19.532930] ath11k_pci 0000:07:00.0: ignore reset dev flags 0xc000
>>>> [   29.259157] ath11k_pci 0000:07:00.0: failed to wait wlan mode request (mode 4): -110
>>>> [   29.259229] ath11k_pci 0000:07:00.0: qmi failed to send wlan mode off: -110
>>>> - Second after this, I commanded the unbinded (ath11_pci) and I get the
>>>> warning. Let extend here the stack trace:
>>>> [   24.238198]  ? free_large_kmalloc+0x57/0x90
>>>> [   24.238199]  ? report_bug+0x16b/0x180
>>>> [   24.238210]  ? handle_bug+0x3c/0x70
>>>> [   24.238218]  ? exc_invalid_op+0x14/0x70
>>>> [   24.238218]  ? asm_exc_invalid_op+0x16/0x20
>>>> [   24.238224]  ? free_large_kmalloc+0x57/0x90
>>>> [   24.238227]  ath11k_dp_free+0x99/0xb0 [ath11k]
>>>> [   24.238275]  ath11k_core_deinit+0x12b/0x1a0 [ath11k]
>>>> [   24.238287]  ath11k_pci_remove+0x7b/0x120 [ath11k_pci]
>>>> [   24.238294]  pci_device_remove+0x3e/0xb0
>>>> [   24.238304]  device_release_driver_internal+0x193/0x200
>>>> [   24.238315]  unbind_store+0x9d/0xb0
>>>> [   24.238320]  kernfs_fop_write_iter+0x13a/0x1d0
>>>> [   24.238330]  vfs_write+0x32e/0x470
>>>> [   24.238335]  ksys_write+0x5f/0xe0
>>>> [   24.238336]  do_syscall_64+0x5f/0xe0
>>>> Very easy to reproduce.
>>>>
>>>
>>>
>>> Thanks much for the logs, that makes sense. The timestamps explain why my earlier
>>> reasoning did not match the trace: unbind reaches ath11k_pci_remove() before
>>> ATH11K_FLAG_QMI_FAIL is set by the QMI event worker as it is held up on wlan mode off qmi
>>
>> how could QMI worker set this flag? the first failure happens in
>> ath12k_core_qmi_firmware_ready() and upon this failure the QMI worker just break out
>> without setting any flag, no?
>>
> 
> 
> you mean ath1*1*k_core_qmi_firmware_ready() ?. Yes in ToT it breaks out without setting
> any flags, so I proposed to set that on failure case ATH11K_QMI_EVENT_FW_READY: (similar
> to case ATH11K_QMI_EVENT_FW_INIT_DONE:) in this mail thread.

Hmm, I mixed it with ath12k. You are right, for ATH11K_QMI_EVENT_FW_INIT_DONE, the
ATH11K_FLAG_QMI_FAIL is set upon failure.

> 
> 
> -- 
> Ramesh


