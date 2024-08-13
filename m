Return-Path: <stable+bounces-67414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E944494FC18
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 05:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65592831E9
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 03:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61741A716;
	Tue, 13 Aug 2024 03:08:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF341862A;
	Tue, 13 Aug 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723518506; cv=none; b=jkTwFnKTk6bHZ4EIk1yv+ICwVEA825ovvhJabNbStvED9ShA7xxaUiNEhM9Sxu6/OFX2y3/CRs/rPxSs+q7N8DvUOUroyMzfnOtMi51CLrwtCzJFyToE+s+wffKxik+fuIZjhpoMojJQFtKdi83Q5LfZJAsMR3iV/R2KMRrn3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723518506; c=relaxed/simple;
	bh=G8mlqUI4Vj75JSRSXWP8BhfuW8A9ZPbv9FEMFDs01nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBUi/rCRfKk4PhcabIhCUaX7QPx8g+NLYMq5KuteubPvUY8VD8EJ+31u4EmqBE0PvskgZ9AZLDi/gFbT/5n8BO8O82/SUZrF19/SD2pY0EwF4I5q+hNk8mPzliYsLQ/bvXz4xhzXpDEuZZV+831hKYUHVkMquO0F0fqTDdJXRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3XQARzrpmFDniBQ--.21605S2;
	Tue, 13 Aug 2024 11:08:10 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: giometti@enneenne.com,
	christophe.jaillet@wanadoo.fr,
	linux@treblig.org,
	gregkh@linuxfoundation.org,
	sudipm.mukherjee@gmail.com,
	make24@iscas.ac.cn,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pps: add an error check in parport_attach
Date: Tue, 13 Aug 2024 11:08:00 +0800
Message-Id: <20240813030800.3949400-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3XQARzrpmFDniBQ--.21605S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fZw4xGFWxCrW5uryrXrb_yoW8Ww17pF
	WkuFyYqrZ7Xayqkws7Z3Z5WFyrCw1xta1xuFWUK34ak3W3KryFyFW293409F18Jr4DAa45
	CFsxKayvkF47AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In parport_attach, the return value of ida_alloc is unchecked, witch leads
to the use of an invalid index value.

To address this issue, index should be checked. When the index value is
abnormal, the device should be freed.

Found by code review, compile tested only.

Cc: stable@vger.kernel.org
Fixes: 55dbc5b5174d ("pps: remove usage of the deprecated ida_simple_xx() API")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/pps/clients/pps_parport.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 63d03a0df5cc..9ab7f6961e42 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -149,6 +149,11 @@ static void parport_attach(struct parport *port)
 	}
 
 	index = ida_alloc(&pps_client_index, GFP_KERNEL);
+	if (index < 0) {
+		pr_err("failed to get index\n");
+		goto err_free_device;
+	}
+
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -159,7 +164,7 @@ static void parport_attach(struct parport *port)
 						    index);
 	if (!device->pardev) {
 		pr_err("couldn't register with %s\n", port->name);
-		goto err_free;
+		goto err_free_ida;
 	}
 
 	if (parport_claim_or_block(device->pardev) < 0) {
@@ -187,8 +192,9 @@ static void parport_attach(struct parport *port)
 	parport_release(device->pardev);
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
-err_free:
+err_free_ida:
 	ida_free(&pps_client_index, index);
+err_free_device:
 	kfree(device);
 }
 
-- 
2.25.1


