Return-Path: <stable+bounces-206427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB89D07936
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 08:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F35D13013BC1
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB12ED873;
	Fri,  9 Jan 2026 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vWenyqBD"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874A1FF7B3
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943911; cv=none; b=N7CZjRsw3TbnLtpl9iKx+Z3XlryBhV6ieqxSNTp2xnVXMbtFqyan8n2AEX4KHsCYLmahE+RYGkpRGWTqndF9BthpRXZlSECA+7uNt2/B9x9ndcJ+k3oovyDVLVJSrzr8LFfpbylQO7p5HSxTpLN8RlfkvX2c7qs49OCMM6ygsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943911; c=relaxed/simple;
	bh=WsvJsVALgC0cijAFEiCO7CCeTFF0GGqchkJSqu/RrRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hEOAxicl0kMlz3wwN6sMs4GUPlFc7swFvffe5+ANLmYpO2q5cuS/zgAzbDMU0J3CHiPK3jn6u9YdM3cV3JJW045RDBPxVwJaHx37vp7/syGh3JpQ05s1qAATfAsJFy2zBdyiXjuFyHJI1yWFVXwR1EXJEusxqXBXAyDAFpFBEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vWenyqBD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F9CBC1F6CE;
	Fri,  9 Jan 2026 07:31:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7FBB160734;
	Fri,  9 Jan 2026 07:31:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBFBB103C87E8;
	Fri,  9 Jan 2026 08:31:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767943904; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=O7pzVTj6X0AEeV6swURMFMUKvFmICmffgzcekptf2P0=;
	b=vWenyqBDDH8G1zzaYpSa7Rrze6ECMjD08JHWjpuC9NeezlEl8GKQMyr6uPHyJ76o824+As
	FzzSYtLMwGVmuDgeTPxQJZIBN3mcgSo0Dw8aZDq+ZttsrbUSBUbfg6No6g4dYbTqJlDXih
	yApcnzSTeppghscMgDHf9Gilzo986LSZTDNL/xzNXktqAEgwu4xxtY+Jgz5qpqQODQrFO5
	0XzZ/QGa7eWoVQ1vzkldtn1FjCbEgbyw4OzRYFRBc8z0zlhmVlar3Sx4S1FejR7tNj8Z9f
	1TBajImkXcBSK8bmcYOmNiinYrljqkaT42IXL8yGHmjBIjUfGYcuTP6vr4QVhA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 00/12] drm/bridge: convert users of
 of_drm_find_bridge(), part 2
Date: Fri, 09 Jan 2026 08:31:31 +0100
Message-Id: <20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-0-8bad3ef90b9f@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANOuYGkC/5WOzQ6CMBAGX4X0bE27xIKefA9DSP+ATZBiW4iG8
 O4WNPHsceZLdnYhwXq0gVyyhXg7Y0A3JIBDRnQnh9ZSNIkJMDhxgJwaf6fKo0mL7HunaWvjOMX
 N166pGxxM/d2BctBCKa1EeRYknRy9bfC5527Vh719TKkaf7LDEJ1/7S/NfLNbXTDOiv/qM6eMQ
 pmbQinJBJdX5VzscThqdyfVuq5vAxQV6/8AAAA=
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
	  c. … convert direct of_drm_get_bridge() users, part 3
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
Changes in v2:
- Fix bug in samsung-dsim code, patch 10;
  update patch 12 on top of those changes
- Fix in imx8qxp-ldb code, patch 9
- Link to v1: https://lore.kernel.org/r/20260107-drm-bridge-alloc-getput-drm_of_find_bridge-2-v1-0-283d7bba061a@bootlin.com

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

 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c | 15 ++++++-----
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c     | 12 ++++++++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c     | 31 +++++++++++------------
 drivers/gpu/drm/bridge/samsung-dsim.c        | 37 +++++++++++++++++++---------
 drivers/gpu/drm/bridge/sii902x.c             |  7 +++---
 drivers/gpu/drm/bridge/thc63lvd1024.c        |  7 +++---
 drivers/gpu/drm/bridge/ti-tfp410.c           | 27 ++++++++++----------
 drivers/gpu/drm/bridge/ti-tpd12s015.c        |  8 +++---
 include/drm/bridge/samsung-dsim.h            |  1 -
 include/drm/drm_of.h                         |  6 ++++-
 10 files changed, 86 insertions(+), 65 deletions(-)
---
base-commit: 814b88f91b121246b35be9c519b537041fe3d178
change-id: 20251223-drm-bridge-alloc-getput-drm_of_find_bridge-2-12c6bbcb6896

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


