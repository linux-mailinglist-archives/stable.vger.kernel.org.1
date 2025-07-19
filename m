Return-Path: <stable+bounces-163430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C12B0AF44
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B485582E2E
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A0231C91;
	Sat, 19 Jul 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hw1+m4VL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AB221555
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752919844; cv=none; b=N54qBgIpyo1MaFE0tWN1+sCVzjfVNgKhEqdztngaUp9tH2Rc9s0UUQciAMSzals2Oc3mSnN5r7i9Q5OJi08lNISg5gVL26jVTe31E2tp7yxnioUH5eddKhf3+qO9Zo/Mp00IbGfuzYo681WO09Dqzp1dMGOUVlMk6LVR77xPROY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752919844; c=relaxed/simple;
	bh=utSiTo4TMlu1YfqS+7TeWM6t3lr6x4U04C1TJbKXAXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TohCU6X3BoZ6GbSEbcROOo0MXwc48KGCBek+glcz9D9ORPy/jB8u2xhph8zu++PmHPs37VInkLbS7f/vl4LhDzkHvMBNMMIAkPwsW2Zf82tcMzaQMCtYjV6Ufr4DYLwQR3qs6IpWoR9HAcI3T5RM+3MztjmtrVAdVSO1cje938k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hw1+m4VL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4e0qN002638
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 10:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TafuwAxxAyRiy+2/X0fzDvpZ
	2vsF3PkzwIbwp+jnjII=; b=hw1+m4VLVuD0e4CoSTymezjhl6AWgsWf1pNtk4AY
	U1K80C2wzZjo8noZRIfas6+lfQ637xNsXbRZeBocrsrllGTWV9Br0LAf1xBbVBUy
	PUE19KxYLcmWhk32a2Qc2Y53SertSD6D4BNMsjITJdApvVkJVsltCSpsGGqSWrB7
	3mdaEOIxattHgNuDICKPyX5znHcYDT/viO7bFQSOw90GDklQNT4UD4DdDJDz/9SI
	5vdjFmaq8nKyZGMSMKtcbPxMuD8JZKDj+2x6GJj3dCzxXxkWXdlltcDBy8OGVUIW
	khlDxvEAcDsUUjBQZriEMMncEeanG07+7oUnaEY3IVcsnw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmgdsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 10:10:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab4211ca00so58836301cf.0
        for <stable@vger.kernel.org>; Sat, 19 Jul 2025 03:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752919840; x=1753524640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TafuwAxxAyRiy+2/X0fzDvpZ2vsF3PkzwIbwp+jnjII=;
        b=TGYyxvRtwGoutha21wU9dBVsHa7KUZdlZjHsTKn7kXlc8udJuvaPcWtkLxXgK1poHD
         jGawj6WWoSso6etnySbXYWYH5yJbx6Z3Sv1sToNm0Us4AIQwY9BkM7hXT/Rl8fRyYdmE
         VKOJi9krEzJ4X/90HbKmRraA1/kzJ2b9CYYMLm2vfWlzVRQaw/b+iv3vSZ6eu7KUYlp5
         nPcyA70NVf5ifU7d08PLGGzxyrQ+k1m2ir1bkR+SQ+HjXnWTT5oC6XUItTaO8b6Rd/Fl
         B6kC6ipy1cDTzCLKjHOLpGOOURo1EFKHwvaoLD7Jru8klq0Nj0vbPilXPRED+vzkvxp7
         Tcsg==
X-Forwarded-Encrypted: i=1; AJvYcCUajX8Iu4WQUpBj8ncMmhJqwREB4Wlf6Orm6tgAYOFBQSWkdYSoRcrPAKVD8qgdqbOkzXiwLEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKYUZ/fHg0L3CE7H3KHfRM+fP/BTheNU6OixW4jpwAQmKwavo
	3NXGhnkKDsTFkm9IbyK0WOnhvuVhdtqXiWWopRokzC26MLstA8Chi9k+OOZ2GNLb87/xaca2NkP
	TzZxUgOlKs4jMGh8iZNkOt+QO67fycrt1Bh0M683GjqOWRlDctptACGUdrGl2DffHPXE=
X-Gm-Gg: ASbGncu3lrqgOzNcPYNsQemf77yVgRT7FzEi8u9qMgqujrP+F9H8Ke6B79jnUMaJCBq
	cVU9wYBixMyHdRBwFZRsbeTSfVPIWl89K/x+1baxpLjHtKmyS1Zgmv/jC32IfHoMI5et0iL3Rl8
	DFgZhmbI/SZ0+Ydqznk0Bb41o184nM3tWw9n4Cq0MpzLZumfabdEs0nvq6yzCXd/Ff+fC21Nl5V
	eINfkV+OGvxDv/8ZFSvagbfh2hgY7dXEV1vEjAYxN4JNx7SRHGTOnEh79KA8mEx902/md1Aqibq
	XEaP81T9i5b7nviM8XspxCoKKkLqrrex1GdYD4I34JtDjGphtAYbf4KY/7AJYBeeXeoibuB9Vi7
	Z+lpu0ocYlJNO67O7QG0DWQ02EcF1VI/5m5MPcK+eHVC60VzcVRca
X-Received: by 2002:a05:6214:194c:b0:702:d3c8:5e1e with SMTP id 6a1803df08f44-704f66ed6c9mr162269816d6.0.1752919840443;
        Sat, 19 Jul 2025 03:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjU49TfyfGJdjzjVGo9vGtcZ/GmenE/HIfg0nrHe2DmMSEvyBaNgStXQurxKK8QsOHT7hXg==
X-Received: by 2002:a05:6214:194c:b0:702:d3c8:5e1e with SMTP id 6a1803df08f44-704f66ed6c9mr162269446d6.0.1752919839979;
        Sat, 19 Jul 2025 03:10:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac93fsm660086e87.73.2025.07.19.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:10:39 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:10:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Disable USB SS bus instances
 in park mode
Message-ID: <px4wsemq2jvt4si33xquy3wzv7fdi6ywp66gutn6wcfdipwyr7@3ofcjfwfoxys>
References: <20250708-topic-2290_usb-v1-1-661e70a63339@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-topic-2290_usb-v1-1-661e70a63339@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: YAvGgX_LNxOgzKmKckRbpuN5JgvHJju7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwMCBTYWx0ZWRfX/Opxb1urZhDT
 BOdXTj4mpnw1yc42a+xdeKT+zuoWLm/A5LLPF/qZe/4wkh5Ji1qqEsK79FkDi/ZJAZzR+KeRV+l
 Q6p9OOFC4h0b8juPfuHnwzRI8cZXJ0X//eOoYLuv40+CCUy4xkUDhmp6fgHjV55P8plZq+6QDPB
 IbFs8R8fci5Hu5zwSvOOWOyIYqfCS0oOqGQD8lRz/A7NSgCI9ijQrEyD9IIIuhcBlkhNd3CCciU
 dxF8cj8abNiLa/6lCdCCyHtozTj7Ydo1pLQus42xzjeH9hKedux5eZhOYUl4y0oWDoNcVMb7hcP
 ebM4HAqSh+f4g/jT3lw+m0me9M4Y15xgO+HpIxLj87W6orE+egCpVOKOeczN+zeewJ/PFftRqdy
 1kfZ84UseF1YUsoI2368aiu99EM7zDGIz3cxTHlSa9i+NkFVRSXaGFYNf6VluqX/O4uZZp0Z
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687b6f22 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=esWAiSMzqJ-acQ4o4ZkA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YAvGgX_LNxOgzKmKckRbpuN5JgvHJju7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=961 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190100

On Tue, Jul 08, 2025 at 12:28:42PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> 2290 was found in the field to also require this quirk, as long &
> high-bandwidth workloads (e.g. USB ethernet) are consistently able to
> crash the controller otherwise.
> 
> The same change has been made for a number of SoCs in [1], but QCM2290
> somehow escaped the list (even though the very closely related SM6115
> was there).
> 
> Upon a controller crash, the log would read:
> 
> xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
> xhci-hcd.12.auto: xHCI host controller not responding, assume dead
> xhci-hcd.12.auto: HC died; cleaning up
> 
> Add snps,parkmode-disable-ss-quirk to the DWC3 instance in order to
> prevent the aforementioned breakage.
> 
> [1] https://lore.kernel.org/all/20240704152848.3380602-1-quic_kriskura@quicinc.com/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Fixes: a64a0192b70c ("arm64: dts: qcom: Add initial QCM2290 device tree")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

