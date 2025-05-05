Return-Path: <stable+bounces-139671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A2AA9143
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9CF1898893
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575581FF1D5;
	Mon,  5 May 2025 10:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3PUSukw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F818BB8E
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441324; cv=none; b=ctEm2mpnA+cUXn1olMUR6QX2ONlhmcfmpSCASqbqVjQqKffjzi05sRWkg9Pn2AdmNinzRIk3Xq+OzktMLYNhpmyIi9QafxabfjBZSxbU7xrxTeTT8Rxav6QMxspMTD3wG4Llh6FRMe57MwVNrWl6EmQoI6aUaNtqSunjfTwnEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441324; c=relaxed/simple;
	bh=DaC2vDdqmokz9Jt/U40zeutsPirki/qadpEpK5UZga8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMelXqCF2L3pcCVEB2SkC+c286AJQhdnGod+x7meDwusZrfsCENfvUvTXwnIUv5OB3T25KiZRYtjBOCbLyj5h1qpz5ZhYj2wrGI8eukurBVOE4obRF3I4qrdbLLatCMrFfswGZNpwBrzi+gIMZhXdqb//TPoAsYjqaJ06CEQUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3PUSukw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5453NIEc010458
	for <stable@vger.kernel.org>; Mon, 5 May 2025 10:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mzndjCg+e2OPuoc9rAF/IaDWFAfTk+vHxfMSSvYANmI=; b=g3PUSukwQcumUQ4W
	hpzGmBY1y8ZIOFAs1AI7ul4kpiFVp9AusLV6bWWe06IKm0C948aSuV2Gh82W2dV/
	PyZJOc25/WBfqwSAp0DtZDZV6jm3e/D1pKWFUQKyRediGofam3Vaxzuf0kuJPmnB
	Lz9y1kEmtzmDhpORXn+HFWtXmrAeFf5KrkKcJV9qYbaVYDCwn5SaDdhxjWdQ1QFq
	uEJXKnO2b3I/mOFa57Gcv3dNXzo/5NwkpA4VHCmjGf8dyMdJhvsYGA7i0J/RG1x4
	YXCrkAiYF0aOQdJhNkn+nd34jmD89CrrVwbTdVGvArsBqb1y3B2MSJebe06a0e/5
	GQV7MQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dce9bq1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 May 2025 10:35:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b115383fcecso2500505a12.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 03:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746441320; x=1747046120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzndjCg+e2OPuoc9rAF/IaDWFAfTk+vHxfMSSvYANmI=;
        b=NL6strcfl8Qhm5gVbhceQlXI736mZFzupTUN/r0Sci0cdgjSxoTW/9EmbzmfOWbkUd
         Ix6NBrFR1ZXQ2NcgjfdBTg5zgv3DuK6Ne+ehy8YqC0spRSstSVr6a5DeVUR7VTped30e
         uMLW3VaJkI5NcdNckGING2jsliGWWtm3h6nLp4qlRiJBOkdKUPyeu/9igfDCRys0M24B
         3pjGjJD8MHfrNJTR+HX4ad/+8dQRN1Mn8fB3KyLs8tge2oO/X6hrZ0jbpDJdoLxzq1Uy
         9rvl0Fv6YYiwimKFOUn9qddMGA07YaBEVCysuKVK2C0H4Ec5RZC3hx6feYSGXVwkXOhw
         1trw==
X-Forwarded-Encrypted: i=1; AJvYcCXJtDOvZQ0F4G9/zlu0inDacE+90VE6+5JaM2O6XVQ+rOBnh7WZgcErkWZVvUN6SMroBaVDMn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfUmnqZudpXDLUmxQiK8XqybbEfPUe+4FNDLuppdQaxNJLz5B
	7CvXjeZNsNUGBt53JOl0gxkzieqDNfddyIpxz0vFH6fZ4T/UgJ+iRKquqPDvrGP8sDab1IrQiYi
	Rm7Zp8feuhQQvuLX2TiuZs8zDkpI6BSWciXKlRN7nrJXf9dBe7NLhroq/GQ75Iak=
X-Gm-Gg: ASbGnctzSZuKywukuhIYunWeod9SRjLjI4l1ZqhcDMa/hDlpD4c0GDmWXZKQ7OlC2di
	e8FdBqCUcaV6NikfawIJ5E61+uzBXkOLsidoOFSQYQIOm4OFEnYOICXhDkF40acywojIM2ezUeW
	odBE/Y35x6aP4hnDrGjM3+C32NuSPgkRhMpHlu4/csAtx9cHCeq3iam+3LBtqfLm+bKTeRwhwD8
	bn/+3M8zbsh92NZYuIGmDdtRsyijsFGnMukP+6Tr+ZEDTXqv/fGMx7i1sLC/kik0OIL5nMS2SqN
	jjeSCm/4bA4uhI4vrm6dvnnZYyieai1EUdUF9OVi12LJaZhY6loh
X-Received: by 2002:a05:6a20:7d9b:b0:1f5:6878:1a43 with SMTP id adf61e73a8af0-20cde85d355mr16144498637.14.1746441320567;
        Mon, 05 May 2025 03:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP03PciZv8s1ToFZ5GwS61QgMF+GczmQXsLG40quiJUaX2iw5O5dKsziticwj7Edr0uWka/A==
X-Received: by 2002:a05:6a20:7d9b:b0:1f5:6878:1a43 with SMTP id adf61e73a8af0-20cde85d355mr16144478637.14.1746441320214;
        Mon, 05 May 2025 03:35:20 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a225sm6379719b3a.23.2025.05.05.03.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 03:35:19 -0700 (PDT)
Message-ID: <15f4021a-821b-4a5d-8873-8eb8f59484e2@oss.qualcomm.com>
Date: Mon, 5 May 2025 16:05:15 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5424: fix MSI base vector interrupt
 number
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Viswanathan
 <quic_viswanat@quicinc.com>,
        stable@vger.kernel.org
References: <20250505-msi-vector-v1-1-559b0e224b2d@oss.qualcomm.com>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250505-msi-vector-v1-1-559b0e224b2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEwMCBTYWx0ZWRfXw64Y/yJMVgzZ
 jzD0CRgkOAdAadaRvS2MrkJRzrSOE9vwiB7ETpBHUlLXQXpn56qkWON9HHU91nW282T8gvPe2xn
 yPGRlsXFgQ2xNAiqrMcLR+3cq2jrBoQNVRqxwtYcASv2Raxf2EVREDwRQDF4V3ppDL7yn7EwP9x
 iPSWbGyiRXKG4W7e/9o04khHWtv2sNZMx+dzYPfiFCCgTM/Qs/XNZQIQ48FcQ8mdcx5M5HpsE0n
 SQQEo7t/BUS7EODcZ/okb7Lfw0MIBxysb7bk0r2m92qleHCPd36qPq80vvOE0yY5DKKhwAywpAL
 VbU52y1WZsGbw6L1JnidAprhlNPyuAlkUg7PZppw0s5Xtdl9EmqGGI6BOXFd0edlATg+leb3Vpb
 9jqfcZ0Ok1crNc4nXF3iH8U0A8zvTgKYdaCuUANH9fGLDAwDX23AheDGuUGhxpeBcKKCK5BG
X-Proofpoint-ORIG-GUID: JuJdWrXzjwLRctkt4Iousm0EQYO29B7A
X-Authority-Analysis: v=2.4 cv=Qope3Uyd c=1 sm=1 tr=0 ts=68189469 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rSoPyq_vb_VxFnRLzkQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JuJdWrXzjwLRctkt4Iousm0EQYO29B7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=714 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050100


On 5/5/2025 3:29 PM, Kathiravan Thirumoorthy wrote:
> From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
>
> As per the hardware design, MSI interrupt starts from 704. Fix the same.


Please ignore this patch. There has been some confusion.


>
> Cc: stable@vger.kernel.org
> Fixes: 1a91d2a6021e ("arm64: dts: qcom: add IPQ5424 SoC and rdp466 board support")
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5424.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 5d6ed2172b1bb0a57c593f121f387ec917f42419..7a2e5c89b26ad8010f158be6f052b307e8a32fb5 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -371,7 +371,7 @@ intc: interrupt-controller@f200000 {
>   			#redistributor-regions = <1>;
>   			redistributor-stride = <0x0 0x20000>;
>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -			mbi-ranges = <672 128>;
> +			mbi-ranges = <704 128>;
>   			msi-controller;
>   		};
>   
>
> ---
> base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
> change-id: 20250505-msi-vector-f0dcd22233d9
>
> Best regards,

