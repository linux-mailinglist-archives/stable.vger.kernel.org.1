Return-Path: <stable+bounces-185817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C342BDEB51
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9949D19C472E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C851EC01B;
	Wed, 15 Oct 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX0EQMAt"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796E1EEA5D
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534292; cv=none; b=ECqMYIqLoidjp3q8ZzRwf7dT22SkqQjgov9iSsyJKG1tvPPebZnBLDHx2PND9aWyk5nLhziTbZZpgZ0869VB7D9DFzRocg9jmFUw99BmdjEUWJMTb7Oe+kOqFwF5gj+7Vcpt2i+bjy7K1dy870py0de17Azbp+BxW5R2APiXrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534292; c=relaxed/simple;
	bh=HfYmjuwrOg7v2qvvURtfwZZNDS6Z63hBaD8sZwee7fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhq6dHxFItEVd6o8gcp57339rF5vKJZnu6jEVTD0mYId7072Yq+ywsGqBS5uIEbp993k+VukoE/pkDS8hsE8S4R+KhpSrB+pv/D9y7cPT5BCF97AN5wjbJOTwqusoRoZZXp65chxdqFssJdQQsLNsdlydGDWQxZ4sNfPC/H6Ts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WX0EQMAt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAc20T024859
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ocdibrsg4QK
	6oNvgystrIsFuQNDpepXOkPernNyibCM=; b=WX0EQMAtstiub/cyNMRVC4ElcP5
	B66aQcPojC3LngkU1/COz1+/Dv/QF0ojC/00YhNnMiS8EknscHQf4j6MO136PawD
	8LKK2R6PqfBiADK4ghBUGcPouLrvSUXS44IzDi6h23beg1TIolAQxdPsW5LxQptj
	ayeHrXCTGNAz9nmNGa6eOngLyY0/MCaHT7/lPY8RCg1JLRNYQje7x+Qo6MXCOJ2Q
	B4ThcuiRwaCKPu1Ob7UROSEjLeqIAW5jQgNgqVEQOv+jDYfIWedsiaR2JyUJkjZb
	8taVvBj5aLtfTJVS6QzP5JDousnpoKp18aNKk6OoqKm5EWHh6l9xvZDR58A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0vfyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78efb3e2738so293484406d6.3
        for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534289; x=1761139089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocdibrsg4QK6oNvgystrIsFuQNDpepXOkPernNyibCM=;
        b=N8MX4Np3yv4yHUCizzpF8TtFj9S52RmMmJViq8Fu1/JN5oor2Ut07aADwBuGyfwct7
         b5T9vrMV1nHvdLR2IvdWZWKjrbHazF84A0ZTmsSv2+v5K77RX/ejaSlam+a+il+nHsCY
         V2VTD73VYMezqdgS8LA0HqNq2z7R3Co37SVRpwxxueCZR5RcDN9D4Nv2IZs58n5tiiew
         i0xg9RKxYpDGyFLnDQ+FuOBkQol89iykZHIoJ2xlzh5wenLrd26JGHNscfho0UBLX+Yi
         IIRMPr7upHBRE6OFDpJ8p0LOI6fRmprmzlOD79pcNu79oCf0mRBQN7mVWJeVf7lFn/D2
         z9uw==
X-Forwarded-Encrypted: i=1; AJvYcCXloImPMAfgcBtJq7uSYL/hyGnyBT6ynfO1m2/ZU9cJWlOKBcEf7rXM4fRC+gjuMmw0n5bVzQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMTEJg9YHZN00yc1i9TNqWqst+PvqvV81P1B8mZ6O2Tk/J+Bd
	8LAW5//4nCL2xE3ND5RSy/FUeDCdAkhEiSiCYz8moJigjln7cugQ3SIug8MXNNYhHlQB6Ev3czF
	Tdre43q84awTWqkkmGaonHQTPsk1frMc+vyLXwQQJcckMhLUGgA4RTd3d2hC3RVJIJrM=
X-Gm-Gg: ASbGncteQN9dYHKtrHdHagFNdr3g1QsydbvrmCS16RpWTVIBk3ZfkbYzkq6M6JooKuN
	bKrLSzA0sVc2UJadQPniNNRZrAmfnwYrk8CP0gBFUNSPfZ6x7jL3xHnRSQUtk0y8x8I1OJrnqTU
	GI9ciiS+LSo/2MjhKSEmMmrl0waDQZDLC1NKeAZ4n8H3YnXs3+4ySUCrzjlsdVlQ7penXDHbHfw
	wH5qrOgfMoJtJ8y2XIptQa3stZg2NEJWITyfQCwBH2mg0S2IwSRuCXHLrslEKna0NrQjsKNZ9SP
	OlIGo4yOUOSx+B1Y8Sl6BjBj191xy9d2zgrd6p3Sk0swMGCT7hwALQ==
X-Received: by 2002:a05:622a:1116:b0:4e7:2644:f3cd with SMTP id d75a77b69052e-4e72644f434mr135028081cf.70.1760534288487;
        Wed, 15 Oct 2025 06:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzw5RKXMUAYsikIggquflBgezust1UvJBHDF7SI2jiFbC8VMnSSIP38h2hOOqJ/sUiesXeqQ==
X-Received: by 2002:a05:622a:1116:b0:4e7:2644:f3cd with SMTP id d75a77b69052e-4e72644f434mr135027391cf.70.1760534287838;
        Wed, 15 Oct 2025 06:18:07 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:07 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 1/9] ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
Date: Wed, 15 Oct 2025 14:17:31 +0100
Message-ID: <20251015131740.340258-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8lAcUW+gxL3k
 IcLO4O1ih5fnWtwE822XgAxpUBkfQ6J/6pQg69fzA64gEbW1UR+vvOo+ooWTouEV3sH4/ZryyOr
 kQ4EQ6QVrdp12ltCYaCbqrkJ5dS1iubFXR9dgeXBC+6YRno68Jkz2UXUCylZrEYr2lrHPRRr0aB
 V9aW8aOv4RNmfZ5gWI4n8eFf65WM8ekLkSGbmZZ9Yqs+ByyPjmQCrYGxiFr72pRdts8rStbMeCZ
 nispOibxYSS9k4MbHPpwwqB5+5uu58+3n4VP3kgQW9xNRaworlggHXzT7OAKilnkBqUK2DXa0u5
 VRnGKNoOLSHStGHDQXIINFKuCkg2vTBIB55Nn4Hpg==
X-Proofpoint-GUID: KFbRkzUfawNAUxbTl1DEdWmOBe6mOm6_
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ef9f12 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-7q2M0jigxX2LbQM1jMA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: KFbRkzUfawNAUxbTl1DEdWmOBe6mOm6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Driver does not expect the appl_ptr to move backward and requires
explict sync. Make sure that the userspace does not do appl_ptr rewinds
by specifying the correct flags in pcm_info.

Without this patch, the result could be a forever loop as current logic assumes
that appl_ptr can only move forward.

Fixes: 3d4a4411aa8b ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 4ecaff45c518..786ab3222515 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -86,6 +86,7 @@ static const struct snd_pcm_hardware q6apm_dai_hardware_capture = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_48000,
@@ -105,6 +106,7 @@ static const struct snd_pcm_hardware q6apm_dai_hardware_playback = {
 	.info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				 SNDRV_PCM_INFO_NO_REWINDS | SNDRV_PCM_INFO_SYNC_APPLPTR |
 				 SNDRV_PCM_INFO_BATCH),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE),
 	.rates =                SNDRV_PCM_RATE_8000_192000,
-- 
2.51.0


