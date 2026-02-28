Return-Path: <stable+bounces-220443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ3uIaQ2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9231C61AB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57C0330DF3BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF03B6C86;
	Sat, 28 Feb 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpsckwFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82B3B5C15;
	Sat, 28 Feb 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300332; cv=none; b=SeGB9Fq1c3zfycXWtLUUPL9zDi23h+YXnSxE2FuKub5tutZZkoT8TCveqAKX7Ttw5BIY0NAQtA8m70tc/8ddYkgOdXavo/Bk7n4QBIpknE9DXsNNIT3/8icOJ16kneegIv0z3Js4EKy1mMhEq+LgK8UcRv6ALCRxPD3GAWvk3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300332; c=relaxed/simple;
	bh=KKUiJY5BMU9CiNqmrwD1kfpk+y+W+aEkS7gg43iaqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feM7HkY3ulwCmjEhzd+PTmruI2vWSvd33n85BlN7MJH18Xwk82BeA2RNHW8dX8YuQzBGy2N5Q74SNWjPvraWSIQVwgT4UEArvMRGekicnVdOekeB2oCXEJ/B7sYIyAL6roUF+jwKsDd3beIkd8R1oADUHa1hY0mB/C6TWRETDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpsckwFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5832DC19423;
	Sat, 28 Feb 2026 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300331;
	bh=KKUiJY5BMU9CiNqmrwD1kfpk+y+W+aEkS7gg43iaqK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpsckwFUErBuN7389uUiF3ozzLpO8RidF36/n9GdLd7C4xX7UrrXR0dhCyrnXwSmH
	 ztb2ZtHhuPkcPeGRkRvoknAqxi+Ft8m+U+JpnNPgNZMyIhxk0n5q+Nr249OhaeHDki
	 cTQxuklbwwGL8tNHVolYQG7G57CAA6SlBrFpQrPT+HCfTwNBVft5nVu8h3jnDgPSsZ
	 NsudZaUCkwB6RjO5+UiOiEgY4QA3eCKTooNsmzvIsfDhgJM6whTiqZmqspcYhhTA4K
	 umgtcqoWO/o2dhBWwOFPSnH6mWPqVgcVIHeSYsyEWKEovPPOGNdfkOwqLQjnTbIECD
	 aojkXTXi5Rilg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefano Stabellini <stefano.stabellini@amd.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 364/844] 9p/xen: protect xen_9pfs_front_free against concurrent calls
Date: Sat, 28 Feb 2026 12:24:37 -0500
Message-ID: <20260228173244.1509663-365-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220443-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0F9231C61AB
X-Rspamd-Action: no action

From: Stefano Stabellini <stefano.stabellini@amd.com>

[ Upstream commit ce8ded2e61f47747e31eeefb44dc24a2160a7e32 ]

The xenwatch thread can race with other back-end change notifications
and call xen_9pfs_front_free() twice, hitting the observed general
protection fault due to a double-free. Guard the teardown path so only
one caller can release the front-end state at a time, preventing the
crash.

This is a fix for the following double-free:

[   27.052347] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[   27.052357] CPU: 0 UID: 0 PID: 32 Comm: xenwatch Not tainted 6.18.0-02087-g51ab33fc0a8b-dirty #60 PREEMPT(none)
[   27.052363] RIP: e030:xen_9pfs_front_free+0x1d/0x150
[   27.052368] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 41 55 41 54 55 48 89 fd 48 c7 c7 48 d0 92 85 53 e8 cb cb 05 00 48 8b 45 08 48 8b 55 00 <48> 3b 28 0f 85 f9 28 35 fe 48 3b 6a 08 0f 85 ef 28 35 fe 48 89 42
[   27.052377] RSP: e02b:ffffc9004016fdd0 EFLAGS: 00010246
[   27.052381] RAX: 6b6b6b6b6b6b6b6b RBX: ffff88800d66e400 RCX: 0000000000000000
[   27.052385] RDX: 6b6b6b6b6b6b6b6b RSI: 0000000000000000 RDI: 0000000000000000
[   27.052389] RBP: ffff88800a887040 R08: 0000000000000000 R09: 0000000000000000
[   27.052393] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888009e46b68
[   27.052397] R13: 0000000000000200 R14: 0000000000000000 R15: ffff88800a887040
[   27.052404] FS:  0000000000000000(0000) GS:ffff88808ca57000(0000) knlGS:0000000000000000
[   27.052408] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.052412] CR2: 00007f9714004360 CR3: 0000000004834000 CR4: 0000000000050660
[   27.052418] Call Trace:
[   27.052420]  <TASK>
[   27.052422]  xen_9pfs_front_changed+0x5d5/0x720
[   27.052426]  ? xenbus_otherend_changed+0x72/0x140
[   27.052430]  ? __pfx_xenwatch_thread+0x10/0x10
[   27.052434]  xenwatch_thread+0x94/0x1c0
[   27.052438]  ? __pfx_autoremove_wake_function+0x10/0x10
[   27.052442]  kthread+0xf8/0x240
[   27.052445]  ? __pfx_kthread+0x10/0x10
[   27.052449]  ? __pfx_kthread+0x10/0x10
[   27.052452]  ret_from_fork+0x16b/0x1a0
[   27.052456]  ? __pfx_kthread+0x10/0x10
[   27.052459]  ret_from_fork_asm+0x1a/0x30
[   27.052463]  </TASK>
[   27.052465] Modules linked in:
[   27.052471] ---[ end trace 0000000000000000 ]---

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Message-ID: <20260129230348.2390470-1-stefano.stabellini@amd.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_xen.c | 85 ++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 12f752a923324..9bbfc20744f69 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -277,45 +277,52 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 {
 	int i, j;
 
-	write_lock(&xen_9pfs_lock);
-	list_del(&priv->list);
-	write_unlock(&xen_9pfs_lock);
-
-	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
-		struct xen_9pfs_dataring *ring = &priv->rings[i];
-
-		cancel_work_sync(&ring->work);
-
-		if (!priv->rings[i].intf)
-			break;
-		if (priv->rings[i].irq > 0)
-			unbind_from_irqhandler(priv->rings[i].irq, ring);
-		if (priv->rings[i].data.in) {
-			for (j = 0;
-			     j < (1 << priv->rings[i].intf->ring_order);
-			     j++) {
-				grant_ref_t ref;
-
-				ref = priv->rings[i].intf->ref[j];
-				gnttab_end_foreign_access(ref, NULL);
-			}
-			free_pages_exact(priv->rings[i].data.in,
+	if (priv->rings) {
+		for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
+			struct xen_9pfs_dataring *ring = &priv->rings[i];
+
+			cancel_work_sync(&ring->work);
+
+			if (!priv->rings[i].intf)
+				break;
+			if (priv->rings[i].irq > 0)
+				unbind_from_irqhandler(priv->rings[i].irq, ring);
+			if (priv->rings[i].data.in) {
+				for (j = 0;
+				     j < (1 << priv->rings[i].intf->ring_order);
+				     j++) {
+					grant_ref_t ref;
+
+					ref = priv->rings[i].intf->ref[j];
+					gnttab_end_foreign_access(ref, NULL);
+				}
+				free_pages_exact(priv->rings[i].data.in,
 				   1UL << (priv->rings[i].intf->ring_order +
 					   XEN_PAGE_SHIFT));
+			}
+			gnttab_end_foreign_access(priv->rings[i].ref, NULL);
+			free_page((unsigned long)priv->rings[i].intf);
 		}
-		gnttab_end_foreign_access(priv->rings[i].ref, NULL);
-		free_page((unsigned long)priv->rings[i].intf);
+		kfree(priv->rings);
 	}
-	kfree(priv->rings);
 	kfree(priv->tag);
 	kfree(priv);
 }
 
 static void xen_9pfs_front_remove(struct xenbus_device *dev)
 {
-	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
+	struct xen_9pfs_front_priv *priv;
 
+	write_lock(&xen_9pfs_lock);
+	priv = dev_get_drvdata(&dev->dev);
+	if (priv == NULL) {
+		write_unlock(&xen_9pfs_lock);
+		return;
+	}
 	dev_set_drvdata(&dev->dev, NULL);
+	list_del(&priv->list);
+	write_unlock(&xen_9pfs_lock);
+
 	xen_9pfs_front_free(priv);
 }
 
@@ -382,7 +389,7 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 {
 	int ret, i;
 	struct xenbus_transaction xbt;
-	struct xen_9pfs_front_priv *priv = dev_get_drvdata(&dev->dev);
+	struct xen_9pfs_front_priv *priv;
 	char *versions, *v;
 	unsigned int max_rings, max_ring_order, len = 0;
 
@@ -410,6 +417,10 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
 		p9_xen_trans.maxsize = XEN_FLEX_RING_SIZE(max_ring_order) / 2;
 
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
 	priv->rings = kcalloc(XEN_9PFS_NUM_RINGS, sizeof(*priv->rings),
 			      GFP_KERNEL);
 	if (!priv->rings) {
@@ -468,6 +479,11 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 		goto error;
 	}
 
+	write_lock(&xen_9pfs_lock);
+	dev_set_drvdata(&dev->dev, priv);
+	list_add_tail(&priv->list, &xen_9pfs_devs);
+	write_unlock(&xen_9pfs_lock);
+
 	xenbus_switch_state(dev, XenbusStateInitialised);
 	return 0;
 
@@ -482,19 +498,6 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 static int xen_9pfs_front_probe(struct xenbus_device *dev,
 				const struct xenbus_device_id *id)
 {
-	struct xen_9pfs_front_priv *priv = NULL;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->dev = dev;
-	dev_set_drvdata(&dev->dev, priv);
-
-	write_lock(&xen_9pfs_lock);
-	list_add_tail(&priv->list, &xen_9pfs_devs);
-	write_unlock(&xen_9pfs_lock);
-
 	return 0;
 }
 
-- 
2.51.0


