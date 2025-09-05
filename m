Return-Path: <stable+bounces-177828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1651AB45BEA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246E718856DA
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3131B813;
	Fri,  5 Sep 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ha3gWJbS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6B31B809
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084733; cv=none; b=KDZykIAsHKDCZfz3KZv2FhqIKvBEuAHWtVM1KAaWyUvyRdiUTK+9fIKTNxIc1lLpZLvyblz/pwhuy9jVTkDnc3bWHpTVmR6q7ClPxEUY4JsaI/WpXlc+LiYIIwk26DhUEk+9diB4WoKMHQPIeYHQD2pPvanxxl7PkKgB9sN4I4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084733; c=relaxed/simple;
	bh=WC0wC8Q7sdcnE55UR77nZ9YhFbz8kmathVHMq557/fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUgymURlzija/tXsEtNZH/H++QC3Ex43K9WuLPKKwn5kLtlZJGtOXKPnY0eeKw2h0CliqW9E4l6cyT1XlFPl9JNGw5XcYLXLE6fKwrZTGJhm6Td7KFW0mXVeQwOHWuUFXYSb4BVpcmssVpQKa4D61H/H/0sN+mhuBemPv2TD3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ha3gWJbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857CxIV007683
	for <stable@vger.kernel.org>; Fri, 5 Sep 2025 15:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dfLc5hoIAeVv0LRPfL5wwCPsZeYeR0ugf52
	QpVAesm8=; b=ha3gWJbSz1VNvSmS/04o8DaHtDA28rx+/tSSudxsp9MH14BCbB+
	BExvOxFlV3f5VmpVQ68OacA0KytJzP93Q5C9emaM0DcS3fN/XCBjhz5nhg5fjrK9
	jU3+NYm1mmycDFp35Sa6BS8GYW9PweW4khuRziyvg4IWQjw6orNKAoxFYtm24SGg
	6y3xGixxnKdtPT8vtpOd9T5JDd6waobe9FZuX/70TV98V2Tf5VKcXqWUqv5/E8Cc
	UNcKcMLkhmPlRFsGrWPezk9ukMvMWPSZo+Hv7Wv/i/Ht65HpqzQaQ37ZSnBg2lGO
	5i930w1VUqPPHgFJs+exPp2wytNMnA4IZHQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura93cgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 05 Sep 2025 15:05:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c949fc524so1749735a12.2
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 08:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084729; x=1757689529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfLc5hoIAeVv0LRPfL5wwCPsZeYeR0ugf52QpVAesm8=;
        b=D14TLzvEjoxaH3FfaWcbYfANgNSycllz/qTvvGG2VkdKgliu3mqmxBd0HBZ4j7MI1X
         j43Ws2ow+BM06IRqS/P8NkHDiUnSF0gcHtlvbIn96nCAe960uXXHLfzx1pVCq37sENq2
         4TLn8T6NzJ+6jvp/0ssFXuZEdQj3ym7+6TuaH/Pzl097Cp8ar4UgzrUQe+HpGECt/cNi
         9/dFHcbdiQfk1qqYJvCcXxTmCQNEfFQwsGoR9HHyQccTflIPxILR0R1OTArF1hDaFu9p
         I7PPbtcmNG3u09RFcjA6Y5cJ3ni66ufrPS6XY1dn9hsz0uAB8oG/bcUY6GzntCYaH9ny
         7Etw==
X-Forwarded-Encrypted: i=1; AJvYcCW7rkTp79VJ/Q3nFU6RvWhpx/Trh7myzLDaZLpuLav2kmLnptbbCrl3ujPbUZesST3vU6tHEHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye//gTxPMkX6Jio9Faq6xk6Ii9bOns7NfhfreQtNqHvZNNUQys
	OB03I1j4ghR/L0COp9c8MwpafQGPpAFu197nJyQFSMOy4PXfIY1faDGHP532LaPO43OFtfbIwMM
	2CDvsd+7t0rHVz8LHxIFPcliYLjoYkcak6KSQCKIxRIcjX03szt1HayA9ZMY=
X-Gm-Gg: ASbGnctbLDxwnjSnz0aDf7L12iWa8sknkhuHXL2duNi0gmswEfMxOSJAy9sM9+HN4ba
	MJKR2RZk6Yu/rBlsME+gp1lufmEbuDRK0upZLHfym9DRNvE+W9JLPoQiuUBcu82Oz8sqQmR/LwN
	2VVN2/FaEJ6TCXaLVgyYvtmh689Cxy8fF4hhw5iaDYeJznR1xNZyjbethh7aAzZKOwcolLwHN1d
	G+R5zA0+UUC2uKmA+xQzS3xZWCJMcverxhSn5QrlSIhNQ+MRZSiANaBuT0cwqrkF99seSIyMYJg
	StgR18wgYqJdsO4xUbrnZClBSVhCSZL3Cp3Q5Lr8QolNPS0ZDwFwzAf7eoHoCD9mearJ5xKId0E
	4
X-Received: by 2002:a17:902:c949:b0:246:edc9:3a80 with SMTP id d9443c01a7336-249448dce41mr332440575ad.5.1757084728373;
        Fri, 05 Sep 2025 08:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEur4fImbfHnLpDXHW5l9lSq6IXnaOlfb2z9L5MzDU+HmkU7aw7yrqcmOlzzf3CXuFiwl+f9Q==
X-Received: by 2002:a17:902:c949:b0:246:edc9:3a80 with SMTP id d9443c01a7336-249448dce41mr332439615ad.5.1757084727663;
        Fri, 05 Sep 2025 08:05:27 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm28882840a91.26.2025.09.05.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:05:27 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v3 0/3] ASoC: qcom: Fix lpaif_type and DAI configuration for I2S interface
Date: Fri,  5 Sep 2025 20:34:42 +0530
Message-Id: <20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Hf6gWJJsT47Ykz9ksjV8lRfuox2qKRQu
X-Proofpoint-GUID: Hf6gWJJsT47Ykz9ksjV8lRfuox2qKRQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX3cF8KWfuR1Dl
 ks79fH+38y7PSNY4w5ekYzp7toqdWQbLX/zT5HytnygmOFPpqT5Z7mLXsMJQTtRwIHja6os8bWa
 Pj0NbgygZ85H4IKT1oudw95OSSZYNEnDunftqcj7U0ILeyb1oBBoHURGe8L3VzpbmQ0qlbDgKCF
 XpsVT61NmCLzBVctj9nqj2u/VVt0ocmzZpOWydKLEoYNayPD0oPTrmR6wbAb24gPA7l3LcXeC8H
 NO/l8zW87Bzx8n8Az3BobjihBYLHkaY8Pab5GLnerCrRaH8Kr1G4ePNrgiLboudRWCAdYN5HIXV
 CEExkHW83uqC/UaylEzJ8g1IdQk40rp5gCJ6a+A4KnvW8+Zh+E+MncRSjKabcoi1NG7gb87xUwO
 8GW4TXXj
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68bafc3a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface and also Fix the
CPU DAI format misconfiguration encountered during I2S
stream setup. Tested on Lemans evk platform.

changes in [v3]:
	- Added Cc: <stable@vger.kernel.org>, suggested by Srinivas Kandagatla.
	- Added QUINARY MI2S case in patch 3, suggested by Konrad.
	- Link to V2: https://lore.kernel.org/lkml/20250905104020.2463473-1-mohammad.rafi.shaik@oss.qualcomm.com/

changes in [v2]:
	- Used snd_soc_dai_set_fmt() API to set the current clock settings,
	  instead of the default WS source setting, as suggested by Srinivas Kandagatla.
	- Link to V1: https://lore.kernel.org/lkml/20250822171440.2040324-1-mohammad.rafi.shaik@oss.qualcomm.com/

Mohammad Rafi Shaik (3):
  ASoC: qcom: audioreach: Fix lpaif_type configuration for the I2S
    interface
  ASoC: qcom: q6apm-lpass-dais: Fix missing set_fmt DAI op for I2S
  ASoC: qcom: sc8280xp: Fix DAI format setting for MI2S interfaces

 sound/soc/qcom/qdsp6/audioreach.c       | 1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/sc8280xp.c               | 4 ++++
 3 files changed, 6 insertions(+)


base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
-- 
2.34.1


