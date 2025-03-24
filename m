Return-Path: <stable+bounces-125894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7515A6DDC6
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADFC3AE755
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53825F983;
	Mon, 24 Mar 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N7Q4LOYX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6C1EB5B
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828601; cv=none; b=RvibIXrQ8tOg+efGVbXb0J2YwSN42mjrkTZLCC/eHWi6P5gjbzDe/taFarHS8YKUln57zZ98vU4V2OKAuT3ghcgtQu6qMASIXNzxal1OrEbgqqKrZHR/Xq+HaS0d0TkRPvrkkKiaA1yeI0TRNbnEaaeDkbWXfWeiL8OsSrP6HBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828601; c=relaxed/simple;
	bh=65mc09JnOzcVvzzTPHmhpq+II+Xcs2gKiHWnDOta5Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xza5ELF4D5QRA7gShPaT+DKoWNVsJ9CC5Md8cHMY9W3RujdfyjUyNzJrNN7Wyxz61pwo0VeYY9GdWDRjJmxok0hNpyV3ylkpJQtMLLxVudieIf5l7UiGbyehauIC9Wseqk1nfdHMCdN89IhN6no1N+bJb90aZPTj2VKoXjAKiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N7Q4LOYX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PPxl017954
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nH4aeoaJ2bY3RhjpBvj4Vxj6NTdJ/AFDG5izM2nQcDw=; b=N7Q4LOYXUuaaVvgi
	l1okrk8+L6tEVc8sAsxHzYetGgDplc1MWqBxjnTEowSOjZEgv8QGguRmkZ05WtYb
	R1mm2WLw0wdrJHTatytur6YWKvL1r2QAFCQhDzhcev9gxk/kEd3tzr63UXa8EMdZ
	ieYH0z7dYOy8CBc/TfrD+N57+pzYyDkYUmiQ6SiBYZP9a0nii/cg/HraHMLU/RqH
	ok3LtIVzOKEwDW1mTNoGn8hBQnnvZQ5QBZHdDWf7pxY8IiDk6l2tgA17k64vtKKg
	dG7c6ezC3oFrXpD+BkUx4C45w6OPZxg38wmz574mWg9ts3f5N1BIrRL0iD+NVklw
	x7Uw5Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hne5vrak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:03:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2254bdd4982so116409605ad.1
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 08:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828598; x=1743433398;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nH4aeoaJ2bY3RhjpBvj4Vxj6NTdJ/AFDG5izM2nQcDw=;
        b=ZbikGslngjQdxyeV8jHoWd1Izsa4VvKUpQ/MwgxLRWS0KV1lf6iieSIM1XYrV9yXW6
         hQHucvy++PSUWOuGlh9+B0k9n0OXd4yEM5euvRpG8k9qyOruJjhtrswU4XUdHoMlcGJ3
         KueOBVtrM3lT0ydYJa2z+nfLa6jbK71nMyTgx1Gyp704GQlnzb1cnEOPg+8gI7Zwx/ON
         v1jrNe2M1UR3HAHhlpbIjknMwU0Vufjv6ri7caag0UoWI8YREVu9lMZvYOv6itKkytyY
         i7ZqMGmBZ9fthfaILqKVlR51EFqqWNkHWOZJu74MTVlgj3Uvv32bNyFVL2WCwZv2we5A
         E9ew==
X-Forwarded-Encrypted: i=1; AJvYcCUdGGpums7wzgcCgI6TOcgxnvv0JF18rMNamCSr+/ez1AREabYJNrTqPkfEe4srfmi7NP703Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3q94aYt/rt0fCXzuxJue34Y49xdAhYQQFkVc635fBrn8Ikxah
	jNH823kSr6SVZlxbLnfEalgNpFXMtJyNbnR6C3TAnVmY8I7Lp3M0ULyIhv7iwmkpzc9xzKp6k+c
	YQymFIEfL2YOyoFN5SQPfqSeOULmGIwRERlXs6p8Yc3C63cGOG64U/z8=
X-Gm-Gg: ASbGncvA2KTmYW+IzJfysSGAvak7GwcKMulnlkF0Aj3/uC1qMzfyhGi8kUT9R3Bc+hm
	xoe3IU7rq+t7WkNA1kA3cWWmlJQhxzsaQlj+LG8pOgZcqGnbyurq1A7x/nFPOqAZ/d5YDUNjgeZ
	Tb9d+eOQliLKrHW0P5QAz1RZ5DkjpkT9yNEa/zGaHUWE6Ny6WQpTanVnHzIP0MQJnH/FSnZnVi2
	fNy074WTHdvo3QdFYLcEWWDTYABv2ietd7ocqNcnWJCxpAvu2n8F42gK5X4iKCHzU3v23x4DiG9
	ADl5bM4s2GFYKEDYCAuchXU6Z/cV4wEOd16idgb4pyD9TiefPFNEpMlIdmXnxmCAyPVo/TQ=
X-Received: by 2002:a17:902:f70c:b0:224:c76:5e57 with SMTP id d9443c01a7336-22780e02a4emr237465355ad.39.1742828597673;
        Mon, 24 Mar 2025 08:03:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH828wzul6klWb3XsCB3+zMsH7vOJ7XnnAtFTDduSHSdwmPgp6DaMF6OMFiOhDbgCT/iquEMg==
X-Received: by 2002:a17:902:f70c:b0:224:c76:5e57 with SMTP id d9443c01a7336-22780e02a4emr237464745ad.39.1742828597066;
        Mon, 24 Mar 2025 08:03:17 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f459fbsm72138365ad.78.2025.03.24.08.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 08:03:16 -0700 (PDT)
Message-ID: <5d872cf0-ca57-4017-b06e-fce9c11813dc@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 08:03:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        Clayton Craft <clayton@craftyguy.net>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250321145302.4775-1-johan+linaro@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250321145302.4775-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pDd3WvhUzUpZdOtDsN2hXlCKxWBZvfEw
X-Proofpoint-ORIG-GUID: pDd3WvhUzUpZdOtDsN2hXlCKxWBZvfEw
X-Authority-Analysis: v=2.4 cv=JvPxrN4C c=1 sm=1 tr=0 ts=67e17436 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=GSe8ykzKO7dVpNIIvtwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=963
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240109

On 3/21/2025 7:53 AM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that the REO dest ring
> descriptor is read after the head pointer to avoid using stale data on
> weakly ordered architectures like aarch64.
> 
> This may fix the ring-buffer corruption worked around by commit
> f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> ring") by silently discarding data, and may possibly also address user
> reported errors like:
> 
> 	ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org	# 5.6
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Does this supersede:
[PATCH] wifi: ath11k: fix ring-buffer corruption

