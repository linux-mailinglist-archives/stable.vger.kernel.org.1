Return-Path: <stable+bounces-152682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B897AADA4DF
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 02:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC716C547
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 00:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FCBE65;
	Mon, 16 Jun 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOwC9Y4Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCA360
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750032682; cv=none; b=mAjAYg8JW3VhieoTuSi39QkmQb5Ysssz7+ewi7d0BPPJ/HzVBGA5nEMvoXykeugqfqABhS3PbXnTQ/KFOVB8UDLOrf6bYAFmVwMSwvIvMTRCNK17+atxMgkdWkbKLVkTn4yM3R5xnYwfRmEuYuJ1k7pJ6+m1OWQqdqcp2n1nL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750032682; c=relaxed/simple;
	bh=mbkkVgFYRVW7IBPbu1Cg2y20fCsMjcz3upWXASAHUPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD2ryCTp2XHIQIu84JXVKyGkTbc8eDa99+oaeUWxRB8YUrm34nA5F9H6ehuHzGLGWL6TbhP3Nd2Y+PFb/1an7aBxvquRF5vnAWv9dESvreoXpJiaB7YFGLmWBsm5lcsQQxAizOtK7RZRLKfnm0QyKJZ9NREMhQszJHv/3a7wS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOwC9Y4Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FN0dxC016220
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 00:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QGemQSnd+YjmPoLsIXiSnMUG
	hACJiUpHSlGPF4aQmUA=; b=QOwC9Y4QgzPoAIrn0bA4HgO6mxvb90gK25lWV7gV
	G0D7OncQoXfJMZeX/nN2ZXtYjRUNPu5hahwvSVsZPZ3Y/rPOo7qd+gpV2eVQpQXD
	k7FPM/dHX1XS1QGsR9YCsxVnqW/Vqs0QKiWSJ/OK5SjyoqEsETZu+Z6Q0eBldU7a
	wv54188WyiWoSvR3uEsh8WLrW6IIhEkAae3f432SbqJatUbovgtMVnBt6cUWnwrP
	NuDNIHWxpy7dvrtXMoV2lu7ZiiYNVtDCBCdz6vl58XfRVQOdNh0so0g/WblFkqyZ
	MFONlRKu3+SAwXyym+3gJf/wZN0/cxQGbsrKOwiWLKWXPA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792c9tgyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 00:11:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2a31f75so1350114985a.1
        for <stable@vger.kernel.org>; Sun, 15 Jun 2025 17:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750032671; x=1750637471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGemQSnd+YjmPoLsIXiSnMUGhACJiUpHSlGPF4aQmUA=;
        b=jn4TIzgrni2PNgnk/cYjgCUzAGeIP2Igr9uEN8zQPnMRqb2KA2dtoUQoC2VaRzY25D
         szhvUYwr1r1ouabNgrrUh8TgYDx/XPigPIXlOxmYfvx7hQeg5H8S74e47VSibw5tjzFS
         HywhoCBKYq+zkIUVl4g7lcoNNCjhxUEHVFYPXUbdX1ZLmXMhbjQAgbu0fqiwMTP8NPjI
         /ZvEOXZgYkRMau34AVe+zw1AgGAAvyQQ2/90UiBLmEdsGao8Kuuf0ZKFxoIqy04SAvBx
         mxkL4s3wJDbxCNMGqKYrO9T3hTekVHAx2qH9VE9HcAbPAXccLRbJeRudrw9SjOKE3xL4
         zf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXg9x5tnylUAjlf8oAUW39WG3NBnZXYuh3foFAAE5VuzNoWaZDs53nUpQ+W11o6+sKQrCYpgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyU6OSWJrNPi/68lAssNaZgF2dr16EClhkQyQL47gPCz0bsuKT
	YD95SBrH9o4sbaMOGTdX5T5qd0ans9sZp+bBQ+2z4U+MsgqTvEOt3TrFSa9fMmQ/LegulbpMQZJ
	I/UDlAMrknu0gJGy1jwjKIVMuGj1aIw5Je6isiepLfo+RBn2oYBoKg7k11a4=
X-Gm-Gg: ASbGnctSGWst63vt8ZYfsqJbluDYl4FCaGc0s85BjkcKoHD21ZYuqBzgg3T0dJSJiUP
	2GBekbCbHeimSD99fEu4xuD7E3HgeKehc4DWBkjMNX1A4MEOS9pcASbB9uVEdfM8ve9vL6ktAQW
	nAGSNi/SPCHyPG9OBgI/kFrhij4FkUBO5ZDkzHv9xzCiodH00WfnfqMiC216Ydb1vGkhNgLMyRU
	I4GoMhr33k3KY7qJsKaCFJ0LL2MmV+5Ctgl5Qt3BSaspSVbRfQKfoI3xQ8EVJdwpzTeBiyshpNV
	74RgYnB5uPSaaYMdt6Dlk4hqpAp+jByTZyowdwRD5oFeukhEtNvEmtrwTIvysTdVGTaRis8Jv+5
	IU68c48WlK6AHV1+8IRfzCLlTm0YrykZsIO8=
X-Received: by 2002:a05:620a:1a05:b0:7ce:bc1a:4902 with SMTP id af79cd13be357-7d3c6c16d6dmr1294939585a.13.1750032671258;
        Sun, 15 Jun 2025 17:11:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbSkDjTNs/Dr3Bi6RCwQRdoGGC3GS5fEbglwoZQ8FxFoTXhFx7VD+QofnLhJtsly5onZKa8Q==
X-Received: by 2002:a05:620a:1a05:b0:7ce:bc1a:4902 with SMTP id af79cd13be357-7d3c6c16d6dmr1294936985a.13.1750032670871;
        Sun, 15 Jun 2025 17:11:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b378371e9sm13076831fa.46.2025.06.15.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:11:08 -0700 (PDT)
Date: Mon, 16 Jun 2025 03:11:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, andersson@kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM6115 MDSS compatible
Message-ID: <bodnhg576oaludi2icuodo5ycjrplkjxpci3yh6sj62bbfj7ry@z2hm4cg7dclb>
References: <20250613173238.15061-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613173238.15061-1-alexey.klimov@linaro.org>
X-Proofpoint-GUID: 0kGNQrrOjCoX-sh0zSw63vj1BqSNO94E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDE4MCBTYWx0ZWRfX6RcberAQwVa6
 OUNjTzmA9KIuMbCFlXkwEFMRKgFcWT8H9x0fMN4xpAzv43527EnrergZhh1JRvzQexpq6NgnpGe
 ct5N1ssLg91T3lAlhEm8s40vAa/cLVcYU44UfKtXEbPcpxjpWMMWhqThrlmB2/R1r+D6YXnPw28
 Ai41QsFKydsCJFuN+Ob+DKoq1bVefOJ8OaBr0EO7jhlpIOfUFkr89v9geE0E1eThHIbqLFpyaUl
 BO2edF/D50fvUYZPbCAmGjqaG+JutPg0BW/ocAx0LSG54eZ8RFgeciZe4qLQXbXbJ2S+x9gfWSP
 FlbWFjEx7KJGKif09rLd4wOH9DoP/rZrkCuXqwr0Or4/Svxlz6d10mqFivzZk2Pa0O1l2eYaql0
 0WwD7yqvCJ3a7pan+kj90LJSYAq/zCb0fCPFiE0EcPlnf00eCR0xtvpT5S7SCE8A1O6wujMw
X-Proofpoint-ORIG-GUID: 0kGNQrrOjCoX-sh0zSw63vj1BqSNO94E
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=684f6120 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=7TFj5ihdlhLXfTPaXogA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=512
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506150180

On Fri, Jun 13, 2025 at 06:32:38PM +0100, Alexey Klimov wrote:
> Add the SM6115 MDSS compatible to clients compatible list, as it also
> needs that workaround.
> Without this workaround, for example, QRB4210 RB2 which is based on
> SM4250/SM6115 generates a lot of smmu unhandled context faults during
> boot:
> 
> arm_smmu_context_fault: 116854 callbacks suppressed
> arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x5c0ec600, fsynr=0x320021, cbfrsynra=0x420, cb=5
> arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
> arm-smmu c600000.iommu: FSYNR0 = 00320021 [S1CBNDX=50 PNU PLVL=1]
> arm-smmu c600000.iommu: Unhandled context fault: fsr=0x402,
> iova=0x5c0d7800, fsynr=0x320021, cbfrsynra=0x420, cb=5
> arm-smmu c600000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x420
> 
> and also failed initialisation of lontium lt9611uxc, gpu and dpu is
> observed:
> (binding MDSS components triggered by lt9611uxc have failed)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

