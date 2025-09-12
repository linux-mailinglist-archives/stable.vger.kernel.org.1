Return-Path: <stable+bounces-179366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563AB54F05
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB6D5A151C
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089930F800;
	Fri, 12 Sep 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyGbXbiw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EB30E83D;
	Fri, 12 Sep 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682835; cv=none; b=NzvLGN2mKOhUMKsKtbpUwcxD4wwe8ZqSxa4twGjbrknekYbNtDufx0AoSV50vqyMEkgfLAE4NAzGUqOF6THmcYySJDlYGF0jyLAfbNHiTqC6Ma8AFTHoXPvxCcY3Of2N2+D+9pFDh/LQ56skgrjy9xGSl17S8Ske8CAR1A8jv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682835; c=relaxed/simple;
	bh=53zhH/LYQFFz1Wl4Yt+O8tMgixCVsPRKlvjRAxLnYME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSfClcfOSVid6dvvOTdWLcN5zxcR+IGigd7YKq1cBRg21BJ16d6ec4bNn7+AnI/a5RAvAEr/FTcVcG0EtajCH2dSnwxy6TVJh00M0XIZqxu43l5bEew8Ybj/iEpGPl2JPtD/eJ+zBWrkkBb48HNoSwmN3xW6isGtUNpxarIaKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyGbXbiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C11C4CEF4;
	Fri, 12 Sep 2025 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682835;
	bh=53zhH/LYQFFz1Wl4Yt+O8tMgixCVsPRKlvjRAxLnYME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyGbXbiwX2aPQ7/qAyEBZYYJ6loFOTSkUqLLsj4Ojd7MAgJEUluifrJ5ptLO8Gem0
	 6SG9Qmws20EwBdU898XbTwCy+aGnilh3MGNSnzSxDTuXhMkaYV2pC+2ZZZ5DDIDvM/
	 A+bll1wHIZZj5gP4zQh///W4hB1jmg7xFtE4Xp/iKjsoqSOb3k+sA1w7KTbkkmA5XN
	 hDyLCp3xB2ucNb4O8t8xZfSiMWyR0zk6S9idITu2IhvXV0zOjKX56VncILLnRkdTyB
	 TK5l6ieD6Sxz6ljh6zt/XYpFngpaMj4wy5BXVHJ/1tRPeAwkBlY2sSHH4P8+0F3cPv
	 mDUgnQmQIX5LQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/1] nvmem: layouts: fix automatic module loading
Date: Fri, 12 Sep 2025 14:13:47 +0100
Message-ID: <20250912131347.303345-2-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250912131347.303345-1-srini@kernel.org>
References: <20250912131347.303345-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Walle <mwalle@kernel.org>

To support loading of a layout module automatically the MODALIAS
variable in the uevent is needed. Add it.

Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/layouts.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 65d39e19f6ec..f381ce1e84bd 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -45,11 +45,24 @@ static void nvmem_layout_bus_remove(struct device *dev)
 	return drv->remove(layout);
 }
 
+static int nvmem_layout_bus_uevent(const struct device *dev,
+				   struct kobj_uevent_env *env)
+{
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != ENODEV)
+		return ret;
+
+	return 0;
+}
+
 static const struct bus_type nvmem_layout_bus_type = {
 	.name		= "nvmem-layout",
 	.match		= nvmem_layout_bus_match,
 	.probe		= nvmem_layout_bus_probe,
 	.remove		= nvmem_layout_bus_remove,
+	.uevent		= nvmem_layout_bus_uevent,
 };
 
 int __nvmem_layout_driver_register(struct nvmem_layout_driver *drv,
-- 
2.50.0


