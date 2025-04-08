Return-Path: <stable+bounces-130497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD2A8057E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF65883989
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2D26A0EC;
	Tue,  8 Apr 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xSHKcwi+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B226A0E4;
	Tue,  8 Apr 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113869; cv=none; b=XWN3dmOINV2C9hO+b2ci/OTjJD3Wj5Kv2/mFQzy1eYKjX9mcHrN6mto++kXcRZgWUK2cExSyQwcB4LeBhL+RJFUsl6j+4kqR+zthC8JR8O9RmU1Tmhdc8LcUUb7mDIbODHpUy2CxuOz1dGW8DT7m97c5/LZWWh6KmL5FFeF1QKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113869; c=relaxed/simple;
	bh=VWq8PnILsYrKPvt9fcrxxV8EPagLFybW3eFBcvwHWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJCaXGLGnOudqh68XrgBQrfeTO9tkoFD/S5sRa9L/sMoAi3GnQgQbCS+rLyKU5IghZDUQiP6ppTvYmsAindL0SHPBO/9c+16Yu2pxYlbvaHEl+vUd8djq/XZ8lAytmk63V6L31+MTIOAu+s7bKZrE7nw3W/ZDGaLwABAkkQyHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xSHKcwi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79288C4CEE7;
	Tue,  8 Apr 2025 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113868;
	bh=VWq8PnILsYrKPvt9fcrxxV8EPagLFybW3eFBcvwHWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xSHKcwi+msD1q9SnzaFLGE95QPyKsTrmlPERCT4TsRn2juwxFnT31O1q5mKzN1jty
	 b5WpfEMLf0xGecZdHHiqsax8v+fdFDJOydB4NrIi1svfCYNEbHesd8BySWeneHbuw6
	 LtSE410rB93/f+LGRNqBdSo3mvK08XTFiGeFQQ70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/154] i2c: sis630: Fix an error handling path in sis630_probe()
Date: Tue,  8 Apr 2025 12:49:51 +0200
Message-ID: <20250408104816.882080718@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104815.295196624@linuxfoundation.org>
References: <20250408104815.295196624@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 2b22459792fcb4def9f0936d64575ac11a95a58d ]

If i2c_add_adapter() fails, the request_region() call in sis630_setup()
must be undone by a corresponding release_region() call, as done in the
remove function.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/3d607601f2c38e896b10207963c6ab499ca5c307.1741033587.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sis630.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index cfb8e04a2a831..6befa6ff83f26 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -509,6 +509,8 @@ MODULE_DEVICE_TABLE(pci, sis630_ids);
 
 static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int ret;
+
 	if (sis630_setup(dev)) {
 		dev_err(&dev->dev,
 			"SIS630 compatible bus not detected, "
@@ -522,7 +524,15 @@ static int sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
 		 "SMBus SIS630 adapter at %04x", smbus_base + SMB_STS);
 
-	return i2c_add_adapter(&sis630_adapter);
+	ret = i2c_add_adapter(&sis630_adapter);
+	if (ret)
+		goto release_region;
+
+	return 0;
+
+release_region:
+	release_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION);
+	return ret;
 }
 
 static void sis630_remove(struct pci_dev *dev)
-- 
2.39.5




