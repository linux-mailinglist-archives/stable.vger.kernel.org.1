Return-Path: <stable+bounces-144821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC977ABBEA9
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456243B2130
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B70279787;
	Mon, 19 May 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C4TKWNxB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC16A55
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660227; cv=none; b=bEvpfCblOFiEs905DOmzpC8+JJzsBOTXkJt0sFLQI7TX0MVTminWq8iLfbHe99zZOYKLP1f5ysRK6bupaAlkhyymnmx/Hx7VzRrHaPhyFJytvY/GV/kJgGoBysKGgrpfgOLM9d4dJUs2MSxdYoZ5ddC/VvNjl55/hZ7MnEBAoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660227; c=relaxed/simple;
	bh=fC1G4qJorHSJMP7tu2fQeIuykG6ks9iZU5w19OgOxh4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mlA7eMZ5Z+oVTmHSmKfuytrMqACByHlqpmmI8tXY8tFEYeGTejdRMENdMhYFxODv3iI1I+YIJAGhlolPKU3HgwPZdiJoZJi0eeavR/hcuLMBoZ0InbOgiRHLHxc9PricU9W8DoQfQe3gFNO1ZXGO5NN5iiCXXR4I/V2LuTEQ06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C4TKWNxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70E3C4CEE4;
	Mon, 19 May 2025 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660227;
	bh=fC1G4qJorHSJMP7tu2fQeIuykG6ks9iZU5w19OgOxh4=;
	h=Subject:To:Cc:From:Date:From;
	b=C4TKWNxBGbDC3s4h7/kf262I46qDvWwTyj7fScWPWPX+3hK7uXqf9f5f8/o0e7yyy
	 Gu7uGiiSVCvmwRa4f/XT4mNWW2ciXrbO+F3dHagUFRMoBwsacBVOOvmQksHYgiMZF/
	 myrilYblopcEkJrFnAagavKKe4FNrcD6lOgdC5KU=
Subject: FAILED: patch "[PATCH] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power" failed to apply to 5.10-stable tree
To: claudiu.beznea.uj@bp.renesas.com,prabhakar.mahadev-lad.rj@bp.renesas.com,vkoul@kernel.org,yoshihiro.shimoda.uh@renesas.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:10:14 +0200
Message-ID: <2025051914-stopwatch-crumpet-385d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce71e85b29eb63e48e294479742e670513f03a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051914-stopwatch-crumpet-385d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ce71e85b29eb63e48e294479742e670513f03a0 Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Wed, 7 May 2025 15:50:31 +0300
Subject: [PATCH] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power
 off

Assert PLL reset on PHY power off. This saves power.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250507125032.565017-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 00ce564463de..118899efda70 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -537,9 +537,17 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	scoped_guard(spinlock_irqsave, &channel->lock)
+	scoped_guard(spinlock_irqsave, &channel->lock) {
 		rphy->powered = false;
 
+		if (rcar_gen3_are_all_rphys_power_off(channel)) {
+			u32 val = readl(channel->base + USB2_USBCTR);
+
+			val |= USB2_USBCTR_PLL_RST;
+			writel(val, channel->base + USB2_USBCTR);
+		}
+	}
+
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 


