Return-Path: <stable+bounces-99071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6449E6F19
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD5228220A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D43207658;
	Fri,  6 Dec 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyG1SIV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F66202C4A
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491000; cv=none; b=eGVGToly1FogAHIYJ0gPqOQnY8iuvgcKOcgXAOIe8En8VAkgR3NT3djXm95GvYxLoDnxbQ/TaGB0qbh0oUzxd98HJKF4AgKrO0dvUoir5dHKtmrVhR+7Y4CguFxkmspy5Y5D/Ml/9bx9TkiZ9wobqF1VjMK6VQ76G5hH8GyAsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491000; c=relaxed/simple;
	bh=JgYS5tZxGrOQISdmtDUjwoKd5O3x3KIy1zqK6aMMs8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G6W0A0LZIHPA5U8cQPDihN7HwnugqsbZAk6oCPUtBLyUSrxRgF3OLf6kgrVU+2qdOj+9E3hXxNKS8aAee7SRlzN/ib5RpoAYrknAHHruP/n6gROwlejwYD98imxrzlwAel404jQ+0VVvLsGZ9ixsbXKTQjft1zXh/t7wvtzVivA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyG1SIV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D0AC4CED1;
	Fri,  6 Dec 2024 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733491000;
	bh=JgYS5tZxGrOQISdmtDUjwoKd5O3x3KIy1zqK6aMMs8M=;
	h=Subject:To:Cc:From:Date:From;
	b=IyG1SIV2gNQZknyEjzLP4/B2auBjWW6KKxefRoWWpErtL5NvM3Z6jWXThIF7w1No1
	 nhtXYGF+Sx4HpU/v0b+0zOdsCM5pcI9FUz245zg+e2ITroHRfObuFoK06LMgaGdCP7
	 uEUCbvsRC6oy0D0i93axCyfGJB1eRSU/9wDUVuNE=
Subject: FAILED: patch "[PATCH] drm/bridge: it6505: Fix inverted reset polarity" failed to apply to 6.1-stable tree
To: wenst@chromium.org,dmitry.baryshkov@linaro.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:16:29 +0100
Message-ID: <2024120629-slashing-gas-5297@gregkh>
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
git cherry-pick -x c5f3f21728b069412e8072b8b1d0a3d9d3ab0265
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120629-slashing-gas-5297@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5f3f21728b069412e8072b8b1d0a3d9d3ab0265 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 29 Oct 2024 17:54:10 +0800
Subject: [PATCH] drm/bridge: it6505: Fix inverted reset polarity

The IT6505 bridge chip has a active low reset line. Since it is a
"reset" and not an "enable" line, the GPIO should be asserted to
put it in reset and deasserted to bring it out of reset during
the power on sequence.

The polarity was inverted when the driver was first introduced, likely
because the device family that was targeted had an inverting level
shifter on the reset line.

The MT8186 Corsola devices already have the IT6505 in their device tree,
but the whole display pipeline is actually disabled and won't be enabled
until some remaining issues are sorted out. The other known user is
the MT8183 Kukui / Jacuzzi family; their device trees currently do not
have the IT6505 included.

Fix the polarity in the driver while there are no actual users.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241029095411.657616-1-wenst@chromium.org
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 7ff17aa14b01..008d86cc562a 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2614,9 +2614,9 @@ static int it6505_poweron(struct it6505 *it6505)
 	/* time interval between OVDD and SYSRSTN at least be 10ms */
 	if (pdata->gpiod_reset) {
 		usleep_range(10000, 20000);
-		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
-		usleep_range(1000, 2000);
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
+		usleep_range(1000, 2000);
+		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
 		usleep_range(25000, 35000);
 	}
 
@@ -2647,7 +2647,7 @@ static int it6505_poweroff(struct it6505 *it6505)
 	disable_irq_nosync(it6505->irq);
 
 	if (pdata->gpiod_reset)
-		gpiod_set_value_cansleep(pdata->gpiod_reset, 0);
+		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
 
 	if (pdata->pwr18) {
 		err = regulator_disable(pdata->pwr18);
@@ -3135,7 +3135,7 @@ static int it6505_init_pdata(struct it6505 *it6505)
 		return PTR_ERR(pdata->ovdd);
 	}
 
-	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(pdata->gpiod_reset)) {
 		dev_err(dev, "gpiod_reset gpio not found");
 		return PTR_ERR(pdata->gpiod_reset);


