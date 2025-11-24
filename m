Return-Path: <stable+bounces-196681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE5C800B0
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A63FA4E548C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E572FB99B;
	Mon, 24 Nov 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2N5K9UO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e0/xiDrI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFC2FB617
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981901; cv=none; b=GfajBlnqymzkqTCN4N3QWdxTAIPtJL6Fn5Idt12FL7Lv3U31bF4t0LkUfLgJOcllV4hCKoDpCeV2X6Cz53jn5oaL9QLgOIdwBc5b9q3eGmSJnuIL+ay8WSRJtMqH5DvYOLlFfEXQGyMmz8g1JGygLnNLCBot6hSh0jrWbsihqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981901; c=relaxed/simple;
	bh=ni6nRajr/9IWgjJSJFTYnjkPbTVNkGisZH/rYykPg7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EffihWlYxG3CyjZ3vbtUi2u/HYlqTojYp6RY1Z0TUL63pgQAO2hE0s7kg7mweRnSxjtmMEd5NALjhPWZXo/h0NigjEpZ9tYtf7Q9Ry1uiPHsrt+xUqIPrvskqDCg1nwj3h4q5salg+RA3EqUtnFZomp8Hh1R2X7YA7uHHG4r4Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L2N5K9UO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e0/xiDrI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO8BkY12092743
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:58:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Dr84khA//YhdbLJpgQ2RHm
	tsBKa/OK3FcQ0pc2ZjBOY=; b=L2N5K9UOnpXn5T7+8x7rOw3u3pKANBnhgARwK/
	AooeoGJouWd9h5DLLH7GurHLb5pmGhMkKkP8OY75nMS4rvd/yjjbGi/NSb3LU4hg
	HVPbM8ll6PmSRb9UDrY5kSKSpALPOdo4wsrr7NgAqJFxQ200YjLYaVQqCn6Tc4D/
	TY/14IKS+efHRSZlqymP10st438dNj90RTtAKBqeTeQg9/IhtyI9u43DqqtYO6nS
	P/ZS6G1urelp6O43icXrxscTOvjQlx+ryxyJcR3LWA8fQBOuO+B0BFXzTffpcSop
	hxJJoXYBoi6lVYd5GKKQWG7zBrWdI+cjZxf6bP3QSKHoXyZg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak68dvq9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 10:58:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343daf0f488so4320013a91.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763981897; x=1764586697; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr84khA//YhdbLJpgQ2RHmtsBKa/OK3FcQ0pc2ZjBOY=;
        b=e0/xiDrI8mnUsrUMkwCexL+gFt3r8pmPjkAxPDqAqHayMsipm0HAWhDYVIeTBLJf5g
         E+bDbtbehTrGRi7u+g1H8znzY/JJOr4RZHdPBbhuZK+4shqu5UsQJEnD7t54DlxCLBM9
         4DEZQpL0jCrwCMtluFjoECVnO/qHZdFy0Sk0PvQ9kci8lkBxzG1q7G2Fch1sT3tkzgOd
         hmqWk+ep+5J7QnAibFKpkxuk1G3fVHVMKPolRuNLLBuReSxjY1I2ifQRy1rzt71IJ2LC
         wbx33kiO+NxmEqoHVo3ODl1jmn8S4ZnubEaU1+9+eHeH1K/bAJ1MduFrrP+VTa09dJKU
         PgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763981897; x=1764586697;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dr84khA//YhdbLJpgQ2RHmtsBKa/OK3FcQ0pc2ZjBOY=;
        b=suSZt9FaG1JzL34TlrzUfovimBZQRdcUuML1+nn7Tl0xEdV0AhF92UkXbThWm+HHoe
         SI/LBtiR0i3vkC2W9gZa/FaibBcbFB2jlojSTLaQ9iflzeMItKNoOIkynxV4QTF2DnCu
         lx4jYmUsm/HImQn9yM+5XutK6XV3xm7lLToAbLQu/OwqDwD7z4lwS07HYlfSpmEX8+AW
         oh5OYb7XUA5u3I3Q8iVKKFF9c6E7n8bguMCRTtmGpSK5BdgVLqg7s678xiHqSNV1hTh5
         m9q7+Qq8ZOtXokSW3zM1qeVMyomM3ghWY87p27qTyYiXKAmESEGYEF7veUQb/m3yuMgb
         bPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6n+Iu4CoDYvxvffFI81t5+YCiSz/Csq+/95rcw2mbZbB1uzo901CmvE96hYXLU+FPfvusPWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqNGd4d5X9gmvHSQXfyJQo/Iyqy1+lHhIOD3O2g+vKD7PBWDb
	8YNURor3+Y4Qn7lcHkMus3J8TQsHN2h/s6OHO9z0n0a4cpKad8ft0iV4c+1pITRKUH1QPUgzzLj
	32E5o3lRh4uK6zq9v/GkEhl9FsFgaYlHdC1kgwZ6h12Cvuh6cfqJnJh0VS4s=
X-Gm-Gg: ASbGncsRVIISYyBaWn79KLGL+9flBanrKKXgLujdFclm4EFo/4+PZ0vgcMnaGrtzAIt
	DT+OLqjpkjt+xqKcZ5gRCVI3pPXdoecKWUTiv374WCk126X9xQiULfHJVNHBNmKyZj94ziVY4lq
	Tc/MTHDvzxMiXjRBhDyulAP7WCEdQPrdJPm9E8zylDHZNYsaQNoJ1MPS5rOklpayHzv+w/dOFKQ
	Y+oxQQ8Qtizqan3tiw7Ijv9SNB/jHWuws1w+LPXdWaYoi4VW0IK5aYFffbQHEzE16rlZ/6thHKt
	NWcokBQC+8T51LuigT+5nZmMDdwOLl2uSivWux4POBcRcm6I8n5cXt2qZI2bHOuGgpBc8iNNFgS
	axuT5zk5VI5DXJIUrZFJRRYPeDBLvafXZoXDDqFL3S2+VFLM=
X-Received: by 2002:a17:90b:3d92:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-34733e49f05mr9391336a91.1.1763981897404;
        Mon, 24 Nov 2025 02:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnOYu6pjZZiKwrHPswD4z8R4kparPgMfKJaN8Zt5TA6m3UTgxM2gG07lNAVRU9duMSOBwuBA==
X-Received: by 2002:a17:90b:3d92:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-34733e49f05mr9391313a91.1.1763981896557;
        Mon, 24 Nov 2025 02:58:16 -0800 (PST)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-347267a1231sm13391598a91.6.2025.11.24.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:58:16 -0800 (PST)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 16:28:07 +0530
Subject: [PATCH] media: venus: vdec: restrict EOS addr quirk to IRIS2 only
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-venus-vp9-fix-v1-1-2ff36d9f2374@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD46JGkC/x2MSQqAMAwAv1JyNtAEF/Qr4kE01VyqtFiE0r9bP
 M7ATIYoQSXCZDIESRr18hWoMbCdqz8Eda8MbLkjYsIk/omY7hGdvkjO9ZYHbjfLUJs7SNX/b15
 K+QCAZZoIXwAAAA==
X-Change-ID: 20251121-venus-vp9-fix-1ff602724c02
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mecid <notifications@github.com>,
        Renjiang Han <renjiang.han@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763981892; l=2343;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=ni6nRajr/9IWgjJSJFTYnjkPbTVNkGisZH/rYykPg7Y=;
 b=jPwN0fpIuU62B3ktzcnCGs3k3HGGVIR0CGUCxGLChQkOgZQxe5d5QzaW3EI4ul2JbAtp0TMDa
 yr3e2Zyf9j2B8XamGQpOv9Hi/qRJ26lrCKWK5L8NpVAiz3/C+nJ6tHI
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA5NyBTYWx0ZWRfX0ELmlYuJT42H
 mTTGJnInO+eRm21JA8S0AMFiHlAsFwOY2Z/KIJiqhFL8uAg25SEwV5m5JkiUEYGW5ohopJ02zh1
 3BCK+qCR6Dsthh6ppxhyEAVjWY7+W6uGRorFVwfikwmgtYp3jh0tgumpHjWPDE9B+O0EJUGqF0s
 v638x6aT/uit8CxHsApgB4znj2Ow5ID8KFdS8JqoLEDsGljjwoOg25EcFFckl7gEoDXsXKsZf6U
 wYCdnyT7Xu6JoCWHG3u/cBBsy6rHM6FpADEKvWVc+U9hAZJFs47NUYQm/EQqqxJBxPP1LBWEkI1
 SX/z0EHsp1TwckWXKJ3+gI++fOxFZoDUBEYmvulZyDqDmSf86KdF5nOdZsZ1aeGHUh3A3xxaWlO
 MntJHaPU8XDCQejA50aXhbSpFVh4MQ==
X-Proofpoint-GUID: IBpPdQWH_bKh9_020TN61oGO-gl0Eycd
X-Proofpoint-ORIG-GUID: IBpPdQWH_bKh9_020TN61oGO-gl0Eycd
X-Authority-Analysis: v=2.4 cv=UsBu9uwB c=1 sm=1 tr=0 ts=69243a4a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fVowlSO3gPwIgFNTVWQA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240097

On SM8250 (IRIS2) with firmware older than 1.0.087, the firmware could
not handle a dummy device address for EOS buffers, so a NULL device
address is sent instead. The existing check used IS_V6() alongside a
firmware version gate:

    if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
        fdata.device_addr = 0;
    else
	fdata.device_addr = 0xdeadb000;

However, SC7280 which is also V6, uses a firmware string of the form
"1.0.<commit-hash>", which the version parser translates to 1.0.0. This
unintentionally satisfies the `is_fw_rev_or_older(..., 1, 0, 87)`
condition on SC7280. Combined with IS_V6() matching there as well, the
quirk is incorrectly applied to SC7280, causing VP9 decode failures.

Constrain the check to IRIS2 (SM8250) only, which is the only platform
that needed this quirk, by replacing IS_V6() with IS_IRIS2(). This
restores correct behavior on SC7280 (no forced NULL EOS buffer address).

Fixes: 47f867cb1b63 ("media: venus: fix EOS handling in decoder stop command")
Cc: stable@vger.kernel.org
Reported-by: Mecid <notifications@github.com>
Closes: https://github.com/qualcomm-linux/kernel-topics/issues/222
Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4a6641fdffcf79705893be58c7ec5cf485e2fab9..dc85a5b8c989eb8339e5de9fea7ab49532e7f15a 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -565,7 +565,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.flags |= HFI_BUFFERFLAG_EOS;
-		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
+		if (IS_IRIS2(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
 			fdata.device_addr = 0;
 		else
 			fdata.device_addr = 0xdeadb000;

---
base-commit: 1f2353f5a1af995efbf7bea44341aa0d03460b28
change-id: 20251121-venus-vp9-fix-1ff602724c02

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


