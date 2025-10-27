Return-Path: <stable+bounces-190004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC0C0E8BA
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81BB9500BC5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDB30597A;
	Mon, 27 Oct 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUUKXjTp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D630EF85
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575952; cv=none; b=TVgQaQNbyX31OHpJVmgbps/lndEvLNWUfP6yQ/mLyYyN0ZalvI/ZGVPdhyHMmcue7UEQNS58FWUhF0J7pJ0xbNTQwPLUeODODZmJXqlU5XEOljJ9YGEnFDEERggE16QfvcYpFIAsqhnMeUVvhkxkY98xHw5XzkzYdTE3ikGuT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575952; c=relaxed/simple;
	bh=47HzZofMxL0ovAwgF2N0WwWZU4d7Fcqxln3pLvlcFrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK8WcNW3MIAznW+mZWRWEK5/alTTWKxcEIoqa3iz5sjjdLcN3XMpCOd7jj8BKA38RLG3NBFVX28puZAbZt1AXLrbOIrOO73kMxHDKzcbWnShplp4cSTIUAON9TmD2l/Bf6DEQmoTOn3uHE7EkM3B7WzCOo7CN/DDtCMEnF1070Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUUKXjTp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RCTp1G2752119
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aYCptxushuK85zBtS4ghGUMa
	UfbytrxnOA8EMRRHrZY=; b=UUUKXjTpHCKASlEf0rB5/nCagNQ/5xVg9fGr+oWR
	veStfZsybImG24joodx6e9Ax3C842i0HTslBXrUIkZu7+clFwnfeiuRv2LKIL0tj
	g2kt/2jJ9Que83VTHP10ve/RKnAG8+sMC/g+Hkn4vEhDiWKcbImHukQkelyt6a4E
	pKDmLwpqPkMybRiOq/rJkWvRRY4iK+GVydD543mova5ikhDcuKWXrB7pF6dqYfqn
	rbCwfRJ9Tu7qc5wA0fcVbm4FlblkcEJIx3qLFvAyKobBXtA43zky95lzTNx7azb9
	yhpP3OHVWlA2yNooWa8uvskQTf1LQmPjmsiomSUoSXG6rA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28swgcxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 14:39:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c146f81cdso124021216d6.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575947; x=1762180747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYCptxushuK85zBtS4ghGUMaUfbytrxnOA8EMRRHrZY=;
        b=Jr8pcWG4jmCR3RdA+lXQEZ929i/TnHzjFs8N4+CAxKR3msTBhtTQfrtiMpY3Ow/XG+
         cWlsdOXKX4+DSBKQ4GxOYnkU7KIfbF++DI83gXrIHAlJXJlYsHItQUD0wPjg1fgk8XTB
         R3FhVOp8HpyPRWqELpZ6jhqUkhNLd+cuVaTOQE+Jyn67veaTk90FP1jZFukAhq/hLwpl
         un/ldE4LHHk8qWXwMeZANvLWhp7x/HM2tBS3KZgEdo2ZIEXb+d8LWMNS9t84Jw4lc0UR
         qwP5JnnUAKMfHhXgrCcg4fgvDyawYPCY7OgdU52ffZn276xhbygoyATvz1tWJeeNlXWX
         kjdw==
X-Forwarded-Encrypted: i=1; AJvYcCVb2++0j46edUTiHp+Nl/k2VtfTSh6aFccbTN/SvgFboTxdkRz9y8DuhbzFWFUDwBHimx6Q33o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNhsXd6dk13IPVgAW58fC9RrD5AWLlACgCliM3TILEKpDbJPw
	mto4daUR3jlPx/rImH/Uw170n6hzg05PeAbDG/RWsknwyfoq5qAh/W2tLIwj6OlwZXGkB45oP30
	P7Q70GTbf4yy1sKvXJG9YPD0CCG6mRhQjBnd3XTHQvCzy+rqRugvSmOSsUs4=
X-Gm-Gg: ASbGncsyibHgZ1Td3PCQIoDIyFZY5NshOoqWAg827zkm6ts+E8V/DYT6jjXNevLeJ4H
	nnM4ZmgVpkYom6qTupynMdCvwpRbkKQzGrhKNhF6uQVdnQyIY7fFuSceDAYtKGqPuOuXFTRrSzQ
	EVr8Eja3+URbPIVI+3rRYmuGkApMxFXJ6CAED+KiHz2mQHh31aHam6nkw7bMkBpspRgm97IeBw1
	hmufsGMGb3AUsNS31JQf9cI8WT4MorUXy8sodlYQPkc4J79Fxc83BNHXQx100JsBhFj2+9vTMms
	545MCgl1H7xB3OWjAzwQH1z37Y+OiBByxEqSMdC5JMnlpUh4+2phAnuJ+6xv6zuFPrDqouRurlb
	mwMpRV3rTUfHFFEXZhtW/YQcKwf8RRrU6VJaeGJNn/z42ht4aBn67xywLFZ/KV+vmVj9gsdK9Zs
	rqnsi7I22WBzR5
X-Received: by 2002:a05:622a:210:b0:4e8:b739:6b5d with SMTP id d75a77b69052e-4ed075af157mr2499761cf.46.1761575946962;
        Mon, 27 Oct 2025 07:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE25V05R9DFD8UMFppmwdaHhnps1+EhW4/tRntEoJQnX+uPBq3zljmulhRuh9PeNVhTxFxKCA==
X-Received: by 2002:a05:622a:210:b0:4e8:b739:6b5d with SMTP id d75a77b69052e-4ed075af157mr2499321cf.46.1761575946421;
        Mon, 27 Oct 2025 07:39:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41cddsm2320354e87.17.2025.10.27.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:39:05 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:39:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] slimbus: ngd: Fix reference count leak in
 qcom_slim_ngd_notify_slaves
Message-ID: <ke5p44nthtwvmptp374xtkkc7giwvnxwheyx4ohz6fugdwinta@w5timotaxhkq>
References: <20251027060601.33228-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027060601.33228-1-linmq006@gmail.com>
X-Proofpoint-ORIG-GUID: e4AFS78VyWvBYIiM0S772hh1g-HHr4fn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzNiBTYWx0ZWRfXwh0Ft7AnNce2
 kIug9GpzsWCZ40W3GpMHCNG2y0Ztbg3nRABlCBFb5nTgbjuqajsU2dU0oVsBRkKBdpSA+kBsOmn
 zCJhLb7T3c1rCQZda7l3kRXT+xMPoA9ELivBn16B9XEUEaPE0hnLPZWW23FxVA86MwxzVrnHlQD
 rq3jiFygoE+p789jEr/3sIRjmSZux3QvxF8z/y4e4R3ucyltQIDkI5PyqWC6uMBQzL52EJQk6dp
 1FlZpfuZXjOhQpidjP19ruZQe1HWJkA1fA3Z/4TRrFq+/1o8ui4qI8JM/DXT0ib5fKT1N3zeVmR
 fBx/4jwqXW/I5AW5jWKj1RYYokfOiFJt7CAJONu7vszM1utL3xzWI4Hg/ZFzK8RUU2XFNSuRtLx
 tBzTs5h+tuyng3uTeSggjtmxy6GOiw==
X-Proofpoint-GUID: e4AFS78VyWvBYIiM0S772hh1g-HHr4fn
X-Authority-Analysis: v=2.4 cv=fL40HJae c=1 sm=1 tr=0 ts=68ff840b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Y9G3A3km2bKrLaHVutgA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270136

On Mon, Oct 27, 2025 at 02:06:01PM +0800, Miaoqian Lin wrote:
> The function qcom_slim_ngd_notify_slaves() calls of_slim_get_device() which
> internally uses device_find_child() to obtain a device reference.
> According to the device_find_child() documentation,
> the caller must drop the reference with put_device() after use.
> 
> Found via static analysis and this is similar to commit 4e65bda8273c
> ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

