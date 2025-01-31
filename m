Return-Path: <stable+bounces-111850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8491A2428D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 19:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F77D188A7D0
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825101386C9;
	Fri, 31 Jan 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pp44ivqC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A511F03D2
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348075; cv=none; b=f20gJlpnsfDnpcs69r8UhSjYLZQb3/VUFpjrKuyDKRc0AtG8htu6TG7D7NbxKQ+aWN96VhZF6hwo8HQg067lXPFDWc/N4rEFCqD7w9YvTIM9g+292/ZK5IZD6A1h56TWF/ZqkILt4x77E3gYC+cx3u9BpnNiBZT3/1auKmrIYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348075; c=relaxed/simple;
	bh=hQC8iazvRnaXA5p4i0JtX94Zw9UZxzTOiQG+KUhwW6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KZr2Hym5AC4bFq6B989a/4FMTNXuQtHu+5nyit0ij8jvfD0efALzkFEaCh5ZbyDjuSF1SJleNfSYtmlmx0+4Cw0N5VqA8rC4iypt8eUoy3XPZ1xjV5fcVQnzcvmqv2oMGUClwFo9Bp5Z8CUMnWkmSUDbDlGQekg8sg5lszG7t3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pp44ivqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGvTZW012740;
	Fri, 31 Jan 2025 18:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Iqy1Q5UBUmJR3ZY566QB7RXoaekZCZOW+gXUXus7zU=; b=pp44ivqCXeRr93BP
	4/sPbVjvbFcA8/P5ogFDoPRWTKCmpe051V7Q7owgKmM8ksRUL3nGc6bcPH5dCVBs
	Qs1sw7lxURwpt8MzyShvCucmfPSgWTfCh20L7l6glX6rd08iutlVSedPcLEqF6pl
	NdupFI/xhjb72JuLsA/ZtckHivYsA60fiCuIAo+bauasVndqF9EfYqTl4ffjy6Dy
	DsssQFr0tvkCGJXHP4c8FzQlxnCJct7ie3NiiZQ7M7rFGM4GXrhjpt0iuRuyFHrp
	1fqB4XLkXNp1BbcawtbUm50jEoO8dk0omdB3ceB15gR/DhRhpXF3k56Lk/9kdUsQ
	UGkYHg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44h2gd898v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:27:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50VIRopa011753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:27:50 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 Jan
 2025 10:27:49 -0800
Message-ID: <66133462-69e4-1909-a384-b29593a6ee24@quicinc.com>
Date: Fri, 31 Jan 2025 11:27:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] accel/ivpu: Clear runtime_error after
 pm_runtime_resume_and_get() fails
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <maciej.falkowski@linux.intel.com>,
        <stable@vger.kernel.org>
References: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
 <20250129124009.1039982-3-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20250129124009.1039982-3-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WgiOnAp8qLnzf7P3VTRJPMSoDj9Y0OIi
X-Proofpoint-GUID: WgiOnAp8qLnzf7P3VTRJPMSoDj9Y0OIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=894
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310139

On 1/29/2025 5:40 AM, Jacek Lawrynowicz wrote:
> pm_runtime_resume_and_get() sets dev->power.runtime_error that causes
> all subsequent pm_runtime_get_sync() calls to fail.
> Clear the runtime_error using pm_runtime_set_suspended(), so the driver
> doesn't have to be reloaded to recover when the NPU fails to boot during
> runtime resume.
> 
> Fixes: 7d4b4c74432d ("accel/ivpu: Remove suspend_reschedule_counter")
> Cc: <stable@vger.kernel.org> # v6.11+
> Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

