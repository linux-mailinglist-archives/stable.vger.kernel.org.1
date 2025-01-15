Return-Path: <stable+bounces-108701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634F7A11E63
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5BD3AD5F4
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205421FC0F1;
	Wed, 15 Jan 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dI2EmcEC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5kvLVcl"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD71D5143;
	Wed, 15 Jan 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934338; cv=none; b=D3UvIZO+erOi+YKCOsp/8Q4BL8l7n+1eb09ffKI5TfxfJjYCCB7FJqTYMbD1stDlt2zolt5Di8z8IJqq13mdt1RHIJAboglmoo4IypXdOyVl4btdNpxj94HKD0eUUCj3Ro6wSbA/MypUsckpTPVIQqQJdngiy71Yjvow14ntb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934338; c=relaxed/simple;
	bh=at9yQuAhtTtRTQWYaJpRgalAuTR4EXL1B0ckNDvToVg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mo31MJSJEAoaZaZmthYJggRm+dsxjnGQrL/WWkS8w+zoyeHQ0rMFxIMhN48LJ32HeAa9+MDP0aM2bhaSyOWz3TG9Jy6/EtTRACB2+F26zsKzy4GLw/ljt/1i1ygzTq5KsK5VW/VULtcb8lqQm2Ox+irjXBmITcOc5I1BmircA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dI2EmcEC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5kvLVcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:45:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736934335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyOrt0G5uXuY3cUTkdiwQaMQUZayEJ5BdjAEe+8gxfk=;
	b=dI2EmcECztoK0hQBhISowka1eyTpiPv4f4V284Hie8L5FqGMGSSrAfox0J8rwanAqRmtPL
	YUwxFPiqSsMhmuyCX99SdNB5k9COA8LZasLCj/UbBHmrcALVUhWAHiV8JLk8x3+8XiCXlo
	BwR9dUgDp8SbeSEoEh9KVMGciz5R4gc8gc3Z1MYzLeU+0BE4h22ebyT189qnGUo2ZEK/Ob
	XldVg5BxX0HoUCagHC5IsT5Rl8M3ksoIP24CIEWPndDtPlRp9NTWDvejp0qpJaRipK3Cj2
	bjP76rcPSofFulirJNQBDX/qdui4OT25/Bqu4lZQLf7Y6eA6PiaVxnh8PMW4Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736934335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyOrt0G5uXuY3cUTkdiwQaMQUZayEJ5BdjAEe+8gxfk=;
	b=q5kvLVclI7shRyeMoWO1t4nBc5Gex2nnffznJra90eaWjM/uEKjGw9YvliEoJpRVSslQPt
	9SI3L4WB1wVYOfCg==
From: "tip-bot2 for Joe Hattori" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip: Plug a OF node reference leak in
 platform_irqchip_probe()
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241215033945.3414223-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241215033945.3414223-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693433486.31546.1035605960354830385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9322d1915f9d976ee48c09d800fbd5169bc2ddcc
Gitweb:        https://git.kernel.org/tip/9322d1915f9d976ee48c09d800fbd5169bc2ddcc
Author:        Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
AuthorDate:    Sun, 15 Dec 2024 12:39:45 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:38:43 +01:00

irqchip: Plug a OF node reference leak in platform_irqchip_probe()

platform_irqchip_probe() leaks a OF node when irq_init_cb() fails. Fix it
by declaring par_np with the __free(device_node) cleanup construct.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241215033945.3414223-1-joe@pf.is.s.u-tokyo.ac.jp
---
 drivers/irqchip/irqchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 1eeb0d0..0ee7b6b 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -35,11 +35,10 @@ void __init irqchip_init(void)
 int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *par_np = of_irq_find_parent(np);
+	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
 	if (!irq_init_cb) {
-		of_node_put(par_np);
 		return -EINVAL;
 	}
 
@@ -55,7 +54,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller can check for specific domains as necessary.
 	 */
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
-		of_node_put(par_np);
 		return -EPROBE_DEFER;
 	}
 

