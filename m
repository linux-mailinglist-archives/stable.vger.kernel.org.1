Return-Path: <stable+bounces-164729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B2B11CE9
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 12:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3429E4E6669
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402C82E3378;
	Fri, 25 Jul 2025 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mI958Yph"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E77235BEE;
	Fri, 25 Jul 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440935; cv=none; b=TqjN69dNeSkxQbFhucKX+fO9F2BF3osVh6MCevGm768fX3XDflSxjXMyBfYBs6+fk1r3eiPk9eRcKlgzK/HY45lZmKdp3JYfHBU6F+33XWJd8di6/VRnStU9i/arscR4zhkYZGEl7Y6Lzk88PAnjbEG13CK+nErfUXNV7Qi8rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440935; c=relaxed/simple;
	bh=FV3sPRKNK25JPb11cn1GZ9yXBPA9EbM4FunPnrMSFgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tl+jnXSA7/VHdY7aC1l/eHSuY5WA+hwptARIxyUJgYnz6SxqiaLkCC2LgBWA1eE5w9cvWbE8QA9i+tKQS2XDVJrW6uyR5B122EtcONJOTw2d3QgnkY/u7bF0mbPduoeG8/eNMk4NVuM0D3KrbJ/zwprUW0oF4zXOAyMdkuArY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mI958Yph; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9eHjV025906;
	Fri, 25 Jul 2025 10:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7F4LxjlwdKshBjbFkXpssU
	iEowkTd8VOY2k07fpuMOk=; b=mI958YphyKXACixTRRJImb2q0Zco68IN3ZnvJs
	bDvWHgfYGT7vkKwZQ5zINwEl7m8GfSsXltZFyMpFslX+Wh8hH+yd6X3D56zWf1sq
	AKzZ1dgFq8H9G4m8zNKdnfO/AbjyHACqdolSmOY/8t6lE9BQ/h5LR04hO0+Fa7Te
	A7a+AnC5STdywyQvITDgP5dFoqePbgt32owV179njtuBO9kpSzWpor52oo9PVb/3
	imZ6QTBS/8NC4WpZGpLj06AsPuT56YJHhw8h5Tt7Mrv/uV3Nty+82Fa5gcHVEQ/B
	AW1bJi4Pcpb68+QIT+ZfX9u5EDVi+vhYlwrREf6SG7ShYtbw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w30ss5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:55:26 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAtLos014254;
	Fri, 25 Jul 2025 10:55:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 483t7s3cw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:55:21 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56PAtLHe014238;
	Fri, 25 Jul 2025 10:55:21 GMT
Received: from hu-devc-blr-u20-c-new.qualcomm.com (hu-hardshar-blr.qualcomm.com [10.190.104.221])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 56PAtLqP014235
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 10:55:21 +0000
Received: by hu-devc-blr-u20-c-new.qualcomm.com (Postfix, from userid 3848816)
	id 8E8C420A2A; Fri, 25 Jul 2025 16:25:20 +0530 (+0530)
From: Hardeep Sharma <quic_hardshar@quicinc.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Hardeep Sharma <quic_hardshar@quicinc.com>
Subject: [PATCH] block: Fix bounce check logic in blk_queue_may_bounce()
Date: Fri, 25 Jul 2025 16:25:13 +0530
Message-Id: <20250725105513.213005-1-quic_hardshar@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=WtArMcfv c=1 sm=1 tr=0 ts=6883629e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=6abORDSa23aJwOuxMHkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SLAgiKus8ruLiNwgZQld6zoHjaLtgpfu
X-Proofpoint-ORIG-GUID: SLAgiKus8ruLiNwgZQld6zoHjaLtgpfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA5MyBTYWx0ZWRfX78I0WPPXXBk1
 Su0tVs+HQ/jz896O5go9TUF9pYCaCcxpMvpXpfv2f8EmtRERjmL8id//UKatKnJGDUfKn5XKYJS
 QBnihWLydQ7Mp7PTV+9oqgsK/RB6scWabRf7/HP6ZyyW8PlbAULYSStfQ14TobkZRy53oECiFSD
 h/pNN01Wwl/rVRs5VDO+50P7X6tR9QjLsN5jeJEPCDyZdGThGS8wDhzapyzh2STqo/4lmcV2Jd6
 S200ebs9wP3VcMXs9t+Xt2CkSLaI7ZcDAlNGaIAnjgufQWSkUe7u0EbDsF2S3oC/ZbcV02sXkju
 qCc5cnoA85rSxBGrMY3vh4n6Lg9VQcanAPBD15mw+qk5AQA3UxfRjs93T+nV6n1YAx7vgaUsr6A
 kRiok15ne058XjZbTmZDtX7k77QB3LzaeDW2NBwe3g0gqi/3m9rnXVz3YoyO5XLFzbC1yZ8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 clxscore=1011 mlxlogscore=659 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250093

Buffer bouncing is needed only when memory exists above the lowmem region,
i.e., when max_low_pfn < max_pfn. The previous check (max_low_pfn >=
max_pfn) was inverted and prevented bouncing when it could actually be
required.

Note that bouncing depends on CONFIG_HIGHMEM, which is typically enabled
on 32-bit ARM where not all memory is permanently mapped into the kernel’s
lowmem region.

Fixes: 9bb33f24abbd0 ("block: refactor the bounce buffering code")
Cc: stable@vger.kernel.org
Signed-off-by: Hardeep Sharma <quic_hardshar@quicinc.com>
---
 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 67915b04b3c1..f8a1d64be5a2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -383,7 +383,7 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
 {
 	return IS_ENABLED(CONFIG_BOUNCE) &&
 		q->limits.bounce == BLK_BOUNCE_HIGH &&
-		max_low_pfn >= max_pfn;
+		max_low_pfn < max_pfn;
 }
 
 static inline struct bio *blk_queue_bounce(struct bio *bio,
-- 
2.25.1


