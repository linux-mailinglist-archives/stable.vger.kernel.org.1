Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD52766543
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjG1H0w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 03:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjG1H0f (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 03:26:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439713C34
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 00:26:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S3GZYV032517
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 07:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MaXkTerJ8Q1GLD51t29/CPu3pbuVNuwCPF1xtI0yAjs=;
 b=hIeVVZDptbAIZiDCnA5I+5FEw4lCN8OW3RqTSzyfk+R9q7Xbs6/R9cEDaHVGjRL3PJtL
 2zdiRnTNtaRKxenXxsteMiOx5i6tChceG/bT6JXd8PdIvzH3mY7AVLP1Az7ZPxPjJUNU
 1KBRSjZFP2UYJBVE020pMT+vI5MQyLinB4u4myPJzXsvJVWFoWNJNRt8/4KSS/WKTmFo
 YhIt+iansrVJip1u4SzDPhHplj+7VpOCmFos+5DwVSu5EXJojaAwqAawNCIcPDIlewac
 nL1pYsh55ly3gSQhNPTwqqBeIq8GYB0wv31keN0yo/O89jWLC+s0pEmHyIkCSC/Fim0B jQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3krnats0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 07:26:28 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S7QSw8010713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 07:26:28 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 00:26:26 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <quic_vgarodia@quicinc.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH] venus: hfi_parser: Add check to keep the number of codecs within range
Date:   Fri, 28 Jul 2023 12:56:17 +0530
Message-ID: <1690529177-24890-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ezF-8Okda3qxlJBKT74zMD4NkLJGhQkh
X-Proofpoint-GUID: ezF-8Okda3qxlJBKT74zMD4NkLJGhQkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 mlxlogscore=915 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Supported codec bitmask is populated from the payload from venus firmware.
There is a possible case when all the bits in the codec bitmask is set. In
such case, core cap for decoder is filled  and MAX_CODEC_NUM is utilized.
Now while filling the caps for encoder, it can lead to access the caps
array beyong 32 index. Hence leading to OOB write.
The fix counts the supported encoder and decoder. If the count is more than
max, then it skips accessing the caps.

Cc: stable@vger.kernel.org
Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_parser.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index ec73cac..651e215 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -14,11 +14,26 @@
 typedef void (*func)(struct hfi_plat_caps *cap, const void *data,
 		     unsigned int size);
 
+static int count_setbits(u32 input)
+{
+	u32 count = 0;
+
+	while (input > 0) {
+		if ((input & 1) == 1)
+			count++;
+		input >>= 1;
+	}
+	return count;
+}
+
 static void init_codecs(struct venus_core *core)
 {
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	if ((count_setbits(core->dec_codecs) + count_setbits(core->enc_codecs)) > MAX_CODEC_NUM)
+		return;
+
 	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
 		cap = &caps[core->codecs_count++];
 		cap->codec = BIT(bit);
-- 
2.7.4

