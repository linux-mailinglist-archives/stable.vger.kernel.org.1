Return-Path: <stable+bounces-189087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41FC00741
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B274A19C43CC
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22B30AD1C;
	Thu, 23 Oct 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b4Ujkerf"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86532FD1B5
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215160; cv=none; b=k6/Imk5lqPWD+bQYQnj04k51oCrLQYspisNeig8Kk6zA2dX3wfx8adncd5Zr4xpXmRzG4dU7IUnmcW8soMc8RY94Z/kByKRn2iKzUQ9rkr4xrxA6LfDwe+4BTZi79FOTm0wxrBLpuuDMXeJEylAcCKtoMsKjsMxtulQ2RsnTYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215160; c=relaxed/simple;
	bh=fKU+7psoGKhGov9+abzdK9VeiEyjPMI2pGqzhT736sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/Prjyy2RoBCJEc1YiLih4pu36PFTFQJTkczoIVRYkgY+ford5IFSnvJ0NM1s8M0CSkbzGIjS/VsIIJNAjNRJPoBTbIxygJjPxFtXNZEUPf2V51OZdJhfveARYOCn8+qHouhtufO78wVVdhlziz6R9GDIoZDP5qNKZqo28RyXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b4Ujkerf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7Gdh3025827
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HoHmVwgfwgY
	ctL/x1k53Df3AjUPsgAlOxk1+AKZybp0=; b=b4Ujkerf3On4nYtoUk7dWUASpse
	yPsTwgbNGnrJnQ02X9yZicsJahmXpEmnZ92+btcP+7Q1xU0MnviixhFsttF1M9wU
	TS8O2UMWtZLOPdD0qXAfTOL8URC+oijTNvwUU132PDIXHH7VRxuauYNJF2/ezJ2N
	FBoSta3SRwhqaM8PuDT2nM3ND1QNnys/Q9J416yu5TITF7bONhsl6P1RFjAFtkqr
	CMwLOMWf5kLdhnG2IByI77GmffT3aY4v1Z9rdfRfp5bjpKWDLc0AR7M1SIvz0p5n
	Q1kFRoA1B6V3We8OMuNAP4PL6SUtxV2BOVm9rSd5tomTmMFv34usgQbciGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kfu12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:25:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a4c63182so17538551cf.3
        for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 03:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215156; x=1761819956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoHmVwgfwgYctL/x1k53Df3AjUPsgAlOxk1+AKZybp0=;
        b=mXDbQAt8DDSm54YjgwRq8hldnK4+B4umS2NqA35PmhxklrFZw0CWdGKmeC1566yWJp
         Mx+lKdSl24836hjQ7twGvL2ns59ccj4xTCQ25ZM/hJFIp8JQXEs4fFCb9mTrQzPt+sLt
         94S98LFxSVkutiipyoBQGf1TzSPEPi35LNjzpYlul8l/Fft071fCN5WFX0gXfb9TdBuD
         dwqDmzSKOw6lAWM/AasreX4Iaz64NDhmQT5n4JZPZxQ6EbFdtZPtId0QK1Qerp+vx/UZ
         1wbl3b6zfGg0FipzagYmPBDmaa2IURfsw/xNKjcp7CeWEdwci3gg+nmT9EhHcDgclFib
         v1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUb9iSyFoTfw0SmmwF5RhawMO3fCxNHDArpzsynl1XiHBQc2yml+E6Zt+q72c4FgzezIdebzwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbuye72qhTD3F46IOQsY8yeMNg9ZXxa3RimaoD/y89CG1rseYb
	hXU0IdBR6nXKs/CcdPZlUh5dwc6EVgqFp8QnT4sPB6VuQYp3M2apNjmvGlUFnQ2WXa+ArElVD2f
	zSVpXiW3MblTqSYuBD6dBmRCeLw7S2ao+lGBhaAX1mJ5xSf39/1DGGxEL/9exD8leNQI=
X-Gm-Gg: ASbGncsmCT5/s2g8ZG7F2NBQHj36V80/dIBgMvHYGb14z0TZDZdGsq8oKUCqJAHHNG6
	yTvjXCLBbAHxt7G1JWZ418+UkFe/rraWqvpT1r803Mf+8w2mDEG+CqZDhb+1OYObnNoY5wfoz4k
	d74apU7funr6CtkdtxtL6KyknQoTiAcHCzOKwRkvmUXNGkq0To+IIAtzxPdTR0i6fhApVBKcW+C
	YR4o/GrXxliKb7+ipqaWCh71+cmpL3aBhezrXOrXI8BA0Qc7ir8GH8/ZseZJDE9dEJhb8Mxd6Lq
	CQ4qfAv6N32FATbzo9mhYH4S6IyLp3oFyaibn9OGiC4uCykr3R/RpByUkkSP5xgcMASgURf1+OB
	GPNE2reBtx7M4
X-Received: by 2002:a05:622a:13d3:b0:4e8:a2aa:77c9 with SMTP id d75a77b69052e-4eb81020e0bmr20467351cf.1.1761215155860;
        Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4pmDb7EjDueb6982IesIBCCpfc2JJhwDrIZYFugXpp3Mkd6MdhDM2CIiRAZN+L5enEZqEDw==
X-Received: by 2002:a05:622a:13d3:b0:4e8:a2aa:77c9 with SMTP id d75a77b69052e-4eb81020e0bmr20467131cf.1.1761215155423;
        Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 01/20] ASoC: qcom: q6apm-dai: set flags to reflect correct operation of appl_ptr
Date: Thu, 23 Oct 2025 11:24:25 +0100
Message-ID: <20251023102444.88158-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y7sgNFdPE_dKKu2ZRSvsnPo5pgjCYuoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX6j74XiemvHqz
 8koMLESCkG7+486nk8/XeUJXVCSi7DjICpuRZfILTVpPXf3Rdwlwl7tTFh1lsM41xY0jjD7XHvH
 LHgmhjOmWvhrsGuylsWrUMCaoWry599olnVAV1qMWiQTRI1fMzE878jqKmVyT1QnqvDhT5RsjPK
 6nb8327QwlgsvNhZy+vcHPKd0Kdc7qhW4/kdwNjHtH8R0CzYgsN7yz9rljnxrM9QuU1GgO+DdRE
 ALXHFQzKoDLbaW1nBUant9v1PuKxlhZS/bGNnfnyDytUaCC515MSFA7N/zYYHEWc8WNQnYllf6W
 K0ciLfDwec7dXyLZa3chFPh/vo3GdJjEWvmN8B7nddwuO/kS+xYt7w+SjLNyWVLTNgGApmlIkeS
 QbZ1Xe1XeUYCLjmec2rkuULEYK6dlw==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68fa02b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=-7q2M0jigxX2LbQM1jMA:9 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Y7sgNFdPE_dKKu2ZRSvsnPo5pgjCYuoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

Driver does not expect the appl_ptr to move backward and requires
explict sync. Make sure that the userspace does not do appl_ptr rewinds
by specifying the correct flags in pcm_info.

Without this patch, the result could be a forever loop as current logic assumes
that appl_ptr can only move forward.

Fixes: 3d4a4411aa8b ("ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
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


