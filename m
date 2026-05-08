Return-Path: <stable+bounces-244713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEu6CXOn/Wl0ggAAu9opvQ
	(envelope-from <stable+bounces-244713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:05:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D374F4053
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1B83051C95
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9F388E69;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T22GXDCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEA3815E1;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=l/hs9sphFngc372JEkOBr2L1wPONldH1iMa0WazDY3g4v0Fam6KP19CxkVEXnmY7Y1XIO8oA8UzD3VTThr2R6r15m1MLiJXq6k1eKVE1a38EnfDQCg6wnd7JWsp+BhB7I0ZxcBHbGvBl8r8Nwc/y12wa5AcxpD5SDmy0VnWeINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=sI4KlbwGOk77SXPZS0f98Lx3I2yyUnIH5LrfDk6EqOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icVWt3jkaETy1Nc1D/tghuI44NBR+zKHkS4yiWYAhAzENCYdux0SAmEIIHC5lNOpCluhneA95EIsibPj38ClYqdwRpS9tqO/alHopUEJpqCWHFBoJ5B3At43BiSHZD5/xYHHnHQu8Imegu/0xH3XWGHtMbt6IB3GssxDZVyPo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T22GXDCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33685C2BCFB;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=sI4KlbwGOk77SXPZS0f98Lx3I2yyUnIH5LrfDk6EqOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T22GXDCAQ8knidISGcDa49K8IN2g99tT6fYnUlS4NOZs3/CN8bbPlrZnO5vILs2PP
	 7G+gdkNYMafyCsnIGDPTOF/ZWxBb56H+G0MvAOT9ZMLREMrcdg865AyYgoMnkFn2F+
	 V3iml5+d0kzNcqs5RyLcaHjLl31p6w0edRUdfLz5305AvvyL7bofQUAcgZSaPsgXMU
	 mPJ1o7y9xrJ35WqmDlsXDjdmp3CPBFHksVImXktihuv4X2T8nPmhekeWu57s3QGXaQ
	 M46XuQlDwX0f+PxX7viasLzkV56eHEp8NKiBPn178QTYDPPMEDGPdCrfjzezrFXmt0
	 v4EOvOvPluEWQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7K-00000001ahA-03my;
	Fri, 08 May 2026 11:03:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 6/9] i2c: core: fix adapter registration race
Date: Fri,  8 May 2026 11:03:08 +0200
Message-ID: <20260508090311.379333-7-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508090311.379333-1-johan@kernel.org>
References: <20260508090311.379333-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84D374F4053
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244713-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Adapters can be looked up based on their id using i2c_get_adapter()
which takes a reference to the embedded struct device.

Make sure that the adapter (including its struct device) has been
initialised before adding it to the IDR to avoid accessing uninitialised
data which could, for example, lead to NULL-pointer dereferences or
use-after-free.

Note that the i2c-dev chardev, which is registered from a bus notifier,
currently uses i2c_get_adapter() so the adapter needs to be added to the
IDR before registration.

Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
Cc: stable@vger.kernel.org	# 2.6.22
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 20d48cb84a6c..4863d660faf6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1577,6 +1577,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1635,7 +1639,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1669,7 +1673,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
-- 
2.53.0


