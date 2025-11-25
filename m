Return-Path: <stable+bounces-196863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F52C83658
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 06:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 391B534BEC7
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C528466D;
	Tue, 25 Nov 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bl2EmNKN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FI9eFBHw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F01DF273
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048869; cv=none; b=V/lljQsnsl20lEEvp7CVrxIV2w9ZpnRaPd1eTHr9qWzVIMFeu8VbeSVRDl/Ik6QQxoQWqRtoadtJPFd0Kk91VJBHHLbXO6/5WKCYWAutUrP4z386ykGYccCZemy3F/xSrouLi50k6SCoI9skaS/+za3wQZaXPbfRc7rhskC74cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048869; c=relaxed/simple;
	bh=r3O+2ED8l46eo/i1u0pELvC17W+YuHOhwVbpWxEnJkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FRYpAPTr+idFCEeE7cpPPIJ99tb7HODGJgMeqvK6OmoYDmxxPd8w0/l2GT6elaNqLVcY24TQVaH8mLb7ki4V1c+CrYp4VkWiNh+nWphnzHimeedM/D2ZutrWq+4h+xgFvgZKLJTjjkcrXY1owOG5fDRzF670Jba42G5OCr9diwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bl2EmNKN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FI9eFBHw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gqBi2149247
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ssugvbgvSG7d3SC1KBDZ/I
	lQ9dRG61L1cgvDKh8lTrc=; b=bl2EmNKN1bFK6U1qCep2Ja5jUawrKEpfbeDghE
	ViUZXjKOfzb4toR2ZB3bp47pRk/FjvXHvEVlwbP27sbEEZWGXWBjjkF0zRN9hqXr
	AZwgJDNNRnSS1fGm6OMgF0VSeHwXB+iYmLWbwUMbgR5dU5LUNb/M/EFOBVfcwEuc
	rnz1zZ95QNEU9bHM9PEhKznneBTlxSDrI8mh7K0RP2snsdqjLgiD4GJwGq1YGR/+
	kVEJI+9ClnOzieMKeTjh6rjTF7Ll2r5PEN+xaviaPVpvo8O853Anzvyjc+KCnaGV
	PYdjz/+evL2lakgwTk5x3iDN3u3EPnOS5I3HpOpYX50Y62Xg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amr8saeks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:34:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295952a4dd6so62522595ad.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 21:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764048865; x=1764653665; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssugvbgvSG7d3SC1KBDZ/IlQ9dRG61L1cgvDKh8lTrc=;
        b=FI9eFBHwn46SmTQYLp3wi8QOR+uxhXHPH0pjtqQTP1e8t21vj5USEPnHANNEzY5Mo9
         cHJ7s7IcRYdCZcVBfYi1n8rPTgeWQZm9LVFFF6lyGbrPxS4eR44kPVTragZGh/4khox0
         JDKijXnJA1jJU1Prn1EmpPglwlPR8c3+WcyZhxoreGwXtkEDQ1bg349n2N4az/3hqUaJ
         G/h1D76N9Rp5b6mDL8wiN0k7x1g/kFddEH76/ScjXs0eWcTCKQ3R1w+LIvkoJWABZC1q
         ORzdwGNzOpLuEC48ln+xU+adquRAKXC2dxd67MJwpW78kkOe2BRqdpqCvpQEXRgR+wcb
         gpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764048865; x=1764653665;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssugvbgvSG7d3SC1KBDZ/IlQ9dRG61L1cgvDKh8lTrc=;
        b=IcPBfu1pWPGTqTCk+TkyHMulgeiK7y7Q21K1WqAqTCDSh6p2ZsJFyxNLNQbitTVvXL
         EZsJmE9oaePo+sTqE0EXcgrAXFdjMiSc/2H1/Cp64jeAxEBN4RxUSncsAGk73wXXLGmz
         +jua4i1vgnV+DsPcYZ+LFeXPPrLaUDKaBmMi7PhPfTZAQ8LYgwXeEUy/23gzPVtMrcBD
         nuU+cgmmvcOY/p86KZnOqS6lFHXsPVA98M9JFPU7r52h0GhmDs05eEwES1YFrlM1pzfU
         rsmK1Cs2Bv3f8IktRPLABO7VmlYDuFCT0+VVHHOiJVQUsE6EnfvMXF51cN4+WyLAnBCt
         KeVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEZBjJo+MlZvtFw4BYcQmx6AvMjhnHjUlSRA3To2PL0Yc8tqMGGGdw2ADW8ebqepR56PQhNkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2joGPzSFGE0FHrVbbPNkzA0mTt013s/X/EquIyyQvsIEnr9oE
	auOivW3rZUaMe/gdkGA7JK3YuJOwaIWqdNVn/AR3o342AQjiqikLVxK2yo6bjTCnRuPe467Sm5J
	KFxNB/kQgcjFJXjj2fWmAVUr5/v+lxGRABWTS/ddHYFfNxt4wbL/3XCIaM1g=
X-Gm-Gg: ASbGncv8xA6AY7wXEG1WXuIPAPho2jjQNSDmBQET43e/hrk+NpR410Z1F+8n06YrsXF
	V1VI9vLpKJNuMu+bPYXmDxDm/tZ8kR33buTj5097GmqpboXXZfIAap6Dv3cGhSmpbrngJOzCTrL
	87G+/uoq3NA9F0FxhqyX+HLlULIAJIK53w9wo1GhF7N5e+9EXgHis/PInK3BpbeQMlztznKWAI4
	nczGi9MvSOstc52VC2bfknzbna4qhs93o0XrCrmfkr6BUaG1/SD0MBaxMoSJ/jEOgaPJBPSlDz8
	F+RBlSFaDvJnZIWZXdj4RWZ31BCb/ONhIF9LkMowQCPyuc+0llzJZkQHxVvK5AARUZS3dPcTAxC
	0zsRQ6Or/ZRzldBW2MxI6ht8ecG9KkMKhsy0fyzaCNPg+LK8=
X-Received: by 2002:a17:902:f78c:b0:297:eb3c:51ed with SMTP id d9443c01a7336-29b5e38c16dmr208832045ad.16.1764048865253;
        Mon, 24 Nov 2025 21:34:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdv8edE3hDdaAIkYsKudaPF2wQSgX6yN+qcuutIsmnFZUlSxOkKKat+tl1Nn8/w85/NxBgqQ==
X-Received: by 2002:a17:902:f78c:b0:297:eb3c:51ed with SMTP id d9443c01a7336-29b5e38c16dmr208831875ad.16.1764048864732;
        Mon, 24 Nov 2025 21:34:24 -0800 (PST)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b00e1fasm152016465ad.0.2025.11.24.21.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 21:34:24 -0800 (PST)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 11:04:19 +0530
Subject: [PATCH v2] media: venus: vdec: restrict EOS addr quirk to IRIS2
 only
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-venus-vp9-fix-v2-1-8bfcea128b95@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANo/JWkC/12MQQqDMBBFryKz7ogzpopd9R7FhWhSA9VopoYWy
 d2bCt108+E9+G8H0d5qgUu2g9fBinVzAj5l0I/dfNdoh8TABZ+JmDDoeRMMS4PGvpCMqQquWfU
 FQ/osXid99G5t4tHK0/n3kQ/0tb+S+isFQkI2pqyGxnBZq6sTydete/RumvI00MYYP4odzSaxA
 AAA
X-Change-ID: 20251121-venus-vp9-fix-1ff602724c02
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mecid <mecid@mecomediagroup.de>,
        Renjiang Han <renjiang.han@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764048860; l=2797;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=r3O+2ED8l46eo/i1u0pELvC17W+YuHOhwVbpWxEnJkM=;
 b=d0GdPcGZ4XXMeOeyU6co30VptwFlHcQolM4Rsf3EKtJmb6uPnOCV6FZLlwjhtl/AX7OL0urvp
 CPfxUmGAxKjAlpQA3QYnW5v1IHuyS94pZy1zEDbIVuTraSEOdNHW0Zi
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-ORIG-GUID: 0bx9bi7p1MucEFR_QYVap_zjVdIIVG1Q
X-Authority-Analysis: v=2.4 cv=KP5XzVFo c=1 sm=1 tr=0 ts=69253fe2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=fVowlSO3gPwIgFNTVWQA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0MyBTYWx0ZWRfXyUWqj69MEIh0
 OZ3MdKugsgydrga/AUDFCVm5uABxhl+bD2u9yKaJO4OZyDcyX8P7PNetucTEXuwoui0mci3K3kE
 cFbtE25jluSCP5xvSK7NXw/OOnZOWnQ3yI4Jp/wUObCWtvJSv+uk6Q9DrAudl1e7kVaAAYei+Hj
 DTk0k1DcG5jKEuXxcWhnT/mRbTkmmF3VahiwCu++dYVk1fMUHOg6+PzmlDa+wG0scr6pd4jOfHW
 D31lJ9yfhUuXAyHPF//PWJnsv4XMzii3RHEBCz2W+jV5j9MmKlgkdWZrN8XPM4MS2PpEb/MHyV1
 wUkMmb2Sd7pqe7UInb8ZWYYN+APq4Ey/+jZoV1i5s4EO4qv/rNDe+b1/geg/r8xMoiw/WDCfq5u
 fdZT0o/gTXPjvmDN+KeGzzqDjXXLxA==
X-Proofpoint-GUID: 0bx9bi7p1MucEFR_QYVap_zjVdIIVG1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250043

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
Reported-by: Mecid <mecid@mecomediagroup.de>
Closes: https://github.com/qualcomm-linux/kernel-topics/issues/222
Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
Changes in v2:
- Fixed email address for Mecid (Konrad)
- Added inline comment for the quirk (Konrad)
- Link to v1: https://lore.kernel.org/r/20251124-venus-vp9-fix-v1-1-2ff36d9f2374@oss.qualcomm.com
---
 drivers/media/platform/qcom/venus/vdec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 4a6641fdffcf79705893be58c7ec5cf485e2fab9..6b3d5e59133e6902353d15c24c8bbaed4fcb6808 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -565,7 +565,13 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.flags |= HFI_BUFFERFLAG_EOS;
-		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
+
+		/* Send NULL EOS addr for only IRIS2 (SM8250),for firmware <= 1.0.87.
+		 * SC7280 also reports "1.0.<hash>" parsed as 1.0.0; restricting to IRIS2
+		 * avoids misapplying this quirk and breaking VP9 decode on SC7280.
+		 */
+
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


