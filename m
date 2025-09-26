Return-Path: <stable+bounces-181798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB0BA55D5
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 00:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 338424E2DD0
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA929C327;
	Fri, 26 Sep 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9kdadyk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773711F4613
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926747; cv=none; b=YSz6wpS7IMuoGZ/cHMTRY9Q+EM3AIolZgrDhGuWL4k2HHT0TmfhpKYy6SwvasP9yVo2BYG8pEobf50WH/JTYLz+OS+qc0EOnvbY+xfEq8Vech1dR7XA3MENn2crIZDiImrEY/IuQp3MACibsbE6mfpXuvg0QwB9jQug8BPWO46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926747; c=relaxed/simple;
	bh=p5XvchawsOENanpzit5coWI2GxGks3nacGZ9hQTUsvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqu6mNN/r8jv8yQBrwhZZY+3d9ifZq8d7ZzclQB8zXvtx6OGBPUhzbSjQL4Les3ZHqhY7KJlBlz3bOnEhOlK8zr+LXtyZstVJx82Tux+DA+Er5N0nBTlAvh97u7TlJpQvegK+2bndBzHxvYF/b3HwgX/Ydc1LOyz44GTNynnta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9kdadyk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEX4gw006922
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 22:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sW/+vR8VmYRg0AyYThaCLKBv
	e8fCpAHlijREnAutP8U=; b=g9kdadyk3brJcAfoaIMpWd0XsAWx20JKzU8mdbfw
	1TVSnIQHptLVeLOJAZIdfhx4L4HuS3Na/OohxN8h5fDxbbXzUROWRkbhTZ224qiQ
	pfzKoaJTnw9KDV4qhWMEPB0CFrNRcmW8vr9zWbHf6H3IQE3HhG91aanoZW/MeGjP
	1nVWZx7NT7FvyCDQIXIa+k2SP/q/joUryI8GxKxAbnlxeCPZ1/NdioCDynYHHUoQ
	cZJjO/YbcxMrpZ5oJV2BKzUtHwu93THFj4GsnBKvoqrx32CdteNKnLZbiuySihMt
	Tpz9Ad5Da2k59I6kiXE+WbkV3yS6zarY9Fe9gjLoqCU1GA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qvau9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 22:45:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d9ec6e592bso53144541cf.2
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 15:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926743; x=1759531543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW/+vR8VmYRg0AyYThaCLKBve8fCpAHlijREnAutP8U=;
        b=c8DXiy+jOMjx/PW3b5LmOlG2ZhzOk4j+je3Did70uJwCJET2qD+JZDy0fhSWUJzcbF
         F+eSQpmE/HqFTq+nh1aNlSyzKWis6qHuqmdXzK5c5QbQJvVBxIE7lgdAQgWFofj4YdY4
         ATbR6l94J7/ZnDF/Ek3LV0eKDUlpf8Zh+PO4J1UsKf3efwqZo7cLzImvUEKFohADppkc
         EATaUa+EZxiqsqZs4Bgi2oS/pVKyAXLSKHiJOlmAnzAPb0q6NH8KQFPvBNFARPMo9uiC
         WfX26n948FJipE/kjMkVeAwOsVgHoBcjgQ4pPjOv7UdUXHGThom1sNimFIvSx8mE3GT8
         W0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUOppTc/h5+iB0Lb8QOydaoa2m5nXJnU+fVgZMRNslX9itFttVCKlAgXJTNsS1P/JmS7VNd2DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3CSbaPviw+0irCKabFegcv8pQkSAAjG62OwKp2oPl8ysLTPg
	u912+OojQVL5RfQG7yfQIHfHBR3dLt07/UE5olrCZiImoqL0Keo28yUIAA/4XfN6zCNDwzR7KtF
	6Xqvup54erIibhfyzj3ZdI08LtkyFQ8RVUH6X18pzdYNey5Xa3/IbBlHYzV8=
X-Gm-Gg: ASbGncuCCw4uaIErRoK4MXmsQmJMdLdi3cODVPAagohTHj8wN/hfJC0uxklVU9WUENh
	rTyEz1++aL8B7bBamB48JYUWvdEmJbDiV9BatNYvxUVZPrw9iPvrXwUPRsSJ5/O1GxZ2XJ0NRxe
	N0mmnZL0dED6kV/65PR1ZGGChjRGx2VY+tEtkuiNNGrd8FvOxUMoAxHVvCHifWOp2bbRC8v+1gv
	rUKXwkspWd4ej4NqFL2v6ikS2LcpZEXrcwQoPCnTufjJ1WAjzwRDHixSmZKqY6I1EMwNw6pB1qa
	mgugZGndEbkx1EDzHGGLk0MxTi0yJy6Vy5sTgVyAmfw5UtyO95qw1/bouzMtMw3Bpo1vkcTb5zL
	YI++xlZ+FFdgzgnP1p+Czv3HStMPJdFEB/jo+qHURjHrLVcrB1Una
X-Received: by 2002:ac8:7dcd:0:b0:4b6:39a2:1de1 with SMTP id d75a77b69052e-4da4b42c2d5mr130499121cf.52.1758926743200;
        Fri, 26 Sep 2025 15:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRfXtG/PeJOoa7YFdPRlCu9ZjyORleotSKki25Y6iLSpr2s7WbBrqGeVtAyk0UN9k7S1S1Zg==
X-Received: by 2002:ac8:7dcd:0:b0:4b6:39a2:1de1 with SMTP id d75a77b69052e-4da4b42c2d5mr130498621cf.52.1758926742648;
        Fri, 26 Sep 2025 15:45:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5847fd56eaasm945718e87.137.2025.09.26.15.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:45:40 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:45:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, andrzej.hajda@intel.com,
        treding@nvidia.com, kyungmin.park@samsung.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm: mipi-dsi: Fix an API misuse in
 mipi_dsi_device_register_full()
Message-ID: <m6fvifsbb2yjbx6txqc7luii5mwukrpiw2n6bcnrmgidm5cxjv@ksmcnqg6sv23>
References: <20250926091758.10069-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926091758.10069-1-haoxiang_li2024@163.com>
X-Proofpoint-GUID: h_Kq7rbOLDIh9IfjXThx3pYU-8Bucb-k
X-Proofpoint-ORIG-GUID: h_Kq7rbOLDIh9IfjXThx3pYU-8Bucb-k
X-Authority-Analysis: v=2.4 cv=api/yCZV c=1 sm=1 tr=0 ts=68d71798 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=tUFaMFilNNX-uVKmuBsA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX2YFUD1kVhxei
 E0RwXCvB4Lpr0Wvpq/Du72wL6NKNKOgYwcd9UYMBHELiderEHI0nzER0HBe8nzsQjERR0i5rXCs
 sh0a6aWWRnpwoygrnuo5f51s6FMj0ENRRuh6OQNg33uCMcOxeluhnBPHwrfJj6g34cdKrl4otVQ
 oiqn3LeGHM+bAbt6cnszNwOjBfYPkwfAM1DGaKmqL8rI2v4+y0wU5jPkhibu8crHKIal4fZ+wBg
 NdfhLQc3ITxfAR+Q7d32CCwXP7XbhMd4UCP542OWjYkiWGHAWmVScESvktRvhacm1UnA3bWje61
 e/rDph9L+wSefNpHTuomfF3mviRxIwFgvFhR/upEQGtm/cvVvBExXPIGf2f1guNvZbFoikf/GF/
 dULe2F06Ql+E+A1adSRn/NS9erpPLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Fri, Sep 26, 2025 at 05:17:58PM +0800, Haoxiang Li wrote:
> mipi_dsi_device_alloc() calls device_initialize() to initialize value
> "&dsi->dev". Thus "dsi" should be freed using put_device() in error
> handling path.
> 
> Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

