Return-Path: <stable+bounces-144822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35BCABBEAB
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9203C3B23E8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8C2797BC;
	Mon, 19 May 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNdpHcfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474942797A8
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660232; cv=none; b=Mh+Hb/zbu9J46arE4ygSy8v6UungnH4DzZFJ8Vhp4I5kuukHATdyjqTcHSAw2yOtMmFnwdMB6RJMi+3zfQAesO3vp5rIyMolQqnHGXos47kYDbM/asRyqXiA9ncz9LaHCYaAQRNk/9ShJ9BKaBandgMy/jd0HlMud7Z2lHViFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660232; c=relaxed/simple;
	bh=xbBzmx0/haNQz+VuPrpqaO/CBRGFYt4A4TB/z+XfsB8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uAXPK1Dxb8E1ZxXQ9e8A1poC9FyRx4gwfH8GyGI05c3Qak54vOw/xNIhDKI8KCOnlJhwaHGL6hkG611+zUQy0KzgSn+hPVN4kC7Jw/cL/e+E/Fj/ueC4HBOc6FS0Cup3mixxEBj33sm3TG4Be5Zw6Mom5qZ6HHcD4+hqDN7x418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNdpHcfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387EFC4CEF4;
	Mon, 19 May 2025 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660230;
	bh=xbBzmx0/haNQz+VuPrpqaO/CBRGFYt4A4TB/z+XfsB8=;
	h=Subject:To:Cc:From:Date:From;
	b=JNdpHcfKu8LMBvKuZq4iNf2hpHWX2rR1vroSy1lmNgL++D30/qZRgtlVJNAkTZR26
	 zTgbha04LKp9ERJ4f5U5DgbwuYBbGQ7xUB5K9X8X7cOstBEs0J2xdD6FyOvcizySsd
	 ro0QtBDvUViHWHrBe5GMtyafDCso6nEmlYZ2zwhQ=
Subject: FAILED: patch "[PATCH] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power" failed to apply to 6.1-stable tree
To: claudiu.beznea.uj@bp.renesas.com,prabhakar.mahadev-lad.rj@bp.renesas.com,vkoul@kernel.org,yoshihiro.shimoda.uh@renesas.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:10:14 +0200
Message-ID: <2025051913-shaky-bamboo-9c7a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce71e85b29eb63e48e294479742e670513f03a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051913-shaky-bamboo-9c7a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


