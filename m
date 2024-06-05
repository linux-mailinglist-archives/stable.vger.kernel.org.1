Return-Path: <stable+bounces-48022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B12C8FCB55
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE371F24427
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56C194A53;
	Wed,  5 Jun 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+wO1efP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9399190050;
	Wed,  5 Jun 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588263; cv=none; b=U6FgOpqJu1CND+XUEBXAJsRrJ5fmxFEU/vsPGyeAni6cKW8K4wCjrIlH7znoEQsBKo2U3QKLI1961m0Lsydl7HhZognmJqvQSjgtFuskkz5AzbZ50IEh7+zJRAEGRN4P1+zI5nDFJ2oyyzD0w6obOQAOxRp/BW31DNGfeGCcx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588263; c=relaxed/simple;
	bh=JJbEb6Be+uGFHcPPviUGo9V6PlBpgcCgy8HtnK62XBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2c+Kskl/vZXKX4a6sPiopPTHPp2ZYtzX+LxkmHkeZXV86hF+KtBYTrCF5j79I/SngmBstypfFQ7twU9ibXGOvvmJ+s2N0nVWMO/Cb+xOAI6xKQ0uEmtPa0wPxr9GVa24TkoM3A2YJU3i440+OY3zjdtzyTSNAawrYtGicgZVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+wO1efP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C3C3277B;
	Wed,  5 Jun 2024 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588263;
	bh=JJbEb6Be+uGFHcPPviUGo9V6PlBpgcCgy8HtnK62XBI=;
	h=From:To:Cc:Subject:Date:From;
	b=o+wO1efPfxvK/Uh8oxtOIQcboHQZT4ExRolhdUTiWfMdE7816GfxhYkdlcfpdEUUj
	 fYoTHPYV87Uah2g8un0yfa8p8W0imo/CSCgOcZtE8Je/EZU8FvhHAddNt925Hfoqwl
	 CwfgROB4wYPL/mfeS4vjBWDvK23uGcuiYr7of7OBhkvzRoEh2LSJajSdSwKFOn5no3
	 lBqJnmKDykorJVj8JBB60sro5wRh72GImfLFfo2jxE3Qh2XWJ0bVX1deiXjG599wb2
	 REqEZTX8BYZQxyhqM1UmQNoUK0k0qJ14ybjbddln/7//oRA73mKYRGofdh7IDHjG++
	 wHAorx9WSs3qA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/24] usb: gadget: uvc: configfs: ensure guid to be valid before set
Date: Wed,  5 Jun 2024 07:50:11 -0400
Message-ID: <20240605115101.2962372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit f7a7f80ccc8df017507e2b1e1dd652361374d25b ]

When setting the guid via configfs it is possible to test if
its value is one of the kernel supported ones by calling
uvc_format_by_guid on it. If the result is NULL, we know the
guid is unsupported and can be ignored.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Link: https://lore.kernel.org/r/20240221-uvc-gadget-configfs-guid-v1-1-f0678ca62ebb@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_configfs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index a4377df612f51..6fac696ea8463 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -13,6 +13,7 @@
 #include "uvc_configfs.h"
 
 #include <linux/sort.h>
+#include <linux/usb/uvc.h>
 #include <linux/usb/video.h>
 
 /* -----------------------------------------------------------------------------
@@ -2260,6 +2261,8 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
 	struct f_uvc_opts *opts;
 	struct config_item *opts_item;
 	struct mutex *su_mutex = &ch->fmt.group.cg_subsys->su_mutex;
+	const struct uvc_format_desc *format;
+	u8 tmpguidFormat[sizeof(ch->desc.guidFormat)];
 	int ret;
 
 	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
@@ -2273,7 +2276,16 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
 		goto end;
 	}
 
-	memcpy(ch->desc.guidFormat, page,
+	memcpy(tmpguidFormat, page,
+	       min(sizeof(tmpguidFormat), len));
+
+	format = uvc_format_by_guid(tmpguidFormat);
+	if (!format) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	memcpy(ch->desc.guidFormat, tmpguidFormat,
 	       min(sizeof(ch->desc.guidFormat), len));
 	ret = sizeof(ch->desc.guidFormat);
 
-- 
2.43.0


