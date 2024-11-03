Return-Path: <stable+bounces-89578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C69F9BA391
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9ED282E06
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 02:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756570812;
	Sun,  3 Nov 2024 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z47KS7c9"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D6524B4
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600914; cv=none; b=gZQbixz5CgbNJUSha7ihbrGIN/yA77mNacjN5YiHBaHc1MrMaaelFTsRiQospdAvY2Q3MHqeaAodB+UUd+WMWbsSacUf0mOOwKckrC9h9vDjDp7tCfXOsW9VcslhtEI9MEhxKNf82vCrlom0+kW7vJRAdqugEdGIjBeQbfdClCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600914; c=relaxed/simple;
	bh=/7dIMVDgdaFJWssZI6V7CUjseARncXSlYt0L3w8soVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kocQiJoy4kMVb0+8/W6nSNG6b+U54sA588LzNVCh1Z2k9vRlXfLIGO3ZR/ocpzMPJvINl4BC6GlGQ88X4DiOqeTDiLcg+IpwpqJUtRyZRbkBYh4DcztOB5Pyw/E498aqoE9pAwCTwcgQ8ER95+300wzEZfq97WK31OoclQALf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z47KS7c9; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=etn9vrz1BqZTKquGqU0R5ARIAQQ96fCpq+7Cmfc9hlw=; b=Z47KS7c9kZwUYIiYm4LbDOG4lB
	qDJu5oDMhd0+Rb7A8rfbiBYo3ZDpKTzZU4jKYVGPMhHfYbFEPp5kbJWiuvQwD5+OsoQsvuBCwrBe5
	VLek+o8e62Ixcup9K+Fc+mfDCSPBM6ub5dDXt/5Fv/xbQAHPLWyPZmKwY+IPIOUUOtbLHBcUY0U/w
	HJj4/9FKapZolAi4noACj4xa6ho7tP+A1/NVJe5cWJeao5Qexdjnti6uttzOxD+7xO1cDKEbmHG2k
	KFBQVHnFmBRCr52TYMViiHiFVWfyjwf09sJPalP7BQ1kbYCQG2u8rG28hOW4dpSdYe6QWTXXB3H3t
	4noDNJAQ==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t7QLn-0010Ey-F8; Sun, 03 Nov 2024 03:28:24 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	sylv@sylv.io,
	andreyknvl@gmail.com,
	stern@rowland.harvard.edu,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: [PATCH 6.1.y / 6.6.y 2/4] usb: gadget: dummy_hcd: Set transfer interval to 1 microframe
Date: Sat,  2 Nov 2024 23:13:51 -0300
Message-ID: <20241103022812.1465647-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103022812.1465647-1-gpiccoli@igalia.com>
References: <20241103022812.1465647-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcello Sylvester Bauer <sylv@sylv.io>

commit 0a723ed3baa941ca4f51d87bab00661f41142835 upstream.

Currently, the transfer polling interval is set to 1ms, which is the
frame rate of full-speed and low-speed USB. The USB 2.0 specification
introduces microframes (125 microseconds) to improve the timing
precision of data transfers.

Reducing the transfer interval to 1 microframe increases data throughput
for high-speed and super-speed USB communication

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Link: https://lore.kernel.org/r/6295dbb84ca76884551df9eb157cce569377a22c.1712843963.git.sylv@sylv.io
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index dab559d8ee8c..f37b0d8386c1 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -50,6 +50,8 @@
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
 #define POWER_BUDGET_3	900	/* in mA */
 
+#define DUMMY_TIMER_INT_NSECS	125000 /* 1 microframe */
+
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
 
@@ -1302,7 +1304,7 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1993,7 +1995,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
-- 
2.46.2


