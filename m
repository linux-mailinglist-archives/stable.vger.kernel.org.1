Return-Path: <stable+bounces-164578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA5B10597
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0764C3AAFDF
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88693259CAB;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvhb7kiJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC7258CDC;
	Thu, 24 Jul 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348771; cv=none; b=Y6Io/RSMUgti7kwL0zdNP9sDW+lioZ/o0t5jPpA8MZfpfp36AXUJVOit1lKYz3cI/gCTSQhKuF6eI0PnF5dRNoLV4K1Ak7lYXYH5X16ooVrSZ1NowyR7ExHk+g+P0Hq+E2LjC2Hb1osuPKd/R+W+xTSWLlILrUT3dq9GQlTCwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348771; c=relaxed/simple;
	bh=Ur2Q4n8lOL4ygQwTq/C6e7qTaHDEJOyY+8hFLtDn3GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaGi/qXYIh9FAImD4e6ZVJ85pFtFo86/3ftAPr8cUahJsA2MxRrjzfv3C4pEMRUfvtdJOxZc2f+HZVq3zCePBkqgZ2+7LghVpBsUsQmDgVGs9NGJoFwwyUA285tKbEpPHRWEqIDVPjlZdKRexDnbl94SefCblP6Sv7+BxiFoLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvhb7kiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB002C4CEF8;
	Thu, 24 Jul 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753348771;
	bh=Ur2Q4n8lOL4ygQwTq/C6e7qTaHDEJOyY+8hFLtDn3GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mvhb7kiJRoY2ryS+f+xwdFn3JlJi2gdSfkAH97VXOGqmOFyNQD8K3/k99iwzZRm+u
	 gAnCRjn4sTFSFqJrPeS/wGBcZthP/rRq9cQvZ/zu33tuQWyty/ocWTJNztgE16xfsX
	 6liCeJtyC4XclS8+D5ECZkNNaSZINEBcOy4uJ/t5xMEdD5PbhVOIqjgza/lVOEHbfg
	 tW/wsFrQCX+MkqVa7VVWoRWAGQJ+XghE7iBJCw3kPkkHhUs1MB1KNbXGmS4H/muIkt
	 mZQsGT8nDwnwa5yawnjvXz/6f1h1U4MGKB+Imq6iivZtVT6bF5nSPBuxGTXLGRvxsd
	 TgVLkqWHrcZVg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ues6n-000000005Ux-3B7V;
	Thu, 24 Jul 2025 11:19:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] usb: dwc3: meson-g12a: fix device leaks at unbind
Date: Thu, 24 Jul 2025 11:19:07 +0200
Message-ID: <20250724091910.21092-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250724091910.21092-1-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references taken to the child devices by
of_find_device_by_node() during probe on driver unbind.

Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Cc: stable@vger.kernel.org	# 5.2
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 7d80bf7b18b0..55e144ba8cfc 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -837,6 +837,9 @@ static void dwc3_meson_g12a_remove(struct platform_device *pdev)
 
 	usb_role_switch_unregister(priv->role_switch);
 
+	put_device(priv->switch_desc.udc);
+	put_device(priv->switch_desc.usb2_port);
+
 	of_platform_depopulate(dev);
 
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
-- 
2.49.1


