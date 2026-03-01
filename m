Return-Path: <stable+bounces-221816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAxSNx+ao2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:45:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6571CB889
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B579307E49C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A542BD59C;
	Sun,  1 Mar 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDDXbw9X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B652C15B0;
	Sun,  1 Mar 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329207; cv=none; b=YsJ0YDMxBtJTBvli/FG5KFr9Mr8uQsTeG/eLe7yAk4QmRpuqQ+5CWpwUbplY/kLrluAr7MhRYIvo9KxdCdrp1tmTtT65R2CYLZaVZiPcKFjZVSPnf4CvSUtk74PDrHFdMUax1eoPNNThQwSyz5YEaj9xPGcCClEzatEQiNaHVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329207; c=relaxed/simple;
	bh=rBIsAzN40tFJVmKTg7xdRe7zK2j5JPJe4lllEEaZmGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzCGXfAR419EJyirSsB/PpNhgtCA4IEyRAUEbVZrLbcv+rtoYFdfJwB+RCAM877qD8ZYr7Ax27OyBefnbq7rA/cRX6IBI4qegAMT1wDj7L4mSEnSfKYkQjKkVT7k5XcFXk325ZscyHmsr10ZK7em0kDQ02tyWj5dPGIfdy5KieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDDXbw9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C42C2BCAF;
	Sun,  1 Mar 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329207;
	bh=rBIsAzN40tFJVmKTg7xdRe7zK2j5JPJe4lllEEaZmGw=;
	h=From:To:Cc:Subject:Date:From;
	b=BDDXbw9XG2pJlk0VRTGZe217PpX8kBElxxqvSmB3tQSg/z9zbcfsMOy9onJIj8je4
	 CcchZGQWlswNkQQ1TaR93ACqUH8xkPX/kVi/XvszMSV/0Vxqn9t/2TkWU/GPoBueQ0
	 tDzlhK+UTnrhvuc54OdvRN9xKvjEhU7WOJiGdQTrDv/uG5lEpm1ziyXo+POlkBGdZ9
	 RIfMrlGizC1p3nYm7AvLqFiZ1BJ4GUlCQf8HUbEa23/in1zWmYSoTi4gxORqiuKwzq
	 6ZnlrhuLtuiXrswHH+5Ry9Kz4B/h3VtYOQFp39bVtW7Rp8O+uM6weKUQWKcQklUD++
	 5q9h4cYHCZrYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hanguidong02@gmail.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org
Subject: FAILED: Patch "rpmsg: core: fix race in driver_override_show() and use core helper" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:40:05 -0500
Message-ID: <20260301014005.1701263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221816-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 7A6571CB889
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 42023d4b6d2661a40ee2dcf7e1a3528a35c638ca Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 3 Dec 2025 01:49:48 +0800
Subject: [PATCH] rpmsg: core: fix race in driver_override_show() and use core
 helper

The driver_override_show function reads the driver_override string
without holding the device_lock. However, the store function modifies
and frees the string while holding the device_lock. This creates a race
condition where the string can be freed by the store function while
being read by the show function, leading to a use-after-free.

To fix this, replace the rpmsg_string_attr macro with explicit show and
store functions. The new driver_override_store uses the standard
driver_set_override helper. Since the introduction of
driver_set_override, the comments in include/linux/rpmsg.h have stated
that this helper must be used to set or clear driver_override, but the
implementation was not updated until now.

Because driver_set_override modifies and frees the string while holding
the device_lock, the new driver_override_show now correctly holds the
device_lock during the read operation to prevent the race.

Additionally, since rpmsg_string_attr has only ever been used for
driver_override, removing the macro simplifies the code.

Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://lore.kernel.org/r/20251202174948.12693-1-hanguidong02@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 66 ++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 5d661681a9b6c..96964745065b1 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -352,50 +352,38 @@ field##_show(struct device *dev,					\
 }									\
 static DEVICE_ATTR_RO(field);
 
-#define rpmsg_string_attr(field, member)				\
-static ssize_t								\
-field##_store(struct device *dev, struct device_attribute *attr,	\
-	      const char *buf, size_t sz)				\
-{									\
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	const char *old;						\
-	char *new;							\
-									\
-	new = kstrndup(buf, sz, GFP_KERNEL);				\
-	if (!new)							\
-		return -ENOMEM;						\
-	new[strcspn(new, "\n")] = '\0';					\
-									\
-	device_lock(dev);						\
-	old = rpdev->member;						\
-	if (strlen(new)) {						\
-		rpdev->member = new;					\
-	} else {							\
-		kfree(new);						\
-		rpdev->member = NULL;					\
-	}								\
-	device_unlock(dev);						\
-									\
-	kfree(old);							\
-									\
-	return sz;							\
-}									\
-static ssize_t								\
-field##_show(struct device *dev,					\
-	     struct device_attribute *attr, char *buf)			\
-{									\
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-									\
-	return sprintf(buf, "%s\n", rpdev->member);			\
-}									\
-static DEVICE_ATTR_RW(field)
-
 /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
 rpmsg_show_attr(name, id.name, "%s\n");
 rpmsg_show_attr(src, src, "0x%x\n");
 rpmsg_show_attr(dst, dst, "0x%x\n");
 rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
-rpmsg_string_attr(driver_override, driver_override);
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	int ret;
+
+	ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
+	device_unlock(dev);
+	return len;
+}
+static DEVICE_ATTR_RW(driver_override);
 
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
-- 
2.51.0





