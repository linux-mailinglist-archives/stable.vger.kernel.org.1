Return-Path: <stable+bounces-189090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D4C00762
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B219C6D0F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201430AAD7;
	Thu, 23 Oct 2025 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHD3C6ag"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0230C364
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215167; cv=none; b=TChiVwdr1BHgF82XFyNJZ2jMLQVWq9jwdXgWokhJWz9H3m3bSdpFUzKRQUURV5lsAd5vrM/gAtVwQr2OitStAJVJBJX4yh1sWjXuA7TwnXhWbkKIAKAAB4Jnkk0IKb+FGjguYc3CHd4S2ZvlIRabj5o1vwnhPOwka8lAk9ZW1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215167; c=relaxed/simple;
	bh=+pEzU2CaP92P+tjHZGLYMYsO+p/lLdluRH2vfoyibvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7kFHhbEcMv4j5OUI7Qr24GG7HJnqVPW4eaiCBdaHQv5T6Z//rQQ23wsKi7+CWkBhHHfpSsPBL8r4uY24dgFRxRbcPtrngvjix+pP06QlRVxD9H78xvH2qpYnA/J1Y7ZaMzDBpTPNPN+KlCmNXBqKJLlOH+JflT+0EkagLxd5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHD3C6ag; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6ZRVh007464
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hugy+iqvLUJ
	2cjxOk55z+UZwKkAMqHXBccnGqDcDbTE=; b=bHD3C6agXJdHa6WOJPjq+k2cj2e
	Efmk65n6JaL9JQox4iXtAsYb3tUz5HRd2dNh03JvSMyQtls+BNIfRxZvW4HZAJRN
	R/FJ1hCidjA/3meuFLicg/UNMQ7U9Hl3/IAndNM5JK3dzuRD1j72gruOQv35jdmu
	OuhMW7b3Qrc1CjZIIj4YzBEyseY7jF12jWxMzgjlqUafKIFybYBXHImFYPxZGQIV
	y8IuxH5luwGauiSOSHgMs7FaHx1Qa/aoLVJo/igQJXK8wrT775Rh+9qYj8uK0nEK
	0rbJlfPmxx/QSNrZAMeuf/9hUSQqtBJpVarEDIJtLDgCr2LFJpCfLwAJI+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344839h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 10:26:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a13eedecso18075291cf.0
        for <Stable@vger.kernel.org>; Thu, 23 Oct 2025 03:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215164; x=1761819964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hugy+iqvLUJ2cjxOk55z+UZwKkAMqHXBccnGqDcDbTE=;
        b=WL04SfRJxOaFb7YJq4QIO4rCLUOvCcrMgo+kswzUzsfSAjJym4qp31Df2ShUqki6GM
         CtbkyDJi4DjCHTgCsI316MNBc9MIiNkMUa1ltp0o/ypLONgd88Pp0VJy+YZsPgZTPCOQ
         8vpx2QZQAr5WtwHWTU1UP4BYIVbqrycJkZ1qD5QGBef9OqvwapgiGSI73BhFFGPtdBcn
         x1/XjERKRDcMW179lGCZYs9kNPWd+dUaI0QbsTM5SEkSg3usYMRIn3hoAkUT0ZU05ZXm
         n3a5VfpPu5U7z2e8N2AR4XWwNt6yFG71gJ8iuz2vY+w5MWTQWFetNoA41S/vGelgZbD0
         0Omg==
X-Forwarded-Encrypted: i=1; AJvYcCUngg0rFhAtaAzpzJvxlzUN+PR0lJCISRAEI32+57WtKO5B6opN1ZOqjb7j1K0uD8Jci3DjYIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhaYkHIfSH7wXNWD/JADgJHqd/5pR/gYUp7rYtxlbeW25ZTWF
	aTPnPK8UvuiWoO2yAukEQZhm/HnAXYUwqmciYQVSOs4bT2RLyz3viVCamryMKOybN57uP/LIfda
	o3x2oPBBgiQZxrFFAlsyhrIValPjklRyQ8Dbi8HL3tM/OtqMnGCcVWz4qtDs=
X-Gm-Gg: ASbGncst1ZASIKGlOeonn/vhGngD/4k/W4GkxcBj/lGNjqFHqdsBW0Ckw7Ka4fvRNe9
	uTXibrTJSCmep6KyKeHgtJ/AboS2uYa7fpiXOq84KKWTH7EwztAiWhjX/ANOOgUtYWJNA8uQVa6
	RV3G9SI7GGbEMwduoeuushrPelXyINoEjkgM1qjIjINGtcn+kzRUuvQvHfxlztliVYlMx6cX/PC
	auDUk11plcEDqtjqckYsA7xOrWajbyVVJZhdP4eCK037YSRrHZCl5gaT9xpyWBlSy0Nw0g0zqP3
	cIC29epPxA06aE90kQ8fJEQyx3XCpkg+tnijF5iCO55mrgkCpjhyuEFsQZrMmPE4HmaYmsbJLaE
	QcvFH0yXEJXg0
X-Received: by 2002:a05:622a:d:b0:4e8:b669:990 with SMTP id d75a77b69052e-4e8b6690c9emr204363201cf.22.1761215163713;
        Thu, 23 Oct 2025 03:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFZ/aAh022rvOoagwONZHMEh0MEWdYvgy0BQ8CSY0tqtrarJPhK0oSiMEE6Ys8biKzppMkQ==
X-Received: by 2002:a05:622a:d:b0:4e8:b669:990 with SMTP id d75a77b69052e-4e8b6690c9emr204361541cf.22.1761215158490;
        Thu, 23 Oct 2025 03:25:58 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:58 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 03/20] ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
Date: Thu, 23 Oct 2025 11:24:27 +0100
Message-ID: <20251023102444.88158-4-srinivas.kandagatla@oss.qualcomm.com>
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
X-Proofpoint-GUID: p6GDDxYufU6VntlgOnWWQ-w7fUSzZf-r
X-Proofpoint-ORIG-GUID: p6GDDxYufU6VntlgOnWWQ-w7fUSzZf-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXyuq8a8vVu6zc
 XFPuPBvKHQ/EzWmKjh3uEq9SOAjTkQ9eExDczpw2/AHRzJTcaG/WczmypAqTzQsoAFzYNF+1gi6
 js4IhJtu6LB6YlBjuF587WPXcPw2Ht8wo+feS+P5jx/Ltey1pQ58EgpE/Pj+kFHXudPHytnzLFp
 6gW8lsM+po85O/bgzxN3UhYWCZjfa/TfEuM+pqC04SHHKpKyOX4yw29H7TjxSqAUzbJs5fAwc8M
 dzAi6KCDLJH48LcRkMOgRng3haYmCetn39eM5ppHc93jrfPgkd0XLZYRL632bfxImBGwNQkfkd0
 AtuzzopxiB+0yKQJxVdGZ9D8HlLMV6tWWnBmxelAs+fi5PY7PazLVAZerlxAZ5qWBsuvVrj0jVh
 w8fdf271lG09EkcfT31D0NFyx2v4vQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fa02bd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=Ubk33e6zxpvlPXQfVdEA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

DSP expects the periods to be aligned to fragment sizes, currently
setting up to hw constriants on periods bytes is not going to work
correctly as we can endup with periods sizes aligned to 32 bytes however
not aligned to fragment size.

Update the constriants to use fragment size, and also set at step of
10ms for period size to accommodate DSP requirements of 10ms latency.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB5, RB3
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


