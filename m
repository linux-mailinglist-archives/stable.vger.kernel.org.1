Return-Path: <stable+bounces-227924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOwuJMsCwWlUPgQAu9opvQ
	(envelope-from <stable+bounces-227924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:07:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F12EEAF1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 743FB3006B5C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD5386445;
	Mon, 23 Mar 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqtnJmLf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D0838643D
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256841; cv=none; b=TbcNpBbED5vMb9JYHk8bXojJwVDdCHgo+mVXwW5+JWeFPEj4OnvDFeNstxZlHSqMJqy4tKuuEoUfY2rzSk9SEJo3VG/OiP0jvSjJD6GwaJ+yTxa5QLnLyiJFPt4lfMcWFQPH7UoMUu5qtpIprMz/xaZyWfUtVnomD4KHyVh7V+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256841; c=relaxed/simple;
	bh=sVpDRct7IzXchib2JLzrXgA7t2/4cBAgY1oQXX3flRA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mJEnulBhmpJU/TEgsjOfykJFdaAfsDrKF5fr4BQ23sLJDX2q/hbxlROCrMUYRfIM9c5m6ukF4zRbP3T9XDeo9PJhHmkjonkozeoiJx78N8OLfOJn76ang/kxaQH/mteSYCUH0j1u2cixj7Mff+EsTOtbbB0+rb98I3fsmfpWce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqtnJmLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB47C4CEF7;
	Mon, 23 Mar 2026 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774256840;
	bh=sVpDRct7IzXchib2JLzrXgA7t2/4cBAgY1oQXX3flRA=;
	h=Subject:To:Cc:From:Date:From;
	b=XqtnJmLfnY4sxGtfe80hXNX8NIeaqxnIJ6YlMxn1jvp+D7IKBAeyGcmDBMfVbjBRJ
	 CwX77ptycWuE35hu45o4qFXRYiSTNzQQlgU1t5eFVzCzFHeKxyCZvDleeFn+U2Kgbi
	 gVDF/aZqOx54D/l7u7fXhz1Ytl/HllRrkt3fbVUk=
Subject: FAILED: patch "[PATCH] i2c: cp2615: fix serial string NULL-deref at probe" failed to apply to 6.1-stable tree
To: johan@kernel.org,andi.shyti@kernel.org,bence98@sch.bme.hu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Mar 2026 10:06:48 +0100
Message-ID: <2026032348-endanger-humvee-fc57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227924-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,bme.hu:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 327F12EEAF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aa79f996eb41e95aed85a1bd7f56bcd6a3842008
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032348-endanger-humvee-fc57@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa79f996eb41e95aed85a1bd7f56bcd6a3842008 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 9 Mar 2026 08:50:16 +0100
Subject: [PATCH] i2c: cp2615: fix serial string NULL-deref at probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index e2d7cd2390fc..8212875700e1 100644
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


