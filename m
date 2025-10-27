Return-Path: <stable+bounces-190243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7733C10401
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F0465A45
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43235331A55;
	Mon, 27 Oct 2025 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+Xx0OQQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC5331A40
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590788; cv=none; b=QSmlKuiVVB4pj3Pspa+VrbltHxvA+1h4Fk9cK+ac9pefkcq/JVi0dHgPorQRLV/dk9yRXBBACGFbYkeaZFPgemKRftqFYXpuZkLYqeI7wGVFjhvv7ANj6xp7xXEXs1XTG4HWwc+/PA7++HZT6gjvM93hb0Fug4DTfz0IU2g75mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590788; c=relaxed/simple;
	bh=eoAJ8PIVfLPdXpqlJmqfYLCFBxtKmPWeSYk7sZEFfzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djk9fN3X+ITb8TMI/XAVFTGCyL2JsFTSwJ853/kPh1CJYnftoLy6zkA6+1iin9YoFafi/skz4U/Sx7HnCk+MalNTQT1lNdDV/rsUXaZ3nh+sx+UUm8zyKMGi5V9PCVUPdQ0xgYk5XLa/SbCKlgyjchJnmZtg5EcuNfw9fLyVzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+Xx0OQQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RDfnvT2881906
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jL0+3GyKZ0RiY1kiMYGppf4ShPWCj6NZj4rXfhbQAl0=; b=P+Xx0OQQqFwSa2Wj
	0tOQVA0rqna4SwFcVpQNe3xnzss9wfJKUYx6/yiNuGEKeZL00E3t2RgiUSKMc/b/
	LruHKBNosaGhJtl2OcUynDMCnYd6ap/8I+V0umI/kVi+C53mPKz/BAL1Y8t5vjc3
	DS/GvtdxWn8wOqeUh4X8eR6GttSlsZ8ynUZazcC4Jb2CcwVsbpPyh8kRqN/y68De
	h/HgeMBEKSJaDH5zHo/RzK7mn8Tpo5Dex9T4Wr9894Uef8EMbAtKqGKjYEqxdDQL
	lyLsdjrrXe0LhS2xucpXb/PMKBNrgaAzcZc9bZNZtFviB49hN0Ykpv1/Z7uaQ3Fp
	ScqRCw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29uh921p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:46:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a27ec82624so2916300b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 11:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761590785; x=1762195585;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jL0+3GyKZ0RiY1kiMYGppf4ShPWCj6NZj4rXfhbQAl0=;
        b=K9PycB7C3UQ3uJVFiTdqPChHhYN6IGKn27Vt1NnOX3Fu686tVKvzceQYjy7Dw0n0wI
         fImRnM3hWQTzRm0rE9XM9ni6MkVUFwP1rK3MX+R+fk6P7B5Tyl5P4XG8mevujNJyCpzw
         8Frntbsawkr8TAzS7jG5S5LEPAOXfVODFeNupAv7pbYyV7vI/JeyE2qRaM3UP0d5guCL
         rMjBp9v9y/LBLB3dv7vPrRPIcft7A6Jzg9KZcnnkJNQkaCaLScugeFgDYa832Lk55Dn0
         zh8XZoD3/zsoEnd/TM9O9lc4YNWq9LUgOq4ltho1Bk80Yoj0zkWVKUl289Run3SrW3pP
         cHUA==
X-Forwarded-Encrypted: i=1; AJvYcCVCUa9UmF1/G+Ew196Ml8aWX13QKYILJmAM44RxfdCTg+hUUYWycCaP3TYxOBkYUxfzR5lRZmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCzGzzZUuI9h4LvgvlSNSO/k/Iv1SGa0W4jEAgM3R9UFGF6zd
	2eOs+zMZ6Z97fXtbtL09oOMhJTO0w/g2mMijy+Wh4KOaX77VyV0pbhH4pxELfGbUxkSKcIlZ1k8
	/ygpqiljecwTweDxnp+vXcHvGfLbcdSEHVJ5vlQn0K/tp/0/+WeS7FM0uSz8=
X-Gm-Gg: ASbGncujf0jiYjdubb/c1YsGBJ+mmAQJfiHxWI+I+14TaIEFayfi7oUhNURbCvPt7bx
	NkhTpdXLPvRF84smzDkQHFlpcEz68S5x+nEG67Adoc299q57MSAPd/2iwLS0jaK/m9D1Y1MTIXy
	P6pnXSaMafDrwDBPsEc7kASHqjcLfAsvVTBADeZdCzS5ccg+pF5V2QUgx0EesRbEhYiGdQI7Fjd
	NDEMdPOCLEU+jqUYyQR4b/D9Q6mNWtptvzK3QAUMTNB2bMhg0Ezk0xIyVk5GFFO6HnslRPGjnvh
	EOF7PIDLyfiu9MjdIJLv1CpY2wSN91E19lGE2TQqkMxQEmFmXzj/v5wfaZhEm4LCrTlCKPvXpFp
	qvOZqfFt48izCnTf2jIq87nhBQaVc/b/uHwUWSEIUjrMonW9tL7WSDWZa9Mkc8DaYEeHXRlM=
X-Received: by 2002:a05:6a00:cd1:b0:77f:3149:3723 with SMTP id d2e1a72fcca58-7a441c3e2c5mr1046559b3a.29.1761590784834;
        Mon, 27 Oct 2025 11:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnL4UEkxsoHI6jYPW9XVOkmRIeY5om9N6SMAt+fJXI4HO3hkw0+YgMzaItJQas5rvbsr30Yg==
X-Received: by 2002:a05:6a00:cd1:b0:77f:3149:3723 with SMTP id d2e1a72fcca58-7a441c3e2c5mr1046536b3a.29.1761590784360;
        Mon, 27 Oct 2025 11:46:24 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409c703sm8923296b3a.70.2025.10.27.11.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 11:46:23 -0700 (PDT)
Message-ID: <98121cfc-0d01-4ef4-b8e3-4506034f79a1@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 11:46:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 055/224] wifi: ath10k: avoid unnecessary wait for
 service ready message
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Paul Menzel <pmenzel@molgen.mpg.de>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Sasha Levin <sashal@kernel.org>
References: <20251027183508.963233542@linuxfoundation.org>
 <20251027183510.473050789@linuxfoundation.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251027183510.473050789@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8sv6Qk-GzexYZPd0UHagpv2aIE6yqzaj
X-Proofpoint-GUID: 8sv6Qk-GzexYZPd0UHagpv2aIE6yqzaj
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=68ffbe01 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=0plzKGMI_zvm0rPhr3MA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE3MiBTYWx0ZWRfX69/nGWEvycsT
 3euUF5kIp+ryR8SAToLfz4RyZ7u3RlbV+LOpfqSx1wMuK7ZfT8kIMVEwJTI39JqrWzSg32B9XER
 bH7Mc1s2U5Z7gCx3eIS/RFUzH3Zeq4ljbmZnr+uJSHhIavrQ6d1Jq+zfkPKR4ISddGLPH6L0sz9
 NJ5Frr2esqfbS67oLSqaS5IuMKI1MZ0l5/ieijJEPvicSt7QehBtqXwbKafavaV/B6CHUHpWR01
 SIpUoVMBIj+A3v4vtl2cx95LlNsemDlf/NEQDT6jmJKzPO6A830qAELgyaSkVwMeTeSPPkjlMmJ
 bSuRYLvdh5i98QaZTbNgwFCf4nsj59oVVBfkR4a1gqPRwlrM8TCeFlcS39eUNZ5QCc1VxWHwyJy
 vlucBO77V/eOwcJTdIJuRioRdJm2Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270172

On 10/27/2025 11:33 AM, Greg Kroah-Hartman wrote:
> 5.4-stable review patch.  If anyone has any objections, please let me know.

Please do not propagate this. This had adverse effects on some platforms and a
revert is already in the pipeline:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=ath-current&id=2469bb6a6af944755a7d7daf66be90f3b8decbf9

The revert should hopefully land in v6.18-rc4.

/jeff


