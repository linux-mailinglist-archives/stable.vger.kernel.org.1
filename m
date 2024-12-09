Return-Path: <stable+bounces-100171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D59E96E7
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE510188D905
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE27E233133;
	Mon,  9 Dec 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="SKnXtTZM"
X-Original-To: stable@vger.kernel.org
Received: from ci74p00im-qukt09082501.me.com (ci74p00im-qukt09082501.me.com [17.57.156.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF32233129
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750757; cv=none; b=mssaIpq0B77uQWaTHGafEzIi+5DQ+CO6JNKnlvRMykGKCLgO6Sj5ByDbcmi4cyE+wfJvs0Hm8NdLvAi1XgL4eYmC0IEHhzcupW3g6eNsmYYNNabS3tvJq2aKsA7au2FZAzsJdpAI6lIvdpXZr2ruLeI2EvUHsAdXCK3shewRmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750757; c=relaxed/simple;
	bh=H/i8KSikZ2sUIrUiS2Ekgr/swUIcXlVMiuTTZ8cXyDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxKvHDGhUbjH6WfG7SDwoVpB1YGVN80QbpuN7ZInyCjWKkhdyWrKPDgVQhNuIFrfbexH0oFvcYh3jTq5CfhQKBbKggRAATKXCDPTEqz/au4PwNODnyXnMBCOctzPr1Zum3WFtZljGTfG11uP6WwTrO1KsNbT+Bb9nMptCo1jVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=SKnXtTZM; arc=none smtp.client-ip=17.57.156.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733750755;
	bh=i3Jdan8uZVn7UNPErfqRxyIjXKkKSwc1fhtcBHUOdM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=SKnXtTZMhGx41kZA1vddt+ARNRi4myt8jn/Ncn07jvUYQVVIa73VN1MRpsn/TLlSk
	 /8A9WQnZ5WjUAzd6VGiZkV9pJY0HUZrvnkmyRF76IFOdNjuWuo49vwLOM5AtZL7Kp8
	 tEW2UDvo/ezp8EUgLv+K1eoiyLv+3D0lcPibqIU7A1iPDbNSnfpBm9Ux3ha/2ksRhd
	 mUYXxqQfAp0QLKg/oT/ZDldqCNh2sXsaneiI0CqcYf5XuP3o9HJtVTu9rL5nJdXnro
	 NOCp9ba3HQEYwUSU8UPcODtWVxCR8FwhdbPFAmJ/4UuKpAlP7ARf5bUZobojIeJs9p
	 ohyMVIb3l2f8Q==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082501.me.com (Postfix) with ESMTPSA id 75A7F4AA03B1;
	Mon,  9 Dec 2024 13:25:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Dec 2024 21:24:59 +0800
Subject: [PATCH 1/8] of/irq: Fix wrong value of variable @len in
 of_irq_parse_imap_parent()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-of_irq_fix-v1-1-782f1419c8a1@quicinc.com>
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

Fix wrong @len value by 'len--' after 'imap++'
in of_irq_parse_imap_parent().

Fixes: 935df1bd40d4 ("of/irq: Factor out parsing of interrupt-map parent phandle+args from of_irq_parse_raw()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 67fc0ceaa5f51c18c14f96f2bb9f82bcb66f890e..43cf60479b9e18eb0eec35f39c147deccd8fe8dd 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -111,6 +111,7 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
 	else
 		np = of_find_node_by_phandle(be32_to_cpup(imap));
 	imap++;
+	len--;
 
 	/* Check if not found */
 	if (!np) {

-- 
2.34.1


