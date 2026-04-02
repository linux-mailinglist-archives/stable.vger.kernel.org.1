Return-Path: <stable+bounces-233046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CruNTaQzmkbogYAu9opvQ
	(envelope-from <stable+bounces-233046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:50:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7838B754
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB1A301485D
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980643ECBE7;
	Thu,  2 Apr 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F41NZasR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF23DFC98;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144989; cv=none; b=WBHD+kxJNYwkKp6L3OYULWmi3ndp3ajMAKwqvRIkCGbxaNNjUQRpTGTB8/oY+lF+BhzroIYycCEpv/PYOb8JcvniNyLWuUDKw54hJNqgsnrAJBiqqH7HGpYBFjHcKvTf9gNlNGEuOeIo5NZkj6o5PW4x1kFPUbRGuY8PTRw6ex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144989; c=relaxed/simple;
	bh=VL5LBw99FRqrEC5kFcGQ9UvBX6IvWRUeRbZCGJ/xtvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENVA8gCSZTDJ+R1i7JIEJB5C91crmcaIp/xt00w/VxabPHnZy5vxCgTpdoSCXkv1C7kPFV8zQ7Ih3smODSeCzhaxg97pmQOMHIEV5Wq0cSpNy7JsXgAuK3YxVqsOih3hXwAs/A5Ku9HM1Xrn3/edMqrf1gtvKRSbcEgUXgAAMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F41NZasR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1904C4AF0B;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144988;
	bh=VL5LBw99FRqrEC5kFcGQ9UvBX6IvWRUeRbZCGJ/xtvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F41NZasRETl/Z6T1sqazPHpz2jx14eVbzBEBwndFzIWT/YVIp9HgrQnjIbvk9LHzI
	 AMs1Qxm909CwowWYk5oc+wKbVsA7GtNuZkWIfD9/tuQhtMK773SoFQkQIj73IbFZxc
	 uPc9R9BxEpmP4bDV0KO6jx0ftccvupHpdMgO8Gl/LAJNXFAbPWglTLHcGzfo9ay0D0
	 BVDutsekGWO/HphfxneKks4mcZlR9bmrL7lFvtDk/c1TzjQQaW4GC/YkmJMs3F9KYU
	 3QDAF96LIMHvjxo1oRH4YfVn90vwpmko72etSMQ+qH1zvyDHLh74xX4yQp7HPMMnJq
	 j4IaxXa/vinfQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8KIk-0000000ALvO-24qN;
	Thu, 02 Apr 2026 17:49:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] Bluetooth: btusb: fix use-after-free on registration failure
Date: Thu,  2 Apr 2026 17:48:06 +0200
Message-ID: <20260402154810.2467291-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402154810.2467291-1-johan@kernel.org>
References: <20260402154810.2467291-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233046-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 54A7838B754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to release the sibling interfaces in case controller
registration fails to avoid use-after-free and double-free when they are
eventually disconnected.

This issue was reported by Sashiko while reviewing a fix for a wakeup
source leak in the btusb probe errors paths.

Link: https://sashiko.dev/#/patchset/20260402092704.2346710-1-johan%40kernel.org
Fixes: 9bfa35fe422c ("[Bluetooth] Add SCO support to btusb driver")
Fixes: 9d08f50401ac ("Bluetooth: btusb: Add support for Broadcom LM_DIAG interface")
Cc: stable@vger.kernel.org	# 2.6.27
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 21e85c212506..97de6e6e7dbc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4372,7 +4372,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-		goto out_free_dev;
+		goto err_release_siblings;
 
 	usb_set_intfdata(intf, data);
 
@@ -4381,6 +4381,15 @@ static int btusb_probe(struct usb_interface *intf,
 
 	return 0;
 
+err_release_siblings:
+	if (data->diag) {
+		usb_set_intfdata(data->diag, NULL);
+		usb_driver_release_interface(&btusb_driver, data->diag);
+	}
+	if (data->isoc) {
+		usb_set_intfdata(data->isoc, NULL);
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+	}
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.52.0


