Return-Path: <stable+bounces-178848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE5CB483B0
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 07:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08012189C38E
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5738223A9AD;
	Mon,  8 Sep 2025 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJgTUo3G"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213923956E
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309853; cv=none; b=f1CBy3UEeB91ccrze1Kr7XiXEPXM4GnJhjRfMFk0v52IjeQpGZ1cMvnJ00Fe7XFInCrt1M1x2Jjjo5QZ85klqvlFRk9716I7s5AD1GrnmiZJKQ7aC3F2nB7nF+YPB2cGSw6tZxHHys4b0gsI3v4oJvD0RvYHEc/PXdWAUzhMzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309853; c=relaxed/simple;
	bh=z+gGsuW1nP7yJtlnfXfDq453MF7xeDeN/7Bqp1rigus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seV2La6ys0XTsCFM5Qp8XmNmUGXuka2scYIbFc/hqg26kV7v7i5d13G7S2hQm6Wdb08yNquEMOdvs61i1FojL1wX8Vp5Jo0ZmTpaFZfQPARQQlTc2bOPPRXbeMiGIkTPD0kk/M/r5oNCuXmQHEVoxecMg6YS6zKA5MSKK13A8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kJgTUo3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883lLdS013469
	for <stable@vger.kernel.org>; Mon, 8 Sep 2025 05:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q4ORjV3h/Ug
	G8t1QXMHoEv//ijDc+HhKRFWyrdBcOJg=; b=kJgTUo3GtKfTXy3jwEQpjWCBS+V
	RG3m1bVfT8HIcEfzzGhPjML2UL8WuWhcbtmNtCnsnPcIDtN5pl8NkkCvtooPUD4m
	CNnpzlKWn4gOccAyr7Qpot2nru//y1hwWw2BAhsriDKqnDLYql+NHPpcRfynXAEj
	yqzbewruE/3KszbIqSTCuUxn5EIZzb6mm4J6awhOR1dDHiOguCXDGgFQTUMsm87w
	q5CbolB0KbzHNjx/UWs7CpP1om6zYzbTeZ8TPhCjNYbueXtsgTXyjklSOAByB9LX
	7LYyFHVtjryYgibdyhehuhh4uX2Ux4n1nqo6BXNshXf2BXlyFeLTl9SsaTw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdr6bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Sep 2025 05:37:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4c46fbb997so3886042a12.0
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 22:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309849; x=1757914649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4ORjV3h/UgG8t1QXMHoEv//ijDc+HhKRFWyrdBcOJg=;
        b=cSH2cUJ1a99Gyo2n5fX84zirlwVsYZC2V/Ikk4yoUJtjtZs1uRvBaFimpEj+PMEG4M
         FmaO1ObAql/89BiaWoCOj5WTtUD4RqJPs+npVdBxXCyGceUxjDnwKGKdQY/cTsWwqsmA
         Mx+q9u3AlGEGNNdImQDI8u6BnJA4JZMK8sq0nXF2FAlC1mAQ8Dxzqdb4PaMl7Hs7kgCa
         Xhl4wj7XIYfBcVtrUcntLJllKyLH45AR8Kr6JQt782Kf6zfLQICFhfjHkGsqro5m3TLG
         KjJD3aXwyWdLQ0yNiQ85CYOhux2dPtScmVuKopqM4EFdxEHhC9uDo73RchGlBUscu/u2
         6OTA==
X-Forwarded-Encrypted: i=1; AJvYcCU/enkuF8M8pUy+3TrakKO1tgbkV0eF+2uDyghCOPfbzRzj6MqjrsKctM9Xn3rrELmz/vHtroo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUoGWEt1SO04M/Iq7Slynp2lBCJD5cV533Ei5IU1Go77wag2C
	BOmqj8OpBcy1eMyna4I/iOrMZxP58Reezp4SkPQvnCuOKJ/DkdYqKrSI0GwXagKfdpF1TWgNJGj
	ALksmJMFkuRXaPLLD1U9BchVGp3u4Ujnh/JxyH0njF5fVyP+1Pw898eYUld0=
X-Gm-Gg: ASbGnctIBz/PPc90IC5Sg+P5SNjLr+v9CxY/HhR6qdnPbQe2KhYLTN+b7oaatSqohUt
	CnFCJSFWdZ5hTbj8iWvxEOhkr8ff1Qdnsns2AhPsZTOyCP936BkaQIFbYHc6lYRH5zPAalLrGeb
	A8JDkqg7bgCSM3fJ95uuhveOVVKk6GQ9E3n61g3qkkII/mirskH82+MR+aJCInhl/rzaKGvt7HQ
	nXxSl15BbArcbsCLE8/zEG8VQrNR+p+kqEFSJB/3NbDActRK2Mwe7qRkdgO2jyE8+g6Def4L184
	VimsL3xmhgMmQ+9NO+LxpR05ztkfNquWyowlqZ/um7NRbaoGZug3hUyWJLaywxWr2Jl6HmUb5Df
	Q
X-Received: by 2002:a05:6a20:7d9e:b0:24e:2cb:673b with SMTP id adf61e73a8af0-2537e066fcemr7667952637.26.1757309849242;
        Sun, 07 Sep 2025 22:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUB3fffQc0dYIvBmhNho3Grz0OULGZkqOb9HQi9BruK+kfs7gs6X1rClEeQVcaz0XcgWbw6g==
X-Received: by 2002:a05:6a20:7d9e:b0:24e:2cb:673b with SMTP id adf61e73a8af0-2537e066fcemr7667929637.26.1757309848724;
        Sun, 07 Sep 2025 22:37:28 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:28 -0700 (PDT)
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
Subject: [PATCH v4 3/3] ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S interfaces
Date: Mon,  8 Sep 2025 11:06:31 +0530
Message-Id: <20250908053631.70978-4-mohammad.rafi.shaik@oss.qualcomm.com>
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
X-Proofpoint-GUID: bRXSuVKT_pOcCvgKcvWAoogMjeJhgevP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX5xf2Vg6D71D3
 +kAfw9EU7J65/e+/zE+ietceymxRmZVBcuaD/Yulgp3MlBvArvrrNLJW/zNM+cN0M597wb+oESa
 BgNg6niY83IxlkAYwiDYFoaV1djdRbpNlSOe2PTPgnz2OZ05WcyH4tCwi1TjK8CNpUwgCcC/iew
 2qPkizxY6pIDOX9fazGrzIVFLon/nzIMPEDR6MkqhniRin5907Hj2oOGPlBYlEBVvpGN3ECm37q
 s1FPS+eWMsC3A/aozDU3UQaSLRbtRJ/a6AYG3mPEGrUN4kUjg+24OyjPhyiDoiI4HfD465y4gc6
 6zuAfqWU+pOsqkn9zmvjrd98Rpxd/kbZwaut5hOQOMIfHG8ir5SPiZ78EQy3iHJF5eh1EaBr5yE
 Cg9fakMK
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68be6b9a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wtrncf1qwap5WzB382UA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: bRXSuVKT_pOcCvgKcvWAoogMjeJhgevP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

Add support for configuring the DAI format on MI2S interfaces,
this enhancement allows setting the appropriate bit clock and
frame clock polarity, ensuring correct audio data transmission
over MI2S.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..3067b95bcdbb 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	int dp_pcm_id = 0;
 
 	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
+		break;
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-- 
2.34.1


