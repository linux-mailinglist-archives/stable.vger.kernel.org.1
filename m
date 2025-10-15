Return-Path: <stable+bounces-185819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC6BDEB8D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18EA8505D17
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A69221FC7;
	Wed, 15 Oct 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVA/PdEc"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B91EEA5D
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534294; cv=none; b=OSQMbMNk3P+5r3xyIIdMCa7PD4+x9qHhbRXmmJ04Bsi77HdWCzn+6lgPG5n39tDQSZKiTSvM/2HhwMGK3nXBzyPJmLYn8dqMCUjkJBEMndrL4NcemPbo+uSQ4yMinSCqx19OgONfTMSEBijipqeNWsiHXKQL19aSuhr8zRGATxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534294; c=relaxed/simple;
	bh=L098FDafS8pm9ObOLw9+1ZKs3tCLohX1/Ibu253xq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDv7vxoaJcDGd4S/ujt3CXouclFILWbF5Z7rKZzO858w27+jc17mzpALRx9/iqbsIEhkw2EaodIb3XC7FVNd8YMVkvgxAdS/aYzjIOU4RdrE7yNx9bYqgXTbX2jO6L53PBWtCz8cLwyetkiuMM6kcyFxA68c/SuXGgpFvU+gejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lVA/PdEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAV2G6004288
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nnMgSGQvZWa
	892OSdBf3qcySVN9QLFS9/sViBiMJgyA=; b=lVA/PdEcyNkWadMnx9OhqO4b34k
	jBIKkQ0EmtxqrF02yhgh0lchJncIrev97kamcBArfQlzTTSTa7DyglY4McI+hL9r
	AHRBKdOTnIrGEdMB9q3vznQtJsH/NJmlx3bBfvyrsFu8RV3Wv/6dGZBnN2QbI6ql
	Fsmd6ZNaA3Rt2IRrJn3eqam5CZ/vaad/vQDlurKHBU7KzgYwl+M36qaq04Ek9ZQM
	742QX6cBjfAdtAmAYCDC2dTAr4zwH/Tl7bAk2/Q9ibmlBnTFNWO3GoRHIoIkdkmJ
	JUyCIt0VLDmvHkAkZzZmLogQyrJFt951G0r2KyvmmPtc+lYOvMcZt4vbMqA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg4c6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 13:18:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-887c8b564ffso298105085a.0
        for <Stable@vger.kernel.org>; Wed, 15 Oct 2025 06:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534291; x=1761139091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnMgSGQvZWa892OSdBf3qcySVN9QLFS9/sViBiMJgyA=;
        b=XfVHiI57NmLtPkzbVkRJdob5rJLGOAXuUS6y0XN4afrC7Xfh7xvmPpHCPlZ+A0/uhg
         VyllepkQWxEgWmxqEUUvLA3jtqW+guSWY2dRWGrJw4+KCb0wsRqEGnE1EYIuSxa3/7UJ
         k+w1GCFkFwSTsLMHd4aHuRqYPMz3YlpAt/HFZ+VHhA5AhAkQr/Hbql6pwdnNw0yFxoI3
         Ktqa2tRsxukMTAjDLNBuMbwr/2kKy6Ra30Iq0hKjqzBNBQ8xCM5xf5uZJoNNUMdwssqD
         HLumLmDDfApcbvvKxMedYSarinx6sIYbq5rDjeE8K5v/6obumad7T2uDpPOzwstW5UN4
         Z2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWs2XCdrmiqXQMY6Qq6thLvySh70uRpOBn/oJseE7kaIrnWPj0zIXkbtDvxYBcbhFaPf15RDy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ymbb8cvVlAjkUG5Trw7wwUYmPoVNmWIxq9QANmpW3bvmP7CN
	YWQZqWCfkUDOoeHtkzLGUR9LvhOzMVDzjHsYFuxL+yEZRYOP4GePO7rJVyJzUVmq9aQ2CgtIsoY
	AE4PVVOEtQ/Com2KjuXF0o18Xj7I1qosYUJVE8reXfV21Ml/55UZS1T/mK/o=
X-Gm-Gg: ASbGncvPGDLlSZ5f8woS/cr91d/8gh7i3E1G6YD6F9SD1/IiXECpBfnrKp056yoIi+P
	8wJCCO8D8rzoFEEyfmH8kFx6we2XTerMBPBWwYykz3DdtYqXtUy8x1ppXNJ4Ykg1hO5ToSJQcMD
	Vr5OIZyjSRLEDFapmTgK7DqXipgSoSXhEss1+XKDfCBLjCcA6O9NOoQLGhukyJA+8i//s4NlmrT
	mXYjX0Vyepn5iD6fk1S55PtuNC+mSDMqKDLoUyKZ0fTQk3ceUVAHjySIg5DKKleBRmzocDOZA1F
	ZpdrjrwsRGn1IXLYmCIzVET9H6aNkbKdUGLyiGvhPdcDuxN+lsIyPA==
X-Received: by 2002:ac8:7e89:0:b0:4d0:fbd5:4cd7 with SMTP id d75a77b69052e-4e890df9b42mr974741cf.16.1760534290517;
        Wed, 15 Oct 2025 06:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQPK/8F9/L9WtmiMGFpf77cZuz+9kWatOyQjFPz0hd1jWTnhTVvG4UfIIpB1jflL+E3HXJNw==
X-Received: by 2002:ac8:7e89:0:b0:4d0:fbd5:4cd7 with SMTP id d75a77b69052e-4e890df9b42mr974021cf.16.1760534289820;
        Wed, 15 Oct 2025 06:18:09 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:09 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 3/9] ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
Date: Wed, 15 Oct 2025 14:17:33 +0100
Message-ID: <20251015131740.340258-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX6CLC1r7RSGIA
 SoNOWqxoXa1B+gxYQDg6h30STYWJRjB5iST4lvylKPASvO9iFq3sqkhIxf2opQXsAmdyZlO1AMx
 /8LSxd7YltxKMwthZcHqY4eW5yAUeeys7XX8PcXsIRxkd3Hm+bOEEFfvkXYfxFBPtuflWZh/9Bx
 tBOZUcZ7SpKs3xVzJvEUuUsYbIuINEpTaLYrwWe6eOyEH290xN+UU84sZXMarcESjORq6Cs3BCV
 h8/aJaQUZBj4wgfNqrTkKLcIIg0le7hIWTejZqY/CuSjBI4fIBCWWHia3D/jboIDthNW9UkDrAL
 bFqakeZf57XK5/NSM6760WXyzrcPSwcWAMfHTYfrc/Uy8RlK10kFDYi4LwtVA6jjEa355Nm+C27
 bG5If0tElh3JbLxqyOxHqN35boJwEw==
X-Proofpoint-GUID: Vo4RvnPJYPCXyRTH4AjDFb4S2yvgmip-
X-Proofpoint-ORIG-GUID: Vo4RvnPJYPCXyRTH4AjDFb4S2yvgmip-
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ef9f14 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Ubk33e6zxpvlPXQfVdEA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

DSP expects the periods to be aligned to fragment sizes, currently
setting up to hw constriants on periods bytes is not going to work
correctly as we can endup with periods sizes aligned to 32 bytes however
not aligned to fragment size.

Update the constriants to use fragment size, and also set at step of
10ms for period size to accommodate DSP requirements of 10ms latency.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index b616ce316d2f..e8129510a734 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -403,13 +403,13 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 	}
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
+		SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for period bytes step ret = %d\n",
 								ret);
 	}
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
-		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
+		SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 480);
 	if (ret < 0) {
 		dev_err(dev, "constraint for buffer bytes step ret = %d\n",
 								ret);
-- 
2.51.0


