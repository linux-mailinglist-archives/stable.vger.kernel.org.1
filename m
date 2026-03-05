Return-Path: <stable+bounces-223191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJXwJqVfqWlc6QAAu9opvQ
	(envelope-from <stable+bounces-223191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:49:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B520FF5D
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07850300A7E7
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF3376BD6;
	Thu,  5 Mar 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWE7Nbp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A162222AC;
	Thu,  5 Mar 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707593; cv=none; b=bbTje9pShDKJswi/tm6c6TrTYdrDQo6ZFlcK2DF4vS25C9sUJqSHp1VMRj60gD7K/7y7se0u7tkFUBOFYtGxRhICcBBvyopytLp6oiuvJ+YyCRqNUvhfxI8VypiclcLooLzdHHuy+d9eUCmxiMcVRmgRXmodnIFrHvbDu9mJjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707593; c=relaxed/simple;
	bh=gLsf5lob+ysEtsu2tZgLv9jcJO0q1TEZU82wQZrOGik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dg9+wgt7PiMuDAyYkOyMHPDPuSCrqxKxv4nW/5o+kaQtTgjelG5ndskjk8ZSxWOcFY8H4BHQ0ClF4qbJpQ609yOw+wIN22L98IMEn/bFo/ENjsHFhbajum4bSug6TsJ4SFY+Wf/j/pMnjOTEXTMZ+SzYR7fi2dw8pgrbbBzQLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWE7Nbp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6BDC116C6;
	Thu,  5 Mar 2026 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707593;
	bh=gLsf5lob+ysEtsu2tZgLv9jcJO0q1TEZU82wQZrOGik=;
	h=From:To:Cc:Subject:Date:From;
	b=XWE7Nbp/QLGR2GLxgVbWpawv+nlf2HWUJNOmvMD6ZxmvWs5BH3oBjkV+t6szuuiAW
	 TaAoB0q2A4Wr5HTbXloXDs7lAmPidEUuJZ9C2JesPJa5su1nSzsZk0sxapgtnHExdT
	 1cCi286vAqBB+krEeHCBbD+G98mdcuLYKyHyPi3+EcA0gprUzZWLPMEXd6DZ9gtQXN
	 HZwoUdFhAC6va74unEE5TY3RfO19vHgHL6EXcetNtQ4qNelFhEeQTPsEA3QL/dy09z
	 SJMokZLjPAF1fFC8JFgAVGIpBZZleoj29NapFEVmrV3mTnxb1B762Dwa+gmMmc3xiW
	 1c+wUaCM2X8hA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6Dv-000000004CV-08sa;
	Thu, 05 Mar 2026 11:46:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] net: mctp: fix device leak on probe failure
Date: Thu,  5 Mar 2026 11:45:49 +0100
Message-ID: <20260305104549.16110-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 188B520FF5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223191-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,codeconstruct.com.au:email]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

This driver takes a reference to the USB device during probe but does
not to release it on probe failures.

Drop the redundant device reference to fix the leak, reduce cargo
culting, make it easier to spot drivers where an extra reference is
needed, and reduce the risk of further memory leaks.

Fixes: 0791c0327a6e ("net: mctp: Add MCTP USB transport driver")
Cc: stable@vger.kernel.org	# 6.15
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/mctp/mctp-usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
index ef860cfc629f..3b5dff144177 100644
--- a/drivers/net/mctp/mctp-usb.c
+++ b/drivers/net/mctp/mctp-usb.c
@@ -329,7 +329,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	dev = netdev_priv(netdev);
 	dev->netdev = netdev;
-	dev->usbdev = usb_get_dev(interface_to_usbdev(intf));
+	dev->usbdev = interface_to_usbdev(intf);
 	dev->intf = intf;
 	usb_set_intfdata(intf, dev);
 
@@ -365,7 +365,6 @@ static void mctp_usb_disconnect(struct usb_interface *intf)
 	mctp_unregister_netdev(dev->netdev);
 	usb_free_urb(dev->tx_urb);
 	usb_free_urb(dev->rx_urb);
-	usb_put_dev(dev->usbdev);
 	free_netdev(dev->netdev);
 }
 
-- 
2.52.0


