Return-Path: <stable+bounces-110920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A589A2015F
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 00:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D90D3A4B01
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8011DC9AC;
	Mon, 27 Jan 2025 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RlLGDcLc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317482866;
	Mon, 27 Jan 2025 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019286; cv=none; b=k7MOpmp3Onh8ekSU86OPfkbfFfr9MKo8mcOtTAh/RAuizlvySY+i+EWJ5G0pBKY2Is0IcgoGiIOzrVmTioFiaHArmDJLnqyLAJDGyqKY7M++9sRLrDPat+0UFT8OLiSQYHRfXpz5o1q3+cPTDczYOvDbar7GVMnDMo9/yc+0fDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019286; c=relaxed/simple;
	bh=tYq6+A5sQTyvjenjao+fCliHvqFv+GsCuSImP3A5ans=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Yi62oOz8BgkNBx7x/nCADdZu+Eq/k/5CPxQcQZX2HA9s8HV49jlK2Q6Y0Bb6zgqLewKXoYat4TzAMmtc7bILSS75PdUnZ7pVvhR1YYZjP0usoBvp28D3CjMcG/kIn82E7Wlj+koZ3AD+AIgR/FIfiRcTA+Bkpnokl+/yqjgl1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RlLGDcLc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFkclK009727;
	Mon, 27 Jan 2025 23:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=zGE1qF72pGTw
	FGj63Co+GJ//QrOw5gtUJQBbxMJC8r4=; b=RlLGDcLcN08QznUgVuJjgVpxQnOW
	zjlut0Ddb1brK04A4LxVwTMxvaeDPXVRXi4QIEYRKf3MSKQNaP1XcEI9MQ0AlJle
	JuztPU5CkihI7uOB3fYU1kq/hUFd398MPFGmG+XchIzsQZrGHSTNQoRMYy5BsW91
	5ISCVJNIWp9fthrZhDh3CM2pkjJLVyys/pulTqnAvsHoT/2lGP3uOZUMZ4iaUhJR
	WqFHtiZashpva8sqlSVi2zy6m0Ie6Cs27ra6s/oCvGwKbwQMWYi81fPQNUf7U4UT
	IS7VyKVb8wgyXOgmh5c9qZ9/YBbqaJlJIinnw3Gcdnv0ND9cUPrN0W5wdg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ed36rv9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 23:07:51 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 50RN7oZl012066;
	Mon, 27 Jan 2025 23:07:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 44d9eh13sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 27 Jan 2025 23:07:50 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50RN41KH007300;
	Mon, 27 Jan 2025 23:07:50 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 50RN7o6n012058;
	Mon, 27 Jan 2025 23:07:50 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
	id 30E4250016B; Mon, 27 Jan 2025 15:07:50 -0800 (PST)
From: Elson Roy Serrao <quic_eserrao@quicinc.com>
To: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        xu.yang_2@nxp.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>, stable@vger.kernel.org
Subject: [PATCH] usb: roles: cache usb roles received during switch registration
Date: Mon, 27 Jan 2025 15:07:15 -0800
Message-Id: <20250127230715.6142-1-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o64W48O_qy_8fOQM-ZpIJKC4uRwa7b6y
X-Proofpoint-ORIG-GUID: o64W48O_qy_8fOQM-ZpIJKC4uRwa7b6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_11,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501270181
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

To avoid this, cache the last role received and set it once the switch
registration is complete. Since we are now caching the roles based on
registered flag, protect this flag with the switch mutex.

Fixes: b787a3e78175 ("usb: roles: don't get/set_role() when usb_role_switch is unregistered")
cc: stable@vger.kernel.org
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/roles/class.c | 45 ++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index c58a12c147f4..c0149c31c01b 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -26,6 +26,8 @@ struct usb_role_switch {
 	struct mutex lock; /* device lock*/
 	struct module *module; /* the module this device depends on */
 	enum usb_role role;
+	enum usb_role cached_role;
+	bool cached;
 	bool registered;
 
 	/* From descriptor */
@@ -65,6 +67,20 @@ static const struct component_ops connector_ops = {
 	.unbind = connector_unbind,
 };
 
+static int __usb_role_switch_set_role(struct usb_role_switch *sw,
+				      enum usb_role role)
+{
+	int ret;
+
+	ret = sw->set(sw, role);
+	if (!ret) {
+		sw->role = role;
+		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+	}
+
+	return ret;
+}
+
 /**
  * usb_role_switch_set_role - Set USB role for a switch
  * @sw: USB role switch
@@ -79,17 +95,21 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 	if (IS_ERR_OR_NULL(sw))
 		return 0;
 
-	if (!sw->registered)
-		return -EOPNOTSUPP;
-
+	/*
+	 * Since we have a valid sw struct here, role switch registration might
+	 * be in progress. Hence cache the role here and send it out once
+	 * registration is complete.
+	 */
 	mutex_lock(&sw->lock);
-
-	ret = sw->set(sw, role);
-	if (!ret) {
-		sw->role = role;
-		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
+	if (!sw->registered) {
+		sw->cached = true;
+		sw->cached_role = role;
+		mutex_unlock(&sw->lock);
+		return 0;
 	}
 
+	ret = __usb_role_switch_set_role(sw, role);
+
 	mutex_unlock(&sw->lock);
 
 	return ret;
@@ -399,8 +419,14 @@ usb_role_switch_register(struct device *parent,
 			dev_warn(&sw->dev, "failed to add component\n");
 	}
 
+	mutex_lock(&sw->lock);
 	sw->registered = true;
 
+	if (sw->cached)
+		__usb_role_switch_set_role(sw, sw->cached_role);
+
+	mutex_unlock(&sw->lock);
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -417,7 +443,10 @@ void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
 	if (IS_ERR_OR_NULL(sw))
 		return;
+	mutex_lock(&sw->lock);
 	sw->registered = false;
+	sw->cached = false;
+	mutex_unlock(&sw->lock);
 	if (dev_fwnode(&sw->dev))
 		component_del(&sw->dev, &connector_ops);
 	device_unregister(&sw->dev);
-- 
2.17.1


