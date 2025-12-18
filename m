Return-Path: <stable+bounces-202933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D03CCA8B1
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 796DF30173BF
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601293321D9;
	Thu, 18 Dec 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZpYgtOY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQB79mov"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0273321C8
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040903; cv=none; b=I8jvr0dvVqmuI/tv2Xzs90NkOIXH7Qo3rJ4+fPcLmIdio+PR0KP07FW31xjQY2HkvKNuxe6t9dnZ7y2WdD1wMqn8VWFY69KF9mNNQoekfvZK/lpCgN7KClMm9BEFR6Qoj6Hw757e3QnazAt7epr42UXJoewsLRaPh2sajYABtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040903; c=relaxed/simple;
	bh=rbEDD36jASrBCl/inVwYGt+KCW8wjtYmrIDNoGY3eCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RnWMVLqWf293lX8EhLEF7k2vMzQRQJkWXBVSLgZEQNo2WIXsIs+8nu2ivPIkepEG4GH4AkWWeP+tIlatSs50HyVJ9BROZoLt6Z5WuBUFjrKHXLctsUUFiRlz13mXl1pH/oKFTK7gWXHZAVfZ4354xDZGPq7eJGWZebYLmlTapzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZpYgtOY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQB79mov; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YQeO680343
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vYZ64icdSYQ+AkCDzWGNHH
	tlAn2tu4pLhOHQ723n4Vg=; b=mZpYgtOY2GBzV/zjtTHa5NAmRPX173UAzvZjBy
	QTbM8KBWvdAiKEZacwaY+xKAPaix9QZ6KOekW/K+Kg8dpIawYE7MMzDYpsWBo7Gv
	6IT+AisGm/kxd33CigsW0s/ReoyvMfXOzOR8/xXJ5f/UxqEuTkth5eFyIA3qpyUO
	6KkvwLR1U2qq0jOhp7RzQSiuDNte+kvmbQncIA95To+RcTCoGVh2VvvBg/3fIrwu
	gIqkHdSRa/ZUAp2KQAm97NHK5JKZpV20MWk6txQoy7aRHkp1n4gf7PBk8UxHsC7c
	RVxsXkM1CtuES7W3sv48Aj7/XZz+Z8GmXOl5td2DQU/R3KFw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45bhh5nr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:55:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13be531b2so7381275ad.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 22:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766040899; x=1766645699; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYZ64icdSYQ+AkCDzWGNHHtlAn2tu4pLhOHQ723n4Vg=;
        b=MQB79mov7zKkVgnPl7zGHFasfYGhc2y6EHTqVx7mHEcPnzzIYwRVsjiQrFPOBKrC+m
         zmOmJckV2nPc2wPKkQ8O2EbdRr4tsTA8alkSx4UFGJ3akXI903BGlMx3803qvdnFta3R
         48wRkVoLUwF0k0i9TQpLdNXaL8QTPTUKV+cERubM3Od26Gtc71jquDHpGHTnYhNRhPbB
         hv+KBsyoqHIuW+XArQklnEE+u7NzJDNqnCNMF6Nx1Osgj19mAr2pT/TG7p/+HQhmzHuf
         qn6kD+fEJoW0QlkXc1n1cC6jMB9WlJ8wYJf6Kuxb6FYq05MJFl0Nt+woH3cQNx9J/E66
         6yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766040899; x=1766645699;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYZ64icdSYQ+AkCDzWGNHHtlAn2tu4pLhOHQ723n4Vg=;
        b=JfOcE+F9lQpYd0qLPCUoY/e2gSTYZ/cWCdtmkbrGygsNKTujfRpalbiar23eIEYC5l
         r9fVJzvWLs/MiAZHbplZ/IJR20V8C2xz75zCQijSKyM/Kx5rWvwyzWVo9Cj0FPwD7EXx
         jdTO8WZEzPkJI2/cBxx6Y+VCe5eXqsnRNq+dnKlcWPFJN00950I3DC1hofbkk8VE9khy
         VKVpV9InaEOoZJ5y1sKRE78E47/IIDVXsZs73AhJNNmCD1ghH12lYJ9Adyi3YipMDtk/
         M1g9dKM0pTU4QoNRTrEcXPcft8oN3fXaMkTjVhsQE8W7L/tmJYJjmnALJOEXI+xGIEJ0
         wQag==
X-Forwarded-Encrypted: i=1; AJvYcCVHezzTbYBgR6qsyTX7eQdbv2yAA6dkMsnexvnyEFGVqO5qqZTCHfaQczQdMekHu89lZKmMX2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YycU6VVp7k1JdDlq70nLRs3mmGDcqJVzuNK8kjKt+tLgMeW1iQN
	ZPi7i5+A4XMBzfucBTIAJfJJ+YKvD3jafrp6kZj7Je4BZMXYq+w9mKlmIna3JOVO8NbNSvbzkAo
	nJUFYzlxJ936Pi8WFJcXEkcUJb/20ujgqnzDQ1aCbmk69g/EkS4WXWp2eC5E=
X-Gm-Gg: AY/fxX4XXH/tS3J8W/HHKncY7FhLEBtcfZb4gaZFANhyG6JbFbzMOncPLLQhgJ3sYm3
	UBCU251qtdVULq5YXfY3CWMs/o+Dt3T3SmeAAcbCX4Eb7b3Tdmhvfcn3RdpwZ5sZq/0Lw3bR5yx
	2Zl5RdFcMgsOvbkgLgzP5P4U4DhZoh971Wx8jpmD2zANjqu1YtD5xiZbv7uWvjKcVYBNVL1PyYN
	rrZbFakgh9ZaF5/IzzxoUM70xg9RLT5j46JFdQITBn8HrZ++uN7kTBHFuIynytCCYCWd0Ork3FA
	l8zEpLQMWRlvmhdUz6zV1LGfIWDAP90Svl7N4sy/S6ztmzven4RvoR2rIGy3/V0np8mQPkOt6yZ
	xmhXOAecz7XfAw+yhq2Hcn+pxSFPAIOa54o/2iYaIIlKFQYs=
X-Received: by 2002:a17:903:2f48:b0:294:def6:5961 with SMTP id d9443c01a7336-29f24369cdcmr207080875ad.45.1766040899409;
        Wed, 17 Dec 2025 22:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU9qxYFliNjHJ3rbHtvEwbG5O+EDTbZ07K2BEHRatSydrVbya60iDhkn4/AhPf4OdDUEVerQ==
X-Received: by 2002:a17:903:2f48:b0:294:def6:5961 with SMTP id d9443c01a7336-29f24369cdcmr207080745ad.45.1766040898944;
        Wed, 17 Dec 2025 22:54:58 -0800 (PST)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926cecsm13784975ad.74.2025.12.17.22.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:54:58 -0800 (PST)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 12:24:09 +0530
Subject: [PATCH] media: iris: Add missing platform data entries for SM8750
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-iris-sm8750-fix-v1-1-9a6df5cd6fd3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABClQ2kC/x2MQQqAMAzAviI9W9g6h+JXxMNwVXtwygoiDP/u8
 JhAUkA5CyuMTYHMt6icqYJtG1j2kDZGiZWBDHlLtkfJoqjH0HuDqzxIsaNgnTN+iFCrK3PV/3G
 a3/cD9tvg52EAAAA=
X-Change-ID: 20251217-iris-sm8750-fix-2d42a133058d
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766040895; l=2070;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=rbEDD36jASrBCl/inVwYGt+KCW8wjtYmrIDNoGY3eCU=;
 b=XgVKkEx9SZoOHnRPFRpUdtComxczf16qJZuFK6w2D4FczTWPTcaHMuWDvOXbHHO4cbugNAuse
 CggP6+6hUZBDr+MNnUtEWOG9MWcWU7IRS8K7zSAkCfI27aWP7CUD1KM
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-GUID: n_tXngpWI-08tDBL1sSqKo-ghYgQQpow
X-Proofpoint-ORIG-GUID: n_tXngpWI-08tDBL1sSqKo-ghYgQQpow
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NCBTYWx0ZWRfX855q/Ic1ZYV0
 t2MfGbR/3bp+Qh1/CnCuDwFQMgAM5NeHEDRY2ZKhgViB30L1ijqZOJPLSHzp4Ozbcn7RU56xGt7
 Pv3qrB0nFszESfOBkhjpZ0cd7BYGnE0cgfLv9C684/pm1H7dN2sBtsyWRAo9D3VG4cYq83ZABdH
 bZVbsKCw+Hy81k8TuQ7+hKYkw7MuS0NIxrTbXSHQJDVgVGxBGn2jIRZ8YJPEjojRG+iH8G4Uv/P
 gaT4FLAAmDZ3987UD67GMtXnDFfGc4DYlAfgkH7PneW2VCdGQWk8p2ItWmZabB2AqARtuA10/5w
 U/hcDSC+b4B8ul5lDipjOYSxLAu6uziBVHvkn28s3jQ+Nkyms64H8IGc4tJE/JIxEgu79ounH3b
 wUHvt7CR/sP8xDdNWkwHcvbsmfhHzg==
X-Authority-Analysis: v=2.4 cv=SZr6t/Ru c=1 sm=1 tr=0 ts=6943a544 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LTTLJIunlERdK2HIRzsA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180054

Two platform-data fields for SM8750 were missed:

  - get_vpu_buffer_size = iris_vpu33_buf_size
    Without this, the driver fails to allocate the required internal
    buffers, leading to basic decode/encode failures during session
    bring-up.

  - max_core_mbps = ((7680 * 4320) / 256) * 60
    Without this capability exposed, capability checks are incomplete and
    v4l2-compliance for encoder fails.

Fixes: a5925a2ce077 ("media: iris: add VPU33 specific encoding buffer calculation")
Fixes: a6882431a138 ("media: iris: Add support for ENUM_FRAMESIZES/FRAMEINTERVALS for encoder")
Cc: stable@vger.kernel.org
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_platform_gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index c1989240c248601c34b84f508f1b72d72f81260a..00d1d55463179429f2ae7554546dcbe4fb1431cc 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -915,6 +915,7 @@ const struct iris_platform_data sm8750_data = {
 	.get_instance = iris_hfi_gen2_get_instance,
 	.init_hfi_command_ops = iris_hfi_gen2_command_ops_init,
 	.init_hfi_response_ops = iris_hfi_gen2_response_ops_init,
+	.get_vpu_buffer_size = iris_vpu33_buf_size,
 	.vpu_ops = &iris_vpu35_ops,
 	.set_preset_registers = iris_set_sm8550_preset_registers,
 	.icc_tbl = sm8550_icc_table,
@@ -945,6 +946,7 @@ const struct iris_platform_data sm8750_data = {
 	.num_vpp_pipe = 4,
 	.max_session_count = 16,
 	.max_core_mbpf = NUM_MBS_8K * 2,
+	.max_core_mbps = ((7680 * 4320) / 256) * 60,
 	.dec_input_config_params_default =
 		sm8550_vdec_input_config_params_default,
 	.dec_input_config_params_default_size =

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251217-iris-sm8750-fix-2d42a133058d

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


