Return-Path: <stable+bounces-111849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EFBA24286
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 19:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6513A3A067A
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B831F03ED;
	Fri, 31 Jan 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OO8C4Ftg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDD1386C9
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348011; cv=none; b=Z0pToWCW+6z0cHb8a2+3HLkcA3+qIDwwoz7tWIglAYPTZWZr8L+1BNa0jpcWAKd49lUvy0MJcYvXiRpq2gIzj+/fneLwmFi92HjrZrbgjUv430ZkgHexiozPQdPEDy92cuHuIdTLlARfHBlMN1DpTxNso24Q60ZCiYV3+78qZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348011; c=relaxed/simple;
	bh=4yxqNCmnfXcA79OkvE4QzQkUJqElfszqjkXt0sBSZBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oCjbzAvey0Gcmt4ekTYzzDgZqKl4BLkHGuWwE39ebFuN5W1wpK5o0KB46PGwnrlsbZhwGh6AHa8fcHucV9yYQCLttDfGwH9U5bObH54iUz8yuLXW0vzoWyK2XLiChBqb6BqN+Ya688vYYzV93PbNIbaQvm8pR+FoIucQbRfty3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OO8C4Ftg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDM2wW011337;
	Fri, 31 Jan 2025 18:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5lnwxUEYBQT76CZ9n9SKOh5tkTWWdQ3MnV8dTJc1j+4=; b=OO8C4Ftg2/Fh/8sW
	5YkwKFs9Uwi/qlY9yMQUFd8l+JLTN64NM6D/2RTlh/YrBSrjdjyPGHUpq+7NSSO+
	NPpBZ316d12oLrFxeqKiGu53d9NcRUD2R6/A8DEqgnXmVmJ6XwCdcRwb75pBNeD9
	omkjPW76e47J/xGNo9YkNu4ssFBrfHtONcMsmHf1zrc0e0plKil8naFfAHD03kwv
	jHosn5jchxWb/VgdxXN60tDHuSsJ+uAVsN84qvdiZ4/ujBY2Ne/RMCBZ/4pXd+d1
	FdJmz6/CmpPwCKvnpmVx/VYoYntoVJB6Gzz+QfkO+mXS2wFsQ8WJrYl09kKfK+eq
	jWpSqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyapgqus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:26:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50VIQjc3018312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:26:45 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 Jan
 2025 10:26:44 -0800
Message-ID: <1112b087-a73f-60ac-5942-ea155df5384d@quicinc.com>
Date: Fri, 31 Jan 2025 11:26:43 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] accel/ivpu: Fix error handling in ivpu_boot()
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <maciej.falkowski@linux.intel.com>,
        <stable@vger.kernel.org>, Karol Wachowski <karol.wachowski@intel.com>
References: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
 <20250129124009.1039982-2-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20250129124009.1039982-2-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sHWzeA5FAv5tf2WAgbD_LeH6UCOuP5Hx
X-Proofpoint-GUID: sHWzeA5FAv5tf2WAgbD_LeH6UCOuP5Hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=956 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310139

On 1/29/2025 5:40 AM, Jacek Lawrynowicz wrote:
> Ensure IRQs and IPC are properly disabled if HW sched or DCT
> initialization fails.
> 
> Fixes: cc3c72c7e610 ("accel/ivpu: Refactor failure diagnostics during boot")
> Cc: <stable@vger.kernel.org> # v6.13+
> Reviewed-by: Karol Wachowski <karol.wachowski@intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

