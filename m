Return-Path: <stable+bounces-216071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCAWKRkVj2kXIQEAu9opvQ
	(envelope-from <stable+bounces-216071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:12:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785D135F6D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 810D2303181A
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0C3570BA;
	Fri, 13 Feb 2026 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OMojA1Zx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0534A3A7
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770984724; cv=none; b=K+ZaJzmyXC1e96wIZTxQR8WuECjYL487uZLdndQ23ShY3BB582XUSo8+YWpzL/XV63fMHgDeRrwbcxs08MHfabntGVLiVrYJ0u2o9mWYQXcpHkF97L8UlZ0tIVrvf81wtjTId+qQay4xnUP3Ur6SvGreI5nEY1dQw9nevGsUfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770984724; c=relaxed/simple;
	bh=w/gdCMn+1hML50Jzfd4cL5xaQ5gGU2iV9bZdWJQZQWo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lr5kZbNDPw+LvRAosw+n/VH1UCcnAKpZbpqHGfQOBoaNn81Qf+tZwniuA5BXU7FDpu2vhCgyLWq2L9O9U3r//HdqBmW47n719Bw1msigNqbzxIfOkAxrGkyKYRjrkypisr4BisA9spsAc3N7tCWwT574fevy4uV737GsY9bQZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OMojA1Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B2C116C6;
	Fri, 13 Feb 2026 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770984724;
	bh=w/gdCMn+1hML50Jzfd4cL5xaQ5gGU2iV9bZdWJQZQWo=;
	h=Subject:To:Cc:From:Date:From;
	b=OMojA1ZxApzSM4ae5s5LAJ/qbJUWN4TtJtzPOlEOenG9qD6kHpJreGnuXL6iUXXsb
	 sToITzefT9ZbP/U7UWSxuAmD1BhEEAWr+1HfQJopsvIUI+XtYL9ZyrCHv9XwIOFR+j
	 aMTJTBhBEaKipbN2TzlDFwNo8KvrcZmm+FAhxeUY=
Subject: FAILED: patch "[PATCH] bus: fsl-mc: fix use-after-free in driver_override_show()" failed to apply to 6.1-stable tree
To: hanguidong02@gmail.com,chleroy@kernel.org,ioana.ciornei@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Feb 2026 13:11:47 +0100
Message-ID: <2026021347-showing-tapered-feb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216071-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4785D135F6D
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 148891e95014b5dc5878acefa57f1940c281c431
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021347-showing-tapered-feb3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 148891e95014b5dc5878acefa57f1940c281c431 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 3 Dec 2025 01:44:38 +0800
Subject: [PATCH] bus: fsl-mc: fix use-after-free in driver_override_show()

The driver_override_show() function reads the driver_override string
without holding the device_lock. However, driver_override_store() uses
driver_set_override(), which modifies and frees the string while holding
the device_lock.

This can result in a concurrent use-after-free if the string is freed
by the store function while being read by the show function.

Fix this by holding the device_lock around the read operation.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index c08c04047ae2..08b99b0b342f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -231,8 +231,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 


