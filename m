Return-Path: <stable+bounces-179713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA6B592FD
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6175E168140
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A612F83A7;
	Tue, 16 Sep 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClHK62Cv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F42F7462
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017428; cv=none; b=KzoVgMK3YldM1NxFhSoyqATsEAA07VmsLmTYrshtc6i0XPRAFlz8jbMfS9n3LvE5/xGGCPJNNEdpO2IfDPE/nsCAaqqHsHn8u12Wjag5J6EDTWgK4QK/kXOa/xqRD0O4mopnFw6XHif+pQJj+JTaHYHC7woE085htboR/SJhVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017428; c=relaxed/simple;
	bh=XbVFcqCWViC3Ty/3Z0wTLN06tYYojOW9npjz34zaKWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhFg8d7kMUxfpQk7tecsN4RosucBsCX/6gm7g7QlEQOQE/DD4hyjgMNDhaptkKb0FnNZcoXO2F8HbpNnCeuVFebjB8AVd/mx7b11sbv4IUP78HPHIBivysg2JCaTZCtc3ylLgFiacmwsoJN2XRZ7YyL84rNV+5PSP2664Ika1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClHK62Cv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA13dR003890
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 10:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wKZA8BPl5AnCLEV2joJ24RdF
	tVw9jv4aVixR67Q19MY=; b=ClHK62CvK3ZDTQyUBb8sTAip0ggbSrF2CZpplJ5x
	kO5ini0JvfXSEuOy/Lpkb+DFOFY8lTxJaIGNYgOa7plJ3Xabo/CJ6WGBFN4D2DQn
	RkYRVLah6rRN+eEVLwJsRZY6rNYvjfClgFgKNMXrlAQCdr8ECZd3z6uFXgxfHCiM
	mq03sRBzh2eBtKC6clanyxDxRY85HYJCXhJAyV2wgrrgkunjnFz0wX58aR1Phngy
	9x5aD0uyOCb2jV7GwMq9IiTDcL13t+Mw0o/SwEACbgVeuihHe4q7CXUkZCOMMqca
	udi0dvciKfes0syQg6dB6iKhND0LNku6ga7hvCS3RbhN3Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494wyr8r55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 10:10:25 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e0ddd918aso222026d6.1
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 03:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017425; x=1758622225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKZA8BPl5AnCLEV2joJ24RdFtVw9jv4aVixR67Q19MY=;
        b=X2tTWbpMFAEF2c0g8oDThvEjADjCfwrRulPFAGr5GZGp+ki0By9qEg5C31oAq1tSea
         buHZJ2OSUK1R1KaajP4o9Dbn97AOqThonHHBf5HtLKHuNOe+QCPacVx8Vh97OwxqmmSW
         AfQlquYET1qXvsVjPZvurl7rFvozxSnXwCs8Qt7UfYR4GDYxkafhAIZ0GRIbVeKiFTqG
         Q0DKyuRY0EBT8A78uQ2cXNhUIsgB/SEyvWeLgadw70CyaOoTesY1wNWewcyHsSQFkU55
         txReVcPseelv5j40c9rKY9g+tVu9n3tZ9C6CVDDkqVNNBMbJqZGeSPbWJxCNHfwEq0MX
         fmrg==
X-Forwarded-Encrypted: i=1; AJvYcCWldcaqqjg72LPeEWBsXcCpkwIsaYZIMbhtbkH+ASRsjxUHkKFc22luoP4jHAy3UeTP46fT8Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS35wvKvPCb0m80lZAEN17TwJ82CKNm9EPTEvyFMNmko2SaT9
	6FU60OfmsIjqpuy1j0YtX4H6Z8e8mfbX+PmA8iMSgZTyrAsfAzXTOXI/xxm8rJPIx6K5uOJABSc
	eJCKO/ARoE36Bkmu+a56Ak3rhYNCtrNUFuht4zwyr94fVwbbj0Q55bnZ++ag=
X-Gm-Gg: ASbGnctwQ1fHDmoujzjhKSwwgcw3iUI9DIEsJaQqjjE3kfC2qO1yQ5cuOwsRjw8s1nX
	GuSbFwdFa99kMQCDTLDYO8PQ8DhJRNXXIPliuaeHbDzvePdWZKSW/JKuGHF0AvPvMyHaWAjFlbU
	5TEB+zUFU49aJpCFEY4/ivmQxN5CXdMemN9Q4IIZ+PmCrYWgA7ig0su2pQgMSjaXA8NPEFq3iK2
	0FBOh85Q6Uf38MbMv6Wf+9UAyMRUvEaIUa6xvzoBIlmedenO7eFfHuq6xztsroBoN4Nvhv7CW8I
	Gp5X3EYEHSpjBZDkoyFFk5ORzqOXlq23KyxrMeOOcHyVdwJzOrbFq6GVA5Y6GTHcLf4NaS1gNqK
	126o61xeHuXu7Qr/16R3GYHT1LkGnec/XzGpPuB5gepSjYudBOhYv
X-Received: by 2002:a05:6214:dae:b0:78d:4b58:2eca with SMTP id 6a1803df08f44-78d4b582f82mr20475226d6.26.1758017424884;
        Tue, 16 Sep 2025 03:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1ZEAVjtbKX71iAiDJ19Ofyo+pVaF7VLXJpCCJ2aZl++ji5oAc1d4XKZOcSuQMCS9y6Mh/8Q==
X-Received: by 2002:a05:6214:dae:b0:78d:4b58:2eca with SMTP id 6a1803df08f44-78d4b582f82mr20474886d6.26.1758017424433;
        Tue, 16 Sep 2025 03:10:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e651919d1sm4386662e87.126.2025.09.16.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:10:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:10:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
Message-ID: <pjalx3o2lfh3g6fxsaw3beir7ufpls4j5y3f7zdsgopvpr4vuc@5vldxr6lvojs>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
X-Proofpoint-ORIG-GUID: fS4j5-MaJ1szZBbV3zFd-NFaUk-e4ICn
X-Authority-Analysis: v=2.4 cv=SouQ6OO0 c=1 sm=1 tr=0 ts=68c93791 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=08tnehPgh3LRQT3fcTIA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMCBTYWx0ZWRfXyiFyQyeLSmie
 8WQcVBmiHDouJBjj0z6FMgnZ3tq1Uf4h8ViDLWJiDPNrZGhor1Oqnn0RHWI1kvs0rODWrcfbwdd
 PvHV63oC9/xSmvNzf4uVyLNVInclnHR9GkU5Z0PUpX+/91d5sYiMXWdMXy4Rn8V+NPD443sqFV5
 h81GuN+Guh4rn4vqik4vdDXFgv4vbZRaRuJRXa2bvUi6QUvyTbs+Eld7K0rRrYdU8hH91VVPhp+
 YC5LEtKC7W7hQvbPZc/Dpmg5iHU7GNGP6cwEHN6+yB+S9MQ8qRfO/Ece+fNp1g9sdXpIFiexWH9
 reLnukwORQVHwDJvfmFUrOqVzPFjAU9KFW4gIeIYGe9vPSWWHJWJPyMvKkuarag/uhqgGTuiv4b
 GgQE3ktO
X-Proofpoint-GUID: fS4j5-MaJ1szZBbV3zFd-NFaUk-e4ICn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130000

On Fri, Mar 14, 2025 at 10:17:02AM +0100, Luca Weiss wrote:
> During upstreaming the order of clocks was adjusted to match the
> upstream sort order, but mistakently freq-table-hz wasn't re-ordered
> with the new order.
> 
> Fix that by moving the entry for the ICE clk to the last place.
> 
> Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

