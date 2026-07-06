Return-Path: <stable+bounces-272113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aQIPHuX1SmpaKQEAu9opvQ
	(envelope-from <stable+bounces-272113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 02:25:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF270BD3A
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 02:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=GhzzuSo3;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272113-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272113-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E346300F576
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 00:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30961A681C;
	Mon,  6 Jul 2026 00:25:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CB19ABD8;
	Mon,  6 Jul 2026 00:25:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297503; cv=none; b=FVnnLA9lCV6MP/iiMiOMTWNrHfPI1lDVDJ8H6MVNI4Qd7non+1fnXEn7wuItFTdwZiAumeYL+l3J1KulvYApHc1bP27w4Scqtmfv5rZFd/OcysI5e4a6OtLwnZrGKr+YXWY+T4A3fE+eLjEiZjoA77ByGcjtQ5uGEaXLnZDFWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297503; c=relaxed/simple;
	bh=bCGdQ2URblDgbOtay0qpBnB6xMFjeIx5gHRDomOOfb4=;
	h=Date:To:From:Subject:Message-Id; b=k9ezPNCu56l83LE/2pHI4vfSvZ1bgdz9tOeZOMSkWjxx08swEFlHIpxjBWBFiLN2yI7MC7ssv/ENcdczo9e+a4E90rJKFX29JX8JFwrNWdhs1AeTqtoE5I5FKX3BL8Q6L8Lk6Hp/RE81DJKQ42y5h7wT7B9F7pW003gf0rtokwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GhzzuSo3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2A81F000E9;
	Mon,  6 Jul 2026 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783297502;
	bh=f9x0hn9xNIk0s66fvdI0ZtWo+WKKUa3VOwQiKb65Zpo=;
	h=Date:To:From:Subject;
	b=GhzzuSo3hMf1XF9MC8yo5fxLg8R8e0z5l4LmlaC1IVM/T2rqgwckCMkJUGTeFKC/N
	 sFVeOWOd83GgpAAOiG1m2gvbMWnBWBpiDIPoBMM7q4DPb4leF1VAH4mD+tMSvKnac1
	 FLjoWi/ErKHT0BItl/mS46TusgSknhHLVOwo12aU=
Date: Sun, 05 Jul 2026 17:25:01 -0700
To: mm-commits@vger.kernel.org,vishal.l.verma@intel.com,stable@vger.kernel.org,dave.jiang@intel.com,dan.j.williams@intel.com,alison.schofield@intel.com,lgs201920130244@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] device-dax-fix-refcount-leak-in-__devm_create_dev_dax-error-path.patch removed from -mm tree
Message-Id: <20260706002502.1E2A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272113-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vishal.l.verma@intel.com,m:stable@vger.kernel.org,m:dave.jiang@intel.com,m:dan.j.williams@intel.com,m:alison.schofield@intel.com,m:lgs201920130244@gmail.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,intel.com,gmail.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFDF270BD3A


The quilt patch titled
     Subject: device-dax: fix refcount leak in __devm_create_dev_dax() error path
has been removed from the -mm tree.  Its filename was
     device-dax-fix-refcount-leak-in-__devm_create_dev_dax-error-path.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Guangshuo Li <lgs201920130244@gmail.com>
Subject: device-dax: fix refcount leak in __devm_create_dev_dax() error path
Date: Sun, 12 Apr 2026 15:00:10 +0800

After device_initialize(), the embedded struct device in dev_dax is
expected to be released through the device core with put_device().

In __devm_create_dev_dax(), several failure paths after
device_initialize() free dev_dax directly instead of dropping the device
reference, which bypasses the normal device core lifetime handling and
leaks the reference held on the embedded struct device.

Fix this by assigning dev->type before device_initialize(), so the release
callback is available, use put_device() in the post-initialization error
paths, and keep dev_dax range cleanup explicit since it is not handled by
dev_dax_release().

Link: https://lore.kernel.org/20260412070010.2402830-1-lgs201920130244@gmail.com
Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/dax/bus.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/dax/bus.c~device-dax-fix-refcount-leak-in-__devm_create_dev_dax-error-path
+++ a/drivers/dax/bus.c
@@ -1485,6 +1485,7 @@ static struct dev_dax *__devm_create_dev
 	}
 
 	dev = &dev_dax->dev;
+	dev->type = &dev_dax_type;
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
@@ -1531,7 +1532,6 @@ static struct dev_dax *__devm_create_dev
 	dev->devt = inode->i_rdev;
 	dev->bus = &dax_bus_type;
 	dev->parent = parent;
-	dev->type = &dev_dax_type;
 
 	rc = device_add(dev);
 	if (rc) {
@@ -1554,14 +1554,13 @@ static struct dev_dax *__devm_create_dev
 	return dev_dax;
 
 err_alloc_dax:
-	kfree(dev_dax->pgmap);
 err_pgmap:
 	free_dev_dax_ranges(dev_dax);
 err_range:
-	free_dev_dax_id(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
 err_id:
 	kfree(dev_dax);
-
 	return ERR_PTR(rc);
 }
 
_

Patches currently in -mm which might be from lgs201920130244@gmail.com are



