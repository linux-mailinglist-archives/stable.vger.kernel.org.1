Return-Path: <stable+bounces-220886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF1+DP9Ho2l//AQAu9opvQ
	(envelope-from <stable+bounces-220886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C891B1C784D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEE433091662
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502342357B;
	Sat, 28 Feb 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUtJrKE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA859423573;
	Sat, 28 Feb 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300776; cv=none; b=g6RvbWh4+jIyui0I61eq3JKnDzHG2pdLZU/fYgp0i7kJF29fUt4SE/RXwJQABQmxi5NjzvHudPTP2qwghq5+C9sRG1CwjzkXGGoXdT7TO4tbVbqh4JeZ6JEkeidrj26O6AM74T9ICc03XGf/fxF1L77r4sVz/OrbG3tjkwgF66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300776; c=relaxed/simple;
	bh=D22sXEeJMslmAAsbB8Dliwp+gkAeNSn++Ovxt/kE01Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjmU2cqNZC3NqQBevN7o9IBdYPc4D8gBRTg1Q7Xm9lAl/RTOE4EtagbM4xFj+hXGsVKpqIFODwbEQIp1BRm8uE+zZ+o7tSXq/WthCKeWPeVA9l1DBu6rYLyil11MdAKmS6znaJydK+yujfwShSGWuZbegoTNiJjkCZ8QFrSd9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUtJrKE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB0BC116D0;
	Sat, 28 Feb 2026 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300776;
	bh=D22sXEeJMslmAAsbB8Dliwp+gkAeNSn++Ovxt/kE01Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUtJrKE+98p4spnXgAAO5ukXYlN4SanPrPp1F6ezrqMj3vtdem6lEh8dAx8E4R2bC
	 fhYzI69/tLGy1DMMOwdlNYB+q21/OWT7ylEAg6xkW9cftNZwyz6uTcoDY4lC5Ul4FK
	 fFSRa5QcntePxhgJAa5KmjGMT7/PeQ38YxNlclRjrdAiLpK46JLhLe58rwrH/IWyhF
	 E74oSr34LjVxBPIGz1JG9YN3td2+H88sO3sPb2OQCPVa69NOFjEbUy8crI02tL+hZp
	 vnk9902LAt1wcHLky0F3vu5N15yP+INPKuxC9GPPdwu//7XHiFfC8c6Kj9B0f4IiLn
	 V/LJTojrPnRJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 807/844] fbdev: Use device_create_with_groups() to fix sysfs groups registration race
Date: Sat, 28 Feb 2026 12:32:00 -0500
Message-ID: <20260228173244.1509663-808-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kylinos.cn,gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220886-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: C891B1C784D
X-Rspamd-Action: no action

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

[ Upstream commit 68eeb0871e986ae5462439dae881e3a27bcef85f ]

The fbdev sysfs attributes are registered after sending the uevent for
the device creation, leaving a race window where e.g. udev rules may
not be able to access the sysfs attributes because the registration is
not done yet.

Fix this by switching to device_create_with_groups(). This also results in
a nice cleanup. After switching to device_create_with_groups() all that
is left of fb_init_device() is setting the drvdata and that can be passed
to device_create[_with_groups]() too. After which fb_init_device() can
be completely removed.

Dropping fb_init_device() + fb_cleanup_device() in turn allows removing
fb_info.class_flag as they were the only user of this field.

Fixes: 5fc830d6aca1 ("fbdev: Register sysfs groups through device_add_group")
Cc: stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 36 +++---------------------------
 include/linux/fb.h                 |  1 -
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index b8344c40073b4..baa2bae0fb5b3 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -12,8 +12,6 @@
 
 #include "fb_internal.h"
 
-#define FB_SYSFS_FLAG_ATTR 1
-
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
@@ -451,33 +449,7 @@ static struct attribute *fb_device_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group fb_device_attr_group = {
-	.attrs          = fb_device_attrs,
-};
-
-static int fb_init_device(struct fb_info *fb_info)
-{
-	int ret;
-
-	dev_set_drvdata(fb_info->dev, fb_info);
-
-	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
-
-	ret = device_add_group(fb_info->dev, &fb_device_attr_group);
-	if (ret)
-		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
-
-	return 0;
-}
-
-static void fb_cleanup_device(struct fb_info *fb_info)
-{
-	if (fb_info->class_flag & FB_SYSFS_FLAG_ATTR) {
-		device_remove_group(fb_info->dev, &fb_device_attr_group);
-
-		fb_info->class_flag &= ~FB_SYSFS_FLAG_ATTR;
-	}
-}
+ATTRIBUTE_GROUPS(fb_device);
 
 int fb_device_create(struct fb_info *fb_info)
 {
@@ -485,14 +457,13 @@ int fb_device_create(struct fb_info *fb_info)
 	dev_t devt = MKDEV(FB_MAJOR, node);
 	int ret;
 
-	fb_info->dev = device_create(fb_class, fb_info->device, devt, NULL, "fb%d", node);
+	fb_info->dev = device_create_with_groups(fb_class, fb_info->device, devt, fb_info,
+						 fb_device_groups, "fb%d", node);
 	if (IS_ERR(fb_info->dev)) {
 		/* Not fatal */
 		ret = PTR_ERR(fb_info->dev);
 		pr_warn("Unable to create device for framebuffer %d; error %d\n", node, ret);
 		fb_info->dev = NULL;
-	} else {
-		fb_init_device(fb_info);
 	}
 
 	return 0;
@@ -505,7 +476,6 @@ void fb_device_destroy(struct fb_info *fb_info)
 	if (!fb_info->dev)
 		return;
 
-	fb_cleanup_device(fb_info);
 	device_destroy(fb_class, devt);
 	fb_info->dev = NULL;
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 05cc251035da9..c3302d5135466 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -497,7 +497,6 @@ struct fb_info {
 #if defined(CONFIG_FB_DEVICE)
 	struct device *dev;		/* This is this fb device */
 #endif
-	int class_flag;                    /* private sysfs flags */
 #ifdef CONFIG_FB_TILEBLITTING
 	struct fb_tile_ops *tileops;    /* Tile Blitting */
 #endif
-- 
2.51.0


