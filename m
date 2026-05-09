Return-Path: <stable+bounces-244892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ1qG0Sl/mnPuQAAu9opvQ
	(envelope-from <stable+bounces-244892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:08:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3F4FDD29
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F22D3016915
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99E28C037;
	Sat,  9 May 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxbpui28"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1537B018
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778296113; cv=none; b=Z1+X9Myq40ivJ83Z2xvi+VLpeaMQV63TWR2jta96Zv09vwWefaNBsrRvypI0fOnebHLeqaQMIEQR9STR3hvq/+zRC3ez5XaVswGAerHiiFH8VXCcYINhzcF7gmmMx1azA+L0O8Cws9CAfq67GYCe59HzaCNcoCmd5Xo9ni7ADp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778296113; c=relaxed/simple;
	bh=GGEsXBE86l7xHgNFaIZg+xgHc8srKdu4nTXzSJ2Dbe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsqKxT3FZDf/6vKXxzlHYE8reeJlRW0ZVyfMumqqXLginif3Wxdo+x42aaGEgKbvNBNBE01Z1I7r3cj7FoBKV9zcjCMUhruARbosw5DGmvOTxyLDU5EX12zCEx1pvpU+kA+ZWAwGE2LWDHPKCxSJRgvOYP60lHWCQGEpCwgj3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxbpui28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1417C2BCB8;
	Sat,  9 May 2026 03:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778296113;
	bh=GGEsXBE86l7xHgNFaIZg+xgHc8srKdu4nTXzSJ2Dbe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxbpui28gwJ9NgpAA5IraVMd2vJk005W8L9V+hNhh/t4VbYjLR22zXpletIWn44sE
	 wY7HCRlTuUHkXCjcsddk3doH4e6Jqm9t00shKeg3jaMzhUh/CWfMzJSDAR1W2YZlMM
	 MOi2BpQNMfZdguxClWt7tBAYgcfoqI62OX6+2+WAfFOp50ycLrkhk27MFUOhVF0YSM
	 di/aa3PU4fMbN2+E0i0z+36G6gO1Fpu5tnjT07TCkqkIiu3tcKlo/jBuTdf/S65PvL
	 l+TbZSHsOATe9hpv9KDiGgIe8HBmqPMi9BiTdpu6cvyLJcCC+tPqHikXIy1XkmdeZP
	 gi8hEIaxqBmIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] can: ucan: fix devres lifetime
Date: Fri,  8 May 2026 23:08:29 -0400
Message-ID: <20260509030829.3038691-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509030829.3038691-1-sashal@kernel.org>
References: <2026050411-squeegee-passion-d179@gregkh>
 <20260509030829.3038691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8E3F4FDD29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244892-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit fed4626501c871890da287bec62a96e52da1af89 ]

USB drivers bind to USB interfaces and any device managed resources
should have their lifetime tied to the interface rather than parent USB
device. This avoids issues like memory leaks when drivers are unbound
without their devices being physically disconnected (e.g. on probe
deferral or configuration changes).

Fix the control message buffer lifetime so that it is released on driver
unbind.

Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Cc: stable@vger.kernel.org	# 4.19
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260327104520.1310158-1-johan@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 58069c96cab20..64dcbeef7a7c2 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1394,7 +1394,7 @@ static int ucan_probe(struct usb_interface *intf,
 	 */
 
 	/* Prepare Memory for control transfers */
-	ctl_msg_buffer = devm_kzalloc(&udev->dev,
+	ctl_msg_buffer = devm_kzalloc(&intf->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
 	if (!ctl_msg_buffer) {
-- 
2.53.0


