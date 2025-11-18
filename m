Return-Path: <stable+bounces-195078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDAC684A1
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8CDC358564
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3830DEDE;
	Tue, 18 Nov 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbQn/brj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsOu+f/N"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5130DD22
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455888; cv=none; b=kG8MYEHvGrtkhgxu2ol+RhCy5l1Kx4uv0r17rGH2WIJ3BXMQBSsgW5IBJRvMl2fh/WtA3lvkZaXqHELfs+J6FtXkXD08p/i/uLxtGkKP61jZ1XYGOhw7iY+sfgXxKLRZu1gObG+7H93Qy68zC/4bxrIuBYwJZEZ8JDffriYDpt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455888; c=relaxed/simple;
	bh=75w/DSS2hsmQuGew0+oPiaGMUNyIZyrF4qSNr7xCjPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8tsDGnJAG9b+9noRXcFprCk8rTwb/P7nVd0MjX0MmQX4yJ5xRJlAin/oV2IQDdFh0AWM1yGJ/2LcneEWEIwsbsiJbIs2uGKkCpKHPdvZHiZH96J2ql24v3o2gmEwwF763kxDJmw7PsRb7BDvQLymUcaITr54zyZbZvAyPCb4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbQn/brj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CsOu+f/N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8VMZn2249861
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H4vCyzBAng103Oq0fMyz/UmnE+wwp6D/i+dL9/t/Pjo=; b=ZbQn/brjBhwoMCd/
	IXPswd+gdSg8ZixoZa5dJWsmP1Ku/zoA5LoC7BMJCRfwM0dL2cACyBXx/hP0dJNR
	w3gez8M0G3VQDwe0y9GX1ECUUhLBj43GfqOMriaOfD29Dgm4c5J3BEn+N1MYNSEe
	UmeJ9/fe9tXuwUhAJH3Vn9wGezXaxEMd2K96b+GZFFVPKpbBKdSVGFGDRkK2qIws
	c5F5qEGOddVkXdolc5LYbL+VBl7jBDAyAqRHr7vmCs68RP3IpaOevwTt4kEqlAMd
	2jQ3eF/DOGkCp4Rad4w59Y2nec+cy8oeqtvjQE8V7wkr26V4/+NJgzSuPy15ADCD
	8DBFMw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5g1mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 08:51:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f587dc2eso95577455ad.2
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 00:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763455885; x=1764060685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4vCyzBAng103Oq0fMyz/UmnE+wwp6D/i+dL9/t/Pjo=;
        b=CsOu+f/NBsjAVHzX9hxY0XPiofCx8tD3WnHFqNZGOJ/tta9TSesB2AYYE6n7cXwn3Y
         jXsBQbOCQgUDMj1WQ+D48F/Qx+UcJBFjvS1r4of0uwBOLGUBoAx0MXCD/e/vWfQ82W9b
         2Yppt50jSl7kBsWMsbI3vr7K+KlnMtmSOtI6K3bw0ERPYgrgMEbm5uGZvc3kr+0zr/F5
         s9vDNAx1XX8XZuUxEZZuTib0mWT4T5p8We7EPR8wuPua4yyBtKQ5Vi8tB0xpdRSRjrdI
         yysRB2f8md9om97u3NuYNzp4HGYmSABFBAWOreCd/BxDKWo1/7H5f0kUGRtomWyBTC6o
         H6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455885; x=1764060685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4vCyzBAng103Oq0fMyz/UmnE+wwp6D/i+dL9/t/Pjo=;
        b=hgv/LjJjwKhbmeeSyE0SqtrKhxldPRHaJpBdjSwZ7DLaoJ+rt3GliMPQZT2v0AiPD2
         aj2XMPwbSj962L0MXJBARihgGUWiQg+Rov5V76pWlni+fmUe7+D0y49Jn+7cKu70RO1V
         TM+EmEDU+CbWjj4PBXGPUffZpaZyexsmka0t4JDk7vwXzdeXLW7z4aZe8+JdcCVJXXzY
         5RH2g36VW314iZruE1rCqv84e0+5/nxfywBYy560dG9y7GL8jk+DQINiGURaLCzuNe6l
         v4KRvj38F+zSTOhpJpDoPXvsXvgbbasRIIGLVbCUIypjTtSEhrHjYMVcxIVYoffMdQ9J
         KNZA==
X-Forwarded-Encrypted: i=1; AJvYcCWUyUcbX/Tl6ugO5Bn313iVRl1qnVDLqoSziUg0TsjXolXCITgjAN5QajJLLYZGRI0PbhpLuQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpnOnO8AEO0d59NDKnA7V1jTeAiIzkwxHV/FTEbUo+EnVBbvBL
	OSXJSlZ9eg7DgSfFGoCN+6SApr+VkdwYHhQD/cQUquxwmNrrLZ2nfLoqnmV88Sq/RwHpEbb9w1j
	KvVg7dhAWExauxJ5Vk2DD/KdL9DQ5BDENo3JwbKXAmym0Uw7Jb3QgQUD1M5k=
X-Gm-Gg: ASbGncsdl1+rHZKH0BNVto+NmdiS/m6DjWVSM4sSY2446o8Ti8bwlL1VO0dYtqepbtz
	UO5sfp3583LuKCzLT0qMJrJJy6rzgd6nL+3L+8uYBafBNag35TmelxN8CUuYzRqg+Wq+3dGaRzQ
	N3Z037GQBhG6Q8RStIc0f8X9VJVZdldrjz0MuFfMnwyDYMHApvohSw4DjaVo6Lp6qbgUaBoCDiE
	G7TE6voKNiFfHJQXymV+j5TuDAMxsvtfWnzCdp3w2d1MT2JXc34QtElRTJ1xKqHS1dSkqh3O1N/
	P0DJj7Y4jaTHXDc4rAacRe4HTxnnzpt4lB5hmlMTuHNP9KAMf+bwSPlE3UkK+W2Oncpa+huwsuP
	+A5Adz6OumWowDlUel4ueABI=
X-Received: by 2002:a17:902:f603:b0:295:5b68:9967 with SMTP id d9443c01a7336-2986a752d17mr194312835ad.49.1763455885229;
        Tue, 18 Nov 2025 00:51:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbC51hO2dOCARJAyGl+8Koi6W7aP2bRmpLcyj3T7XMY2HEbsh68c6kf4TSJcXeGL2xke4r6g==
X-Received: by 2002:a17:902:f603:b0:295:5b68:9967 with SMTP id d9443c01a7336-2986a752d17mr194312525ad.49.1763455884759;
        Tue, 18 Nov 2025 00:51:24 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2568c1sm162910695ad.47.2025.11.18.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:51:24 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 14:20:28 +0530
Subject: [PATCH v4 01/22] drm/msm/a6xx: Fix out of bound IO access in
 a6xx_get_gmu_registers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-kaana-gpu-support-v4-1-86eeb8e93fb6@oss.qualcomm.com>
References: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
In-Reply-To: <20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763455868; l=1041;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=75w/DSS2hsmQuGew0+oPiaGMUNyIZyrF4qSNr7xCjPw=;
 b=jLipoeUTateSBD+g7vKKvS2yUCM4T7jj8HbWbcE3idzdOQIu0EPirauUiY3Is2Tzh/Nibkr/K
 97kGQ3WCvoMAzjLIS/xjcAXB0eXKO6+mlb+Pc7iuP/yIi+AHnbe11mu
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 78BLq3ccS5jCq_Q-fguvFyGU39Jpd4Ne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA2OSBTYWx0ZWRfXzze2zXUHAuUy
 ZZMUHf/LytgLHIy1WiWtpsPxi5zeSPF0dP0fRoMPh1Vo5Vk1JP8DDgajVaaYQRbb35kejc6LyP8
 NpYMiVh6ZQanhxwlrvONdEq2DiIr73Whv0yJJGY6P5aSdJ2mxg5FIZWss+st5rIZgRiO40Q08N8
 nIgYTOGyLuKwUFO9LYpZ5OB1dxK7DlWCH8m4C1lYaR8MVRe/bnsQhndw//1F9ZvdLBUGRog0pkp
 wr+ejkFCrihek2ctksxTwaV6fBJx06/U5pOWT64RgKNU4XLb3ty01GgVKNQHOmtHj8jhzkA9ZlG
 kM7MDjgKPi4idWhoDkYI9FJg+qdjHu+chY0jCQnvuGe1z2DaVDpU/yrH3siXqNe1jeKcKNGPx0V
 ml5cH04460YASCa7aBQt5LePqRLR6Q==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691c338d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=PiXygW76SPkGC_ia2qEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 78BLq3ccS5jCq_Q-fguvFyGU39Jpd4Ne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180069

REG_A6XX_GMU_AO_AHB_FENCE_CTRL register falls under GMU's register
range. So, use gmu_write() routines to write to this register.

Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Cc: stable@vger.kernel.org
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 838150ff49ab..d2d6b2fd3cba 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1255,7 +1255,7 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
 		return;
 
 	/* Set the fence to ALLOW mode so we can access the registers */
-	gpu_write(gpu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_AO_AHB_FENCE_CTRL, 0);
 
 	_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gmu_reglist[2],
 		&a6xx_state->gmu_registers[3], false);

-- 
2.51.0


