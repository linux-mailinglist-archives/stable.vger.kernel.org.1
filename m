Return-Path: <stable+bounces-158601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BAAE8709
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F7E3A597C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514841D5CFB;
	Wed, 25 Jun 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YDMPZmUS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC21BBBE5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862941; cv=none; b=ugPHPYBanFFDVc2t6wFZiPdHLR+0ZnM4ykNyAv0CTINXLQuSq1lTtao16Tr7fPTjQOctxxNvcIg5kubnNJqRCebxPKIBMY6O1aSn2pu9mGDs88yXOTJU1L6H7JmZ+Lk0ccEFw3U+LgHszrNGSlXQ3xEGIlpUvDFJeCmpB7duHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862941; c=relaxed/simple;
	bh=BWPoKXwqfeDMulZOutw5Fsd5LPnsifJw/UB3yiZ9u3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDdTZclcOax5El9KpXphuWscaVZxi5vv2WpKDUdhXiUi+1qvG8Ljxj5Z6rPJv5Eb/oz8E11rQExQGmseYVvSvDv8R7WgZSOgb9+Zkq7dQ4pb5gDxU12fuodsHGjz4/u0UWiddNBTtPE2mVuGobvH3nNnhdrBrem6g2Weye9CAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YDMPZmUS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PC4305017315
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqGGFhx6AVCTLXfpWHpti1jyp5AazE3wQBZfo+NlLJg=; b=YDMPZmUSCEGdHORf
	VKxpYOmQXtgilnrbYwx3ONk1guyObWr6p5Z2iWrVitTkdtaHr2elr2sP97BlTOWB
	Av4816s0UV4DXyLJMKu6fzlZQoqSFWQwpmHYc998VHerijgYr1H+/zCJrR2WQgSK
	qGzDSjXY5BJzv0uaqxoaPKVrNbZ8LvLU1ZO3qHTIdFP3qXaSFmRdnniaLjFpcgOy
	UXSEW6CNNwC/p1DomXr1IRzyEIAJmjLrOdWz3PLMmbb1u32VrGhTdXco9w9ULIop
	OJg6DZc65BuA0trhL8fK2hjgF2yxhB/wjF4CcbyGFBjo78BvyzigiYFCAewrGGXM
	BMaNkQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4sfyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:48:58 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748d96b974cso1323179b3a.2
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 07:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862937; x=1751467737;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqGGFhx6AVCTLXfpWHpti1jyp5AazE3wQBZfo+NlLJg=;
        b=BD0fxH3YDBe0wS1WEaBkUC5N7f7RCiRlRA/6k9RDIXhcw1URlPrqKXLXOeoZMRPGvb
         QZGqlaGDSJOwtDJ4ttqfE1rypjQQGSAIsp0mQ4CsZmvqxrfcGQwszpfzWEIFIYrIR9OO
         IeV5SBpueZbpigLKENXcKt93xrog3qop/257GS9UcCsIzgYvRpjUdKgNpgn8JuJx+ft/
         J7eWvqL0OOECT7W25RaOALWid9HS0UEAn4v3R+Mt4fr3mI8hCfyaYLiviXY/JH4dsEaM
         TdTGjC5PihEC9S8aSNdqulRmh5h2qlCohrXeMfAuMsUusrRXvd/BRwq5lfJNRLSvy2Za
         UDbQ==
X-Gm-Message-State: AOJu0YzlBZ70Xyfvk8PnlIckz3fUDCqUVv3DFOoA+FC34M3UtFHzUnys
	7MhjjKVE04SXuQm2KixxnboRLqALXySyuyMXcqy1CqnFlf+f2W5sWLCneJlkmbDUMjYqrYcf/y4
	XArFdgbLUw3PKTlTgFVdGJ+iFEBmzRslbY5pKq63BRwLoLBl/2UJZyMC/BYKmqt+2l6U=
X-Gm-Gg: ASbGncveY+i7yBKKuEqP3IMeDzQ8dmi2GDRpppv0OfxoeShyGolla/S+Z1FgerXEaBN
	teGDHDl1KlpTcAGyAXCiGqRtDCbVg2a+mFekdHjLbA/cRgucwqFMkrVgJts4yIehOXjZcIpvaMg
	akTOFzke4OkNq+rPepYUw5VpLzYRCMmlptw1qZTlGuTTWwrZDsYVKItqu1vNd/bEthIeKa8M258
	7g827577jhGIPOykRgQLSLwZgwPlayCDV5GL7MuGaVJuBIMjCVU+3DAVTayu6Dam9gHgBAyAEk7
	pJgUTp5MY+vrcH+H3H77RkPVdsDqPrEeW6vdcEIqOF8FgHM778oiY7WuToyXq/iTIkqQNjwKHBV
	CsA==
X-Received: by 2002:a05:6a21:38a:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-2208c610eeemr176611637.34.1750862937329;
        Wed, 25 Jun 2025 07:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+XHscp/yEzgIUgr5HvkN796Je8M5rUAoryyGJvsCBmHFT8xX3ENlpIX1qc5J+I50JLhQlLw==
X-Received: by 2002:a05:6a21:38a:b0:21a:de8e:44b1 with SMTP id adf61e73a8af0-2208c610eeemr176572637.34.1750862936922;
        Wed, 25 Jun 2025 07:48:56 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f124249bsm11161411a12.38.2025.06.25.07.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 07:48:56 -0700 (PDT)
Message-ID: <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 07:48:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
To: stable@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregoire <gregoire.s93@live.fr>, Sebastian Reichel <sre@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685c0c5a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=dh4-YsZgxDmbEjmCT7kA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ny34fwfeLw_628bn1-JOMFhGlckBa_tl
X-Proofpoint-ORIG-GUID: ny34fwfeLw_628bn1-JOMFhGlckBa_tl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEwNyBTYWx0ZWRfX77bNTGKMx2Wj
 uPQx64yE96cARtVtDin5wNTShLzDZm6P6ODoekX9wCvpX2UECslXN24U7+d8MLevbFJTh0zLJUa
 pZnaFoA6y6vONpfiKB6m0K+BrGR9sZn9x+FBqDUFNxgvNSQddPojn2UYifSCha+OaGG7XTP6EnW
 3SnjKysxEFTut3Cy1rhakK1kK/kuYPLai6Q6C0i+gjdnjfsWIgUEInRK7blUl09xhkblzrYD7M2
 z7qRBJ0JRGKRXZmeBO3IoLOu6RW6d0VEzqSJYmtoUgb3mua+1UB52VW9hQ3PMWb6ZDIird/rfqB
 3PrEvak814vf+7PWGziiFH8CMXaJhIxmuFPBmPNQh99yIEw/R+Smx/ir22f5v7WUzhsBJUXPmiv
 OW/kCfcOZx6j6QBavfP6yJYDJGa7zeAmRYVlbBhAudgtF7XlxluwxlWF22v3XPCh+SVE7VyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250107

On 6/25/2025 3:15 AM, Baochen Qiang wrote:
> 
> 
> On 6/25/2025 5:51 PM, Johan Hovold wrote:
>> [ +CC: Gregoire ]
>>
>> On Fri, May 23, 2025 at 11:49:00AM +0800, Baochen Qiang wrote:
>>> We got report that WCN7850 is not working with IWD [1][2]. Debug
>>> shows the reason is that IWD installs group key before pairwise
>>> key, which goes against WCN7850's firmware.
>>>
>>> Reorder key install to workaround this.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
>>> [2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM
>>>
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---
>>> ---
>>> Baochen Qiang (2):
>>>       wifi: ath12k: avoid bit operation on key flags
>>>       wifi: ath12k: install pairwise key first
>>
>> Thanks for fixing this, Baochen.
>>
>> I noticed the patches weren't clearly marked as fixes. Do you think we
>> should ask the stable team to backport these once they are in mainline
>> (e.g. after 6.17-rc1 is out)? Or do you think they are too intrusive and
>> risky to backport or similar?
> 
> Yeah, I think they should be backported.
> 
>>
>> [ Also please try to remember to CC any (public) reporters. I only found
>>   out today that this had been addressed in linux-next. ]
> 
> Thanks, will keep in mind.

+Stable team,
Per the above discussion please backport the series:
https://msgid.link/20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com

This is a 0-day issue so ideally this should be backported from 6.6+

/jeff

