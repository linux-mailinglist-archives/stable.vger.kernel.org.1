Return-Path: <stable+bounces-229548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O1rOwdwwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:53:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBC2F902B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1CD5310D446
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8F396D28;
	Mon, 23 Mar 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K103Rsgj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0F271A6D;
	Mon, 23 Mar 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282219; cv=none; b=TXlQatTCmJ+FE+7SMmDQrHk6caV21ekHreLKneSnQ2Y7YUiJJocBp6ZrgDhnd0EUH4poNETQ1QxvDcn7sG5tgB8eJnVxPouNiCOzCjLFnq6zgilebjF5lotNtArXPefRAa0MyfAXcOGbCGXmW1ZsXYxX6RurrpMj3mFmxGsGSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282219; c=relaxed/simple;
	bh=+po8PmzL0vU8W93CIk3fCM2Io1Q2n3R3C1/DIYVV7CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl3hZZDA8eogaBEW6teU5gf18RZdAjRILU4rF/7DjDK9/l65PRnL7cg7lSxtQwPxoxVa6U7VqStzCvpkiKpvMCiFqlaFfdqFzFTbGWr6VS6uT3exE0NbS+Gz1IOojpCZU6WOQo9xi4Z0mOKv7fZaPasFezuYCRhZMR/HeEWhTe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K103Rsgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4352C2BCB0;
	Mon, 23 Mar 2026 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282219;
	bh=+po8PmzL0vU8W93CIk3fCM2Io1Q2n3R3C1/DIYVV7CE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K103RsgjgdcVuEiOwyr6BEIPQdV+o8pFlJmDLcP9hcXf5nHUHigEN98y/JWOZq3UY
	 vdm4mQw9anOCbkiFhPWbA5geRUpLzoA/gPtsK6WibgKKrdHjXn7bujnhKN7+A/pScb
	 L1JX8AvNWnak0H+3A26WwFh+xVWODmUZuH+F+FtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petko Manolov <petkan@nucleusys.com>,
	stable <stable@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 074/481] net: usb: pegasus: validate USB endpoints
Date: Mon, 23 Mar 2026 14:40:56 +0100
Message-ID: <20260323134527.038265899@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229548-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6AEBC2F902B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 11de1d3ae5565ed22ef1f89d73d8f2d00322c699 upstream.

The pegasus driver should validate that the device it is probing has the
proper number and types of USB endpoints it is expecting before it binds
to it.  If a malicious device were to not have the same urbs the driver
will crash later on when it blindly accesses these endpoints.

Cc: Petko Manolov <petkan@nucleusys.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022347-legibly-attest-cc5c@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/pegasus.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -815,8 +815,19 @@ static void unlink_all_urbs(pegasus_t *p
 
 static int alloc_urbs(pegasus_t *pegasus)
 {
+	static const u8 bulk_ep_addr[] = {
+		1 | USB_DIR_IN,
+		2 | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		3 | USB_DIR_IN,
+		0};
 	int res = -ENOMEM;
 
+	if (!usb_check_bulk_endpoints(pegasus->intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(pegasus->intf, int_ep_addr))
+		return -ENODEV;
+
 	pegasus->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!pegasus->rx_urb) {
 		return res;
@@ -1171,6 +1182,7 @@ static int pegasus_probe(struct usb_inte
 
 	pegasus = netdev_priv(net);
 	pegasus->dev_index = dev_index;
+	pegasus->intf = intf;
 
 	res = alloc_urbs(pegasus);
 	if (res < 0) {
@@ -1182,7 +1194,6 @@ static int pegasus_probe(struct usb_inte
 
 	INIT_DELAYED_WORK(&pegasus->carrier_check, check_carrier);
 
-	pegasus->intf = intf;
 	pegasus->usb = dev;
 	pegasus->net = net;
 



