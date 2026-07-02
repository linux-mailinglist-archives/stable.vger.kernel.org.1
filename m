Return-Path: <stable+bounces-271405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QxPhJxybRmrTZwsAu9opvQ
	(envelope-from <stable+bounces-271405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D77B6FB09A
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hCcdCk2m;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271405-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271405-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42FF4304C96B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7B25B09B;
	Thu,  2 Jul 2026 16:57:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916822D7B9;
	Thu,  2 Jul 2026 16:57:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011458; cv=none; b=iDkW8urmmiF2QOK+FuCwYaqO2bUA7DqhPqPWO+mIxFzXmmzE8qMBvvbpGZOuh3P0rZXqbUXSrYZoKaBJ9ehftIonUM6ObwgoRLRCOdG9VLZTfMwBXiKd7Gmcib301iB+Q131diGGzhH1XF1iUy5o1aPfRL05qdkiANa2YW9/tYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011458; c=relaxed/simple;
	bh=tHqFAihbKH+PSOXfM7iF+fijPfkjNLwxDWisWdA2sJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTMVnWN+Y5NS9YeYrkqnDFIT/WpaTCkjoarUZq0XJkqMHPOQEHZaboQaSVxtbMJ4mkC3gFntIn79rcnEA2+kgbH10QCPPCKtcS4yalOZkko+EbAf6KKKOwxbHY9kxpiiTavMmfsjlPhUMQI5B4KgpfQiOfkfDpv1x4iGPrpCSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hCcdCk2m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA331F000E9;
	Thu,  2 Jul 2026 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011456;
	bh=IKg9tE4wgv3FE7x8eVzdW50Hj7FgXWDvvIllx2tv0ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hCcdCk2mfcewuDcjxHN2qYRin8Gnn4B7BOqcGmTzTc35A+EPZv0n175c9Co+8l7XZ
	 bkUQySVTYfzXns1Ps0dm2DG5EEAG4qHl9K6go7qvoLx0dMDLEe+eukp43rsMOf0iWv
	 aX7ce6DWeFoV+fHdDE5fZFvY519ZTXfTJBhAIgAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6.18 094/108] i2c: core: fix adapter registration race
Date: Thu,  2 Jul 2026 18:21:31 +0200
Message-ID: <20260702155114.058354297@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271405-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,m:wsa+renesas@sang-engineering.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D77B6FB09A

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ba14d7cf2fe7284610a29854bdff22b2537d3ce6 upstream.

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
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/i2c-core-base.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1570,6 +1570,10 @@ static int i2c_register_adapter(struct i
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1628,7 +1632,7 @@ static int __i2c_add_numbered_adapter(st
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1662,7 +1666,7 @@ int i2c_add_adapter(struct i2c_adapter *
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))



