Return-Path: <stable+bounces-98948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288059E6906
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FB81882C40
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 08:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6A1DB52D;
	Fri,  6 Dec 2024 08:35:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1F6FBF
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474117; cv=none; b=dRJjd57LO2uEx+NhBQsKl4RMUrST52rfaGLy5bm41Q213yHuwk5wxlGfvNlHJRSrPT1lgCApa8XkVyeok+dmIWocJsmwlr6Q0Zh+lGhZLnAranp1jweRxuBqQQgiCzvCHOtpKLJZ8kOkC8S0h5TFXP+eWitcyqQYGRqz+V+49Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474117; c=relaxed/simple;
	bh=z7iM/covW97ys+D32rC5qV8I6qBJB+AFReA3wSZATSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ob/ANC1lnUSB+tnU3RxljXoE9o0tC0jO4ycLHYDhDqjLy1JqaDaDDJfV16tJhA77BYClgYZQP3cYEXwvc5ObbPSZkmtJ+eyhMGKEEkrBar3+ulh6FAWloezxM3wsNvs0+f1r1ooaOZVkVCrRTYOTm2vF/IO0Rt6CqJAzBeZhFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66w2u0007348;
	Fri, 6 Dec 2024 08:35:07 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 437sp773jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 06 Dec 2024 08:35:07 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 6 Dec 2024 00:35:06 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 6 Dec 2024 00:35:05 -0800
From: <jianqi.ren.cn@windriver.com>
To: <rand.sec96@gmail.com>, <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Fri, 6 Dec 2024 17:32:56 +0800
Message-ID: <20241206093256.939765-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Qvqk3Uyd c=1 sm=1 tr=0 ts=6752b73b cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=RZcAm9yDv7YA:10 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=maAJvPpQ-1jnF_CgM8MA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: KrltXpd8z0mBXo3BueAh0vrznw6s0MCX
X-Proofpoint-GUID: KrltXpd8z0mBXo3BueAh0vrznw6s0MCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_04,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=761 malwarescore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412060061

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]

The ssb_device_uevent() function first attempts to convert the 'dev' pointer
to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
performing the NULL check, potentially leading to a NULL pointer
dereference if 'dev' is NULL.

To fix this issue, move the NULL check before dereferencing the 'dev' pointer,
ensuring that the pointer is valid before attempting to use it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index d52e91258e98..aae50a5dfb57 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.25.1


