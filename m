Return-Path: <stable+bounces-54732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E014910ADB
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D6E283A8B
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6131B1436;
	Thu, 20 Jun 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KIe+j++7"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975291ACE89;
	Thu, 20 Jun 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899253; cv=none; b=iSvjvxjYgx23BTIDUcUrI0gkLuYmv3qZyukHiK8E1eLlWt4vCqMBY4PIGavnPEnO4ZactuXCT/4zBZXiA6vU1+rJfM37ohfiVsxqBCo00gyvCQTGIiL5uN0mKFcyh0yQG/NrjzVlZBm+81znl+0dP8x4EO979pD2fy6WXoOz+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899253; c=relaxed/simple;
	bh=qZH/XbFDujN79derPC6Ra+IV8xgYykFW8rje5FopDfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9TST+RLKBs2Fuz8XLbbSvKYvNSp6yuYyaBeSD9/XLR7tzp2ZpzdWpdypdEP8ay2I6LN2tRg4k4ZtQ6vAcO4vqO69XzftQMY2gnXLWm5uyJ6Aui7ZIGLiZiWYkSkDxcZnJ+XCC6eDY3pseoYRhGSU91rp81HEg6N11DEyxTRATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KIe+j++7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718899248;
	bh=qZH/XbFDujN79derPC6Ra+IV8xgYykFW8rje5FopDfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KIe+j++7FE59c05dEDol7tHCYs2zL33R5W9TQ5t6sRIVXUEOpzBVvgq1vBE0SWI92
	 27MRLT2YXT0sajg0oLLSRQXbFowCr9D+TjpJ/37PcJhvMhjTgimqoHyypPJJ5Nay8X
	 KTP7iNAWvJ5XQoMzQYzWB3RlOg3kX3juw1inUi3M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 20 Jun 2024 18:00:33 +0200
Subject: [PATCH 1/5] nvmem: core: only change name to fram for current
 attribute
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240620-nvmem-compat-name-v1-1-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899247; l=1144;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qZH/XbFDujN79derPC6Ra+IV8xgYykFW8rje5FopDfI=;
 b=R/dQi5IeBBVHsiehLo5P0Z5JPXd0eLDxcBfEISsTYxpL4q6ioWE1CRFK5mPn/NpgV9o0dbCpl
 Iy9RSvpJmCQByw9oGaBO9bEnRpFSRcKx/lTAJiM1ur/DTClaRCoMyPm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

bin_attr_nvmem_eeprom_compat is the template from which all future
compat attributes are created.
Changing it means to change all subsquent compat attributes, too.

Instead only use the "fram" name for the currently registered attribute.

Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..1285300ed239 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -396,10 +396,9 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
 	if (!config->base_dev)
 		return -EINVAL;
 
-	if (config->type == NVMEM_TYPE_FRAM)
-		bin_attr_nvmem_eeprom_compat.attr.name = "fram";
-
 	nvmem->eeprom = bin_attr_nvmem_eeprom_compat;
+	if (config->type == NVMEM_TYPE_FRAM)
+		nvmem->eeprom.attr.name = "fram";
 	nvmem->eeprom.attr.mode = nvmem_bin_attr_get_umode(nvmem);
 	nvmem->eeprom.size = nvmem->size;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC

-- 
2.45.2


