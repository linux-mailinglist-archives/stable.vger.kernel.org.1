Return-Path: <stable+bounces-206145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474AACFDE34
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 14:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7C8304657C
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82831CA4A;
	Wed,  7 Jan 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYsutHAa"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76F304BB3
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791611; cv=none; b=mSYo/1vbE+DJi54+uJEQQYX0pdPCTPEi6b8PFDm+I6xRqhsfGu4xd7mSMJMJCdtz9XiGZWBUpPHSQbDDHKqsiUS6OkkxvsqRACA53Les8h/b7fB3s1u85fRrAtdNTT71qnUaWn0MhGpd41EOBcmOr5TlLfbEfdj6vOOIpf3wp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791611; c=relaxed/simple;
	bh=5jVeuSzJT+n8P47HXLLZTs/JzIhVT2VEdre1Y8Rz2Gc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e1ddovOBy1TGP/kSVXN1abQaOLhkS6UoCBmzT9BTkrhKSgQdaMvTJpe5ezy6YAe8JyG9UscJ9/UA2hmZvUpC5CLVKfgf4h+w44ErrXNa97mrL1CV4HBriCads3ije9o9tSq+JNa7wjOXKHzLANTgIswfKMcqbTsawEWit1rGvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYsutHAa; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B1EE41A26D8;
	Wed,  7 Jan 2026 13:13:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7EAFA606F8;
	Wed,  7 Jan 2026 13:13:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BE8E103C821A;
	Wed,  7 Jan 2026 14:13:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767791605; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/6/7zEjl1v9ZVxgb94JYXoUenLxDhgfv7BOcFf4jkQ8=;
	b=dYsutHAaJcpAzsYO8Pen87tXlqWFzho5PghJp7MFXwoxlDfSycJAjKWX9cm1BWjSM/2grF
	ko5DlJF8QTdMecr+4piqX0YiOx/8AMpktt80Xg+BJ4S+eOZ2Otm8GyOh7mU115qeQ589pv
	xntnqIDYySfiE1Rn4BmBQNUk4QFGseZPYCRJFeMoCTL8I2QxImvo7h3buUcUrpMsTUcGyH
	pjIyVC40HCn+fFO13cLJUubKwlC/6ds5W7djAAlNILCFJ0y2zOGl5bPQ2Sisaoo2yVOATp
	ZaZFz3Zt67cJsV5U3NpgjP0BG5TFjBiP2IqEK5sFHfQgK55qSgYRCyY43aDPvA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/12] drm/bridge: convert users of of_drm_find_bridge(),
 part 2
Date: Wed, 07 Jan 2026 14:12:51 +0100
Message-Id: <20260107-drm-bridge-alloc-getput-drm_of_find_bridge-2-v1-0-283d7bba061a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANNbXmkC/y2NUQrCMBAFr1L224BZMahXEQlNsqkLNambVITSu
 xu1nzMP3ixQSJgKXLoFhF5cOKcGeteBv/dpIMWhMeAejxrxoII8lBMObenHMXs1UJ3m+vU2Rxs
 5BbvtqDR645x35nQ20C4nocjvX+56+7PQc27Vusl1/QCqbC9hkwAAAA==
X-Change-ID: 20251223-drm-bridge-alloc-getput-drm_of_find_bridge-2-12c6bbcb6896
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philippe Cornu <philippe.cornu@st.com>, benjamin.gaignard@linaro.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Adrien Grassein <adrien.grassein@gmail.com>, Liu Ying <victor.liu@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This series converts all DRM bridge drivers (*) from the now deprecated
of_drm_find_bridge() to its replacement of_drm_find_and_get_bridge() which
allows correct bridge refcounting. It also converts per-driver
"next_bridge" pointers to the unified drm_bridge::next_bridge which puts
the reference automatically on bridge deallocation.

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. … protect encoder bridge chain with a mutex
       7. ➜ of_drm_find_bridge
          a. ✔… add of_drm_get_bridge(), convert basic direct users
	        (v6.20?, one driver still pending)
	  b. ➜ convert direct of_drm_get_bridge() users, part 2
	  c.   convert direct of_drm_get_bridge() users, part 3
	  d.   convert direct of_drm_get_bridge() users, part 4
	  e.   convert bridge-only drm_of_find_panel_or_bridge() users
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. … handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_dev_enter/exit() to protect device resources (v6.20?)
    B. … protect private_obj removal from list
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. finish the hotplug bridge work, moving code to the core and potentially
    removing the hotplug-bridge itself (this needs to be clarified as
    points 1-3 are developed)

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

This work is a continuation of the work to correctly handle bridge
refcounting for existing of_drm_find_bridge(). The ground work is in:

  - commit 293a8fd7721a ("drm/bridge: add of_drm_find_and_get_bridge()")
  - commit 9da0e06abda8 ("drm/bridge: deprecate of_drm_find_bridge()")
  - commit 3fdeae134ba9 ("drm/bridge: add next_bridge pointer to struct drm_bridge")

The whole conversion is split in multiple series to make the review process
a bit smoother. Parts 3 and 4 are converting non-bridge drivers (mostly
encoders).

(*) One bridge driver (synopsys/dw-hdmi) is converted in another series,
    together with its (non-bridge) users. Additionally this series converts
    drm_of_panel_bridge_remove() which is a special case, and has a bugfix
    for it too.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (12):
      drm: of: drm_of_panel_bridge_remove(): fix device_node leak
      drm: of: drm_of_panel_bridge_remove(): convert to of_drm_find_and_get_bridge()
      drm/bridge: sii902x: convert to of_drm_find_and_get_bridge()
      drm/bridge: thc63lvd1024: convert to of_drm_find_and_get_bridge()
      drm/bridge: tfp410: convert to of_drm_find_and_get_bridge()
      drm/bridge: tpd12s015: convert to of_drm_find_and_get_bridge()
      drm/bridge: lt8912b: convert to of_drm_find_and_get_bridge()
      drm/bridge: imx8mp-hdmi-pvi: convert to of_drm_find_and_get_bridge()
      drm/bridge: imx8qxp-ldb: convert to of_drm_find_and_get_bridge()
      drm/bridge: samsung-dsim: samsung_dsim_host_attach: use a temporary variable for the next bridge
      drm/bridge: samsung-dsim: samsung_dsim_host_attach: don't use the bridge pointer as an error indicator
      drm/bridge: samsung-dsim: samsung_dsim_host_attach: convert to of_drm_find_and_get_bridge()

 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c | 15 +++++++-------
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c     |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c     | 31 ++++++++++++++--------------
 drivers/gpu/drm/bridge/samsung-dsim.c        | 28 ++++++++++++++++---------
 drivers/gpu/drm/bridge/sii902x.c             |  7 +++----
 drivers/gpu/drm/bridge/thc63lvd1024.c        |  7 +++----
 drivers/gpu/drm/bridge/ti-tfp410.c           | 27 ++++++++++++------------
 drivers/gpu/drm/bridge/ti-tpd12s015.c        |  8 +++----
 include/drm/bridge/samsung-dsim.h            |  1 -
 include/drm/drm_of.h                         |  6 +++++-
 10 files changed, 69 insertions(+), 64 deletions(-)
---
base-commit: 2bcba510a612cea32b8a536eedeabd7fcb413cd0
change-id: 20251223-drm-bridge-alloc-getput-drm_of_find_bridge-2-12c6bbcb6896

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


