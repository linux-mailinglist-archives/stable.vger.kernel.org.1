Return-Path: <stable+bounces-172829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E96B33E63
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD3B3B08A8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656852E2DD0;
	Mon, 25 Aug 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJb0ntd1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5826B08F
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122736; cv=none; b=KBuVOqi7hbJ8E0kKSj/gxgFJxunsq6Cjd5CworFKcdmW4GsRn9CLvS3+OtcD6C790Vk0ss78l5lpp9vpDc3+qn38iTGRF13KPG/vMibdAR3rS6LJ3WtUZDo2a8rO8HH9z/wwP3PBE5JPi778enJN0D4rAIVYLhVIpN3f2inV0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122736; c=relaxed/simple;
	bh=dHzgTV5EgsoXBfE9yCqjfg3o/8E0k/K/0/cMTieZHrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tqmkkyPAt8rDGFfmCqCGbOzzz9mvd7ideQv0vJdNlwyZcqwHBUHbt0lnGwhsItQwgaR8aY9c+tLRUKf3mEuATAFIf/gjfnJRl2nB+MUY6UUtZVqdDAlVQGlXOBngzz89N5rvYz5jnv4uHo54PZQkIYZnsJFkHwW1Wi2sc263Xwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJb0ntd1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8GEEb026314
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/Y526DyN1p59PkdBwvGxDS
	FDOnzDRguJWKI/2yK0OeE=; b=NJb0ntd10hSm0hzqU8vfKNexLd+sbEWn2h22Hl
	618M03HMzt3Fe8qgPH+7v9VYUICjrt6bN8+BQQ5iT/E+Qg+VSxEAiIljpE8utIRR
	KFrIhaCeZQX7FSXVYznNdLLYNmi+Qtj1x0zgcJszUGL4qn8Qs2LphxC2pj+UGxm6
	fb4wK1e+wCRfiwoV4X9O1hxuO/ZYev1I/sUVAipnNZhuaoHLFwoV94lFievqxFq/
	Hd/2eCydsywwmXfmay5NCLmD8dXbmqGROFGE2cjBbesPytGPG3B2mBlMOFz8mf4E
	x41oXfFgKm7nqbKMdDH5G8lfySSZky1+a6gUulI9m/qj7xXg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfcyc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 11:52:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24640dae139so23718995ad.1
        for <stable@vger.kernel.org>; Mon, 25 Aug 2025 04:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122731; x=1756727531;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Y526DyN1p59PkdBwvGxDSFDOnzDRguJWKI/2yK0OeE=;
        b=fFAQkE7OYNzG+bRewFruTRqe+4exTgyaO5nLJUtxeaU/k2/geUud+ikQg2Xd7iCgPO
         WnHMRRaooivHro6t+lhHBzMjbsTqcYTZNBieactz7Mo4hmublTtgqC5yPs51wXavhQ8Y
         66TSWV7JwmJGgmy4VhY4MkAQ1aukfHzeyJD6W+8kcsnU8kC1HTyP8QszysGnvG9pPIa3
         0Dl7PMGExX9BmKqDvHO/aqW3Tgwb4qVVBdQAgvqN6VnujYjdFhOaiS11KzBzvK4uB7z+
         SQxVo2f73igtIJsNO027uPJ31FB9M4qZrEfxJK91JgNYJq2hFI2Qb0YWmj3mPlL/Xvk3
         D3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVtlhW/ANTCELNV+eeicJLMUpdw2+KLyhTFIOdymzlZAEYDuMYJwq/Zzmlk8cBjrW9PlgC6/Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3KdEEPJ9RP1NdXwBblPSU2j2tLRF7FdzMvRAjdklarQ1Vk0l
	Vdw0qD7JOpW4Dyq/vM1VbXI+sbp3kYKBToXmxkB4zb1siDRix7lgL8t2bFsUrCs+eAquePzQl1r
	HgdFm6ySHGhT6xp0K55ocih95B3TQQyHNYag5FfwP/yRc4oBR5M6xaJg6bsc=
X-Gm-Gg: ASbGncuy9grD7yovC55gpvRLNb33/KGzjdlgH1OU7cIKRaIXMBwxM7sP7NH3oU9hpEl
	KKct6RRtkKo/4A5mWyIwGVZzxktrNch/kQwC3/xQn9MIhV5KHsTWnhhsTi1/HmHCog1MlPS44MH
	FeY3XuMhh+f4dvuhzl5aePOR7qiFK/70KA6Th1ShqLrdX8vHxsbxiw35/R2E5kSgnYTEKzYhPRF
	GviwuyLQSJLp0nvdl2+bmLECQGrJK9oQNRiBKnxbajwPIQS3bLSPBUNKOmK7lkLxIWycfqFDJnm
	O6NSFcCn7lA8gOaQjQFC1wFDzxoj2Mb9x+wvN4Z2hjC6lKtd8gfFuPx6civNLjt7IhzOENUqv/r
	K+EbRKKmWRzwLUyihsIwX/RSxxrljC27LwGEPuX/Rt+jtdxs8qqRHshV6kYOiGucXwi40FgZvXZ
	4=
X-Received: by 2002:a17:903:4b03:b0:246:cfc4:9a27 with SMTP id d9443c01a7336-246cfc49fefmr37821415ad.13.1756122731137;
        Mon, 25 Aug 2025 04:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0nXT2JRvirqDOleS8kFaVnHFiCoQc5HWIvFsBFs6zeOhIu5PAQX22b01eAoG3tmxg7dDKAg==
X-Received: by 2002:a17:903:4b03:b0:246:cfc4:9a27 with SMTP id d9443c01a7336-246cfc49fefmr37821145ad.13.1756122730680;
        Mon, 25 Aug 2025 04:52:10 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b521bsm67081015ad.60.2025.08.25.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:52:10 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/3] Fix the NULL pointer deference issue in QMP USB
 drivers
Date: Mon, 25 Aug 2025 17:22:01 +0530
Message-Id: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFOrGgC/x2MQQqAIBAAvyJ7biEFsfpKdChda6HMlCKI/p50H
 IaZBzIlpgydeCDRxZn3UEBWAuwyhpmQXWFQtdJ1ozQeW8Rwris6SuRxDxg39K5txlZaY/QEJY1
 F8f1v++F9PxDlQo5mAAAA
X-Change-ID: 20250825-qmp-null-deref-on-pm-fd98a91c775b
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756122727; l=1268;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=dHzgTV5EgsoXBfE9yCqjfg3o/8E0k/K/0/cMTieZHrY=;
 b=bq8Y3fUJzfMQT1ir+8ZpNme7SH/5rFoC8X+nVHsTL4XrSAbtetJEoIRxutdNqbYkdSBxVKOo6
 cQ+0ejVApFeDS7bz+rcwSTU4RUbttRQyGQAJthKmpRVm91keB91ALka
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX9so+V8AyKCuY
 aGGYkh00TxypomO45BmI5iv4ZPIX02Z3zS4AWfD6+eGCH1VKOhoyBCy4VXxWzUAJ3BI81wLuIHQ
 km+PZUqcj7Cy1mPpFB1mbL7zHV2Czpp3LVPFeWqP/t/qi+F42MTakry29V49S253tLptFZtWb+W
 ejgnvU6e35CyNXqRqAREyMKgDj6EWA6YqHk7c5wtPpyvVcs5SaR8/zDV4VFEsj8bmVY+HOmOpeQ
 1hJkAME1kTsUYOtV6l+p8uyHTmkRCaRA5jUjkIe/8fCk08b3P/RLEsd9JEZU63zHwoVZ1h4x33c
 81q7BGuTzAEnel8UZAA4M/Gprf7oxWAfVJ/jYH6qVqRC7VLeYHJw65tT+JHLiYQU/narZyWqAC5
 EpW/Zsq0
X-Proofpoint-GUID: cYBTl4UNqZzidJCBreLbPCfyFIia75aZ
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ac4e6c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=7tgEStx-2YtQAc9oN5kA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: cYBTl4UNqZzidJCBreLbPCfyFIia75aZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

In the suspend / resume callbacks, qmp->phy could be NULL because PHY is
created after the PM ops are enabled, which lead to the NULL pointer
deference.

Internally issue is reported on qcom-qmp-usb driver. Since the fix is
applicable to legacy and usbc drivers, incoporated the fixes for those
driver as well.

qcom-qmp-usb-legacy and qcom-qmp-usbc drivers are splitted out from
qcom-qmp-usb driver in v6.6 and v6.9 respectively. So splitted the
changes into 3, for ease of backporting.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Poovendhan Selvaraj (3):
      phy: qcom-qmp-usb: fix NULL pointer dereference in PM callbacks
      phy: qcom-qmp-usb-legacy: fix NULL pointer dereference in PM callbacks
      phy: qcom-qmp-usbc: fix NULL pointer dereference in PM callbacks

 drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.c | 4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c        | 4 ++--
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 0f4c93f7eb861acab537dbe94441817a270537bf
change-id: 20250825-qmp-null-deref-on-pm-fd98a91c775b

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


