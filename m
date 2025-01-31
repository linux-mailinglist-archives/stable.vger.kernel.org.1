Return-Path: <stable+bounces-111851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580EA24291
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 19:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7F3A87B9
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402101F0E28;
	Fri, 31 Jan 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q5lpvZwy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859971386C9
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348176; cv=none; b=GW+iG+LHvnsngrkhwDaRG2TirUZlyv8llxLREgRbpidCgBFeChnHHvQU3ew9R2c1FKeVEGapzqIE4UWOHPJj0Jk0693Bmp4qf+KGMmJyjlROCXGjO3VogSBu+ra/ZBVAovd1zYuAq7VGn5biRe+837BIjLlkKfeEhGBU59i9a78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348176; c=relaxed/simple;
	bh=Myjpc/f5VLRtAoF6lJlarZq9skZkYdc4867s2znz8ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CM9g2JM9HerJ+vGI+/qWjZBqTCZqYKxsX6/PCkIxXTOUxMkDaGmnOtFozy+xZnvZ+fWrL/9GFIQxjWUTNr61jwfzYehR2vEqaOBko/FQrl/9y7Ol9Hz4+R8IPPaAqlmYWdtv8D8wP2O33wkPthh+9ekti5pxQS3qCIIdiMtIetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q5lpvZwy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDL5Xd020683;
	Fri, 31 Jan 2025 18:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BmQfPCtsiPiVdQMaiDQ54r+5hhpCU2+hgfWKN7wcXgE=; b=Q5lpvZwyaI8dQTBo
	vWCoee3EdyTamymI0/o2Em6QXH/6bbxROy6auNdzDoQmR9IiwMFJvry7rv0HLNbN
	V/YDN+HKR248H6pi+0u9B/r5ZLRuQorPm1cOnVnqaWyFa4svvHpGP2SNuQHML7ls
	KI38M9xbS3B2ICB/zOjQD/HedFCY905MXJkJar/pnAS3W28cHAQApBy/el9ykzE4
	zD4mWZZ3w8iiZo0mbkgghB+7O0vzwsOLsPTcMLvIxKUX6PyhMKR0Eb4C7SI4NpCz
	wrX6eXMNcTH78dmfkad1pkULpbCjFIQ5unR0Op+AuyRBP5TumWRI7SNY4qqQogy7
	mY9B8Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyapgqa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:29:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50VITVQd013735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 18:29:31 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 Jan
 2025 10:29:31 -0800
Message-ID: <4b7b91f0-29b1-d406-f25a-bd63e27f4a2a@quicinc.com>
Date: Fri, 31 Jan 2025 11:29:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/3] accel/ivpu: Fix error handling in recovery/reset
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <maciej.falkowski@linux.intel.com>,
        <stable@vger.kernel.org>
References: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
 <20250129124009.1039982-4-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20250129124009.1039982-4-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wZdFQTeZ43r0fURrR2q2CrRuUmhFLn40
X-Proofpoint-ORIG-GUID: wZdFQTeZ43r0fURrR2q2CrRuUmhFLn40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=890 bulkscore=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310139

On 1/29/2025 5:40 AM, Jacek Lawrynowicz wrote:
> Disable runtime PM for the duration of reset/recovery so it is possible
> to set the correct runtime PM state depending on the outcome of the
> `ivpu_resume()`. Don’t suspend or reset the HW if the NPU is suspended
> when the reset/recovery is requested. Also, move common reset/recovery
> code to separate functions for better code readability.
> 
> Fixes: 27d19268cf39 ("accel/ivpu: Improve recovery and reset support")
> Cc: <stable@vger.kernel.org> # v6.8+
> Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

