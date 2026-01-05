Return-Path: <stable+bounces-204584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CCDCF1FF4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 06:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C24302E145
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 05:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5B324B33;
	Mon,  5 Jan 2026 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cNP6SHZx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AasACfb7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419932694D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767590145; cv=none; b=NsYeiAundezA26EDjTp81mmouw+SWfTR+lW7w9KwEAqW/JNscnWLaak8L1Aqf46hhWnOztxduEWdker56oOkDu+qVP9tX2f6/ozOVjKAxmGciELSTfMd3AdsAo1CZUZdJ6j39LOkw42j27kH9eKZDU15nNON1uAsXNF+qh+oDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767590145; c=relaxed/simple;
	bh=ccckinTe4Nd6e+DN+CiKqNsVaXVriV0JcN/wQcWRlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJW/QFnfkckO3yW/96Ih1tBsSrYNjE50f57Dp/a7I+sh0g4VOcjH190inNeCoaNDTLSQUKgRP7Jn+hkM4z0QbGoC3UOf8M+9ZCnsuBpJ9bvR68qUvTzdT5l4p2/f+gXGnzbRZnlFYVm8AyYnbl719GSPCKAJQka4bgM4LoczM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cNP6SHZx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AasACfb7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052oNR6091785
	for <stable@vger.kernel.org>; Mon, 5 Jan 2026 05:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w45yMTKmw3T3FsrBXK+GQLsm1qbLPVg5YDaxvUzAAPQ=; b=cNP6SHZxDAp7CWTg
	13K0Ub9Hwi6XGcb5BnYqF//HQp6S4+Y0Q4wuspF2gJ2xkwXVz6VKZWIV+vo/YRvE
	nBqiD/XO8oQ74NaXVM7eFKRoc8hCx+ZWNiYdW96vcsZxwebYJvNymRrRBf1N4btZ
	ND+VZV8FnRWE3j2Gcm9qqOfMPSqID0YfcTux8+6a2GkrT3LEPVLu+b7pxf+fz3md
	y1ZXUDUyylUOGwaXBARp0+6nTqkC4gbzOm3pPiu5gHZn3zBhRARU/P3BVkqA6pbU
	wVVRGvEUCViw9mEzktqDsna8227Cnx5HefJSJTzClEuUm759xquH+Rokb4sl93vf
	MaBRZw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg4v609xh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 Jan 2026 05:15:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34aa6655510so16336271a91.1
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 21:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767590141; x=1768194941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w45yMTKmw3T3FsrBXK+GQLsm1qbLPVg5YDaxvUzAAPQ=;
        b=AasACfb7fXub8UWP33lXkqfJa6Mlq6nHdaN809jqUAUyUWKA5wjQOkPb1jUW5ictAB
         1cu699MxvU5LfT57ysZPh7sq20uYplaLrAj3CrOauSCvxNaraTx75enHLEiPvZ035EFY
         ByPCE5EHDp9VTsStOiIZs1dlPsqqLYWVb2SV7olOciTXLSCppfdl1CVT6I6GNwJWLUun
         Ns62VZwG90Wt9LGo4SIwDyzwv6y6Kz7p0tPTPYGaWhqPvBQIwdZ9kvQFwmZm7ABGO5Bj
         qHddfHNm7MP29HiAVxFbkstVtIRk8IDneeiiGaAABWp6VfmJ1cvEo+txm+0B++XeCyWg
         NEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767590141; x=1768194941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w45yMTKmw3T3FsrBXK+GQLsm1qbLPVg5YDaxvUzAAPQ=;
        b=kn6o8JlQMX34cku3lyL3SP5adLJEFwnyBuom4r1qWCQNYPXSS5+wpTXP/KLnnsiNLO
         K0pPSsEZV9txOfoB4GYJSGT4C6ZRKoKOJeLZXjMQrlEQiugzrP5qgtkXLtHVxfN9+DLR
         DgAicrVqn0VUMrTBLhganBNIH9voAYhueB2eKTLhn3tNmT2EY9Wrjc3vsEbzqtlprdSl
         ceOrQOFbEvPG4PYl/OJOGEPQ99w8br+q8OOvqyQBdfINVM1U+vL4kWt3qjvSpQiEf9sm
         oXsLgfkWmUR7ociXH43NZbhoxdBiS4YiTHEI8zb1hDN2n6fl+Zu2bGnfRUq0Vm6btZeO
         7CLw==
X-Forwarded-Encrypted: i=1; AJvYcCVZn97XnFpUO8gwSbMP8NENvDjHGy27a91IJfq6Xls9D8Z2P6eVCFwoej/9wUDnVcv+ynJI9/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgEI736WeetZTAQ3vqdiTS4S9rf34WIb6DD3fyUvLV9YdPPPC
	I1hL6YROtE4S+oSzJe6pzbP9RxmVTyDK8p1FSDyqP36RwxXjuaYllxohgtK79gWniFImvaNS/wS
	cCSWWVwrpI8v+GxvPj/kSFMkPnSaha/qWt6OYyr8fwv3TYGk17KqglG5o5SY=
X-Gm-Gg: AY/fxX4xOTiIINQ/2tumsbmH9ohqmhAC9+5iEu7AXIW/K23hjr9w0+qxA746YW5zWls
	xKqVRQ/xVrHa+4KMOhq/R1lKAfEHd+M3CqDghcqtTqF0kw8pgKJO240HsHuGf0chP/b2XgW+bVC
	fHKlq6yi6eK5E3WWZQQBx/CPvIrP1ebEhPZmlGQwnTTH6c4mQtBa3J+MQFNT+U7x+rVYSOzGQEH
	95oLRSBAXfz3a/2JowedNK/WhinM3eZzwlwCiMMK3j/Dzf/yjXpyIkmFynWcayem+50Y8ZxAg9J
	RcBEvMJhbf0RAw9lfv4DsFdfc/vHcCtMkflXACp8Nm9adblO8bnLyvanvjya4G7iKM6AEFUeRgX
	bKmbasStKqG5QAFx8rnxL6fXCiA==
X-Received: by 2002:a05:6a20:7d9b:b0:355:1add:c291 with SMTP id adf61e73a8af0-376a75f5bb2mr44560759637.10.1767590141038;
        Sun, 04 Jan 2026 21:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfNcaMd2IHGrgg0+WgvXFUrvvd8fIzU+ttGMrRaZKzm0QUfBMuqUCbK1jhV254MgJ2Excv9w==
X-Received: by 2002:a05:6a20:7d9b:b0:355:1add:c291 with SMTP id adf61e73a8af0-376a75f5bb2mr44560548637.10.1767590135763;
        Sun, 04 Jan 2026 21:15:35 -0800 (PST)
Received: from work ([120.56.194.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7cb01a9asm40787234a12.35.2026.01.04.21.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:15:35 -0800 (PST)
Date: Mon, 5 Jan 2026 10:45:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
Message-ID: <mdy2edlneqivwjsi52ildqcnrprbqc57ghtuwtc7mmuru7ajhz@tdo6jts52soh>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA0NyBTYWx0ZWRfXyRZg9vTW2HB6
 LBc0/UdFxqSlEmQGXCtE6Opb2AOHAwM5zY+lmHVgNCHNtCspXdqr9OCw5m5Fuptm6QFy4LQpzzL
 PU8jsNmw67JxAB8Ga/pBGr3S67wAfQ/PQlxS0So1fBd29Qxkt7Ffkk7LccNOebEm/RjTDpWv4ak
 8QEVfxiyM36nETvIaumSRsdfOfsaoTqPYZgEg1xBTCCDHAfsILjpOcIbIGG2W94N6Q6Xz0IxeRl
 /+xp5mCPOIwwh3tg1VX0MMQPZ76FJNnRzQcMAjW7MFB2W8QT84TT6WowPOitAF5V2mNeErteoRP
 VchU5bGsv3gTRdaChWA81/9QXrrHZB+fRfr6yZh0Rb8kpVglq2TraamjickP3srx43vHjz+bHFf
 PulMMcU2pTouKxn1iMi2tbNmJV+n/fe2KEm5ZdmoFJbD1zoYNqEBEfCkOS+elurvQhqkt/1cC35
 nqsusD4ii2WCzttAOqA==
X-Proofpoint-ORIG-GUID: YMKl8CvS_BM8vzs9dwp4tb5wsWCIGPm0
X-Authority-Analysis: v=2.4 cv=c4ymgB9l c=1 sm=1 tr=0 ts=695b48fe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=3dEILRYKsVIWdVk4w2Qziw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=LkPj_kuH23xJFnsvXP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: YMKl8CvS_BM8vzs9dwp4tb5wsWCIGPm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050047

On Fri, Jan 02, 2026 at 03:13:00PM +0530, Krishna Chaitanya Chundru wrote:
> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> can happen during scenarios such as system suspend and breaks the resume
> of PCIe controllers from suspend.
> 
> So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
> during gdsc_disable() and allow the hardware to transition the GDSCs to
> retention when the parent domain enters low power state during system
> suspend.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Krishna Chaitanya Chundru (7):
>       clk: qcom: gcc-sc7280: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-sa8775p: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-sm8750: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-glymur: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-qcs8300: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-x1e80100: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-kaanapali: Do not turn off PCIe GDSCs during gdsc_disable()
> 
>  drivers/clk/qcom/gcc-glymur.c    | 16 ++++++++--------
>  drivers/clk/qcom/gcc-kaanapali.c |  2 +-
>  drivers/clk/qcom/gcc-qcs8300.c   |  4 ++--
>  drivers/clk/qcom/gcc-sa8775p.c   |  4 ++--
>  drivers/clk/qcom/gcc-sc7280.c    |  2 +-
>  drivers/clk/qcom/gcc-sm8750.c    |  2 +-
>  drivers/clk/qcom/gcc-x1e80100.c  | 16 ++++++++--------
>  7 files changed, 23 insertions(+), 23 deletions(-)
> ---
> base-commit: 98e506ee7d10390b527aeddee7bbeaf667129646
> change-id: 20260102-pci_gdsc_fix-1dcf08223922
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

