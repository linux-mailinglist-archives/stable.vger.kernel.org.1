Return-Path: <stable+bounces-114443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5751A2DDF0
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AC11654E2
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C865B1DE88E;
	Sun,  9 Feb 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hyvvx8lH"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE051DE3BA
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106018; cv=none; b=ej9lwKzoHp8R3JG5kC0t5B33iu67LVHZir20jU5aA/iwg17PwWjm9RViAHgMgWkWmZQp/emhkW6fWcwqgVzf+66KSgaJTbTZczy9h5NZCmBntl04JPEcdkJ/p1vtytZCN0ra1OCaugC5Hm/qsegxhsTurIxV6uafmXKqvsrImUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106018; c=relaxed/simple;
	bh=OqfLLryDTrYu+I1LVEjY9wnlgXFaiDs1ypiygpWGReE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMp4j7fKsAVdVhNBheR6P98GPIZ/D+Lcinfy3CV6hHK+ESyeabCJM4yGn8a43NuScvwBleKTpwSjd24de45aWq7trPMv03QQ4LKD6cEZ2avVgEEABqull4zoHxeI6KrnJyWDQPtvCbZNPWWwyQRj7waY2Lr93Yl7DPsQN6yUocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hyvvx8lH; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=itBy9qCxfeKAmoPColawX+1dT3mRAnFnFY5Z861wbMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=hyvvx8lHhV5MSXhjHTDoUjkEqSuRV7lrb49V2vq0T/L0SR851hMQvlkvqt+vD6A8T
	 lRFBtXqGPEuUENAtficg9ApALD4jwouacIKS0GnmdsPMQUGmKgsTfcJ27My8EJh1ij
	 QhzsEfGMM5RD/taPaOwepJoJ+b056GCCOzQ+kiD1WiBgFbVVGJhIxPDYQq2g0eE7RJ
	 xpb3uEvS++ytgXCpHj/Fy8ivlbvZ1/f8L0+aXFwLOb29ipP9XVyhbYf+tK2Uo/Anyz
	 rROdjfWEy9/wVLYfWaA1gQVRnI/lyjgoKYs+nHibyQS4CWl+uZRIVaz6fouHx5VHZG
	 Ey5xG3RvHKKSg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 8803BD0008A;
	Sun,  9 Feb 2025 13:00:10 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 09 Feb 2025 20:58:59 +0800
Subject: [PATCH v2 6/9] of/irq: Fix device node refcount leakage in API
 irq_of_parse_and_map()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-of_irq_fix-v2-6-93e3a2659aa7@quicinc.com>
References: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
In-Reply-To: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, Tony Lindgren <tony@atomide.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Oj71nTUld6c26RoWbQHJnJM822Ci5Lbk
X-Proofpoint-ORIG-GUID: Oj71nTUld6c26RoWbQHJnJM822Ci5Lbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=934 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502090115
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In irq_of_parse_and_map(), refcount of device node @oirq.np was got
by successful of_irq_parse_one() invocation, but it does not put the
refcount before return, so causes @oirq.np refcount leakage.

Fix by putting @oirq.np refcount before return.

Fixes: e3873444990d ("of/irq: Move irq_of_parse_and_map() to common code")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 95a482a584740c3a0f55b791157072166dffffe0..064db004eea5129efb7d267abf7c1133c9a76e26 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -38,11 +38,15 @@
 unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
 {
 	struct of_phandle_args oirq;
+	unsigned int ret;
 
 	if (of_irq_parse_one(dev, index, &oirq))
 		return 0;
 
-	return irq_create_of_mapping(&oirq);
+	ret = irq_create_of_mapping(&oirq);
+	of_node_put(oirq.np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 

-- 
2.34.1


