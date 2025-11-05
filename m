Return-Path: <stable+bounces-192479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB2C33FFC
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 06:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3EEA34B35A
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 05:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82E26F2B6;
	Wed,  5 Nov 2025 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hP2v/6CJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idzNo682"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675026F289
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321671; cv=none; b=cKhgO3qFzQRH4RIM8EtfxQPx+RoI1H04uoa+M72hgjlwztPcC7AnREluQv06qmlhR3meDSV+Lax6XwflRSy9UVXPaWXdfM1LBejv0af/9CXTq/51Iw/r9iKRQA1VfRJbFdRhtMMELTeHiAJmR2EJ67StmQcU90tnHQnXrJaBTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321671; c=relaxed/simple;
	bh=CmCMkFGdjKimc4a8I9wySoXS+kBG+D4uHqlvimyNf3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JSH4tLlIYH9gQ6rHpytzQojblH11v45SGb6YWOPfot8NSgrDlbfxUedZfGhU5w5nlmQ/dVBnVSDLTlEXbXzGRPZI30Grb2YybIQUVcHqrl2E0jn7akD5S+HCn8e+zk8DyapiSiASepDDE87QUt8yai7anCXjaKqqYk6IzwktQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hP2v/6CJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idzNo682; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4KfpEL2904354
	for <stable@vger.kernel.org>; Wed, 5 Nov 2025 05:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=83MHbwvzUZdEq/T0F1dNJV
	sVheiPbFtUJACtWCcmOL0=; b=hP2v/6CJoe7LpamhAy8MczphHmxktuMddW8dJq
	GH0RDq5yfTT9+Jcf/Uf1vyB6r8RJybUJhqetTLrO5TwWyc0fdC3eN93Mxg7iiMpY
	2aLaxqPMPTyLiFzWlSxUjlhYIW5fLqsielQVtyvwJQfuCdyRPF8iA36DfwSssvFm
	lQpTPwNQr273YTn7Lv+UMEYo5Ykvw9H3U9OhuacETCkx86XBcv94Owv2598dnuoH
	UGqEl41oojuUpKWcQSx41MXSwbX34cRC1Bqup8x1URdc5yv+nF+52VCtPjl4C8bT
	UdEqTblZ9CK5yMQzOIaQ9wqIupXOxnrmq6fiRiL/wGZDmH6g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbt6mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 05 Nov 2025 05:47:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6ce1b57b3eso11360997a12.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 21:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762321669; x=1762926469; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83MHbwvzUZdEq/T0F1dNJVsVheiPbFtUJACtWCcmOL0=;
        b=idzNo682smXfIO00ei/wDUjq/GoWumW0II3CfRpKF6l6QV5wUxaMJ6guDr2XRXA51D
         8DTs2n6pHT8ep25Pn5l0d1d2JsNEwSWSGiQImev4gzQVndznlUJSguhlu6sK3mxc9TA3
         3tra5Pr11RD53AZXvRJlJpz2TsHIPKPPr5g1Jb/iHdSQfNz95dTlQSO7xQawsg9MJJtv
         mwdlik7lf3fa+dez35glUWFnQiQhxurs38GfjRJK4BAsbcIs5JY/+kF4mUsmtjgd7HTo
         RSlfEaXj8fbNM0CVoWSSYZaJ7pS372LHA+9gPicGs8cRuH5TRs1lYwEP0hMN5ESPedW+
         2+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762321669; x=1762926469;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83MHbwvzUZdEq/T0F1dNJVsVheiPbFtUJACtWCcmOL0=;
        b=frkkuVvX35+1EKwDsGQTMEIJ1CnUsFeKnzuFPt8Kv171AVvAX/p3YetDEcU72+8BPU
         m8zoYErI9/aNKRsI2jfBfyyRz7qKF2t52yZmfmajuXSqCpHFwtEF7dPBY3mbLP2RY8wK
         pGwzp5hMu0B6n/mvGw9u5hsMQlHmC+8+o4aajNH1khrvJR16242H4MoDkP8WpFQu5R+Z
         B4TiMCnlvO+uhRlF3luCunYyd23MF3EbPIHbU1QsNpsmORYrqJEgBvEuUD6smN+BMpD0
         DNunptoFzoYRjfeFMUN9O7fNZmzr7mQX3cQRNct8nflnog7+uYxEMsXXzx/GCsCX1+dT
         1NXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVptc4aJH2366BZx+lqK/4JumQmDP09gATC2AGm+FfoE/661MT4y8TFFPULdtbUK5qFmQitORs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmWyKyoZrh7CAuPqxJSBpjYoTSdGYvpY6mdkb/0F4Ntl11p/3
	r4ZFUZo/ir9mdyxPVvl46jJRwqR6FMsbSwYMsh2DUQWn9RZne5g/u1YWyi+a50TwHOmDpwIN3m5
	lC8UYFqMbPsLE4GhkvCezCvllFjv78tLgIYRrE5FizrNXchXC1EpcrOxgyq4=
X-Gm-Gg: ASbGncs+CbjDpoMyZVe/KeuzpQFMj000zBxxn+6TAO2+0yOSY+4kcWEb31CAl2Z1bNi
	Qzbzt9YDnqjbm4CN2m9YsuGKBESmB3a9o1n+Hbge5RNKQspg19EL5ajftqgwNKTSR2n8kusHcKc
	IW7v5Kdcrx56fmIQKwqR2t66aKkfVnNRDkVpsyji4YtrCnyviOP2ZJz8v7rb0Epk07hXEtlrl3L
	trmegOx52ySzUY1u6/SNWRZatSHgBra0QHVP1HyPsObT9M1yb42UcFpECVAtM+mp1k5b8QEYPnh
	59p600CK4DwadN/nB319zqiZWholppr2RiqdpgK988FGooNYTf6j9zw21PIUe7WOlwFIESWUHWd
	mfUOWJL9kZmqJyFrO9bj2Mq9QYtqfpiJU+Wbo
X-Received: by 2002:a05:6a21:338c:b0:343:70a2:bca9 with SMTP id adf61e73a8af0-34f863015bcmr2554578637.53.1762321668659;
        Tue, 04 Nov 2025 21:47:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHox9k7eKy6idJXRpDoSZegqgrG1eKq8dcvVFuh9rbDGp7JdOle1rYXMTc1Nt5mZN8yZZBYzQ==
X-Received: by 2002:a05:6a21:338c:b0:343:70a2:bca9 with SMTP id adf61e73a8af0-34f863015bcmr2554527637.53.1762321667890;
        Tue, 04 Nov 2025 21:47:47 -0800 (PST)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417d40da83sm2090203a91.14.2025.11.04.21.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 21:47:47 -0800 (PST)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 11:17:37 +0530
Subject: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPjkCmkC/3XMQQ6CMBCF4auQri2hUyrBlfcwLko7lYlCtdVGQ
 7i7hZUxupnkf8l8E4sYCCPbFRMLmCiSH3PITcFMr8cTcrK5GVSghKgkp0CRR8Qzd/TkjQalHYD
 TClj+uQbM8+odjrl7incfXiufxLL+k5Lggm9tp5xC0TQAex9jeXvoi/HDUObDFjDBJ1J/I5AR0
 1ptULZdLe0PZJ7nN5K6X6H2AAAA
X-Change-ID: 20251103-iris-seek-fix-7a25af22fa52
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762321664; l=3061;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=CmCMkFGdjKimc4a8I9wySoXS+kBG+D4uHqlvimyNf3M=;
 b=/iFaMOhCzLvfIlk8VviJtF0/+OhwhDKTGibbWsNNI5IWpqKCpPs8jIxaHpqoL81h1K9ORp80m
 wtfel3d5xtbAbV3c2ILDXNRq7K3CcdT6BhZN7I/JWMbXqdVTj4NZM8p
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-ORIG-GUID: Pw_neJU_Lp7U_Do5N9TxFk-Wbe4XK8by
X-Proofpoint-GUID: Pw_neJU_Lp7U_Do5N9TxFk-Wbe4XK8by
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690ae505 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mRoNVkTk4HY_DrcNXJoA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAzOSBTYWx0ZWRfX7yKFtLK9wOZr
 hPAL/rn+AAce5fjSGwbjrcD/y1RSG2agjo3mVo4A3sOm35TBL1u/M+9zshgqnAihr9tDXSiuKMn
 oBCxNsEq8TFzyF87/L6zmMzKnyFcWEb4gtC6e4wCJuV3kuDOs8MC6AU9xGe1LQzVmrMd5cgBRck
 ybekO+4noEipzdLgyX0gGirD27qIpT40eGbsU3XAo2LN5QhMZDmQM1tSZE4j3LdtQxcqrqmAE7T
 sNCmikr2XUTSeIrDpcgeXnrng4i+cjTw+yMRehaw8Ll1JMweMxlxtDt52I26vYgtHDcRnMUzSL4
 j7r2IkiFlR3Lbn+H9DFA7CKixSiX4srqOGsBkwx0R8LhtZ5bZT1KhMc9XoTpDNKEP2WvEIlV3zk
 V+isybXMcq8JgfbTJA8G6MQ+G/+KWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050039

Improve the condition used to determine when input internal buffers need
to be reconfigured during streamon on the capture port. Previously, the
check relied on the INPUT_PAUSE sub-state, which was also being set
during seek operations. This led to input buffers being queued multiple
times to the firmware, causing session errors due to duplicate buffer
submissions.

This change introduces a more accurate check using the FIRST_IPSC and
DRC sub-states to ensure that input buffer reconfiguration is triggered
only during resolution change scenarios, such as streamoff/on on the
capture port. This avoids duplicate buffer queuing during seek
operations.

Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
Cc: stable@vger.kernel.org
Reported-by: Val Packett <val@packett.cool>
Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
Changes in v3:
- Fixed the compilation issue
- Added stable@vger.kernel.org in Cc
- Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com

Changes in v2:
- Removed spurious space and addressed other comments (Nicolas)
- Remove the unnecessary initializations (Self) 
- Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
---
 drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
 int iris_process_streamon_output(struct iris_inst *inst)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
-	bool drain_active = false, drc_active = false;
 	enum iris_inst_sub_state clear_sub_state = 0;
+	bool drain_active, drc_active, first_ipsc;
 	int ret = 0;
 
 	iris_scale_power(inst);
 
+	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
+
 	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
 		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
 
@@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
 	else if (drain_active)
 		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
 
-	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+	/* Input internal buffer reconfiguration required in case of resolution change */
+	if (first_ipsc || drc_active) {
 		ret = iris_alloc_and_queue_input_int_bufs(inst);
 		if (ret)
 			return ret;

---
base-commit: 163917839c0eea3bdfe3620f27f617a55fd76302
change-id: 20251103-iris-seek-fix-7a25af22fa52

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


