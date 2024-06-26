Return-Path: <stable+bounces-55860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2B9188CB
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22EFCB22BEB
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B9617F370;
	Wed, 26 Jun 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HvQdtMPN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A113AA4C
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421852; cv=none; b=HRI8igX8haY2qo3p67hFH2RXrNCQm0QrRXVEl+ACPmAhtyzqH234v3hGrZ30+izeLw3kamPCxaXNUvCk16rvV7aM+1/PH/hBY063MDhLg+tjeLxHYj41SPopsuq1yd8jP2T1m8Pm62OrjCv/1kM+dBTtBdy5VMgx3RM3izPzITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421852; c=relaxed/simple;
	bh=5CfaMuch0gJLQt+2rQFoSea2d2JxTTTEEsrnFi6/9rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rl/vEAdA/1VCeCrubJlCDsKlpte+9n22GBlsHYw3RgpOMYPclwXcgXJucTohjdL+w8GWV/6hYGJO+LlNdjXJWhoC324OxCUc0sf3BV312bSPh8MCSp2v+4syVCvRX4sm65JujYhWOh5k8p9XUz5tCeHyYoQFZiM2/bmKlqk21x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HvQdtMPN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfVQ1029258
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VO2khDDJ1foTIuQ8V7du5tIc8EuBOC0TmFRiug6HRSI=; b=HvQdtMPNtVTzP20B
	QCgQgK6K7X+cGWE/U+MxqY9tWznrmzn7jCex5dn6qpV44oeWILI/gYXHVsGbkXJi
	9Lo4ySrq+O/S7hIPBP2eH28i7u8+grZDQ1WwD2LEMnddUBHVL7ITH3hq61ca6q7M
	ww0FNWr5XdHjJ0qydjeoxBuQMxyEmdUFK6Kj+OI1sCP8eXvxm4pRtzMluR3qZSgX
	XvBfkq8gSA+jNa+wHKzew0iK81fNdZYBySFvnR8Zi28pxC4viw/HTJv8/HcBBzO+
	nryH4jyPs4Z4vuhIQIUyki7Ln5FX14zJClC1J7Yn/ATG6kA0wODLh8NtMxfzQ0hX
	qkFvzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6sw2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:10:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QHAnex006730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 17:10:49 GMT
Received: from [10.216.61.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 10:10:48 -0700
Message-ID: <d5dcbfca-8cc0-439b-8127-483b8374e84e@quicinc.com>
Date: Wed, 26 Jun 2024 22:40:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] arm64: dts: qcom: ipq6018: Disable SS instance in
 Parkmode for USB
To: <stable@vger.kernel.org>
References: <20240626170808.1267243-1-quic_kriskura@quicinc.com>
 <20240626170808.1267243-2-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240626170808.1267243-2-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cqFA2tJtylpxfLNUYyBiyvXXuvIoG5wW
X-Proofpoint-ORIG-GUID: cqFA2tJtylpxfLNUYyBiyvXXuvIoG5wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=395 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260126

Please ignore this series. Sorry for the inconvenience.
Was supposed to send this internally, but ended up on the list since the 
stable kernel mail ID was CC'd.

Sorry again for the inconvenience.

Regards,
Krishna.

