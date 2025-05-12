Return-Path: <stable+bounces-144012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478EAB43B2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E321F19E142E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE262293B6D;
	Mon, 12 May 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxlVfcyi"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4847296FD2
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074895; cv=none; b=X9okNy4pNBY+ZnrZrGXdIG9pEwYLR9efHlR8jjNRjbc+pnxEVDCzoWTQwUn7r4jkeYmOCcybw62Ski1zsFWkkXHUREc285iuPRNoRU81mNZ8PtCitE1lXLM42yEKO3fxF4tY57mqNhI0kc70Lej6G6CVJX9WX6Z2uzIn+Ib/VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074895; c=relaxed/simple;
	bh=lyE5sRZk4CBUO759z0Aw5ns/46Fs0cx1f+23Fdjb7L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuBeSVhwZChO8LfsbAQSxdrOINgplXuUcHeyyi6edJ+cjmvT7vy2C3cBGBrzPI6reBBOfgzIXZcHhVK4BecD+EtihRzlRL/8asIZ6TeblbVcAajQ0+qART15C6+Rkl61cZRtN58FxLD7TlUJv9hE5MTOvOO1ZLgCLXGAn8NQZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxlVfcyi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHlQ1X015280
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z/fKDyk+1NUrhAEQiirhFI4X0w+Ip6zFM/5bjbQI4wQ=; b=DxlVfcyibTphmLpq
	ipPx6oIcfhLXP0aSu22MgtSTUVY9aRMI4mosUkpt5LjgHIIVtCzrR20UzteAG05L
	2f7oauNnPQQlH+iIOx6NVqGilAJSkwIlCxZiCnr6nmgEpXuQSHCNPc46xOIIa44L
	+xEYyhCVOURLZ0m1X+YTQhUs4iuweJ2U8km4d2uGk6reW715VQdQ2RSo6gXbYCKq
	RG+YQvhVsu+chswppWTH4vo8hYHzc4ez47c3uQu6iIRKuslDmutwm0uWwD1hnipT
	hwAGwNHOPkhv+gZ4Zf0wHUtnOLn0Yf3Ib1SXEWfCoF9lhFSqLOCBufzRJk1MftDm
	9/2izA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46j03bd83m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:34:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22fd4e7ea48so28909525ad.3
        for <stable@vger.kernel.org>; Mon, 12 May 2025 11:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747074892; x=1747679692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/fKDyk+1NUrhAEQiirhFI4X0w+Ip6zFM/5bjbQI4wQ=;
        b=vRnChOOqGDo6GlZjeadj8dqONTd4pEBBqG7w0r2Q3ECYXqSrQbTXkN6jsHK1x5dxQl
         WXsV/JFN70dD3IZop2UFQlutF1egwhGuumMrd13jSdPIinOYrvqtM/rconQVU+lecEKC
         QnAfZqjHu3T8P9eFsp/PlSHKMl7vBoS+4mAi+5KMiWCsASM2sPeocwAhQqtc4giVPp3t
         ML9w7lJqiORtTgMK1fL4zAMCKHy21w8RiyKDuRBioVkwK4S4McqcAfhKcVhRaErqAwJ3
         P5L2S/zWVcFQ/+pG0a97s0Z2FvXv79537Yltv+WWQUYs/XsuVA8sBlPbq5mvix00Ftsc
         245w==
X-Forwarded-Encrypted: i=1; AJvYcCUNQSv0c5B79/TZYzQ+ZvZzTnZu7zo4rMMzNhDrDJHEgVxqNVsnbeEqrKZZhY2LAvN6ffZn3sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBiMeYzD6qi6OtIiIoniuvTwxZWd8CgbPEZLskx1voIKfQn58
	d7fWuvSnoTAFU67o/P7ZZxxvy2QpRlwj6Af3ybMmnPhgNVnjY2/eBDNTDaT06fpIL0MbsZi2kdi
	mWcj/LXFf4khsVHwPnMCcvFHis2vlsqUFLjs6f32Zuzdw2IR6AhM6Jdc=
X-Gm-Gg: ASbGncue20S3f7vzIviKMSAE1M8GXkdE9wAZQr0uRfal0U0anG683xwaz6e/HwZzDXA
	ENrMfqq6U1pxAzY8nKkb9Uw7VS4jMMz0H2iv+UdUfpEhCpGIBLreDUscE6h72g/PHF5CwOwiJA2
	l44u2i0hFR64bR1gkPN5OJxuaMkV1hwffcxyuXLM4y5BFJrGdXRTs0OQiKqTDaA7c+o5NSjWtdq
	t1T7HdEJNoGc4BxHasXYjhI3q4Q/BkBV3Sxy6SYotVhWWKUIidYdjYDZ74dkxmnITsWog7rtr/m
	/fDS6XH2WaxjnAiXYfoZFDyPzBjlDuxoFcLEOKrV2kHFGieTeCIOoFpAemYFUg==
X-Received: by 2002:a05:6a20:6a15:b0:1f5:80eb:846d with SMTP id adf61e73a8af0-215abb03109mr18896284637.10.1747074892231;
        Mon, 12 May 2025 11:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl1Huc+lrMfWf4OQM+9/66B5hu2RcVCrULPeB+GGuAdM5kY6UYxXBIPpfmvONXzHu3iiBlIQ==
X-Received: by 2002:a05:6a20:6a15:b0:1f5:80eb:846d with SMTP id adf61e73a8af0-215abb03109mr18896251637.10.1747074891776;
        Mon, 12 May 2025 11:34:51 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4fe23b2sm9208527a91.37.2025.05.12.11.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:34:51 -0700 (PDT)
Message-ID: <6b87e6c8-33b6-4476-bc8c-934d93bc1f86@oss.qualcomm.com>
Date: Mon, 12 May 2025 12:34:50 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Improve buffer object logging
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Cc: lizhi.hou@amd.com, stable@vger.kernel.org
References: <20250506091303.262034-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250506091303.262034-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MjTIu4b7Fuax79RhCEFbzNujjmFMp0hO
X-Authority-Analysis: v=2.4 cv=DOuP4zNb c=1 sm=1 tr=0 ts=68223f4d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=iKTJfPOwawMBF07lcpsA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: MjTIu4b7Fuax79RhCEFbzNujjmFMp0hO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE5MSBTYWx0ZWRfXwkL84yiqGH9j
 SDVMRl+B5/CSQe+Op5xTki0GE5SQ+XbZGefLvAAmJ6Ia5R3Tm5FQ38/5JVCWmedZLALDpK/2zyg
 QDQOWCuyRwU6ltqPkxHHjeNaqGlV5Zf1v8I8Q/OfuQ4KKxm+frLqk9Y/LwgIcIzbarQdGZfLl7Y
 yx/keLY57LgSrDbA11I8jwoB9fUYgWfiyJ5ROKOCOcqXG6nlYr4FvavL8EPBmGmAmYRjlYQx0mV
 066ocpLUJ8axE6D2gZf9g7+CxcVlqan/5MnFoEy/QyKOWLnq65KjIhFgV2IcSMfXhgrWiG0KF4v
 v1Rjqex31nG/pEHmULMu6jkOm1t30OoJ4dWuK4WmgF5vajpAaRRoTr+K5EUlermu43DFQquhcQq
 /Vg7g8QUPrbv2vcUJHSZeWtOIfjzcuaih8Ts3CtrN5nLQRBPhbCmVMJQZ0YyJZPSTTpglRR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505120191

On 5/6/2025 3:13 AM, Jacek Lawrynowicz wrote:
> - Fix missing alloc log when drm_gem_handle_create() fails in
>    drm_vma_node_allow() and open callback is not called
> - Add ivpu_bo->ctx_id that enables to log the actual context
>    id instead of using 0 as default
> - Add couple WARNs and errors so we can catch more memory
>    corruption issues
> 
> Fixes: 37dee2a2f433 ("accel/ivpu: Improve buffer object debug logs")
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

