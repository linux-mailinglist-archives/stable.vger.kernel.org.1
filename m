Return-Path: <stable+bounces-36123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D494589A0D1
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790F91F224AE
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3B16F82E;
	Fri,  5 Apr 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N9uJc2+f"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EA16F28B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330229; cv=none; b=q6X0zuDMQ21xOblDhBOhIB6Zx8dGLezRJOGQXVJHbYJ2wjTvTL983iDx5/hNCQxACPfcNbV5pT3taHLaKu6OeSrXG3QeHFUmFesKjW8Y0jSWACmo1KsJYA5ij475CNidfZxLf0j2F8OuRYrItZD41wJ1NJFNfp3IgrCErGKRDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330229; c=relaxed/simple;
	bh=4EVL2JNp8e2pMNjgTNNvU6O+PmK8pTlJUlQZD3nEFe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jtF31WJ2CaHBWol+GLKRuCVkNx+5G7dXhQf85iytTiOrbqwEKBAG4yJj38Ml4zZdiz86g4+5HItmBpqAx1HeuX27ae9X3DmqDjC4A6hWhNAkzxJjbjj1C4c5byJ9MAlN8VjEeIl1PHJ4oiNTOzNEuUjB0adHCjYg5q/hhhcPhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N9uJc2+f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435ETQpG015686;
	Fri, 5 Apr 2024 15:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=257TzLra1WorO4agCjkMrLPpVxuRWnoz7SjEi14wZyM=; b=N9
	uJc2+fsJVUS06KLeD8zhEf6BjcRI3fC4zq4KoRcZGFJ1afthiEPpDV1AI2mMmLyl
	ezlI6Jy2G9aepDJBW9YIa3oGXhDR9XaoHynDes7CbcT3j8B66U3tEKIe0RyfV883
	KLoEtWT1Zqf2gT0MnxrYORoGtK8vycD/dNEbSZ8IXpBIUF+Na84Ju58iBGDrmds9
	RBiik8njbRCuR/D5uCaVncgAnNFvcYaP/f3nL7h8XrPpUa1CGzlnnM6y0BaZj2Y2
	9XgqHi5kHJWLYNN1JK3cmYSr0QsjJ88ADU1nIgoZO3motqbVnEos/6hAEaboDMny
	AQ2c3dD/xcrIc7MLqB9A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xafpkrkqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:17:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FH2kD003087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:17:02 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:17:02 -0700
Message-ID: <4bfe603e-c0a9-8bfa-eda3-026613d974de@quicinc.com>
Date: Fri, 5 Apr 2024 09:16:41 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/8] accel/ivpu: Check return code of ipc->lock init
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, "Wachowski, Karol" <karol.wachowski@intel.com>,
        <stable@vger.kernel.org>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
 <20240402104929.941186-2-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240402104929.941186-2-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: r1LODWVDRryLxl3R0HXnurSBJd4yl6B9
X-Proofpoint-ORIG-GUID: r1LODWVDRryLxl3R0HXnurSBJd4yl6B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=953 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050110

On 4/2/2024 4:49 AM, Jacek Lawrynowicz wrote:
> From: "Wachowski, Karol" <karol.wachowski@intel.com>
> 
> Return value of drmm_mutex_init(ipc->lock) was unchecked.
> 
> Fixes: 5d7422cfb498 ("accel/ivpu: Add IPC driver and JSM messages")
> Cc: <stable@vger.kernel.org> # v6.3+
> Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

