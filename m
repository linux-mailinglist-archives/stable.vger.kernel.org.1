Return-Path: <stable+bounces-192827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D20ADC4392D
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 07:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 176494E3F0B
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 06:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D172459EA;
	Sun,  9 Nov 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n+JdvuwS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3423DEB6;
	Sun,  9 Nov 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762669439; cv=none; b=EAPmh6OVxSXuJRKcZst4iGTJclfx9XVwDqP7IjuEtLZp0mQe5nrOlRpIfZuq0gqZE8LPtOzlud55BElmvzPSOEAgv+kpY5xnF9xqUAQA4Yd6CLmGMfn0i4dW7CVV4Schg0c6LnOn8FRrQ9fDBL2v4d6GCmbMCjxbzQ9GiHG2r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762669439; c=relaxed/simple;
	bh=ZA3WOin+Ic+7yNFAqgJtH9uboaaS+mRnwgM13YBtU+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p750oII+FNAh8buyL56PeKdyLeXnqADPkD31L2XScgq+fgPsDYXtSx7Z3V//TuGlhadR6+V9my4oxQ0KLtuzdix0Mi7hAYIkz2JjFeYlkk0SOVVeDjgM9jNCcvqrFBh9T5WfLH0qBl7PB1K4EaRO2S1xIXzwuo8i8k4RsFngqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n+JdvuwS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A93gDiT3405494;
	Sun, 9 Nov 2025 06:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1PFVwLU+PwPAcQxv50gU88qqYYM5kLsABu7HUle+scw=; b=n+JdvuwSnzYBzIy9
	VWbqtbmo+14euFGwTxiNqwqyHtLShTqIzFSVrLsv//BpbrQ7Q4TQNJiPN+msDFsf
	29BuLOhb6pWqTf1BpSmxhccv5lmOjxBXQvoWqla/rkvP1jEGeHFXgG1etnTTrLpl
	7snyBBBExCJdWZn72jEH5ZQu7BgraxYSZCJLZSPqD8ks5p3faa/cYvPRimliLONj
	u6sv9/0Lq88zieCqS+uZ+ePP0E50AcYcHHotlqyGoaIE8d4+8zQ+ubajhPZnB69k
	eiAX7P7sX/wifepYxehHjPQtt7zhJjCHNxL/dj7Qm+on8cAScHwiKChRU2nbJ3ow
	mQPcGw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9y1h1qce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Nov 2025 06:23:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A96NmgR001804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Nov 2025 06:23:48 GMT
Received: from [10.253.12.191] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Sat, 8 Nov
 2025 22:23:47 -0800
Message-ID: <41684170-b9d2-4fdb-8c7a-ecb0bc9a79b9@quicinc.com>
Date: Sun, 9 Nov 2025 14:23:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: add new custom firmwares
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        kernel test robot
	<lkp@intel.com>
CC: <stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
References: <20251107125405.1632663-2-quic_shuaz@quicinc.com>
 <aQ3sbHDGL4DQAE8J@4b976af397a4>
 <66bjkpos6ul2gnh4ezmtidjguv3qx6bedhlihbg4vtdkmnvsrb@jmojegj6ijf3>
Content-Language: en-US
From: Shuai Zhang <quic_shuaz@quicinc.com>
In-Reply-To: <66bjkpos6ul2gnh4ezmtidjguv3qx6bedhlihbg4vtdkmnvsrb@jmojegj6ijf3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mxsL80OHJqHLWoWJf0l8X0a_7F_BKh9d
X-Proofpoint-GUID: mxsL80OHJqHLWoWJf0l8X0a_7F_BKh9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDA1MiBTYWx0ZWRfX5TloFg+eEeSJ
 qed81VuMW33mzRtS15RtCNv/xmIqn9k89ZR8Z0AQaAbNlIlYd6nZzg7vBvtZxsDmn6zn1FCxDV/
 N6Cf3GVg09cKzlYeaYpwMoFEYn4R6thgPlP6zRurI8ZswLhGHoGqkcUa8OUFrPI7a8jzyQ3nDF/
 CML1Or9fuPSDF9SuV60AAjmU/kc7wngZ6cLEsvrlv4TZr1JiPa/yfszAvC6sBwjSR0Dv2nR/HJZ
 dy9R4ANa80QdQ0Lm0wzzTWcEpQn/2Ocz1Cx3MIcvwLHBr61qfPWvC+xlUJtvJIBcRlKrJswDhMQ
 DsLf1WUIbqf/+HCd1bdzm/x4xGoJwNkm0RSuCglh8AfbkntQsKl+fL/7cZyWmROP3Kt+uA82+AN
 5vUQ4xS0jioF5uwZFob/KSIyoEz7Ew==
X-Authority-Analysis: v=2.4 cv=Xuj3+FF9 c=1 sm=1 tr=0 ts=69103375 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=Up1s5pyZt900Hf9bEyoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=TjNXssC_j7lpFel5tvFf:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090052

Hi Dmitry 

On 11/7/2025 10:14 PM, Dmitry Baryshkov wrote:
> On Fri, Nov 07, 2025 at 08:56:12PM +0800, kernel test robot wrote:
>> Hi,
>>
>> Thanks for your patch.
>>
>> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>>
>> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
>>
>> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
>> Subject: [PATCH v2 1/1] Bluetooth: btusb: add new custom firmwares
>> Link: https://lore.kernel.org/stable/20251107125405.1632663-2-quic_shuaz%40quicinc.com
> 
> Shuai, why are you sending a patch which is not a fix for inclusion into
> the stable tree? Why do you cc:stable in your headers? Do you understand
> what stable kernels are for?
> 

Sorry for the oversight — I forgot to remove the Cc: stable@vger.kernel.org. 
I will correct this in the next revision. Thank you for pointing it out.

Best regards,
Shuai Zhang

