Return-Path: <stable+bounces-100178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D89E9718
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75CF18890B6
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FB4233132;
	Mon,  9 Dec 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Wso66Tc9"
X-Original-To: stable@vger.kernel.org
Received: from ci74p00im-qukt09082501.me.com (ci74p00im-qukt09082501.me.com [17.57.156.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4E233133
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750809; cv=none; b=N+lqDVpDsMmX1dTuZao8EsoUwV8dVM/fzCRpjRot8vJqjViFjm28HPHwQtp2h4sWQ42ZzAndFirPTXqRoJ9ecOl96nbRJFvCvS3mdyvMvwYCwO+GLjXSgxSb5Ufg6VXoeEJsc46FysFZgXEdGCNkrF+bns7r53HKa2KrwF1MuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750809; c=relaxed/simple;
	bh=K0Lwr+5Zc7hqtyeiWM0OCk8PT5tW57AsknNOd5lB1Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDT3U+w7P7Q8pZLk6UaMuPLBZ98nTmYtNORl14RrEhhBhuViHGmnTia6dtvLDXLTvW0B3DpyFplr4MNHUiBiOy4FEGcP53GVsLwu/ApVrRmqqFY2ZBhUkjldt4CjK+KKqW5Pqmdof9xzCR95i+eiFJjZXMLI6YFSmHu53uTwcRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Wso66Tc9; arc=none smtp.client-ip=17.57.156.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733750807;
	bh=o+mb1+yAyOmCC9VR27IaIt7teFx55tYGAzUNXG1KmaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Wso66Tc9D+q1txBNGW41589RkhLNh3tjT/q7i4ups0/XZb4hY7jNrnSdkUbJSLzU8
	 bQ88UlhyUPk+iDNeG7dIwSV/HnQZLNeWzfp/QH+T7PyzEvccAZhpidDODrCfa8jDNH
	 YbRCw4WaXqpQkRjP27+5ZuyQeIAIQZSjrjRAYrFu9rkdQZUIb9DoKTSYFUNRf4L+Jh
	 BoqzGPd81n2WwiDXnrp+M46qQbnOEc7nzJoGntMxMQuIIxakvGpuZcnZKU1t/DFjOO
	 IIbczDQyslVs2aCGzP1q7OCCMHAVpF/hd4uXw+i6TyEs7ZGwLC4gjFOJf39l4CrjpF
	 VTxbw2FMKIJPQ==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082501.me.com (Postfix) with ESMTPSA id A10FB4AA010B;
	Mon,  9 Dec 2024 13:26:40 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Dec 2024 21:25:06 +0800
Subject: [PATCH 8/8] of/irq: Fix device node refcount leakage in API
 irq_of_parse_and_map()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-of_irq_fix-v1-8-782f1419c8a1@quicinc.com>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
In-Reply-To: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, 
 Grant Likely <grant.likely@linaro.org>, Tony Lindgren <tony@atomide.com>, 
 Kumar Gala <galak@codeaurora.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Julia Lawall <Julia.Lawall@lip6.fr>, Jamie Iles <jamie@jamieiles.com>, 
 Grant Likely <grant.likely@secretlab.ca>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, 
 Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
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
index 29a58d62d97d1ca4d09a4e4d21531b5b9b958494..b43c49de935c76cbf1e49391517dd7b1a569b7fa 100644
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


