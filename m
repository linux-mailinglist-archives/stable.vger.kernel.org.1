Return-Path: <stable+bounces-114170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17EA2B26B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 20:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19354162C90
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7741AAA2F;
	Thu,  6 Feb 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QrFbyYfQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF251A9B46;
	Thu,  6 Feb 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870804; cv=none; b=tA2NITMRPkYEJnu7gJ9tN2s3LcnhD5FTZBcUb3zDr29ahUE7u94Hc4B/gRkkYKKjUIubR9VDsbdEkzlnr8vbUM7axW0klz+yX+ql70K/UBCZ++3+713BaMylhvOLl1CJQnkA6zYo4m+Uk0v//tehO722Kj7PTipEeCcNvWkjNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870804; c=relaxed/simple;
	bh=x/gRAVP5w48dDy3Q4GLG6EyEXkg923PyyQPCeIGWkXE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nMz5Mm/1IoDuKA3y9n8CXvDpVtAMWXUBx0F+zSrXnOp4Vs5QSYBs4zjBqO65jWEQHrarqq+LguWKuvf7I/gWGAN4Pk2Lf+Y8f4YflhlPpnqVWfupSGZtQFmmXqraWdUy7CFvaVl+hisdkf3givPd4mQNCdsGlSWCGNtRD2/j5Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QrFbyYfQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516Hrior018154;
	Thu, 6 Feb 2025 19:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=N3DbkgSLvQT9
	Mh8DpNYxq3rF29ncrXImS+5D27fnjTA=; b=QrFbyYfQWh1/ApBAiTMN02bPXADx
	YVjKABqCc++ZnP0sQu60M3xazSMRRtJBDo2pIk4XkckFROXVPsCtfe6I3uPMf2S7
	i2bNdTQIO6OmBKxTbqY3EckZvSK8NnEGEefTa7YGSDCiQ6iH5hYXJkLZj6LjO14u
	dIdaYwm+4xjHgShlOZ+hDUlnd1bNiVqD43dm7Io5nJIYxCUEETshf+Z7Em28ZQOL
	oXbSSkAU97Rykas5hGWu68FADDW8lJAFSwabqRjO5cM3tXlTV4kaD+AYxVENAbFo
	c2H0fWA3bx+beITAtA2HXmLcQLaF6IeQ/1AXD+N+1P++UN9w5fRsTah36A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44n1vng8dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 19:39:56 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 516Jdtea012577;
	Thu, 6 Feb 2025 19:39:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 44n335r65a-1;
	Thu, 06 Feb 2025 19:39:55 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 516JbT6X008333;
	Thu, 6 Feb 2025 19:39:55 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTP id 516JdsVD012557;
	Thu, 06 Feb 2025 19:39:55 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
	id C0DDC624CA9; Thu,  6 Feb 2025 11:39:54 -0800 (PST)
From: Elson Roy Serrao <quic_eserrao@quicinc.com>
To: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        xu.yang_2@nxp.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>, stable@vger.kernel.org
Subject: [PATCH v2] usb: roles: set switch registered flag early on
Date: Thu,  6 Feb 2025 11:39:50 -0800
Message-Id: <20250206193950.22421-1-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mZCfhr0dpV2NxLO4jK71MJD8fEodPPjp
X-Proofpoint-GUID: mZCfhr0dpV2NxLO4jK71MJD8fEodPPjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060155
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The role switch registration and set_role() can happen in parallel as they
are invoked independent of each other. There is a possibility that a driver
might spend significant amount of time in usb_role_switch_register() API
due to the presence of time intensive operations like component_add()
which operate under common mutex. This leads to a time window after
allocating the switch and before setting the registered flag where the set
role notifications are dropped. Below timeline summarizes this behavior

Thread1				|	Thread2
usb_role_switch_register()	|
	|			|
	---> allocate switch	|
	|			|
	---> component_add()	|	usb_role_switch_set_role()
	|			|	|
	|			|	--> Drop role notifications
	|			|	    since sw->registered
	|			|	    flag is not set.
	|			|
	--->Set registered flag.|

To avoid this, set the registered flag early on in the switch register
API.

Fixes: b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is unregistered")
cc: stable@vger.kernel.org
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
Changes in v2:
 - Set the switch registered flag from the get-go as suggested by
   Heikki.
 - Modified subject line and commit next as per the new logic.
 - Link to v1: https://lore.kernel.org/all/20250127230715.6142-1-quic_eserrao@quicinc.com/

 drivers/usb/roles/class.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index c58a12c147f4..30482d4cf826 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -387,8 +387,11 @@ usb_role_switch_register(struct device *parent,
 	dev_set_name(&sw->dev, "%s-role-switch",
 		     desc->name ? desc->name : dev_name(parent));
 
+	sw->registered = true;
+
 	ret = device_register(&sw->dev);
 	if (ret) {
+		sw->registered = false;
 		put_device(&sw->dev);
 		return ERR_PTR(ret);
 	}
@@ -399,8 +402,6 @@ usb_role_switch_register(struct device *parent,
 			dev_warn(&sw->dev, "failed to add component\n");
 	}
 
-	sw->registered = true;
-
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
-- 
2.17.1


