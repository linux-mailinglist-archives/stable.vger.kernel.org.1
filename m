Return-Path: <stable+bounces-191657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF16C1C5AE
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 18:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900D5960E0E
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC6354AFF;
	Wed, 29 Oct 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NOOEL8vj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VB460x2W"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B85354AF1
	for <Stable@vger.kernel.org>; Wed, 29 Oct 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753679; cv=none; b=AlCnhPt+T/fwF5waI7+Q5I/Wepplm7LArTrrXoWFAc9a2bNKMNsL4s0DTkditUQICg7aR9NkGGmolSDwvxet2+vNYNGhRA8ren1a1Oq1WnJjDPThj34/mQ8eYox5ECtOzqmhqywK/VRtzCTf1aU3sp86WJmCnqYXnVxEnBxOq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753679; c=relaxed/simple;
	bh=iZXJ+wvYSZ5S6EtMrmxWZW14bw4Q9snvePaLf0HVOQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mbqp1CuxPoUs7Id7mY80ri+crvIspbu2TaySzMQCCDHyZoMvTy3zs3+0fkE+BSAwUvOSPJN4rWFTExzNsafnaRJKoGhE9/wM8VlFqzPPUQTznQCdDl6rouFe+MbUho+dj23i2fDxDGG9p8lh0ONJNcuXxmrMvMQ2GePValeAEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NOOEL8vj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VB460x2W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TC0RBS3720424
	for <Stable@vger.kernel.org>; Wed, 29 Oct 2025 16:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xd6tUxrDmZV
	yYkpH6AHK/2JkgivGrY63G9FW6CayDw0=; b=NOOEL8vj2NWA1GTOrvp+0hoMfod
	hfSfTlX58IIOqKdai/Pwy8kBLc3i5BtaKYAuSDXg2NLnUiaGPp5PrXmCxs62xOQZ
	TOSbY5brM2mR8uyXCdJdZEgn02oZ/C8mWyAQre9lj+MuMPOyH372zNfjRjHjJOAa
	gy9A5fNxX6GGpSXXyzk7F/XeDQVSf2itzs7KB8gPSJcKnju40EFnpyzUCVNdwkYz
	507M30s9UaqLo62GPbz7YUblmSBh9ZWqHAevCS6DRo9iQfAsurWtpUgqh0rljSfn
	irlnE/VJcBukpfrNvTj4GcwXRhnbFVIQRHPitgpXxEjSfjPi1uR7eLvmJYA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a237fr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 29 Oct 2025 16:01:16 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54aa7b50e26so8980e0c.0
        for <Stable@vger.kernel.org>; Wed, 29 Oct 2025 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761753676; x=1762358476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd6tUxrDmZVyYkpH6AHK/2JkgivGrY63G9FW6CayDw0=;
        b=VB460x2W4XbxVrN9/6yFB3sAgIhrq99fG4ecGqb54Oo1mf2Uo0EeSCsbo6MCtQcLp+
         FboKH7Qm4VA8QCBlHuGWt8fAeyrgIGBl66cDmsqChuJbOfYAuruNXJehpaudTJMgekDT
         LvgPfOgQRMF3z+JLtG2si3hw4gU68W8cV+JEX4HkM/Al1ZiZNC90sqNHFuRT3zPHdVO4
         RirGiJ7nNXNR69FspHBHjSbQK7Le9D5ZBxz7dNizBB/G4Ud+b7+und8kJ2OlhPMQMZL8
         CQZRxDGmhWkf+qIR1xlvLxbNy5thICTTdSOTUFski/YDOzL0H7BuuMKS7NEjhedboIhD
         87Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753676; x=1762358476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xd6tUxrDmZVyYkpH6AHK/2JkgivGrY63G9FW6CayDw0=;
        b=c9qF+ZZYWm3zbtBUIJ4QKmJCe7amX+M4VzhEdJwz9y6N45VCvZHHQjnZJsrpQP0omt
         ZpRDt5pzMfJZW8bTtkW/yf1e5wl6ZTVRA65r9eCjklrof2EnE5xTfbqGEbMaZ3JXKlfg
         t5LGXBJvyef5cuRLfBS/v0dzgemBLQ3QZtJ5NoubfbYNUmTtlx1Oq9uOqTs4c4JjuRP0
         t9eRw7nr+CM8W7DWz9DhDhcjp0I8jgCON3WB6dYHnL1LTwYikrBgAX4qjMU1/CK3Yp9w
         9cxBJisxwTb0MlTKin8XxKuoc+byR5UByTLSYjVeorQosEXnv0sfdVrDupscIo/V/hVa
         mniw==
X-Forwarded-Encrypted: i=1; AJvYcCVPNwO2GRBXj23e7FfA/0paJtuX1GkitWpG0HZALLxt52w93H14SlWYnZuBNBv7iN6jsROD/LI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz76ZSUBfrFfu9tQWFP44ouR038l/Z2RbxZEgYLMZv1B8h0zgB
	WLGeAmf97p2WxUNO6zyfdh0nhw6dzKeXp8zNoynX7oievIMqfQ/ZhUBUBdWUbJ+4PYXmTsAxxHp
	xt0n3DZZ/Mcq3F7H7mwwzC18F+qrcRYL7ClsI4eVKc4rZJqWt8pnmSVcaWC4=
X-Gm-Gg: ASbGncunJvjlYV2aC8rxKYRy9IRBdZe1CKJyX1gUrYXqasBvtWB39lvX+7mDOnl6YiC
	5lHm/T3/szMIqKL+l0DF7QeNoIgOrSCGwFXylpTVS4Lf27SWBTdw/LJcsZY11fKz1t/CzD98m4P
	zHzsg1hNcQaxj5V4GGQVFQEc9GpdLNDYUx4/zl5nH4kd2ONqI/vFxuPLcpfJyZ/1mRzF3MmeI38
	A0E8sOUMBy5EL3wSdhwioHjPtqmOZDvS3Q6MLZkZYhiIw6gT1+9/sNx5O+z2U7U7JpJsUhUgNsq
	l/dh9eCwPpQvHN1PlBZnLJFMgTcKQaaI7xdEZ4ovHjNC93jAZmaKfi/OJcnkob+IgA6byPIXOCg
	7qKHpOmxDlUBv
X-Received: by 2002:a05:6122:1d9f:b0:556:4f4e:812a with SMTP id 71dfb90a1353d-55814105b1cmr1156444e0c.7.1761753674879;
        Wed, 29 Oct 2025 09:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmMyq2OMke7b4038qoWowzNVA9IP6dPgXk9UEoB7Iao+WLyIdArUF4UBE7roEcnbRQ9jmahA==
X-Received: by 2002:a05:6122:1d9f:b0:556:4f4e:812a with SMTP id 71dfb90a1353d-55814105b1cmr1155604e0c.7.1761753668177;
        Wed, 29 Oct 2025 09:01:08 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e27f7b8sm57154535e9.0.2025.10.29.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:01:07 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH 1/4] ASoC: codecs: lpass-tx-macro: fix SM6115 support
Date: Wed, 29 Oct 2025 16:00:58 +0000
Message-ID: <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDEyNSBTYWx0ZWRfX9ZtWtV/7eANJ
 WqgVAucj6evzK1nnUQk1d6gSIc4KYZHNNaiY1Ec16NZrUKruhP/g1TuaUk6BPRTV5FhfApM7hUY
 HNoggaplG5dWM8OKpNbsH7tQ3DaFUi69a9rJwHzHTz4RWnH2IvWfvonSZSjgVlo5M9MMgSH+dy1
 Conhrjv0xm+m9ITZ23xsexBj7WazBjdVbIU8odJcZvC5mmJdf4Zn1qqLYkDe4dvA4fu3C4zKg89
 K1Ahiv3ZqFuC0O4sILoFWSZaWQqCiqJ6pQVOEoWOEh1GHZ7S07TvP217Zu6MvjBRreBxIj80YNz
 Xzz3q7q8IV/r+xn8ORPFCgSEo7LM688O1yAAqWS1USj4lBYFIJfvZZrWOZsiFwLYU6bqKQRNm2x
 HjCq14oNOvRz9G6yxlO9q2SD4PlsRg==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=69023a4c cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WUhUZdYVz38ogwO1su8A:9
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: GJ9hrgLY3Zr0ABlZMutbIhthgaAdZLH1
X-Proofpoint-ORIG-GUID: GJ9hrgLY3Zr0ABlZMutbIhthgaAdZLH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290125

SM6115 is compatible with SM8450 and SM6115 does have soundwire
controller in tx. For some reason we ended up with this incorrect patch.

Fix this by removing it from the codec compatible list and let dt use
sm8450 as compatible codec for sm6115 SoC.

Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1aefd3bde818..1f8fe87b310a 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2472,15 +2472,6 @@ static const struct tx_macro_data lpass_ver_9_2 = {
 	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
 };
 
-static const struct tx_macro_data lpass_ver_10_sm6115 = {
-	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
-	.ver			= LPASS_VER_10_0_0,
-	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
-	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
-	.extra_routes		= tx_audio_map_v9_2,
-	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
-};
-
 static const struct tx_macro_data lpass_ver_11 = {
 	.flags			= LPASS_MACRO_FLAG_RESET_SWR,
 	.ver			= LPASS_VER_11_0_0,
@@ -2500,9 +2491,6 @@ static const struct of_device_id tx_macro_dt_match[] = {
 		 */
 		.compatible = "qcom,sc7280-lpass-tx-macro",
 		.data = &lpass_ver_9,
-	}, {
-		.compatible = "qcom,sm6115-lpass-tx-macro",
-		.data = &lpass_ver_10_sm6115,
 	}, {
 		.compatible = "qcom,sm8250-lpass-tx-macro",
 		.data = &lpass_ver_9,
-- 
2.51.0


