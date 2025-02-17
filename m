Return-Path: <stable+bounces-116574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F41CA38291
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDE118884E6
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC87219A94;
	Mon, 17 Feb 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iyatpmj6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7046E2135AF
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793821; cv=none; b=WXjjM4XabAdQ/kp4VY28feoOS/+v0Mc42lfE6kZ6g4gAEzM9f4r1gD3fSkI1O+3G8vQyeO55zC0fH0S9zr6XaQglRHqW/6VJTzdKzXXAIcHqvwJVoit/wkLKt8BMQGSXU5lcgWDjmVShhV0LeO8xA6e8eMl4K3WW3jwRI5RjjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793821; c=relaxed/simple;
	bh=6K1s7WtvEcHra4PUkbNmsvAn+WXVWxS0gjiaUNd/DaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j4rdbF2D1275IFT7YpKj1/COlRWYN+jfSToQK09U3YCtS35eYaKoa3u5H0GYzZJ87k9Dx1Pt3RBYiyQaf3HPjXRpMVgNu178ue/S/pEEC8G9tlwe1796nWTnRN4aDrHpo+eTJD9FNuu0NNPelMDc9yiOpktPqoP/TNe3BP8UjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iyatpmj6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HAinWM004213
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 12:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aSw/G6T2sY+Uwj1Mjfh8/x3LyRxDhXoGM64
	LGGBqwdk=; b=Iyatpmj6Qzd5lrwLSDcnbKhY1PEhWovR98kJt+HTgzONzVpjnxd
	qvwigJNGNbGBdudzSRNEebmi4C8k8cS9noiRfFc9tDaZlu5zhk6cwsnCIHqNnRig
	iV0IbXFg7aN8vP/hKz3UlTG4toOC/BkQxVT+mU/qTJSXpo54344ctAWsRc4IwpC6
	sYvfDENc6v6Er1/ibdl+0daKOzMks6dsNlZKiaWJ+u+qDGfu5g+ehant1MF40igV
	g29opPcICn/NJuQ6vd8aZmhKFSKig18p9bO3FbC5kJzEoYY4sQCzEVrdr1lczSqH
	a6jPjKVyC0QmnFQbe0jtDX3VfpTeAjnwqgA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44v3mg06gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 12:03:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22104619939so63821645ad.1
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 04:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793817; x=1740398617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSw/G6T2sY+Uwj1Mjfh8/x3LyRxDhXoGM64LGGBqwdk=;
        b=PCofNFnGnymus6eTtkeEjixcIqakfq/O4HLrC/77Zh4DfukMPia1v1RJmWVn0FwlGx
         dt7/RvUq/HBALJYNxVZLwQadvqrv+dCVJuB0Ci3AbFFnf6rBJqGc2X5qZ2MhjalXlNgK
         UWz8yC6TFcIG23FHzMy6ybotgGO5Nn4MZzdvOEQ/6M2nN2/5v1uV+Lr1+0tgpgKAQTXR
         0L51c3YYgf/TNV2BSJGutzqEkpzM45Pp4LhkyTRRjtoeZSNVmvNSNcR4ro0mSXOlh6L9
         xTyswAInubUqZXyaxPo1pxspmxANwN04asxY2WAdfXVTAZtASUyIerxRdg8sDT6tUH68
         3JBA==
X-Forwarded-Encrypted: i=1; AJvYcCX+qQ/RkhqNs3w4J3DPukjp5/R4lJAlxx8bLTqqaQvWS2FpsQt+C3hfZLqduho3pWeFtpZincw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/O2SwvIgXS96fevJ8W9IxMRTocJPvRU1uVFJMZ2kB0x15xvZ
	BlyW42o3rkM6ervWeqTib433j9tJCBdkPEcXNW4KbnKBLqbPXEaH2bxUOtrASuxZKclNKdSsXgx
	iAcYaor661I8A+hcvK3GNk0r3tXFHrzCp4qDBAXccPRAfT/zVVChGztE=
X-Gm-Gg: ASbGnctuFyGTmd28w/3TLB50bBBxVIzFxWpAMZjcFCWXkbsyHOgx5mC6LAa2067y8s/
	UK/4cQENL+k8zjal0fWNVXRsmP+L53BwffMlZ44y88ykBSZvwregHMFYP1TrGVa3VrqalAaaGjh
	T8ZkJLFi4lPJeL/ihxaSK+gy5NPpVuk0HAcjWoeR2CBENVJdypBZQ3nAQaFD9QNCYUkVug+PEsk
	gLgGOxEE+ssyqMVivxNtDKJjja6D6TrNHwvCjrMhjMbfD66LBPvjln3qVyqr40e4xpUHN3ijA5T
	5wgtLubnLN4UHMDM+4i00gzrORPjYUs44A==
X-Received: by 2002:a17:902:d50d:b0:216:3633:36e7 with SMTP id d9443c01a7336-22104062006mr155026825ad.26.1739793816579;
        Mon, 17 Feb 2025 04:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCA6q1jXs0gOYPnNc5rfyp37vbwb5yTD5SJhEK5QU1yvw7CTG3Llt6jrhbbwMiFjX0ult0Sw==
X-Received: by 2002:a17:902:d50d:b0:216:3633:36e7 with SMTP id d9443c01a7336-22104062006mr155026335ad.26.1739793816079;
        Mon, 17 Feb 2025 04:03:36 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f34sm70632925ad.10.2025.02.17.04.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:03:35 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and bmAttributes
Date: Mon, 17 Feb 2025 17:33:28 +0530
Message-Id: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -ogonL7TX_s-THUpEy-dheDwetRqDjEc
X-Proofpoint-ORIG-GUID: -ogonL7TX_s-THUpEy-dheDwetRqDjEc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=481 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170106

Currently the USB gadget will be set as bus-powered based solely
on whether its bMaxPower is greater than 100mA, but this may miss
devices that may legitimately draw less than 100mA but still want
to report as bus-powered. Similarly during suspend & resume, USB
gadget is incorrectly marked as bus/self powered without checking
the bmAttributes field. Fix these by configuring the USB gadget
as self or bus powered based on bmAttributes, and explicitly set
it as bus-powered if it draws more than 100mA.

Cc: stable@vger.kernel.org
Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
Changes in v2:
- Didn't change anything from RFC.
- Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-prashanth.k@oss.qualcomm.com/

 drivers/usb/gadget/composite.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index bdda8c74602d..1fb28bbf6c45 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
-	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
-		usb_gadget_set_selfpowered(gadget);
-	else
+	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
+	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
 		usb_gadget_clear_selfpowered(gadget);
+	else
+		usb_gadget_set_selfpowered(gadget);
 
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
@@ -2615,7 +2616,9 @@ void composite_suspend(struct usb_gadget *gadget)
 
 	cdev->suspended = 1;
 
-	usb_gadget_set_selfpowered(gadget);
+	if (cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
+		usb_gadget_set_selfpowered(gadget);
+
 	usb_gadget_vbus_draw(gadget, 2);
 }
 
@@ -2649,8 +2652,11 @@ void composite_resume(struct usb_gadget *gadget)
 		else
 			maxpower = min(maxpower, 900U);
 
-		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
+		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW ||
+		    !(cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
 			usb_gadget_clear_selfpowered(gadget);
+		else
+			usb_gadget_set_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
 	} else {
-- 
2.25.1


