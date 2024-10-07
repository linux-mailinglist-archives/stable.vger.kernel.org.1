Return-Path: <stable+bounces-81321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D885899308E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5987C1F226F3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4D1D935C;
	Mon,  7 Oct 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rn3Vt531"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493001EB25
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313497; cv=none; b=uOsNWQeJp+AuppYgqpu8hQNyPGmVmC2wNKz1/8XZnlJ4RzNTb9183GQugD1n+b9+uB7DJvrIwc6dGfHYPiQyetzb9zuf+WlSm+dUZWiq+FrBicFephYZUe6YXqQFnRPYCRyBFvVctWEPsGNhJAF2RU4Mogk1ueFtUaWWggxo+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313497; c=relaxed/simple;
	bh=LLXGGaI77Ia62ZiGo7oiNx0WuHi9MkEx3IlBncetdA0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CRJyQXbVG11UbSkjvCfXWMAmWURQgQXjZvJDAFZh9Flb1UbhC7UEwTaY8V6wWOE6P4/wUdetsrg/q8yjkhkFGFGMC+e3F+liqXHKhsTrn1q0Kcp5mYVeXdI4Vhl/ckV9spj85FHzo2wjaLdBkJ74NoUmsx2c1wNnB4mltoI/84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rn3Vt531; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2BAC4CEC6;
	Mon,  7 Oct 2024 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728313496;
	bh=LLXGGaI77Ia62ZiGo7oiNx0WuHi9MkEx3IlBncetdA0=;
	h=Subject:To:Cc:From:Date:From;
	b=rn3Vt531aygwNDBjrMzFkQRE5xx1HVfo2Kx9UA2iRYcC6lzIPR7N3dhGElk3Jqpar
	 KwMoKQ4UF7rGr51TKgdnqb8m+waOkaHSLVnIMUOcPShBm83Mjxu+yyWGOCv8P/Qj/+
	 jLVZcgbjBK92YukeNNCzRVHt3SGLbMtyKRORGskg=
Subject: FAILED: patch "[PATCH] drm: omapdrm: Add missing check for alloc_ordered_workqueue" failed to apply to 4.19-stable tree
To: make24@iscas.ac.cn,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 17:04:53 +0200
Message-ID: <2024100753-rockfish-ensnare-ca86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e794b7b9b92977365c693760a259f8eef940c536
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100753-rockfish-ensnare-ca86@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e794b7b9b929 ("drm: omapdrm: Add missing check for alloc_ordered_workqueue")
2ee767922e1b ("drm/omap: Group CRTC, encoder, connector and dssdev in a structure")
ac3b13189333 ("drm/omap: Create all planes before CRTCs")
f96993630445 ("drm/omap: Remove unneeded variable assignments in omap_modeset_init")
845417b3b3b0 ("drm/omap: dss: Move DSS mgr ops and private data to dss_device")
f324b2798c87 ("drm/omap: dss: Store dss_device pointer in omap_dss_device")
c1dfe721e096 ("drm/omap: dss: Move and rename omap_dss_(get|put)_device()")
67822ae11971 ("drm/omap: dss: Remove panel devices list")
4e0bb06c0b9a ("drm/omap: dss: Split omapdss_register_display()")
b9f4d2ebf641 ("drm/omap: dss: Make omap_dss_get_next_device() more generic")
92ce521a4841 ("drm/omap: dss: Rename for_each_dss_dev macro to for_each_dss_display")
7269fde4e8c9 ("drm/omap: displays: Remove input omap_dss_device from panel data")
fb5571717c24 ("drm/omap: dss: Move src and dst check and set to connection handlers")
1f507968c30b ("drm/omap: dss: Move debug message and checks to connection handlers")
ec727e3f6184 ("drm/omap: dss: Add functions to connect and disconnect devices")
b93109d7dc9e ("drm/omap: dss: Move common device operations to common structure")
e10bd354ad79 ("drm/omap: dss: Allow looking up any device by port")
a7e82a67c1d7 ("drm/omap: dss: Rework output lookup by port node")
9184f8d94c38 ("drm/omap: dss: Create and use omapdss_device_is_registered()")
6a7c5a2200ad ("drm/omap: dss: Create global list of all omap_dss_device instances")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e794b7b9b92977365c693760a259f8eef940c536 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Thu, 8 Aug 2024 14:13:36 +0800
Subject: [PATCH] drm: omapdrm: Add missing check for alloc_ordered_workqueue

As it may return NULL pointer and cause NULL pointer dereference. Add check
for the return value of alloc_ordered_workqueue.

Cc: stable@vger.kernel.org
Fixes: 2f95bc6d324a ("drm: omapdrm: Perform initialization/cleanup at probe/remove time")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240808061336.2796729-1-make24@iscas.ac.cn

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 6598c9c08ba1..d3eac4817d76 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -695,6 +695,10 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 	soc = soc_device_match(omapdrm_soc_devices);
 	priv->omaprev = soc ? (uintptr_t)soc->data : 0;
 	priv->wq = alloc_ordered_workqueue("omapdrm", 0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto err_alloc_workqueue;
+	}
 
 	mutex_init(&priv->list_lock);
 	INIT_LIST_HEAD(&priv->obj_list);
@@ -753,6 +757,7 @@ err_gem_deinit:
 	drm_mode_config_cleanup(ddev);
 	omap_gem_deinit(ddev);
 	destroy_workqueue(priv->wq);
+err_alloc_workqueue:
 	omap_disconnect_pipelines(ddev);
 	drm_dev_put(ddev);
 	return ret;


