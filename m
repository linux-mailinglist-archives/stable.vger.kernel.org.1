Return-Path: <stable+bounces-223862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNaGAU75r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A54249D43
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D465C30B0A2D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF03815F5;
	Tue, 10 Mar 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1dZ4uFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842303822B7;
	Tue, 10 Mar 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139922; cv=none; b=UOtLJpOY2cu3AtAHSk7UIXzHScgeyVMeF7K925LIriX2WLqKmdQCCpz+hhT8QVqTE3aUl91qdv6Z3CrBcdAm99ae4scnSKVMVvpC9s0o7LrDUVhplLWgOFCvz+hfgUlwaUtsHR6MAL+1BPA9FwW1Z7eRrLbtOV/zGzIDqyYp+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139922; c=relaxed/simple;
	bh=GrPnMKq8qTTLkSYj+FJaMFdtv5tT9Y8pQdQVL/qtdFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PR18NF7gMMtaSI0b6h5rYDcOuqTq8oSGYw6t33Jzjme+viIe3/mEtADRW4vMXqqot1YGR738nwwjuzZZ32qQwUasMX3iKgD9VukMPwqRAIdVVqG9OPupBlnZVqY/rVEK3s8rQqfIuA8Ia/pOaHhSNSLBFI0UUMLizWolF3k43r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1dZ4uFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E63C19423;
	Tue, 10 Mar 2026 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773139922;
	bh=GrPnMKq8qTTLkSYj+FJaMFdtv5tT9Y8pQdQVL/qtdFI=;
	h=From:To:Cc:Subject:Date:From;
	b=a1dZ4uFsaXmQApLh6YtjH9fDB1EYtW7zDkkcc1+My3UIHxVZo//APXtHZyRH6OsE5
	 qZUlE1YN3TQ7fx5R6ZsnxBfU3+aQ+SsGzTU9ipzx8dN1kpTAXFtPwr5j45/LoUb4mj
	 z61etJSbS3YgvuMR0eJQRGtq5V3JXJ+/rK0wB5YUSBnkuSafs9MikawB5OceULd0Gk
	 /apGCf+iTl/JmDRvFoww+iUcAr04ge4+igf3IWc/pamRKy/QaB66UXEVQusnRpnLSJ
	 IsgjajzxEOsnkWcq0YZFVkcsThTYeHR8SAwclfdSmMsoIEZLrirAO+DppNI+3Xl3JU
	 GWD2vSG5WI5Zg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vzugy-000000004Zd-0eWZ;
	Tue, 10 Mar 2026 11:52:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] gpib: lpvo_usb: fix memory leak on disconnect
Date: Tue, 10 Mar 2026 11:51:27 +0100
Message-ID: <20260310105127.17538-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86A54249D43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223862-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The driver iterates over the registered USB interfaces during GPIB
attach and takes a reference to their USB devices until a match is
found. These references are never released which leads to a memory leak
when devices are disconnected.

Fix the leak by dropping the unnecessary references.

Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Cc: stable@vger.kernel.org	# 6.13
Cc: Dave Penkler <dpenkler@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 389dde5a8481..e6ea9422d6f2 100644
--- a/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -402,7 +402,7 @@ static int usb_gpib_attach(struct gpib_board *board, const struct gpib_board_con
 		for (j = 0 ; j < MAX_DEV ; j++) {
 			if ((assigned_usb_minors & 1 << j) == 0)
 				continue;
-			udev =	usb_get_dev(interface_to_usbdev(lpvo_usb_interfaces[j]));
+			udev = interface_to_usbdev(lpvo_usb_interfaces[j]);
 			device_path = kobject_get_path(&udev->dev.kobj, GFP_KERNEL);
 			match = gpib_match_device_path(&lpvo_usb_interfaces[j]->dev,
 						       config->device_path);
@@ -417,7 +417,7 @@ static int usb_gpib_attach(struct gpib_board *board, const struct gpib_board_con
 		for (j = 0 ; j < MAX_DEV ; j++) {
 			if ((assigned_usb_minors & 1 << j) == 0)
 				continue;
-			udev =	usb_get_dev(interface_to_usbdev(lpvo_usb_interfaces[j]));
+			udev = interface_to_usbdev(lpvo_usb_interfaces[j]);
 			DIA_LOG(1, "dev. %d: bus %d -> %d  dev: %d -> %d\n", j,
 				udev->bus->busnum, config->pci_bus, udev->devnum, config->pci_slot);
 			if (config->pci_bus == udev->bus->busnum &&
-- 
2.52.0


