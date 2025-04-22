Return-Path: <stable+bounces-135044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48209A95F31
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB62A3A9451
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5458238C17;
	Tue, 22 Apr 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g1p16Obc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D461990C4;
	Tue, 22 Apr 2025 07:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306594; cv=none; b=uqX6+wS9jO5ZcL2ueIy5RXDuzPYIRYVYIX1RRJut7Zc0ZcI572/YJWlNcz5aDnpIfVdGAhXgFdRTbkEx/YqDFge2o71GO+G1xaGk5/pN7T5E7LLm8KcGVusJyypJIFxfsIpbuDzCNIXxBAK1xIY2CeykOr3OEG8TzaomNPWRuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306594; c=relaxed/simple;
	bh=l3odTGkCEPmF+UhXrqMsiq0edrsviwescjJ492AmVvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dNduCUs+ntKvqWfglLQyLrt2UyU71KZR1msRYYcgOr99VkKxMr4ntXiAEmqgcwOFUclc98U9f42xFK1y5TVIAlBDUuLdaNDm82NudWNippJjpx40kXhnWhl3Q9oGCLfE/q7msac1B1bL/fgJRMYWPR5+IE0QZzpNe5A2YYint9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g1p16Obc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4Ovqr006201;
	Tue, 22 Apr 2025 07:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l3odTGkCEPmF+UhXrqMsiq0edrsviwescjJ492AmVvs=; b=g1p16ObccMJisH2D
	vZrd88jZ8+qwD9tJ/qosCT4XgsO+Xgd/rCLxO6SC2FMqA6AArKN4JsWr7fCgzdx3
	EbEWEjWb6cvbzuIc7/2WZ15RiIQy/8R7IP3AmeTzIxVs2IbEoXI9QLe3d/mR3Vfl
	glBkNom6oSZoMD0IPZHdFnhXs9FhXUmiXB3PW+/vAZDA7IDKDhEJ0L/gD8liAAQ8
	NtKgLmqBMSewQWkfgbwwwZNQzYEli8RM1XMNBJnIUbMy+9yCs7XsxPm1rXVV+fmV
	v3YxvgryNVTVeBRjRSmpK4pDcVcgkda/qn0OkzTtZklmvDHO+y6bJf0NBG9b3k+b
	ysxUtw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46435jehms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:22:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53M7Mv4q014279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:22:57 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 00:22:53 -0700
Message-ID: <a20449f7-f1a4-409b-9330-81edb3ae5195@quicinc.com>
Date: Tue, 22 Apr 2025 15:22:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, slab: clean up slab->obj_exts always
To: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>
CC: <cl@linux.com>, <rientjes@google.com>, <roman.gushchin@linux.dev>,
        <harry.yoo@oracle.com>, <pasha.tatashin@soleen.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>,
        <stable@vger.kernel.org>
References: <20250421075232.2165527-1-quic_zhenhuah@quicinc.com>
 <CAJuCfpGwspnceQ5oq_ovViHnawcVCkM1pKawJGckfKsvK1s_Aw@mail.gmail.com>
 <6a2b474c-764e-434c-be23-2f366b81c839@suse.cz>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <6a2b474c-764e-434c-be23-2f366b81c839@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EOYG00ZC c=1 sm=1 tr=0 ts=680743d2 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=res92O2KwU_vbVZGu7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x1yb66_xOsloAML_1pzQWwFK-LBDR_Jx
X-Proofpoint-ORIG-GUID: x1yb66_xOsloAML_1pzQWwFK-LBDR_Jx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=673 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220055



On 2025/4/22 15:10, Vlastimil Babka wrote:
>> nit: the above comment is unnecessary. It's quite obvious from the code.
> Agreed, I've removed it locally and added the patch to slab/for-next-fixes
> Thanks!

Thanks Vlastimil.


