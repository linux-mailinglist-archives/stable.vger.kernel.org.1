Return-Path: <stable+bounces-240148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MrXMiF252nf9AEAu9opvQ
	(envelope-from <stable+bounces-240148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:05:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C70943B195
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A08E30115A3
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06403D6480;
	Tue, 21 Apr 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JMBrDRio";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3/XmXeU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E33D565E
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776441; cv=none; b=OIJXK5kR4O8mZo5knrqB+RSy5aIXZkn68eQ+afkvxdHZEpgoOfvwPoL9TJOEDF5ueH/3w9zb07cxxm9GUEA5944y1mZr/UI7c25mp6D0P/7OrZU50JHsa4exazq093yJ7coixof9YVGUUsqx63bn3UTW3zMST02V6OErTd/fHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776441; c=relaxed/simple;
	bh=tiwrcb1ZdzpanGae6iugYwFXzX8mwDGXiuvH1E1kdzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4r0F1563OJ887Awghw+kr0HiZjNI1oy2LYfgD0o1l9sDz3eOzVIn5kSsSCZTMCoGtkkKSVM7f6iKmqlou5J9UKXpK+EVenzQJY2994RKE1Fd3o4I6vBJdmnpXjwFoHijQI2mIBk1Qc0czB8InrZcdHRmqPVMWtGSvFg1jzUYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JMBrDRio; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3/XmXeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCmfkh3574539
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7lvnln9/rgbiDxukmCo33hD3qG0KmpVWAD0BX5Cqj34=; b=JMBrDRioSUlYbGAO
	2TDAZHbW+q46MMawUgYNH7iOkFcfVFT8zequXVB5948kDc2BTxX11Ox9vb7AcAx+
	geEeKwVNsHjF4g16csqVKoFy4f8V5MuNXhfnSMbM9h+/quUie7xcjbAfR5N3UuXA
	tL+KlFApqqimO8MGb6mH/aiDQuuO36rbYJ7woSZNL1/cO7JVgWQF5Ly/hQp6caWZ
	nGoLKg5nvA0ZBYsSXQUR4TREsOzUa8mOagtOC3hz8Fxl0Cc62G0+v8XhZ8GEnlWO
	UVQFGXMDtMph/UQTHW4OgtFZvNK8wjGWtroV/5kmkVLxbvZFx53m0fqYxNUGoHTl
	8wonhQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465hb5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 13:00:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50de6db1eabso10115501cf.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776776438; x=1777381238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lvnln9/rgbiDxukmCo33hD3qG0KmpVWAD0BX5Cqj34=;
        b=J3/XmXeUZZOsvW2Yk9kpvhmvfNI82S5f7WfOdI1UO+dLVAr+pB2Iouade0wWuhLKRX
         mWXJMfCyqzLZzh/sKraK9Ti5dozeC8gwXHzHcqzwvxCfi/C8pr++YjOKAXJhaZB9+hrR
         iBB1oncjbzqjZVnc7F4LJzg/j6coaQxrpGVqs2q6CfcvIeGv1BRmEenJvGhZBnhG2YPg
         Z5DY+6W2gALG5cdRwXt9NDsvWDPgrHGaMlgspIhGnUN2oAKmHo1jDE90qV6J8/Kk7Wkq
         zGfUhXMS2JE1MKAMt4M7xde5uJIRyA3yA1iSyW9MYcwF01upCxTVO34w/RsnBOlyvEPd
         efnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776438; x=1777381238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lvnln9/rgbiDxukmCo33hD3qG0KmpVWAD0BX5Cqj34=;
        b=MKpquYV7lpLvCmlOuWaco9e4Yjadw+joG4yANdH8o4Yr50GdbCLFGp/3G777nGIBMz
         QHvz7KQjK4BKwkwkNnAzixLHZfiAHf/MKkNwzHxEH47pVr2fZDAPLX4GlQ+cGQezWOey
         7AVcAWhghpGIjYOmJ7dJaCR/mJLz3D3mkGaQ/dEROjxoSXHT6Y3/Pa/yk3GKokl1JH7U
         bGxdOCNsgN12hX6D3j6XDPubVLP/8L0aQQ/tGEi3lUxbXmrYtvtoCbUOgBF2MqUDsIm9
         /pHPd/ydR+MfDfFLuRwn+zZuqW/9XwlJYxATseZYqjOcEVWZU0WvOfCjSaSQ0OohEKNO
         BxWw==
X-Forwarded-Encrypted: i=1; AFNElJ+o4gvpDuHvcoup/cPjQKcSXWLU4XTy869Y3XcaE+rbhfDgFRy53oB1SHG4ApuwFYbe9wT3LwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHwNgU222VAN+1DqG7ItYpu1Zsrm6XHajOPha5s7IE2RmKt8k
	Md+JSH+KdaiYVZnScmte35D/WT9Zry5KCj/aYgj6pvOthWjoUs555W9Z2H4yKWH91mE3BpYdHmQ
	AQc+c+zyRz0ISF9rLU4XzAKyIW7Sr+431EXe/434dMQERG7n90s5rVlsN6qo=
X-Gm-Gg: AeBDies+J7fOOdYUZXvSjaJ6e5IAlnoziQI7q0HdUdDwGSz7qm1ammPHuNJ0jHZqIym
	qcKsBdh9oSeV0ej0kdcbORMeUNYaQmjTGpVnaOx0JJMWNnpus9+AW6zYvrfSkGOVKgkLpR+gDnQ
	PJO+R/IgH0CCQtRq/7kxn06giHbwiMyVCjTelPMEdGAKeTwH5T396JGCwqfD0zd2hjkMRlC2vGE
	181wsri1rzuZZWea/yJVeno5IppDA+BH8y4bsSD0N0LCQOCBJtrROqdRT3njrW6vVsE+PFB9uNI
	HlSE2Qyll/FSUF1LIa2fWpll35gp+hj7fbIG4sz6Z2ocnwT6khvr9scziMC5Zd9VxIrOmnJfbPW
	nym4V8VkYHeEtCNKOzKHD4DcB8Lfv8pxS9fJsoZCFUdO6IB1fmG6nWR8qxHGElL4hofcow+ytJF
	5CaSdMK18dSu5ihA==
X-Received: by 2002:ac8:7d14:0:b0:50e:df3b:80 with SMTP id d75a77b69052e-50edf3b0365mr60847021cf.8.1776776438233;
        Tue, 21 Apr 2026 06:00:38 -0700 (PDT)
X-Received: by 2002:ac8:7d14:0:b0:50e:df3b:80 with SMTP id d75a77b69052e-50edf3b0365mr60845871cf.8.1776776437463;
        Tue, 21 Apr 2026 06:00:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455046429sm442637266b.50.2026.04.21.06.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 06:00:36 -0700 (PDT)
Message-ID: <25244bbe-0500-4712-8ab6-eca060b942e3@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 15:00:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] phy: qcom: edp: Add eDP/DP mode switch support
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
 <20260302-edp_phy-v3-1-ca8888d793b0@oss.qualcomm.com>
 <245f4589-d7ca-4d6b-8162-a86972752bd8@oss.qualcomm.com>
 <12e8a8de-49b8-463a-8b88-2cbbf1ab901c@oss.qualcomm.com>
 <e956b609-3e37-4c3c-9168-a50793722061@oss.qualcomm.com>
 <aad6a3a4-5050-467d-8ece-e83648d219d6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aad6a3a4-5050-467d-8ece-e83648d219d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyOSBTYWx0ZWRfX3E9WeqoBr8Q3
 TQaCDSVrqhvcuZ6M0xJtwL51ajcYf8RXIk2br5IqQciCr6jJD+k3rZ+0eNGmuHg1YS+3CFMUUmB
 9aPFEQWBdar2RE5PKWb2zIo9F2XH74Tn221zTNiAoic8e1nrC0wztMbS78ypb8Jvxoq4BEVmMaX
 NQK2oVEt/uEDHhwNNWApXd1igGiFBUnKbbO1nXut9vt+abBOhJMbgzd4bY6G8WJqGhdxGj9Y6t2
 3r80LjSbVjAXy/TpJluz0GY0H1LgVEQS6AtlRT6Lbnyiys44dDLXzQjLGy6Woj7Zma2dmlJNi8R
 1yCqYQONL4VHCz58TW3+wsbPsw7WCAIfAsjV8NTNcdSaJvWQlcns4BMxC0ZiI5WITXZuslWsQiH
 Mnla/Wiw0bbIaXGM9rvcFIriBAW9NAgQMJKpHPR22yrqo4vsJ0vY6V0NLl78kzLAJzhprMwMfM0
 b0z6Ded2BNqdfQwkBtA==
X-Proofpoint-ORIG-GUID: rEmd2Qx7ErqwXFcHQd55NkFjf_XjLBqb
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e774f7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9dqbPrMe-NXFaFYHzLoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: rEmd2Qx7ErqwXFcHQd55NkFjf_XjLBqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210129
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240148-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C70943B195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 5:54 AM, Yongxing Mou wrote:
> 
> 
> On 4/20/2026 8:49 PM, Konrad Dybcio wrote:
>> On 4/20/26 2:48 PM, Yongxing Mou wrote:
>>>
>>>
>>> On 4/16/2026 5:34 PM, Konrad Dybcio wrote:
>>>> On 3/2/26 9:28 AM, Yongxing Mou wrote:
>>>>> The eDP PHY supports both eDP&DP modes, each requires a different table.
>>>>> The current driver doesn't fully support every combo PHY mode and use
>>>>> either the eDP or DP table when enable the platform. In addition, some
>>>>> platforms mismatch between the mode and the table where DP mode uses
>>>>> the eDP table or eDP mode use the DP table.
>>>>>
>>>>> Clean up and correct the tables for currently supported platforms based on
>>>>> the HPG specification.
>>>>>
>>>>> Here lists the tables can be reused across current platforms.
>>>>> DP mode：
>>>>>      -sa8775p/sc7280/sc8280xp/x1e80100
>>>>>      -glymur
>>>>> eDP mode(low vdiff):
>>>>>      -glymur/sa8775p/sc8280xp/x1e80100
>>>>>      -sc7280
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
>>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> I went through everything and all the sequences are OK.
>>>>
>>>> SC8180X will need changes, but it's already incorrect so this
>>>> doesn't necessarily affect it
>>>>
>>>> Thanks!
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> Konrad
>>> Thanks here.. I didn’t notice before that SC8180X is different from SC7280, and will correct it in the next version.
>>
>> Please make it another patch on top of these two, so that we don't have
>> to re-validate the existing diff
>>
>> Konrad
> Thanks very much for the validating this patch. Could you sync with Dmitry how i post next patch?... He suggest me to splite this patch...

Eh I guess he's right.. I think the following approach should be fine:

- take your current change
- split it up into smaller pieces (so that the resulting diff is the same)
- add a 8180 fixup on top

Konrad

