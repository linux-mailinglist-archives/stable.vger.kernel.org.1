Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440006FE1B2
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbjEJPlb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 11:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbjEJPlS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 11:41:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B86358C
        for <stable@vger.kernel.org>; Wed, 10 May 2023 08:41:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ADuxBn020694;
        Wed, 10 May 2023 15:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gdLoutplD378t86pgxn53TJEOuxjy5grob3ViAJmnVA=;
 b=oZP5lx2DIlYQAyj0ecc2ksVKI9qhTBJ/smJXq2884z4n9TN9WfJjanUS1NNoQBrtjH5d
 rtTFvq72xXhZlEjE0g9apBBRbPAMzCPAvhU0xmIMZRxddusuJExvMWubaTIl6T+eRzHx
 hTwBa9GhNMRpIOGu0DUScuYfy3wuu/7XqEwEgbalSEXQKU6KqKAMt6WiBnjECcn3qfjA
 7hYgCebzwHyeeIMiKtyezFGJLkhXud/7YNml+S7Ij6iQTTDjxXBXAKn45Jw/QUcYX6vp
 Z4iqX9IfKEnc8nZ3b8gGbPzJ/9/L7OfONNNVVUVSF8XRGKKWSrtL/PR0wcJfYSOlxM6Q KA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qfw3d1vx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 15:41:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AFfETH005306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 15:41:14 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 08:41:14 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <stable@vger.kernel.org>
CC:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5.15.y] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Date:   Wed, 10 May 2023 09:41:01 -0600
Message-ID: <1683733261-16492-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2023050609-foothold-turret-5465@gregkh>
References: <2023050609-foothold-turret-5465@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r4NN0O-0YWnYl78Qt53SFCfRAxP0-0AC
X-Proofpoint-GUID: r4NN0O-0YWnYl78Qt53SFCfRAxP0-0AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit 6a0c637bfee69a74c104468544d9f2a6579626d0 upstream.

If the value read from the CHDBOFF and ERDBOFF registers is outside the
range of the MHI register space then an invalid address might be computed
which later causes a kernel panic.  Range check the read value to prevent
a crash due to bad data from the device.

Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1679674384-27209-1-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index d8787aa..829d4fc 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -517,6 +517,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	if (val >= mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB)) {
+		dev_err(dev, "CHDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * MHI_DEV_WAKE_DB));
+		return -ERANGE;
+	}
+
 	/* Setup wake db */
 	mhi_cntrl->wake_db = base + val + (8 * MHI_DEV_WAKE_DB);
 	mhi_cntrl->wake_set = false;
@@ -534,6 +540,12 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return -EIO;
 	}
 
+	if (val >= mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings)) {
+		dev_err(dev, "ERDB offset: 0x%x is out of range: 0x%zx\n",
+			val, mhi_cntrl->reg_len - (8 * mhi_cntrl->total_ev_rings));
+		return -ERANGE;
+	}
+
 	/* Setup event db address for each ev_ring */
 	mhi_event = mhi_cntrl->mhi_event;
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, val += 8, mhi_event++) {
-- 
2.7.4

