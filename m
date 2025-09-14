Return-Path: <stable+bounces-179572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221A3B5692A
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCA3A6868
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CE1EEA31;
	Sun, 14 Sep 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PX3oYHsu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14223257422
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855778; cv=none; b=fflkwAJhYwdJBKIKIKWagjLLu5w8rjPoJywoZM3WNlGFtH6E/rodo2i0pqCNancJ5gPMmShE6hewFR4C/s5dmseUfI4aa5jaAaAyg4L+9LpUg7z+ra8V+AI7h/OkpousA89s/jLSeXZGMJxM4YEPvD7THM/D0Gt5eeIpkvSWwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855778; c=relaxed/simple;
	bh=ASTRe5VOEhSFShtU7AUd8KiTkDSRQRHKvy7Cf4rPWBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nIxPV2sqEEdKaWtO0EoiUZ8AfjISedrFZkp0NAwhV4m0clPjXbvx4puvmzTxwhWtoC0n8ZX+xSqiU6nPL7MIYEDjto4iTUHo14RvM+XEcQuPp5/ZfA9KebILDhbOkw2jsK37E7LD1y/Ri1M5C4fueUdvjlAzQuPNkqywdjNCMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PX3oYHsu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58E9U2CR022430
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 13:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cFsUhwbH3X0sd7hf9crCeGPj7gKsS7ptnZR
	waiXgaJw=; b=PX3oYHsu8T4Z6xb2oqG3grWhQA4zLO3eQsKhLHqogZoHw5RWlT4
	KI/zzo2H2Y/Tk7uZzv8lOiB2LutOJtU1MMXT0qQL5RmPPwa37zyVbCGPxRtFPJGT
	kBqv8fXlaUPKluNVTQl4bWRUs7A9d3zI0WoAtTlZw1GZy4zR5tsJliT0LEMxaZIw
	d8y0V5VyzbS3kSQk8jl4It+PywezVjrXyU5Wceyb47YYSp5nOKovHG6B8dnx60Tf
	FlKo8YNBA/xUEk/jkKTrLComVq9SV2rFj8cPsvu+nUCTNF+iptPXszMeWSy+ai4l
	43YJ5uTRBYrtW0h3cRMT9rTYOdS7NcWFjPA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv2bmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 13:16:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ca417fb41so32456135ad.1
        for <stable@vger.kernel.org>; Sun, 14 Sep 2025 06:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855775; x=1758460575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFsUhwbH3X0sd7hf9crCeGPj7gKsS7ptnZRwaiXgaJw=;
        b=XQaa5F6XVOALjpFDtEuSNPGW8ajVmrtQWdZ8JDhasM/tv7qvWL69stjYTinmzmEeqN
         5/i8HLIlKZlmwPcvoiiIHPgJXW/QF9E0iHJfRwwVMdDXtlFRuPs3elalwEmxKaHtEzUn
         ftziGfkJ9CxJEXbsnz7I5BWDP7Q6sl92MCkj3AZpOitM0tVsRXrsesSlmzdI+uPmMfMS
         G3CfvDqGqCz6Odvkt0l0yLTJ4iKfg/hfrTsMy6kXSIWYoRJs0e6zcJodWeflLMIa7VoC
         /EJn+Yjdbro98ZIFMiizzSfvtiSyNxegzMcb7YGVxvubCGZNOp8A9DxdzJNMZ7Cn2pyz
         FsNg==
X-Forwarded-Encrypted: i=1; AJvYcCXErZTJpDGsBY2jrEOKBV4L86Ej0UhySYSWCLCtkaJG5pE0AT5xAQZK37tAPFHp/xCuj9tSeqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8EPPQKknzrp3KgiklVkOCw7Gd7+b5Wnm14nbym1yXb29+PAD
	NyFulNQSKp7HqPhibW7xQ81Je/29aDHr6x/OGqp1TY2XRaoTtUZqciPZNbhFTrTLmPMv2duOOKE
	s+TRuBwaIifYz04suzvaoc/5jzx82nUZLrr2dLGoyFXaqL2tMU9Dl9axZlRqUdaBTssY=
X-Gm-Gg: ASbGncs7C7Qv1gdli1DUzNPW/gjJIUw3y+G1Jzy/SujbiTL6PuBjHYyn2e4a+/iZxOU
	Q2gr9swBnDbYQMTkEghESQh2t/n0uowxwdlbm2wZUrlTcBLM6V6eo5TFGE2T02belbZd6TrNnL5
	KdLDhqHdC4/2jOrmP2k78AG3+nW7KA59lc6d8q/XbEWeWrYSsFo//EBuhWiychOA17U0Mb68O9T
	jqN8NuDfQVDroFEmkN7z+gTLKcF1swJXsdH0/pZEAiDyR/BVDCPO4BpXoFLBIv8RRmYioTwUaHD
	XIR9ixD2i2fijOiXAnz/CO+fF4QTRrBYCpc2UjxcwbJwi97ivXI5ER1iBeiIUqxkURSY0WLKE0s
	L
X-Received: by 2002:a17:902:d4c6:b0:25c:4902:7c0 with SMTP id d9443c01a7336-25d23d1bb3bmr118454005ad.3.1757855775133;
        Sun, 14 Sep 2025 06:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJuy1SPEO/XjEKKhYEvmFIgN+JNIp7NY0Hu7kXU50Dz/94OCkRLrYzCtcat0KvAIgfcL9GgA==
X-Received: by 2002:a17:902:d4c6:b0:25c:4902:7c0 with SMTP id d9443c01a7336-25d23d1bb3bmr118453725ad.3.1757855774712;
        Sun, 14 Sep 2025 06:16:14 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad33ff0sm97871205ad.115.2025.09.14.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:16:14 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com, ajay.nandam@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH v1] ASoC: qcom: sc8280xp: Fix sound card driver name match data for QCS8275
Date: Sun, 14 Sep 2025 18:45:49 +0530
Message-Id: <20250914131549.1198740-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c6c020 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=687F3S6WDAOtLpWcfGQA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: mog88Bx3yQ5-QMh04zd7jpdPhnp0RUqv
X-Proofpoint-GUID: mog88Bx3yQ5-QMh04zd7jpdPhnp0RUqv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfX/aSzqqECaPen
 yUZRMsqM5Vrfv86ZKCp4X3o/aNnGlgKKBEGCdBH/cl6jjxsPpdVa88T1PPeXOPdq9VhlibSMxpr
 4caejl1HpL8cvJQ4pZKa1l0gBw0pUa9NSTypedjBPZB04Ev6aV+ksLTOMIxm+r0qIvrrfGaoXoC
 sXYJOQK7ucoVEyVW+vdDSK9otv5tz7EeBAJO0zcCp16xGcFWsWpcabhApiYpyUygGhmFB+2vCeE
 YUOwGOsJ4ew9GW/LwE34vV0UrElukmy+YRphJkMJcnLwVsDFgE038VaZE01grXK58wl7dCvGbIX
 LLvY4J5RAHAc2fcI55QZ5/o916b537Jgzv5p0qoe8BHKYCcwX7Qma+tIKOsZZMffVKdP/JPPA/X
 4faK/iba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017

The QCS8275 board is based on Qualcomm's QCS8300 SoC family, and all
supported firmware files are located in the qcs8300 directory. The
sound topology and ALSA UCM configuration files have also been migrated
from the qcs8275 directory to the actual SoC qcs8300 directory in
linux-firmware. With the current setup, the sound topology fails
to load, resulting in sound card registration failure.

This patch updates the driver match data to use the correct driver name
qcs8300 for the qcs8275-sndcard, ensuring that the sound card driver
correctly loads the sound topology and ALSA UCM configuration files
from the qcs8300 directory.

Fixes: 34d340d48e595 ("ASoC: qcom: sc8280xp: Add support for QCS8275")
Cc: stable@vger.kernel.org
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..db48168b7d3f 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -186,7 +186,7 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
 	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
-	{.compatible = "qcom,qcs8275-sndcard", "qcs8275"},
+	{.compatible = "qcom,qcs8275-sndcard", "qcs8300"},
 	{.compatible = "qcom,qcs9075-sndcard", "qcs9075"},
 	{.compatible = "qcom,qcs9100-sndcard", "qcs9100"},
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
-- 
2.34.1


