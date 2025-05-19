Return-Path: <stable+bounces-144767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A77ABBBD6
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B69F1882336
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE422749C4;
	Mon, 19 May 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h4FeyJbI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3620102B
	for <stable@vger.kernel.org>; Mon, 19 May 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652422; cv=none; b=W87+JHJrA9UUBH+gK3iUGC394r5eC17Q+/AZPGdlkWZriCf1XPunEUyHmlfVSM3FckceG7/rzloJiNqrumxG6WRtTh+jGzjiMISUTILfLu80KNKZBwwWIWyh8DETc7ZREvD/6gYy8JHTT3Vle5LkeLgocigsuOScg6VDJVPwK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652422; c=relaxed/simple;
	bh=fFmjqnxgeSmiyzEOPvUC2pZYL/wVtsRdLROklYyM+Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1kTI341+Po+cMQWtwY8kiWrTg/EyimZsuzXEXgumLzIiAuCa5SbmGDLYZwA7Pn0sMv4mb/F5gglP+N2O0rRiYdnSWedU5by0vEbKeD+yvbwGlqGBuA68vAk6Hn7JR9Bu7QIoAuKCb2jsnCQ7RVdmPkE3+39pPpolndJHZdnEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h4FeyJbI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J9j3vr023240
	for <stable@vger.kernel.org>; Mon, 19 May 2025 11:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AR3Ehus8X3xdnq+Qo57YslQ+
	CRLb/Q5bFilFIz2nOhE=; b=h4FeyJbIQExSvfT7G+6p82PPzQbsTO68g4UGOPX+
	Y2/tcD9XHkpP8WKTnJAEsmrC6niddSILbxN5ENl6HC20Kaa5peeX7zFh8wLY/WcT
	0Jl8SxYV+0jFcOG6YmgygBxLGm5AzKHP3iHfUrKV+vYjk1+hdaDuYjqNfhc+lycC
	aiq/g41myBF9oZAeeOW0r+LhIvymBtFRajUgRGRQnpNuuL1bomkzP7BaMR1+he4h
	LvM6C/8umJarqhJ/uXhUryv7wGVb9pdOTAua1AEW0bcMsBX6dsSeHHFAC/t/xezC
	EiMJ5uZPAxLslyOiOOZ8yVfn44WxV8bARPFwnQlyJStqVA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r29d06wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 May 2025 11:00:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f0e2d30ab4so76688006d6.1
        for <stable@vger.kernel.org>; Mon, 19 May 2025 04:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747652419; x=1748257219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR3Ehus8X3xdnq+Qo57YslQ+CRLb/Q5bFilFIz2nOhE=;
        b=UBU62wst2trsxQJ/mipuqhXAtC2sM4G8lFdGcMalA7UBsFhU/2n38aM9mB5Aphsqc9
         jha0HmU/ALmghXhVOwBiKdwuwmmY3UzEgNASAVNHXoSykDMU2sOnsa6l2Fa340RQq+Co
         WGFK9MaI1di27O667dQVomdFD0uu4OsggWXxdS2fB5nWklIJ6903hiTe02AHxqav+C4j
         rsf1Gm6N5DWs+LzPbMs+h5oDbZdcjYxUra0hbLHq8mRnNvCYVwlTDlvKLd9/iEnghQOT
         Y3PtGlyYFrPhenk7+OsVdkQYFo23JSoQaYD7wWCdDstMXJRzih89RwmYQR5NyS/MyDWl
         Dz9g==
X-Forwarded-Encrypted: i=1; AJvYcCVb1FK9i0lpb29r4NaHKGtDMaP3GSnwy+m+Nnp2hSbED9SDn9G5Mk6rMUJb1jzf+1F+2T3Enmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWYKf1alcCrzoBf3bC2cmJYDG+2ExO9GWN8BI3XT7V3Hw2b5/
	jYg7/PFLTrjdJq+/QFrw3+x5rygWlVMZE/tMS8RY9kwxf178LdlfYd4jTmMRaSNGTFuI67PI/jI
	V27OGbK8S6XVMWUuv7IvubMfNWrZegzdWDKo0ww1bsaILjxO6BuHPuupZUzQ=
X-Gm-Gg: ASbGnct9USZseOhpUwWQSssdNUGoGMmngjj+2XX+17g+7HQ0YwOfS/4f4qEPK90srM9
	gJLaiE7TbHcI9p19c5jAWvyGND/UoA+nzox0dKXnqbpt3Yz2AlG4t7QvtlDfosXiJctyqJdRqQP
	+E1BGm1qhB2nfl8bSTljRmc6Hzv77xDHQOTXxFK/9NPLXCi9um6otGjbimffTccOd25HigdAWNB
	jRcAYf+zorp6vCHbwfD7lzLD9IW6BKw1MrsIpWDqapX3grfEuEB9uHXmNx2JMV5FqRO11GScX94
	jcTodnYQ6MQxzVWjM+2R89rdPs7wIPmfcA3YKRlMypT8qlU5y/xB6hSuOIQ07MmMfaSsU0As0Ug
	=
X-Received: by 2002:a05:6214:cc2:b0:6f8:a6fe:24ed with SMTP id 6a1803df08f44-6f8b082861fmr194274016d6.10.1747652418000;
        Mon, 19 May 2025 04:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKLoOs77LAAd2FaVlz7S0E17UdAYw+X90/56bpj496u2rqnN6gHMaHcHAnyDBiwJmiqq2D2g==
X-Received: by 2002:a05:6214:cc2:b0:6f8:a6fe:24ed with SMTP id 6a1803df08f44-6f8b082861fmr194269906d6.10.1747652415358;
        Mon, 19 May 2025 04:00:15 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703e7b1sm1779835e87.229.2025.05.19.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 04:00:14 -0700 (PDT)
Date: Mon, 19 May 2025 14:00:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: srinivas.kandagatla@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: sdm845: Add error handling in
 sdm845_slim_snd_hw_params()
Message-ID: <e5k5zslz33in53ivbqttnnkt7whvzfay4uwxmi2o3m2a6c6ahg@5kpjzcyov35h>
References: <20250519075739.1458-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519075739.1458-1-vulab@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEwNCBTYWx0ZWRfX6EaW0AlXbJFA
 ljSVR8KyNpBXkM7dZm30tPC3QHx+Jwm9QdPypPomasVfVmBPWmz7Zl7wQmYFc6eZqhLcyyjJUN8
 j7UOg383O1FtwoqgjEV705bPd16wjIHQk++F0eytydXjZ5TyIsLeFNVzeU9cxX9Ia2KP2yNvm6M
 vGbFHLTwjZJGsj7aN1fv8/HnWkkPq03r15hngegL+4B3OcNXkixx9xQyfda+f2HAjAMVAbzEq+U
 Lf2enW1uHYaVLV7MU42moigiCW+yz+hTvmK6PfcAnXeVC03xJJCpn5HV/TdhPKCPeXRqvFe/0oA
 3pFP+7RvzjU4Q4kIMCWjoTGEau3DUkErX1fYA8zoVjOF1TA3A5bGnUZfF8hKXTPvPQasMk7vEBK
 k/+YDwrsHtcJRsS77As7d3O70HJ3ASy3hFkcbkd6x7gSTgUaKnI+VRqnnEkxABKUrxxS9OpL
X-Proofpoint-GUID: irQWCMpRRKmrxuLLIJH259mqYrJNSaU1
X-Authority-Analysis: v=2.4 cv=KLdaDEFo c=1 sm=1 tr=0 ts=682b0f44 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fLaHX3QtLFUqQw0t1l4A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: irQWCMpRRKmrxuLLIJH259mqYrJNSaU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=672 mlxscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190104

On Mon, May 19, 2025 at 03:57:39PM +0800, Wentao Liang wrote:
> The function sdm845_slim_snd_hw_params() calls the functuion
> snd_soc_dai_set_channel_map() but does not check its return
> value. A proper implementation can be found in msm_snd_hw_params().
> 
> Add error handling for snd_soc_dai_set_channel_map(). If the
> function fails and it is not a unsupported error, return the
> error code immediately.
> 
> Fixes: 5caf64c633a3 ("ASoC: qcom: sdm845: add support to DB845c and Lenovo Yoga")
> Cc: stable@vger.kernel.org # v5.6
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  sound/soc/qcom/sdm845.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

