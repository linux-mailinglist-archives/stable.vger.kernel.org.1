Return-Path: <stable+bounces-177706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D9B43613
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 10:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1D93BDCAD
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4E2C21CD;
	Thu,  4 Sep 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mRR9JaMu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC472C11E7
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975244; cv=none; b=KrpC/kCl13zCOa56174chIJD7qsxWMXB3dqhme7VmlLsoasu1COoKjdhpqIkHnZvtN8RBuEJVkPKd7QOm+vJn2JU3XK4poRQfA9u0BEj4lCg2613I1vT0ZonuK7ROOZx58P5gD+TlxgVuLJWieoLdTMxL2a1rCUlWgoABOx+76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975244; c=relaxed/simple;
	bh=NkmDNo8VPDtMikBhpQmfI7PvvoyGiT1t1uBLOq/33TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgZ86FDCOluksEGlCHQTSh6RjIpdfP/7uocOkHKRj919gWkqati6pRrABnnzxP+3sJgA15wyisf9yvlWT1xIste8ytBy4nd8OtKjofZ6sHqetSWOe55zNUmjP+XkEfJ4A+pvTDtCGwL0SepUgPvGOqL5WafuGcZkyyodZ0JWDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mRR9JaMu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841KdSf017623
	for <stable@vger.kernel.org>; Thu, 4 Sep 2025 08:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I4P4Vpckc6QJ4OtjBhntsKaQJGflNRN1gBEgtyUv9mg=; b=mRR9JaMuBjiUkIC5
	iZv+AUF4xoQaK0bIgVVycAebuDTEGGDgdDyuqPmDKKLYYJ8B78r4q6ssMhNqnMPV
	2jYEFJPPg3LQ6ssw2So1aaI753Fwx+D/7ViUVzSTtCHOYbVbWn0BhcWDJAutNj+c
	ywOFwv/BkFGyoiTfMa/DtVhilXvtcF+gqkWgO+LpZH29LhsF2pOEc36CHwgozXcE
	tCQ9WDsm1O8u1+8ws28m6SQPQ6JB0qF0YfcmdsKVV+2V83au334aHNgepId9JerW
	af1krn3OwbAcdfftxQcTqpP/44LwfBJmUZW6BCi3oVLqPeMiLIhJiJGEzihdzVhW
	Fg4LUw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj3bx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 04 Sep 2025 08:40:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b331150323so1860701cf.0
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 01:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975240; x=1757580040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4P4Vpckc6QJ4OtjBhntsKaQJGflNRN1gBEgtyUv9mg=;
        b=Qjaws+94Uvp9cc07y3RpbD7orJ2so43JJfeHZH7swg+33Cz6EK5o3Slb8ot1gvo1lH
         q72QfZX9njKmV9h8++o6OEjji8sc/H1p3w9xzAZU6KbutHHLVL2tFDERkVqMO/F2YFtp
         x5juYGaPj3WHNcU6HC54qZmf+WRvYTk0syYZbk6hreJiQbrus5VuRyd2qxnrt7M7md/J
         hYsopPIME9GscbFR8iWKjp1/dxWY4mEKgkA11UztctAMRrmNY6aEM3+azrpOQpfv2khp
         Fgt3dTULh82aov8yjNMBtmOp9JMR7KcCD9CIaJisUiz6mB5Sx/bXD670ymcR6HNaxWg2
         /vLw==
X-Forwarded-Encrypted: i=1; AJvYcCWZKeqOHgDG2jpdR6guINK7OLiF/hLsLTzHUTKR93gggwvai812rzgN336AjN0jUq7erOhFgVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLsJ2+GVkaSgvuqUZQD4lhLo42oKN+VdLOPNpsxwhCVPy1Ss0b
	gSqLLdeeQ9McvQwjWEvJukmZ7LAvKW4ZPdAlZMPCGjPgVtmf6FSV7qE5umCr2TPfpz4MNHWyJED
	brsa+aRnOqH/3zMQ11PqkgAeHhFQbjmD/+bcqKfP0qQ/B6PWgyoXgOv8ZyBo=
X-Gm-Gg: ASbGncuvaIDEc59B8dLGoM/bOT0je7x5AgAtBDyYa57pk62tG2j6IpM+vaOyWB2u//m
	7a9MDbEmw4Ap/emgdtcxqDHKnVEO/80D3MWrfbNZQ3IorVzwUVh932UDvGvoKScXyhGRFWeUKZt
	oFMMa2Pr93J8ZT+1EXSq66uo0wROq6kZJaMAJRk6f/0bI2iiSlIgRroL7RTc6JIMJxopbIbniGF
	wAW71+3zrA5NG01YivueM0SUOaSj7ZUev9jnffyb71h8ZbRnw6d/hjB1gyUQeedBez0JElTqJQU
	yqu+UgAbg/OHwyqjjWOzK4JtrP0XVllFkMYSEejd9dAjv42eg8TjZPVYEL6zqu3qDrHEjJHVIam
	svx3GIHxJfrvRQHk5fDeRTw==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr176386681cf.11.1756975240386;
        Thu, 04 Sep 2025 01:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3LGMrSU/BytfgHKLmHyXhzao5cramuAbvzO2C5SkqEfzxhB2VBfo0CX0aTEn069I0+lokrA==
X-Received: by 2002:a05:622a:349:b0:4b3:d2c:f2a0 with SMTP id d75a77b69052e-4b30e9a9735mr176386541cf.11.1756975239917;
        Thu, 04 Sep 2025 01:40:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0431832a98sm886966366b.80.2025.09.04.01.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:40:39 -0700 (PDT)
Message-ID: <34d9e8eb-e0f4-47e9-a731-fe50e932fea1@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 10:40:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add missing TCSR refclk to the
 DP PHYs
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org>
 <20250903-phy-qcom-edp-add-missing-refclk-v2-3-d88c1b0cdc1b@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-phy-qcom-edp-add-missing-refclk-v2-3-d88c1b0cdc1b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX+caHlYxksAEn
 ZnXhdGL7qhIHJzSNLcDi8sgo5SSOEdHx/hLw48fPD3/b0FZEJWvxwemXPTyadVDiw41q9bje9RZ
 1zfUss6h22MeE614VxpEmXg98kUqb0GUyS4TNHj5Hj5qRlZyJsQoBOD4Df60M1wLyzSQVMmV7ba
 oeUq0eXcUh+ZOIBX0XRV6qdEdHdUX1YkpYwotUljte04kHWN94Z47O0HcsxsHJ/rpUN4YfCiCka
 bkueyQeI8hHSRh6gHpNoukbf2qzoPX7KLj+OyEG6cOg2La3ecCwGFnODPCiEHRIiBKUcY61gJoI
 MdVW/5EMNcbtw2s6yPU/IJt5orY2U9DxmyDMEdfv4OoOZ5n1+z//hGpjqKTAHtoq0vwHn/KTUNE
 XcWe8+jw
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b95089 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=LkxnY9FmGKG3Lg6D2dsA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: DUw372Mec4-5vzZDAfPYWtRX4jKbfvcO
X-Proofpoint-ORIG-GUID: DUw372Mec4-5vzZDAfPYWtRX4jKbfvcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/3/25 2:37 PM, Abel Vesa wrote:
> The DP PHYs on X1E80100 need the refclk which is provided
> by the TCSR CC. So add it to the PHYs.
> 
> Cc: stable@vger.kernel.org # v6.9

You want to backport this to 6.9, but you also want to backport
the driver patch to 6.10, "meh"

I'm not sure it makes sense to backport functionally, as this would
only exhibit issues if:

a) the UEFI did no work to enable the refclk
or:
b) unused cleanup would happen

but the board would not survive booting with b) in v6.9, at least
it wouldn't have display  - see Commit b60521eff227 ("clk: qcom:
gcc-x1e80100: Unregister GCC_GPU_CFG_AHB_CLK/GCC_DISP_XO_CLK")

and a) is not something we'd hit on any of the upstream-supported
targets

Konrad

