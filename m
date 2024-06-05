Return-Path: <stable+bounces-47994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8858FCADE
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819F028AEF4
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F118C34D;
	Wed,  5 Jun 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEs2GZSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CAD27459;
	Wed,  5 Jun 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588169; cv=none; b=tyaWtF4vd3wOY6DMV2VTwfqtg9Q2Bpu0YhG0VCcQ+DqSG7oofWeGJAwlN9nsZje5OzZi4HWHXrdQvuPOmKRB2cOksibsSbr1umbNXisamZx3yWKb0I3wi3rd9yeBuO3G+onpotRjosIzwB1RnBtz4nxwXoEszvpOc2xGe2VdmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588169; c=relaxed/simple;
	bh=JJbEb6Be+uGFHcPPviUGo9V6PlBpgcCgy8HtnK62XBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1FdoSJgJKLgx+qSVyM8WKbxHyvZujmWAVudn/7eQaikWoBjp5tpK3D8N5v8Y+fRQLLI5W6efr+4R23gs5SHn2EUZJw+grMKxAmGxclmVHt0CIwYH9/NhX7tv3qVGfqWVtS2ZObx4vm15jm5fTfhgxKilXv42EBVv8twExKp/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEs2GZSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B860C3277B;
	Wed,  5 Jun 2024 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588169;
	bh=JJbEb6Be+uGFHcPPviUGo9V6PlBpgcCgy8HtnK62XBI=;
	h=From:To:Cc:Subject:Date:From;
	b=pEs2GZSjhoI052k+119dcqpUX79fqtUZbcUG4n6w9FV2UUUKuNlAsLb/hSVy1s5f7
	 y/zYf9LDXhBBdnlDr7uM6tKidngWplu810MKaiZfI3yfop34E7kP39r/8nnq/EYFMP
	 nU5JsSIo1ElUB7R/Jpwhqi8jufL910rYRit3mv4l+ULMLFBAxBx6MRfY6jYeUy/hi8
	 1jHr8mtKWL4VRXzuwbU9uzWLG4xpoQdFFVjD7lycMjKIAascSwkai4HvOqWMjfsfoT
	 JqfR2eaGYfjW+PwnhzpRbhogTIHNkS2WvBWOl8vk4tO1gWjQD6ZTFjYDFE0oJAGULA
	 PktPuU2rrCZvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 01/28] usb: gadget: uvc: configfs: ensure guid to be valid before set
Date: Wed,  5 Jun 2024 07:48:30 -0400
Message-ID: <20240605114927.2961639-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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


