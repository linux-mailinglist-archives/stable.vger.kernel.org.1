Return-Path: <stable+bounces-2540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6D7F84C9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDAB1C274C7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E55F2D787;
	Fri, 24 Nov 2023 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T1SM1sus"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546F98;
	Fri, 24 Nov 2023 11:38:17 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75138FF809;
	Fri, 24 Nov 2023 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700854696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gK80R0M7dvN1cmSQk+8Hk9wbTsrIf4Z+IhzQHo3PHu8=;
	b=T1SM1suskaIuCwd4kbvQdQEiCDN0oAjSleDEKrXTCILUIxzphNI0zhgJybSIQIrmryz7u6
	/YnbjIthrPPA0P0XS/XbSETl0b5bvcraz1J7zgh3OpmKFVws61sAhJyKQC4od1wZ0zKV4a
	gJ7aRuJowhbUd693yO0AMyFGYvQcUqN6wEoB1METfs1byt7wZAvYW//nGnGXluRlC1OZpm
	YyNG4yJzmcLh6SCr5qTpsO7AhTckcVJLxpx4hV/2kjm4/ZB9eSf909vqMpK03xTx1xJe64
	CbpNxyvWlVIqiP/MSqUVwtp8E/CiUzuOmMynCt+i9twpmHLtcvtBLN1n8FDGHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: <linux-kernel@vger.kernel.org>,
	Michael Walle <michael@walle.cc>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH] nvmem: Do not expect fixed layouts to grab a layout driver
Date: Fri, 24 Nov 2023 20:38:14 +0100
Message-Id: <20231124193814.360552-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Two series lived in parallel for some time, which led to this situation:
- The nvmem-layout container is used for dynamic layouts
- We now expect fixed layouts to also use the nvmem-layout container but
this does not require any additional driver, the support is built-in the
nvmem core.

Ensure we don't refuse to probe for wrong reasons.

Fixes: 27f699e578b1 ("nvmem: core: add support for fixed cells *layout*")
Cc: stable@vger.kernel.org
Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Please note this is a temporary fix as this piece of code is going to
disappear when the NVMEM layouts 'as devices' series gets in.

 drivers/nvmem/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bf42b7e826db..608b352a7d91 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -796,6 +796,12 @@ static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 	if (!layout_np)
 		return NULL;
 
+	/* Fixed layouts don't have a matching driver */
+	if (of_device_is_compatible(layout_np, "fixed-layout")) {
+		of_node_put(layout_np);
+		return NULL;
+	}
+
 	/*
 	 * In case the nvmem device was built-in while the layout was built as a
 	 * module, we shall manually request the layout driver loading otherwise
-- 
2.34.1


