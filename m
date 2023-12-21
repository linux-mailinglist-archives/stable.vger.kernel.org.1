Return-Path: <stable+bounces-8224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7423F81AE83
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 06:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B08B20EC6
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C39477;
	Thu, 21 Dec 2023 05:47:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC7ED29B
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (unknown [81.20.112.87])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 83CB45F784;
	Thu, 21 Dec 2023 06:47:45 +0100 (CET)
From: Fabian Godehardt <fg@emlix.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [4.19] please include b65ba0c362be665192381cc59e3ac3ef6f0dd1e1
Date: Thu, 21 Dec 2023 06:45:47 +0100
Message-Id: <20231221054546.2045316-1-fg@emlix.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023122014-defendant-breezy-5e93@gregkh>
References: <2023122014-defendant-breezy-5e93@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> As you did the backport, you too need to sign off on this. Can you
> resend this with that properly added?

Sure:

From c88f647a482b7258b428c9ae567a9fce6fa95e96 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 28 May 2021 16:04:46 +0200
Subject: [PATCH] usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling

In commit 92af4fc6ec33 ("usb: musb: Fix suspend with devices
connected for a64"), the logic to support the
MUSB_QUIRK_B_DISCONNECT_99 quirk was modified to only conditionally
schedule the musb->irq_work delayed work.

This commit badly breaks ECM Gadget on AM335X. Indeed, with this
commit, one can observe massive packet loss:

$ ping 192.168.0.100
...
15 packets transmitted, 3 received, 80% packet loss, time 14316ms

Reverting this commit brings back a properly functioning ECM
Gadget. An analysis of the commit seems to indicate that a mistake was
made: the previous code was not falling through into the
MUSB_QUIRK_B_INVALID_VBUS_91, but now it is, unless the condition is
taken.

Changing the logic to be as it was before the problematic commit *and*
only conditionally scheduling musb->irq_work resolves the regression:

$ ping 192.168.0.100
...
64 packets transmitted, 64 received, 0% packet loss, time 64475ms

Fixes: 92af4fc6ec33 ("usb: musb: Fix suspend with devices connected for a64")
Cc: stable@vger.kernel.org
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Drew Fustini <drew@beagleboard.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Link: https://lore.kernel.org/r/20210528140446.278076-1-thomas.petazzoni@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabian Godehardt <fg@emlix.com>
---
 drivers/usb/musb/musb_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2a874058dff1..4d2de9ce03f9 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1873,9 +1873,8 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 			schedule_delayed_work(&musb->irq_work,
 					      msecs_to_jiffies(1000));
 			musb->quirk_retries--;
-			break;
 		}
-		/* fall through */
+		break;
 	case MUSB_QUIRK_B_INVALID_VBUS_91:
 		if (musb->quirk_retries && !musb->flush_irq_work) {
 			musb_dbg(musb,
-- 
2.30.2


