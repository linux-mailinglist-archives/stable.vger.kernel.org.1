Return-Path: <stable+bounces-204582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEBCF1CFB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 05:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B494D3000DC9
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 04:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D30324716;
	Mon,  5 Jan 2026 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BK0alOoO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gFC8KSRa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E331AF2C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767588906; cv=none; b=Df8uljEX2uddQbKxIs2gle8j1KLFESEAr8aP/xK66FXZQ35sIlwDaWBQqAKS8a4sTBKr0UAvqGg+8ufDZyXmotJ1A5C/VXvX/Ewwdgrsj72DZpJuzUAFPXR2hw1L3OYLxvdI6KazCqvjr0gO52m4FihUyGHhCmyrJm6o7p0D4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767588906; c=relaxed/simple;
	bh=D5+wsa8d6AKmE8SYNa401J10zc1Opslrw81zmIM508M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHkQUofzdNqTy2CdSPl/7ct0unYubgX4CmimjbzvMyarj9eub1YSxJScgzLXP8jbfK6Pa4dlb/zMeAgMKeS28IEhQ+Yca6VlgFHBycHwRUHyB6sS0Si4bLw3KYSYMTCfO1Mbs4bmE+zCFxzcH1MDJp8WSt6ftQS8PEuXqFEZQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BK0alOoO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gFC8KSRa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604NeJHo3941330
	for <stable@vger.kernel.org>; Mon, 5 Jan 2026 04:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nm45HE0wSttWHB4PgGIZB5I7jtkr8Gbc6fC1XCjkHhA=; b=BK0alOoOWdTxtjPl
	kW2eYUTSx4H7NwY1htIeUjYYNE3XumbtgSNp1SSOM6TLc4u5OTOeKy+IIRx3wLGy
	BOPVQpzZQBCgX80WccgDNhqFVhz1B3wApbBipa3xYEXKhJZbqgdVa5BJXS4ZslyI
	3PPfe4JBv3N4S80oW3gEICDKENMcMT2WOaZ4t6wi2+a5KmryAndsB/5011Snd4a0
	qLHBT8B0TWbQ23aGkTudioiBcyGxYuxfWDigs3jN6ccK37RBCqy3SXos781yMvPf
	4jyxJ4RnebYY+zGmHKnZwBJHaHVN6UdQlq7ePEDxQ3NeXSySWnB4JS/O+VRFqYkY
	tLU9Fw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beuvd35se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 Jan 2026 04:55:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0e9e0fd49so15292135ad.0
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 20:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767588903; x=1768193703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nm45HE0wSttWHB4PgGIZB5I7jtkr8Gbc6fC1XCjkHhA=;
        b=gFC8KSRa6QOxLNCr1OaToNrPKCyQboUkDZ8TBgJLG9s9JZAdYW/PTNl5KQWCb0X+4+
         NieJXJnP9u3GjtEN/ofZI07qslUhCKEwGa2dACFzR5Sc9weyicS/KvQSiFCLLW4VMnoP
         /zsO+MVnomMsKgTw22As79N+A5YYq9vNuxWzzM7JWABVZBcwGZCOQeTTM0JChWctle0R
         5cuyHBdIDJpinwRUN1xFkCAeCfsma26U7R0MFGMToahwmoYj+yT7WeOUM0H6sZkMY5MR
         Npref23+OH4d9ausNyP7YeN6cHt5Z8zVq+B6baxaoNDmNA2HfS7JZdVVcP5cEszzb/Cy
         M/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767588903; x=1768193703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nm45HE0wSttWHB4PgGIZB5I7jtkr8Gbc6fC1XCjkHhA=;
        b=OkZ8LKgjSz8Gg43dTdp6Btp+Yrf1O1DIUB5T1euSrfi5aUsFGFS9BpDDN7cU4AU/e3
         QmKwogIdxUliFWLZktXugfqVlaHys9FnSL27YAB8uIrA3/aOINZCtpGSv+AalNovcjf2
         +a54MTWNiyRKu4sDVUavjgBNOwdrIibki294N2VG8UH6QHgQ5ufRF9vHN2eEO/SxUHpb
         D5jmuwLspS6RQCNTj9kMy/AJZgbLDBjfRlQDQ1jUghWM2lmwBIDAKolE6q7uXFBHYS+D
         8L79ok2DrgMJUgSTWc4wU9V7UVO1ChH/DQad+3wLdZGyQ+DdH/ZOEehc8iVvFZMZHRpR
         q1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO6+xelc1yNO7dRD22oeSkDmL02jlZXRT7UGCdHyNPzEUxWOf741Voeefji6ud6CU5H2hlbXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUwf0OLJWUpzjnRIrt7btmzHTO6TovPOKSf7bTsVZEoKaRZCu
	Un/DYL86MXUu4OQniMbjf3kePWDCP0Ika05rpfwwfFLAwzujwiTBBTSt81wZaacRRm/tiEmA6jF
	g7dgIDVLKXBqX2H9PioQv3Ju4VahWSAd6IXI70KlNUhOC3DT7uovGHXuafCE=
X-Gm-Gg: AY/fxX4cULE3fauUwcQhe/Sp3BJ4l5I+RG3gfv9OidsJPyHiO1XkOKa7YAxDJEjowAh
	qhF0PH5rheTRlPhgzD2p2Mx2g/B8yXmV5Cy0NsOYXc0U8AxbdZAALIoAx1bCYqeS7rbJTV3s2eQ
	I882xWjJ/hKWmK2r7CYo/+oN2pUizAyI+xjJJb3jquMVxCazsZGXC0b+LOLInyYQ6t8KL6AZJrX
	8CIf+f6L/j/OF5/9IIOvT4IKu9yckwbDN9ilNSiUWHPjZEkR7TvfBkENB1RLMC5y43V0w+H7Iew
	e52m29wY63UTU7WIVVG84yNkxUt2g8Yk83BpB3OTQNoKZ+kHrC09wa216I87wm6Oy7C5ZKq3N9R
	wCzcKENLiEc5xl2MypBrS8iVYPZFeG1IoKL9v8JWxMQ==
X-Received: by 2002:a05:6a20:a104:b0:366:14b0:4b18 with SMTP id adf61e73a8af0-389593bda2fmr5948209637.35.1767588902901;
        Sun, 04 Jan 2026 20:55:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFacj7culxX1WSh1Rq5jfZxcULqvVOrEjZIp8JekHVlP7djaScfvXdTMwv9fW0VLbjINJOlHQ==
X-Received: by 2002:a05:6a20:a104:b0:366:14b0:4b18 with SMTP id adf61e73a8af0-389593bda2fmr5948184637.35.1767588902398;
        Sun, 04 Jan 2026 20:55:02 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476f8f3fsm4806409a91.5.2026.01.04.20.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 20:55:01 -0800 (PST)
Message-ID: <32f1b476-c3b5-4912-bf60-b24ff67a4320@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 10:24:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com, stable@vger.kernel.org
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
 <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
 <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bzy5pz9aMqIi589qb5tmgaXnATNLFfpN
X-Proofpoint-GUID: bzy5pz9aMqIi589qb5tmgaXnATNLFfpN
X-Authority-Analysis: v=2.4 cv=OuhCCi/t c=1 sm=1 tr=0 ts=695b4427 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7th-FYyNm21myA_937sA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA0MyBTYWx0ZWRfX7hMmTwTiEshG
 VEcP4bEDL63ubfYmz/o2WVj70s1g+tiuV1Oar6gNr/bnLcZkLkM61vnq98sR9/ny+mkSsOZrYyH
 YCi+fD0w4/qATSpdAKanUuGurG+LYe+z5u4It1zNSfvUmxMzb3hoPfsw/y1JN0Hxt3p8BGgmw3B
 j2jKYpsZTxzdDJ7DWHc+4Bx8OfY1D+X+Gt1PtDJNuQSPaEBBPZ+EgTlvX6BMuZCR5VzyVTfJGaF
 ZeU2oMfk+Ys+1T1ajo6rWsJesfU6H/yoWR1xyZeoTVZePYQbO7EOxDnhJv/jtBLleanVyt+xAqZ
 Be3UQMmVkUg4Uqcup0RGwYBTe0+FE1/cP5+0NwNyz1up+af0NCm1CQxOO7LcQ6qBOLlv52DOLWP
 3lZfzYMSHlTk8KZmSKDsCnMq6JDKszDtTdJbF6xt5e3k8RlNP8fQgLqirZmBenYdGNctIzKZAYS
 Hd0R/YfkGTYG2af3TzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050043



On 1/2/2026 7:27 PM, Konrad Dybcio wrote:
> On 1/2/26 2:19 PM, Krishna Chaitanya Chundru wrote:
>>
>> On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
>>> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
>>>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
>>>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
>>>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
>>>>>> can happen during scenarios such as system suspend and breaks the resume
>>>>>> of PCIe controllers from suspend.
>>>>> Isn't turning the GDSCs off what we want though? At least during system
>>>>> suspend?
>>>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
>>>> so we don't expect them to get off.
>>> Since we seem to be tackling that in parallel, it seems to make sense
>>> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
>>> "off" could be useful for us
>> At least I am not aware of such API where we can tell genpd not to turn off gdsc
>> at runtime if we are keeping the device in D3cold state.
>> But anyway the PCIe gdsc supports Retention, in that case adding this flag here makes
>> more sense as it represents HW.
>> sm8450,sm8650 also had similar problem which are fixed by mani[1].
> Perhaps I should ask for a clarification - is retention superior to
> powering the GDSC off? Does it have any power costs?
>
>>> FWIW I recall I could turn off the GDSCs on at least makena with the old
>>> suspend patches and the controllers would come back to life afterwards
>> In the suspend patches, we are keeping link in D3cold, so turning off gdsc will not have any effect.
> What do you mean by it won't have any effect?
I meant to say that in this case we can turn off the gdsc and it won't 
have any effect in SW. But in non D3cold
case the link will be broken and will become non functional.

- Krishna Chaitanya.
>> But if some reason we skipped D3cold like in S2idle case then gdsc should not be off, in that case
>> in resume PCIe link will be broken.
> Right, obviously
>
> Konrad


