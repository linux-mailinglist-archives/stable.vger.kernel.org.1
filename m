Return-Path: <stable+bounces-105923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690819FB251
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0775A1885E61
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C81AE01B;
	Mon, 23 Dec 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B5Bly1nB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA931865EB;
	Mon, 23 Dec 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970597; cv=none; b=V0cgvN1A5KuIfsw9KsVS9ButqKJ3EtR2G+m3uhvnEhX9KfQltxHG8nlwXMR8MgTr3N1ADMGyIOOqEpo5wsSXrwG6oiCUgbVweI+w+w5eW+z3FhdvdMZKATZelTQ/O+L1cKksvKs4gVPZ3cpaUUprxpaapjJEiwJDjiLJRYojKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970597; c=relaxed/simple;
	bh=6+UTFMO3bDCU4LVXY1q8BvRr9k66IIYkY/gwML6A03E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnCVF5Nl3IlLCcrvwKPLGCbq7FXHraLPLu4dr+O5zwqf4up9W9fJpPm0uzjm5U4l9vQdF70JBN9ulwZUk+NTaVVIad4Ib8nVHM1yg9i1gU4q/AsPvXYIMJ2fbF1p7Cj5XDBtclo8xbMNxIS5s/9mmwQTckBTLvdk+upmZHCTBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B5Bly1nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A758BC4CED3;
	Mon, 23 Dec 2024 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970597;
	bh=6+UTFMO3bDCU4LVXY1q8BvRr9k66IIYkY/gwML6A03E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5Bly1nBQwGIfFJE7n6ZpMZ+cGcfCUMMAaGVdtwfVe60MYgE9bZCJ9YA5IfPtq2k2
	 6+qAmQFFILZSaTBJOWempAfGWGUENzEUliE/uPoI8Z7pd697jqlnn0nZu/hEYT1kGx
	 Rpsy6AOnbE0QiPyPtJhDF9RRRfPbDz3T3Uv4mdHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 13/83] p2sb: Factor out p2sb_read_from_cache()
Date: Mon, 23 Dec 2024 16:58:52 +0100
Message-ID: <20241223155354.145767605@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 9244524d60ddea55f4df54c51200e8fef2032447 ]

To prepare for the following fix, factor out the code to read the P2SB
resource from the cache to the new function p2sb_read_from_cache().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241128002836.373745-2-shinichiro.kawasaki@wdc.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 360c400d0f56 ("p2sb: Do not scan and remove the P2SB device when it is unhidden")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/p2sb.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 687e341e3206..d6ee4b34f911 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -171,6 +171,22 @@ static int p2sb_cache_resources(void)
 	return ret;
 }
 
+static int p2sb_read_from_cache(struct pci_bus *bus, unsigned int devfn,
+				struct resource *mem)
+{
+	struct p2sb_res_cache *cache = &p2sb_resources[PCI_FUNC(devfn)];
+
+	if (cache->bus_dev_id != bus->dev.id)
+		return -ENODEV;
+
+	if (!p2sb_valid_resource(&cache->res))
+		return -ENOENT;
+
+	memcpy(mem, &cache->res, sizeof(*mem));
+
+	return 0;
+}
+
 /**
  * p2sb_bar - Get Primary to Sideband (P2SB) bridge device BAR
  * @bus: PCI bus to communicate with
@@ -187,8 +203,6 @@ static int p2sb_cache_resources(void)
  */
 int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 {
-	struct p2sb_res_cache *cache;
-
 	bus = p2sb_get_bus(bus);
 	if (!bus)
 		return -ENODEV;
@@ -196,15 +210,7 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 	if (!devfn)
 		p2sb_get_devfn(&devfn);
 
-	cache = &p2sb_resources[PCI_FUNC(devfn)];
-	if (cache->bus_dev_id != bus->dev.id)
-		return -ENODEV;
-
-	if (!p2sb_valid_resource(&cache->res))
-		return -ENOENT;
-
-	memcpy(mem, &cache->res, sizeof(*mem));
-	return 0;
+	return p2sb_read_from_cache(bus, devfn, mem);
 }
 EXPORT_SYMBOL_GPL(p2sb_bar);
 
-- 
2.39.5




