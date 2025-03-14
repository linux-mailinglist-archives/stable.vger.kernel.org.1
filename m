Return-Path: <stable+bounces-124459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A8BA61663
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC0B881B8F
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B794204691;
	Fri, 14 Mar 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlt1JDhL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618292045A6
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970188; cv=none; b=pLK5ZxBHXiNbLAFVoFsoJ1baBJloVobYREYERCbnDa2Fm06yPdQuyi8lQ35hItIEtGC/JpkvlVKdyFE2fd6ct22QbHuCYnrxxrGqy/szml2Wzajn3BVqvFUW4tmwifajPJYrvVBOlPTiLaX6AbWxnYc8Aat8atiojq79Gko8XYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970188; c=relaxed/simple;
	bh=HL2qrnqP6m2SJjIgrryOgrdGWPC/DqOKAlmK3yLxVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2mSMqbsKGx9bj6sRyETvnwjy3T343Uk1qzmhOJOO5iBSiG5YrRa+IXSKQN49e95FmpVIugjiBqUe5eQe37QXdW/d6tT7VN77yYeBv7xOPJCf2APXDafiK0xw1ZOJ4JzDQWP7xLS1PooFQ6uM4wtlnGNvaAK9yl8knOe+NeE1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlt1JDhL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EDu5xO024792
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 16:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dwRYAMlQoWB7Kdu76G96hqJd
	qDT3vaRt4pY8/dRjDDw=; b=dlt1JDhLB3SF5k1enjXmPQ+CY5/Jc0SXLOy8zj/j
	uDBrJIPmf0wDjctB15xSX7YkTsOAEhjm0YhizvjywwKAs4AeMsK1gMAyCkdz/hmv
	7Gx8Jjj/I1GpU+piLuO5mmC/PhDsKVo+aOXmNgMUIiMTxkaAvlxPrVUuKeCUlotS
	9ZgUHJFml/qIAql8oo2MoFD6bI5mJnbPgvqUKja4pggtsfo90ih0h7d7my/1gt7/
	BLU1b+Gnq7pHHvjpPloiDRspdQGFhl7IcE+odoH3OogqNSLq4x2aCNz4sgz/qo2W
	1q28TTeMZ3aVBxfgQoZZqrCr+2PYYNSohu9ghO3HSf4RdA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45cnscrdyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 16:36:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e1b8065ed4so51206966d6.0
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 09:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970184; x=1742574984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwRYAMlQoWB7Kdu76G96hqJdqDT3vaRt4pY8/dRjDDw=;
        b=JQNEz17YDLanv1gXjdl2pmNyWljwFHniqEAFcSy7dBcmOqvuwzm3lVEVNy7cGllQun
         uXd21VFSvtcqRAXhwEN744+kktH09GpTx/vX2B6Nx3ncjV6LspU9P60y58xvyAGjsO2b
         jKWkwGWs9boxXBjFQh95ohNYMSqjtEWjg8vBvIHHUxWjkQaUHgklTfgLmjjmtDYNdkb4
         IQf+ch2SUDeaOYTvqiOOzdD6+JWZCa5QpWM5QL1OVdZQFAQo3/AMvXnVuAEopaFlWhrq
         3HND+u4WZLjFVzayQ0CECr64wqt1wsML8WkuRJCH2bQPp3zVthqN7paMWnCarzc3qiN0
         GxQw==
X-Forwarded-Encrypted: i=1; AJvYcCWVNf4Li0z/70aKe5wf8KMT1TKj4/OREo+8iXDKbJu2FcVYw0/DfmA5dwshcIjKavphm3rlfhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNe98q+0aWvc+JlYGCspJUzjUuNk0fsaCUSZB6v8JTx8lf88r
	FtenkYoM4PjsYczUce6ShK/fzYlpO/IVqQU8kXbWzLqKle6t889AIpCy+Mf7LnbrJYSILgLZrrm
	rsLJH/h08OQp37pd8hPUt6y2XLxS3qoYCe/x1zrG2j+j087p8zLDOtuk=
X-Gm-Gg: ASbGncut4FZ5drnyT63urjuy/Y/04Gdl4hYD6ASIDAbFmwutVljYLSGWKfJyBkbBxo2
	c5dBC24GNJLvS0ZGNxazF3xINIq4dtjQg2WlFCuFEJ52kWJ8IZx6j7+AWMGtEPyRywvI53g50M+
	/yYZyWQaynhiuyws5UY6Fb7e/liam+Rf1uu+DAhr05dBNtB2WQN4EITtQ89dRrwt97SRJYJA4iy
	2Z/K0Z4PErmrYQcehS/9qMVbFx3jutw6vGXTzUJPCEti1aatjB21H6eWDtMQq2qpp2fHXjbMKJw
	99F/BphLlph7TjO9NXplm/szRwZZ7qEIOESWmml/qxAJBWwD8Qb0CaiUklgoaNq82Smfz8GhSCd
	aK9c=
X-Received: by 2002:a05:6214:5097:b0:6e8:ddaf:6422 with SMTP id 6a1803df08f44-6eaeab00312mr28706706d6.43.1741970184413;
        Fri, 14 Mar 2025 09:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJb4x2fMIyGfk5ixR2DwoFRga6e8xcjQATKUUg0Rfaz32txxfwF6NxY3A0ZD5xbJ0//+/kjw==
X-Received: by 2002:a05:6214:5097:b0:6e8:ddaf:6422 with SMTP id 6a1803df08f44-6eaeab00312mr28706456d6.43.1741970184127;
        Fri, 14 Mar 2025 09:36:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88598dsm562471e87.188.2025.03.14.09.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:22 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:36:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: qcom: x1e80100-crd: mark l12b and
 l15b always-on
Message-ID: <zhiunl3doj3d5rc2m3w2isnwloyyvtbbgiiuzbg3dxy342vnhy@n27ioyo2mhvm>
References: <20250314145440.11371-1-johan+linaro@kernel.org>
 <20250314145440.11371-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314145440.11371-2-johan+linaro@kernel.org>
X-Authority-Analysis: v=2.4 cv=Qbxmvtbv c=1 sm=1 tr=0 ts=67d45b09 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=z4ldfGPc2qRxCRB1vwoA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Mdz7kx0tyYrEHwIHruAn5RKCjfP7q9qc
X-Proofpoint-GUID: Mdz7kx0tyYrEHwIHruAn5RKCjfP7q9qc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=473 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140130

On Fri, Mar 14, 2025 at 03:54:33PM +0100, Johan Hovold wrote:
> The l12b and l15b supplies are used by components that are not (fully)
> described (and some never will be) and must never be disabled.

Which components?

> 
> Mark the regulators as always-on to prevent them from being disabled,
> for example, when consumers probe defer or suspend.
> 
> Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
> Cc: stable@vger.kernel.org	# 6.8
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

-- 
With best wishes
Dmitry

