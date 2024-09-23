Return-Path: <stable+bounces-76906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EF597ECEB
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBF58B2194A
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B623197554;
	Mon, 23 Sep 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RtVYo/io";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DyVBgZIZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8C10F7;
	Mon, 23 Sep 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101017; cv=none; b=ECjju+xLSjyODwhbaEMkxtxM72PHj/D/iQiZjW+l/f6b941m+MGxFdHiJ1iyk1UF27jYF5UyTFRIOd4tBKk9HR92m3qzkfIpjRsa//QrQ31kVpD5THvOfSRGGuYjEfQswAtm9Y3Hg05n94J7zU6/FXLMliGcevGWuRn++EPcZhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101017; c=relaxed/simple;
	bh=ffsN+B8i9wwxmm54ykTW5O3U7+XiB+deDuykjj3u76o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqdQDezsdFqVUJx1iUXoXDmFzAK9g7Yw0FHV3JmkfVYrVS7wVHnO0pWfKdx6U1/VBTVdDfG03ZYpbfLx284sMxpVtPTKHEatH5sZEwTeoQ8yjlqJotDXjdFQyYaM9Qeaj3MvADNlbHqTnA3ToIO3tJtnlktH3Nqg9tBp8Ibkk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RtVYo/io; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DyVBgZIZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 614F821DB8;
	Mon, 23 Sep 2024 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727101012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vy3r3kjKM26aBsWsuVuahNpyztjcHkCjXvxlsDEnO2I=;
	b=RtVYo/ioFvlvZ8tt0CcZIzykm8WHpGKs4bAcgQ/r0dRrzi2gCST647LIQ5KvinlnpRu2MV
	43e7xt/VlXVyVP551eEPTiV6w8iwBP2DwOg4eAYiSDQ9SA7UqDOMO2r39yo7tCncYY3YKr
	Y2k+4kKVnBw3ePDlwBHkTvJQDsq7Oeg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727101011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vy3r3kjKM26aBsWsuVuahNpyztjcHkCjXvxlsDEnO2I=;
	b=DyVBgZIZRjiKaXNU7dBmlr0b8kn9VVFJsCf02jcVzzMLsRG5VeX34gf/bl8ewD42I2upYz
	IIo0jC7aEXtY+YiIx1zHWGTMz4B9J1SvANx5zr1v+rdXiG2lQhFubcXq7KABxHZj9h6HGZ
	jErfwDb27sTIscH+HMNUgXMlazkVNlM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FBC213A64;
	Mon, 23 Sep 2024 14:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aZlVDlN48WZOXwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 23 Sep 2024 14:16:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] usb: yurex: make waiting on yurex_write interruptible
Date: Mon, 23 Sep 2024 16:16:43 +0200
Message-ID: <20240923141649.148563-1-oneukum@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The IO yurex_write() needs to wait for in order to have a device
ready for writing again can take a long time time.
Consequently the sleep is done in an interruptible state.
Therefore others waiting for yurex_write() itself to finish should
use mutex_lock_interruptible.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 6bc235a2e24a5 ("USB: add driver for Meywa-Denki & Kayac YUREX")
---
 drivers/usb/misc/yurex.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index 4a9859e03f6b..0deffdc8205f 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -430,7 +430,7 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 			   size_t count, loff_t *ppos)
 {
 	struct usb_yurex *dev;
-	int i, set = 0, retval = 0;
+	int i, set = 0, retval;
 	char buffer[16 + 1];
 	char *data = buffer;
 	unsigned long long c, c2 = 0;
@@ -444,7 +444,10 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
 	if (count == 0)
 		goto error;
 
-	mutex_lock(&dev->io_mutex);
+	retval = mutex_lock_interruptible(&dev->io_mutex);
+	if (retval < 0)
+		return -EINTR;
+
 	if (dev->disconnected) {		/* already disconnected */
 		mutex_unlock(&dev->io_mutex);
 		retval = -ENODEV;
-- 
2.46.1


