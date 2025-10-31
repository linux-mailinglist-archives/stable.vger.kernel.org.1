Return-Path: <stable+bounces-191807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC6C24D60
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 12:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A87DB4E733C
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051ED346FBB;
	Fri, 31 Oct 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hlp8vBse";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayuBRYAi"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E104346E6A
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911307; cv=none; b=Y/olSozu1+LkxQ3WtxwD6PA/5jeMSdMLukoT5PKvRtQ8cNgmF2a/xmJtxh1OXnU0BkAWHdkoikGKRbNPG/ap+eyAsk2Z9MkJToYMpQtEqm7hugB9YRSBQCy3m2EW8AN0Y8jykSV0IsnXoH/Fo8ax/QPMU9COqtv8nk4viBskImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911307; c=relaxed/simple;
	bh=IjhQRZlTTXmUt5sgJp27pvl7YrbqCsNF6Y9gX3XiQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLNENT4D/NL3V+zSLES40+lhc27Pok4n4ZkZcZutaM1ZekJH1wTYp8mOga7iYIGwouMMZIj1VRIJzQ9CKC3YfmdG4vZdtutza2aLksrEDxdnG7864gncz0N+mgPcHkEA2pJqkIi15rswC0w2zlgUp/dRGP39o7NAUysDJtj9/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hlp8vBse; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayuBRYAi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8TwPK899073
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 11:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qgwrHL4mIWD
	XlhnJhcTW8PlWmQLURwHl1NklGm/TfcM=; b=Hlp8vBseqWneaa3Km3YHyMxDWMo
	whU9ic2x/1hC24GHsLsmsUbosJj3nd9VXL+g5NDsl7hznzKjYpo5CwaF/MVSPudy
	GUn+bw5/S76LMKbgi0IWRW8gcCGNc1YZ7nu0zoG6BvmtaF9xpQegsZ0fh4zrIzCd
	zYmMxr4wqQMaJFf/UqgCpIKSEE1qVIBakmPoKCJkanZ0dROvqVpR9jBr7bw99c7m
	WmMndsI54i2eLfRdlVXM2wppes+Xd5NgAFFLUtsndkgyI392aNlfmpY56gPWrq4T
	8wcwpb6q9xkwOxM4YzLFXau/ffY5zUzD2Y2RSk9UYSz8VkXSNvSvUu7Z7Nw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb21xh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 11:48:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so52965621cf.3
        for <Stable@vger.kernel.org>; Fri, 31 Oct 2025 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911305; x=1762516105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgwrHL4mIWDXlhnJhcTW8PlWmQLURwHl1NklGm/TfcM=;
        b=ayuBRYAiSxg7cGxCeK8xF6WFtD/AaF2Zw3NZNI2RRp/1O9/3Htk5ch3zQ3gz9055u4
         B+qXfxrMzxvAZ8bTxd/ghPmBFMxrHQmrDonkwDlH5dB9hZFf0I3xyHj29FEzpbAQI/L1
         FqdU5jTXjqPdU48nyh+GNjXhNte/a0SIoVT3iQi2BdXDh/bRlEvdxvUnqnWyH43HIUH8
         icmXRMoDOSXq5iCsj0Wa6tJifezctdKuil+hLyQ+Y2ShM6GGOGM6Xn1g1hzdb7ZtUQpM
         tYlVB53kacYanUaJd7OpX60oHm8VK07s+WtJfBZRuKytzzvCY+mR3JUVwRCAuqwVbsZq
         xOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911305; x=1762516105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgwrHL4mIWDXlhnJhcTW8PlWmQLURwHl1NklGm/TfcM=;
        b=ngVak2z4hhWuXfUnsx4eOIL4yTeazO/fPLvlreUCq34QuQS1yHjJnVurbvGAXY5R/n
         WdRtK29ufmer92B4v5A2wOZtVUC9GT2oW3b1s3WgzrdjXcpNO3xfon3g9f1V/3nfnywc
         NTGVKucXuCrXlc+CEsfuAeOJRyBHEQ4247bb+SwWuEBkxBqqwg64bImqeQABPJoHjA/q
         tq601RYjyI8upICReeZhP9Bdy6naEpxhJ2QIaxHZi9y/Zb4Oh64I67p5pCkOk9S+cgbt
         HKzdXuuzoYYN3hYVUIhWjOYpZ+BZFCPhPgcV8o9zvh1X2ArWe3XKOoLWDyASEkAcGW3/
         0v/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOu90FrnePY2OuHPBLpZRaxXyn4PBdAGFmAgzjoMjEprrQ8D4Yv76uN97Gfp6if/3Zm8aD60I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyEhDoTRdWhaX8wnEbTPVgS43U6btnO7wbLFy2jW+Eav+22pt
	fgPWzOUJ9jH30+3+gUG2rRrwU+1jh2l9D6YLynrRvcWc++X6No4UfFYJOBB7gRTZq3GeIBN70K7
	J+Ib2AVpNp1ZnJpj9T3ZFWIBZ5p78yWpBsoCW6r8H+/ce77CKuBHZa37ZCZg=
X-Gm-Gg: ASbGncvvvBuUFyMiSBCAk9dt246MyFOY7d17ckz84ZmDt8Hk+xi0DKupDmY/GrqQhhx
	OdtUJq1V/WuZWZ2dKmJbnlyb0gkZ/nR0fZW/byiphZaux11sQFEdTwPUknz2g+38sxGRmlFcQvS
	brl3EZNKTgpkyxGjclrmR9sVh6oabO4fjhDcMKGNLmIPsHfOFUMMZ8r3fB04eQNt1P3yuVNHa28
	JJRUFiyPSu0GcQWiVieprRhxNegs03H8E0i8/M1pr03ogmP0VX2w68bzIORlYkTRQIB4QbdoM8t
	X+XYLa346Yyta/W9stv2druH3ibBNylmIH/UYpp171r0lCUNIdr9TYnFYhaGFirTE4SQcrm6d+H
	GYH8/TWONICqG
X-Received: by 2002:a05:622a:5817:b0:4eb:a33e:6e32 with SMTP id d75a77b69052e-4ed30d56c17mr37055131cf.14.1761911304777;
        Fri, 31 Oct 2025 04:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6Uqx/qmZA1dGwjlYoTU2mJZKz2ZexJxlDQY0bz74P1DlKsZ4lpSFPWVkUeabKZk6Rn7XNfw==
X-Received: by 2002:a05:622a:5817:b0:4eb:a33e:6e32 with SMTP id d75a77b69052e-4ed30d56c17mr37054601cf.14.1761911304312;
        Fri, 31 Oct 2025 04:48:24 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:23 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v2 1/6] ASoC: codecs: lpass-tx-macro: fix SM6115 support
Date: Fri, 31 Oct 2025 11:47:47 +0000
Message-ID: <20251031114752.572270-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=6904a209 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wdEHzOyfiJQDvapTZ2sA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfX4Gr44YAVQmAv
 HSlnyfJokxVvkFxUmK/06jRtQSaw+7y3KMFOV7XDfq1ghJPNfXewfMCPyz8tewWKjzsfUC9UgiL
 HJA5lmYJApySOvu1GJe0l+ZN3HuZSb4RO2Xr3xg9busamJC/ktvYMv72AN8h+WPyiMpIi8Lv01H
 8xoiPmHHR1yeWKYRTjxEiveTUjI8qoJxQmiJ3eXgjX8sV4YiWywdrqJcSJ9h1hFbQa+5dF6ynWZ
 q6zr7SNTDjrva9acNjV5fHCIbDBTdBN6Qa5Z11oMXRFmHStvhENQktm/lkX/2iyHEEUAEF57n27
 3WcstbgaYjPbiU5BwJCjV6zeY8r7h7enrc40zZRC1orN6ZrVgGIRKLzzmYTjIQfOH+puQV2awpE
 x8Ev9OcY3hrZSm8oYm55z575LzuL5w==
X-Proofpoint-GUID: y7Pjk2P5p9tU5hKxImdc-mfwg0r6S4Q4
X-Proofpoint-ORIG-GUID: y7Pjk2P5p9tU5hKxImdc-mfwg0r6S4Q4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

SM6115 does have soundwire controller in tx. For some reason
we ended up with this incorrect patch.

Fix this by adding the flag to reflect this in SoC data.

Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1aefd3bde818..ac87c8874588 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2474,6 +2474,7 @@ static const struct tx_macro_data lpass_ver_9_2 = {
 
 static const struct tx_macro_data lpass_ver_10_sm6115 = {
 	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+				  LPASS_MACRO_FLAG_RESET_SWR,
 	.ver			= LPASS_VER_10_0_0,
 	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
 	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
-- 
2.51.0


