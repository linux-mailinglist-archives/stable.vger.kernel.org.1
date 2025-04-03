Return-Path: <stable+bounces-127713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B1A7A8F8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ACA188F996
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07302512CD;
	Thu,  3 Apr 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="phDOw6DG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VjmTbNd4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD7171E49
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703213; cv=none; b=LxQxkMSeI2caKb8fRYiudDeRzchJKtn6ecYM+VkAAxD7Dlx+8BNYJ0hna/kS5NJ/2l814eh+Vb3UzuSQn1B+nsSvPXnC1ACYJqbbHXJkTRI9AJs7oIY05V1M0/FCNrFLR5kRPUXoszfHCP/BhI2vJJM5oMULO3yxqGMKC+MJZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703213; c=relaxed/simple;
	bh=vNL8oGYXYyi7evROq0JTr6p/hDyms6oWp32Ay/Kw/Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u07dUAcyZZ1WtJuVoLUnEDtiX8YH8T+aYl09itj1n5awvuHf3y1+8POR92I6DODMNL6kzwIYcOAiuuYEqhk5jR5Ci1Twh86EPe1dIcNjhFOfShAST8yAvAZMTRLn7B2BA5JJcautEhMIq7NCmvYL+VbW8jTNi6ckGKSLfpaMWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=phDOw6DG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VjmTbNd4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAA8C1F385;
	Thu,  3 Apr 2025 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743703207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dvon3orrIPskieZf5OquLJhBMyt41RbJ7xKkCGtlqN4=;
	b=phDOw6DGY6a8D33SyWEmMnjYuDemvuULXCPyI7ZuqqkMN+4NqzHO/BFIwU/FrlDn438S77
	NlR/pnXzSFRam6PtQCUWy2SbevQqnff0Lli+rLzHTGBG2Y0OslEEkjGfRPSlLUfygOIGss
	YypMc7gVnV+g5UnJKS3AGcYqSveie6c=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743703206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dvon3orrIPskieZf5OquLJhBMyt41RbJ7xKkCGtlqN4=;
	b=VjmTbNd4bxlJmCpcSrtoDZGiP2QD+T4X6EdyYwntkBebqJGOinXEqN2VbfElnQjADqSs5l
	x+x1jqWg27py463RUfqVHuMGq79kaXhoU9Vyxhl2G7Z0pDyBjtuX5tV8e66fRTs1g8d22F
	G6xaffaJtzNb7y1AIJ8Y1FdWcgoXabs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE5DB13A2C;
	Thu,  3 Apr 2025 18:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IHnSKKbM7metFwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 03 Apr 2025 18:00:06 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: storage: quirk for ADATA Portable HDD CH94
Date: Thu,  3 Apr 2025 19:59:45 +0200
Message-ID: <20250403180004.343133-1-oneukum@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Version 1.60 specifically needs this quirk.
Version 2.00 is known good.

Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 1f8c9b16a0fb..d460d71b4257 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -83,6 +83,13 @@ UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_LUNS),
 
+/* Reported-by: Oliver Neukum <oneukum@suse.com> */
+UNUSUAL_DEV(0x125f, 0xa94a, 0x0160, 0x0160,
+		"ADATA",
+		"Portable HDD CH94",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /* Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> */
 UNUSUAL_DEV(0x13fd, 0x3940, 0x0000, 0x9999,
 		"Initio Corporation",
-- 
2.49.0


