Return-Path: <stable+bounces-99070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E839A9E6F2B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184E8164AD3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A50206F2E;
	Fri,  6 Dec 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jw/pV8Uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921B1E1C11
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490992; cv=none; b=FYqnTaiv3FmB5/DZlU//lJnwU1YDGRt8BFUiZhWeQXeGcwuYyJeRMo0HDJpVmUfP81TNIugHIJmnIQC0FW2GxQbDDM+YwLy3JyzxThOFMyEQoPUXjfHKnQzAJCfmAoyZIKTolZry82Yv1+41aNrNNYmX3nOEvjZmhNspSMrW+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490992; c=relaxed/simple;
	bh=roNrLOD8HFoKCoNMiOUrzQ/e9KAcWbzJwC4L9ZvUTNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hSLjhJ2d/HkjaoIjvj7/Owpuq7893xXp/Q4SZO/N3rnLP4pGSlYWCdiSx3DiNSSBlVQ8pJdhPAHpp6r8Ftxt1H7iJaSpVmI+yoqIDRa858fjVsRWEWBfKLSpeA6xwkxOEBfQkXBHC7hwaRcIwSCW/661/SpGX2X6mEQ7+KEup0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jw/pV8Uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A54C4CED1;
	Fri,  6 Dec 2024 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490991;
	bh=roNrLOD8HFoKCoNMiOUrzQ/e9KAcWbzJwC4L9ZvUTNM=;
	h=Subject:To:Cc:From:Date:From;
	b=jw/pV8UzORXTs8K3+8PKSNUkYsYAa2ptDrDAgk0lkawcJmTPHmz2m1s7K3788NK87
	 ekuXdt61JFOrtq2Zi9gZ9sg6fQcNgdzolUyw1AUAZCKXYb33aujGi3bcOks+WzvjaB
	 KbICG2Bf315rbrMAgYYbsyTGtVJFn8oZP7QpvvA8=
Subject: FAILED: patch "[PATCH] drm/bridge: it6505: Fix inverted reset polarity" failed to apply to 6.6-stable tree
To: wenst@chromium.org,dmitry.baryshkov@linaro.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:16:28 +0100
Message-ID: <2024120628-size-spiritism-13d9@gregkh>
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
git cherry-pick -x c5f3f21728b069412e8072b8b1d0a3d9d3ab0265
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120628-size-spiritism-13d9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


