Return-Path: <stable+bounces-197054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6DC8C107
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABBBA4E6C98
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C83064B9;
	Wed, 26 Nov 2025 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEl/yGbC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ds7WZijG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED743168FC
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193367; cv=none; b=RBVRCSi8xnTfFDmvbwYJqnMViWM9w2fu/yJc1It4TweXA1U4za59CtMx9IWG61z8kWEf7DbQF1/P+YVYhW2YN8au6446CgMWGw0X05wmwVDwAM4QfpDWuvJcRfVHsJzdENHv27329NnK0SmkWoF5kmGskYCL6yHV9YY+8mPlCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193367; c=relaxed/simple;
	bh=KLk0N1FAetp7tkmzfYNdMAb0rPrwY7OkD8wk8cLPZrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA8LuCDFlotCY8rAM/WEq+gs0dKeqboKoKljKIA9b9ujf/l27lwgOAiKw0ghIecp8LJJn3uiAkjSh+zncXyKDp+kh8RaI5o/oDrZ9iNvFI1eSGLofm1s+DyIqLsC940oGsGW053VYAMZtsJ/r2tSby22Cz/nsDbxNwv3uaeDvDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GEl/yGbC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ds7WZijG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQJMIwP2222100
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 21:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z+WPrqph3VWDf+dS1LJJ1KlR
	DwYS2bbPcyS/oPhvXlc=; b=GEl/yGbCRUI/c6OQ8IPSjWdNvZXV91TguQT5Y6aw
	PcDDhC5scY/y7LgUKz24x2muKP5S/mYwvC8lYOEnoncCvbwXdqjoUsE2NbXdR/jz
	FDPDpCB9o3SUKKPH8tCkY/jHh0DR5TS77wP/DxSO3XXu09ceQn88dELmbY0sOYIc
	HRaHz2Ut3sJUHivN9lqE8ADjYG2WYLh/XbmpChF9m76oY18Px/pRaWlrDvjCmL/8
	KDWElglI16o3+Hp+CsE5ssTRU29PmAUGTtdGXpfyVRVmAbxJQP5wfVzCXbYBQcNV
	pFGawcgkSYkGLFzJ5ytdsieRRB5WSpmpD8O6rll9+aS+kQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap7n489pw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 21:42:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b259f0da04so52362585a.0
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764193364; x=1764798164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+WPrqph3VWDf+dS1LJJ1KlRDwYS2bbPcyS/oPhvXlc=;
        b=Ds7WZijGhFcobO0QGU67vZXTyXij34eA6xK0dQX22V5vhD+wGzwaG/XpH5ZOVYIJoR
         lA5Rq6HMqBDDDnu91P+OoIJ6sZ1M+LN3YKY9U/Rr6WAMzMzRrbD2M76o0yYbbyfgUB3w
         4qGw/PLZ3I61Dg/Q9OZEzt+aN726/AWzg2a37wcCD2KMw6OzpiCyY/3oeKLU4v6mpQaC
         7wRZGwd4s+vaHj/W/VJxtgYL/qGZpTm1xFpEcBCX77nD+Ddd2LvxoMzyZurovVUdnx0m
         5SHpgVAmbGh2a+glFjGC5P5YqxSNaEnr74DUDqXMoEKuYIQOcxzACXYe6OGOKM3qzYAm
         qK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193364; x=1764798164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+WPrqph3VWDf+dS1LJJ1KlRDwYS2bbPcyS/oPhvXlc=;
        b=KViea90IlHbhjNlqV2f9UH5b5atkmDQDRRtibaXazeIEuuE9UE+pM7OU1mTHHhWI+H
         1TeKv+BidYNEq+ScNiijWZ7KQhwa/Tcd9ENqo2H5StCbyFhu7tPwxX4i4ySWT/+NXOT5
         yYkkAw6kCzb9dxldaXykTT8pGB5SllhFjHfoXA/1/l3KsnzZ+vO5KM4jXBG1F/Ese3bM
         aXbygtSbdthTeumlQ2NZhfecw17qFSzyB6ofpggRijCmCqhBKKnU3V7r8HXzjSsb0uVV
         rjGc4S5ceRd52ubsJy1oT3M7eZwtboKc62d9LioRvmOdbC+rq3OhFaEhSzPRy3DCkW9a
         XGDg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Y/z1nj2Djy0kPs0VDgeJhTUNNoFgj9ROBeFnV6ZlHhvHgsPhXCa8Qpz/8zCyiG38FJ2Qvwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZQGPJXaKYzofilAFacU4xjl11exrEl8dKHx5Xp/ZErMmRkWm
	gKQYFPCFcCfftRYF7DSzBVLJ+vBd2eR/zPU/slH1a2iDyjw8A9gU1aoSqYVJcSuKQyQ1Pq4IqIw
	srt3VscGnwlM3nXDh26+jvXJ0xtFoSNVixdycW/IsbKQKnBvytpACIhUCKv4=
X-Gm-Gg: ASbGncscm2mTG98PLDCvu3dhYJSZsHhd/3YmNQnisHshbsyzEDZlWEnuhKR2kkcLtzy
	FTZSukp+5/7VdOetNLaQ5Rj/LSfeZZE0gAYqI33SnxBqWX9lrdtRIqd5ewgYBexXwegOoqNeBYC
	14AI0vnG1OvJUlwJ0PybvljbkT3NTysZpyOdmscnsnxeajPiqVe9WJ0xMZt2ZDaZPItG5A7bh8L
	9/igbPqzk8GrBsy+nmmvGYbqCsbZP4dOI/Z0mammQNTdwozQGMB2tHJnefOgb6cz9eDI2QZr5uR
	tkYdBueI4xGt5B/TQ0ccdKlhHbXYUapb1VWsPIU+Se0a21zUInIHQBiiE2HcGDpgek6Sa0/2gbV
	9vC6IvyBc9aTHPUgh1t50wKi2TGc8ht/1/A/xka93FowZwAsIylrQjO2y/CwlDsLbf4aP25PEBc
	FXJN7bXbWVy4cem7hgV49IClU=
X-Received: by 2002:a05:620a:28d2:b0:8b2:dd7b:cc8a with SMTP id af79cd13be357-8b33d469758mr2883990285a.75.1764193364110;
        Wed, 26 Nov 2025 13:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH2vVGd+GcWOMX+Re4xb1YF/CKD+k9Z5kHfJEow6wWU+/bNxqvRsyFDVIN+UdpwQznY75zxQ==
X-Received: by 2002:a05:620a:28d2:b0:8b2:dd7b:cc8a with SMTP id af79cd13be357-8b33d469758mr2883985685a.75.1764193363526;
        Wed, 26 Nov 2025 13:42:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b59ef2sm41430281fa.16.2025.11.26.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:42:41 -0800 (PST)
Date: Wed, 26 Nov 2025 23:42:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm: add PERFCTR_CNTL to ifpc_reglist
Message-ID: <c5t3ae5ip2eoxrxv34ssudf3det73nht2ug6o6ia5lawy2ws7d@jafvcijp5hjg>
References: <20251126-ifpc_counters-v2-1-b798bc433eff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-ifpc_counters-v2-1-b798bc433eff@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3NiBTYWx0ZWRfX/sHALvuepQJe
 bKaVGEXZXHI6yiOfR4g/ZQUwphP1EyZnzxMfeowEwgF0jhhR7QbyYy67AS1gaMlkCMePsDxUZ6J
 uJPLw4YePbLmWli7oyXVPSpsbPg1fyLxn0U37vAHk2c7DselWt8si2kOZFwISg4YjJ5P6FSwVqn
 sCgt9TX/Ftw+YPqwKE4OHNvpOo/Nvt0JYRv3KFkGzRKfhyQqEOyfhpb5YL0ed0flus0L6soJh1Y
 wuX5rpXcXeKqlsz04GvPo/b7ADjGBV7NOiKD/SUeYMZnzO/unEHxx8wauWiIToSmCxru2fraiEJ
 zbUU7EpBl7dvxgQsSZKojjXB0Z2RBLNwA5Q1OpCffgKsizfSsqTdomGseZ6hDEeHAn0qhjg62HX
 jGHXscBkQSGAvtqW9FzufFOCFhylhQ==
X-Proofpoint-GUID: DCbEhtfzuJGd7wspfkOLLB3FbC-EaC9M
X-Proofpoint-ORIG-GUID: DCbEhtfzuJGd7wspfkOLLB3FbC-EaC9M
X-Authority-Analysis: v=2.4 cv=EP4LElZC c=1 sm=1 tr=0 ts=69277455 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RUpeJWWRx64e7F2V8Y0A:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260176

On Wed, Nov 26, 2025 at 10:31:30PM +0100, Anna Maniscalco wrote:
> Previously this register would become 0 after IFPC took place which
> broke all usages of counters.
> 
> Fixes: a6a0157cc68e ("drm/msm/a6xx: Enable IFPC on Adreno X1-85")
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
> Changes in v2:
> - Added Fixes tag

Cc: stable@vger.kernel.org

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> - Link to v1: https://lore.kernel.org/r/20251126-ifpc_counters-v1-1-f2d5e7048032@gmail.com
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 1 +
>  1 file changed, 1 insertion(+)
> 

-- 
With best wishes
Dmitry

