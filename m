Return-Path: <stable+bounces-240625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFIAG8dF62m4KQAAu9opvQ
	(envelope-from <stable+bounces-240625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:28:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42B45D0AD
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4855301DCE8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8783630BF;
	Fri, 24 Apr 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8JbPdiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9D342523;
	Fri, 24 Apr 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026185; cv=none; b=DT2UOInOV5lM8/AZiyEPT8X5NuhkNUAQaGe24Y7qVCFsoHmnBTyCyafeGDTJ4bp2zIfxHao5jLWG5I5j/WDXJr7qNC1rHFKF9yCtCMfQUdk+cK2sdeeGOuWwTlBHsWLHUNVvowPt86ht6ln1pqoRP3Qelbl+ZqzCAdMb9Gt4tTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026185; c=relaxed/simple;
	bh=dC3ckZECbhAz6juu3DYHArE+BCjaT07k48OesiNagpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGGhYWQED7R9XhBiMYLtrMwc2LjwD323rWoTVOUJ0hnahJkreNhMIzHwpG0br6HNEmEXAc2ZmGiyFwGj+KnZjh4oSAvwrb+GjMMmixQm5AhXiSiHUS+gSI4RBArwVjSRbzEfhqYmIWz7fc0/o2Deij/gUH1zGMYo3ATknnkuhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8JbPdiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8310C19425;
	Fri, 24 Apr 2026 10:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777026184;
	bh=dC3ckZECbhAz6juu3DYHArE+BCjaT07k48OesiNagpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=j8JbPdiEYTlwVNYKlihkpDqT7ALrXz8NYbEGxVdIaZ//1VOlEzRWpaN2s5ZpNOVq8
	 9qpq9t33dUuFmLMJivXRIRxipdzbLhwJAi7c7wA7MNApJ9FNPk3owpVjrxCJtQGYbl
	 yis/pIJhr2x0Tdi5OyC5/pT4peYU2FwER1Hps96dcp4i/WLorriAFKL53k8fqCU13v
	 Kho+cGU2KDI7TlZbesqaOCJOs6YA6neL7TPMyyG2IjjoOnCU+JQR6ZiVBK7Wdt62pQ
	 b/YTIoXfN55pY7kzwo7Ew/GpnK5siQLHknIeL0PQReQF9Ea5yVOhYu84AH7OGqyzb/
	 CmkLHdfy+jByg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDgc-0000000AyRC-1UqB;
	Fri, 24 Apr 2026 12:23:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] driver core: faux: fix root device registration
Date: Fri, 24 Apr 2026 12:22:31 +0200
Message-ID: <20260424102231.2615557-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD42B45D0AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]

A recent change made the faux bus root device be allocated dynamically
but failed to provide a release function to free the memory when the
last reference is dropped (on theoretical failure to register the device
or bus).

Fix this by using root_device_register() instead of open coding.

Also add the missing sanity check when registering faux devices to avoid
a NULL-pointer dereference if the bus failed to register (which would
previously have triggered a bunch of use-after-free warnings).

Fixes: 61b76d07d2b4 ("driver core: faux: stop using static struct device")
Cc: stable@vger.kernel.org	# 7.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/faux.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index fb3e42f21362..402ed119dfdf 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -133,6 +133,9 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	struct device *dev;
 	int ret;
 
+	if (IS_ERR_OR_NULL(faux_bus_root))
+		return NULL;
+
 	faux_obj = kzalloc_obj(*faux_obj);
 	if (!faux_obj)
 		return NULL;
@@ -234,17 +237,9 @@ int __init faux_bus_init(void)
 {
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
+	faux_bus_root = root_device_register("faux");
+	if (IS_ERR(faux_bus_root))
+		return PTR_ERR(faux_bus_root);
 
 	ret = bus_register(&faux_bus_type);
 	if (ret)
@@ -260,6 +255,6 @@ int __init faux_bus_init(void)
 	bus_unregister(&faux_bus_type);
 
 error_bus:
-	device_unregister(faux_bus_root);
+	root_device_unregister(faux_bus_root);
 	return ret;
 }
-- 
2.53.0


