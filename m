Return-Path: <stable+bounces-127291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F1A774EE
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61B97A2E30
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99F1DEFE1;
	Tue,  1 Apr 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SXP4bdwQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44A2111
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491593; cv=none; b=phZthgSO0TB2lalevQEsfbN4vzMScZVTgG6WBPWPVScvXJc5TypZpJ4wcpw9/+Ibc+g93oYmJS3bGIHkrPR7QU183wxghJr4tHPiAcBWQgo4yNgeyKPKq6BoD12YrNBWjneAfnGHsC4Zi78mmu2f1C90zoNQUnCDnT0/s3mDMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491593; c=relaxed/simple;
	bh=Cnywng0WZ+MTsiWZZcgj53aluz/ug8MWYgzZdbCRVXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qC5dF677E5khwAoKFNWZy7Pt8Ke3MBqJSSmQS0iCY9+6ZgdhUIQn76ZcsmSrhgEv67wxvEIOawTQvD7jamI3ZIzky/3FePfkKn7YUn5G21onCsAG47ha9j26oFwf5Hh2HvaswpjDkuxrgnkJFqQ+39TZizViPCazKnsynClFR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SXP4bdwQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531694Xs024710
	for <stable@vger.kernel.org>; Tue, 1 Apr 2025 07:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XdB1kgWI/boUn3AOo7kuAo
	xxATnSvSY7HIkworsR2s8=; b=SXP4bdwQ1b0E/yZLMBfJhsNTp/sV8ZRRgEXxPT
	CPGAiZ7qlSitotihK5xb4P9wBDKmDuVUc/S8g6h//bIEJEfsGpOv+2s6AXmxuVf7
	bt/CoAx4a/vcKHYnd5Hn1vhw9Qvhtjuozy+OJBwceUOSt05OTGiSj5kMHGucJ26J
	BRzrI5pCWtyjJ5DtqekiVGlG18WcSy3wLsxEfd/oSTrKG2egk46IxmOg+1uUzjqf
	0ESeCm3Z+eQqztpA2Jqo69JWNiGr4QA7pERSdM0FDsVMKpn2OP7D26hH8J9CUZnB
	xfOn+roc4mWFx+ZgRJpnrxpjXkZPOC2+fJe006G87eO78u4w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p8xvewk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 01 Apr 2025 07:13:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5317D9H8014891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 1 Apr 2025 07:13:09 GMT
Received: from hu-sumk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 00:13:06 -0700
From: Sumit Kumar <quic_sumk@quicinc.com>
Date: Tue, 1 Apr 2025 12:42:55 +0530
Subject: [PATCH] bus: mhi: ep: Update read pointer only after buffer is
 written
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250401-rp_fix-v1-1-c68c9d81a56a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPaR62cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyML3aKC+LTMCt0U89SkZEOLpGTjpFQloOKColSgMNig6NjaWgDYjlO
 IWAAAAA==
X-Change-ID: 20250328-rp_fix-d7ebc18bc3be
To: <kernel@oss.qualcomm.com>
CC: <quic_krichai@quicinc.com>, <quic_akhvin@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <stable@vger.kernel.org>, Youssef Samir <quic_yabdulra@quicinc.com>,
        "Sumit
 Kumar" <quic_sumk@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2O7OkwHUgYQvSE8Omr6MSC_HoLb8i9aZ
X-Authority-Analysis: v=2.4 cv=PquTbxM3 c=1 sm=1 tr=0 ts=67eb9206 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=zHbxs7Yk4LvyobavtX0A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2O7OkwHUgYQvSE8Omr6MSC_HoLb8i9aZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010048

Inside mhi_ep_ring_add_element, the read pointer (rd_offset) is updated
before the buffer is written, potentially causing race conditions where
the host sees an updated read pointer before the buffer is actually
written. Updating rd_offset prematurely can lead to the host accessing
an uninitialized or incomplete element, resulting in data corruption.

Invoke the buffer write before updating rd_offset to ensure the element
is fully written before signaling its availability.

Fixes: bbdcba57a1a2 ("bus: mhi: ep: Add support for ring management")
cc: stable@vger.kernel.org
Co-developed-by: Youssef Samir <quic_yabdulra@quicinc.com>
Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
Signed-off-by: Sumit Kumar <quic_sumk@quicinc.com>
---
 drivers/bus/mhi/ep/ring.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index aeb53b2c34a8cd859393529d0c8860462bc687ed..26357ee68dee984d70ae5bf39f8f09f2cbcafe30 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -131,19 +131,23 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 	}
 
 	old_offset = ring->rd_offset;
-	mhi_ep_ring_inc_index(ring);
 
 	dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
+	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
+	buf_info.dev_addr = el;
+	buf_info.size = sizeof(*el);
+
+	ret = mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
+	if (ret)
+		return ret;
+
+	mhi_ep_ring_inc_index(ring);
 
 	/* Update rp in ring context */
 	rp = cpu_to_le64(ring->rd_offset * sizeof(*el) + ring->rbase);
 	memcpy_toio((void __iomem *) &ring->ring_ctx->generic.rp, &rp, sizeof(u64));
 
-	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
-	buf_info.dev_addr = el;
-	buf_info.size = sizeof(*el);
-
-	return mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
+	return ret;
 }
 
 void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)

---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250328-rp_fix-d7ebc18bc3be

Best regards,
-- 
Sumit Kumar <quic_sumk@quicinc.com>


