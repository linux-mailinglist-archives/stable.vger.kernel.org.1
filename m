Return-Path: <stable+bounces-62708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03791940DB7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33AB81C24683
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F518732A;
	Tue, 30 Jul 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hF/S5+PG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8318E741
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331821; cv=none; b=Ntakrt1LN4G/b4OI6TPUVZkulw9EV4DxKZjtd5HOgLtpaXT16WafQQ1HkkwNu/G8FxvQEzpmvev8SSo/CJEduVPoJ3ASubYyP76wxZwyzcd3ywXY+lG2qWxABgBtYhgAJ6zzRdud5lbSr1GjJndNxbdEiFrdEg0oQohrg4mzZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331821; c=relaxed/simple;
	bh=fDVIMmj1mGgJnVkLzefTS4RCJEHIiFfiaVBC/8fZEgI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=livA5r+Djy5+GJr0n+G5bZSr5bReWGrNMUA08N76U1XAe2DZcRjAXWAp4x+r9xQ4pi1mf3qpTwv4VJxJIPpvJS1UXAiPam0jtVa8wGsxpEC7F4t5Owtf8z2tQZ3Yd4S+RGQ3J/Ex25JJCO70PdliXFTGWlNcfi3qcyeMq0pXAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hF/S5+PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A161C4AF09;
	Tue, 30 Jul 2024 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331820;
	bh=fDVIMmj1mGgJnVkLzefTS4RCJEHIiFfiaVBC/8fZEgI=;
	h=Subject:To:Cc:From:Date:From;
	b=hF/S5+PGkNAtvasYzNxyl3eJcA65QgMCAXYpeXadHeRh34QmX02u4koV/2Ysavhjl
	 MPv6r5X9nsH7OR54rFLuGwbpqj4e3Q2pOLd0Vt8kYBPJD/wORybZfsvGQ0MSwmaHXP
	 EhsQynhuprzZF7NDfkoyN9NPNhi44RCurVt3Llq8=
Subject: FAILED: patch "[PATCH] drm/udl: Remove DRM_CONNECTOR_POLL_HPD" failed to apply to 5.15-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,alexander.deucher@amd.com,jani.nikula@intel.com,sean@poorly.run,stable@vger.kernel.org,tutankhamen@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:30:09 +0200
Message-ID: <2024073009-turmoil-zombie-8941@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5aed213c7c6c4f5dcb1a3ef146f493f18fe703dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073009-turmoil-zombie-8941@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5aed213c7c6c ("drm/udl: Remove DRM_CONNECTOR_POLL_HPD")
0862cfd3e22f ("drm/udl: Move connector to modesetting code")
43858eb41e0d ("drm/udl: Various improvements to the connector")
2c1eafc40e53 ("drm/udl: Use USB timeout constant when reading EDID")
c020f66013b6 ("drm/udl: Test pixel limit in mode-config's mode-valid function")
59a811faa74f ("drm/udl: Rename struct udl_drm_connector to struct udl_connector")
255490f9150d ("drm: Drop drm_edid.h from drm_crtc.h")
0f95ee9a0c57 ("Merge tag 'drm-misc-next-2022-06-08' of git://anongit.freedesktop.org/drm/drm-misc into drm-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5aed213c7c6c4f5dcb1a3ef146f493f18fe703dc Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 10 May 2024 17:47:08 +0200
Subject: [PATCH] drm/udl: Remove DRM_CONNECTOR_POLL_HPD

DisplayLink devices do not generate hotplug events. Remove the poll
flag DRM_CONNECTOR_POLL_HPD, as it may not be specified together with
DRM_CONNECTOR_POLL_CONNECT or DRM_CONNECTOR_POLL_DISCONNECT.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: afdfc4c6f55f ("drm/udl: Fixed problem with UDL adpater reconnection")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: Robert Tarasov <tutankhamen@chromium.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.15+
Link: https://patchwork.freedesktop.org/patch/msgid/20240510154841.11370-2-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 7702359c90c2..751da3a294c4 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -527,8 +527,7 @@ struct drm_connector *udl_connector_init(struct drm_device *dev)
 
 	drm_connector_helper_add(connector, &udl_connector_helper_funcs);
 
-	connector->polled = DRM_CONNECTOR_POLL_HPD |
-			    DRM_CONNECTOR_POLL_CONNECT |
+	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
 			    DRM_CONNECTOR_POLL_DISCONNECT;
 
 	return connector;


