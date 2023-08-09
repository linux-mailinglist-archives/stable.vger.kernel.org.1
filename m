Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5977513C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 05:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHIDJG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 23:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHIDJF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 23:09:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2AB1BEF
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 20:09:04 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37933V0h000765
        for <stable@vger.kernel.org>; Wed, 9 Aug 2023 03:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fybLsQntBjDPeIINYbmncAJXzI627HXW3R0ZrjRa2fg=;
 b=PEXRYQWB421NTMsJawGlIB+CCU8EtDWYlEj8+fHU6ts8ygEyA0+P9LOxJqedMN8bZfrG
 vgSOlbnBDseWjeZ0JkiGQ6yyfUq28mlzgvyL993NhEf6pyToTRJfxwJ9WEZQ+32iJnSo
 ZSXUjrK4qgtvYzfSK/5f9ejLz0rlcaOtnCpOvuJMeRrFW+x3gZvN5O51OOWwqfCaKsUT
 vk2cvziTPl8Q0xHt1F5GNGNY3f+tix4zCpDv6PfH+pztU+j1Sm+G0ujgaTMO0x5+GQUe
 jhoSkA/nKHI9LJFSpYkUQWO7ZyuiX1umOIu2RIoKkzTz9NcnX+H4vbcXagxmj+VboXUh 4w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc00508gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 03:09:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379393hZ016006
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 9 Aug 2023 03:09:03 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 20:09:01 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <quic_vgarodia@quicinc.com>, <quic_dikshita@quicinc.com>,
        <quic_vboma@quicinc.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] venus: hfi: add checks to perform sanity on queue pointers
Date:   Wed, 9 Aug 2023 08:38:10 +0530
Message-ID: <1691550493-18096-2-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691550493-18096-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1691550493-18096-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3NCOyvqgbGfIIn_ypySmhg-W9C4u2Qkt
X-Proofpoint-GUID: 3NCOyvqgbGfIIn_ypySmhg-W9C4u2Qkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=673 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f0b4638..4ddabb1 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -206,6 +206,11 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 
 	new_wr_idx = wr_idx + dwords;
 	wr_ptr = (u32 *)(queue->qmem.kva + (wr_idx << 2));
+
+	if (wr_ptr < (u32 *)queue->qmem.kva ||
+	    wr_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*wr_ptr)))
+		return -EINVAL;
+
 	if (new_wr_idx < qsize) {
 		memcpy(wr_ptr, packet, dwords << 2);
 	} else {
@@ -273,6 +278,11 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 	}
 
 	rd_ptr = (u32 *)(queue->qmem.kva + (rd_idx << 2));
+
+	if (rd_ptr < (u32 *)queue->qmem.kva ||
+	    rd_ptr > (u32 *)(queue->qmem.kva + queue->qmem.size - sizeof(*rd_ptr)))
+		return -EINVAL;
+
 	dwords = *rd_ptr >> 2;
 	if (!dwords)
 		return -EINVAL;
-- 
2.7.4

