Return-Path: <stable+bounces-46214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4368CF370
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439371F21AF4
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216394EB46;
	Sun, 26 May 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQwuqhfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4A4EB20;
	Sun, 26 May 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716561; cv=none; b=bLq3/InCuTZy1H5Tf8ppwiJdO5/n1rK0beJ9IaoIaFGoaBdYSdemsyHZClhAwC7KC1b+1BMJ1zlj4NWUoA4gq6EWMpVWDRJjmE0d8WKbgPTCz+6q5D6B+h8vmXA9Bw7UPGK/bB8KS0djSkfKu2RvjtXjmOP1TgXXMwoLtCN/1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716561; c=relaxed/simple;
	bh=yZCx+Ui138RWNHsw6N6p9WbGX2dhsHntqReUeJevRsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5f6onhXUE7aJ5re/sOTm5lDAUsSJS7vFN0LvC9cEfhNBNzZuHZpUTqndHU59uw6va4RQWNAhVNgmVomj5R5QArzG5P0rQFJ1hPr7WmZ6NgCeRY4sDNsE6CiMMXGUoeJdbxnA5U1zoju5gHnsTr2TvjzA/dIjTizHoyYS6NaqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQwuqhfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC6DC32781;
	Sun, 26 May 2024 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716561;
	bh=yZCx+Ui138RWNHsw6N6p9WbGX2dhsHntqReUeJevRsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQwuqhfCdyNrApf6+1t0Ebak75V9be+zAlfWWCzBgH/1jXZCbLpYfMCNpjXIAj6J5
	 skDe8adFDeCtxlOS3oB5vpYjdMI5vhu63NjNe/DPDzVFG222srwiXHZC1qPpjEOreV
	 5Eo71NHg/Bhy8+lb+9YzbjG/z/42vhtuN1RaOF/krz6o4ABvAHLXTUB8+TaPGrUknl
	 1M8w5PIHHzgeMy0HwnVBidGdfhiGFS0na1qJBVE2uRbJ05GzF+nLSsDfNUDtDZ6+mg
	 t+X4iXjk0w8U5APVTJSHpKboERCN0fDJUVGGh5Dpuq/KFmzzzFkiAUn/3J6Pv3Rgfz
	 tXSw1x+cLroeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 11/14] platform/chrome: cros_usbpd_notify: provide ID table for avoiding fallback match
Date: Sun, 26 May 2024 05:42:16 -0400
Message-ID: <20240526094224.3412675-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094224.3412675-1-sashal@kernel.org>
References: <20240526094224.3412675-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.10
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 8ad3b9652ed6a115c56214a0eab06952818b3ddf ]

Instead of using fallback driver name match, provide ID table[1] for the
primary match.

[1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c#L1353

Reviewed-by: Benson Leung <bleung@chromium.org>
Acked-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20240329075630.2069474-8-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index aacad022f21df..c83f81d86483c 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
@@ -218,12 +219,19 @@ static void cros_usbpd_notify_remove_plat(struct platform_device *pdev)
 					   &pdnotify->nb);
 }
 
+static const struct platform_device_id cros_usbpd_notify_id[] = {
+	{ DRV_NAME, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, cros_usbpd_notify_id);
+
 static struct platform_driver cros_usbpd_notify_plat_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_usbpd_notify_probe_plat,
 	.remove_new = cros_usbpd_notify_remove_plat,
+	.id_table = cros_usbpd_notify_id,
 };
 
 static int __init cros_usbpd_notify_init(void)
@@ -258,4 +266,3 @@ module_exit(cros_usbpd_notify_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
 MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0


