Return-Path: <stable+bounces-247314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KtIGauEBmr0kQIAu9opvQ
	(envelope-from <stable+bounces-247314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:27:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09318548B8F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BFF3302E3AD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B43BAD99;
	Fri, 15 May 2026 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HVpdbuqq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EqbZfbVp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F473B9DBA
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812069; cv=none; b=FHPWn1vdJTRR/w1M3buhB/SOgUv5PYZtRhVMhb3aVJ+1vm6fJjrA77iv26QMHwWDzTtn3kSGZqyVfGvqN+u6AyoXJQBHn1ZtFDdcMujnS5jyaqLdQ6C45/ok3/cPscFCDMS44PvXSoUK70gi9f12qa5uzrECm7GGjxEt3TE0KGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812069; c=relaxed/simple;
	bh=ZGLrgcKzSMYLUuc3NYqgkyKk39yYXLvWcx1OoQhBENY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWfGy+huc2l9bcGJbcEdu3W27HiQ7+tTO4z2/vDuvoo/Ai6aZt9ZAxAavcPLsW6h5VstlC2uB3EoHqC56EBPowVi0g0byZj5QxMU3nqkBhLCgB9xDaw+5zPSI9FXEFFXIPbYOqT/L9l/SAdvhr2l3KB4wpt/bgn6xbk+7HF3oXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HVpdbuqq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EqbZfbVp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIq6ND3672547
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GG4jPt4PsiOv78ZDySQX+4PT9DNiaDGHP2Yb7bOsOys=; b=HVpdbuqq6AIg0+Cc
	DdYjfeJU5dVxaT1HZfXj+0xOOuRgc2blLDzJNnE7u0XVk/RQuaHS7xdBoqJTf1fY
	DTNL4n6bCIjaWpeP12UmoI9Ik44nf+JhXkRGp5MpoPHfYlXkFQyOsiuKGFUCnOC/
	seQroQ68j4hP9+Ze4idscchpY9iIJt5Zi4O9JP0mS4et9EPj5Er4x0kK+dMksAZd
	9xXR22Zp8ZKG2YdjVT8xEnruzKvO0GpnakQUL7iswRaNkIhAGApfvC+7iX49a4js
	YAYG9YrCKUvFcU/oA7K45eSdM1UJI0byXliZC/qTsJ6Ch5s9rq59AGHhED5iDYd4
	da2rZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s16v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 02:27:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b458add85aso91218425ad.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 19:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778812066; x=1779416866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GG4jPt4PsiOv78ZDySQX+4PT9DNiaDGHP2Yb7bOsOys=;
        b=EqbZfbVp42ycigYxUdgsKgTxMLQzId63tvDQmcG8ihZ532eDsAhBl+VHxGb2bTezXh
         fvoMQMvOZ/2ulF0AdKXPBDKlfuHdfztSZZtN9IiZ5/EpQEulja2XNCRNwkzZI0Pz85Q7
         MWeYoC3kBfDs3309q3SFvkev+b5v1nr9HLMx5tnueIWkEwO5vTw9lFwCG2qI1HcJ1JBC
         6VlJfO11DO6sO4wZfDx5E2L3ZMpGnikKojfkAoNYpzmn0/B43pRK4HcwYrZ060qznRAD
         u0pbqfJE6MXbzbjq0hCf00pntJiWphQfsFEEl8KCT+cS95OmwSKIosB6W/hdgg5XbTT5
         u6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812066; x=1779416866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GG4jPt4PsiOv78ZDySQX+4PT9DNiaDGHP2Yb7bOsOys=;
        b=Q/ONcU24rSWus+x5PvNpNnzquWZaGKwWaq7gnmOtovLI8NmD8+3WwSxr+Gr0io/tf3
         fEEIfg75FN0tsJ8g/ZJgTtMqe52+uMhN7eVJ+il5UoVW6Q7IrHDBDF/wq0v6zBpwdApQ
         10Ja16iPLy4YKNFNH8KSHZcQqN/RDL4jc834oAO7Egfxb+Lj2TI+DrzFWCS36k+SHVqL
         gCIzRQjrs4eY9xZGY4pZFTjf8Qh7o3orjCBPQXSUoxBy3JUiOzrzKKhM5C9l7edKcfpL
         Xlo4BCrtU5ySgQAq8pDX0/nSfi8j2Q1eSLMg2P9zX9ytQIlYj6upr+5ZuSqEQ0hBhyIF
         ri0g==
X-Forwarded-Encrypted: i=1; AFNElJ+2L9sSqUFSDv+tZKm/vr1G9PP9CHD7ZcmVBrKaBUf5dMWjM0rN6xdyrEG2nRXZKeMjXbKjB00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8XMFNNahyLzFj9w6roaxCoVB2N2NdhvbxqWY8wxaF6k5X9NN
	vbh73Z9xa7xcp8TDTL39cTMRkgoRO9r7r7gC/ElqR5W/F4eHbTLIupG0bOqmPGLUm/S42aMaO5f
	ia2Wg+hWjMu27Qj8Vr6zqbdwmltVaCUjm7/r5DQBvsOIyQHfIqO//1AgbbxQ=
X-Gm-Gg: Acq92OHuQXlLOSdp0Dd825hjUvoEvjXgdOYEC4MxUOlAnk/QaGwDnjZMUJjuNEck11k
	u7y7dJrJT65pPQYJDppJVr7EQ7GXtQbE4SX4p1ZNdbMCKKrRg3qRGEE7Z+E30pAoh6vQMD5pqwt
	taiGE5yUYXIBwoMMxgMah6zs2Ekf+hpjNQZYAz77/4vIDpjhCMQ9YDp1XCsSO9udps6VQz1v8TW
	jWVQ/VDCq07WVZMLJXqUN5KGamiAP8YVvhTMYN9STLkXLDPTAkn0MOFSdETRSORGpfKnnoupG4e
	D6eVVRNYt4olkb5+9VlogbDVNyza1ugi1QFlPlH0aAynmitslaa+RVftZgIK5j+yDjNqxu66wRV
	32n4BfSYpDbOLBtl0tFP4B6HxypGsZbVDa0MAlRzpeDZ+SvmFEiRZaHLL8EX8J3E+dYar
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id d9443c01a7336-2bd7e9e263emr21145095ad.40.1778812066415;
        Thu, 14 May 2026 19:27:46 -0700 (PDT)
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id d9443c01a7336-2bd7e9e263emr21144885ad.40.1778812065866;
        Thu, 14 May 2026 19:27:45 -0700 (PDT)
Received: from [192.168.58.30] ([152.57.206.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fe44sm41884845ad.11.2026.05.14.19.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 19:27:45 -0700 (PDT)
Message-ID: <fdff6264-9c35-4c77-bab2-6db9125d77af@oss.qualcomm.com>
Date: Fri, 15 May 2026 07:57:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: ath11k@lists.infradead.org, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org
References: <20260507070808.367442-1-jtornosm@redhat.com>
 <20260514061841.9517-1-jtornosm@redhat.com>
 <95bff017-3554-425f-ad8e-767f9cbe1277@oss.qualcomm.com>
 <c2523379-ab12-47e1-a0d0-ef6073deaf11@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <c2523379-ab12-47e1-a0d0-ef6073deaf11@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAyMiBTYWx0ZWRfX8XoEjv+d+ES5
 RWqKqs3xjtMJFmAE2VH0cY7bf5cET65loAH6+qXLjp+zOmJJaOGdJH+VCmYtWpPDb8GC7WD6uCi
 BVwqvxX6qZh8Oby7cp/h9+oIgCxM/wR+9pCVFE6CSoPeLMyIo07dVRYGfM5MslN8BCp2vr5k1WN
 6lWKRTse7qslcmjw9law8voq8x09pEpZ0cDhy0AG0i0o9wPetFhKVkg5/eJjo4q1LIVTl917Vws
 YH56wWrKAe54nutXd14EF11OdLvuSdDfeLj9M24kSStRIYhCWEBfuZCEf9D9jB9AMEDwf45TVG1
 QovYvHnGSkmXAw6evS4g461PHhGs3UbrPQElq20TvAVagNuhncjJz9PIhTehodd+aphx7weut57
 kXVIxMXyiP0yWLnP8X6+iSK1qpf6+r5FxDWYLFrXG8P88Stidk9LsgjS8MuzSde0yiUP39iJ50N
 E+1D7/dOvr45ujToPfQ==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a0684a3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=YxPPAu78v9FaI4eag4rAcQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=eGHVyj3czf8DJk7V1mEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: VGPvcMdngY7zLVE_Qj6Zho_jErf_grFa
X-Proofpoint-ORIG-GUID: VGPvcMdngY7zLVE_Qj6Zho_jErf_grFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150022
X-Rspamd-Queue-Id: 09318548B8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247314-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/14/2026 1:45 PM, Baochen Qiang wrote:
> 
> 
> On 5/14/2026 2:55 PM, Rameshkumar Sundaram wrote:
>> On 5/14/2026 11:48 AM, Jose Ignacio Tornos Martinez wrote:
>>> Hello Rameshkumar,
>>>
>>>> I agree that setting tx_status to NULL makes ath11k_dp_free() more
>>>> defensive, and it matches the ath12k fix.
>>> Ok, I agree too.
>>>
>>>> However, i am still wondering how the second ath11k_dp_free() is reached
>>>> if ATH11K_FLAG_QMI_FAIL is set.
>>>>
>>>> In ath11k_pci_remove(), when ATH11K_FLAG_QMI_FAIL is set, we take the
>>>> qmi_fail path and skip ath11k_core_deinit(). So the normal remove path:
>>>>
>>>>       ath11k_pci_remove()
>>>>         ath11k_core_deinit()
>>>>           ath11k_core_soc_destroy()
>>>>             ath11k_dp_free()
>>>>
>>>> should not run.
>>>>
>>>> So if the double free is still reproducible with QMI_FAIL set (with the
>>>> change i proposed), either the flag is not actually set in this failure
>>>> case, or there is another path calling ath11k_dp_free() ?
>>> Let me try to clarify the issue more.
>>> There are two error actions:
>>> - First the previous error. I reproduce the situation as I commented: running
>>> in a VM the default upstream kernel (with this card using PCI passthrough),
>>> since this is always failing. Let me show the logs in this situation:
>>> [   15.906564] ath11k_pci 0000:07:00.0: BAR 0 [mem 0xfdc00000-0xfddfffff 64bit]: assigned
>>> [   15.926520] ath11k_pci 0000:07:00.0: MSI vectors: 32
>>> [   15.928572] ath11k_pci 0000:07:00.0: wcn6855 hw2.0
>>> [   16.984192] ath11k_pci 0000:07:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id
>>> 0x400c0200
>>> [   16.984351] ath11k_pci 0000:07:00.0: fw_version 0x11088c35 fw_build_timestamp
>>> 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>>> [   18.186971] ath11k_pci 0000:07:00.0: failed to receive control response completion,
>>> polling..
>>> [   19.211036] ath11k_pci 0000:07:00.0: Service connect timeout
>>> [   19.211815] ath11k_pci 0000:07:00.0: failed to connect to HTT: -110
>>> [   19.214181] ath11k_pci 0000:07:00.0: failed to start core: -110
>>> [   19.531989] ath11k_pci 0000:07:00.0: firmware crashed: MHI_CB_EE_RDDM
>>> [   19.532930] ath11k_pci 0000:07:00.0: ignore reset dev flags 0xc000
>>> [   29.259157] ath11k_pci 0000:07:00.0: failed to wait wlan mode request (mode 4): -110
>>> [   29.259229] ath11k_pci 0000:07:00.0: qmi failed to send wlan mode off: -110
>>> - Second after this, I commanded the unbinded (ath11_pci) and I get the
>>> warning. Let extend here the stack trace:
>>> [   24.238198]  ? free_large_kmalloc+0x57/0x90
>>> [   24.238199]  ? report_bug+0x16b/0x180
>>> [   24.238210]  ? handle_bug+0x3c/0x70
>>> [   24.238218]  ? exc_invalid_op+0x14/0x70
>>> [   24.238218]  ? asm_exc_invalid_op+0x16/0x20
>>> [   24.238224]  ? free_large_kmalloc+0x57/0x90
>>> [   24.238227]  ath11k_dp_free+0x99/0xb0 [ath11k]
>>> [   24.238275]  ath11k_core_deinit+0x12b/0x1a0 [ath11k]
>>> [   24.238287]  ath11k_pci_remove+0x7b/0x120 [ath11k_pci]
>>> [   24.238294]  pci_device_remove+0x3e/0xb0
>>> [   24.238304]  device_release_driver_internal+0x193/0x200
>>> [   24.238315]  unbind_store+0x9d/0xb0
>>> [   24.238320]  kernfs_fop_write_iter+0x13a/0x1d0
>>> [   24.238330]  vfs_write+0x32e/0x470
>>> [   24.238335]  ksys_write+0x5f/0xe0
>>> [   24.238336]  do_syscall_64+0x5f/0xe0
>>> Very easy to reproduce.
>>>
>>
>>
>> Thanks much for the logs, that makes sense. The timestamps explain why my earlier
>> reasoning did not match the trace: unbind reaches ath11k_pci_remove() before
>> ATH11K_FLAG_QMI_FAIL is set by the QMI event worker as it is held up on wlan mode off qmi
> 
> how could QMI worker set this flag? the first failure happens in
> ath12k_core_qmi_firmware_ready() and upon this failure the QMI worker just break out
> without setting any flag, no?
> 


you mean ath1*1*k_core_qmi_firmware_ready() ?. Yes in ToT it breaks out 
without setting any flags, so I proposed to set that on failure case 
ATH11K_QMI_EVENT_FW_READY: (similar to case 
ATH11K_QMI_EVENT_FW_INIT_DONE:) in this mail thread.


--
Ramesh

