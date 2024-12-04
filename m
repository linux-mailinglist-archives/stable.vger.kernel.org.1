Return-Path: <stable+bounces-98631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21C9E4963
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9746516A084
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB9215F6D;
	Wed,  4 Dec 2024 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUwM+h3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC73215F62;
	Wed,  4 Dec 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354943; cv=none; b=INj7Cx3g4KnJfMp6vppBv/Sh+aa8dxzfnpRqbsruwLzRduttDRGttZGEddX52Qd0eACEMp1obVY9Z8444zRJludzO7NmJrQGcF3jN2KAKrIriv0Q4X79Hh3sE5TwHrF4lvNeNi1/thYLtcOaK3ezGbTOhwbEr3Pl3noIQKKHma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354943; c=relaxed/simple;
	bh=Pk0XYOaSRK/hR93+uDXH8B8FrNukHwTXjp5RVOSUmb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFrA4jp27lkmkBY2J25Z1uK6ymkANAIZgeW4wIf8qRMwfM53Y4HNtl2Vh9j4t8Xkfo71T30VENwTasTIvUt9Q9Ya3GQ/apeNrAZ/wxAwrFK1E+3sT1D//9yjOeXZ2PFW4DL40LEThUTrNE+umwcxX6qIgJBEgAbV8idRnzr6cPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUwM+h3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36041C4CECD;
	Wed,  4 Dec 2024 23:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354943;
	bh=Pk0XYOaSRK/hR93+uDXH8B8FrNukHwTXjp5RVOSUmb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUwM+h3T9eJzhErnSgdy5/SmqwWzV6eI26if1Hd5K1ILthvlcM39pvv+BEJXI4jia
	 m+XOC05QDCZNW7LgOdak+LUpB757GTHfu8rLKwIpB0lwICbKYVg7fyGynCFrC9OMgw
	 Zu+rakdrEHtFUeqFtvosJO9H0kEe996nKGSYSg9eGofi/SW8udPPXTtgXLMHZ59P5C
	 TXmCylk9ULi820aZoxgOBWO9EFSxuEuhnOyZ9ryLQCGn35pAA1X2lwsMqNk+SDTuU4
	 ppgpn449AFOV073CkYa3Y51vRAN1Z3dFSh+Yo9yr8GxDbpeDEXePMRc/JFDLnMjgIz
	 wAY6afIXv4dcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saravana Kannan <saravanak@google.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	elder@kernel.org,
	ricardo@marliere.net,
	sumit.garg@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 08/15] drm: display: Set fwnode for aux bus devices
Date: Wed,  4 Dec 2024 17:17:02 -0500
Message-ID: <20241204221726.2247988-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Saravana Kannan <saravanak@google.com>

[ Upstream commit fe2e59aa5d7077c5c564d55b7e2997e83710c314 ]

fwnode needs to be set for a device for fw_devlink to be able to
track/enforce its dependencies correctly. Without this, you'll see error
messages like this when the supplier has probed and tries to make sure
all its fwnode consumers are linked to it using device links:

mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@notapiano/
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20241024061347.1771063-2-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/display/drm_dp_aux_bus.c
index d810529ebfb6e..ec7eac6b595f7 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
 	aux_ep->dev.parent = aux->dev;
 	aux_ep->dev.bus = &dp_aux_bus_type;
 	aux_ep->dev.type = &dp_aux_device_type_type;
-	aux_ep->dev.of_node = of_node_get(np);
+	device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
 	dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
 
 	ret = device_register(&aux_ep->dev);
-- 
2.43.0


