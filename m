Return-Path: <stable+bounces-92773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788029C587D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D53B358B2
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219C217466;
	Tue, 12 Nov 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hDVYOCMl"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728202144C0
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409884; cv=none; b=a8/7kny3wqDn5T9GMzjtByqju4wrAF/Fdyp4Umnva0Oxb2zT8YSAkriBm57H0vH8wu+pIdSz9s0koiEnNxuv+5GwOXW2GdTQ94wRZjV9u3LUcHW94AlLDoyKGy7+7OtPzddCMnSO2aDToua4YOaYq0ICOgk/YBQ9U5+MCw5vEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409884; c=relaxed/simple;
	bh=ywR85OiWuzWlgWAd2eNOPKgqgkUU3b/hcNQah1GT2Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1VBluBj5aoG/4u+/Sjbguz0C9Em5bEpUky+4OF/Pz8mfL7MKQLk/rtHorAtvlJ4vCi+bBJP2nGbiiWa1bCl1M7qZLEJZ1+lBzS9QY4MAG5Ca3bf7E1lDeNPXAJ4BGsTiUzvIvF/nOOWHSWfB9UZ4DWt4wiSwVu/lN7uvAk5aG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hDVYOCMl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC2TKtj020803
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 11:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h5t7dc7G/jjBr8WlAlwPdc9LxkWltx2aKpkt9Hv6dQE=; b=hDVYOCMljcutU6aD
	8Gb/mUCrLbmjZiCK842u2yTxArjKNi46LwoR9896VHV3ouz8NuH0ywr116Yj+w/E
	8L1lAzvMd/qUNEJWFAY/ryzqU5X61MkrQRRnKHfMTyzFeXTOcsLIxJO5PEiTqhe4
	4YeFX7B+enlqVqUZgzIrBBTiKiTWSwEScXAplLJfwVOGk+RrkP7Nj37H8dbxLrwA
	lE7N27biVnwatQZPY1HM2oO6xDtk8MyE1o02DLpI5lHGFPeSY+GfUNV53vxum6sK
	piMKpWMB9mQxQZRdHl881BBuNyFdirgyKyTdnksfOAFPebxKZHHY5hg4nvywq5h+
	GDD6Rw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t1186yhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 11:11:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe149b1cfso1632866d6.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 03:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409881; x=1732014681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5t7dc7G/jjBr8WlAlwPdc9LxkWltx2aKpkt9Hv6dQE=;
        b=PSSJLU1/1KvCtMOHJiU9o9EW32744h8WlWzA2+HLzFBdfv/EVDXf12J8nUbg5QZRnk
         TVgyWgLkIeYtJ+gdaSce/kZspZpUzUtYWgcv4G/OWlJyEOKDjTvf5xhYKVJ7FbdJJr1D
         LaWm1mO4eILKkla5m73iW1wZ7e5ajUBUe5gd3VeWxoFZb7tM4F5+2ejmTcGGZaa3vmpn
         BTa0mTlnixcOsa4A2RCTDRZCk262vRr/GR0lQHEtlNC3cLWXQiNHsXOjuPjuRrzR994o
         6oquQaaFL4n9jf8Jqxo6zy+1zpUGTv61Ughbjohf7xQ10juNweygXNnD3weOFNy/J3mP
         S1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ExmVJjASdoTRCEZnFGOqoR3+AUWF0ZZcejdyTf8Gi/XKg3QoHCRgRFpXQrL+/qPbGSn11Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlci1X/D8FwcvC/r/Z5j8ofZli6I4/cuMm0PgG4fk7aCR2Oz0x
	DDMIlvxw1BMhtEDXbLp+xwf8pp3LqFkaBdlQIDwh5OUuICyQ82EbgiEGYW0ZS5KkKTASuctEiQ2
	Cmh59Fj+P1Il1149bDvotzA89q5uJzAygJ7pr2NGr0Re24SG96GA/P14=
X-Received: by 2002:a05:620a:24c5:b0:7a9:a632:3fdf with SMTP id af79cd13be357-7b331e616abmr930877985a.13.1731409881283;
        Tue, 12 Nov 2024 03:11:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECna4oHPwSQGVlcKMRTsp1CXWFFwVbPJfw844hm3cc6KdClilnMMxBnVcLsnfGr7SMHpmrpA==
X-Received: by 2002:a05:620a:24c5:b0:7a9:a632:3fdf with SMTP id af79cd13be357-7b331e616abmr930875985a.13.1731409880912;
        Tue, 12 Nov 2024 03:11:20 -0800 (PST)
Received: from [192.168.123.190] (public-gprs527294.centertel.pl. [31.61.178.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def4b5sm710246366b.146.2024.11.12.03.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:11:20 -0800 (PST)
Message-ID: <a10193c1-a89f-45ed-afbf-ab75b3a4ba43@oss.qualcomm.com>
Date: Tue, 12 Nov 2024 12:11:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-qmp: Fix register name in RX Lane config of
 SC8280XP
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mantas Pucka <mantas@8devices.com>, Abel Vesa <abel.vesa@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, stable@vger.kernel.org
References: <20241112092831.4110942-1-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241112092831.4110942-1-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RMIFSApp6Mg8tp2pw35Bos4z_AAu3ngV
X-Proofpoint-GUID: RMIFSApp6Mg8tp2pw35Bos4z_AAu3ngV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=566 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120091



On 12-Nov-24 10:28, Krishna Kurapati wrote:
> In RX Lane configuration sequence of SC8280XP, the register
> V5_RX_UCDR_FO_GAIN is incorrectly spelled as RX_UCDR_SO_GAIN and
> hence the programming sequence is wrong. Fix the register sequence
> accordingly to avoid any compliance failures. This has been tested
> on SA8775P by checking device mode enumeration in SuperSpeed.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---

Good catch!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

