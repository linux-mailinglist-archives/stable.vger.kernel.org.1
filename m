Return-Path: <stable+bounces-112136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4F7A26FAF
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3632F3A5E98
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D220B1EF;
	Tue,  4 Feb 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oliS+NTu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6D20AF9A
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666764; cv=none; b=FCHqMWN1SlaHhcu8IFzsV5DljU/UxZSFAxc3z48mdu+u1l6SbSdXZsYPUD7cLWXz41arz0B4Zry/h1/U9FmD6Bl9zSwAVtZTYFM8Fj32q/yxzQxoaMvGpapRyuICTLD+hTaaINcKlZcLGE0ExnWSNoF/01Qlha7trNMASLYMjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666764; c=relaxed/simple;
	bh=KDUpqFH60In99EOYxcvh8+1IiNmgCdzqDbEQmebOkZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F5BUpJKnAXEnE5zm/W4j7GB13ucb2HfrC8vCXjf8I+sKYB+DHVN9MDs7hasX6c/bkHBRQ8RCORhQc4HsYJQ/DwIIY+b/LrJ+vZ9zUnrXmO+ZYpoGzuJv24Q/+mbBd/4bp6rlnBcSb5FxXfV4larNFtQAHm/l8RFE7L1DuzPEf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oliS+NTu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5148UHp4006256
	for <stable@vger.kernel.org>; Tue, 4 Feb 2025 10:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Bbk6v/28CZWZB/e8V3KywwDq5m0DSq4iiyz
	z/FZspds=; b=oliS+NTuxK6FfwG3/cxiqqd9Xm8pp5WBNBIMm6b3tuDEqRMyMPW
	D9ygEJtnm+3iG9X2uovhNKbRwdP28AmJgnBMxoNZQrnN4x2vek9syfJB8EjaWa4Q
	8v0NWTP+ycV737y57sNRq+TGw9Dnbu0eH0U1ZE69mpysPkX15K8QhX1Dp2EvgMwT
	t9MdEV/nMzelUkdFhGGgMMTksW0a7RVMSG628DYMgx9CQx+3wI7DXowPJevJ9NEi
	Lr1zA3rYZrKSpuPCdxRX7yOMkwB5CpgxT5tTwCrZ60VY00aw23YEtY1BqHRPJLLK
	DZxFPEVLpQ4un+r3C/9QKWLmy+xVnnvI0wg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kfe9gckp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Feb 2025 10:59:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so10571855a91.2
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 02:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666760; x=1739271560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bbk6v/28CZWZB/e8V3KywwDq5m0DSq4iiyzz/FZspds=;
        b=rF5rPjLx1vBxmTy+DcJNv3EEXveL9tlVbciXTrkXEoPCRKi36Wo8b0g1ufrBpJylOz
         diQJ/9czgRkoNn8sNNrHf8nrYYcnA8BhbbKk6YwlkZIIQv7sjX+v8BqMDzYIAHrgKDcC
         y7lZd/rTYhlCZ2sVHQh4KI7YuYSmOX4If3liQOx7D8Jt2ABq374aaLjtmZgf50q60QOD
         xMFOhoyYYJV3XkckuCb7C9GH1T8QuvBg+uSWRPyanR4GCAYwQTGL/WFlHG+YZpHCrVLV
         AHo4w1QRbvhn6rwwfWKKB+44JSdb0Unm0QztoWmrvSnjAvLm5aIOAvU43mRhYmHC9yBu
         9Wzg==
X-Forwarded-Encrypted: i=1; AJvYcCWXPrwDtTD88YgDxjnA9w8Db8P1muo8GduD7Kz7x3tInVvf9Vgqr9kUgmimPNGe/hMDCyokYLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oSlwUtE23t3Y5it3wL5LH6o/6rFelw+kMgG3eNMWRNLhO5wk
	jxr8qdwfYSS/9/LXGjdOjQ9zlYlcigLL3bksZgwr8fj8RiNqie3W+If6gZefzmYV8Tz6kT6dbHL
	tHIxziM9YnWebcKjQf18Lt5CUwavKrF2J1fxtakRSTeRrJOtUz/TEIMA=
X-Gm-Gg: ASbGncssc6wyx+UX8dw+SVE+VEmqlwOy0Pt+BNLr97Ky2Tv9lIoZDoj5UXmjhTm9ANd
	UdHj/NhNbOJiM5ALxVesbHHYVgspN9hOYkcLfsATO6uGfx/Sp3aKJ0yt9dgY6vzBF5D0VMzoWA7
	KZBK50QZ8STA4gvYV2pNMfvNgHsqa7VZHm74sxQ47K8wAR5IZATYRWq37mp0UqG39L9YrEJFPma
	0gaGKs7PDo8yGRvk5ivt3+tWoAqmM22SNRA+mLr/QPEv/qU8rr2FeXd2N3E2S9rBPzQGYuwiep1
	EMZ5DDeC2/38yXy/AqNtQO3hi7PlPVJsKg==
X-Received: by 2002:a17:90b:2f44:b0:2ee:c91a:ad05 with SMTP id 98e67ed59e1d1-2f83abc3987mr34859256a91.3.1738666760460;
        Tue, 04 Feb 2025 02:59:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDFBGFgvL9ZTIMVPksGB4FYma4HsKeELqR3L2h5d2h1EDl6nl6eH11BUBbOegxde5u3k9NJQ==
X-Received: by 2002:a17:90b:2f44:b0:2ee:c91a:ad05 with SMTP id 98e67ed59e1d1-2f83abc3987mr34859233a91.3.1738666760104;
        Tue, 04 Feb 2025 02:59:20 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d65a2sm11930665a91.29.2025.02.04.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:59:19 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH RFC] usb: gadget: Set self-powered based on MaxPower and bmAttributes
Date: Tue,  4 Feb 2025 16:29:08 +0530
Message-Id: <20250204105908.2255686-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1uDzVIjJmi5Vo-TJ7KWnPz7FNloFslCe
X-Proofpoint-GUID: 1uDzVIjJmi5Vo-TJ7KWnPz7FNloFslCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=404 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040087

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


