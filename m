Return-Path: <stable+bounces-227971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GcDDac5wWm7RQQAu9opvQ
	(envelope-from <stable+bounces-227971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:01:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F72F2625
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5CF308A65B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425236EAB1;
	Mon, 23 Mar 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQXJ6URt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E63A9DAB
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270594; cv=none; b=ipZo7rx0YAkUNp/EQPUNkZBZIdeJlFoHaJIFa5VWMnAhuBw7ez7/A8I58p/7W8FNbLPhUZBxsdEtAxz1J2sluIgMfHJKdhjiyqQpuGNbQ36e/Y9aLMkwazyDVHnzG5Cig2ZHiCMDvFMFF4OMul3j8h/8OSW14N4uMu0bcebgzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270594; c=relaxed/simple;
	bh=5RFSHrSy0T0N8TKyFd5rGOjqnVR8zENTugr+DmETkVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uozJ/R0g5dSimSNMhViF5X87WQ4MPGQYsBlKH6jEMWk8EAJudexp5V7Yex+p8AEKl0mEhs2CZfIsAzeUxb/iY2Puhk8YSXvXl+HoQdk7E2uGxQQPLsmHbdLG2uzDRLb/Dh6FgC+DYncebqhu/K7aqveal9Xw/zNr2PULBXCmK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQXJ6URt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E33C2BC9E;
	Mon, 23 Mar 2026 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270593;
	bh=5RFSHrSy0T0N8TKyFd5rGOjqnVR8zENTugr+DmETkVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQXJ6URtNaqMex69bkgbpO+eT6eZvyCd1Yxw7tBiDLnBKrl0xa3o7ScfEP1OdFUq2
	 nye85bCOsg2sW3nwXjU3RktDu4Yr2fsDQL1UDqOrgFNEgpnE92kf9UShsbW3yecmSZ
	 vKBxecDxgMkZZSRN5U0XZfOC0VqTaqFsoveFDxrJpN4zEhvZoB3BaGWysGOH2wHEdV
	 oG8svjxQCU/g7X/bMRGyiym/EFRlMe+hTzKbNQ+mbRsdN7HHsPTILINHqA12PA7bU0
	 +iDuihgmy2hJ8tbRGyOe6RQyDcG4RHCQRKJ6owtCEEmh+eaF0TEyn5yMOd28w7dhCf
	 6CbT3fQ19D5+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] i2c: cp2615: fix serial string NULL-deref at probe
Date: Mon, 23 Mar 2026 08:56:30 -0400
Message-ID: <20260323125630.1651316-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323125630.1651316-1-sashal@kernel.org>
References: <2026032348-endanger-humvee-fc57@gregkh>
 <20260323125630.1651316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[bme.hu:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D67F72F2625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johan Hovold <johan@kernel.org>

[ Upstream commit aa79f996eb41e95aed85a1bd7f56bcd6a3842008 ]

The cp2615 driver uses the USB device serial string as the i2c adapter
name but does not make sure that the string exists.

Verify that the device has a serial number before accessing it to avoid
triggering a NULL-pointer dereference (e.g. with malicious devices).

Fixes: 4a7695429ead ("i2c: cp2615: add i2c driver for Silicon Labs' CP2615 Digital Audio Bridge")
Cc: stable@vger.kernel.org	# 5.13
Cc: Bence Csókás <bence98@sch.bme.hu>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Bence Csókás <bence98@sch.bme.hu>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260309075016.25612-1-johan@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cp2615.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 20f8f7c9a8cd4..8e17f32d38c06 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,6 +298,9 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
 	if (!adap)
 		return -ENOMEM;
 
+	if (!usbdev->serial)
+		return -EINVAL;
+
 	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
-- 
2.51.0


