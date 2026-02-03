Return-Path: <stable+bounces-213240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d8yFJlT+gWmYNgMAu9opvQ
	(envelope-from <stable+bounces-213240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:55:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C7DA37A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8939B303657C
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAD3A1A34;
	Tue,  3 Feb 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R+lQBVng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P4ZyWV2o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R+lQBVng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P4ZyWV2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE93A1A21
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126930; cv=none; b=jxzYoLqpZg6Z6dHufVBgsdnvaMOr29jGdO7lw1QdgEXBE4yOUQqgJBbFu0IATu+F/HiXfT9EI0TyvRMhCmbbBBQvwlOcCLMX6u7kExOrwDiNMWQGG3OmHMvBAVdvxqeUxEQk9N1b+IuNv0duP9TBzLPB2wN5oCZ4VjzOKoQC9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126930; c=relaxed/simple;
	bh=xm2VKeAsYk6He+S6K11q2Gci+qyi+ItBLbop1iKU/I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+StLb0Uo7+Knc0y/3YFlzY7F/EGObXQh8VYUfR4stEy+I5TwBf68FnX/fQ4WxA/DinZC6TZeSrSzUPWvhGLHbYpj5KjyEZNk1JG/yx/UDt7wrAuT3kgegAsqFaa9BKzU025+r/JyYqQmDE75wLBz8dkmCHE58bj7AKLt1DcOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R+lQBVng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P4ZyWV2o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R+lQBVng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P4ZyWV2o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A4593E6D4;
	Tue,  3 Feb 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770126927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTSUboSXMQ96dLOPRSbXCAHbAbBhP7M3WA0bd1W/HFM=;
	b=R+lQBVng4L3h/jT5jD7pKfvJHFp7RslZRRDyBoYuLVX6qdMzboBwgWH/T+kV72dITKvllV
	79aLeMYZirR1q/3vyW8Py51f5IpojNb7VGKnqwKFSYDtvPoTz9Eb8dV2sbAju2LOwPV/Zz
	95f+2TjPI74+Bvv75OjMumVeKK4EOjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770126927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTSUboSXMQ96dLOPRSbXCAHbAbBhP7M3WA0bd1W/HFM=;
	b=P4ZyWV2oKEQ3apq+Z5K/sppTGaRXdm2jEG+e/5LvU4uqw6IghSDJeLgkZEgVirmxDNTFse
	zTWxAq5kUXY1FGBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R+lQBVng;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P4ZyWV2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770126927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTSUboSXMQ96dLOPRSbXCAHbAbBhP7M3WA0bd1W/HFM=;
	b=R+lQBVng4L3h/jT5jD7pKfvJHFp7RslZRRDyBoYuLVX6qdMzboBwgWH/T+kV72dITKvllV
	79aLeMYZirR1q/3vyW8Py51f5IpojNb7VGKnqwKFSYDtvPoTz9Eb8dV2sbAju2LOwPV/Zz
	95f+2TjPI74+Bvv75OjMumVeKK4EOjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770126927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTSUboSXMQ96dLOPRSbXCAHbAbBhP7M3WA0bd1W/HFM=;
	b=P4ZyWV2oKEQ3apq+Z5K/sppTGaRXdm2jEG+e/5LvU4uqw6IghSDJeLgkZEgVirmxDNTFse
	zTWxAq5kUXY1FGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9715F3EA63;
	Tue,  3 Feb 2026 13:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mHJyI07+gWlGDwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 03 Feb 2026 13:55:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: tzungbi@kernel.org,
	briannorris@chromium.org,
	jwerner@chromium.org,
	javierm@redhat.com,
	samuel@sholland.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: chrome-platform@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hansg@kernel.org>,
	linux-fbdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 01/12] firmware: google: framebuffer: Do not unregister platform device
Date: Tue,  3 Feb 2026 14:52:20 +0100
Message-ID: <20260203135519.417931-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203135519.417931-1-tzimmermann@suse.de>
References: <20260203135519.417931-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-213240-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,chromium.org,redhat.com,sholland.org,linux.intel.com,gmail.com,ffwll.ch];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 271C7DA37A
X-Rspamd-Action: no action

The native driver takes over the framebuffer aperture by removing the
system- framebuffer platform device. Afterwards the pointer in drvdata
is dangling. Remove the entire logic around drvdata and let the kernel's
aperture helpers handle this. The platform device depends on the native
hardware device instead of the coreboot device anyway.

When commit 851b4c14532d ("firmware: coreboot: Add coreboot framebuffer
driver") added the coreboot framebuffer code, the kernel did not support
device-based aperture management. Instead native driviers only removed
the conflicting fbdev device. At that point, unregistering the framebuffer
device most likely worked correctly. It was definitely broken after
commit d9702b2a2171 ("fbdev/simplefb: Do not use struct
fb_info.apertures"). So take this commit for the Fixes tag. Earlier
releases might work depending on the native hardware driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: d9702b2a2171 ("fbdev/simplefb: Do not use struct fb_info.apertures")
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Acked-by: Julius Werner <jwerner@chromium.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Hans de Goede <hansg@kernel.org>
Cc: linux-fbdev@vger.kernel.org
Cc: <stable@vger.kernel.org> # v6.3+
---
 drivers/firmware/google/framebuffer-coreboot.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/google/framebuffer-coreboot.c
index c68c9f56370f..4e9177105992 100644
--- a/drivers/firmware/google/framebuffer-coreboot.c
+++ b/drivers/firmware/google/framebuffer-coreboot.c
@@ -81,19 +81,10 @@ static int framebuffer_probe(struct coreboot_device *dev)
 						 sizeof(pdata));
 	if (IS_ERR(pdev))
 		pr_warn("coreboot: could not register framebuffer\n");
-	else
-		dev_set_drvdata(&dev->dev, pdev);
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
-static void framebuffer_remove(struct coreboot_device *dev)
-{
-	struct platform_device *pdev = dev_get_drvdata(&dev->dev);
-
-	platform_device_unregister(pdev);
-}
-
 static const struct coreboot_device_id framebuffer_ids[] = {
 	{ .tag = CB_TAG_FRAMEBUFFER },
 	{ /* sentinel */ }
@@ -102,7 +93,6 @@ MODULE_DEVICE_TABLE(coreboot, framebuffer_ids);
 
 static struct coreboot_driver framebuffer_driver = {
 	.probe = framebuffer_probe,
-	.remove = framebuffer_remove,
 	.drv = {
 		.name = "framebuffer",
 	},
-- 
2.52.0


