Return-Path: <stable+bounces-144350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19F8AB67FB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 11:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7A7A3089
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381CC25D90C;
	Wed, 14 May 2025 09:51:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148AD529;
	Wed, 14 May 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216283; cv=none; b=tBlCQ3iJkwkAeF5dis5PYSXMLNcN4jfNTMDlGe0XPKJkq1MeXw+KJxjPpijyU3YK2NZ/uCzZYpGaeHCdSB9LMU1WCweG4/RhoemILN313kRGUBoIrymzSvtKy8Ur0sxYYqwU7KCBeEnd1ZN85TsxjliXjMUC/630i7p08InDPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216283; c=relaxed/simple;
	bh=pPytq2xngHnqIvsv89X3PysVr0XkI18QW8kCv6FzIoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYdk/n9FJpRFHOs0CBVrRq0V3aFAsVLGdWkFYs8NjtWKrpb5JaT+4m7a/P9msHcGjsUKQoMuOkQMAnTuiJ3zkM8V/Knn1g2ljbnkdiYvA9NHAxphzKBTDsBnSFWbSQSxfa7wMLJ1Axk12OCGBkAsWmQW00E2UEtmmcdj3SFUFS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAHRQ2OZyRovH4uFQ--.28565S2;
	Wed, 14 May 2025 17:51:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	u.kleine-koenig@baylibre.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: udc: renesas_usb3: Add null pointer check in usb3_irq_epc_pipe0_setup()
Date: Wed, 14 May 2025 17:50:53 +0800
Message-ID: <20250514095053.420-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHRQ2OZyRovH4uFQ--.28565S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWrCrWDGF18tw1UXFy3XFb_yoW8XF13pa
	1DGrZYyr4rJa1Yqay8G34kZF4Ykanxtry7uFWxtw4kC3WrX3ykAFnFqrW7KrnrAFWxAF4I
	qFyDWw10kFy7CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUatC7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4CA2gkZDgLRAAAsZ

The function usb3_irq_epc_pipe0_setup() calls the function
usb3_get_request(), but does not check its return value which
is a null pointer if the function fails. This can result in a
null pointer dereference.

Add a null pointer check for usb3_get_request() to avoid null
pointer dereference when the function fails.

Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller")
Cc: stable@vger.kernel.org # v4.5
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index fce5c41d9f29..51f2dd8cbf91 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -1920,11 +1920,13 @@ static void usb3_irq_epc_pipe0_setup(struct renesas_usb3 *usb3)
 {
 	struct usb_ctrlrequest ctrl;
 	struct renesas_usb3_ep *usb3_ep = usb3_get_ep(usb3, 0);
+	struct renesas_usb3_request *usb3_req = usb3_get_request(usb3_ep);
 
 	/* Call giveback function if previous transfer is not completed */
+	if (!usb3_req)
+		return;
 	if (usb3_ep->started)
-		usb3_request_done(usb3_ep, usb3_get_request(usb3_ep),
-				  -ECONNRESET);
+		usb3_request_done(usb3_ep, usb3_req, -ECONNRESET);
 
 	usb3_p0_con_clear_buffer(usb3);
 	usb3_get_setup_data(usb3, &ctrl);
-- 
2.42.0.windows.2


