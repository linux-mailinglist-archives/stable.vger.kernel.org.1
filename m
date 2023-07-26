Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D398176362F
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjGZMWo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGZMWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 08:22:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE7E100
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 05:22:41 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QAr8Oa004454;
        Wed, 26 Jul 2023 12:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=svPmzVI+7eFon/1ocEodK5MNmMYxEhx6SeLGE+hwf/s=;
 b=gHyTFXgxt1ogA67NhR9Rhj9VmMzdCafieS54GAGfE8pRbUsaokrfPf2V0o7yKlnJOZ7D
 o02HvYSqmISgQibZeO8ZGZERiwBZ46jbtILnNS2fmCfkBF/hJw8Cf9Kx4eT26Yyfb3wo
 mKK/keiY2xKXPTahhf6auUgPVU879lqEuneyBZ1sY404B8XBexqtWx4sq//d9GolmICS
 Nw9Y216it+OY6FnH5/qqeNYp7LIHfjFT8B6KZacxSsl7R4PN2x1gKTvXO3ZgUoqjuRpL
 zmp0BCXS1fXCEou712e7EDoMw+OCSidu8Ss0Oe2aQaiXDHBPpU4hARw2MVAbfkayqnYi JA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1t7qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 12:22:40 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QCMIgE025708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 12:22:19 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 05:22:17 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <bryan.odonoghue@linaro.org>, <quic_vgarodia@quicinc.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH 4/4] venus: hfi_parser: Add check to keep the number of codecs within range
Date:   Wed, 26 Jul 2023 17:51:54 +0530
Message-ID: <1690374114-29208-5-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-GUID: By8qPbtBSPTa2okY0dRdwMXqgJWA3Z6Y
X-Proofpoint-ORIG-GUID: By8qPbtBSPTa2okY0dRdwMXqgJWA3Z6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=980 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

