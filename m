Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7577513F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 05:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjHIDJP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 8 Aug 2023 23:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHIDJO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 Aug 2023 23:09:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3E1BF0
        for <stable@vger.kernel.org>; Tue,  8 Aug 2023 20:09:14 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3792ijlw015103
        for <stable@vger.kernel.org>; Wed, 9 Aug 2023 03:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qnnfa/E2csSoEJfzcMjz6VRCrhnXshNrlw1QRh2X2YU=;
 b=JF3WBYPlkLyUQpvSrUlvxu0ebaKdi0IqjugxRQBfrFTtsHLKDpP+CY2cYOFljvMZStY5
 8kiaOIlB8N3Q/j5C6Jp1xc7Hrc3P1116Qe94e9OnQT7WKE6HWZNpGMQxUkhiEky1caDo
 wd90QDrAzPfMjUgXNJ7BnFsjx7cUDYyz1I0omYaRYlG7z2B/k8pfA0FrRtf0psxsjojU
 Hbx8POIHjw9u0YlzMkJb/NwLpCXdl71hix4Dy5aG0RiUm/e0jKgcawpy3fRVceNElQ6O
 BlYHNw1E/fXHVsmZNVV002WiF3oAIckSjlAu2GkJyyAECArHOebu95NTiOg6evTN1UQL Cw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc28rr15x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 03:09:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37939CPh031431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 9 Aug 2023 03:09:12 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 8 Aug 2023 20:09:10 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <quic_vgarodia@quicinc.com>, <quic_dikshita@quicinc.com>,
        <quic_vboma@quicinc.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of codecs within range
Date:   Wed, 9 Aug 2023 08:38:13 +0530
Message-ID: <1691550493-18096-5-git-send-email-quic_vgarodia@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -3_PgQigm7v47OH76oBc5j-at-5VlYIS
X-Proofpoint-GUID: -3_PgQigm7v47OH76oBc5j-at-5VlYIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=821 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/media/platform/qcom/venus/hfi_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 9d6ba22..c438395 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -19,6 +19,9 @@ static void init_codecs(struct venus_core *core)
 	struct hfi_plat_caps *caps = core->caps, *cap;
 	unsigned long bit;
 
+	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
+		return;
+
 	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
 		cap = &caps[core->codecs_count++];
 		cap->codec = BIT(bit);
-- 
2.7.4

