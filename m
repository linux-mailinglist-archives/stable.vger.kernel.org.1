Return-Path: <stable+bounces-36126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E40089A109
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27261B25396
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD516F90B;
	Fri,  5 Apr 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gyqReLse"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0B16F850
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330791; cv=none; b=XPBvsLlYE91NGr6y33rS4TrxSXB/ufMy85qgDOZ71k31NqZ2njqhObUp1CBfAAm7DoHvBvVmoCJ49zWMhcbE7W5Gt8WOK4l2GdPA47zGJrQZnPNQQQHaZO7VK7urw8SM2N3YwHtcnlQF//c9PNG6/C71I/pwVbGIZOJRo34yaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330791; c=relaxed/simple;
	bh=+cnElMZn9PpSsVG/2Bl7joueH/WwDvqfuQX4865U48E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eAMxdbnOV8E2ymUWdKo53c+IiPGNGJKsmXGFzAhVQkH2ySTWFBYFXzznsztq016IZpaWLGJNtabFLFSGxF2r8sgDqMkmwRmxZosxodbQS9A7S5PXe1MtIoWSXHF/4pTeRdbCXQy9iUkKV4BBwoY38/vsz3l/KfzbpyM8AhYnQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gyqReLse; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4358M2UM024399;
	Fri, 5 Apr 2024 15:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=v2g+tdvJV1ZtWHRVYkimha2fQ/aAUCdLSQGpzSEzFgE=; b=gy
	qReLsejrSzRAuxrb0yVb6neuOEDtl6nnAV2odT+6HVrsdGakT9fzyitQzqYLop9i
	pqN+vVCBZkEj9o2oB980ON/xb/8A2VnaPGJqIQgr6iQVUNbfMnp3OXmbxR8d6rkA
	Y6a0/8X+CCzRa8tF+PeOy4JeQYxBxDTrOiaX9uZhf9bdR+JO91gPM6XC35S77Lzi
	0CnwnS2D9DjNhXM0bsPYac2Ui3/W6/QFpiwfeoTrsvYr5QUuFJAXzENvQFehoruo
	fbUvRcGLMP9lynruimyXGQvT3eOhI558YA0h2OWm8Fjxo/FG/KEprkkRgHF3sRhy
	fQvNccadV/7eb5Y3b6ew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ej9w1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:26:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FQQGh015469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:26:26 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:26:26 -0700
Message-ID: <5a4d8fa1-a537-7690-b712-57391a192fa3@quicinc.com>
Date: Fri, 5 Apr 2024 09:26:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 6/8] accel/ivpu: Return max freq for
 DRM_IVPU_PARAM_CORE_CLOCK_RATE
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <stable@vger.kernel.org>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
 <20240402104929.941186-7-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240402104929.941186-7-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b0jjmC0H72JSDkmUv2-rAB_lm2hnhK3u
X-Proofpoint-GUID: b0jjmC0H72JSDkmUv2-rAB_lm2hnhK3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050111

On 4/2/2024 4:49 AM, Jacek Lawrynowicz wrote:
> DRM_IVPU_PARAM_CORE_CLOCK_RATE returned current NPU frequency which

Commit text should be present tense, so returned->returns

> could be 0 if device was sleeping. This value wasn't really useful to

also wasn't->isn't

> the user space, so return max freq instead which can be used to estimate
> NPU performance.
> 
> Fixes: c39dc15191c4 ("accel/ivpu: Read clock rate only if device is up")
> Cc: <stable@vger.kernel.org> # v6.7
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

With the above,
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

