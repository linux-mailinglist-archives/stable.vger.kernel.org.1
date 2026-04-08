Return-Path: <stable+bounces-234625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EqCCiak1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE343C1DBA
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C311631AC0AE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83E35C1B2;
	Wed,  8 Apr 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vruho8RZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547528C87C;
	Wed,  8 Apr 2026 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673343; cv=none; b=aI6olTo+X8rdpoWeW13l/+QiOL6L6XLczmOfgavh2fjBvOLMlETGe6vGiamKApKS91z7Mve6rJ61/utc3jFPA7nFsAqjmirHVYPh6UTY9Y/edKvJMjGB+dayPU0uwxOJLu7YixC1i2GjrSa4tkG1V48lXrc6wvzzCglrZURQC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673343; c=relaxed/simple;
	bh=qCEUtC0tUhR5++ELVCVAKlkrLo8F6wQzlTXRA2Oq78o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOmnBKWStXhK/wQG/4kHEcplSzGYqmF4oGiwGWDoe5FyEzjNzC9WAmPWDfHWgICUvVnpuNmGaPIobhloqLiUiPvbKrc195AMEdwfadTzDMcIHS1FIh1Cmssw+def9nu8feyIQmlZqin8PmYYcmOsdNPRUsxVJnKQ+/UlW9HgXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vruho8RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AEFC19425;
	Wed,  8 Apr 2026 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673343;
	bh=qCEUtC0tUhR5++ELVCVAKlkrLo8F6wQzlTXRA2Oq78o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vruho8RZGQsJRL2TmtxtGzpz8NuBOdNc5GeCChwJfKyYsHd8T6JdTdWSINiB52C3Q
	 vUc6tkZN+MUMBVRy7ncRWqgsfqsTfPM3CPYiFsk0nG2apnAuaGFKNlVGeKnFBqR5lx
	 gK5waGX2+OsNoxEe1VbxoFHgrDCUNTDinAIJUGNQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Penkler <dpenkler@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH 6.18 196/277] gpib: lpvo_usb: fix memory leak on disconnect
Date: Wed,  8 Apr 2026 20:03:01 +0200
Message-ID: <20260408175941.183352517@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234625-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAE343C1DBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 5cefb52c1af6f69ea719e42788f6ec6a087eb74c upstream.

The driver iterates over the registered USB interfaces during GPIB
attach and takes a reference to their USB devices until a match is
found. These references are never released which leads to a memory leak
when devices are disconnected.

Fix the leak by dropping the unnecessary references.

Fixes: fce79512a96a ("staging: gpib: Add LPVO DIY USB GPIB driver")
Cc: stable <stable@kernel.org> # 6.13
Cc: Dave Penkler <dpenkler@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260310105127.17538-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -405,7 +405,7 @@ static int usb_gpib_attach(struct gpib_b
 		for (j = 0 ; j < MAX_DEV ; j++) {
 			if ((assigned_usb_minors & 1 << j) == 0)
 				continue;
-			udev =	usb_get_dev(interface_to_usbdev(lpvo_usb_interfaces[j]));
+			udev = interface_to_usbdev(lpvo_usb_interfaces[j]);
 			device_path = kobject_get_path(&udev->dev.kobj, GFP_KERNEL);
 			match = gpib_match_device_path(&lpvo_usb_interfaces[j]->dev,
 						       config->device_path);
@@ -420,7 +420,7 @@ static int usb_gpib_attach(struct gpib_b
 		for (j = 0 ; j < MAX_DEV ; j++) {
 			if ((assigned_usb_minors & 1 << j) == 0)
 				continue;
-			udev =	usb_get_dev(interface_to_usbdev(lpvo_usb_interfaces[j]));
+			udev = interface_to_usbdev(lpvo_usb_interfaces[j]);
 			DIA_LOG(1, "dev. %d: bus %d -> %d  dev: %d -> %d\n", j,
 				udev->bus->busnum, config->pci_bus, udev->devnum, config->pci_slot);
 			if (config->pci_bus == udev->bus->busnum &&



