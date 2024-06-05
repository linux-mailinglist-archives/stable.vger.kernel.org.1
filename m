Return-Path: <stable+bounces-48046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C82A8FCBC5
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCA02895BD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D2919308F;
	Wed,  5 Jun 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfbtH53N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B2188CA4;
	Wed,  5 Jun 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588348; cv=none; b=TA9mtrUH+WVxBqUU9jVB9QpRqssBZg5+RJAYKAyfd+lr8O1J1w9eG4SX5sBOXXIsQ7/7j+KQyUdpaLElcHC5zKUNYnfmjzucptmKwKVdETjkAe+qN8HT9gfGw2JZq9RkAWmHNk0RIb4wDEZJ+ktlVTLxH4UxqwKy0ATvatu431Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588348; c=relaxed/simple;
	bh=QtB8mv8E4Dukpym+yLaodLWDBwrg6sLR/LVpNwBmWvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZLzjDfNy9kD5NZ4zD9w0E7D3y2MXNUdNoHUDobAbQdtOxv+idycTyPcoqwSQG2GbP8eDO5ho6UbZDTo5V7lZgNlRu6+uHLM1K1rATwDb3g+Oq+8t+eMjoNYJbxwKqrdBbKtWMaHwUpOg0ehrSR4KolgCIsE0fnU3dbPiWoCOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfbtH53N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA46C3277B;
	Wed,  5 Jun 2024 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588347;
	bh=QtB8mv8E4Dukpym+yLaodLWDBwrg6sLR/LVpNwBmWvE=;
	h=From:To:Cc:Subject:Date:From;
	b=DfbtH53NTlSGdu6f6dhxLIrRXxHtb3D4RZnr6U+AuxpMp7mjC0sFL5Paez8PK2uLk
	 IDledi4JmJ1XbdTuMArv1Y3wEGCAia2fjCXAG4k8HL2nquZ54KqAbrL3iSL8LrrQSk
	 EKStR88/wywIjMtLYBn7G6tvwYihY3C8aPalrqjxwjOZ4gYS1NrkSmnblM0EJN8yCr
	 rPYJB8olo9ZfC8Wtx67vVV5BQdorBsEIXznju9x40Eyx+AdTW/5PQD/byeK72rZpYo
	 LVIV3Bc5jmjdzb94sMWKIaCgxG/kq0C8HpMo6AhcG0Bxu5IaRGFHXHQmHScq4AeRbI
	 QL7lCP/e8h+Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/20] usb: gadget: uvc: configfs: ensure guid to be valid before set
Date: Wed,  5 Jun 2024 07:51:44 -0400
Message-ID: <20240605115225.2963242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index d16c04d2961b6..4acf336e946d6 100644
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


