Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C576362E
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGZMWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjGZMWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 08:22:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECAAF5
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 05:22:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QBwp7j004444;
        Wed, 26 Jul 2023 12:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=b9JkBU4ajOHvGCySu6FDWdEm1FvpwdBuAZcDijsmdWU=;
 b=QW/fsyGlJA2VdVlMaa1n4AXEr0AZjDfMJUajS9j/l32JG3gGvWJzel77/upCjJvsbCeA
 2lEDQ4eYJiNLkuVF0e1WP0sByq4bQV/ju0Rip+JZhHdcKnHs3C4ye26k9Ioagutv50Kh
 mPbPWIkiGFtBpcRjUm9MUYD6hC27kieX9aJq2u76wAvf463krDau/v8Ismnnn1yp6BgL
 KqBOMFpbC5OplPQBAuYBxskGjA0kstXp3K5xKF1BP4PuJxGNsJ0ag5rsw2prRguFe06q
 fTTSv7HWlAN/4I1wqz2X5Dze7zFXSYhEP3SQhDudh+OkEEycw82vsn+2wcMFK2teREAu ug== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1t7qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 12:22:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QCM8p8023100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 12:22:08 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 05:22:07 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <bryan.odonoghue@linaro.org>, <quic_vgarodia@quicinc.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH 1/4] venus: hfi: add checks to perform sanity on queue pointers
Date:   Wed, 26 Jul 2023 17:51:51 +0530
Message-ID: <1690374114-29208-2-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690374114-29208-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690374114-29208-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZqVFPCEiSpGG3Yasu6r-gqqYYk4jGAO9
X-Proofpoint-ORIG-GUID: ZqVFPCEiSpGG3Yasu6r-gqqYYk4jGAO9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=665 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Read and write pointers are used to track the packet index in the memory
shared between video driver and firmware. There is a possibility of OOB
access if the read or write pointer goes beyond the queue memory size.
Add checks for the read and write pointer to avoid OOB access.

Cc: stable@vger.kernel.org
Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f0b4638..dc228c4 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -206,6 +206,10 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 
 	new_wr_idx = wr_idx + dwords;
 	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
+
+	if (wr_ptr < (u32 *)queue->qmem.kva || wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size))
+		return -EINVAL;
+
 	if (new_wr_idx < qsize) {
 		memcpy(wr_ptr, packet, dwords << 2);
 	} else {
@@ -273,6 +277,10 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	}
 
 	rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
+
+	if (rd_ptr < (u32 *)queue->qmem.kva || rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size))
+		return -EINVAL;
+
 	dwords = *rd_ptr >> 2;
 	if (!dwords)
 		return -EINVAL;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

