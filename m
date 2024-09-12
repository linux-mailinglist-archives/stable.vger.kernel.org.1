Return-Path: <stable+bounces-75997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC969769B4
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 14:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8AB2835E4
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620301A42B0;
	Thu, 12 Sep 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ud9eNduq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ud9eNduq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7F19F424;
	Thu, 12 Sep 2024 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145695; cv=none; b=Uh84LQFA19JvUiqb0WPbgDimjoTUh9s/q2p8MPHPxkvLbiZTWQm2OeACVS0lBzIqJu/zdtgHwUr+eUwpw5OKHnyRPsD+Fu+Uc22qxLH87fikO/8EkzeZVA4w333YklPvfDMIO5XaAcsA7lwGYcaz38EAKDVQJUx6O+9MuuMOM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145695; c=relaxed/simple;
	bh=PjqA8FNEU85BiU6yK0zbv7QybV0ac2zxBuwtvI1jlyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd9jLFJjIKJjXloksXkP3MNtUNySrR11e1xf94lxm8CPIjixVtzDApRLOJVMImKmMmDosG+PavP0NMelCOuENmelO4UfkkWJNijhQrEbiUTNEtrhJemyt40bd6dInT2kTOaFafYS+WGjHbS30RvL6/em0KHdal45LHDePS82WNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ud9eNduq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ud9eNduq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C5EA219F0;
	Thu, 12 Sep 2024 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726145691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u9CadEyapibM1Kb0SxB79yMCrX61GjluEySOnb2Phow=;
	b=ud9eNduqnkYE8cJpxOfRB6JzfmumRGlghYQb07HG85KbT7jIOXS+WATObDeifgKcDM/gvZ
	vzlighG9uMPgzSFz6ow+kZoWB/YnYQChawC31rLUL22/QlKskJtocW645/FjcyJgFBguYz
	0YJtF8pwOjXR8m9R3/2BZ47337K2CMs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726145691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u9CadEyapibM1Kb0SxB79yMCrX61GjluEySOnb2Phow=;
	b=ud9eNduqnkYE8cJpxOfRB6JzfmumRGlghYQb07HG85KbT7jIOXS+WATObDeifgKcDM/gvZ
	vzlighG9uMPgzSFz6ow+kZoWB/YnYQChawC31rLUL22/QlKskJtocW645/FjcyJgFBguYz
	0YJtF8pwOjXR8m9R3/2BZ47337K2CMs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D8CF13AD8;
	Thu, 12 Sep 2024 12:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W8vrCZvk4madZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 12 Sep 2024 12:54:51 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: misc: cypress_cy7c63: check for short transfer
Date: Thu, 12 Sep 2024 14:54:43 +0200
Message-ID: <20240912125449.1030536-1-oneukum@suse.com>
X-Mailer: git-send-email 2.45.2
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

As we process the second byte of a control transfer, transfers
of less than 2 bytes must be discarded.

This bug is as old as the driver.

SIgned-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@vger.kernel.org
---
 drivers/usb/misc/cypress_cy7c63.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/misc/cypress_cy7c63.c b/drivers/usb/misc/cypress_cy7c63.c
index cecd7693b741..75f5a740cba3 100644
--- a/drivers/usb/misc/cypress_cy7c63.c
+++ b/drivers/usb/misc/cypress_cy7c63.c
@@ -88,6 +88,9 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 				 address, data, iobuf, CYPRESS_MAX_REQSIZE,
 				 USB_CTRL_GET_TIMEOUT);
+	/* we must not process garbage */
+	if (retval < 2)
+		goto err_buf;
 
 	/* store returned data (more READs to be added) */
 	switch (request) {
@@ -107,6 +110,7 @@ static int vendor_command(struct cypress *dev, unsigned char request,
 			break;
 	}
 
+err_buf:
 	kfree(iobuf);
 error:
 	return retval;
-- 
2.45.2


