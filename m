Return-Path: <stable+bounces-62707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B31940DB6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B0D1F250E9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39518E766;
	Tue, 30 Jul 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+CNpJyr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DB18EFE0
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331812; cv=none; b=XEM3fibcybii7JoK0Y0vBSuyMkggO98BmfrmpPkSlsaadr4MX6lgUe0e/QdZ4TlXBGuJFefzuTJIBEtvz9f53Gcf16JWno/nzg0s4+dMpQtewwRL2rvACCNw1KsZ4BcIWMG7tsr1iLlhT9569Pphh7wIlWKxQLZbXugpgbQjtR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331812; c=relaxed/simple;
	bh=2N/yiJA5ZkcRnEk9DGCQbHjHIaAXyzVirLI1Tp7r+Ao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oheyj+VuEMg5WwRGzmj1/wd4TfDwbRNb7KtuWNf5JSbBmkgyQVtPzgNruwLBHDC/FtTSrLSED0j13GIiSGzUetTa7zkZMsmtVtxcnh5BBb3gHlFvQ4cxHL4U9eA74x0IzFVKjzGI/HJdSxwBPhvfBUnJR0kGWZBQrpiXfpYOKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+CNpJyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C6DC4AF0B;
	Tue, 30 Jul 2024 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331812;
	bh=2N/yiJA5ZkcRnEk9DGCQbHjHIaAXyzVirLI1Tp7r+Ao=;
	h=Subject:To:Cc:From:Date:From;
	b=M+CNpJyr/FIiagbpx6h0vkF6hU+K57af8rJfvtc3+k3+6bwpRXKDqVUoxOtsYa7Me
	 UX76djkBqyHfmUg/JMe3q9mb9ZMeZiCTNKfM1gCU8Q5ZG9FT9ARYxFLJu+y60SfJ8l
	 h7U6s+SSJuWvyZl0pn+Ae999K5dyEPjI+372SAtg=
Subject: FAILED: patch "[PATCH] drm/udl: Remove DRM_CONNECTOR_POLL_HPD" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,airlied@redhat.com,alexander.deucher@amd.com,jani.nikula@intel.com,sean@poorly.run,stable@vger.kernel.org,tutankhamen@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:30:08 +0200
Message-ID: <2024073008-bakeshop-unwarlike-9346@gregkh>
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
git cherry-pick -x 5aed213c7c6c4f5dcb1a3ef146f493f18fe703dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073008-bakeshop-unwarlike-9346@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5aed213c7c6c ("drm/udl: Remove DRM_CONNECTOR_POLL_HPD")
0862cfd3e22f ("drm/udl: Move connector to modesetting code")
43858eb41e0d ("drm/udl: Various improvements to the connector")
2c1eafc40e53 ("drm/udl: Use USB timeout constant when reading EDID")
c020f66013b6 ("drm/udl: Test pixel limit in mode-config's mode-valid function")
59a811faa74f ("drm/udl: Rename struct udl_drm_connector to struct udl_connector")

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


