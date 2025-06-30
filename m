Return-Path: <stable+bounces-158928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D7AEDACC
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CC33A8A49
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD223F43C;
	Mon, 30 Jun 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDz6a4cS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109623BCF2
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282634; cv=none; b=g5+wRDIzPFQmYBrc1TO1cv/PaACOOSlHeWT7XdFse69df95CVWTzsb/iCfXcTZDGJE5dQ2d1yTstb+b5+OkuxrzP4yuNiDXe25qQnZCztYjjtAKEerA/SsSTILsAF4IHhEceXJlxVoFcEaFJbcv8i0F1OBK+eZE5QkM/FmyjPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282634; c=relaxed/simple;
	bh=ScyvCDzZ+kSfd5C7tDUfViBF9YC/4DF14hPg/BQ4+3U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q6ESmS4rF2sK2TRpOQdHd8hNNLSHM19G2ljQLZvRRngjgMoEGe/RWkFcbL1FDNXTAv7aGDzkm4wXIwUDahp9PmGcAQqrll5R2EJHJObWZZcORrC6RYNGrU2SUU87AYFFYMKhWrvcIDWbqExzrfcgYr5blHaz0zcyXMjFYN3640Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDz6a4cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C892C4CEE3;
	Mon, 30 Jun 2025 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751282634;
	bh=ScyvCDzZ+kSfd5C7tDUfViBF9YC/4DF14hPg/BQ4+3U=;
	h=Subject:To:Cc:From:Date:From;
	b=gDz6a4cSta+ngVRpvSEEREv0LTLw+WA4HciI8cZiBQQD8lY/uE4/MLOk4iwLPqHvP
	 wlgb3Ay/B3EBEDPAb6siaMe0r2AHvQ5q4Ot589XZDcIoJC0W3zmHlMCD2yXVLgJeGN
	 AQPP569amD3cSQ+ZZ91qdd0WxeKK0Ijyz07yBfYE=
Subject: FAILED: patch "[PATCH] drm/bridge: cdns-dsi: Fix phy de-init and flag it so" failed to apply to 5.4-stable tree
To: a-bhatia1@ti.com,aradhya.bhatia@linux.dev,dmitry.baryshkov@linaro.org,dmitry.baryshkov@oss.qualcomm.com,tomi.valkeinen@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 13:23:40 +0200
Message-ID: <2025063040-crablike-endorse-741f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fd2611c13f69cbbc6b81d9fc7502abf4f7031d21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063040-crablike-endorse-741f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd2611c13f69cbbc6b81d9fc7502abf4f7031d21 Mon Sep 17 00:00:00 2001
From: Aradhya Bhatia <a-bhatia1@ti.com>
Date: Sat, 29 Mar 2025 17:09:13 +0530
Subject: [PATCH] drm/bridge: cdns-dsi: Fix phy de-init and flag it so

The driver code doesn't have a Phy de-initialization path as yet, and so
it does not clear the phy_initialized flag while suspending. This is a
problem because after resume the driver looks at this flag to determine
if a Phy re-initialization is required or not. It is in fact required
because the hardware is resuming from a suspend, but the driver does not
carry out any re-initialization causing the D-Phy to not work at all.

Call the counterparts of phy_init() and phy_power_on(), that are
phy_exit() and phy_power_off(), from _bridge_post_disable(), and clear
the flags so that the Phy can be initialized again when required.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Link: https://lore.kernel.org/r/20250329113925.68204-3-aradhya.bhatia@linux.dev
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 1cfe17865b06..3b15528713fe 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -683,6 +683,11 @@ static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 
+	dsi->phy_initialized = false;
+	dsi->link_initialized = false;
+	phy_power_off(dsi->dphy);
+	phy_exit(dsi->dphy);
+
 	pm_runtime_put(dsi->base.dev);
 }
 
@@ -1166,7 +1171,6 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	clk_disable_unprepare(dsi->dsi_sys_clk);
 	clk_disable_unprepare(dsi->dsi_p_clk);
 	reset_control_assert(dsi->dsi_p_rst);
-	dsi->link_initialized = false;
 	return 0;
 }
 


