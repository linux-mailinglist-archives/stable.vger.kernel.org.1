Return-Path: <stable+bounces-89263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5289B559F
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 23:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492D51C20EBE
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BF20493A;
	Tue, 29 Oct 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n4cc172z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3117B402
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240211; cv=none; b=B+5Z1Dbm2znfM3HVs2olJIP7rQ8I5Kkf/tYtdwd3rtY55PQlg4wqR4V+gYSP1Ene1ygKKTvV0a4xkBqPybnCKlJOS2R+EMdDgx9botctKaqqNUlKFAJs5ULSkjgfP/SEx7qBJOYVWJFcM9dD1Pdjs3+3AX4SFftOH+LCs921h/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240211; c=relaxed/simple;
	bh=OM8WI4SLuicxesSB/JGb0/SKjsH0sdbh58Sqf3JfDFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e/B6LiouWzbehG9gr/fNnLe+7TR0xLfC+H6pUzKJ3uG1WlfVdqK3CpTvFV1pzzjVVCo+89s/QXykpU67oJaBk0zC1dt9tHdIqJBe84JdtyxZVBhwC1Zm9k1RENEd5yv+uSsFu41rIlBKPTp8TiP05qm1pZR+fyJuvvMiSl6vJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n4cc172z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TKXrlT028698;
	Tue, 29 Oct 2024 22:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LeVWSvBxCDpgMuiN3UzfEa1sx/dGWG7fVNzxfDywfs8=; b=n4cc172zS0QokamI
	2YhYTZWH8eCoDE//VQW6Ttkxq1THanbdjYF0M2iHXwV4SJf6x50Ua1OcdvY99BRF
	+rAokamfM1cIHzvKH44Gh/shhB2/o4RFD2CJYPebB7lXAW1NUyjnnT3Umbk+WVNj
	PSYdn31c8SAEynWqBgzcwsw95wUYjkcwnNiFoudIL2EF4ntNFml2+ozwsC6QacRG
	BCyij2si0PRBWkDAjb3PdrOg6m6//9JzneGsVXiAmjyOf7DxUpJfyuwn/+VrQkcZ
	sI6JFFzclqKBQNCvpq2QkUKCrFPavDFaF06JYPpFQk51u1jM7bDCyMesQMfHaxlC
	EXrR6A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gsq8hugd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 22:16:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49TMGiOF025324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 22:16:44 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 29 Oct
 2024 15:16:43 -0700
Message-ID: <4166f657-f239-de1e-a46c-193eff355e7c@quicinc.com>
Date: Tue, 29 Oct 2024 16:16:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] accel/ivpu: Fix NOC firewall interrupt handling
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>,
        Andrzej Kacprowski
	<Andrzej.Kacprowski@intel.com>,
        <stable@vger.kernel.org>
References: <20241017144958.79327-1-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241017144958.79327-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qmag8ONm56TjAyrNYdGfD2Q5u8JRJ5MT
X-Proofpoint-ORIG-GUID: qmag8ONm56TjAyrNYdGfD2Q5u8JRJ5MT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=710 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410290168

On 10/17/2024 8:49 AM, Jacek Lawrynowicz wrote:
> From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> 
> The NOC firewall interrupt means that the HW prevented
> unauthorized access to a protected resource, so there
> is no need to trigger device reset in such case.
> 
> To facilitate security testing add firewall_irq_counter
> debugfs file that tracks firewall interrupts.
> 
> Fixes: 8a27ad81f7d3 ("accel/ivpu: Split IP and buttress code")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

