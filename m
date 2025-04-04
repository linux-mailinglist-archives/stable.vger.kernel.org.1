Return-Path: <stable+bounces-128332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA2A7C043
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D99D174849
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7FD1F3BA8;
	Fri,  4 Apr 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUsyGKrr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE01F2C5F
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779346; cv=none; b=qku0ye4MVnKkoKp+KnVtOPvSf9+tY1DX9KIsLzcdQhi2d6oIQQhnQgMnMYO61yP8rP5NTbPYC+567pY6GsHhQY5CEWrr2f7ARgwd2JU/gQhCp8+crNrtuQLeDSxLbB63Nm+MvOrs7y13bl4nAJlXhW4JpY/Sx/pTAXKuBwwSw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779346; c=relaxed/simple;
	bh=JOy39FyrcWgiFXmHfSJKlunSQhKFMibdJ73Q/t901+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/6c9F9o6Lfjr8UP0Tq7AR3izCIndvr8dw3GajKbQ49WmHcFSV8oxKCnBTw35llcN0EsTVa6lkQT+b2XYu6ede0a89qWchEouTJFgoa3M77fNlMrDE+DtLIYG4FOebXGgFJy3YXbqbje0R0jjMW8CVM9ePxWE+LxUXJ0zMVaZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oUsyGKrr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534EroYf004591
	for <stable@vger.kernel.org>; Fri, 4 Apr 2025 15:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wkJ4A/aC7pKXYGEy7Rw5miq0Hsw92wemjeWCtzrGHaM=; b=oUsyGKrrHUGn4Alj
	rxNp+f/UFH99gXiyhYEs/8cx6XCEmAt5yWxwxz1fJm+5Z/uTdqX10hY2n9ljnkgy
	BWRps3zVIrQD6VxYpzW2ztsGn8dtLLrlt3V39NSlpSxh1m/MM/I8FqddrUPpNp/S
	y+uDfzprTshxIQGPJptz6xcM+7Xh/NAtIdbt381ZED+u4Rl70J31TBQLu5BKxWfn
	v2CWBBUyfMPuDreWgXqMxOdHJHdKfl+SjfB5bJSL36ENqPL5rdYldBcIWEPdFoWa
	OMRKab0RhK3rvgx66semrgJyM+iDAiBHtvRjacgIN0KLrIwKFf6hHKAT/hdJyzPF
	v0kHSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d52795-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Apr 2025 15:09:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224347aef79so30987755ad.2
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 08:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743779343; x=1744384143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkJ4A/aC7pKXYGEy7Rw5miq0Hsw92wemjeWCtzrGHaM=;
        b=V8gIJJwx7cl4RFCYw8yRxR7ts+x4By/vxCHWEFvAHFNbZc6ubV6Sei8rJD06nJx+sN
         fl4nV3xSzUZiAu4yqNDoTdbYXGjPOJD28Yiv8PK+q5SKsnh71Jnyc4zLhZF8vZv8HK1t
         KTbzsi6haF8PfIpp0T0UrTOAXAsr7zeHbXza2Vmy6vQAmjvcuBZ/E+dLFJNtkiHr4pst
         84ec9Rat+7uyH24Z9mUH2V15hu3F+iBF6aoBx8o+bujyUvHCyle5aIcq5hTcz9p7U+tX
         HO1wfh9lfPA3UA0wnLcuqx19i6COYYrt1NDih61iEuPPTHJRFVHmkqizvavTmldFlwP8
         BpjA==
X-Forwarded-Encrypted: i=1; AJvYcCXOxO6N8Mv/tf86Uvr1RKOFgZkNuVhbWkEgW0ZFI1SFD4sfXQTpP9X9V53DIWRnG6EN59jpDAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkg+RSV88n9+mblqVxzvqGjbos+x4hn/zDlWz8mdlRrKmUmID
	wtj42xGoQjz1SNO+syTlS9KId/CmD7gNF3zd3jfPY/g30Vlnu+bvtYlMWUDMru+i26ittGr7o4H
	HVHPd6f3JTaw3FdAWyVVofdeq522arlRDyOlV9ZCYTEyrio8q5fhxWcY=
X-Gm-Gg: ASbGncs8JKD4dp7WpvN24yHhW5Oxeum6uSMnbyUuKMHH+abjwhn/8HoWy7nxfY8vjBs
	j7ZaRXoTmq0aUMMQK/6asLBw4Lpc+CvOb/r4Yh1T/9GzX7sbzLWikeryIvRsK5A5vM1z83Yn3N+
	zdCoek4KhlpiC67viAv+lTuOG/hRbMZ2EdqjHVW1zIK7S8kOuVh2WdsgCw34AYCaRr50F3JQv/R
	CTZpiLekV2G988ucBN/gvVITK5bNUMd2hei4fWU4Dm5FATaYSFx5uQ0xliC6lyiV/5Ydzx+OB+1
	gBoBZkmo0XiadLXoKpFwfz+sAOOEjtsXeFwecdllU9/s9e5J0cZYydL5jTZOwVr9BA==
X-Received: by 2002:a17:903:2ac7:b0:224:1609:a747 with SMTP id d9443c01a7336-22a8a07e75amr47276235ad.31.1743779343031;
        Fri, 04 Apr 2025 08:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFz05Yp4dLMQfru7T9w7HO2RpPSzpYzX3hqg3qF00f8PIzAReAOci9J80pjBEtzUHdJ4xTw==
X-Received: by 2002:a17:903:2ac7:b0:224:1609:a747 with SMTP id d9443c01a7336-22a8a07e75amr47275995ad.31.1743779342684;
        Fri, 04 Apr 2025 08:09:02 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7cc5sm3559585b3a.176.2025.04.04.08.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 08:09:02 -0700 (PDT)
Message-ID: <38f15544-57d6-4963-945d-5bf8e2c06343@oss.qualcomm.com>
Date: Fri, 4 Apr 2025 09:09:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/ivpu: Fix the NPU's DPU frequency calculation
To: Maciej Falkowski <maciej.falkowski@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jacek.lawrynowicz@linux.intel.com,
        lizhi.hou@amd.com, Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
        stable@vger.kernel.org
References: <20250401155912.4049340-1-maciej.falkowski@linux.intel.com>
 <20250401155912.4049340-2-maciej.falkowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250401155912.4049340-2-maciej.falkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 84GG6W4jhd918i2R51sdP-GRBAnPFl9S
X-Proofpoint-ORIG-GUID: 84GG6W4jhd918i2R51sdP-GRBAnPFl9S
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=67eff60f cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p5fPCWA-AZ_0pnIrD7IA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040105

On 4/1/2025 9:59 AM, Maciej Falkowski wrote:
> From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> 
> Fix the frequency returned to the user space by
> the DRM_IVPU_PARAM_CORE_CLOCK_RATE GET_PARAM IOCTL.
> The kernel driver returned CPU frequency for MTL and bare
> PLL frequency for LNL - this was inconsistent and incorrect
> for both platforms. With this fix the driver returns maximum
> frequency of the NPU data processing unit (DPU) for all HW
> generations. This is what user space always expected.
> 
> Also do not set CPU frequency in boot params - the firmware
> does not use frequency passed from the driver, it was only
> used by the early pre-production firmware.
> With that we can remove CPU frequency calculation code.
> 
> Show NPU frequency in FREQ_CHANGE interrupt when frequency
> tracking is enabled.
> 
> Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

