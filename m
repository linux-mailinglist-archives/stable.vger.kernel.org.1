Return-Path: <stable+bounces-151448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA0ACE226
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7147A4E11
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E61DED7C;
	Wed,  4 Jun 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJfXl3ER"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CC18DB0D
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054279; cv=none; b=r1kHqlUNTz/IWUR3Oo9IoHPsV+KPtyKVkYVjoYtUju5PgTJPG0O3crEWLDVIJ8F3bd/tQm/iKFC5euYmMYKD2/ZaiTjh0tdWzC1rEuyPbhYvOlp6wE5cXpWk1g5Ln87+OMZZglfB3VtpPJq2JdEKaMK1jW/BwxVeNODXFzpaEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054279; c=relaxed/simple;
	bh=PO3jUPStlFmT1m2wkC43j6GeI16ajnRuXqsKw7nCnHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2sY0rkpibUwa2vkoJKPyFngT1xDzejeViAS5rxcaJOWMkz1d3XTteUYfY3PcRqyRMRjVaMvB2bryPNbZTrYWereobAuUgKzNZ4dACCqL9LJHyCQSGuGM6lXTwjg/ShakOBsvVD9Xzyo1vKqDNh1iq+UMJaVgfCGkNR+YY1dUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJfXl3ER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554F98Di028609
	for <stable@vger.kernel.org>; Wed, 4 Jun 2025 16:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmqjCOK/2PV+3jpeh7XZghC3MKfY9pGurM7qJBU/Zyc=; b=KJfXl3ERFqlZhjj3
	21STEtvBdDAbkpQsizC8Gvb74Fv8Nse5ic109dL5yKJ8iNC3iOoIFq+CP3iOrC1o
	wEQEq1qUJdXVV/jDWF3WlfpysKmCxf04km6UJRU6/RxRKsoj11Aigttyp7jwcR/R
	Cdbm6AnzT0EVPlC6uHfswTs2rAWCRks3cxKpmFy7AWedXgbHqLU+6lABjF7lp1Xj
	pxmDEG8Nq/Ze0tSnAeWoggdg2D+0v9BR5A4iowj6cRLjsMLCkaQuXRb+BPn6Xg3a
	1orNNQx+eRrZ7iREFvp/41TkodY9XfWP+IJkSGDYjWAUyRudElRWQ/FBEDVWGvms
	GKO+Kg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8txqpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Jun 2025 16:24:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-310efe825ccso14993a91.3
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 09:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749054275; x=1749659075;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmqjCOK/2PV+3jpeh7XZghC3MKfY9pGurM7qJBU/Zyc=;
        b=pqmJrLXkLY0nUwXtgGb9lJhk5uzwBaMmNPijr6B6k8xGSDJdyVyVgpe3gRZqPlsc1i
         iTPIUEjZ0bTW8w/pZQKE/QFZTPp3LVJcicA17VeBcOMtfOyt/pZSLb5WIqbmVaM8uAB2
         /AsSj/I9lH9IAqj6JpfOO/OPCNTcL4DIXzFet+PM+HLHbV+NNOQB2cNvB8ZukvHyysuh
         4PpmtSBVnj6XwMW28ZZ5vX5fP25a4ox5rjmYsNfqK0Oxnasg3v0u/eANG3P89rjPnf3q
         D7qNX3FxgpfWwJZ5/xh+YeP9Gx5xtM+hNCLdNrG+2VX/7CQYUZB9CHodcyxur8spa+r5
         rNLg==
X-Forwarded-Encrypted: i=1; AJvYcCVBVA/RXDAex83z+dCbnJUbSwnV6Pveex6l2oNnK7mP55mtgjDjNck+ITGANtI0qG9lqBZLyHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJv4r6eQ785EIuD6RHq0jJY5g8oAhfkThkizKirBKrsjbuxnD3
	AImx64tiwS1eb8EXsisG7IF8DjLt3r37iEEF8BI77/px/bWnvY4S/5NulaHkli9rIYNb33FRU0H
	1KbaFlbtRgRB8F+jDFxr8eamgZLg4+UiaqmIVpoJzMbiruhf/rvLtPxJVN/E=
X-Gm-Gg: ASbGncvwh3codJU4j0w+0xeXnac7A56pet2sv0ijuLRt9Oo6ayHc9YwwMYJAgU/DAuW
	708Nfd0Z5NelCzQSRVnsbtst/g0N47mvp/otGxehi3zsRxrbb8VAyS283KNWqq2aVc8vX+ZhT/J
	qAx69DSsihIDyZgUKIoh7EoI7e3YfDQTVuxCzuQaoPhKZK2sTkC0ZJXryacSB4+eXfwYfIsQ45E
	RYD7Ho+NLseGI8YuHc9DIsVAMeCPRFgaAOckaEgyZ/AbwSlqifxfX40yypkYGEfjpf1LG/aHUT2
	qO9UXlzxkdW1zGZKwAn7tkg/MA2OA6aRrhTvn0pgCxSceSPUyW3ZkFuEt4jjegjHr/8=
X-Received: by 2002:a17:90b:48cc:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-3130cd3c193mr4541062a91.22.1749054275285;
        Wed, 04 Jun 2025 09:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyeX7AH3Z2qmV4RyPhkzwExHjRAMbx65+A1uhcePobw4T+CSD/5pREJy2bkxvhQy4rzQER5Q==
X-Received: by 2002:a17:90b:48cc:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-3130cd3c193mr4541044a91.22.1749054274900;
        Wed, 04 Jun 2025 09:24:34 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2d1689sm9089572a91.12.2025.06.04.09.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 09:24:34 -0700 (PDT)
Message-ID: <50555c1a-c200-4ac0-8dfb-424ff121b41d@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 09:24:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, Johan Hovold
 <johan@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
 <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xkGM_dE25dB7SOGXj6_5BNB6oJgi5UmH
X-Authority-Analysis: v=2.4 cv=Qspe3Uyd c=1 sm=1 tr=0 ts=68407344 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=OOj_HejH6eEqbjqsXVoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEyNSBTYWx0ZWRfXwe0MWZpqJqxL
 5gphjgm2lzxCqdqGBM2yfTKsCZzExng6kY5MVIS9QWUOKM6B3HzSx60oS+YWyuDOJ5TQVg6wuus
 pKf+JUFMI8slv3wJuKO95L2OQO1OtFA5eDnUKymtOmgpZ+wh+Pj+Fr3JfevtWFWctUSUBu0z7OQ
 UDQxmLOVcnUS6/qFQPmFNwEUg57G5bxvImoU4LCQNfSjwzIx8CUmXFx+xtAlwyOqKnxQMMUC5vr
 VZr/5u8MY8QvBTuuO1crYiT16MSkpPvsi/ykoINWGdP5lUSJ0A685Wn+lY3UFCVvpnf+wqTRBAy
 oJtze47VUUoGKM5tvzxgR14OUBz2QEfYZBIa/LMeqWwQorEYZvOlSbY4vY2TF8LiUcphl9yO9RQ
 aqPvIoybymQVqtuHIFbmbCw+mKvCgvlYh5RO039hVDrkPbuo85N8TWFdTCkgA43/JAuPwE+G
X-Proofpoint-ORIG-GUID: xkGM_dE25dB7SOGXj6_5BNB6oJgi5UmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=956
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040125

On 6/3/2025 7:34 PM, Miaoqing Pan wrote:
> We previously had extensive discussions on this topic in the 
> https://lore.kernel.org/linux-wireless/ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com/ 
> thread. On my platform, dma_rmb() did not work as expected. The issue 
> only disappeared after disabling PCIe endpoint relaxed ordering in 
> firmware side. So it seems that HP was updated (Memory write) before 
> descriptor (Memory write), which led to the problem.

Have all ath11k and ath12k firmware been updated to prevent this problem from
the firmware side?

Or do we need both the barriers and the logic to retry reading the descriptor?


