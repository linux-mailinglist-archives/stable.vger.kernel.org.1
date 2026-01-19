Return-Path: <stable+bounces-210348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18138D3A999
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 13:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35F173000EAC
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B760361DAE;
	Mon, 19 Jan 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6X5IIB8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HnyP4htM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124C326954
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827361; cv=none; b=ROn+pbemiOf854DHBgIPSDpjDuAVV7OfAx4zKiuErFHa7uBFA4AUFtKCOq3hViIIduZ6tlB7yvORVFngYwJ18PveX+ubhQcVKwKjB6sL0MHTPM0fbqoK0EJdbmvTeOGLkHNgoycePQT3s13Mi/dTFWNGxqO5gU7yxMPKWgu9SKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827361; c=relaxed/simple;
	bh=hautpUdBrGAgPPkBKUZ5f9mJzlxwF/Hy2WN8wkjP5a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVM9wJ3Nl3j/DVaSVKcwzVK/KuYP1QJTQ0ed5NiRIJ/mKqXmimMOPDbev/yN7xfCNRSY0B8Yrm1jkGgnS60c+mux4VBNt4NEY/4gWqOSOJKDwuEEpDmgL9/t3JMVMaUVND/aeOX6k6DyQVAT/oY6VsDrT3Dohp7e6elKZb782NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6X5IIB8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HnyP4htM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDKDI1440811
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DKqrhLXRipHTX2o/kMbissJ+
	QS7u/kS1j63CzCsZxCM=; b=E6X5IIB8GKBbzMijLAfpPFRs88SAqdEssKIlsXde
	I6CcnTKimZA0mK7ndQp4qHnNP0E7Dk0avi1gM6V5WAOMY/XM3aSH9/bGjaBt5Yk5
	vBfw09nzBCKJGa2OxTSOOobc9yeTr8w9QMNnP1vi571Yjq/OLwlRiRbxYGPNIyES
	onxS2TbeLnCeod0VQ9bUHevv3M1ptYWT5vkgC2KmlOBh0xzP+Ww5sVwRSwLCKjX1
	0tmB0QwHedXFoleJeZnOnU5vr788+HLXDpzK75t24VSzbY/C6RzmV4zvjjxWrvY0
	lZaDbn/Cx2jXOsengOQDkxp9JiHp8ZfjgqQGUgB2PXodMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskj3g8h7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 12:55:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c52af6855fso577838685a.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 04:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768827359; x=1769432159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKqrhLXRipHTX2o/kMbissJ+QS7u/kS1j63CzCsZxCM=;
        b=HnyP4htM7u5tiUNa76RW6VsAJbx+1MPRtGjZUPowkgubhzL/qys+eyvCvceFYxUHDo
         5xGOtG7cYR/GIKBalPJf53kGOG1ygaICAk/vg6aTUWqArOvb3XJZ9dwh16rDJ0mzUAN5
         xgOzj0ahK0ixWzFHMNnCJnCo0qLWJ/qZB1m/UytCk0N6ZXKB6HwFFM3qNAuRbczxr2N2
         Nj2G3DLT2F6Wlz0rVqymfGYCKYZylufSnJWBB2NaWS4fPB9EfY+NfYwEmCedaOsM+970
         HtRJelF+YVltTaThhqCU/h8qCfQQPhO/t4rvmDszwYhtF8i7ELpsATcVsybVYMr5ZEaH
         b84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768827359; x=1769432159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKqrhLXRipHTX2o/kMbissJ+QS7u/kS1j63CzCsZxCM=;
        b=cjb4jcUHHYsFkyZRh3FGVE6yXaxLUoLAUnllWImjLp8/2FHu1GqvQNdvZ9PZBryXE8
         jWjeLpCWEG+4llgwvj6gnwgB3SiZiLAT3MApgUr1cZvKDFKGZPhASAhoOdat8P2Xfqk2
         87bQKFSZ4lSJWJqPQrwS5w/U7idCeFJRZAtBOmE/OjJJ971nIVXDy8KxL+AoMnnzAyP2
         e67tv0tKAk4faLJRq1zg942WdocJlGH6PC8+J5pWBphInTZp1Ki4bSHPQYbZBOoX4/ic
         9KFXBhyRfiqx1jp7RBBIokM2d9yVQaEVmzofTvwG+CGgJZoHGbNYlDZw9MQHDuAJ1z4m
         HLhA==
X-Forwarded-Encrypted: i=1; AJvYcCVHiDisJc/yaDg2NN275OB3Y7KQobcN/OAVqT/ejkFEHWlsfoR+fYEmeJnB+yMPuVDGfXfO9c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxanBFl0qh6DCf6nakiB9WXq5NvdcTRxStqVkvMVv3TtaWFH/Yb
	ZeX2saKT3ed/Z6qsnyM9z/ug9+CbYNA4vbiXkisJL8+E0CUv6MgUk3jda5CR5CHbrZJw70g7RYt
	wJMl9sTkDbSJIiHVPUP4IjHcxjWFzbEFm/djIge8lOWBHN3ZvDaD6ojEDJpc=
X-Gm-Gg: AY/fxX4wMjGF+fvkYRUzChCfFKOtwEF6bjn7uVT24XnVccbVw26LOo2JCjTnGkqCCgX
	60RNM26MiqFd+hwTvofSCYpXgOEKPZX8vlydPaG//xUb7CupAUM4fubB7ep1Iv9t7jlp4JrOvZm
	SoGc1xtpfWjuJv8KRKjhiTGgjRihuOlPYfag147yPtC9u0iyrAM+urIjAs2sUMLl4Yqs5dXyN4R
	74fwGoV29KHYIxGsGNAdujpO2NBqOZWKX2L+6TgZQP/NdKmHiTYmUEJ1j+X5Yx+Ke0tSVwS5ZAp
	Lf/kYdTOwdudyh45g8T8gPcTMXEriDcjgbcPvYz7brcahXNXKcI9G7b1Z2YyF40cCyn1yllEeLp
	Qk8sR8pWzyxun2oeaORb8dyU9NfYlQ/zcwYAhkHe2UElgZDM9gC9ff1vEJtyoy9d5IQHe+4lDsM
	0VVLsPtNvpp0uvml+vRczSGhg=
X-Received: by 2002:a05:620a:4445:b0:8c6:aeff:4002 with SMTP id af79cd13be357-8c6aeff4005mr1258258085a.81.1768827358697;
        Mon, 19 Jan 2026 04:55:58 -0800 (PST)
X-Received: by 2002:a05:620a:4445:b0:8c6:aeff:4002 with SMTP id af79cd13be357-8c6aeff4005mr1258255285a.81.1768827358183;
        Mon, 19 Jan 2026 04:55:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf39c3a0sm3269087e87.81.2026.01.19.04.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:55:56 -0800 (PST)
Date: Mon, 19 Jan 2026 14:55:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v2] drm/msm/dp: Correct LeMans/Monaco DP phy
 Swing/Emphasis setting
Message-ID: <47skckagggxijdhinmmibtrd3dydixtj6pccrgjwyczs7bj2te@2rq2iprmzvyf>
References: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ds7Wylg4 c=1 sm=1 tr=0 ts=696e29df cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YA03fZz7SpFxgGhAhAYA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDEwNiBTYWx0ZWRfX5la5KNcKhZ8n
 s2yTtR7zn7ZkcICngZkF5ZD+Yf3vNm7B5VjPniuFD/JoyT0kzBJV04FbXnWKUpq/naaqV4Na675
 gK6cB1ow5K3dDsNN9bKpKe4SfDKv/gS7FrQyn8QBc8GfBM3vA/O5GbbpNgFO+GJTdP/ZSpb8dLR
 IuJjttYl32ixZrmE9AIFKlcwUzqzcxyGR6qy1Sbwu/gIDT7POm9Q+60NxYcT7rqFeXBFxn3ElD7
 ExuKQsEqkoM4PBwxGL+dAmRoLKQT2QaNNnj3PXi8YqYCyrXbWi2uPgJ2giE+ptVSegq5Oy/5KCT
 uk16oLD+DeAtwAsrBpPI29rsrDgZ9MzCI+l0LMGxpBO2VGL3aU5DagWBy4xEVxuxn2I6XpHOlco
 QeWqf1xHK62V6LqOaDWMyJNXrt26Zw6sOxka6DSBFYHTR3B43RTh8lgUmqcMgJs551S4lN3JbgP
 HG30uF8+WeNufZ0YwCA==
X-Proofpoint-ORIG-GUID: 4SofVbjPIvUw96pY7rr-OkOxT2Osl3DW
X-Proofpoint-GUID: 4SofVbjPIvUw96pY7rr-OkOxT2Osl3DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190106

On Mon, Jan 19, 2026 at 08:37:20PM +0800, Yongxing Mou wrote:
> Currently, the LeMans/Monaco devices and their derivative platforms
> operate in DP mode rather than eDP mode. Per the PHY HPG, the Swing and
> Emphasis settings need to be corrected to the proper values.

No, they need to be configured dynamically. I wrote earlier that the
driver needs refactoring. 

> 
> This will help achieve successful link training on some dongles.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Changes in v2:
> - Separate the LDO change out.[Konrad][Dmitry]
> - Modify the commit message.[Dmitry]
> - Link to v1: https://lore.kernel.org/r/20260109-klm_dpphy-v1-1-a6b6abe382de@oss.qualcomm.com
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

