Return-Path: <stable+bounces-259848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ORxWJhwAH2r5cgAAu9opvQ
	(envelope-from <stable+bounces-259848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 18:09:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BA63012D
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 18:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="Z92/bQcE";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259848-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259848-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D049300EEB6
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C43F4103;
	Tue,  2 Jun 2026 16:08:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m819.xmail.ntesmail.com (mail-m819.xmail.ntesmail.com [156.224.81.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4C3F2101;
	Tue,  2 Jun 2026 16:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416529; cv=none; b=dcS/9hxRx58XLxIDbbI0O2IxDKQ3W0xZW6hDoe8Tt7i6piemxLwqPmWjFadDoO8y1ydoCxDzPx1qVMQpOO7bYue543dXGGi9vTxuWnp1K2vfWsp5gdwOQ35hIixSjaflhcYRsgzohdXhw/6mZunwh0FIqcBbfAopw1xd7KK3oCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416529; c=relaxed/simple;
	bh=/dxd1w1Z4p1qXeKSkpPm9LLgT66hi/yOB1ic5liOB8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8JN0Pjyxn9j4yKanTY4hEwq8/LHtqlzmkmSS5GJvjeR2lNcJ1aiqz4yRd23GbTh1X7njpK+fXcL22+e4LPUswa8AbGxOf3dJFOtMxesjFl48Bh5Sn1ndvGADQ1JwfMYJ4zqUBAoj5dt/rW6efPxrxQc125oFmjSxpHXTlLaWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Z92/bQcE; arc=none smtp.client-ip=156.224.81.9
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40c833190;
	Wed, 3 Jun 2026 00:08:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	cornelia.huck@de.ibm.com,
	tom.leiming@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH] driver core: enforce device_lock for driver_match_device()
Date: Wed,  3 Jun 2026 00:08:29 +0800
Message-Id: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e891823ab03a1kunma0d54db01926cb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR1OVh5KHU9KTxoYTkNITVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Z92/bQcEbrTAQC21z4QNlyuNi0cR6zaYQaa1BH3Yv5J7Q/B3ObwAJr7N7JSSxqdgNY3NOWmQnHHE02tXGEIG0M2mrnu1hRyyJ3MCGJx/To6w5HDiYoiwATMcH6QT8ctwaF2EYNm++Blo/m442FCnz/+5//G46d6GsjwCsBe8ni8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=TMIrFCf68MYkdSisx6DJkrXbUQyDb1aXETgy1WjzwD8=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,de.ibm.com,gmail.com,vger.kernel.org,seu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259848-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:cornelia.huck@de.ibm.com,m:tom.leiming@gmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:tomleiming@gmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,seu.edu.cn:mid,seu.edu.cn:dkim,seu.edu.cn:from_mime,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 110BA63012D

Currently driver_match_device() is called from three sites. The
__device_attach_driver() path already runs under device_lock(dev), but
bind_store() and __driver_attach() can still enter bus match()
callbacks without that lock held.

That inconsistency leaves bus-private driver_override readers exposed.
Several buses still read private driver_override strings from their
match callbacks while the write side relies on driver_set_override()
under device_lock(dev). If bind_store() or __driver_attach() reaches
such a match callback without that lock, it can race with
driver_override replacement and old-string free.

This issue was first flagged by our static analysis tool while auditing
driver_override match paths, then manually confirmed on Linux v6.18.21.
We reproduced the race with no-device KCSAN/MSV harnesses across AMBA,
WMI, RPMSG, VMBUS, VDPA, CDX, CSS, FSL-MC, and PCI. Those reports all
reduce to the same core-side gap in driver_match_device().

Fix this by introducing driver_match_device_locked(), which guarantees
holding device_lock(dev) with a scoped guard before entering the bus
match callback. Convert the two unlocked call sites to this helper, and
add a device_lock_assert() to driver_match_device() so the contract is
explicit.

This matches the locking requirement already assumed by
driver_set_override()-based driver_override implementations and avoids
trying to paper over the problem in each individual bus match()
callback, where taking device_lock(dev) locally would conflict with
already-locked callers.

Build-tested with:
  make olddefconfig
  make -j"$(nproc)" drivers/base/bus.o drivers/base/dd.o

Fixes: 49b420a13ff9 ("driver core: check bus->match without holding device lock")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/base/base.h | 10 ++++++++++
 drivers/base/bus.c  |  2 +-
 drivers/base/dd.c   |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 86fa7fbb3548..4ec487e34d1a 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -166,9 +166,19 @@ void device_set_deferred_probe_reason(const struct device *dev, struct va_format
 static inline int driver_match_device(const struct device_driver *drv,
 				      struct device *dev)
 {
+	device_lock_assert(dev);
+
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 
+static inline int driver_match_device_locked(const struct device_driver *drv,
+					     struct device *dev)
+{
+	guard(device)(dev);
+
+	return driver_match_device(drv, dev);
+}
+
 static inline void dev_sync_state(struct device *dev)
 {
 	if (dev->bus->sync_state)
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 2653670f962f..2b039aa2da74 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -263,7 +263,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	int err = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && driver_match_device(drv, dev)) {
+	if (dev && driver_match_device_locked(drv, dev)) {
 		err = device_driver_attach(drv, dev);
 		if (!err) {
 			/* success */
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 2996f4c667c4..30c3e55ff5ff 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1230,7 +1230,7 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
-	ret = driver_match_device(drv, dev);
+	ret = driver_match_device_locked(drv, dev);
 	if (ret == 0) {
 		/* no match */
 		return 0;
-- 
2.34.1

