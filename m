Return-Path: <stable+bounces-118692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8FA412A6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 02:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9218909D2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C9D156677;
	Mon, 24 Feb 2025 01:34:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA01537C8;
	Mon, 24 Feb 2025 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740360844; cv=none; b=fji8kBDCK/Fby+hJNh163wnq/p7MZsZ3R4qULsskG0dkOYjE8l1k+76TsHN0Q+SGRiVZ3MQLT8dIcZ3ePJggD9UfIt8dzsDT656/sbC8IAEtZuVXPNhhalrPL+h0ffjhkHM1UsmtkvYh5EXtN7W/hRHMBVBdTdha1eppb4cl1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740360844; c=relaxed/simple;
	bh=7XL2h2hW1xBQfS3RvO7aPyzUBxNged97N/J/f0eaYk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u2FzfudJL+5WMkv0fw33yy+pUAmQzyP8WrUJk7HLddt63JEFYi122jcr3E/aCAB7kBTbNFYubpgBAFCqUCFQF6EIFw9mpJljPZ+3eyZ8LGOT1hxmIPxudJNDF+LcWXi90Lb90z666zAMORSNKmJnyYFeZC6Ta7gr9k+lwABqhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABnbaFozLtn0cGYDw--.27817S2;
	Mon, 24 Feb 2025 09:33:37 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	make24@iscas.ac.cn,
	elder@kernel.org,
	quic_zijuhu@quicinc.com,
	kekrby@gmail.com,
	oliver@neukum.org,
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: Skip resume if pm_runtime_set_active() fails
Date: Mon, 24 Feb 2025 09:33:25 +0800
Message-Id: <20250224013325.2928731-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnbaFozLtn0cGYDw--.27817S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykCrW3ZrWrXryDZr1DJrb_yoW8Gw1kpa
	18JFW0kF47X3Wayw4jvFn2vFy5Ww4rCFW7Cr97Gwn3u3W5Aa48try8Jryag3WqkrnxX3WU
	ta1DGw1UuFW8GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

A race condition occurs during system suspend if interrupted between
usb_suspend() and the parent device’s PM suspend (e.g., a power
domain). This triggers PM resume workflows (via usb_resume()), but if
parent device is already runtime-suspended, pm_runtime_set_active()
fails. Subsequent operations like pm_runtime_enable() and interface
unbinding may leave the USB device in an inconsistent state or trigger
unintended behavior.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 98d9a82e5f75 ("USB: cleanup the handling of the PM complete call")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/usb/core/driver.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 460d4dde5994..7478fcc11fd4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1624,11 +1624,17 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	status = usb_resume_both(udev, msg);
 	if (status == 0) {
 		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
+		status = pm_runtime_set_active(dev);
+		if (status) {
+			pm_runtime_enable(dev);
+			goto out;
+		}
+
 		pm_runtime_enable(dev);
 		unbind_marked_interfaces(udev);
 	}
 
+out:
 	/* Avoid PM error messages for devices disconnected while suspended
 	 * as we'll display regular disconnect messages just a bit later.
 	 */
-- 
2.25.1


