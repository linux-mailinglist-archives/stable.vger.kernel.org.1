Return-Path: <stable+bounces-208234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 513B7D16DBE
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24FAC30191AA
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913B735971B;
	Tue, 13 Jan 2026 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irtCW/hu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvOr760f"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE803559C5
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286187; cv=none; b=nTZE2014nIMqy/h3fnLfx+bQBpCoaDeXCaRH8drfOcptfhYUgOyYMBAasxri7X3foV25TqOwRmJizMIkHtT7hkIGUkq7LAPLQvuv6xK3LVSswQkwd/ybwedcZJEyTJE0/OBw/Z8CWLSVINP73urrHoDS2KCAngndDtsw6B5Kqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286187; c=relaxed/simple;
	bh=bxHALflVqoB1ke0ZLKgbUhpZmhKx+Z+I3wDzBftzmbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx7XCgsvc3mtEy3BEUzfmxAoD0BWYY3bs/bie7RB8Z2XG52yUdqhFrijfbKljr1rSMLgeVx6FWDfKUJq/U0yzNmdoCik697astgB3KRudOQ3ZQsldABD3+0ZEKLTSJ3mbD9wSSE3H0+Jix6ylOBESwj4QsaEVVSXIahxT59IClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irtCW/hu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvOr760f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D5hKYB3817041
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B6Onfh0ZeWVdoiG4WKvPT0Vn
	n91OfwpSgrb+ahgty5k=; b=irtCW/hu7TKE2RYyrPnV7zA8aYC+ggQ/rosFGwTc
	GItQEDVOVJxenGv5bZ0AZ46Iy43KQI577fYwqKNEq0nYCe6u3gwy/Q2U3qYPz/Pm
	ltqHglXxeYgrLLw+N00Pk8VLat+m91ZIq/AO8eoZP/tcrdgzvhnFEsk662tWPZPz
	w32ebC1MXCvSgmnJjkn05JenQHmuKvl9IT6qjTRFtUctBVfhmO16Cq5TKL1dZvAG
	OAzZPwNamYoWxEtBphezV860OU9jHzdBHb7qr1SH02O/nbcYSg9A1EV4179AcB5t
	PmRSgUVWSLN7mhtF1PpIzx19CRl6XZebOcLF0HhimiONNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng55r5b1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:36:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f26fc6476so108207355ad.1
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 22:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768286184; x=1768890984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6Onfh0ZeWVdoiG4WKvPT0Vnn91OfwpSgrb+ahgty5k=;
        b=kvOr760fUgny2xLqjw2pnp/MLXsz0+67AYtoYUmgFUDHCTjYbOmUZE3m8ThIC5nyat
         eYD4GrXcowAXF8TzCUMk60FBl8mgdWZrfTYLUaGy5iWt3LPEqYjL+id+ABWM4fNDBTaI
         jzpcSKKyuzfvJmkk8owEp8QIZH59JwU8SuIotnC9185EMXmIr0bfr5e/HYTZKvio7b2x
         ZcIFwMK08DhUrjaBgw9fhyMDBjoCN52Pgl6LJw7gERitGkMSndGQBoRhSOIEYGoUKBkw
         qYIPKN1qIljZHrgQzwrVNX6MuV8/lqYclBt8AEOH6+T8lQ0xtL0EjNnu5imzUjoxnyUu
         IC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768286184; x=1768890984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6Onfh0ZeWVdoiG4WKvPT0Vnn91OfwpSgrb+ahgty5k=;
        b=s4OVmQfEhlgf7kaClMdAeytzH0OD5yXZclzbY66VSyJaC+Sf17ZsXLpx3BttEJtlnl
         O7b1RlPs9FZ5sAyByRrR/Fx4a8AplnXKqVmsZNuFohW7MugVvSsV2mRGuLPJ8ua/NlNF
         RxFrVFDqn+ZQPfvSn9ciHeD1RvKrDqT+1zW1XpLZcT5Pshaptv8iDeztWLk7otWobLBq
         MBZiLK90Rwig8ECofvyUGEOzZjAia/eCaC5Q/LCSur/f10b9tOW5yt1WkwpLAnyVwoBa
         N8beXLalrZxmKBXyTh73G1CWoqK/0Kcd4PsHkOdVmbDiZ6CH0IZ1cIefQG4F1g1B/6I7
         CqLA==
X-Forwarded-Encrypted: i=1; AJvYcCWGYkAV2q+cn/4fQ2UBJyjzm6uOXXcemy2K2nn54PQ83WMxcoFuB8GaGiJECwHEmtufhD4IObE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/iEEv2xhVKA9A/qkWR7kBKFlQ/9nO5XqPAmEmH0SUIfPaVs0C
	MMAXhkMw8WhgE75xLxSR1A9pTdNO/coSmgXCk9SkYCUGRypdkKyWfcOOsGdNXOvxj39skbyrA0x
	jP1hn1YaYURNvIn9RTcqmAMhtrd32vL3mCH664xGRZ2MaV//FW4CaAUB05NU=
X-Gm-Gg: AY/fxX5dYetU8LzBkaMP/IjPNHZNHy1WAXU5FirIN6JPbuNfSxMIlq0m5YqvuYiVenB
	cZAeXv0Spne5YgsVo/Wr9oT+TN18cZHMxD4DA+b43xDUOwzrdDsTi2+OixtWoh0pnFiNLx0srrw
	H5K6f8Kn+tJiLfQ9EFNoG7ecwX4LhJZKHQ/Jft/9/lkwcGFbypRYPmmSbOV+yst/Bi4kCK4qXXV
	5nALMmltP9cJoAcLQfzd8/81C3bEgyp6NAEwrHxspQFD9w8Ju5h4+SkIZkru+vVXQyY4HGs+v90
	7UD4Sec6UKFvNMD9o/ZnmTkTHqWNUu6cJ3UJugGGS74ZIMFClOf0F68SemWcT5xp5XQK0ba68Cr
	woOXvItDaUsHHxpf9Kb5uxAg0cQomqLOI1H1R
X-Received: by 2002:a17:902:e552:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2a3ee4b2440mr174486095ad.50.1768286184396;
        Mon, 12 Jan 2026 22:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHItfZsPFTEbLZbowJWgLdd3ZlvBosWUoMGGxVHDC9dbDCVCbwmem8tj+6GFFBOLnBlw37b4A==
X-Received: by 2002:a17:902:e552:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2a3ee4b2440mr174485895ad.50.1768286183850;
        Mon, 12 Jan 2026 22:36:23 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a4f1sm186646175ad.8.2026.01.12.22.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:36:23 -0800 (PST)
Date: Tue, 13 Jan 2026 12:06:18 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Xingjing Deng <micro6947@gmail.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Xingjing Deng <xjdeng@buaa.edu.cn>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: check qcom_scm_assign_mem() return in
 rpmsg_probe
Message-ID: <20260113063618.e2ke47gy3hnfi67e@hu-mojha-hyd.qualcomm.com>
References: <20260113023839.4037104-1-xjdeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113023839.4037104-1-xjdeng@buaa.edu.cn>
X-Proofpoint-GUID: E1H9W3GWuhJ571razdSuf0-rmr2KJUN1
X-Proofpoint-ORIG-GUID: E1H9W3GWuhJ571razdSuf0-rmr2KJUN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MyBTYWx0ZWRfX3BE2m07o1qeh
 +dBMXsARavAj1RftAnYyuJWooRViu/bF68T3E+CBWewJt0OJ1VgEj3lAL7sFwDcm1IaZzDnUNLY
 Hm40Ktd2/I0ZZlnoL/W5VRgfyan92/3QjloEiy0+hUjLbwCmnewTJHruAAVEKfcumLnPVRlwtgY
 fUTh7Xm9GMieiib+rYoZHgXh3dQ9ggEzm4i+cNOrqQmv0d9ujLigi1j5yWGmXDYHnCgIplalPma
 UE+9482TUIlVt9WZgjXnM7xLPzoVqHceA2si+flzqabR5soRaboV6OAd0HiN/XiJ5GUTTa0pY9p
 XOGZASVUg7sKmh2m6T38Ifh8KDHrgx2rDUh0U6g6SivE577q0Z1LA+j0xZwTKi7JNDdTznUgq9X
 1P2r4Bm9Vr2SCFPvHnJwiyA2vjpvT7s8RLMZyzuj8zrvNjj4yW2m5Sk0PmyexJaPPHCznoTjFwP
 ypvCzlWUmNKiI51oRoA==
X-Authority-Analysis: v=2.4 cv=IIsPywvG c=1 sm=1 tr=0 ts=6965e7e9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=CfPS7sswJGtPsZrNj_8A:9
 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130053

On Tue, Jan 13, 2026 at 10:38:39AM +0800, Xingjing Deng wrote:
> In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
> reserved memory to the configured VMIDs, but its return value was not
> checked.
> 
> Fail the probe if the SCM call fails to avoid continuing with an
> unexpected/incorrect memory permission configuration
> 
> Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access to the DSP")
> Cc: stable@vger.kernel.org # 6.11-rc1
> Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>

I don't see the lkml mailing list as part of this patch.. please use
./scripts/get_maintainer.pl to collect all the necessary mailing list
and maintainers to be cc'd.

> 
> v2 changes:
> Add Fixes: and Cc: stable@vger.kernel.org.

Changelog should go below ---. Also include the link to the v1 in it.

> ---
>  drivers/misc/fastrpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index fb3b54e05928..cbb12db110b3 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2338,8 +2338,13 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		if (!err) {
>  			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>  
> -			qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
> +			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
>  				    data->vmperms, data->vmcount);
> +			if (err) {
> +				dev_err(rdev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
> +					res.start, resource_size(&res), err);
> +				goto err_free_data;
> +			}
>  		}
>  
>  	}
> -- 
> 2.25.1
> 

-- 
-Mukesh Ojha

