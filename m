Return-Path: <stable+bounces-216731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA5qOqdDk2kP3AEAu9opvQ
	(envelope-from <stable+bounces-216731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:19:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60735146063
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 17:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2691B3020FE6
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47432A3C0;
	Mon, 16 Feb 2026 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iah8C6Kt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236735949;
	Mon, 16 Feb 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258762; cv=none; b=cngnbW14SxtQwshQzhkCHgnBjj+QndCgDz2pySVOs4pik0QNPpFjnoXUIGELF64lSTtBxZ8R+fQJgZFVFs0DGOW5LXDDTA4Na4RqzD7obWD5EMM73gOj23K2cATomUBW5xvwvIJVtBJgVf6XoOraAhBp4ThZlHKybW8XVXqcdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258762; c=relaxed/simple;
	bh=21snncf+vNWidoqsMALjB79rEBnk7EZnuZ0KRnokXTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEVXC8BsaDSiBVskv/w4/6OaqRzI7bg+rJoyyGQtkoOism33RwZC4Fz4dEp0mB4E6WjyGJt5i3Pc5+2XECviO0P/M3nVeVsLJITAAzJYAxH9fhq1EoURThjk3f6Rb6ClFmYh4D55OTLdAw1Wjq0WnI1aNZ5e0nBBdr6E8DQmqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iah8C6Kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362A5C116C6;
	Mon, 16 Feb 2026 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771258761;
	bh=21snncf+vNWidoqsMALjB79rEBnk7EZnuZ0KRnokXTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iah8C6Ktosi98+j0g6p2SoHmHXfcgqBffjAClibLCMUzsaasam3OHPSvj7FF3WLyo
	 7XRZWUi5XUd8ewS4wdSxRfJ6Lm9J2hei2TPo2xpcFzqejM5Zqz1b8Krptvv3do/v4g
	 equB4q+DmYmfc31QulB3f1kFnbgRCwkz+4b7J7fA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.126
Date: Mon, 16 Feb 2026 17:19:09 +0100
Message-ID: <2026021650-calculate-lucrative-5b1c@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026021650-sneezing-establish-a5bb@gregkh>
References: <2026021650-sneezing-establish-a5bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216731-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 60735146063
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 4a944e807690..54c385978fee 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 125
+SUBLEVEL = 126
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 35e14bebbfb2..0b491449b022 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -165,18 +165,9 @@ void device_set_deferred_probe_reason(const struct device *dev, struct va_format
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
 {
-	device_lock_assert(dev);
-
 	return drv->bus->match ? drv->bus->match(dev, drv) : 1;
 }
 
-static inline int driver_match_device_locked(struct device_driver *drv,
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
index 27f8442a3aa9..b97e13a52c33 100644
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
index 07f1332dd3a4..7e2fb159bb89 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1169,7 +1169,7 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
-	ret = driver_match_device_locked(drv, dev);
+	ret = driver_match_device(drv, dev);
 	if (ret == 0) {
 		/* no match */
 		return 0;

