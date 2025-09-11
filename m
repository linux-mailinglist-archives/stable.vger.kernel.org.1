Return-Path: <stable+bounces-179239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A0B5290E
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE12580388
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B627281D;
	Thu, 11 Sep 2025 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntDBUzej"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21A26FDBD
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572602; cv=none; b=R2xknSDpnkSDPAVpKnlyuwlr24RcMVS3E9QuPPJiRoiY29veH4P9YSt1abwRYrS5sPq70OFQl3kNZ9kUCqtoTK+2xK49zohfY6W6X3H3DqVv5wdSGDCJ7nWKXAkSFOT48fChMeQw5kjUgmkmOdTF5YVcyS6dhhy6cWb3E41BRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572602; c=relaxed/simple;
	bh=3CtwootO+el+RrOJXyCia5V9rqAmA+AuWVwZzlzSH4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgxQ98z30T44P9bQNkBGjEEocQ+Ghwf4Dl5PhagOGEjXczY1E7cz9meK1gLcnE+wFRTun4bZI/j1sAEnE/VrY4LmhqiNeLmJKUKq8+Zi0XM2Ifp+97FIPD+J4O1zDH+cCdnT+DouFrKHdx7EQYZy427ZP8FZ1/g6Lt6tgpeRZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntDBUzej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4kC2r019094
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LDwAG0QNYm3
	TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=; b=ntDBUzejHlJ2XmULBN49Yg0/iAV
	tDqw8/f+eFEHDpEjp8OX033z1fsrIOeyduQS6CGswkWkuBJNQ1dqXcx4alhEHSOX
	85TMDmy9BnH0pe5y5f5kB8z5pSzgvKynSOtotsz/+NDKi3v+uYal05NSPwn6ORUx
	vpdnjsbVses99qJXb/ww9K4TKSWroF0+1exBHRMGuLw2RvRKUi/aom8xHBcPdNSQ
	l6/ntFgg7snVpVxwnl3x/gGFr39Jn+Lj9iNrp6adlUTLnXUYNennQn7P+d+dzHWd
	yXYYwbUsG35YLQSGgT5cruhcNdUCJ5pG5q4HJEhDTJbwoe7uUwzbQOvHwdA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493qphr8mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 06:36:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b521ae330b0so353559a12.2
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 23:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572596; x=1758177396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDwAG0QNYm3TJZCTHSe3Hq/KAWIgtpSzOrrjr5E3qM4=;
        b=pLwpdf0U3gtFlpyUogLrqETgINyVN+Uk93r8eYlwUzd6Aq2xAtGmhHSaHmTlZcoPum
         KbK7e3GoNDChM/fFZwKU+/mF07HlQItAE/loLqzBkzWr8qj15tPncAkyBYUNDxZjKYYO
         /GXZOTq4UQ7CKZN9sCoqcjpzoXmOrL/aNfeD0eZwqovLLpiwj9J2bQmi8sgllhDWTs+B
         CwQobahX4LIT2n1eUrBzZ26POdxsCN4PrQuoY7F2DeMYi8XH7fVaBZD4hAf0oDm6Dfda
         mFlEEHdjLYtnmsLerpD+Ii+kv6Ee5WEG2DEasfawPsl/dUeSd9NzI2Ui0pP5KGdxQLVm
         f2uw==
X-Forwarded-Encrypted: i=1; AJvYcCWh1E9d+RkbRk9ZcRrIfvK3EDJs4vMNavKMCX61mcRG+pQ9b/pc4IHYXxzWWL0VokKiiyLj2G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9ta27p47oSieoci4ukUppr7IPdZBIv8jQaDOregs36YBxDMJ
	PGEZVk87zwWuBe6mvvsC3twNR6SSaDYtzj82VDryu/Fo08izxh5sVc3DEloFq3x0BKcaYtxO5Ab
	FpRp+F9YWJ5ltocmZSpq/IWrEHRFjuZWBQ7XIQsq3IDVe/1FT8N7Bzbja1d8=
X-Gm-Gg: ASbGncvKF+dsNyNYu/BRQZCGfbpQw3PYTapR/PtZmWcenW8epEPBVET9qVWsEstkBYb
	MCJsnZEAVWMEt4CBmC4Rlummba0JmGei7a6zX2R0Ob1oxG6OCZ+5gUxikzx2b4mg16cEFsCTHgx
	04gpOWRHPrDaXiUNf9PGGkwgRpXT3cauFKerhEc2x9n4fi26bYzEZHG22iY//syBmgaR0pm3+d2
	NYbwRdPSZClToOpzn5wCQlYhU9GfpNZXGj/1IfKUoeJTQnbrWCOJ4o+HVysJlAzOXKESUyLh1Iu
	cMHwXihYCyTSJ6o7By+JAUxsX242nCwQtVwd7DVj7mAA4SSqFyMKfR+rdimk+BioIsMM5AgENtt
	f
X-Received: by 2002:a17:902:ea0a:b0:246:80ef:87fc with SMTP id d9443c01a7336-25174c1a958mr256279915ad.45.1757572596446;
        Wed, 10 Sep 2025 23:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcacMkV67nbieIIaWIuOTTD3vj8ct2khst5MgT+t512ruIpzEk5hxAb/P/xJMf3FaHrDwZdg==
X-Received: by 2002:a17:902:ea0a:b0:246:80ef:87fc with SMTP id d9443c01a7336-25174c1a958mr256279695ad.45.1757572595996;
        Wed, 10 Sep 2025 23:36:35 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84f72fsm7739125ad.72.2025.09.10.23.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:36:35 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [RESEND PATCH v4 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Thu, 11 Sep 2025 12:06:10 +0530
Message-Id: <20250911063612.2242184-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250911063612.2242184-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPDwqa9m c=1 sm=1 tr=0 ts=68c26df6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: j_sin-OnxaiOQ4WqzkJWW4LJSmBLv3PU
X-Proofpoint-ORIG-GUID: j_sin-OnxaiOQ4WqzkJWW4LJSmBLv3PU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA0MCBTYWx0ZWRfXzxmwyFfwgFG5
 iBnNHMf00y83tHlI6QBAzaVGKD9FShhxJvV8RsaONdwl9ksMlFC+gUvEbWbY8fJcTvCu+bzze0z
 Xxy1Zip7KMI/xpEbwOR3bF5S0ZdaK0vObsjtQcoKQZrB8wF4bwVcX/bgLSa6B7MxtEBYCJhf4I7
 sQNDWHLjI9PjukSUkSFwL4fFZGcIxk3Bg1s2x2kNqPYGwl5MrTUUfIE7Z1n/nUb+dv+vqYHHbqV
 cDO59dG2w3X57fau0IlMFmeV5g1Av8I4/58sRozQ5/moC3s9hV0TTtf4SiuLrl4O+JYWWb71heU
 GZOnpyI+HikMYshw5Aiw7D/zSf0fLJD4+iQ+YzrphwbxLzfpfuJ5pQxP4b9JkAbsTZpMrnYHFRk
 xjBCf3FT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110040

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


