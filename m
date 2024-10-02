Return-Path: <stable+bounces-80563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40798DE6E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512632833DB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB21D0B8D;
	Wed,  2 Oct 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PcnlKXbp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01231E529
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881650; cv=none; b=uTReDXNt2l85w+O950Zl4Bl4ucEWDNXo/yiCGK0CQBmIOoCGXW85kYJemak2vEkUNzti9YPzituFInNS6xBcDYEzgvRmCXRIoTtz2bFn2XulS1k69mFnSmJAeoaRO0meG3IXghz/kA6JKeySEKZOlzyH98KLgcHX3Bi4C5C/980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881650; c=relaxed/simple;
	bh=IbWrig1GFszwB16x1KV6synjCMS/svSsLt2h5Czd9YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dd+DV+vk9EYzpI/OMxbmbZmSfqnec621seRoja5r4yLk+druIDACowHH4VzMqTs6OYtolkRJYoGbH/3Z/OcRuilmTmpw2TmAq0QOq1Jdm+y5GWLrrMIFSrUZJEQ2E9ueUI1RgKiN1qT4WimrVqVMKazq7IG06mAw8qrzdXZrpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PcnlKXbp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd4pY011654;
	Wed, 2 Oct 2024 15:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	corp-2023-11-20; bh=qyj5mvyOOA8bMxkH7EynCIkh2JfXR61c0Wh9zv9b2pQ=; b=
	PcnlKXbpzOQAg2hL5wkXxSaW/2n58FZ2ZKVvvk+unJj9QiS5aSb9zzNBJq1G/hWr
	CqCqS85ppwRs3X/icofydVX36LFPycsEegwruTh4CjEzv7FMVqGxvz+AvsecGAPf
	ZFYLWBG+Mc3XVQx1euR7k9wi15TP5wSSW/xKHHM74LKz0C/S+Rdo6zpQFV/0ew5P
	83GljbVrdy44+tcvMb80Cv6Zd/8GGMD4kdvjo29JsI9GhC0m4UoargoK9BIQxwMi
	IEqkVaD22687lquFxmO/USgOl/LzD7auHer4jhmCT/9VB29nTYfyraMQddSJGrM5
	bqjx/5FGeFI/hCLm2mKlhA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39p7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:07:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492Er2mO017460;
	Wed, 2 Oct 2024 15:07:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888y147-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:07:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492F1lZW012831;
	Wed, 2 Oct 2024 15:07:11 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888xyse-11;
	Wed, 02 Oct 2024 15:07:10 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com,
        Mads Bligaard Nielsen <bli@bang-olufsen.dk>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Robert Foss <rfoss@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 10/15] drm/bridge: adv7511: fix crash on irq during probe
Date: Wed,  2 Oct 2024 17:06:01 +0200
Message-Id: <20241002150606.11385-11-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020109
X-Proofpoint-GUID: JHTE3_MybrdI0ZUo1RNtGc98d5D6bK6_
X-Proofpoint-ORIG-GUID: JHTE3_MybrdI0ZUo1RNtGc98d5D6bK6_

From: Mads Bligaard Nielsen <bli@bang-olufsen.dk>

[ Upstream commit aeedaee5ef5468caf59e2bb1265c2116e0c9a924 ]

Moved IRQ registration down to end of adv7511_probe().

If an IRQ already is pending during adv7511_probe
(before adv7511_cec_init) then cec_received_msg_ts
could crash using uninitialized data:

    Unable to handle kernel read from unreadable memory at virtual address 00000000000003d5
    Internal error: Oops: 96000004 [#1] PREEMPT_RT SMP
    Call trace:
     cec_received_msg_ts+0x48/0x990 [cec]
     adv7511_cec_irq_process+0x1cc/0x308 [adv7511]
     adv7511_irq_process+0xd8/0x120 [adv7511]
     adv7511_irq_handler+0x1c/0x30 [adv7511]
     irq_thread_fn+0x30/0xa0
     irq_thread+0x14c/0x238
     kthread+0x190/0x1a8

Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")
Signed-off-by: Mads Bligaard Nielsen <bli@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240219-adv7511-cec-irq-crash-fix-v2-1-245e53c4b96f@bang-olufsen.dk
(cherry picked from commit aeedaee5ef5468caf59e2bb1265c2116e0c9a924)
[Harshit: CVE-2024-26876; Resolve conflicts due to missing commit:
 c75551214858 ("drm: adv7511: Add has_dsi variable to struct
 adv7511_chip_info") in 6.6.y and adv7511_chip_info struct is also not
 defined]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 2611afd2c1c13..ef2b6ce544d0a 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1291,17 +1291,6 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 	INIT_WORK(&adv7511->hpd_work, adv7511_hpd_work);
 
-	if (i2c->irq) {
-		init_waitqueue_head(&adv7511->wq);
-
-		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
-						adv7511_irq_handler,
-						IRQF_ONESHOT, dev_name(dev),
-						adv7511);
-		if (ret)
-			goto err_unregister_cec;
-	}
-
 	adv7511_power_off(adv7511);
 
 	i2c_set_clientdata(i2c, adv7511);
@@ -1325,6 +1314,17 @@ static int adv7511_probe(struct i2c_client *i2c)
 
 	adv7511_audio_init(dev, adv7511);
 
+	if (i2c->irq) {
+		init_waitqueue_head(&adv7511->wq);
+
+		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+						adv7511_irq_handler,
+						IRQF_ONESHOT, dev_name(dev),
+						adv7511);
+		if (ret)
+			goto err_unregister_audio;
+	}
+
 	if (adv7511->type == ADV7533 || adv7511->type == ADV7535) {
 		ret = adv7533_attach_dsi(adv7511);
 		if (ret)
-- 
2.34.1


