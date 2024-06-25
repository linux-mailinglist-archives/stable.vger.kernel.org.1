Return-Path: <stable+bounces-55157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF49160F0
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5344FB2307C
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C131487C4;
	Tue, 25 Jun 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aQpBGUoM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2pH7pSEe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aQpBGUoM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2pH7pSEe"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA39148315
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303506; cv=none; b=TCrSc0tK4IBABniuTyq2bTfniUPoLUKhvomMI3XTH+My5vDR7PJDBrxKxEjGVsbqpVf2dY7au2skWOL7vIzj2joz8n6DHOjQs0M1LXFsAFMC+IzUBI/WHJn6SKE4WSih/TgzFOKRHuJiiYuXUqaCvIepOP7OUGXJn8DLmj1GE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303506; c=relaxed/simple;
	bh=AsdslvAs1ynv6he6FVu49iJDjJWMmRFiyieVdSJwzCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsrWfGXeYfV9ajj9v3uj9Xz75UXCr16S9/RBZBnhuKO1KTw6OGYC8Rj4/6JjRF9edGIWCA7q+rKuIsTi6d9ly0e49HX9OrOfcOhIY85a2DF1XOff/BIMP4rR/HqhW831aJ5OsZItfHcZ+KJn/6oVJfDC9H35nxDgTNBUi+H3gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aQpBGUoM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2pH7pSEe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aQpBGUoM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2pH7pSEe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C426B1F83D;
	Tue, 25 Jun 2024 08:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719303502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBpJq1qKJcbJToCBUWdB6XboAre4cTNuGCODZlLjUh8=;
	b=aQpBGUoM770fnYDiQrEDM0QLcN+IXIsjUXCy57GZJ905KBHru0elcOQP0Yh23NjXcnxrKV
	mt6DN+bxSG096KeFkIcXKwe7IVy7TETcLkZIhySO52tQCOqIlWglsrgxMMJ1eOwLNwoUZa
	4c2mfkc0OzrMvMaUfajlO1zZkLPUcE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719303502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBpJq1qKJcbJToCBUWdB6XboAre4cTNuGCODZlLjUh8=;
	b=2pH7pSEe3anxOLfKpi/SsaEfPWPWcmC0LC8XafmqOqPdFtXb0HZgJ/W0v9iFkMPItD9Z7u
	FEcqqtiu648Ch3CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aQpBGUoM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2pH7pSEe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719303502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBpJq1qKJcbJToCBUWdB6XboAre4cTNuGCODZlLjUh8=;
	b=aQpBGUoM770fnYDiQrEDM0QLcN+IXIsjUXCy57GZJ905KBHru0elcOQP0Yh23NjXcnxrKV
	mt6DN+bxSG096KeFkIcXKwe7IVy7TETcLkZIhySO52tQCOqIlWglsrgxMMJ1eOwLNwoUZa
	4c2mfkc0OzrMvMaUfajlO1zZkLPUcE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719303502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TBpJq1qKJcbJToCBUWdB6XboAre4cTNuGCODZlLjUh8=;
	b=2pH7pSEe3anxOLfKpi/SsaEfPWPWcmC0LC8XafmqOqPdFtXb0HZgJ/W0v9iFkMPItD9Z7u
	FEcqqtiu648Ch3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D9E313A9A;
	Tue, 25 Jun 2024 08:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dmZeHU59emZTMAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Jun 2024 08:18:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maraeo@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] firmware: sysfb: Fix reference count of sysfb parent device
Date: Tue, 25 Jun 2024 10:17:43 +0200
Message-ID: <20240625081818.15696-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,suse.de,gmx.de,intel.com,linaro.org,arndb.de,loongson.cn,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,suse.de:email,suse.de:dkim,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C426B1F83D
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Retrieving the system framebuffer's parent device in sysfb_init()
increments the parent device's reference count. Hence release the
reference before leaving the init function.

Adding the sysfb platform device acquires and additional reference
for the parent. This keeps the parent device around while the system
framebuffer is in use.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 9eac534db001 ("firmware/sysfb: Set firmware-framebuffer parent device")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>
Cc: <stable@vger.kernel.org> # v6.9+
---
 drivers/firmware/sysfb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 880ffcb50088..dd274563deeb 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -101,8 +101,10 @@ static __init struct device *sysfb_parent_dev(const struct screen_info *si)
 	if (IS_ERR(pdev)) {
 		return ERR_CAST(pdev);
 	} else if (pdev) {
-		if (!sysfb_pci_dev_is_enabled(pdev))
+		if (!sysfb_pci_dev_is_enabled(pdev)) {
+			pci_dev_put(pdev);
 			return ERR_PTR(-ENODEV);
+		}
 		return &pdev->dev;
 	}
 
@@ -137,7 +139,7 @@ static __init int sysfb_init(void)
 	if (compatible) {
 		pd = sysfb_create_simplefb(si, &mode, parent);
 		if (!IS_ERR(pd))
-			goto unlock_mutex;
+			goto put_device;
 	}
 
 	/* if the FB is incompatible, create a legacy framebuffer device */
@@ -155,7 +157,7 @@ static __init int sysfb_init(void)
 	pd = platform_device_alloc(name, 0);
 	if (!pd) {
 		ret = -ENOMEM;
-		goto unlock_mutex;
+		goto put_device;
 	}
 
 	pd->dev.parent = parent;
@@ -170,9 +172,12 @@ static __init int sysfb_init(void)
 	if (ret)
 		goto err;
 
-	goto unlock_mutex;
+
+	goto put_device;
 err:
 	platform_device_put(pd);
+put_device:
+	put_device(parent);
 unlock_mutex:
 	mutex_unlock(&disable_lock);
 	return ret;
-- 
2.45.2


