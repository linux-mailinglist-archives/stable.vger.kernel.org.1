Return-Path: <stable+bounces-247662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CDXInAHB2qNqwIAu9opvQ
	(envelope-from <stable+bounces-247662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:45:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67054EB2E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 908F830E65C5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72519436346;
	Fri, 15 May 2026 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBbZAao3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+LaRETU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEA47A0B8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843937; cv=none; b=TLV8fRS5TqAjAbJt3GdBuc8jkqXyPYZavRpwiE9qEdNEYEcVpsKM96MKDzxjfuOoXpziybnbxMyvO/FIOOzTSXj1N/JnKzF0/MCA44t/SDpwHVYUWuo1Dl+0JLpWTYseAKHojStoCfPGwtvJbXvNOreIz3OEqLMtAZSbbkEwHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843937; c=relaxed/simple;
	bh=UJVYFLt+7s0EoA6/cGgIfQ4tKtgAjAXLxZYsq54yp+c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KyfpNB2+K8VrH9uXBi0IPnUGOvbC3lnraPYrj7bw/CbF5hBEdyGtUKZUN9qHDfVVzVOU0IfEA3FhGNkqwcLbY7OnieJiubGfyDLmpFxLbn1vhezZTvPm56akQtaV9ksTwdWDbEdt+CpTGldfNUN289LKeBLCghfhX97k5LmgE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBbZAao3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H+LaRETU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FB0wFs4020900
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KCGXkWeRm3I5kdOwASc8lBJELQDGMPw3e9LMXhleB4U=; b=XBbZAao30viDbXZj
	xpKBXDPxtl8gV4AlXbfxTZ6nVwKhUCVCKCKmrGDWJraArwh8WKLIzMERe9wzhytj
	gcU/noia15CYHRUTYz4KMOWBYffz3x2Dog6OrHMxNYw2qm0fVDRpgUgsnstl34ZG
	8TroHqRVjRhS617HCfJfwzLbsgCwgEER/36Tzq2rtyCAxBDw307b1+uAcRIPoTfz
	5hms5Bn5u0r27SBl83+EiG1KT9z06Fl20bTksqImeBdT4b84SLVmUs/bq1eyZjzO
	C+OVsxYZ/15p9OTiV5JNGUA0LVw/ZBPb1FnxGequrAGfl3yBDQxyyB7ES78zdc71
	w+A/ag==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ru0y8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:18:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba6fe41283so102487975ad.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778843934; x=1779448734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCGXkWeRm3I5kdOwASc8lBJELQDGMPw3e9LMXhleB4U=;
        b=H+LaRETUyb33znpIqdd0jU7AivUmcvWeBtwTXb9vzLxCbPNTHzEkUOBxGZsLDKd+Fq
         loCpJ819ZkaKF6gnVDOZtBkP8ejJmSbXX4RGFjKT+uozm8YQhXziQEXwYZCIbsLU+fAp
         NDb1fLKmcpor9/9XFdMv6Pl6hLA9B+MLXy9Dq6j9Ggv+RS7mRI9JjnB1K7x62YlI32RI
         3lsddoxM2JdWVELfqm8r0SzRSH7eea8AU31J6vRmu87IuZJGXcw6toRh1XEkkBBWVnWF
         +Q1f22zG9EQNvePVizRQzFadpGCVIGscha9NCgDK4q5IerpDXbNpXXDLmUL236MxfCoI
         n5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843934; x=1779448734;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCGXkWeRm3I5kdOwASc8lBJELQDGMPw3e9LMXhleB4U=;
        b=fpU+b8Nm6HzHiqdrBL7gS3ssEfFwf0L+HQlT/FnhKNULM9/lIHy2Da0krq2gyYoxmi
         dw3ZQZtIgEe35uajkWNHowrUwFVzxKQztFstymhywpK6I16LPMIpJZbQXnharz1eGfNs
         fWizt+UQHvMfzzTOvgWgI2JPqGai7eIH9iEzgpwx0ut8uGNg3YtsXx1brAlfJ6YWBiJq
         IT4VLkqevok+Z2kxpGmKeHWNUmGQqvCoYYtI4c0S8PfKApJFvXmTnZfLQF97/lkSsYry
         SyUat0UU9sfcpmiLvAkCuEABbSJWivwVTysFmebxvWdyxXHCMuloESHXPZkWDIEdkfwb
         MPtw==
X-Forwarded-Encrypted: i=1; AFNElJ+sQGp6Q5uCaINFv/xK23TC7+WgJOj2I7WILIyA7ckP08N8RSyG64AdPfLaTafBzG3UITUo1qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVc+S1bOoB3KfiddfHoWm53yAjogTWRy+dEAWzj/OPT7O1hcU
	fxdyk4xubfmWHAjE2i8aVFFEQkeI6YLuoCcueeqD8ElOe/W+rNB/kWWUegl9sGfMkXdVYIuyHoH
	ye7UQpeeET75NK+q/JJQcKsHbAFbCzHoOLHyrnUrVzNwydqJdZAqG/YdrwbM=
X-Gm-Gg: Acq92OHEUDQ5qZfplqMx8QBR3cvPSynLTQjaGmMQ5azuTeKYXNTCVsa7tlYTH7B77fh
	trqMgNzD6BImShrULfijgdgmBPjOLGNySY7cmqGHW0Oq0pULxY41IRsMuthTZWv8+7daskftc1A
	pZ8Cj9pQ9fa/JpKQeAQgQYRFKK18Rb6K79KV5ge9dBZPdfCzSUgEa6Sgs7vt49cpmaxmE6fMzFP
	MqAtKtH7lfbvgL8SpwwifrHDTtjriC5+8+xz+GJAQPaJl7WMFNoT6wiX0/KYA7W95qkJ/GkKtMB
	GyaVreBAiYs2soV+6/wHKDiAi4RkswTO9WHHqX+BmO+nB8tU+A+cDz1zdbq8hG5FEzg/4J5mF+o
	c2W9CpVg7GmG8rhvux9AGOqBu3et1jhoFWLFBG9xlbRy5cPtXKZoXeg==
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id 98e67ed59e1d1-369519c513bmr3273072a91.8.1778843934508;
        Fri, 15 May 2026 04:18:54 -0700 (PDT)
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id 98e67ed59e1d1-369519c513bmr3273045a91.8.1778843934003;
        Fri, 15 May 2026 04:18:54 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695126feabsm2470123a91.6.2026.05.15.04.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 04:18:53 -0700 (PDT)
Message-ID: <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:48:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
 <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
Content-Language: en-US
In-Reply-To: <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MafK5H4eCvAba21DMzE0WrRWslwSjbim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNCBTYWx0ZWRfXxbOacO8t/Vm/
 TrD4UK6ZIa+eDF9SSP7YywxPF+LrHVzSiT+WB+S+qrRvePBomoVpMP7zyURjCMsLBnGZrjWetIr
 FcuGDRmVmXQ4swkRX59dwBnw3wINCGicHuap2ykAiQFTsSfCSdAEIkqX4tWBbXHjkQYjsIEkB6V
 o2FMi9eVYvlYgBlF1WbtECWgYoto9T20qMemg9/Gx34TfkWfbs9yyRYQgpMn01P6+VP/pdGeCvM
 Z+ECYH+00KnwXuEomDw1kzoPlZ+cu1SUOZwP58DJZrJjYNMNsp7lD2+WXqBvwfe4qY/UUXQQ0Ls
 ZVFp39bYeSZKQNzdHY70rGCK2RLFuy6Ge3cJ2aT/ubDiIttlO4GM8YREqw+ZgwQWmSyWaU31r3G
 4+DMoIeNXyXuknDcOrqU17UYS7csc6Mx1sjxfXDk2ECkdjTiNLmxzU87NhvIWFuV2S/W3MdlVRE
 MCuubCBp2ms3gqhizmw==
X-Proofpoint-ORIG-GUID: MafK5H4eCvAba21DMzE0WrRWslwSjbim
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a07011f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Xy_6AgtP5T3jK3p2aAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150114
X-Rspamd-Queue-Id: 1E67054EB2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247662-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[busanna.reddy@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 5/9/2026 12:50 AM, Dmitry Baryshkov wrote:
> On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>> remove this write to leave the register at its reset value of 0. This does
>> not affect other platforms as only Glymur firmware uses this register,
>> earlier platform firmwares ignore it.
> The explanation is pretty suspicious. I can see this write in venus
> sources too and it was added in the initial submission, dating 2017. The
> driver targeted two platforms, MSM8916 and MSM8996, so this write
> predates Glymur pretty much.

Thank you for the historical context! I checked with the firmware team and
confirmed that this register is not read by any of the platform firmwares
currently supported in the Iris driver. Regarding MSM8916 and MSM8996, those
are not supported in the Iris driver.

>> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
>>  1 file changed, 1 deletion(-)
>>

