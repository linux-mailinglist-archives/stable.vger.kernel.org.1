Return-Path: <stable+bounces-36124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F16589A0F0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4EA287F97
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399416F901;
	Fri,  5 Apr 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kswkUqH7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C016F8EB
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330463; cv=none; b=Jk0XHx3P5vtZ0/rHBNIG4XZG2w2kVw6Bwee9PsBByShab9bSmAXJnISKVIvTFo9DGZvCrObU+ifetmCSCaNpvJ8CXYXqA7J9P5Y8qrzZH0WIXi/GfioDCDAn4WqGoNlGldt9SBGV6aGCLzCSOiomTpks9c/wklUn0doSaKCJSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330463; c=relaxed/simple;
	bh=RDAPegouZaRdK39fojkaICEDrSLFYwLjDI8wczP10zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uaj7XVPNFn1GOmvKMGxPt83+VJdEvgKZdqUjFTzZR6dh2qYAopKGSLGYqb7l7vAWkb94C8aTQM+IdvNnKVWyKJEJ4PSHhSHFAixkRlCSmbsbTMFvvPHQXHMnk15xtQgMN/IbZA/Ye3G9EYgSl0mTc7FgPFS05X9JgdoZD2IHiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kswkUqH7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4359iR3Y018564;
	Fri, 5 Apr 2024 15:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nFPaMFfInwVQm1L2tSKSBN2h+xDoGbVEpFLjnyfMdQ8=; b=ks
	wkUqH7SdZ55otTMYAOqKlda8I3/9kNWnpIVB6yAwDvGTyN8srKcwp1o0+cs4ZPEu
	K/JBU14lLSeQVnPucVugy5FEnotE39QfLlkpBVFfbO8pwNWPECFrzMNUhvRFiiwJ
	Y+iKpfSErw7JH86onB+iBE0gjxw4RRbWAxS8EBvJa9Gw/akQuyIc5tHCrkv6HtWS
	BdO6unTACvJg3HbgCjHJiXiHVotrRYUynpBS6sGctJpacG92Hzxi6jz7HEn+AEN1
	UMDAOoL2YoNAjsABvzRLsb2oBymPm7uaDB8yR0TVP6JnLU9JD6D74HjqpsTFRXnc
	yosL1NHCgdi2ZGilYbrQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7snsj7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:20:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FKs53014516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:20:54 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:20:54 -0700
Message-ID: <1a6dc472-293f-d2b1-216f-40d2f3f90db1@quicinc.com>
Date: Fri, 5 Apr 2024 09:20:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/8] accel/ivpu: Fix PCI D0 state entry in resume
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, "Wachowski, Karol" <karol.wachowski@intel.com>,
        <stable@vger.kernel.org>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
 <20240402104929.941186-4-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240402104929.941186-4-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Io5QxFjy3LAPqlCLGCf599JXfAC5bONG
X-Proofpoint-ORIG-GUID: Io5QxFjy3LAPqlCLGCf599JXfAC5bONG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=919
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050110

On 4/2/2024 4:49 AM, Jacek Lawrynowicz wrote:
> From: "Wachowski, Karol" <karol.wachowski@intel.com>
> 
> In case of failed power up we end up left in PCI D3hot
> state making it impossible to access NPU registers on retry.
> Enter D0 state on retry before proceeding with power up sequence.
> 
> Fixes: 28083ff18d3f ("accel/ivpu: Fix DevTLB errors on suspend/resume and recovery")
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed_by: Jeffrey Hugo <quic_jhugo@quicinc.com>

