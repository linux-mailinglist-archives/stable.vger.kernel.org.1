Return-Path: <stable+bounces-144819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C843ABBEA8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CED9177E28
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3927978B;
	Mon, 19 May 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hUHm3TS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06AA55
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660220; cv=none; b=jLNKPIVEDewEEd19RkDVQ58x9GT+niMGGotqjYUNiMXH7zjy5FYl3aQbrvMlaPHLZ80BgT5wnDLyAIpYmsiDXsPXrbY30l9LTUPWY2nEcDRAE55V1ieDYmRsuWbZpopIqP+I8KEJpFv0SgZU0+U9NP90D8GlXt5wxDhJ6paagzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660220; c=relaxed/simple;
	bh=S1CJPWkp/d+zlLXtm3gsuBm4PFdiVP/OIdMizbbJBiw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jAW/g2OoUo4zgpBrzGda19MejD507zZNqN06u1MWup/baHE5R0u3ewoqAu3NjL8CvNdM2p6DJfpfM+O/uwTC5pdros0m4ywJvMeptR4nVfaEzPpt8MxZT8gGW0+RZ5yEZ0pUGyqNst/Yg+p0EgVsLA5pjuwvfOR1sFxW9yfBcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hUHm3TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CB3C4CEE9;
	Mon, 19 May 2025 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660220;
	bh=S1CJPWkp/d+zlLXtm3gsuBm4PFdiVP/OIdMizbbJBiw=;
	h=Subject:To:Cc:From:Date:From;
	b=1hUHm3TSF8QZGZdUfnpo08YOZAiScSfhK5mUEQbu0paZoh37KFJ8iqFt4VWUmjx4G
	 FPPpcojEiv3LBCh5AhPE6XQi7KOgcvkcGW42yLp/YK08D6XF4cpx4Mr8q6WlMaQiR+
	 LL/L8mj3DEz4eSMxs8VNbjfV2mkei518StEcwsgM=
Subject: FAILED: patch "[PATCH] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power" failed to apply to 6.12-stable tree
To: claudiu.beznea.uj@bp.renesas.com,prabhakar.mahadev-lad.rj@bp.renesas.com,vkoul@kernel.org,yoshihiro.shimoda.uh@renesas.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:10:08 +0200
Message-ID: <2025051908-squiggle-pastrami-b849@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce71e85b29eb63e48e294479742e670513f03a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051908-squiggle-pastrami-b849@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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
 


