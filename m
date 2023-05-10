Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B46FE1A4
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEJPhg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEJPhf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 11:37:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486F1BE4
        for <stable@vger.kernel.org>; Wed, 10 May 2023 08:37:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AD7vYB020393;
        Wed, 10 May 2023 15:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=tdVmMh3THgnl2zma6tZHaqm8FbeG/Z8xnb81S2AVk+Q=;
 b=NXGdNfVwwSIuInoMGD9+vDbl1H6RdJ04nZl9svsxVWD4zzMRUxLTPWx1evNBBaH+rG0E
 5cZ8meNkpEVNDIDCttrC+ttXWUWdkE7UaWDw4fNiBct6o4zB7N9bU6RCeRXppftZmXRm
 c+GWfRN1Zo99AVHn/BDaTOeQc3Yo7mllAEAak6Nrv9GUe3ti5m7iOtJf1chDBNJ7qj29
 C9iBAL19Emv9bHNohTBxrDesFUAWZRX2flxLRI2m3o12Qz20QVlfVdJHRzfy4Z/ZaZuI
 kHaBHdQ4g93CR9Jfb/BCvK8BbYr8sDDA5dPfs706rMayNLsgiwsUXP4AgersMeV9ivTN NA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg79crwca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 15:37:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AFbWYo031819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 15:37:32 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 08:37:31 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <stable@vger.kernel.org>
CC:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5.15.y] bus: mhi: host: Use mhi_tryset_pm_state() for setting fw error state
Date:   Wed, 10 May 2023 09:37:08 -0600
Message-ID: <1683733028-1388-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2023050652-balancing-evasive-6713@gregkh>
References: <2023050652-balancing-evasive-6713@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5ATcEKC1IQXdEgdBWp15isP3nhiFdoYX
X-Proofpoint-ORIG-GUID: 5ATcEKC1IQXdEgdBWp15isP3nhiFdoYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Commit 1d1493bdc25f498468a606a4ece947d155cfa3a9 upstream.

If firmware loading fails, the controller's pm_state is updated to
MHI_PM_FW_DL_ERR unconditionally.  This can corrupt the pm_state as the
update is not done under the proper lock, and also does not validate
the state transition.  The firmware loading can fail due to a detected
syserr, but if MHI_PM_FW_DL_ERR is unconditionally set as the pm_state,
the handling of the syserr can break when it attempts to transition from
syserr detect, to syserr process.

By grabbing the lock, we ensure we don't race with some other pm_state
update.  By using mhi_try_set_pm_state(), we check that the transition
to MHI_PM_FW_DL_ERR is valid via the state machine logic.  If it is not
valid, then some other transition is occurring like syserr processing, and
we assume that will resolve the firmware loading error.

Fixes: 12e050c77be0 ("bus: mhi: core: Move to an error state on any firmware load failure")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://lore.kernel.org/r/1681142292-27571-3-git-send-email-quic_jhugo@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
(cherry picked from commit 1d1493bdc25f498468a606a4ece947d155cfa3a9)
---
 drivers/bus/mhi/core/boot.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 0a97262..c9dfb1a 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -390,6 +390,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 {
 	const struct firmware *firmware = NULL;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	const char *fw_name;
 	void *buf;
 	dma_addr_t dma_addr;
@@ -507,14 +508,18 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 	}
 
 error_fw_load:
-	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-	wake_up_all(&mhi_cntrl->state_event);
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+	if (new_state == MHI_PM_FW_DL_ERR)
+		wake_up_all(&mhi_cntrl->state_event);
 }
 
 int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
 {
 	struct image_info *image_info = mhi_cntrl->fbc_image;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	enum mhi_pm_state new_state;
 	int ret;
 
 	if (!image_info)
@@ -525,8 +530,11 @@ int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
 			       &image_info->mhi_buf[image_info->entries - 1]);
 	if (ret) {
 		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
-		mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
-		wake_up_all(&mhi_cntrl->state_event);
+		write_lock_irq(&mhi_cntrl->pm_lock);
+		new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		if (new_state == MHI_PM_FW_DL_ERR)
+			wake_up_all(&mhi_cntrl->state_event);
 	}
 
 	return ret;
-- 
2.7.4

