Return-Path: <stable+bounces-178846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40237B483AA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 07:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE2218977C0
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3142264D9;
	Mon,  8 Sep 2025 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUG2nH/C"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0523315A
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309844; cv=none; b=q0EdJzRhOMa6/tOnc4J5CzJTQmhC5X9kKe0xR2oBtEby/9+/5eYMfPL+2TeFCMJwCKyzWY0yDz6cOExicDvukFkeZjD3vhJ/p/MWEp7ruoufsObkPGyJ6sp9U3Cm1vyPyNdxEub7/VHUnI+2ss8ork4f9N0fhAbxYD7fXuz3+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309844; c=relaxed/simple;
	bh=3CtwootO+el+RrOJXyCia5V9rqAmA+AuWVwZzlzSH4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhZrlm9BYQOlthKcXFyVoy2c8GlcKvy9hjG6XPv6c01bWceurVEXJ7NTNEz/17JLg2dm440FymE2jC3vkxnQaYLRvVH1KhBew5OMAI8+DBSMLT1QUbcc4pQsv7rpXzmwLSa/ijWDqxOBYObIh8f8WKEilp1g9lj/TXvWxigmgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUG2nH/C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LjLrU022845
	for <stable@vger.kernel.org>; Mon, 8 Sep 2025 05:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LDwAG0QNYm3
	TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=; b=cUG2nH/CXmCrTEOy2M53lSEGEyJ
	6s6rH9V9rLnvZPXzaX2u/aI/pBXwiCE70E0lb4x81vnwMGqxsmMW1x7e8Nkc2qWR
	ZQAxgyeiA2YxOQKK4gTG1fNAEmt6z8m89LYgyBhsRSXARozIq1Xeqc8r3WfLLqqK
	kGugwoiocLi/g5jPuTuwLsgCsaUiMEisldMAr4zll32wE0MOXjF3tftHpZtHPCXt
	I+5ETvHX4rlqOwjPIq62M3W5HIpvWTDrYIMF3aM3xT2ti1obnOXZbJgs1j6t8cQF
	9hBITDIPMt7lR+xIwK85ALi7eFu+1mbWG5z2gSLnRKlyfc/JcW7crNDG/dA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3dgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Sep 2025 05:37:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7725b4273acso8684234b3a.1
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 22:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309841; x=1757914641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDwAG0QNYm3TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=;
        b=YSwGp6yf1qvF1366xxWtlWFmXDa2Pu6RaQrnLY+J/wG4w3ljy973w1EyfUMxhl45Wi
         2vXPRJxv1zcDNSKyaUqNz7uz5aeYAsMvrYuqdsVLHRrHZIVlM/NxCzb7RilpXluxKfl9
         wGg2XAoR75vI+oWPm91tm8WJ86qOuqH78Pr8Kb+xIGg/1JgW36tponG16XRFj834tITV
         DMuGVmF+mNGVmayx4DIaRGF4FiM1lSTYFzUNSz6EN3qbjuI7bCpK72PKrRlaiNp554au
         ubPqFgedQ0ov1KmjwvbqSvwBuBJ0ySAROXHZoOCahRstgoF0ZnKLnxIpiuNArRhHsYDk
         QU6A==
X-Forwarded-Encrypted: i=1; AJvYcCVVXpGQSZtMgiLS0/gx3Np7pQ9JRPnEvc0UFqGwqS++4zR+IIsS8ocjjlzFGa1vCboI21/2wOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhBSybrdJf25JzUZrIFBkIzH3AtiSlmQ9xlT+f5q12jcSv6Xr
	8H1Xyq0GGjcXJd2zcBDJrbqMPsGusBv++5rkOi0bf5Xp6vY238Fkhw5jTwMe9zANtYC8/N+fUzq
	2DIUV2FVIKGt0EjdBUL+x/rrQXd21tcPoRPbQ0254VSFFHSJfVV17ugKMHjY=
X-Gm-Gg: ASbGnctYR4f9svYzQ/InSWYXXdNbWwbVa0CxgmyYsunUd2M3ZAEtB4vZO4DIYigtDoe
	AlsTcekJvdgv/HSwBGtv+Yys0i37mFlSf41Brw/4bmyBNNkt7aPoFDchSN/BiBVxNs1m9WiddvR
	6rHmWXuZAXggy+nJloSY9R+aMn2WEgwKOF8ksQDY0akpUnwTYyuQdeEzB01W7qgw8VFgBR/LXYF
	kWH8c/tC24Brc6jUb6zmEFsIGnNzm+6WQjj/dAYze0nQQIq/TNe9DsSU/Nyt1ZVQIuQhEOKuzUt
	2Eeri38BiIcIaxuHkCTukqEMLMXSWozUAoVPNgJeYrxV+2aQ2VzYm0ae2zeRJu6sB85eeLTFQif
	s
X-Received: by 2002:aa7:8882:0:b0:771:e179:343a with SMTP id d2e1a72fcca58-7742dea0275mr10773509b3a.17.1757309840830;
        Sun, 07 Sep 2025 22:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtn70IgXvQ4aGWZkJAzdfomHZs4vLGdZ2n6w4YrYjD5Z31iweF4zdq2ah09rQn9ZRQmSTSlA==
X-Received: by 2002:aa7:8882:0:b0:771:e179:343a with SMTP id d2e1a72fcca58-7742dea0275mr10773474b3a.17.1757309840408;
        Sun, 07 Sep 2025 22:37:20 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:20 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Mon,  8 Sep 2025 11:06:29 +0530
Message-Id: <20250908053631.70978-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfXxNBluVdPlUXP
 RLaFwRPScrdesN3g6tPxvWYqyGmqu7UjYROW+yU8O3MVHOjbPVtpgqv1vwuF3O//MQXJyunKgi5
 nCWy8i77g+czumh1ETICrZ/WZ8Aiye+UncWirxKyt6zwyGsnflK2zIdzPxrOJWk/1VHADXiiUue
 /HCf4zvQ5fFXObBl609ZTTA9Ay5kbPk/clmC3K9eXw5DWpKGdJaxT34g4/llBClUjC7K7L8F9Ff
 45A+wWjG+nhBKfQojoXz112s8XEoaWAHAi6AS6rFdX8pMH2mQm7TlClySTNgMJgWCibwllzYwB4
 EgVaUfkiz266CZarF3gm0r3IIzQHsnIMayqf8CQlvak7+e5iUyw5w2TxKrsoxEo4DkWUTfwMmYi
 jJJbwq/V
X-Proofpoint-ORIG-GUID: ArJTKN_AxIgh-IS0oiTuDNXXX0Np3nqo
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be6b92 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ArJTKN_AxIgh-IS0oiTuDNXXX0Np3nqo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index bbfd51db8797..be21d5f6af8a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -995,6 +995,7 @@ static int audioreach_i2s_set_media_format(struct q6apm_graph *graph,
 	param_data->param_id = PARAM_ID_I2S_INTF_CFG;
 	param_data->param_size = ic_sz - APM_MODULE_PARAM_DATA_SIZE;
 
+	intf_cfg->cfg.lpaif_type = module->hw_interface_type;
 	intf_cfg->cfg.intf_idx = module->hw_interface_idx;
 	intf_cfg->cfg.sd_line_idx = module->sd_line_idx;
 
-- 
2.34.1


