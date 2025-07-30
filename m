Return-Path: <stable+bounces-165512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3644B15FEB
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F05561DB0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39834284B46;
	Wed, 30 Jul 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCFSCEjR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5221C160
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876899; cv=none; b=I31JtDqoW47VOrll8ybrTGAY+BUcY3/cyp9wzBUvc2MSIhK0DNdl1K92+prhDX8B9AbIph2ayTAh1ndgQ7qs/HQQlqBt57NIU5nQuOYBSRp8X0CrjvNjR7y36uYRW4z9JPcPcf1QnuNaNtoZSQP8XtzcV2DY1DEKrax1ZOWoA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876899; c=relaxed/simple;
	bh=nENZrXVf0xEZ2aFw10idI8zS9pzQ3l3UevWHyh5TXeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sc3RhBF+Z8FhTou/KuDSeUnWXwiF6RYuD3FEp6mbv/o+nN6aCJnaFnD9hnQAVG2lH2YIzoSC9/aNdA+QD6758Fk7symYqz99S3aqfJIUCix4COpQIBIn76ryXSHOGACjNdYjLV32Hp3PEMvOveg3hAW/QvDugwZKdHXQCkOclQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCFSCEjR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U7W481017653
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 12:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h7P4JA0l+stHfoiUVQyDl4hdUnBTOoJrHehJ6ZePN5w=; b=dCFSCEjR282VRba1
	vkgZOkQcVGAHlpXo9djo/qAV3Vt8gviCpLBq67kVd1XG4YBbsi0ugU8i0psfi98M
	ARdp1Pk5H0Dql9iPnBVv6SKsl1wNL65/OcFamj+KjkVRi5esJ8LtkwS2byolC7zo
	yvcKHpo2YduoRKOMZAJmzHuv1Oc46hy6QeSSaoPoSziKZY76xSbN2KajvmzLv5g8
	ba6ZG7a3ZukeX4YQEiL5qh5aAJ7vp1MlvtmT1DMTWR+1tX+1m+4+VeFGEjYgSdjy
	QjREGi42gSCKQq/FAFo2CL6VAosmOxCNdVifoW7d5m5gCd9huTh+Mj+ipOtIH/Rm
	Gvu4zQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2kjp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 12:01:36 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4f9a7d407c3so111152137.0
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 05:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876895; x=1754481695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7P4JA0l+stHfoiUVQyDl4hdUnBTOoJrHehJ6ZePN5w=;
        b=UT/NscD14aC2OBCcQnVOVsI46CrlL6TnNaw2u7CFiivYWnM6fYQ/l+Uz7eYM4T/y7h
         u9pK1S7CQnPMd80Eb00OHaridjuJ0IFK47zy0NeGJpQDt+ykH7LbB/CoQ5kKWw8B85JN
         91Sjf51+oOFl9Pp/jRJCK1ZKFlR94hxH4+BuuNpp6EkvSxV6Vh/LuMw1RYonsQSUf4xV
         cUM6vzugZk0+1pyWMgDbFtZyX4KVzZz9m6hyjpP1gq9bEie9pC1OrmjKkuaWlDYw1CQJ
         6Cg2C6b9n97nyjAzrGdvtMrrejz/JLHXBCcvC/heYAurWWzp0mri8sCYgtzApNiwVJ3p
         TS0g==
X-Forwarded-Encrypted: i=1; AJvYcCXfK4FCNzeRqJQBxpM9C0hvcWXf92gNJFhoTHfsqNgVKGVEkQN6XIO0g/HgVhSGz1XNiXD0Ti0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nViTYUGZFvDnUKMy0ocfQeEvsiQvgqrqVzjD/jvdIW+huTby
	fGmsh+yRbHAXSn+XeIQ+9hmDu+hbAgbUiqRWCCU06JbhOmublL7bEGA2rcT0nZMyokp62EA/OQu
	RmTu6ADc3+33/XUa50uDqAGwhKS07IxvO5mR68wQuN/eRopTpeO6PXvhEEV8=
X-Gm-Gg: ASbGncsxp3QjdwCEowQVBsCsclVjrZq8wyXLr2ftZ8f5GJ1I7YccLVUbCz0DMmPJuWX
	blFhPv4qghcQComZCMZj9RumlDrU5qIpidkuznZ+ybdV0MRgfDEQoBRG2LUtm5wap+TzMYpR6wQ
	zqECBJDTKYIL+DHQHaztFShn/KBaFC5UA7ibYNNZ90n/WPq8RjqxSu607VzE043xpiEWBXAonKd
	Vxz+3WWbRTXQNoRkKXFYWZ3QcYLEepNZ3Fw5Q2av8PptB5XeyJkO3IGePeQss34sDn5gZmRnZ7B
	/YYCsT/i8XOMBMO5Iy4BywR3YLHlITgJQL3XvrZnjFVuTrSWdt9LTlBO20kx0sMTGHhjysYMmRb
	CT2nrONr7iHXBDZkx1w==
X-Received: by 2002:a05:6102:5615:b0:4ec:c4fa:c23a with SMTP id ada2fe7eead31-4fbe8743c77mr527583137.1.1753876894211;
        Wed, 30 Jul 2025 05:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvqburrLqOLTBhCJ6VDYkYHQwA8Vqi6itxndJTY3cfPYNQiShJQvXD/euk52g60pv2Ga9FOw==
X-Received: by 2002:a05:6102:5615:b0:4ec:c4fa:c23a with SMTP id ada2fe7eead31-4fbe8743c77mr527548137.1.1753876893774;
        Wed, 30 Jul 2025 05:01:33 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61544a81df7sm3572090a12.59.2025.07.30.05.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:01:32 -0700 (PDT)
Message-ID: <b99d2b54-b684-4efb-afc7-3a18635fcd5e@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:01:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add missing TCSR refclk to the eDP
 PHY
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
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
 <20250730-phy-qcom-edp-add-missing-refclk-v1-3-6f78afeadbcf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-3-6f78afeadbcf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TbfPufc3QQoc5VoBNc03W-RgYW5GPLss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4NSBTYWx0ZWRfXxLKmDaKEUXgQ
 vCWHSsus71qwqU4Xl5pBqQ7uZbm0Yc2TyjxctdaDz9hSKFNLshYmZ42KW/eIVgpDlKpH7YvCEwJ
 r/xWacg60FmmaG1+P0RpNe2Z0ih5t3DEwlClGPw/VVgHSPT7THsHR5k+ZrR698ozeitDRCYj9Gm
 jpbN32cR+AqGp4Tr5ByRDFjdqritvofUZynDYBFapbZ1VYEMYa1uA8KsUHB3OjT2Dak+6dkuei+
 T6TWcFZw55oKbfXY/nqV7G+2TlimQsfHeaq28VzJe3n14+0B09Rx9YQvV43c+aG5lsYTNWYtCyI
 wVrp3RFhyZQw9D1qz4kRHQg0ZTAZiGXkugawr6d1bN08PBjPp7BidzSdTttULotzRvNB6DIQO/g
 9gdF1Q1CGbfUs/oMB7k4qbjFEiXXUUTAyd6ssxCMjcgQnqjeHqHQsgztUxNT0NEStLvMSS/D
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688a09a0 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=GIX-IF3Huo6piQy2-QAA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TbfPufc3QQoc5VoBNc03W-RgYW5GPLss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=712 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300085

On 7/30/25 1:46 PM, Abel Vesa wrote:
> The eDP PHY on X1E80100 needs the refclk which is provided
> by the TCSR CC. So add it to the PHY.
> 
> Cc: stable@vger.kernel.org # v6.9
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

