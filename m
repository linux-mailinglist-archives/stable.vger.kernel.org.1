Return-Path: <stable+bounces-144817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF4ABBEA5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0083B0F48
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5B279787;
	Mon, 19 May 2025 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+aWsw6z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DC26D4CF
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660212; cv=none; b=dXW0i1u4VWKeen+o+IBzA4GisyhnSOijs0apkese+lMoPYwOVJJtinmSA+KzDCbypNRLbctHSHgokYK8goSn8YU1A98k4Xna5YFDHvgH1ZkVnUNEsrkEbcurAV0M/UFDHe/H8pO9BpRyzzduori7KYfXbsUOvB43AxU6wvtTR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660212; c=relaxed/simple;
	bh=S//Jbkv8L1XUHHE+ne5mYZKI8Zd9PTs4xc/+NB8sYcY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UrU0HaihnQWDTSB0jPEFoCqjJ+5Ae1e+hP7849vDxW6ZFVZPmarVHPpjPS5reGoCktlM+o82jyJpsK4N0eJ8/wqHrCtdip3f4SOO6G6XNmccuXxXc+O035ldpiJHCfHzdjUhmrFf/A+c5Wpe9UuK8G0HY6J6Ap0fTakKi4SWoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+aWsw6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0FAC4CEE9;
	Mon, 19 May 2025 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660211;
	bh=S//Jbkv8L1XUHHE+ne5mYZKI8Zd9PTs4xc/+NB8sYcY=;
	h=Subject:To:Cc:From:Date:From;
	b=U+aWsw6zz00u3KMzg3SBravP9fQtwxXJ+lVTAxoSI8MBJPptpIe2O2nMPIoEVnvOw
	 kUOqNEwHC+QZlYZMRycX2VuOHv7JMQo4MGusX6vumsZEb00KMqRGY0qYVzoo44j2NU
	 KOpzh9EDOSQ8MgyS1l1CoWD3l00ING19sSDpOB/g=
Subject: FAILED: patch "[PATCH] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power" failed to apply to 6.14-stable tree
To: claudiu.beznea.uj@bp.renesas.com,prabhakar.mahadev-lad.rj@bp.renesas.com,vkoul@kernel.org,yoshihiro.shimoda.uh@renesas.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:10:07 +0200
Message-ID: <2025051907-refinance-ventricle-ea1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce71e85b29eb63e48e294479742e670513f03a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051907-refinance-ventricle-ea1c@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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
 


