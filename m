Return-Path: <stable+bounces-139687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF13AA9459
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5588A179025
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7CF25A2CD;
	Mon,  5 May 2025 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4LYVcqN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7D25A2A3
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451371; cv=none; b=qDu8hlvF9ATwfPbtPeUpL5vz+k+rk6yVTa/eNUMOEFi2/V8MtxBoAWIG/p23OcFMGza7Pwn95U5R43eaJcT4/ZmT4haziY7I+ckFd2a72YlIN73WsyO3KXh8D2Sp2yzUZZvbehS9FCeFFKmA+fC5RBQzwATJ2jxn3uOEES79bjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451371; c=relaxed/simple;
	bh=6b6UvFMmR5hwpyVwUTZJ+FnF2O3Be9wTrs/DC2KR41g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoSqC1YiMU0ejYA1Q58WADARXYSoz0mbBKlIeKXXF+IPgXKR8rSzRdaBGKuiFS+y6LnYglS58cbbHwSsYXHt/dYuFRQaby+VEzqM14ZnKoM6nJeDVxXYzC2/kF0Kd5AxopLFVdUjwqdzoTn3y8+EF+1qf75/+75HXxGjr/RQMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4LYVcqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545CY8go021369
	for <stable@vger.kernel.org>; Mon, 5 May 2025 13:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ipfJB44vaRrzzYNTr2RsUlxdMWhli5auraPTR3Cgev4=; b=Z4LYVcqNuIgKiZuC
	gpqHd1nOQkIWqdsTCdDD/SRC6CD9vxFK8GqqyRxpK/1cAngXBYt9yP4y7PIgXc19
	hF1Ldglx+Z/jdO2/LB2crwfHJw4x5e529cpCTdBfOZekjg71Pw6NT1WrK7OmKtaH
	6DklgYiPkci+Uh9MExRHI0K4DQ85vUWKuLdyhkFSmnZ+KFeKo1nmNcM28pbXUvo2
	WUH45GXdRZeGPGD2hYYmXLVEpCRbRB+NpVs3lHvWHMcV5w++CTAEgeymmcJ9x7ZN
	vvPNUzvrw7svlrwBCOCsXG5lc1MXBVpXsRYtpFKWgJWN13j9t2z+lyp6g6C6MIKP
	2YDaZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46da55v6rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 May 2025 13:22:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47b1b282797so12486331cf.0
        for <stable@vger.kernel.org>; Mon, 05 May 2025 06:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451367; x=1747056167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipfJB44vaRrzzYNTr2RsUlxdMWhli5auraPTR3Cgev4=;
        b=k0qwpmbA+eU3cSDhAgK9d8rFkqIcROgbfS0/DVZU95u6kqP3JJanJv60sHkThbVQuE
         PpvnsVXN2bl6bLHgk6z2bPh2jPiobSj3vtV85z2Rj1LtmAiXwIBO4GOTVmvgb84o+L+4
         uYxOFs7VayISSDqwuCjWyoiM7rpDqRjvXa7lE+XWm90znqhg+siYFbsIK8+g25fSzzZg
         fUxBGQ1NY/vziQNXGlLl8WaHe7+bEx0cRqj0v8MB7sJvSHe+IYD7Ou1D9LpavvhUTh6x
         m7MBFxJWIHClC9JBAAMW7/+93y3nwFcUW0EXDhfmG69kgHEPJ9OnbrIdMs3l2MqqdK7l
         TchQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxlGbnu7i37fdYunn4zoVheVS+Xu57C/0/C8i8mbXRwxOCZ4FV8G1ivx4C1gabu24GezMIGOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4PHruW3l3983XVsGGgSl/+y5lxdb9D/0O9WTIVrwKQxzoDz9
	ZyEAZ8J2pvShazdARjHfHtLCo2jpRK66pVNuxPaMF1YT3LDU7LoZ4KhXQ94BYUIQ0rwYzo8b+4h
	hbPqW1QfbCgfFVW126qpVdGnYHrILsEwCc/c8sG0DEEOLMm2qqj0WeQfS/LSNFDE=
X-Gm-Gg: ASbGncvrFwZb4lCBPTmC9Pq5CuG+HVYPbytFz8n6XhoDa5WjPRo2OsSGz9zqDz9CIZs
	XfIBtujmRfpzc5dwrec0qabhHlFhPPtDJ15WXZNogxSc3Z/8mlSHOOPEwltoRpVvox5m2w5fsTv
	rMJEgP+Ws+yHWg6yvqh5Grxg1PvO+0nNl1P4e9LLTppcdT57HQR/0xsTwDqJbLizp+Jk8LPALxo
	Ftfp/q3gInUQiYPzosQPhWNvpaPeZbCbzptQwLOO4Tpu7NpgT6JdYSAvpFXxdif0CRSg7UDvpp/
	52v4nCSyDfbkYchpA3iftCtqQCGJjLpB2EMOloh4gkjvd/xmA+We78MW7+gTDz/ti5U=
X-Received: by 2002:ac8:5996:0:b0:48a:80e5:72bb with SMTP id d75a77b69052e-48c30d83ddcmr76442221cf.2.1746451367453;
        Mon, 05 May 2025 06:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjFC3fECabwesq4x5Fiy2V1yv92KY/9fO0f8AU4OsYx1OHQ7BrNcRSdkmpG2hw9MT3iHS01A==
X-Received: by 2002:ac8:5996:0:b0:48a:80e5:72bb with SMTP id d75a77b69052e-48c30d83ddcmr76441901cf.2.1746451367042;
        Mon, 05 May 2025 06:22:47 -0700 (PDT)
Received: from [192.168.65.169] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18950ac90sm494506966b.150.2025.05.05.06.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 06:22:46 -0700 (PDT)
Message-ID: <1cd1d97f-a6f1-43e6-8451-b9433db93c16@oss.qualcomm.com>
Date: Mon, 5 May 2025 15:22:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: qcom: Add missing bindings on
 gcc-sc8180x
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250430-sc8180x-camcc-support-v2-0-6bbb514f467c@quicinc.com>
 <20250430-sc8180x-camcc-support-v2-1-6bbb514f467c@quicinc.com>
 <20250502-singing-hypersonic-snail-bef73a@kuoka>
 <cbca1b2f-0608-4bd3-b1fb-7f338d347b5e@quicinc.com>
 <35662ebc-d975-4891-8cbb-1ba3c324f504@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <35662ebc-d975-4891-8cbb-1ba3c324f504@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEyOSBTYWx0ZWRfX4RhlVqXdsLfh
 IbIVLipL7Tnz9apMRoLWPrnpLKXYlNWEk37tt8IiXo/ClHBbbHHBynlkrO9zhkEISsxac7pUnaQ
 9p518SRMDxgsMRRZDqIovjlvMEqYpOD3o8jRbZW9P/YguaYwZTTHbTCODkWM/nNy8By+Jtb2m3v
 sw2uq22t/JYuPd3+1+lS7fDUsIg8Nw/AK7nWRIXWol2xLjky0o3YJoCUld7mdVUXVhN+bCHaiuX
 7Zu3tu2ADhkfinkrNsClL75rrHKSOgW0/GPAOOFyNfSkxzOeYyAlC0FDU5hu9XtZV5dDnBZEWwM
 f+O6nsFV7UhZJkwxOXbUT1Di4EwriEWkQT8v5UdrDEc+jEwY0qKA/nu/3cWktmbfhscfqsmeaEF
 LFPeoVg4pOBKHtL5PbTHMMhEcfgYrhG0TFboUmzooDkCIrSjggctzVHU8EmacwPbB9cYp48L
X-Authority-Analysis: v=2.4 cv=M9RNKzws c=1 sm=1 tr=0 ts=6818bba8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=bJQp2htD3s1xF4Ub2coA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: pDtQmbUfE5ypAbMaGoub8Qi5TUQltuwD
X-Proofpoint-ORIG-GUID: pDtQmbUfE5ypAbMaGoub8Qi5TUQltuwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 mlxlogscore=826 priorityscore=1501 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050129

On 5/5/25 11:46 AM, Krzysztof Kozlowski wrote:
> On 05/05/2025 11:43, Satya Priya Kakitapalli wrote:
>>
>> On 5/2/2025 12:15 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Apr 30, 2025 at 04:08:55PM GMT, Satya Priya Kakitapalli wrote:
>>>> Add all the missing clock bindings for gcc-sc8180x.
>>>>
>>>> Fixes: 0fadcdfdcf57 ("dt-bindings: clock: Add SC8180x GCC binding")
>>>> Cc: stable@vger.kernel.org
>>> What sort of bug is being fixed here? This needs to be clearly expressed
>>> in commit msg - bug or observable issue.
>>
>>
>> The multi-media AHB clocks are needed to create HW dependency in the 
>> multimedia CC dt blocks and avoid any issues. They were not defined in 
>> the initial bindings.
>>
>> Sure, I'll add the details in the commit text.
> 
> I don't understand what is the bug here. You just described missing feature.

i.e. this patch is fine, but the fixes tag doesn't apply, as it doesn't
really fix anything on its own

Konrad

