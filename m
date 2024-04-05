Return-Path: <stable+bounces-36125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150189A0F7
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D081F21BE9
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D560A16F827;
	Fri,  5 Apr 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T1rhSc2+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC916F27D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330542; cv=none; b=PcI6WWHA8kqfaHdeL4LwQYvD74dPcrRBcLoCpr4gJwgwZssp4VGqGAJ94unnzCvN/r1uN45qyN9p4DVF0ty8HUYS+ps4u/ukvhrqEy+wrCPSu2tMf5UJmi9p/ifFl7+3GaY0/xhecsjK48ifONJ7Q6hDURTxzl7rmuqzEc9BbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330542; c=relaxed/simple;
	bh=vIbi07TzSKcpkp0WLR0tDNK2M2wzsqySOx8nozyxouY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lZg61lgswDlcmhxHUn3KOymdbh21SioUg4LfvElcrecZ9fvvcLrmJLDf5TA1BPhlH0f7uXnmWJOkK4hf/ktivLMTVfwNy4nnzH9nqZKtH3olmYXNNmOobxt4zeRzzyGORQx7E66ZPFvQ28xYfYM5YRgOP0Rwo6Y5vZAdUHuh+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T1rhSc2+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435AJ5nl007828;
	Fri, 5 Apr 2024 15:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5RMgDrNLoCO1nHsf1PY4/ua0RPoM4RL4U3aj+laqv28=; b=T1
	rhSc2+HLDCJD7/FfxNkaKR2XWAOTNKdcFqigodxIzRGF38j+TOReUs28Vn0569oE
	uahhTX+GnJjblxVtxjtcJ7sZo1iSuHfzkbeClml0ODbVK+m0nXrlQsYnz/Yhbku8
	+f2pB631/Dlc42IE9tTlaRH+3tntqo43uKNJi3e95JhG6+o6E29TVhVAj2iJoO5V
	yPUsqrq+Ch55kv79vsgF1AePGtkUo2EIdvoxuAeQV+b3qEhx7qE8jxjD01I9PBwy
	5L6VukhZ98AAw8nqLBiNTWXGpGOTFFuO13ZwTxOu/k1kZgOu+SWKb7yf41yaZAs1
	qWgs4Kla0tuRlQvYWmxQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xaaj19bax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:22:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FMDiQ003290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:22:13 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:22:13 -0700
Message-ID: <1b0faa38-ebb9-f578-6f4e-5dd33374a384@quicinc.com>
Date: Fri, 5 Apr 2024 09:22:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/8] accel/ivpu: Put NPU back to D3hot after failed resume
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <stable@vger.kernel.org>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
 <20240402104929.941186-5-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240402104929.941186-5-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qSo3yb0lGOXCkoG7fXNiKidUFsYgdMkq
X-Proofpoint-GUID: qSo3yb0lGOXCkoG7fXNiKidUFsYgdMkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=633 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050110

On 4/2/2024 4:49 AM, Jacek Lawrynowicz wrote:
> Put NPU in D3hot after ivpu_resume() fails to power up the device.
> This will assure that D3->D0 power cycle will be performed before
> the next resume and also will minimize power usage in this corner case.
> 
> Fixes: 28083ff18d3f ("accel/ivpu: Fix DevTLB errors on suspend/resume and recovery")
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

