Return-Path: <stable+bounces-216729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJWrIXBEk2kP3AEAu9opvQ
	(envelope-from <stable+bounces-216729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:23:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A1146127
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37CC03073F55
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A09331A46;
	Mon, 16 Feb 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zAzl9SNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458E32B98D;
	Mon, 16 Feb 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258727; cv=none; b=bUopB54leiXCN5nECoK1ew/6wjL6WxNBHwFqKWvDTe8hDvNp0k0z0JdYa8L5hxo9Ee7prCMelMwFxU3eO5bRfZJ7COzlMbFDbMpznaDghu2Y6VZt991UcIA0hVunFH389cxF/hcl1FlPOjWOOSNpGgZY5xSM0A/F/3o3RcxXrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258727; c=relaxed/simple;
	bh=B3SwJHFdyRQxoSDykEtIGBWF2tsn5JvRH+m2h5uwkZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siAtKhKyRkc4lbd/VWU4Wq2X7ZE66Jx8NMyVoNCQ0eRxGU9yvoVs7y8bwEGuf1Tm7o1smPLdTBDTbK8xQeJNN0yNuv85Jx7CZaWLIS7pH9W4sfCBqnYzt75RjbMNKRX4QwIOIeWHVb6wz0YKtNdz+hviOJyHZBcWObyDfZ96O4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zAzl9SNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2F6C116C6;
	Mon, 16 Feb 2026 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771258727;
	bh=B3SwJHFdyRQxoSDykEtIGBWF2tsn5JvRH+m2h5uwkZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zAzl9SNraT4i9NV5EdURt/fiSHESAxLuMIrhD0snerUqVqp//nwmySCUm4jZj2b3q
	 sr0YQUzEoJAvo9XxwQPRcbP0LwY0fLtmkw1D3baqOMtS2TusW8W74i8O8Bk/gO+gms
	 8En7DI6/8L83JrtRA3EjXqtthJGMKiTmR3iZSoyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.73
Date: Mon, 16 Feb 2026 17:18:35 +0100
Message-ID: <2026021612-rectangle-overturn-ddbe@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026021612-paddle-directed-be1c@gregkh>
References: <2026021612-paddle-directed-be1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216729-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D11A1146127
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 8af8b413c054..39a05470fbce 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 72
+SUBLEVEL = 73
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 8e1fe3dfa318..c4ffd0995043 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -165,18 +165,9 @@ void device_set_deferred_probe_reason(const struct device *dev, struct va_format
 static inline int driver_match_device(const struct device_driver *drv,
 				      struct device *dev)
 {
-	device_lock_assert(dev);
-
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 
-static inline int driver_match_device_locked(const struct device_driver *drv,
-					     struct device *dev)
-{
-	guard(device)(dev);
-	return driver_match_device(drv, dev);
-}
-
 static inline void dev_sync_state(struct device *dev)
 {
 	if (dev->bus->sync_state)
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 82a7bc5b4dfb..eaf38a6f6091 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -263,7 +263,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	int err = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && driver_match_device_locked(drv, dev)) {
+	if (dev && driver_match_device(drv, dev)) {
 		err = device_driver_attach(drv, dev);
 		if (!err) {
 			/* success */
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0952c864b78b..b526e0e0f52d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1168,7 +1168,7 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
-	ret = driver_match_device_locked(drv, dev);
+	ret = driver_match_device(drv, dev);
 	if (ret == 0) {
 		/* no match */
 		return 0;

