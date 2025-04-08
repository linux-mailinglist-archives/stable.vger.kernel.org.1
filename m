Return-Path: <stable+bounces-131764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C51A80D29
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA0716DA4B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734071A314B;
	Tue,  8 Apr 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X6eQDlrB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X6eQDlrB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72A84D13
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120686; cv=none; b=MvvfTbEYHBBdxjIiim4LQTisx3KenwxPC60u0bU4FXUYxDuEbJux0djCHDW3DSLzTi5TwU44LIqGW0QD5ehFKwT0lclYXaCNz8IfDasgSHiVb6qd08vBYZMZ4vTg1YFfo9eC37hl7v9LqjdopRJUHjWi7f2aX71vR5+XiKVZe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120686; c=relaxed/simple;
	bh=vQhsW6jK/6RqUs6WgYO2dhkzEOREwjdfpXnjm5E2Anw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAKkJ0NcPyNCV16ubmVcSEXBFmNNqtu4UfMqhfUPdcPxJ7GxM6cnVwwNSEfHewSvBpWDBegEiuQCr3q7l5t+I7oxw/eoLuW7GSxDxHjP8JwgREOSX0TG/IL0jYwrVRo2H5R2dPCMuGEzNVBpI109sBPo/OxujjWB7OXsQaKTZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X6eQDlrB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X6eQDlrB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1E1B1F388;
	Tue,  8 Apr 2025 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744120682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I1O2nbNkoa0TDw1/USRUdvHU7qE7zLCK38OvZEPQYtM=;
	b=X6eQDlrBeRi3XYn457Mv5ZEYnLY94cITaXtTmSp8ZGKpD1CGoy3DiVeSA0gUk126W19/JJ
	KxVqaFgHiuavaE15nwZMapdSPD3FlhlTHrL2Dch0cWiyS9aT7lvR5o27EPQSphIWwGH1At
	/E+rpB5LDACICUXkfASY98RByyhoHC8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744120682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=I1O2nbNkoa0TDw1/USRUdvHU7qE7zLCK38OvZEPQYtM=;
	b=X6eQDlrBeRi3XYn457Mv5ZEYnLY94cITaXtTmSp8ZGKpD1CGoy3DiVeSA0gUk126W19/JJ
	KxVqaFgHiuavaE15nwZMapdSPD3FlhlTHrL2Dch0cWiyS9aT7lvR5o27EPQSphIWwGH1At
	/E+rpB5LDACICUXkfASY98RByyhoHC8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9676213A1E;
	Tue,  8 Apr 2025 13:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c5aZI2or9WeYPAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 08 Apr 2025 13:58:02 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: VLI disk crashes if LPM is used
Date: Tue,  8 Apr 2025 15:57:46 +0200
Message-ID: <20250408135800.792515-1-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This device needs the NO_LPM quirk.

CC: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 8efbacc5bc34..ad7b0ec59836 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -539,6 +539,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
 
+	/* VLI disk */
+	{ USB_DEVICE(0x2109, 0x0711), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Raydium Touchscreen */
 	{ USB_DEVICE(0x2386, 0x3114), .driver_info = USB_QUIRK_NO_LPM },
 
-- 
2.49.0


