Return-Path: <stable+bounces-114544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270BA2ED4F
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1001887C82
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E222371D;
	Mon, 10 Feb 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ruhOiY9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F232236FC
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193278; cv=none; b=qb5Nr8rUSsovAyac52NJTW35Cnzw2zMjgggAIbWKhwPodDdyUdtfEfd5Rsfd1/iONOiCAshCC+QqgJ+9+WqnvZHMXdBf9bYbOSYtwJNMFHdVqrJpIlD4N3EUi0PaHf2DR2l1JvVizAl0YXho1FrwBlJtPcH46dvrCAZjcXLd09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193278; c=relaxed/simple;
	bh=PSIkHAJlAUPdhUCshV85q1oDoNPpWH5VSX+GmH2kd8U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fpi8b2I/qCnxM93Xpm/W6DfWJJYadHAFUvZ3I4Tri81cOzP0qg92EnYM9Z156+BYnnGOsVfBAiOZCP4ixugRpxYsEBsQ2qJadUcMi7X4myLbDrkDygjRiNaKsJ9w5ujWyZaHW2dUIC0/SYwdAJJrZoHB9kSIw+N+XeizL0yA+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ruhOiY9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0707AC4CED1;
	Mon, 10 Feb 2025 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739193277;
	bh=PSIkHAJlAUPdhUCshV85q1oDoNPpWH5VSX+GmH2kd8U=;
	h=Subject:To:Cc:From:Date:From;
	b=ruhOiY9dYxB1yC/OrKKKOMfgIIkXGtdLzkc07B1WNxuq9GJCRj8OLqcR9EIT12nIk
	 2z+EyQJsxEYQtaU/C8jbILtCaQaoNc67JSKsHYypf+X/VRC9TYXkn3rwDSOW0SbRzP
	 psmW3mh4cUbFSlkif1fA1gfa8V33CL5K7NM14GG4=
Subject: FAILED: patch "[PATCH] drm/rockchip: cdn-dp: Use" failed to apply to 5.10-stable tree
To: tzimmermann@suse.de,andy.yan@rock-chips.com,groeck@chromium.org,heiko@sntech.de,hjc@rock-chips.com,stable@vger.kernel.org,zyw@rock-chips.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:14:26 +0100
Message-ID: <2025021026-surfboard-eskimo-5c01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 666e1960464140cc4bc9203c203097e70b54c95a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021026-surfboard-eskimo-5c01@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 666e1960464140cc4bc9203c203097e70b54c95a Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 5 Nov 2024 14:38:16 +0100
Subject: [PATCH] drm/rockchip: cdn-dp: Use
 drm_connector_helper_hpd_irq_event()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code for detecting and updating the connector status in
cdn_dp_pd_event_work() has a number of problems.

- It does not aquire the locks to call the detect helper and update
the connector status. These are struct drm_mode_config.connection_mutex
and struct drm_mode_config.mutex.

- It does not use drm_helper_probe_detect(), which helps with the
details of locking and detection.

- It uses the connector's status field to determine a change to
the connector status. The epoch_counter field is the correct one. The
field signals a change even if the connector status' value did not
change.

Replace the code with a call to drm_connector_helper_hpd_irq_event(),
which fixes all these problems.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 81632df69772 ("drm/rockchip: cdn-dp: do not use drm_helper_hpd_irq_event")
Cc: Chris Zhong <zyw@rock-chips.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20241105133848.480407-1-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index b04538907f95..f576b1aa86d1 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -947,9 +947,6 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->connector;
-	enum drm_connector_status old_status;
-
 	int ret;
 
 	mutex_lock(&dp->lock);
@@ -1009,11 +1006,7 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 out:
 	mutex_unlock(&dp->lock);
-
-	old_status = connector->status;
-	connector->status = connector->funcs->detect(connector, false);
-	if (old_status != connector->status)
-		drm_kms_helper_hotplug_event(dp->drm_dev);
+	drm_connector_helper_hpd_irq_event(&dp->connector);
 }
 
 static int cdn_dp_pd_event(struct notifier_block *nb,


