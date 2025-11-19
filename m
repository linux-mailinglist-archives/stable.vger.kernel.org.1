Return-Path: <stable+bounces-195161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C33FC6D948
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 10:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F38F3580BD
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8A33373D;
	Wed, 19 Nov 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F133vRw/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLR66Z9T"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA857333437
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543042; cv=none; b=lEjBVV17pB/Z61uIUyIk7pBE90hAnXD48pdq6zsrZX7VlJm0mDJKWxgGCx/Dz0dHWKCj7yxld+zMnnkB2ESyBnKTHwD7mzI6svKEqr/p6KCcildifKLc0gr4xYRnkvwJpILRy1PPNSx678QP3PbB0WNdoRRG3taMau/s2/lKk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543042; c=relaxed/simple;
	bh=7PYuIVxtoPFYg62jWxIrmMhmv/W6lp9AHKj7G26g0YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjPG/ASscejmlF9Li2dDTUBy46lRVsyYlExioy64Sp+jZ1JptPgxorFCOG6bdd+bsT5gpg/FcC3kdAXsh7f0rdhPimAiaGTMWGTPG3E/TOmoKJOIU0l0zTT7U/SbD6cw6FbNVrgwHSRjRSEiP4Ost97984zKd0BFmgIrme9kbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F133vRw/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fLR66Z9T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ7aFxV718744
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 09:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/DVKl889ORLjBsf1CmtN97Ol
	7Es2W4sbC50Q/Zqk7ew=; b=F133vRw/ZJ4fThE/cs7tswbRjcTnZTuiyAs967t1
	NxQHcSXheN2PJro5DSDzxHxsHezA9zxtMzf0jMlIleexCKkH18KfJ3waNPYNOezy
	ISGNC6ijgr9lWqeCpvuvS9BaOXMbTzHtaeycy5f2b05aAOfxOiYkaYauwx7lqUw7
	r8SK0bKAasUHFzybeZjoH1vd6UYCs/UvmXqdml8cuDduOa0bjIZ919Mk+W8lBbH0
	ChUwpaFfwePjxBG9hU/9S3zEmqNC7KbJlo2rlQyV8lHCf7KgY7gaX8mf5IZYjIFz
	VqBWB8QSKJguAogkBGypg9Nx19QZ/eicOUTPLSurRncNYQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9n0r8pv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 09:03:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8805054afa1so169995016d6.0
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 01:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763543038; x=1764147838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DVKl889ORLjBsf1CmtN97Ol7Es2W4sbC50Q/Zqk7ew=;
        b=fLR66Z9TltbigcI8DJYw5dISyxiqjHLOHDSkLySxrHxUar9kKYq2XucypiYwD/KihC
         XNV0v1jmuXlS2pDc0AWkKTIpYjpWhcbRjVZApoWbbzH48HFhww+BkeaLJP2EbSPTduRV
         64difajofcehKA55DLusLncrwmU1gFlfKHkTvzaoQWek7JutsaIl0qd9BeZXyfeTRe8y
         xn1xwxdd13sT+dwNVXtE5H/iOycZJ7U7IWiys6tlN7RxPaoi5MmdSTfG3N4I4TC4t8sc
         wuESoLD7YGNjvHlC95Ra/tX2CnRBZ1wk51zJVNN4gc/EEjppWo/MQCKDVmEsuh3uT1KW
         opyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543038; x=1764147838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DVKl889ORLjBsf1CmtN97Ol7Es2W4sbC50Q/Zqk7ew=;
        b=L6zFymJwTJ77YjBxa18OO5iMISmrgl0aFjTxfzIMT9hEwXD4XMXiIITZS0LZitD4Y8
         K4Fx1sicRC3nP8TY/n+j8FytQz+Pi0uPcXL6LyX8v6u5bBbded+028iFE6X53PScOExC
         uh/B1GaHdIVpsUn5hyE+zEx5YvST+6DKxEpkU8IDvf9wGKS/+AohyjRnJSmIFwX5pWoy
         GsiqLIx6FVWNdkMAKkATHinuKyN+4vT+sUkNrC014JZTcWw1wKHSho8qPtm3BYP6r9yM
         U+oKcd2Co0NmtxzZ/WboyxFJyVDYp3jf6BT0g6DwYV1shX0JauCQjQcQHH/P6Z1I0tSg
         6n0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4lecZ38hqu0kYTDuHX7ZwbpjWgkyfLHuj1L5/FUbOe+3yj82u4doZ1jwS+PueGBzQ9fCqKD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqytA3budSabaM9loeF3J//y5oT/TP7/cef3BwWJ/o24JqrBBg
	mi1WYhAWuCrcvETFoP8M2a49WIgFhT2uYOedl3FxQhcDh4C3iE7nw7RmpqjplMGadW6QIuqshRS
	lqqGjFG+a4/8V/rPrDjgc1Hz+1yi5RKP0vsDjtWCOc8RZPkNGccgthOh611k=
X-Gm-Gg: ASbGncsxt6cmHDHudeYIdwLUYU8nQFGblKYG+x+kz//1yE8bA1OPZ7TMQN+RvnjjKMn
	2VbA0MPynReJ7oUpTZZUeNBNDynmqbe9vBq7D+wd5WM66Dh5I9wiM5o2B/79FjYcmsfhBuTVQaT
	LhikzoN/d1v3h7JGK8Iajr0msFPFhoWrYaM4kvBasuhpmTZJPGQdcTlyDRMkaEuqcvrYkU7/ofO
	e8rq6Y4Ke2D86y1UPsqdCWpyWIZNsXQpxWh8XPMJFhYFkAlBMO6NFlnQCavW3gjQcjwsRin8OpN
	eOEb/Zht3D4NGgUc8Axq4kuwScN6UBaGpZXTMMagHEh8Egnh31JRofDyOEpDwCyaI7KiwbA8/Eu
	mtWtnBDV7qu9/M+gpDKu3NDm6/7Pw+k+B47JjxVU30FXRllRaqfsA5LjYSuM5nNotdIpzTEHC8A
	OHLpTUVWV5NJdW12m6DfeHR30=
X-Received: by 2002:a05:622a:87:b0:4ee:1c10:729f with SMTP id d75a77b69052e-4ee1c1076admr155151801cf.35.1763543037805;
        Wed, 19 Nov 2025 01:03:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgCgf7dxZdMMwZXKao/8OhfR5srPEi9FV8w0+XM6CwVTnm8sYFYyJRINt88wai2SJeu1RY5w==
X-Received: by 2002:a05:622a:87:b0:4ee:1c10:729f with SMTP id d75a77b69052e-4ee1c1076admr155151571cf.35.1763543037376;
        Wed, 19 Nov 2025 01:03:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-595803b8bc7sm4478697e87.46.2025.11.19.01.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:03:56 -0800 (PST)
Date: Wed, 19 Nov 2025 11:03:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] phy: qcom: edp: Make the number of clocks flexible
Message-ID: <basmm6j76upxmb5h6tmqvuuehg3qvj3tfkbq4q6e7tugfkv4is@ttu4dam5h2gx>
References: <20250909-phy-qcom-edp-add-missing-refclk-v3-0-4ec55a0512ab@linaro.org>
 <20250909-phy-qcom-edp-add-missing-refclk-v3-2-4ec55a0512ab@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-phy-qcom-edp-add-missing-refclk-v3-2-4ec55a0512ab@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MCBTYWx0ZWRfXzTCbfS8e1y3v
 Y1zW5VLoysJf5aL1iEb1VwkALL57P72AzWtVmz6BjnNkP3Yr84lsfQRM4XlxY/cWvh1YI8eotFL
 xtYjYyjf6COdpGFqaJmvYq4gYxxTeHhH0+tkgjqhOPHysLI3A+Nq9HhLCvf3CR2ZAO0PrZeXQMs
 c+LVpqaI1u7r0NRoqAJ2iyYUZkRMaHo3Snt8wA/+vab0NDT+uMEtP5LM0qjmsGd9zj99BB/0q6A
 iXNRLq2g5EIvVBb0CxqIYzdL+Ocy5jyo00XtW7U8nsBSgwcsvO5O6hrHNihtazauxkDBMlbOhEb
 2pc1eLvQv3rjlMrahiyX74KabDS+UMga7P7h85Hf0s/IyeFAnaMSXkeQ9L/M5v5+rhSD2WMsleR
 TRZSXAw7U8WlYpaDVNdavYsH0zxa5w==
X-Proofpoint-GUID: s9BIpzLp1cYIJr7jSZJH79hBmDCn4XT5
X-Authority-Analysis: v=2.4 cv=QZlrf8bv c=1 sm=1 tr=0 ts=691d87fe cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=77Gn-jvO4NWksBu-1S8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: s9BIpzLp1cYIJr7jSZJH79hBmDCn4XT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190070

On Tue, Sep 09, 2025 at 10:33:34AM +0300, Abel Vesa wrote:
> On X Elite, the DP PHY needs another clock called ref, while all other
> platforms do not.
> 
> The current X Elite devices supported upstream work fine without this
> clock, because the boot firmware leaves this clock enabled. But we should
> not rely on that. Also, even though this change breaks the ABI, it is
> needed in order to make the driver disables this clock along with the
> other ones, for a proper bring-down of the entire PHY.
> 
> So in order to handle these clocks on different platforms, make the driver
> get all the clocks regardless of how many there are provided.
> 
> Cc: stable@vger.kernel.org # v6.10
> Fixes: db83c107dc29 ("phy: qcom: edp: Add v6 specific ops and X1E80100 platform support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

