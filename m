Return-Path: <stable+bounces-191754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF60C2138B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E52CD4EAB88
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED02ECD39;
	Thu, 30 Oct 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRagolsW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52F2EB859;
	Thu, 30 Oct 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842106; cv=none; b=tKE670J2+avMTOiaI6S8knyEBGMeJfZ+nf+k+S02uY2xoUbFLH6qDVW0sp3z0N9O8vt3yz36uGFKbeFnere9ZyjyxC9eDjCl/RLojvSg/O/uNveNz2YV6CW2xVWzqEXecar7+GXff4UNiRQ/jDMMHnMfUSzl4eCSzddNPAKdFII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842106; c=relaxed/simple;
	bh=HdDzBszjRT1bjtGdY7rWYwp2aMVoUkReGlxOWh0bxh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjZD4EoVLNA80jzv9dr46sL0TIb8cI7rUIOg2S+C0A5sA08S12xP7RFSQ9hn8y/CQteQTfuIhCEDohXIJNQHfUIPPkDBf0wrA/gNrNNAx9yru1yuiyHqeZyWbHjFyL7i7poQV+DN8NuBjC1C70KY+3D0hMZ+9ePvdXS6IadH+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRagolsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88974C4CEFB;
	Thu, 30 Oct 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842106;
	bh=HdDzBszjRT1bjtGdY7rWYwp2aMVoUkReGlxOWh0bxh4=;
	h=From:To:Cc:Subject:Date:From;
	b=kRagolsWLCR0E/AtgHrrngcBHOH1aVkzgGg2k9G2AXliMsHK2pnRhICuB+64f7pJs
	 eEJbkxjveKUSGSADFl8aLj4YK3XZ2gXatdyIoufEMRtkXIGHkNPfRVsMWljFd3FcmA
	 0gERd3kK1D0r/wW3qpxRBqVuUBfWs6gRWi2INFZnMjLh98qbEtNQ4l7Jw9PU5HHBI6
	 Kk3oWqAUnl1Jno55agbNT/X+lrdL7M79j+iToYZpFhCvxt3EeyrZcnS1vvPXJMVmui
	 UmEWfNOYhgwTek+aCj7uwD6n5gCK7elmKe2prS8NRjRfHVom9hq5Z8mIqrVUZWjLXR
	 xCtLERFmWeMig==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEVcI-0000000047N-15xn;
	Thu, 30 Oct 2025 17:35:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] drm/imx/tve: fix probe device leak
Date: Thu, 30 Oct 2025 17:34:56 +0100
Message-ID: <20251030163456.15807-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the DDC device during probe on
probe failure (e.g. probe deferral) and on driver unbind.

Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
Cc: stable@vger.kernel.org	# 3.10
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - add missing NULL ddc check


 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index fd1e617e171e..68bbbdbd347b 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -525,6 +525,13 @@ static const struct component_ops imx_tve_ops = {
 	.bind	= imx_tve_bind,
 };
 
+static void imx_tve_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int imx_tve_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -546,6 +553,12 @@ static int imx_tve_probe(struct platform_device *pdev)
 	if (ddc_node) {
 		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
+		if (tve->ddc) {
+			ret = devm_add_action_or_reset(dev, imx_tve_put_device,
+						       &tve->ddc->dev);
+			if (ret)
+				return ret;
+		}
 	}
 
 	tve->mode = of_get_tve_mode(np);
-- 
2.51.0


