Return-Path: <stable+bounces-178859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD13B486EE
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B7E18951AE
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D5A2EA493;
	Mon,  8 Sep 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAHkHQUV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165423371B
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320046; cv=none; b=f04i/P2/h9UQ4RiUmP6gIiCEf8leoxfoVHALOBdcx0JMfjClagJrKOiU9yxQMbX8VQPX1dQKvSSGAhXm3/7k21zV5pJ3wSKVQ3D9FRVsmL5p5mcc3mAZ5FJBLI1emR7MlqAWM9qkGCo/f/ZhDmXVLe1ee37CqqYIbnB9ZkEUAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320046; c=relaxed/simple;
	bh=HOqcvWr0rv3WcAg+DTG1pbJ/S3XKe3NEf3UHxczsHq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=egHH4sb0L3DzAO3o2Q4akdTzeYppLPtmItFgr0NEdeuO84Hl851/rDpIlUfwZD0y2wK30672A2BfnIOVJRa+tZ5t8+14Nbslr+YPvX4x2voWNCWqZwlH9U47DRl55bOr2wSy/FwVdYucjV+bkqNyEp9GprAYUC4n6nSiHng0RzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAHkHQUV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587LBelr028761
	for <stable@vger.kernel.org>; Mon, 8 Sep 2025 08:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s0HdkjLRf4rWFHG8fw/KFe
	35He2ooBJYXRAeELbJy0Y=; b=ZAHkHQUV78RJbC4YOWYTKrUh+QVpBk/f+3ozph
	+yhCXryjieBw/LUqnJFcpSrRVF9BXt5r262GgEJ2ZHG4u0FlrF3YFpUtw5cJg5OJ
	fCzwyERGFdbEmcBXcw8bM1b2T4VqIU+P3WmwFlxSolWQPIi7cbJXySe6v224Uu0b
	TMHEC5tfNx5j4ic2nwAIFFGhg8SMLc8QkKJLKFkI2/APVG0jxwcYN3I5iCAqJj47
	jMhdXT8PNecCwQH7fF03+99LybjfPGMGi9jKozsKT5eNrZ6h4xBbugGZn7rrQk8/
	2FxSOQoUzyKiXT8Y/zz5lrOfX96Q6cs531yooPLspFldgK0g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3vcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Sep 2025 08:27:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-772248bb841so7515887b3a.2
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 01:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320042; x=1757924842;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0HdkjLRf4rWFHG8fw/KFe35He2ooBJYXRAeELbJy0Y=;
        b=sjqHSc+BRCQsevmBpeEg4b4s3n5Ggo+CN2wdMwPDg4lcIyCEoNOahxfxeX3wO8DUF9
         JxXJ+obG6XFxFsWyrV6PvUYVxXfZNCHo8vnLsC2Q9ohwpKgzaOFvZETQF+YLkJnYoaLb
         630Oq8xNYFXrkndrBxmSB80q3EFZ35WnAiF4cb9JqAGT9sJ5FsysDzpn3AOd5FhFHOlY
         XpPoyvoFU/Ej3DPWVbXvNyrvM6klsyfx6Qtc1wJLwiUuUCNwvAEzxb1r0EXy630Q/kfN
         MI7Eq0tUomH2TM5hAh8WylphXScSHpnS3cfmwfAl0TyXjYxtClFdEU/YVQwKpGzm6MQg
         tqAA==
X-Forwarded-Encrypted: i=1; AJvYcCWVAVFsWxZ4oR1QiDpVReNCHnHtEPU2Ci5ybfWIdghKdsrY48HY2+BTrk9ny1T9R9fRRFmQq48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsrL1pfLq0tQUU41Rb8+0UPiZgte8cSsD/aWi/gRPbk4Pvfps
	HMlje6FIRwkcqCHLGrRPPomLFei3DRzPtAlYAihcV6wOe50c6486BgbdTES5qbmrGz7yvc9Owk1
	MQcrdLMq4KcRE8V6W7YPIRcoCL3dhF16vZaO+ydvDUWtzuQxVEmiQ/04uLuw=
X-Gm-Gg: ASbGncu+oqWQj1Bywe73WefwA5dj1Y5+iZ6+zRbKJnvYmGrv9iPOacYN9SS4CI9FwPY
	aYHPI2UbnA8B4poexAEEr+ayqQOMoKb9yMnTWIQOpt0SpOHqbpkfxvU9gm3SY9FAouSpP5S06p+
	Xm5RtFeJyZoKsLxjRtZcx6OhU88mivgf0ONvYVZD/u38aLzTv9+p579EGIdBLX06KlOvLnsNOIQ
	RDdsSyMuqD20ElJ00VUsJY7NyeUiuLanG+eKYU77aO6WjD5QpWHqQfh46nokCB0tpkJ8DDewHSw
	nhlDkuqNKVL7Cv9fr6L6ClYivON+pstYP0XzgSkwoIDRpzLWnft8egXTMN3HZ/lu
X-Received: by 2002:a05:6a20:9151:b0:246:3a6:3e62 with SMTP id adf61e73a8af0-2533fab6f41mr11097699637.24.1757320041907;
        Mon, 08 Sep 2025 01:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTu6FUJWMDyx42YFJIOanrZsIeCjqwwjeQS99oYxeMrv4GV1H/SJVyxH58y7tccyCgdXQuag==
X-Received: by 2002:a05:6a20:9151:b0:246:3a6:3e62 with SMTP id adf61e73a8af0-2533fab6f41mr11097666637.24.1757320041412;
        Mon, 08 Sep 2025 01:27:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm29157523b3a.18.2025.09.08.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:27:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 00/16] drm/msm: Support for Inter Frame Power Collapse
 (IFPC) feature
Date: Mon, 08 Sep 2025 13:56:53 +0530
Message-Id: <20250908-ifpc-support-v2-0-631b1080bf91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2TvmgC/1WOyw6DIBBFf8XMuhgeiq2r/kfjAhArSS0ISNoY/
 72oq24mOZM7584KQXujA7TFCl4nE4x9Z6CXAtQo3k+NTJ8ZKKYVoYQjMziFwuKc9RExecWEN5L
 VjEI+cV4P5nPoHt3JXs9LtsZzCVIEjZSdJhPbIvGSNMirCvbwaEK0/nu8ksiRzq01bij+b00EY
 XRjVSNELZXs+d2GUM6LeO3iMg/otm37AewTYvPcAAAA
X-Change-ID: 20241216-ifpc-support-3b80167b3532
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757320036; l=3999;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=HOqcvWr0rv3WcAg+DTG1pbJ/S3XKe3NEf3UHxczsHq8=;
 b=tzHepRDApKgq5JJQo9Ne4wWNomu5jVbmaMEEEsd3Ysy12/oclkgRhp6BVffPayXxbWrew0RRl
 ezHC51sUE/CBopYK5qwpNvRerf3JydryUdyrNpeFn1Qtvhe++B9Xv9p
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX+8GWV3ui1ej8
 NFpsTbuvxuCfUzC0LQf5xUnDVyRW9LgoUafoV+8h0xKhKw2gqVb8FDwvJLpqYrm3m3LMX0a9Cfn
 1TMAEgD/w4Wq8UCNCalj/A7B82Dm9vgzskHOTwAYm69ohCUePa9mSS2tPBqEPUjsjz5XgB2jmXO
 P07EHMkLuoWk1GqrWlggyR32Bmq/ExOol4wHVW6blvWEGkB6rvWHMAU2aOOQeNnrCURRkf1MHSL
 6dm+sajL9W6Ze+P4CwR+aauK0eKdWedG6KSZ74OSJenJNctRwcUZXCoXodXsH6sahmorjeEta1e
 HkGk/aubHhsLNmHNU5qUNoOmdTJNC1r95dJ3y2zOF5fGKAR7nUTDDbOTzMBu9bsVvNCZpa/a87f
 /GAIsd8V
X-Proofpoint-ORIG-GUID: v1mW37BHa9cCrRJrY8Ert1wJImautzvv
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be936b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tVI0ZWmoAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=e5mUnYsNAAAA:8
 a=sLhxGqmu1eV7p1u-_mQA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: v1mW37BHa9cCrRJrY8Ert1wJImautzvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

This patch series introduces the IFPC feature to the DRM-MSM driver for
Adreno GPUs. IFPC enables GMU to quickly transition GPU into a low power
state when idle and quickly resume gpu to active state upon workload
submission, hence the name 'Inter Frame Power Collapse'. Since the KMD is
unaware of these transitions, it must perform a handshake with the
hardware (eg: fenced_write, OOB signaling etc) before accessing registers
in the GX power domain.

Initial patches address a few existing issues that were not exposed in the
absence of IFPC. Rest of the patches are additional changes required for
IFPC. This series adds the necessary restore register list for X1-85/A750
GPUs and enables IFPC support for them.

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Antonino Maniscalco <antomani103@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Antonino Maniscalco <antomani103@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Elaborate commit text and add Fixes tags (Dmitry/Konrad)
- Document GMU_IDLE_STATE_RESERVED (Konrad)
- Add a memory barrier in fenced_write
- Move an error print in fenced_write to after polling
- %s/set_keepalive_vote/a6xx[gpu|preempt]_keepalive_vote (Dmitry)
- Add an "unlikely()" to read_gmu_ao_counter() (Konrad/Rob)
- Define IFPC_LONG_HYST to document a magic number
- Add a new patch to enable IFPC on A750 GPU (Neil/Antonino)
- Drop patch 12 & 17 from v1 revision
- Link to v1: https://lore.kernel.org/r/20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com

---
Akhil P Oommen (16):
      drm/msm: Update GMU register xml
      drm/msm: a6xx: Fix gx_is_on check for a7x family
      drm/msm/a6xx: Poll additional DRV status
      drm/msm/a6xx: Fix PDC sleep sequence
      drm/msm: a6xx: Refactor a6xx_sptprac_enable()
      drm/msm: Add an ftrace for gpu register access
      drm/msm/adreno: Add fenced regwrite support
      drm/msm/a6xx: Set Keep-alive votes to block IFPC
      drm/msm/a6xx: Switch to GMU AO counter
      drm/msm/a6xx: Poll AHB fence status in GPU IRQ handler
      drm/msm: Add support for IFPC
      drm/msm/a6xx: Fix hangcheck for IFPC
      drm/msm/adreno: Disable IFPC when sysprof is active
      drm/msm/a6xx: Make crashstate capture IFPC safe
      drm/msm/a6xx: Enable IFPC on Adreno X1-85
      drm/msm/a6xx: Enable IFPC on A750 GPU

 drivers/gpu/drm/msm/adreno/a6xx_catalog.c         |  71 ++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 105 ++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  14 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 221 ++++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   3 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c       |  10 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  34 +++-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c         |  40 +++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h           |   1 +
 drivers/gpu/drm/msm/msm_gpu.h                     |   9 +
 drivers/gpu/drm/msm/msm_gpu_trace.h               |  12 ++
 drivers/gpu/drm/msm/msm_submitqueue.c             |   4 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  11 ++
 13 files changed, 459 insertions(+), 76 deletions(-)
---
base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
change-id: 20241216-ifpc-support-3b80167b3532

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>


