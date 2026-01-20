Return-Path: <stable+bounces-210421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF5D3BD96
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 03:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4C93037CDD
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 02:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37B27B35B;
	Tue, 20 Jan 2026 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSvofj2G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CgJB4cPW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D2221FA0
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877035; cv=none; b=SDjybFUM9DlaCweGqj8/siZOjOySARPKNSf7WwUt4fOXD7GCZzPyj3oiMtq3C/Xj3vj9blWbKQ+394yiyZta+DIVuGsjizG+4jDZQWBkaSgwYoVRkdXsld3FI1E0rnzxCK3Wx39NZso1ptQrIRgDMIXfqn4t0yQEJp/rmFKZ3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877035; c=relaxed/simple;
	bh=nuUeT7gQlkRoba8PY7o/3+JBn/7v3Dz02pM/gPiGE3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWVMmbL3ybI8hCaiPFBMF/HmWzRg84/01bmRggMdT3gbw9qmHRkFzHbYYWLLyD7FjvPtZqyfqLnlY03JdGpgYRmusB/TXODYk6AhoruZ6YU3tffdEWOi2+iF/VXi81zgfW7XsbTySbypiO3KbvSeD02BlzL5CtZ8lS9wnnfjz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSvofj2G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CgJB4cPW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JGo2do1904978
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NRl6Sa+ZwZHRuOm1+JnhJZ4n5H6tSZyrGahUYzTc84k=; b=WSvofj2Ghfai1Lkw
	n/ekCft7017zUBHDfVGYjif8awVgXqrqhsEU0L1Kj1C2m6jjfd++qfyXeZjPwKEy
	yDXRmp1osxY1dxsB0joR1aNWiPGJMA7wfdi5dE+6VSIaUdzXFCl/tiNg1MtvcSO8
	6u8pRPYhRVpjHaPBjDzeygdoNSPzDL9ourbsHugbo/KsPfhmKHERcXRsqkqGVf2E
	3/H11PBbezN0yd0gLNIkHMIKbor9cryQ0fT1wLXesmS86xyQe5r8ybS81bOddA3p
	snpL9YvgB6TTUWziPGpNMHl4VGIHwVsBl4E0buhBSOOqp+hpQjC1hlFiNMHp0ABp
	Xu8yxQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmuar13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 02:43:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso8711304a91.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 18:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768877031; x=1769481831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRl6Sa+ZwZHRuOm1+JnhJZ4n5H6tSZyrGahUYzTc84k=;
        b=CgJB4cPW8JUr8ow44S7vUtZamHaSjWa9Sy2WOzkISNoxx1KG+OV/37Uyz42lUO2Jjh
         hvYmFPi7tUFDFTbrr/ChICFHu/03zE8glQa9518762Yo17sy8MKjmUxy1EPG7owbiwM1
         ZDszthVU4WPS1dFXolVYBmyOzy2Fz3LhjKyr1kjc+vJe5FK3P9n77zh/aJ7ZoVdx4Tgn
         PO1C47K0KBONdLL8BCQkwQuhH+vB6V0zvsB8z0ZERn96msuDu1nExEms1CHf01fKAC03
         Gh2brc8iYsfLfm3AQ3Lr/mTTYBucPWto4xccbx210LerofAK8lDpBEEtGQSRAOOwGsU+
         0Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768877031; x=1769481831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRl6Sa+ZwZHRuOm1+JnhJZ4n5H6tSZyrGahUYzTc84k=;
        b=rV7BEleyZq8lVY8TAgltvygBAdceP8dLMplDhyus8u7tXFUX5jNlNVbY5MjuDcLCyk
         ABs4QDpbxbTTgdhkJ2Kyxkdnamd9qeF66E4GiLwFe2Ui98D3TNh5Lj7i4ZhDSTraTYyC
         zQ5+HW0NsRIEgL67uxP1cV3lCNNC9TZPVYQTh31ao6JzQRtMrxyTQEOjEn5lgMah9oAH
         5uu+Gbn/BtTi/rKeTVfcXKGxsqPw7+4dj1seiVtHLpgfAnR3kgQCJ5jH39SPZO1wbNwl
         AQvHjT6+BA8dCJU2oREMGihR+WDHwOZBNyzsgrWfEBHBZpDATTZEy9JzLkCGmtwmaJtr
         KFpg==
X-Forwarded-Encrypted: i=1; AJvYcCVAW2fOXtdBSAcwfN44mz6LpHqBMowLMwixhn8As2TQSApNUnRrPRUTxGqI+/7qnlw1P7+LTZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4fckOu8guzkKcs6s3wloEk1N6DLeA0hveYU7K9mVGPxcPh3F
	Vd5jWWZp9/sZzFKpjGnC5A/jSIdTAgci+qaFokgRY0ykYosmnSMh3+dXlQ5jpvV1N9ViytNBvUk
	V77UaZoNTR+IyVHuzAZE53EoVSR6J4sk7xmA+fxyrUbroBAoT4fqGtijBW+4=
X-Gm-Gg: AY/fxX6WgCCYEmGH6nzzPmoNvq70GaiTmhKrPQ8vv9w0V/Uo1PPMFlyyvt8RKgDSEJV
	AVm6X5Ckhj575ROq86KyUxqk9KuqK0rwep96bsYojwWPU2yzZTZWglSn71iKaH69yr3VLk7VKDA
	pA7fbVUcEkrqQf/DVGQPHvMN4QtFUW4LznWMfUt/K3RD/N45drRanB5eTG7XF5dPgTcoiDQTv6q
	DwYqO9/KS31Qb+0xBoFsMW/TVr9y9cinI7E6qnG/Tr5UoY2sdE0mNKn0lkBRLxFmPvv/DkroFsq
	dTDjlHYmVZ3D9e+FqUoyw556/RBHHODLJLVLdPEPBbzIU9QpGBuVWmlbTzKuGghXxR/bcqXoaJR
	lhqU4QLP+6C5wS1rQSji/NDBKYYhMxqwD079U7vzhssIAGoPBxxBtFJ9Xx/Y4by9kZyMnUZ6CP1
	o+1h5a
X-Received: by 2002:a05:6a21:6f01:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-38e45e40609mr460452637.46.1768877031042;
        Mon, 19 Jan 2026 18:43:51 -0800 (PST)
X-Received: by 2002:a05:6a21:6f01:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-38e45e40609mr460438637.46.1768877030477;
        Mon, 19 Jan 2026 18:43:50 -0800 (PST)
Received: from [10.133.33.57] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf395851sm10323294a12.36.2026.01.19.18.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 18:43:50 -0800 (PST)
Message-ID: <749e716e-a6cb-4adb-8ffc-0d6f4c6d56c4@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 10:43:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/dp: Correct LeMans/Monaco DP phy
 Swing/Emphasis setting
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
 <47skckagggxijdhinmmibtrd3dydixtj6pccrgjwyczs7bj2te@2rq2iprmzvyf>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <47skckagggxijdhinmmibtrd3dydixtj6pccrgjwyczs7bj2te@2rq2iprmzvyf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAyMSBTYWx0ZWRfXwTf6IOtVEPhC
 ljjr8Fe7WTFj/8atlaoFrK8GbaDXUqwT0UWPO6IhAk0D939TfmEu4IATBhIeW+QmTL92uKOtV9H
 KhdOl0CPCwSTWWzvKItvrYRuofIBYmBb/7lg73cfFc4ordq3il0OfNjiavUM68Izu5IAcEgf0Ju
 4Oq+/kGkF7ZVOYG5ZY+vDsaDqxwRpkRIgEmrMM2NEDOqJqThHbdeTt07+QcnJqCTxL8GVhcY+qn
 D8ByEDuifrQsZa3ZATvDQnyE43aFie5fRCxE6/TK1Vus77b6/g4Yb/4DEUGQe1MGh3NYmBSUrDY
 9I/9RSBnR6k+g+GjhDBenZN61g8xxlqmZOSaKqqcP10cbAZOXF+QiijnMH768Q6kFZbETG80fm6
 CUTk5HArq5g60Wfulr1Ma2Dl6RvD3dpwZWPOITeNDiScY7Q424hVUG+2hhrQgSdFZCq1EptP4eX
 zfXCuetD/ZfPBNyo9VQ==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696eebe8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GPqq8a5sn0nJmRmufXgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: c032OStOHTMqrCgZr1CEu7UVPmLFCjT3
X-Proofpoint-GUID: c032OStOHTMqrCgZr1CEu7UVPmLFCjT3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200021



On 1/19/2026 8:55 PM, Dmitry Baryshkov wrote:
> On Mon, Jan 19, 2026 at 08:37:20PM +0800, Yongxing Mou wrote:
>> Currently, the LeMans/Monaco devices and their derivative platforms
>> operate in DP mode rather than eDP mode. Per the PHY HPG, the Swing and
>> Emphasis settings need to be corrected to the proper values.
> 
> No, they need to be configured dynamically. I wrote earlier that the
> driver needs refactoring.
> 
Hi, Dmitry. I plan to submit them in this order: this patch → LDO patch 
→ refactor.
Since the refactor involves more platforms and may take some time, I’d 
like to get this patch merged first.
>>
>> This will help achieve successful link training on some dongles.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Separate the LDO change out.[Konrad][Dmitry]
>> - Modify the commit message.[Dmitry]
>> - Link to v1: https://lore.kernel.org/r/20260109-klm_dpphy-v1-1-a6b6abe382de@oss.qualcomm.com
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
> 


