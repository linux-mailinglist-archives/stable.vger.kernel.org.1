Return-Path: <stable+bounces-264184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zvSFDG5yMWpKjgUAu9opvQ
	(envelope-from <stable+bounces-264184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDA6918F0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:57:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CKpxh5v9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264184-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264184-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BBC130A7825
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15044CAE6;
	Tue, 16 Jun 2026 15:42:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8C44CF4E;
	Tue, 16 Jun 2026 15:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624573; cv=none; b=Je1E1FTqFXB3i7OFRnfr3dc88qI3iUl8TpxQ3j36SMD1MUdek+fp6nLpBdoAky2XET5A1vsJEe6XMzr9GujH7hGM+IzXVEB16sPnnMu2fYG9DaDTj3MEi1HmPVM5Jd/So8wlYHDHGu19jnn8tezIlQMcnj0bpLx44tT5v6UxL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624573; c=relaxed/simple;
	bh=K/iPwQavtybZJUHEGPhRQXS+8Gd+TVEYYXBTSkcEvyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm+9MpNAWLa/BFzhUspIvDmfsHKO6i3/wYqoWwNsayu+XhLKXODI9tP4gT4WBfjy07SLtKTMRDrtXWNjpFyFqeChh6TbiV0Zp9fb4/qt+q15EmgKw32R7L/8ro93vmuA9bk9TtcRlBsneqi3TlLwgOHIeq5rLUMQDkD5iOUJ+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKpxh5v9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84EB1F000E9;
	Tue, 16 Jun 2026 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624572;
	bh=t1jOzOyWk/KMNP7tjR3e2aUUIII4F/K65YpqZQwUTdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CKpxh5v97txttGaQwy/g8Gl7kizXuXStoplEyOxulFwGhOYFES5L2khZTymPmhyNB
	 Ic4OQ+evkJezGSvGhKC18V6Z76FZfkr4SDzAsBn9/WTkdExJxZYdYQnKrSht6pQEdP
	 +GrdRNTtGUWVuSqkRK5JaW3aN/WJrEW3rvZbY71E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 7.0 360/378] driver core: faux: fix root device registration
Date: Tue, 16 Jun 2026 20:29:51 +0530
Message-ID: <20260616145129.094215520@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264184-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,m:dakr@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AFDA6918F0

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 580a795105dae2ef1622df72a27a8fb0605e2f6b upstream.

A recent change made the faux bus root device be allocated dynamically
but failed to provide a release function to free the memory when the
last reference is dropped (on theoretical failure to register the device
or bus).

Fix this by using root_device_register() instead of open coding.

Also add the missing sanity check when registering faux devices to avoid
use-after-free if the bus failed to register (which would previously
have triggered a bunch of use-after-free warnings).

Fixes: 61b76d07d2b4 ("driver core: faux: stop using static struct device")
Cc: stable@vger.kernel.org	# 7.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260424153127.2647405-2-johan@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/faux.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -133,6 +133,9 @@ struct faux_device *faux_device_create_w
 	struct device *dev;
 	int ret;
 
+	if (!faux_bus_root)
+		return NULL;
+
 	faux_obj = kzalloc_obj(*faux_obj);
 	if (!faux_obj)
 		return NULL;
@@ -232,19 +235,12 @@ EXPORT_SYMBOL_GPL(faux_device_destroy);
 
 int __init faux_bus_init(void)
 {
+	struct device *root;
 	int ret;
 
-	faux_bus_root = kzalloc_obj(*faux_bus_root);
-	if (!faux_bus_root)
-		return -ENOMEM;
-
-	dev_set_name(faux_bus_root, "faux");
-
-	ret = device_register(faux_bus_root);
-	if (ret) {
-		put_device(faux_bus_root);
-		return ret;
-	}
+	root = root_device_register("faux");
+	if (IS_ERR(root))
+		return PTR_ERR(root);
 
 	ret = bus_register(&faux_bus_type);
 	if (ret)
@@ -254,12 +250,14 @@ int __init faux_bus_init(void)
 	if (ret)
 		goto error_driver;
 
+	faux_bus_root = root;
+
 	return ret;
 
 error_driver:
 	bus_unregister(&faux_bus_type);
 
 error_bus:
-	device_unregister(faux_bus_root);
+	root_device_unregister(root);
 	return ret;
 }



