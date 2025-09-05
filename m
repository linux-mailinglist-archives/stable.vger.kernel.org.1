Return-Path: <stable+bounces-177831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE98B45BC7
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68077BCEE1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC04D31B822;
	Fri,  5 Sep 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8bMpnTz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216230214E
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084743; cv=none; b=RX0+Y6kmDB+EoYs3WPPFm55xlb8Tji7/h28CmatlGtjptVE2mivSPXviHp0q/38/Xawk+0oCi7fvrIaDcsjGF0ybKHb6/0JHSclyDYCqxhqq/N8FQVeWG3wgkwDTaU/6o22tVYwTfP8w2WzAQnskV5RyVbFAxHmsl5hag9EDXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084743; c=relaxed/simple;
	bh=wW7dIF9hg5FlDqjmM6YX0iZNQQw1lXp/0P0KvOe/ibA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3/mtD7PsA0KnxBU01PNGb7p9QKfUtEcawEQkQ1pmUW4Fw1mtaY5TpGkvb/EnEIMzdIsVBYWQIVTgpYqRNMMNP2UhwngmlQhk8RnK285Da3cDs8XRTrHhVN1NwgdAB6QC4HwfoLR4uesKMnijCqWkQEk6zR1aELaHLorz8WUtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8bMpnTz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856iIM7022151
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 15:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rams1MK76xG
	xbvTN1cUvij9c/QYVcgdlDejUrDnGUzQ=; b=M8bMpnTzdQb6zjIt7wcxk5/qLLj
	k0VtqjhsZGPc/Odh6vsdX7lViuVGNxVMun3TZdW/mgr2Fj2Dukp9TjCrtCMzLgkz
	eOaP1A5F973wcLwBoa8J6ukLxHn5+RvdbkV1k37xWBQAqDWHfopMnVfbDzCCLNpX
	jjbnZKL9kGN3Bl4O3Ed6YMEV+0TcOXCr52Q7vBKAxZViJ6U7g4xjIMkU+PXNSKkJ
	xHCXFxe6Zxkk0i7zFhIj8Yx2nC4qazzv8bMnFYYY+3EGF/aZ/oOVOkfRXuxU0i+J
	4raDyAP41fa/7JtHxJXdqNuXXv3xWKO6E93QN9gcDHRMt0S1yLSgGidYs3Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9bbqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 05 Sep 2025 15:05:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445805d386so26834495ad.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 08:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084741; x=1757689541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rams1MK76xGxbvTN1cUvij9c/QYVcgdlDejUrDnGUzQ=;
        b=c6RUTzHLg26gBOWdCG26IyLyw7KNldnr7FfuTQkFBZhuVV54wU3V6TufpLuwO+azCM
         B76ApXXDmpFaQRa+pPwgsfDgsf46X7ht/OKCuAfOeM1fa8M3cWvsNVgKtdBjge3GqL/j
         SE4dpR+te+UUQUgN8TYgDUj6AZ1KCKe8gNJ9dcwBeNPJ2A6EH9j7w9BB51+zUz3ioUzF
         L4ERwWLiSuK7l5hUn432zcLeDM09xCX6EfqB+SaszQ5VCLo4Z8By2JW8l9bwQEYNEdVL
         IxlI030dfpWT8UBTpswBmqEW+/GFI30UYSuqXAfCJVI+Pn1MntxgBnQoYwkrmp3lwMoK
         7lVw==
X-Forwarded-Encrypted: i=1; AJvYcCWBila9OPLAmFTXIKNiQncXEDCJT0z5jY+sHVx2yrXFqqf4mQdhX+QsQz7yvJzuOOCDEG0DH2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZkDOUO7/cIKd6xzmt8RzS3yeFrGPtC34v6sOtjxMwqSPHYl5
	7VLchULyOZzSjSEx9wew0l/a5R6UQLzpC0/pqYd77LvlrAZP2R6odWDcGfLqqlJAI6XB61nyZx4
	bdX4sF6sivOynYK9tXozRB7bOoB8dLzz0EKHOEraNEl5e66YbFB+HLnTYmEo=
X-Gm-Gg: ASbGncvu6RDRMytHGwtjAjQLbzg8Dt/9B9cOgNgikradL640vYq4bg3XRCQO5Jg2PpM
	mdHTQUf0uB3JWqTws2TkF1i2s2D1nf19pTNl1qXVU+B1C6JbFIfB8kcHg7086hESDku7OhYNM/1
	gynPW0BAvI1oY/R/6xjp3j+LqBvYIPyFUgRrMkPxf0vJulUziE6w79v0URbi/VxbzF9vHcuJnvU
	q+e+QM9zcE4gcLpkiinJC/gbJ1S3TyW4dbGHoyaB1EWkEeyKFTusPJZy2SAUOHgu+QIRCLipGyE
	08okVhQN7D5X2wsgvTmobqgHgOQh0NlsE5L53yS4dEdH7KX2D5HTt5PiBBIE3fKCfORlN+4Hmd9
	W
X-Received: by 2002:a17:90b:5310:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-32ba2b9b3b7mr6442929a91.13.1757084740541;
        Fri, 05 Sep 2025 08:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx5KPPwVlb9iZR8T9g1aFHZ/PhPD4GNA1cvU17UqhbW9am2w2sCrWdN4XEZM5Yy+9fYcUdSw==
X-Received: by 2002:a17:90b:5310:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-32ba2b9b3b7mr6442858a91.13.1757084739852;
        Fri, 05 Sep 2025 08:05:39 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:39 -0700 (PDT)
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
Subject: [PATCH v3 3/3] ASoC: qcom: sc8280xp: Fix DAI format setting for MI2S interfaces
Date: Fri,  5 Sep 2025 20:34:45 +0530
Message-Id: <20250905150445.2596140-4-mohammad.rafi.shaik@oss.qualcomm.com>
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
X-Proofpoint-GUID: 5JN15W9YdBOz_6vaQlr8PmzJusXmuRHa
X-Proofpoint-ORIG-GUID: 5JN15W9YdBOz_6vaQlr8PmzJusXmuRHa
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68bafc45 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tfJ7er6LdcoPz7dJv_wA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX7kMZasgyEpwv
 MNg8ck1JI0Uf6Mwgb3rBa4qIlc7ub3vDkixBuqBt5mIvvmbhKMsm5wOJ2S0YoOGcIsRLUgcJCLC
 K4pQzItm4rvf1X+Yf7yrPolgjEYV1kdw86W7EHFIV7aMeuAsTSf60XqBvFb/JpEmZadlbAHHlW9
 G1NOqmv1xJGs/3cE7Cbj4sC1BRXEoOY4XcR+CyjjwDTaXq+inlAGaiIku7FI8n6BTjVLYFopAsl
 a7U9SXlNibJsKIo2VN7we5ky+xez8JpOMC+lWhfHbbl16HrMs3RVhhfbNwdJbMEc0FyKu1Y6wLb
 rXHkcbT90kR/Ym15duOdYIh8goGbsSpWkmBHyD2rxcejZcinDYZkWwWKtctekQ3jSk+uEQBQl6+
 P8I3HJwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

The current implementation does not configure the CPU DAI format for
MI2S interfaces, resulting in -EIO errors during audio playback and
capture. This prevents the correct clock from being enabled for the
MI2S interface. Configure the required DAI format to enable proper
clock settings. Tested on Lemans evk platform.

Fixes: 295aeea6646ad ("ASoC: qcom: add machine driver for sc8280xp")
Cc: <stable@vger.kernel.org>
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


