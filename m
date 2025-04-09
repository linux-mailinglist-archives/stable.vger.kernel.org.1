Return-Path: <stable+bounces-131966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57941A82865
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD557BBB64
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916282676D6;
	Wed,  9 Apr 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jT78wl4X"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA230265CDC
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209670; cv=none; b=LC/nnE67RwRe/qcLnexjdpkI5DKPqG7UCp+qATBsVD0Q+P3Zkds5QWYAdHidd8fkM0iDAFCe7lQCgxTNsBZkEidECCHtyBCPtPF9emMCqVIMlP6XfghY+LUeXaN2e/IdawnnCRJGmDbz/MGyMcnNpamwQ+KmvimGGruyyyCXDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209670; c=relaxed/simple;
	bh=+jAaxo1TCO741+kpdjVMq0f8msIm1aVBprj7vRnZB9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frDBaaMb5mrvw9u63PxXoC85tvexXISFGM52z46Y/lCpldeuxhvWfSjiuDxfkuU/w5TjGvdGwhhldpq7IiEGbqNeQ9w3t+BVH4eXbh/Bu4khdq9owALXcj2v0ePnDLOmwop0hbjip8gYByLOdMJ/D5+l+sSqpXFix962l71nqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jT78wl4X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398dj2V008056
	for <stable@vger.kernel.org>; Wed, 9 Apr 2025 14:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LG0gqeloi7FE5d7p16XRDqhtX9K2zsgebX8qfY7Te+M=; b=jT78wl4XukyH/die
	0Bj8lEldfMDGVTa0F15PvGw+qHq7UM1o5hBL7fEkTv11aZsQQ2DLxkbUe6+/lYJF
	yA8MnajdBub8F/6K2aBBkwAiQIyHxcdxbPVyjZ0sDnWcD19cboQV+htqOy+LkniG
	fv0y5RjvxHdjot7WZtMdAjqIdy0oosrn+QrYeCwNWIDHjM7TlAUOmYt/x+gnhr+E
	HQu+GdrZu/vK0T5qZNSV39+VBK3IVqdUwONzswXj4k1o7Fn2tNlLsWe8A6Dqqazc
	fpITKQ9NJeufUQT5+dO5jTIW6GW9pYuXsAfiG+28+mhLK1MwQwem0i6YCxAO2u1t
	xyn/Dw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3knxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Apr 2025 14:41:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2262051205aso50062295ad.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 07:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209666; x=1744814466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LG0gqeloi7FE5d7p16XRDqhtX9K2zsgebX8qfY7Te+M=;
        b=v0K1Z5NwdRlUFJgxtcQQGC/QwotOKfyvbU93X75F8lO+KLCCNGmj8uvLPL9RTeenAS
         wa430+m1TnIrJGsT+JbueeFaIMRWgDyoANQGfen7zlKMw1lKSnoHj7PC2c85Ys7wfZGQ
         lrQTWsKL8u9NsujL8BE4d9cW+W3HZnLBphNLA9AOPtdu0MkTPFOSXufug0qz0cSo+O/p
         GM+SQeeS31TaMFPKJTMdxNvHYr8VXekz0q66XgPEMMmF8Qks5lRVCaeDbiGsdlRef9S6
         SQJRIp82Sh9YdtCT/Lv0+OuM6MTh0lzPY8vcXC5kBDFphaYpgZw9dyzTuRb1DA6ECrcm
         4Abw==
X-Forwarded-Encrypted: i=1; AJvYcCUaPxeaiYEca0Z7USNJ5yDEG4xwUWBPx4DMJK+Rix8+bTNLCt5Lt2837S9InOWmbPfwr3QbfB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6Pvza7IV9su3+qule0i8mnMQoHIKHq1lfeh+ejNtrnhMVaU8
	kH/dOiXLvYrj04B8eTe6i+0NdUcUnb6UoRMIGK9Y9Di7k1guIdLMkdPXhTjCgfhx+1UNQdl6L38
	awNqsCN0CbDud52XeUN5lyucuo0XJgR+3U971YFx6Ti2LQKkDFrybjOo=
X-Gm-Gg: ASbGnctS0O0U98M1e8v16W3orfreLxEza/QIm1yFC1R28BSpL4+9QogXn2cwdr42TUy
	BPn5fKbCbZYrnXxh+CHkcG+YBs3cAU/47pZKQNXzea/MBOYxGmJ6jb6PJO2p89w7P1mhGkDl/pc
	t4rNLpeCEFWuA+yNtFfV5Sbw/p3mkLUjAoWwK3lnOQMs1ze40aok4eOAVahQBmBZXKe2lFAFIdM
	oZsWCKInO4RTjwoyywxbDyEOE2LyCHX+kbRdEYCJKKGGjIiO1hDdk9yq1mQHkNq0ZutekQk+T7n
	bUEw6YokRUAS/XxX+08xQeER3crBf7e5jmZwWhWhy9NgL4Z1XflR/sRrUx6XhQ==
X-Received: by 2002:a17:902:e94c:b0:223:f408:c3cf with SMTP id d9443c01a7336-22ac29a7d9bmr55332365ad.21.1744209665721;
        Wed, 09 Apr 2025 07:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPfuY6hqgOg5etkGo/HTOxudMRDkIQgYiO8YJN+34a0GSOQamTjc5qFyXZO44KKkIKLc2Acg==
X-Received: by 2002:a17:902:e94c:b0:223:f408:c3cf with SMTP id d9443c01a7336-22ac29a7d9bmr55331925ad.21.1744209665320;
        Wed, 09 Apr 2025 07:41:05 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6511dsm12744275ad.7.2025.04.09.07.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 07:41:04 -0700 (PDT)
Message-ID: <27642cab-9d0a-4989-9f3d-68f329676674@oss.qualcomm.com>
Date: Wed, 9 Apr 2025 08:41:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: ep: Update read pointer only after buffer is
 written
To: Sumit Kumar <quic_sumk@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        quic_akhvin@quicinc.com, quic_skananth@quicinc.com,
        quic_vbadigan@quicinc.com, stable@vger.kernel.org,
        Youssef Samir <quic_yabdulra@quicinc.com>
References: <20250409-rp_fix-v1-1-8cf1fa22ed28@quicinc.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250409-rp_fix-v1-1-8cf1fa22ed28@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jhPZQ4OZ2kwlfUumJWy1HFPW52wbUp10
X-Proofpoint-ORIG-GUID: jhPZQ4OZ2kwlfUumJWy1HFPW52wbUp10
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f68703 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Mw1Om9em43-oCLZg1R0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090092

On 4/9/2025 4:47 AM, Sumit Kumar wrote:
> Inside mhi_ep_ring_add_element, the read pointer (rd_offset) is updated
> before the buffer is written, potentially causing race conditions where
> the host sees an updated read pointer before the buffer is actually
> written. Updating rd_offset prematurely can lead to the host accessing
> an uninitialized or incomplete element, resulting in data corruption.
> 
> Invoke the buffer write before updating rd_offset to ensure the element
> is fully written before signaling its availability.
> 
> Fixes: bbdcba57a1a2 ("bus: mhi: ep: Add support for ring management")
> cc: stable@vger.kernel.org
> Co-developed-by: Youssef Samir <quic_yabdulra@quicinc.com>
> Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
> Signed-off-by: Sumit Kumar <quic_sumk@quicinc.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

