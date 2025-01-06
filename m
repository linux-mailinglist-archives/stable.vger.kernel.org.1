Return-Path: <stable+bounces-106811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8949A02336
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B6C1635A7
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440519E7EB;
	Mon,  6 Jan 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rGFAstg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521DB676
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159948; cv=none; b=TRxqbFht3gWhT9gDQmzL8NL6AB73p6Emkvpumn0Hb5gJ7mJgOLnsfzE9AHZMwed9sa+ZvV/s/tl86tP02Iywc5CZ47CILuR8zxQUu/ZerhXUIt8u2WGJ25T/iMZo7eiQNgjZSTshMFgqLFevEaMJpSRoE/8u8T7eLCOvIhQL0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159948; c=relaxed/simple;
	bh=Ozb5RYd4mVlkCQjRUUnhrP6qi53pnQPr+LKyzLJDQKE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CVLaSrDVGyZX+L/oCDje0S6nCmITIkoJcGhAoQdw3GsgGj4e7VSeKA9qeIYmVji+BGIeapKuow15UtDPYLy17rUI7jE2YG7sVnZBduDECDBiF9DWuQ0y3LWDetBmhvHzqCF4I6u5777p/PaskS9yjyyQCD1hFQEZG3EdrGdPt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rGFAstg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A7C4CED2;
	Mon,  6 Jan 2025 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736159947;
	bh=Ozb5RYd4mVlkCQjRUUnhrP6qi53pnQPr+LKyzLJDQKE=;
	h=Subject:To:Cc:From:Date:From;
	b=rGFAstg3NBT7htbFdpyaRtUixt7ga9huhPWwsl68wyVvZo/KiD96SEaeJFXGWWGy5
	 3L3EV0CcNCX9Wz1HnN3pLbFWEqvRCikHDm+FXK73ch7iAq8jesBsg/LROAgenE3tY8
	 TCpxO/OrmPSukmR5ZN8H04tUlWuwUSYf2WyqNzg8=
Subject: FAILED: patch "[PATCH] drm: adv7511: Fix use-after-free in adv7533_attach_dsi()" failed to apply to 6.1-stable tree
To: biju.das.jz@bp.renesas.com,dmitry.baryshkov@linaro.org,laurent.pinchart+renesas@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:39:05 +0100
Message-ID: <2025010604-resilient-unpaired-7bb7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 81adbd3ff21c1182e06aa02c6be0bfd9ea02d8e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010604-resilient-unpaired-7bb7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81adbd3ff21c1182e06aa02c6be0bfd9ea02d8e8 Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Tue, 19 Nov 2024 19:20:29 +0000
Subject: [PATCH] drm: adv7511: Fix use-after-free in adv7533_attach_dsi()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The host_node pointer was assigned and freed in adv7533_parse_dt(), and
later, adv7533_attach_dsi() uses the same. Fix this use-after-free issue
by dropping of_node_put() in adv7533_parse_dt() and calling of_node_put()
in error path of probe() and also in the remove().

Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
Cc: stable@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241119192040.152657-2-biju.das.jz@bp.renesas.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index eb5919b38263..a13b3d8ab6ac 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1241,8 +1241,10 @@ static int adv7511_probe(struct i2c_client *i2c)
 		return ret;
 
 	ret = adv7511_init_regulators(adv7511);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to init regulators\n");
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to init regulators\n");
+		goto err_of_node_put;
+	}
 
 	/*
 	 * The power down GPIO is optional. If present, toggle it from active to
@@ -1363,6 +1365,8 @@ static int adv7511_probe(struct i2c_client *i2c)
 	i2c_unregister_device(adv7511->i2c_edid);
 uninit_regulators:
 	adv7511_uninit_regulators(adv7511);
+err_of_node_put:
+	of_node_put(adv7511->host_node);
 
 	return ret;
 }
@@ -1371,6 +1375,8 @@ static void adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
+	of_node_put(adv7511->host_node);
+
 	adv7511_uninit_regulators(adv7511);
 
 	drm_bridge_remove(&adv7511->bridge);
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index 4481489aaf5e..5f195e91b3e6 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -181,8 +181,6 @@ int adv7533_parse_dt(struct device_node *np, struct adv7511 *adv)
 	if (!adv->host_node)
 		return -ENODEV;
 
-	of_node_put(adv->host_node);
-
 	adv->use_timing_gen = !of_property_read_bool(np,
 						"adi,disable-timing-generator");
 


