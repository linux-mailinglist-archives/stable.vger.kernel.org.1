Return-Path: <stable+bounces-198100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6EAC9BF76
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 824EF348F93
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB0224B14;
	Tue,  2 Dec 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="foBXbNgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4551E51EB
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689642; cv=none; b=jbROM/VwX1jxO0+7yum1vkGPzqfDAlr8M5J24iGqSBPA8L5HWvzj+sx94n2EO929X9r/ZIl9+HxLCQmKOBhl4Z2UCc5x/PygkirvQd+dzDMv79FcanexxBqbLllQx6ljowK4s2daGAxkpP++75xAeujjL/6QPyxzFDIkKPSsDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689642; c=relaxed/simple;
	bh=PuE0OsiycQEAjozWW/YA33iV7J86b5HhgqUE0tHptqU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o45kwRAWefgZ44HICif1YMwXdRH/BLJVNRY/8hd8SLlAv09fk8eRJ+/DhD5en1BWNqBLYlKU73XhGJHfbQpbsESDNSNVWTtTJFue8uWTqGSKiEeFZ1fQOTov2fWRLGouiKK4QQxsz7ZRjWCM3YRoQO/R9I6ak9Qipx/jxoILECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=foBXbNgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE2C4CEF1;
	Tue,  2 Dec 2025 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764689641;
	bh=PuE0OsiycQEAjozWW/YA33iV7J86b5HhgqUE0tHptqU=;
	h=Subject:To:Cc:From:Date:From;
	b=foBXbNgUxPEOQl6zinwULF31wRqm/Dli3tmNHsFzEhHjW8Se+VPlWRkx8WwBKKZy/
	 TvWzucp0knwoqOPr+V7GBN22Wo/Y/34xQeOA4jIOvuYwFX35OKQGzBpayg9miQQB9V
	 WZPwLKrLwOJgoOyCAL462uGUA3TDKArrycXrSYKk=
Subject: FAILED: patch "[PATCH] net: dsa: microchip: Free previously initialized ports on" failed to apply to 6.6-stable tree
To: bastien.curutchet@bootlin.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 16:33:49 +0100
Message-ID: <2025120249-dormitory-filtrate-415a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0f80e21bf6229637e193248fbd284c0ec44bc0fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120249-dormitory-filtrate-415a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f80e21bf6229637e193248fbd284c0ec44bc0fd Mon Sep 17 00:00:00 2001
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 20 Nov 2025 10:12:03 +0100
Subject: [PATCH] net: dsa: microchip: Free previously initialized ports on
 init failures

If a port interrupt setup fails after at least one port has already been
successfully initialized, the gotos miss some resource releasing:
- the already initialized PTP IRQs aren't released
- the already initialized port IRQs aren't released if the failure
occurs in ksz_pirq_setup().

Merge 'out_girq' and 'out_ptpirq' into a single 'port_release' label.
Behind this label, use the reverse loop to release all IRQ resources
for all initialized ports.
Jump in the middle of the reverse loop if an error occurs in
ksz_ptp_irq_setup() to only release the port IRQ of the current
iteration.

Cc: stable@vger.kernel.org
Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Link: https://patch.msgid.link/20251120-ksz-fix-v6-4-891f80ae7f8f@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a927055423f3..0c10351fe5eb 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3038,12 +3038,12 @@ static int ksz_setup(struct dsa_switch *ds)
 		dsa_switch_for_each_user_port(dp, dev->ds) {
 			ret = ksz_pirq_setup(dev, dp->index);
 			if (ret)
-				goto out_girq;
+				goto port_release;
 
 			if (dev->info->ptp_capable) {
 				ret = ksz_ptp_irq_setup(ds, dp->index);
 				if (ret)
-					goto out_pirq;
+					goto pirq_release;
 			}
 		}
 	}
@@ -3053,7 +3053,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		if (ret) {
 			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
 				ret);
-			goto out_ptpirq;
+			goto port_release;
 		}
 	}
 
@@ -3076,17 +3076,16 @@ static int ksz_setup(struct dsa_switch *ds)
 out_ptp_clock_unregister:
 	if (dev->info->ptp_capable)
 		ksz_ptp_clock_unregister(ds);
-out_ptpirq:
-	if (dev->irq > 0 && dev->info->ptp_capable)
-		dsa_switch_for_each_user_port(dp, dev->ds)
-			ksz_ptp_irq_free(ds, dp->index);
-out_pirq:
-	if (dev->irq > 0)
-		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds)
+port_release:
+	if (dev->irq > 0) {
+		dsa_switch_for_each_user_port_continue_reverse(dp, dev->ds) {
+			if (dev->info->ptp_capable)
+				ksz_ptp_irq_free(ds, dp->index);
+pirq_release:
 			ksz_irq_free(&dev->ports[dp->index].pirq);
-out_girq:
-	if (dev->irq > 0)
+		}
 		ksz_irq_free(&dev->girq);
+	}
 
 	return ret;
 }


