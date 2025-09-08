Return-Path: <stable+bounces-178845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22CDB483A5
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 07:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F18F7ADE72
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 05:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D122A4CC;
	Mon,  8 Sep 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpqscwuE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C05225397
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309839; cv=none; b=mNzC/8onkU7MnhrYmNFzFfV0UmtiTUen+nkQNYKYfFF/RW0fuuw6zTmhO5QM7yba2kMapdkfGD5HlqFb988X5XP9BuUDyQnRgUg3zE9bWZvq5Iu3k9SgvAHhYaT9VFjSYYWiTSJwik0YzsSmafKjoiRNkQqzMRpDkowKZ6pRYkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309839; c=relaxed/simple;
	bh=CaB1TNSUbDHyyFdrQnQBPgQfdsRu1OOu0HhAAigiGDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/M2mVSXI3HZaoqOvGfx2sxsQUT+m/EF1T2kKbpe3+MQNVfSf7o+ZTXOrJXkm2UHfvd6Kz1o4YEuq1sAzs6CUbuGn1dEB7Hw5wr5KgAVdUnBx6xtqNUFCxufJHIQq/tyIGd0fFT1CwGb2fXEpVj7SBvE+sIv7M18iJHK5Zni0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gpqscwuE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MbDlp030332
	for <stable@vger.kernel.org>; Mon, 8 Sep 2025 05:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lD8cwxf7MZ8m4wMdcW4NqOMxZLJgf7K+8dM
	uzZNQ9+E=; b=gpqscwuErW1BX2hi2kz8Nlw+r8zmPO2a2Hq/Ek4uAW9HqgnSiz7
	tzY39FjHxH2D2hL2m9mxYieGHRF4BjoWp6fF6OUvFskRWo5s/E3uJGelWSvdY9CB
	YI/U792TtBcHXRzOu6B/qXs61vRYRDKsnQuYCFWDQZaP0BQtuhT1ln+gd42WLFI0
	5FbiRPGjo4GmntP2ARDYvSE0vQ4XPAULVKfQAsYcnO/JI6ljKns8KTWOf4SkyZT8
	owJ4i2eVr5Rk3xdzttX30PQBALTcZ19efp/XJtWm/Z2n5zKqdncMOlva3iH0/ifb
	mRii0nxTCZR+8ymh6UsOPO3w4H1rZ85XvxQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a383g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Sep 2025 05:37:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724ff1200eso3613401b3a.0
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 22:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309837; x=1757914637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lD8cwxf7MZ8m4wMdcW4NqOMxZLJgf7K+8dMuzZNQ9+E=;
        b=seZjd26YUCockOIwxMYYecBMpwozpyH327MCKK0K9Mr1BIQ2vGpAnf4KbSMcJ6b/dc
         SA+itSA+pDvCh5Zrh6bAbJDukT2ftEVEzqMB9T3M/A6DIpzFdjfLzMlaXvTV53kn7ZTB
         E1zTObI0UHWuNIkHcpljSd4hD94/uNXdMTH9N/+AfSMZAzA++z5eDt5zn/jN0d2tQZqw
         L0fiWImMkM6qJ2DrfpATQmmZxolQEjMzEW7+4CFQNe9Qag3FYeDxbgNpuiQhcY4lxeqJ
         TlVfwmfIKuDPr7PdeP9bFQfKHiDpPK/nv/rO2U9+IEaqooE9nsRinYJl75rzJHVd2V3j
         aFrw==
X-Forwarded-Encrypted: i=1; AJvYcCXcb+otjQIh867S7E5Yl9pZAoinjaKbvO1/9zuJna/cPhL9+bvqwXGkoQ0o2RebE4iSTDbIXgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/TREVxHze+6JsGDQv7Oq7v8I7AU/3ixoFab+J5iY8EtEKl/FK
	qlJcOBYuOy8rdyeFwTCDq9F7ts0ziyEHM3pGSZUnNNxS2X5qjQEN6aBld0XcwSgUbebgjyuU0Ft
	5ft4AtRMTYAeItFnKP0DZBMPp9NOnO76npq672HQL7zL/+BdXL2XjoRCUDWk=
X-Gm-Gg: ASbGncsXVq+cBM3PDqcEdufC5+2Wr2p+vRyJfzZRKs8ZNfPGrXb5kpthUkU5MGPW6VL
	ePGxcIFdEDZKGaKlnS0pG++RJByJLJPNsBTSIzH0MoCSBAAgiJNTtYJofpnPNLBrZt4ixf9KCV4
	ju/gqtDRo+CKEXy0xGTWpJ1jzED9WF2OirKEomhztuCGIvzgBHKKQ0L8X4YyWv0pxAhdZa4MLtm
	vgYBQmbCgWTilX+F6WpGeY7uxgxV+XwOisJDKsibGzEFnJar4mH4F78WhXN0DqWd7zxtcFBY6I2
	8myTRMkci7H00+yvR9CR20lAze2tydDSZbJIeSqcXgaog+3sLp6sencuYmVY6SYULxw4QfI2+TL
	o
X-Received: by 2002:a05:6a20:3d88:b0:246:9192:2779 with SMTP id adf61e73a8af0-2533d60850dmr10791539637.7.1757309836693;
        Sun, 07 Sep 2025 22:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH57rjgychLB7Qf8P+tE8Tlb0ThhlaBMZviRf1StqzDT6yykvqMOcWbNKfvbcwKGmoSP5L4Zg==
X-Received: by 2002:a05:6a20:3d88:b0:246:9192:2779 with SMTP id adf61e73a8af0-2533d60850dmr10791504637.7.1757309836229;
        Sun, 07 Sep 2025 22:37:16 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:15 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
Subject: [PATCH v4 0/3] Fix lpaif_type and DAI configuration for I2S interface
Date: Mon,  8 Sep 2025 11:06:28 +0530
Message-Id: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68be6b8d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5HF5tzHaENt2U_M8s7UA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: rVSTeObEXQHQgxJeyVbFRQ5yWNS7LrOa
X-Proofpoint-ORIG-GUID: rVSTeObEXQHQgxJeyVbFRQ5yWNS7LrOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX+1QsSLnhpLK6
 7gXHrN4pCpRcHGa1YB5VMgk3Dk2BqnNKHohrpRGvbWJI4NPb3NL/hBgDsxwg98gtyP88ndIscPb
 8bl+03CTK2/80C9twPSQNu/PRblvgBTN701pjNN0w6hGJ7nGmvrJeJNBE/y25udxmL7KNfrCb/c
 JD42d2sU3YcMq8C6sxC3WdYk29BB9m3SGrmA8Sz991M6mk/i6gh62fYJx5aO1c2Owkpr6cKMt2K
 MQqMDMq39ymXOijoT9R5f4MvUE3n2PH9FZLxCww/Iq2Qt3Eu91KPCJMk+2lFUPErstpmPnPyXJs
 uD8vt+yeLOEE0TJKqeONcG1/RznzG47lnTUKU6vfEOryWp3AWAMtk2BMT5TyFveBLxYA8t9iwIg
 CNYt2ijf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Fix the lpaif_type configuration for the I2S interface.
The proper lpaif interface type required to allow DSP to vote
appropriate clock setting for I2S interface and also Add support
for configuring the DAI format on MI2S interfaces to allow setting
the appropriate bit clock and frame clock polarity, ensuring correct
audio data transmissionover MI2S.

changes in [v4]:
	- Updated commit message in patch v4-0003, suggested by Srinivas Kandagatla.
	- Link to V3: https://lore.kernel.org/linux-sound/20250905150445.2596140-1-mohammad.rafi.shaik@oss.qualcomm.com/

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
  ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S
    interfaces

 sound/soc/qcom/qdsp6/audioreach.c       | 1 +
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 1 +
 sound/soc/qcom/sc8280xp.c               | 4 ++++
 3 files changed, 6 insertions(+)


base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
-- 
2.34.1


