Return-Path: <stable+bounces-106812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21EA02337
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D4A3A486F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274019E7EB;
	Mon,  6 Jan 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0sL/uEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663BB676
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159958; cv=none; b=gvtFy+kzQUqqAfTgdkF7HKzDhO9zpRDpXy6q4PdB2vOPwOYwmH2+22SFxSWg/ojJAnAwdOAyPmbU17oCF0FwTQtmxBxOTUE7kenHFIF22aWCDSOZbbwiW2j00Oavbtxgk4LoCI2JF3nVOlXxLnm1B/D4PnQw6qTjrcoQwgDNa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159958; c=relaxed/simple;
	bh=dZuWBZZlqq8WOxZ3sUPdlgAm2jom80HYG3Hvydhf8Sw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L50tlwjD1c64IbyymjpsNp6ZOZtHjKilZHgINt4+MYdEI7lEMEmGx0ugIXKRce+4Mu/ak349/s5C5qrPTzF77G2vxdLdxpYWnK+wtxnxT9mDVT9qGi+lORR4UZknsWBXW6cSPdmUwPZC1MhbwAhyneIfF7a7qbvEAIRKGOXkYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0sL/uEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087C4C4CEDD;
	Mon,  6 Jan 2025 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736159956;
	bh=dZuWBZZlqq8WOxZ3sUPdlgAm2jom80HYG3Hvydhf8Sw=;
	h=Subject:To:Cc:From:Date:From;
	b=A0sL/uENU7RfA6H4HY/W59Awd7SWHRTfPGiJdJSX4Ms0cKsfNMOys3A9PpP6JglCv
	 9xDxYOcqBntgx982YS31sPAHyVOsCRts+RjtuU6MeMnCShRYBK5Mx6eJLA0aEqOI9g
	 cedNFLySZnd52GEQSsBzVRa79Rv439inkR1PFhIA=
Subject: FAILED: patch "[PATCH] drm: adv7511: Fix use-after-free in adv7533_attach_dsi()" failed to apply to 5.15-stable tree
To: biju.das.jz@bp.renesas.com,dmitry.baryshkov@linaro.org,laurent.pinchart+renesas@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:39:05 +0100
Message-ID: <2025010605-quit-rockfish-a0e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 81adbd3ff21c1182e06aa02c6be0bfd9ea02d8e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010605-quit-rockfish-a0e8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


