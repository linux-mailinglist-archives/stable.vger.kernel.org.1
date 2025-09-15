Return-Path: <stable+bounces-179592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C851B56D2E
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 02:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4A23BA3C7
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE412C181;
	Mon, 15 Sep 2025 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K3LJOp5j"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E451B7F4
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895113; cv=none; b=t4nLlllV0Tfz5t850AyelGdHEHjZ9SQH8jIM/RUE6JCyt2W3BXsoHtm8pH3aTEn5BcDRZHKkjqiG9dDcPGe8UlbdCzMHiI7b9obH2BbSX39zpXOTUMadTpfV/OhMkNh2e5jKt3kBL7QsCRplmGGozv5NEmdpB+Hnkngf5bybrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895113; c=relaxed/simple;
	bh=iSoyahLZuzvJW/LLpw2WRZ8dNqvwIYHpD2wjF+DRt5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFJ3tb9Vh7WCff2vFCsy8dCMkbjvhvNE3tSlleANxevmbGUFsS5b7vK98EFEzw960Ha08MZ5IfXzRUAubQZQ1WvnDYNZgjH7/eYkTUUgrl+Ngfy9L/g6zRAB40WWpIBEJ5NpB8+xSBmGuiqxrojqQbdZAOVgW/P5HUuk1WMwErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K3LJOp5j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EKwxKS025449
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 00:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jgubuXIBHxl1EspmzGxmpMOu
	9GhsFOhOkdvbf4oIGsk=; b=K3LJOp5jN8EpntH0qMi19Cg/3wIT314oQaaADRAy
	rABW2HFKk9jWNvs6cuIoPd1HXB70rcUC2QIZrD/csiva7OdE14at9QD4/EoV8i3O
	K9x4thQTv4L+8L6RY8Y2wdrSDl2VCOIz9N8zVttL+Uw49aedXmhAjS921FBTK/3J
	zy+pqE4koEApxj71kUnSOw4dbq4xz+kBKbcr+AAjbtt2lkYAqI6/oaK9aNh1h4cx
	eJJTyF/Dnqn48hipTflX8HfAdbklVoNlTLFwzI+hLoZl4/ZQI0X81qNohoEPyuKl
	BdSSi0JKEibRuzhtBjiQvl/idmFg21vUP1XQXiThFrvBbg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072jx98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 00:11:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5fb61d80dso105750881cf.0
        for <stable@vger.kernel.org>; Sun, 14 Sep 2025 17:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757895110; x=1758499910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgubuXIBHxl1EspmzGxmpMOu9GhsFOhOkdvbf4oIGsk=;
        b=OUMhFO/nbNxQW8c0fl6kzNxhTU+KfWrGBXwBFWkLQ/JSiRA2mVDPMG3P5i1AG6NNNF
         Wds6TMB7yKkFpWd1Nh6Z02zca82v3605+iM2eqdU1gnby06fSfJjtVXBW16tAV8+t+V9
         xSWhitFw40Lx3h1zMBsvxU6wozZVbmhmMRiy9GLx4W37hop4rACcn8j3mf/JlPP89KKS
         l0ZMXgIb7aHPjRSusgOuRDTTES2nTiISUb4mLatcJet/59PD28LMGoBdRfAfFpBeW8a5
         LTLcbABLr5Vcv5dgzWC9JmX2X4ivWRXw1aJq07P+5aSLV/LOdXV2Ez2Y5MiDJZkj9G+N
         0uSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuf6gV1so2KXABvETOiiSF0wCmwZEJ76hmRzCdr5XUOF3kylbsJdk+eBzoWVBRH55YlhruvJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAYLzV3/Ks7WiEUfWrnDfkFggRwhQ3hvy7htJhadosp0Y62rY
	i2ShQSXIZG1zv++MOyuKbKYtiKl3VpkjbDRUbrY5nxNsOglxJCVGa5GYbet6JNqpmLqoxfEA9HK
	nvbdpHa4cMJGBb6Jn14s4jQnwcGc8Nn/15mDh408HJFbvXDKJHiESIObbLtE=
X-Gm-Gg: ASbGnctM+uSHIcDNhNsGg6xEydQX5BkrzQbIc/258eLa9EA0TGbcr5/lk+eJ/Dp4y8n
	dei3KcZxhOQg9GXN7cxzpT6a+pB+cJXRWXmKyWfl/vKnAa8CHlmeQmM4c/ivc9yxr2Eb0kPIaPL
	TT9hAHeYqMvM8GFWVZm0U+JMbueKB/RNMPhFYCKb55uSIR/setHgWTKRfmKRvEWWalHghh1g/LW
	LxHy04OhAuaoEafzhM23H4plKjvbDoVWijeUPHCw+Oq5eXJSx1ZErVhnFMfeMoHERxFKT5Mle0z
	pi2zxoYSx75fGeFDR0wW+hMBI7zNfehsj1sha0vv6IGODk99u8gOFYnplNwL9FKSwD5uO+v3Tbk
	NMeKhiVWsVwA3Iiwo9qxUl5evJevgLNeV9QuiXkXhKkt14RWjCZ+n
X-Received: by 2002:a05:622a:1dc5:b0:4b3:ce3:9615 with SMTP id d75a77b69052e-4b77d0e734emr103191861cf.80.1757895110212;
        Sun, 14 Sep 2025 17:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr8fMcGTWpoT3vdfr5rMRLD+sgOyLchYdmKd5WBs6kKIgs17duY0sHaa7iwCY30pATrgGWFg==
X-Received: by 2002:a05:622a:1dc5:b0:4b3:ce3:9615 with SMTP id d75a77b69052e-4b77d0e734emr103191611cf.80.1757895109746;
        Sun, 14 Sep 2025 17:11:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b622fsm3227252e87.2.2025.09.14.17.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:11:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:11:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: qcom: sc8280xp: Fix sound card driver name
 match data for QCS8275
Message-ID: <ocevx3x6rniczf2sjhd2yie5i7obhwrohim44sqiev2cdngivc@lapwpkqbq6o2>
References: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX868ySirAFOsJ
 GZchA41wPCFYr54ODXeecsVqauuwBWv/+9Yju+uFEWDXBdhAJdJxp6inTnq2ZZfLrfoD1cvhcYT
 aakRWOeVm49qPb3zZyi9o9aHcDIK4Mn8BCaQbbZvxQpi6sB/j6HcVennxFWKfVkS57Q3fQ0eqqT
 2Al1oAYjCwh0Z6Of4RimZZhwNaWhQGwnWG1kWZvE+aTyY8t/tE3hzX6lCWm+nJy45w2iNI+qwNi
 v83cu3ooXwM8UsKnwuV+45vggZ+CtCyUIsR/dME4RCEHWcJ8Te6P1qb7voCN1Ba+YeZqnv8aTNH
 46itetdfygQ2vlqZFsoH2bjjMKdDhKuWAs1W68Sibnw521cpfLEcNMzd276GGpVOIqkQaUXPQzV
 Uz5RBSpV
X-Proofpoint-GUID: 6-UydSgTTTpoq4JDH7-l7nd-NJGfX0fq
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c759c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=b8Ncz4iFJ-U_pff5yioA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 6-UydSgTTTpoq4JDH7-l7nd-NJGfX0fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On Sun, Sep 14, 2025 at 06:45:49PM +0530, Mohammad Rafi Shaik wrote:
> The QCS8275 board is based on Qualcomm's QCS8300 SoC family, and all
> supported firmware files are located in the qcs8300 directory. The
> sound topology and ALSA UCM configuration files have also been migrated
> from the qcs8275 directory to the actual SoC qcs8300 directory in
> linux-firmware. With the current setup, the sound topology fails
> to load, resulting in sound card registration failure.
> 
> This patch updates the driver match data to use the correct driver name
> qcs8300 for the qcs8275-sndcard, ensuring that the sound card driver
> correctly loads the sound topology and ALSA UCM configuration files
> from the qcs8300 directory.
> 
> Fixes: 34d340d48e595 ("ASoC: qcom: sc8280xp: Add support for QCS8275")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

