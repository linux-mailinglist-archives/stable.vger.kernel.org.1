Return-Path: <stable+bounces-135283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961BA98A4B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE64E4435D3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04D78F36;
	Wed, 23 Apr 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvHBibE0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E55D8F0
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413374; cv=none; b=gcUDqWYbzGWfylFC4C4JW9aM+3V0h4fu7OGcJ2NF7LkJ4P8s556LDVtxbLE/+ybTQVJvEcM3BGSP9vAsIBRseugKghUo4US9orcNKVyCvsfXkLcdjpa4+6rJbtVcOLijYpN34PtWpib4iBYa5m4tOwphUt5Pq5F8Ay33HnTiiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413374; c=relaxed/simple;
	bh=BnvOXO+boD8aoX/yVyEiclGZPfk5b7M+Q3WLNEqtKXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2PRt02wleq8i7JMD8kjs9r8gakzBzRmpqTHmjzljvipF19lrW+l5fuxJ+SX3wdYW/o6RPVcOPH3VYwLtMWvJF+c/BGxLpq5SC1LWww8Jnfd2TZzIS0uqbSBv8tAlhB0tHb6klHlP9WPiFzb3aDodJV+o8ktoImCDbECF7gyGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CvHBibE0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NB0YEp024105
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 13:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zfAVF+aMaiSo/7Us8CKrNfv3JkPdUAHjwZh9PyIZpAw=; b=CvHBibE04Ca2Uz9v
	lsgtR5XjledecTmtOP1xlkizF62cGjd1jH+g7A3Yadj6RK3aVxGiXykOBBWGhaal
	+oqEAQOv7l7jkwq3+02kMK91m2MxE9dt5XMEjpVTTL6awk9nY7ivOibVfqHwhzFd
	ygEFR7YcHzzT9/2OxV/G/7/wiyB1Xv5Be2f32ord0ohi6v9Llr682/iodh6WRS5g
	UN6L2glMhMHXkkEPRIo1vBwfSky54vZ0uj8cN5oI025R6VzUCutVd8LQqIB93d/y
	bVj7JGyGpHZpF3wkhj5SkmbudItYqmvSFyWEdsQCnE3+R7WaDIggDXZobQv37qJI
	K2zi5w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3a68k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 13:02:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54788bdf7so28835185a.2
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 06:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745413371; x=1746018171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfAVF+aMaiSo/7Us8CKrNfv3JkPdUAHjwZh9PyIZpAw=;
        b=XPAHx9Xfy0FGyy6VIG9ykUjifuRBEhtiF/VVzG0UccW9FOJBiCSsPhimqI5+Ov6i6g
         JVlj9FpSO997PqqyB0t4AQWTX+Iamd7zNFOvD1RREKuPzvL2LjdmHfGk6jWjiStRrIE3
         v+iBFWvIhaycygOCfhh058SoFnIcXnodwZMrlP90tfNDJIdLpC1YcIrFGYfBF5Vl24r2
         /Vo3951ERVQkwPnG06EnOTFtfX+3L54AsektmaoRHLmT4/MlVscdnf3glOS/t9nE3y0E
         dL8Z6gU8igJA2QPtOzJ1jsIcGke9ZuT8MTNWWcbTh0ONSblp2MkVfEhWbkKrTvxOWvIC
         r/7A==
X-Forwarded-Encrypted: i=1; AJvYcCXq+W+BNRNRoHGLtVkJ1sl/jQZXcF4UwE/pNam+WFGrxPT13yGUeUiupNZkqFGvR1JWzncJNKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHN5fo+qT6kr7t2bkln/BYfn285WKKRn05Le3qWxiV/VcUIrh8
	lUB40wnQfVk0dmeKFQ/m1XRzjJhRaJxGWeyT1bV44tSu63/Y8+dF55tfRYfwmX0RRLjczETHEH9
	wwV8BO8OpNFahpPH3gZEIoWvj7tsYVKCpPmRW5EfhOC/xq0tHDXkuxRc=
X-Gm-Gg: ASbGncsfwvSbSjwoWPLF4Rs1XbHFTA3DnRhwwCVU2I7kKqto9wDcfc1UtUaeLu5lo2d
	mvgs0bEAYEB4LZISeB+fOfAfNi4oUktn7/uI2qE6LWXjs+mVNhYtLpS47gkoYqZrgzpSUyz4wq6
	NWC/brUQCAakg8iEQ2qpuAyjCWu6DRLJeNZ3UWq/+HRdMq2hDq+OJ0ylpiHBq2Z+7Zn2WJDCH+w
	hV4K1iYUGTbSRM1lKNX//h37MKxc4g+4/5TgAYbgmcTTS+dZZDjaurAgT4DaODao80IxRIrIBpJ
	AxOAbeVDeBAp935ixd6/nIWA2GHTpIc6mR2O8emixduEN5Q7G5luIGJvQgoFHuro/e0=
X-Received: by 2002:a05:620a:17a1:b0:7c0:c42a:707d with SMTP id af79cd13be357-7c94d32ec56mr169897685a.15.1745413370758;
        Wed, 23 Apr 2025 06:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/ovwutEM93izQp2u3D8TlzNzpz5TZzJ2ihH4iRdeWJCL9e6H4/DMIlsm5XIOUTBCuAmehFg==
X-Received: by 2002:a05:620a:17a1:b0:7c0:c42a:707d with SMTP id af79cd13be357-7c94d32ec56mr169895285a.15.1745413370184;
        Wed, 23 Apr 2025 06:02:50 -0700 (PDT)
Received: from [192.168.65.183] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefcf37sm805661966b.97.2025.04.23.06.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:02:49 -0700 (PDT)
Message-ID: <2dae7d88-4b3e-452f-9555-05f10b42dabc@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 15:02:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add GFX power domain to GPU
 clock controller
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        stable@vger.kernel.org
References: <20250423-x1e80100-add-gpucc-gfx-pd-v1-1-677d97f61963@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250423-x1e80100-add-gpucc-gfx-pd-v1-1-677d97f61963@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VA43e6p1jUcvf4tEpmeYJVtvuehIu6kZ
X-Proofpoint-GUID: VA43e6p1jUcvf4tEpmeYJVtvuehIu6kZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA5MSBTYWx0ZWRfX7E0cV89jA1Cz VzqMCGAPe4EvP1xSBgxr7LjwNczY7D3vZt9gVd3DAJPyZkWgPbNXyeS/JEzVd0hVRuFwMYGzh11 WO1RfQGUbboAcVQIUsMLiOXC3ffyxHBPXoZ156JC6UZ+5WAWQAxMdbehJ1Mc9OHQ9pvcDpyNj1c
 BNUSXs6UsWdoMy7FmrzAHeM0G6LSvJKCnq4/6PKSLyUaQLKKPScwdmPYwM4vngerZAGtIsQ7f40 mXLPfcmrYopyXkmO068HdlADodX5X+qHDTtIpPpAc+aivaW2PLJIe9G3Hi020UD2PpJBdmEN5Jb QZY3Cge6ngqqK9sDE0n9P0cq+wcNAuH9645boy3oCobXljKWWZk/BpEQEfCu9rZc1q6xm06Q2W2
 rLmM0UuVS5JhYt1iT9aEYDDpiJVDXVYKZHrCZo9VeFxKC0GqsocxJj4FHPitri0c9v4FYCGB
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=6808e4fc cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=O4X4kKYYB9jgRp4dNnsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=975 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230091

On 4/23/25 2:58 PM, Abel Vesa wrote:
> According to documentation, the VDD_GFX is powering up the whole GPU
> subsystem. The VDD_GFX is routed through the RPMh GFX power domain.
> 
> So tie the RPMh GFX power domain to the GPU clock controller.
> 
> Cc: stable@vger.kernel.org # 6.11
> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

You shouldn't be messing with VDD_GFX on platforms with a GMU.

Parts of the clock controller are backed by one of the MX rails,
with some logic depending on CX/GFX, but handling of the latter is
fully deferred to the GMU firmware.

Konrad

