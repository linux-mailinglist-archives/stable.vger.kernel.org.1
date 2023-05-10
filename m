Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA656FE190
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 17:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjEJPbi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 11:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEJPbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 11:31:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8A10D0
        for <stable@vger.kernel.org>; Wed, 10 May 2023 08:31:36 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AEpUtY027043;
        Wed, 10 May 2023 15:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=szvr9JO/kjW2MYMTPEsV1MUDNKYQ7RSXtBHBZnPEzfs=;
 b=QGbuCTaqFWgx549qM70LJLkLLswLqleMxndk+Ic+T6A1tLY1awPSEygHKLK4kDdOGeM2
 IqQBDXiLkg8RAtONgQ3Z+194aZT69QXtBJD9sSqvJ2H7Me1yyCq64CNE8lVVOMsQthV1
 aiLmAHT6xr/lse0O4lommUY0BGmM4JaJ0uB1vbUGSfn4q0JdPUxf9Mjp27DH0HjLQnF4
 svO2lMY0NcHRAfHqzNJd79GlxPdpo5TmYpnVrWo+kZjmRUMnQ1nOeupjcthsIrsI4mbu
 sQRocfH+N9BL5JWIY2EYIY8tDm2QtaPe1B9NbOX5lB2IIEq/Nol+iwBXhTIXqJglRE+v kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgdd9r417-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 15:31:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AFVYKa015980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 15:31:34 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 08:31:33 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <stable@vger.kernel.org>
CC:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5.15.y] bus: mhi: host: Remove duplicate ee check for syserr
Date:   Wed, 10 May 2023 09:31:07 -0600
Message-ID: <1683732668-28817-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2023050638-murkiness-purple-0e97@gregkh>
References: <2023050638-murkiness-purple-0e97@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EFL5mO6t8biD_hHOYLtxNxuV5uNHciRs
X-Proofpoint-ORIG-GUID: EFL5mO6t8biD_hHOYLtxNxuV5uNHciRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit d469d9448a0f1a33c175d3280b1542fa0158ad7a upstream.

If we detect a system error via intvec, we only process the syserr if the
current ee is different than the last observed ee.  The reason for this
check is to prevent bhie from running multiple times, but with the single
queue handling syserr, that is not possible.

The check can cause an issue with device recovery.  If PBL loads a bad SBL
via BHI, but that SBL hangs before notifying the host of an ee change,
then issuing soc_reset to crash the device and retry (after supplying a
fixed SBL) will not recover the device as the host will observe a PBL->PBL
transition and not process the syserr.  The device will be stuck until
either the driver is reloaded, or the host is rebooted.  Instead, remove
the check so that we can attempt to recover the device.

Fixes: ef2126c4e2ea ("bus: mhi: core: Process execution environment changes serially")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1681142292-27571-2-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 9a94b8d..6b36689 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -489,7 +489,7 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	}
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 
-	if (pm_state != MHI_PM_SYS_ERR_DETECT || ee == mhi_cntrl->ee)
+	if (pm_state != MHI_PM_SYS_ERR_DETECT)
 		goto exit_intvec;
 
 	switch (ee) {
-- 
2.7.4

