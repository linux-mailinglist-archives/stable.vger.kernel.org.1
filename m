Return-Path: <stable+bounces-215153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAAcKS7xiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3185F1108DD
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1F573008317
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A62125B2;
	Mon,  9 Feb 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m3vM4F+G";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m3vM4F+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B93783A1
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647849; cv=none; b=P5bgRsSgQr9+vY0h7j5P2m7LOJNhKbVwxx3+/kFknCAsoplZO61CRjej2yjx12RkV6uzKDupg4YNF3vboKUum+2lJ+gSwKNSFK6ye+sJkGdguJr8UpRyPSnLwvbzcB9l9z5H5e4v+P4LWvU4PcP1jpr2RORhe2jWJgGsjpGZzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647849; c=relaxed/simple;
	bh=ZAEmPvJnn9snUrB9t0ZnXH1KU8X2QF6kPTYIfug6CZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9X4NVOn9XLqi/BSVQZ9HkMOlFEI73QtaE6vAZNLfUA1HeKMhoZDoQGkUckyh1bjQ36+TrEQ+cmlOcsvQnaYtRQroaw/RD9Q8kTIXlDhJD4P4H8sZHVHTrjmIyVGQWXUcYKrpChpOBZCJmCwkiIzv/DumOVslnRLIb4Dia7x+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m3vM4F+G; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m3vM4F+G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E90983E72E;
	Mon,  9 Feb 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770647848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FMl4//Th1GbkAfgaWG7Y/vqxhalVuVlvmtLeoNgLc2o=;
	b=m3vM4F+GwR4Ec/s4aXYiIkxGl92TX3vLFW9ILjQprrr0ktErTjoYOA5hviAwv+6J7jdV+j
	GyCZoL98eEi8y//HRkmeTuFSwa/hr+Px47yVEebbxs2dOHxwmsGEeLGkoU8+QbS9wX1lX7
	IHaSTrqQlYPBbZx/EgxL9y7WxWZRezw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m3vM4F+G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770647848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FMl4//Th1GbkAfgaWG7Y/vqxhalVuVlvmtLeoNgLc2o=;
	b=m3vM4F+GwR4Ec/s4aXYiIkxGl92TX3vLFW9ILjQprrr0ktErTjoYOA5hviAwv+6J7jdV+j
	GyCZoL98eEi8y//HRkmeTuFSwa/hr+Px47yVEebbxs2dOHxwmsGEeLGkoU8+QbS9wX1lX7
	IHaSTrqQlYPBbZx/EgxL9y7WxWZRezw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC5E3EA63;
	Mon,  9 Feb 2026 14:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id haavLCfxiWnZMgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Feb 2026 14:37:27 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: yurex: fix race in probe
Date: Mon,  9 Feb 2026 15:37:20 +0100
Message-ID: <20260209143720.1507500-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3185F1108DD
X-Rspamd-Action: no action

The bbu member of the descriptor must be set to the value
standing for uninitialized values before the URB whose
completion handler sets bbu is submitted. Otherwise there is
a window during which probing can overwrite already retrieved
data.

CC: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/misc/yurex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 70dff0db5354..6d03e689850a 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -272,6 +272,7 @@ static int yurex_probe(struct usb_interface *interface, const struct usb_device_
 			 dev->int_buffer, YUREX_BUF_SIZE, yurex_interrupt,
 			 dev, 1);
 	dev->urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	dev->bbu = -1;
 	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
 		retval = -EIO;
 		dev_err(&interface->dev, "Could not submitting URB\n");
@@ -280,7 +281,6 @@ static int yurex_probe(struct usb_interface *interface, const struct usb_device_
 
 	/* save our data pointer in this interface device */
 	usb_set_intfdata(interface, dev);
-	dev->bbu = -1;
 
 	/* we can register the device now, as it is ready */
 	retval = usb_register_dev(interface, &yurex_class);
-- 
2.53.0


