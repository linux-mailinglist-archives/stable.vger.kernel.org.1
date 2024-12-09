Return-Path: <stable+bounces-100176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A09E96C4
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F11C2822E2
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EE1A239F;
	Mon,  9 Dec 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yw0TlJrE"
X-Original-To: stable@vger.kernel.org
Received: from ci74p00im-qukt09082501.me.com (ci74p00im-qukt09082501.me.com [17.57.156.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D3233158
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750802; cv=none; b=cd5kxzlv/hIqNf7V/DrE4haiDodIN6OxEUAXyG8cLdV6uqp/PifTaq0YWdCvku7otFS0cL6dJLCXDSZmNL8K7q7Tk6ck3ulI8I7K0GHWhX/gy/RGeovkNGStMhfSkTvbtfJckARi3RMvi/k8i3LnTwr0JBAJn4y+Kv1YYzlhN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750802; c=relaxed/simple;
	bh=vOBJoOrL2GOjzvg2/KzQS+hC+9xTjENJAFJuV21+KHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDPziBhByTk/xDUG7l/zB/M9lyshXcRZ4h4q0W8cFiV/DhqI1zCZ/hQn+aZ3kK0/n4/M8nY1T5fUBVmPyNgtXp1qd7opNecmxZj8JVQQDUZYHowE3qcZxEDHCLn3Etm//3AqGX/JzeNFXmylqCn90H2oR0Kq1po4kEn5WKZ0AY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yw0TlJrE; arc=none smtp.client-ip=17.57.156.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733750800;
	bh=ggXYd9pgZjM1MUcos/NcrgUkTxu66JwJEpIUgGpEx3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=yw0TlJrEl4exmcyy2nBsCzk4Y8P1ilcwejsAxqdK2lf/UMvOwZFekyEhRaf1iYaau
	 lE39f0QMzUQAHWOiq6ox/kJ3M9QWCPOxJ7RaYagvptNAYyZGXXxZYzGTCE0Ddgxo1Z
	 U4CZQPAnKzgji4uNh2E+OJksG8I2cfcoTf0n8zgF+Re9ULi1mE9Gy847cDRNoOGTMS
	 C4py3MmZ6D4RZCwj6chIq1Q0qh2xTh5Eu+8rHvqUnjY2OlWT7+4Meu6nH55yxs0rOi
	 2guiy1pUQYiQl5E3BYcx/ERPpMZGciF97m5RotTVQeLPF7UlrwVIhmbco5rCjwoHzu
	 PKLu9lPFVVl9g==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082501.me.com (Postfix) with ESMTPSA id C7DD14AA042E;
	Mon,  9 Dec 2024 13:26:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Dec 2024 21:25:05 +0800
Subject: [PATCH 7/8] of/irq: Fix device node refcount leakages in
 of_irq_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-of_irq_fix-v1-7-782f1419c8a1@quicinc.com>
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

of_irq_init() will leak interrupt controller device node refcounts
in two places as explained below:

1) Leak refcounts of both @desc->dev and @desc->interrupt_parent when
   suffers @desc->irq_init_cb() failure.
2) Leak refcount of @desc->interrupt_parent when cleans up list
   @intc_desc_list in the end.

Refcounts of both @desc->dev and @desc->interrupt_parent were got in
the first loop, but of_irq_init() does not put them before kfree(@desc)
in places mentioned above, so causes refcount leakages.

Fix by putting refcounts involved before kfree(@desc).

Fixes: 8363ccb917c6 ("of/irq: add missing of_node_put")
Fixes: c71a54b08201 ("of/irq: introduce of_irq_init")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d917924d80f563e1392cedc616843365bc638f16..29a58d62d97d1ca4d09a4e4d21531b5b9b958494 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -634,6 +634,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 				       __func__, desc->dev, desc->dev,
 				       desc->interrupt_parent);
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -664,6 +666,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}

-- 
2.34.1


