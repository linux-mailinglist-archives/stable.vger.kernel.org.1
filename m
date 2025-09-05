Return-Path: <stable+bounces-177829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C12B45BBC
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F067BCBF9
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269B302150;
	Fri,  5 Sep 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7TAX/B8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928231B81F
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084737; cv=none; b=DeXg3J9niRR+S/oEMImkynvW34N8ks5RevwSzwDKFZh4EFUYB6mBabzQGwa3AF22GlA/aSvRl2jTZhvEZHdD5KFv9BY67tfql0MEC0rLz3qcyPoQAtTDUcR2PB/AODoCCyyXHrAmTtWXlZpQ+T+FpWNmG/feodLjM66K+zXp0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084737; c=relaxed/simple;
	bh=u65y2jSDRLaSgr2s4XMiseR1rskbbKzZS6Ts4b/elFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpyF0Ifvz7uuACAMbEgAOFvN6GBIh9p8CCk/DjekJoQCa9e3JqsICWskL5vYvYLH0K5+UsCOqn/aXe2fAwF+m1tVVJDPVaXRWc1J6vWA1dXuT5SZLDVo2IUcAbL+P7qpVrAtWr/l+iH2Be3ZyWZt4Ka2qTQnmTpVatPvqmFyHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7TAX/B8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857ED4E007551
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 15:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ln4QrHvRmvl
	Sj7VRoWV0fWCKQ+IjhQYN87ftM4Mr5ZQ=; b=f7TAX/B8rTXwsoc1S9Z/ygzk6Bs
	+XUSbGPFp6Ni3ax/u21rOusfDLgn66DM4elHq9EZj39wNzHzsudKmy/qLIFvfB8U
	5GpBbJuh/paJS9E2wE+G88FvdIY85UjwOIZFfx82oY1L8mmanN0f2Ok0BKvpnsPw
	eU8KtKKdIorvHZTc3m2ZkREnHcWJsQcbMOQTmY2HhJVGIY68Aw6FWdHbzg2GXRYZ
	WAk94UNBIlneT4dYQq8nNJJS3mZt3H1tsy1qSXhOCXw3xtoHl5bu/LtJAroBhaYD
	9SyW7h00x3vXtiUrF02ORanA2AycAEArrcMl3e7U/FeaY1M5xeFztDZNdOw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura93cgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 05 Sep 2025 15:05:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32b51b26802so1962132a91.2
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 08:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084732; x=1757689532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln4QrHvRmvlSj7VRoWV0fWCKQ+IjhQYN87ftM4Mr5ZQ=;
        b=lNo4N2Xtlqj4UtAiNmJduFlGRIZqcfoecfIDCBRO1BJGVma5PBhpsrEOHli72htfIA
         3yMnbrywExwmPynJcsfl6cHTlPQZWJLrv/ubXPwAZ4Qw9xBCy2PVQNE1ZjlQbBjhImMy
         QxF9pZFDOKXFSXHskJoPu4m3OgJAc7Uxb2zpqk1cbLbMYvf32X2xGwl5+pTgwyzfNwqg
         1p6NbAzobuE6cZKgw5q7hoCDRKKUKeeiyxUayFZ62CtGRRGWWvC6Fd5GqXcCshPjhqI/
         naVDA2tRi7YUTtlooz/X86Rv5lWd9hgQdN2srcviX177oO0erc07ZA6kXiEXkQ+TXiBQ
         zTTw==
X-Forwarded-Encrypted: i=1; AJvYcCXhauqDPofft0QJ8v+sxXAIu5IlHfD79kDVM5cAD+D9fO0g46Cq6lyGe0KvEH9slACdzEAQQsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFUnMt2lkfJjwowtdtmZpLFh6TTM8ICW9AREJDozLfYHo7S6f
	w2ZJZ0kaWu9TYrfMZktJihsaDOYglE7I1WGIwVhNBwbARoW66f/0dFYiCP81FESvRc1DcL7csl6
	xFDy3bj1Ykk418VQi51MpznGgbuhJQE741pRowld6yPTfGdSt6yfY/S1Huhg=
X-Gm-Gg: ASbGncsCf97bREkSTzfe8jvscGHOow1+55WHJaffxLDpT7vHwQ2itJvwN0K/GAWMNFZ
	ASjQQOS/trPk0RwcWwj/wGKOroqAe2jdVh8hKluLEBeS6W19v/kKYZbwx0kJX9ncz/fx7Ty0GTo
	n0kMS+pdBCqmNBj8+X1RxfVuyWeJHD8lf5Azt6bSbQ3RY7kbTNHaTMnWdcct1cyqAw1yX+kVi7e
	T9G/yi3Dgzmw/Bh4Frq/dwzlz83G6ijke6LFGGkkSp3m6o26vM0WrMoJk2XV5v3VlL2kd7/Q580
	f/BgKovaazlpk3RenwCtHfBW2r7XRO3m2IEoJPjM5f3Cb51GtP/NMLMnpnN3uvptabYtyQRSR88
	8
X-Received: by 2002:a17:90a:d40c:b0:32b:e42d:649f with SMTP id 98e67ed59e1d1-32be42d656emr1455916a91.4.1757084732331;
        Fri, 05 Sep 2025 08:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDmM3rGXxEcUOcvGJH9jngE6DgxXhxZQFlWg53KST+M+4unP4or4/YJLIttQc0R5ta/Pf+0Q==
X-Received: by 2002:a17:90a:d40c:b0:32b:e42d:649f with SMTP id 98e67ed59e1d1-32be42d656emr1455857a91.4.1757084731777;
        Fri, 05 Sep 2025 08:05:31 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:31 -0700 (PDT)
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
Subject: [PATCH v3 1/3] ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S interface
Date: Fri,  5 Sep 2025 20:34:43 +0530
Message-Id: <20250905150445.2596140-2-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GLXzsnzzCNvbULVGpwvCb5M5x5s1v9qX
X-Proofpoint-GUID: GLXzsnzzCNvbULVGpwvCb5M5x5s1v9qX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX3ktgPJCcDhhx
 8Kfsp9Lr1G80lgrW+Wyx+TvjLPiGDKjJC8awee2Ucp+yzod42/cfdK8AosBapPxICWn1a+mUfky
 /+31usdOLapgcWfko+qBC0I5IfulvIM3vPJTX45skjM4Y3npcLq1es2daOCijA/7O0bEJ3tjP5c
 GXsavRjwyyHT1UyqaHlaPNAZU8eH/vWiSv5IPx//pRLB8EdJ4R0jrJRxdjLsEGIBEWIQT2TnWM4
 q+HSOYizeJq53MXV64Syyv2c6XLo1ilDBzTCTwgoCodYHMuy7Cmobg5o96ixwKswQUgKTCHnhO6
 6et4uAkDmA5ULdVQP290ZHrIFOJ0KaK5bcZ9KQhvvWpnpvRIaMW9Usv43vBjazLlpkDtYsYyOhL
 11F52Uhj
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bafc3d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Fix missing lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface.

Fixes: 25ab80db6b133 ("ASoC: qdsp6: audioreach: add module configuration command helpers")
Cc: <stable@vger.kernel.org>
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


