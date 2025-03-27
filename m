Return-Path: <stable+bounces-126859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB3A73366
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACAE3AC2F1
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E408215766;
	Thu, 27 Mar 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvp3bB+6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0B215181
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082363; cv=none; b=GtTHNKvmaRw4cnH7QA92OYaeoiofiaCekur4wNv2txxBDXRNYaY9NUmHsZY6jxX/Ox25urXqYegHNPNAhTfA5XHlQzEwHj7uJ1+5EnziqyIgstEmw0kNei/EEYV5RLBIED0XzwrH+ZtXR8V9BSNDpurkP9FA251EVV3BkMQ+0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082363; c=relaxed/simple;
	bh=7q1uNEuHmGla+JuXXowEZSgbCDACVTPaRgrYod3ebQs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e3N3nSgYFTtcfrEa3SqLaEtvxvYlPHQw+czxjseGOnGTFQ1htaY70GdtEjd1UM2BysrUneZgIAzgpLwlNKAtiKyIU7DZVd+EY9b11M+O6fw1y2i1wAJ8ONANjuPyZnN7eqaIatXDI7TCo1cN1W6Eg/BdTx9oU8th3aRZ1YNCjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvp3bB+6; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-30bf93818e3so4230291fa.3
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743082359; x=1743687159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rvLl2g0pnUQZ5mu1E/NbAEL3ldOZpuU0L7idYoO3luM=;
        b=rvp3bB+6hiCwWHeSIY/c8wlcNQyKt9+w2o4GYHbqSC31a+Efor7LKKl0VeeZCkQChb
         cG0PO3s4Wc1Be/ZvVQPw7RSVTDjDnF4GRoooRL+Sw2kNoHII+uB038Aib7D0HKDy77lI
         kYeIpqS7g7l1836kAl26fSybVmwCDyjuaZh9eNdfTe8QoauC6DSizqcX/Y5C8VLTVXVw
         /VplaJmgA9yySu9PFzXCJWotV725ehYt/hf7nBTvk2EdzWDW5xODMgEDl5qrQ0/b/InP
         cc1XbgZa4+iNnMGSf+/rfA3Ox0psc4696P3q8Wj2/u513S7zSXWypx19fVUb8D25/5Ya
         i1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743082359; x=1743687159;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvLl2g0pnUQZ5mu1E/NbAEL3ldOZpuU0L7idYoO3luM=;
        b=EecdABroePJB4VXq+WG7lmRbwJvUMnfX8sJCiFETD1VOxdOAk5jOiEHhndDuJEpCy8
         2RgHlgxwsuoD1altjoj+/uQaiFlWF2jstc74Nq2YrEvjsMKVS37/dBuumwriiK8CV3dO
         tva4fyHs2wF1g5s/42sbfMNmtKjYCABzMKGFkPz6RC1pI59p28L/W/V8XKUvcfnMmtB2
         YcBBjVael3yQim/EPae9osH7PF6Xn3Kj0Ad3YYy54DoRDJcWGzuKIA1Wb0rvayDC2i6I
         ZIKTiOHocvIFkD6aIRpdz2BNGp1uO0wAVFxy25CTyXSi4FwGViV3J0Cq+/TMnVXCZjnB
         oS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhQzqAE5W53py6f3Gd2Qd+6Up5cZg8rPrUtQMganX57E7i+79l9nzfFJZ/bqhToamJdnTG7a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+VjjkplOef140FXEGUI7v94YFgsoZaziW9IUq7ULhDxG/OpP
	ub0w5LNZDf5k7MlKGqLi5vMRAL2RSkFA5kDuEiSSiFkOgWh5LvHtpSbDZyq8sVAo7HHO3pWZGyB
	jvA==
X-Google-Smtp-Source: AGHT+IFXYSDIEk3Zsgjrs9FwwLIjl1mfB6QZ/QmjE9jGOtRqznw9rbjqy8/6pPUL/MehEfDA3PcxvIpF8jc=
X-Received: from ljql15.prod.google.com ([2002:a2e:a80f:0:b0:302:40ef:439c])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:19a4:b0:30b:c9cb:47e5
 with SMTP id 38308e7fff4ca-30dc5decb94mr14870791fa.8.1743082359318; Thu, 27
 Mar 2025 06:32:39 -0700 (PDT)
Date: Thu, 27 Mar 2025 21:32:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327133233.2566528-1-khtsai@google.com>
Subject: [PATCH v3] usb: dwc3: Abort suspend on soft disconnect failure
From: Kuen-Han Tsai <khtsai@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When dwc3_gadget_soft_disconnect() fails, dwc3_suspend_common() keeps
going with the suspend, resulting in a period where the power domain is
off, but the gadget driver remains connected.  Within this time frame,
invoking vbus_event_work() will cause an error as it attempts to access
DWC3 registers for endpoint disabling after the power domain has been
completely shut down.

Abort the suspend sequence when dwc3_gadget_suspend() cannot halt the
controller and proceeds with a soft connect.

Fixes: 9f8a67b65a49 ("usb: dwc3: gadget: fix gadget suspend/resume")
CC: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---

Kernel panic - not syncing: Asynchronous SError Interrupt
Workqueue: events vbus_event_work
Call trace:
 dump_backtrace+0xf4/0x118
 show_stack+0x18/0x24
 dump_stack_lvl+0x60/0x7c
 dump_stack+0x18/0x3c
 panic+0x16c/0x390
 nmi_panic+0xa4/0xa8
 arm64_serror_panic+0x6c/0x94
 do_serror+0xc4/0xd0
 el1h_64_error_handler+0x34/0x48
 el1h_64_error+0x68/0x6c
 readl+0x4c/0x8c
 __dwc3_gadget_ep_disable+0x48/0x230
 dwc3_gadget_ep_disable+0x50/0xc0
 usb_ep_disable+0x44/0xe4
 ffs_func_eps_disable+0x64/0xc8
 ffs_func_set_alt+0x74/0x368
 ffs_func_disable+0x18/0x28
 composite_disconnect+0x90/0xec
 configfs_composite_disconnect+0x64/0x88
 usb_gadget_disconnect_locked+0xc0/0x168
 vbus_event_work+0x3c/0x58
 process_one_work+0x1e4/0x43c
 worker_thread+0x25c/0x430
 kthread+0x104/0x1d4
 ret_from_fork+0x10/0x20

---
Changelog:

v3:
- change the Fixes tag

v2:
- move declarations in separate lines
- add the Fixes tag

---
 drivers/usb/dwc3/core.c   |  9 +++++++--
 drivers/usb/dwc3/gadget.c | 22 +++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 66a08b527165..1cf1996ae1fb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2388,6 +2388,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
 	int i;
+	int ret;

 	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
 		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
@@ -2406,7 +2407,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		dwc3_gadget_suspend(dwc);
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret)
+			return ret
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2441,7 +2444,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;

 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_suspend(dwc);
+			ret = dwc3_gadget_suspend(dwc);
+			if (ret)
+				return ret;
 			synchronize_irq(dwc->irq_gadget);
 		}

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89a4dc8ebf94..316c1589618e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4776,26 +4776,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	int ret;

 	ret = dwc3_gadget_soft_disconnect(dwc);
-	if (ret)
-		goto err;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-
-err:
 	/*
 	 * Attempt to reset the controller's state. Likely no
 	 * communication can be established until the host
 	 * performs a port reset.
 	 */
-	if (dwc->softconnect)
+	if (ret && dwc->softconnect) {
 		dwc3_gadget_soft_connect(dwc);
+		return ret;
+	}

-	return ret;
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
 }

 int dwc3_gadget_resume(struct dwc3 *dwc)
--
2.49.0.472.ge94155a9ec-goog


