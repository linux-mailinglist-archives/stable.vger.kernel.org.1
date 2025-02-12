Return-Path: <stable+bounces-115041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC9A32340
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E8B3A4805
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80A207E04;
	Wed, 12 Feb 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oMm7YIZo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460122063C7
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354933; cv=none; b=N9uQeBvAaO+1kHdRTbd/VczkJAlDf6MuQaCYO0tLuNQlM9aMxrUqQVhIAYlBMrFrNONu0mLUTxjU1p0lIW84d1CPf3GPLV7AD+R0JA1+J6Ja8l23V2Uvpz7qF2QSuHey3kl92mKTvZ/loQlogw6WI+4/PckfPNgegvTXFsltpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354933; c=relaxed/simple;
	bh=TCwfIE/pUasluVSwZTdHWUH2y9kGY+p5IU5lrrQ0aXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1FDRzSBoCkaj1sxw3wkqMJt0nCLmEc8GcJN/CW/3BLKGgZnPDsE9AlohYQ7DLTYkmF3DsMGOo8RgW3jaHzvQyK/QEWLIJSCc4+isr6IaALkRqEJT+PQ8ed1bIiMosdy0rbiTeIqQfUqKQPx7mSjOoshJSxqAwEdzSYr9x16I58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oMm7YIZo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C24u7n010407
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 10:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B21EnyUYOIhZzIf5xVM2mRo1SahizWAydB+
	PPvQassE=; b=oMm7YIZobwLDYtUoNSqzPIWZNhkDJkCirtGEzxbCSz8WKm4YUUU
	rzYtbqDN9Zs+O6DnQCx8tK/28YOGM7xA4m2o72pbddvppru7lX/eYRFTxZ/JYfqo
	Tv04T9FJutBmZeNFZtRZgcQm29ZxBzd92e8HNqKgZITmT/5bY9DdM/qGZTRh5oU3
	ZX/T5eLDVZ+Z5sanm8QXPVTr41dp1tdLpcB9T2Y2RSAlNz/DoxdAWnHTGVGW1F7g
	ScD0tVnUeiKctd+lHdmid3tP/M5C5jRZJ89W2fKzpy/MryMsd6Wt9PDqIoFB6iLI
	g/fm5q1BKZNd7uao4ITlGuR0IC9uJnGpynw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qcs5feru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 10:08:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f42c8f5f6so89051085ad.3
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 02:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354927; x=1739959727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B21EnyUYOIhZzIf5xVM2mRo1SahizWAydB+PPvQassE=;
        b=m8aU000ejr5g9YReNb9kgsCwQfGPcP42kME7ul+eWAiCClKdExvbH6/cdmHTJfd19M
         US2pedJ5bxpkvi52TdAMrxW516AgIOy8aTdP62u8FJrdmNiA3Tm/K75Pl+XyNUIX0rFe
         hzX7ku4/l5a4/1aK1kn684QEl0O185arfXiMC5hvR0+rqZAAuQRfZEo/8D91MgFJvaje
         AQPgKyQVbrWxnxpxwc05//HZ8Gj6zNwrsjvDDZ7N8Lrw/2ut/meahcGDKT/mBVzgBcD5
         K/Xzmmuf535lI0qXeFiIn1g+z5oKoE4oAt4pDpnD/NYcc59UjLDuy8OROV60JMUUyW8v
         7WMw==
X-Forwarded-Encrypted: i=1; AJvYcCU8KdOHt+emT2aQLhYz4PlhjvVeWXHH6FBhJDaUxRmC7/YU8XHdmfU88DDwLgvzhVfMLHXETB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwYZshjjHobESzhy0ekowzaLpPghx+gM+JjMNUR08KClfcCfQ
	80Vr7IGzdh0NBliZ/s408pdPUJ+ADcnc+nmQMBZlF5/VcAIOMxe3/+FDbJXsbXJymkqvzcQrCGE
	/ivqRovHlTGu3MqWrw9siFjg52AR+1Q3Y8hnuprBnFgOo9weDwv1EuCM=
X-Gm-Gg: ASbGncsS/15Jv/LpFTL8r+EDyHt+e7lDjg3PL8gMwzS0EPSoIBtuXrxn8/PbvPmc3md
	XftIewpmkQ/vqLTxIwP0DXj28yCvCntK4yzde94AjYXJTBE8djRpyyq6MlcXi5wBtlRjQ3Onm47
	SG8eSksB5CyttlkivTZeK1CjghheQ5wp8cLszMOXjaGRduqgzKsvG7pUuZno4oeyFd4Vu1kYx9s
	11XQ9elpYh8d6BdPEe3aD9MAPXlzUphSFen67SACcsytXUh6mdBY6OcA1Nt25nG7wopeSSSo28G
	P0hkioYqHuReeiYAPlScSY+v1gJ4uWZFyQ==
X-Received: by 2002:a17:903:32c8:b0:21f:5638:2d8 with SMTP id d9443c01a7336-220bbdd906dmr49597935ad.53.1739354927470;
        Wed, 12 Feb 2025 02:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5QcjisXpRuziURHZeTlGA14PANI0hISRmK+4kzlfLZqi/cdkjxjyPK2eRmbaTegnFEn+qyw==
X-Received: by 2002:a17:903:32c8:b0:21f:5638:2d8 with SMTP id d9443c01a7336-220bbdd906dmr49597525ad.53.1739354927105;
        Wed, 12 Feb 2025 02:08:47 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f365517desm109635795ad.86.2025.02.12.02.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:08:46 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Ricardo B Marliere <ricardo@marliere.net>, Kees Cook <kees@kernel.org>
Cc: linux-usb@vger.kernel.org, Elson Roy Serrao <quic_eserrao@quicinc.com>,
        linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH] usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
Date: Wed, 12 Feb 2025 15:38:40 +0530
Message-Id: <20250212100840.3812153-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oOru977MuxCcdodBZ4nniimQEAW5M1PJ
X-Proofpoint-GUID: oOru977MuxCcdodBZ4nniimQEAW5M1PJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=738 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120077

Currently while UDC suspends, u_ether attempts to remote wakeup
the host if there are any pending transfers. However, if remote
wakeup fails, the UDC remains suspended but the is_suspend flag
is not set. And since is_suspend flag isn't set, the subsequent
eth_start_xmit() would queue USB requests to suspended UDC.

To fix this, bail out from gether_suspend() only if remote wakeup
operation is successful.

Cc: stable@vger.kernel.org
Fixes: 0a1af6dfa077 ("usb: gadget: f_ecm: Add suspend/resume and remote wakeup support")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
 drivers/usb/gadget/function/u_ether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 09e2838917e2..f58590bf5e02 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
-		return;
+		if (!ether_wakeup_host(dev->port_usb))
+			return;
 	}
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
-- 
2.25.1


