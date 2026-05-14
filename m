Return-Path: <stable+bounces-247140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHxbJ/aGBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:25:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33853F3FF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F300F3035884
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481F3AEF34;
	Thu, 14 May 2026 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="CVsKybsX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3C3D7D65
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747104; cv=none; b=tg+qklHnDB5nFSQea1xyJxDLCYEsYFSF2qvsuE0DGt6LRTIHaXvv7SGjDvjQ+3joygMo1J9le5UKulxf7Xsmw7vD3t+wZAolgwfTyA8BXfdK5m6jzWiOJz3352km9zOvsBFKOPd8bjMvUejrlOzhAXLyTIapua3CnHm51YKGDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747104; c=relaxed/simple;
	bh=8Z8K1cxzOFKrVJqTydIBAVWPHk0uegI4AOwudkIAUMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mt6yBwbyB0Y4uya1osDHrB6CwoFoYdpUhRT2WRIfOsEIcya0nygtWyEiddRK6YAj2eziqvq2XRolqpEglUO+pT/tYw1gEbGJDd49lLhYzvgOLA63f7OTsS2OuqeG4vtxpurA/4Unsbk0LgLR/9my6mbmyofzzYB9XQ0WoXnrFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=CVsKybsX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so5504236a12.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747102; x=1779351902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7d38f+IaIo+LqPs0VUxtKb87zLxGu6BC7Fyaado5mzo=;
        b=CVsKybsXWDXuCTZclc+ut8IMXNhmqIGPBFYrMQkaLFXdFfmujFt98fCinanHM64J8H
         53iFU/aBY0VpBu+TjsfeF/QtiAe2+CLoM9fdvsu/HKrO7vp2LOIpFbnAJCbc+DqB4asj
         tsWkdQpJZ7UYDiAaaZQA3OPxUDYWTXdZbmTqePGte5tfr6+srYAvPnlDWClkl8V2qbcN
         8DMHRldVeI9/e04AAEBGFmMt0M7Lgg25kJXnsCbhvy/zVxFIH4Ad4KAEaaCD2oWtmxPF
         1T6gIfm6HKDFci2DeiwsgdShtfrC9k4IdIcs1jE+7U3vLAV1TA/9pDwFft5fRLDlhfPZ
         615Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747102; x=1779351902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7d38f+IaIo+LqPs0VUxtKb87zLxGu6BC7Fyaado5mzo=;
        b=Z3mJV5hC4B5fB3m7BapFw9Pe5c8H18ySK2T60s1IEAcvWpgKfiky3MnepQ4nS04Xgx
         F+TyuV1XZ3sPNFk3dI+VYjqpv7AP9q/n3xQY8YkGGxxwA1i7rkGrxZS5fsncV935aDvG
         tAI9nBVw6KVGnsB0eFD95MnKVqBqbBs26wseK2wWR+caqK35whXTeJPWKz73H3O7WB5/
         y67wYxZXG2QVYp0tjg3HQXJO8EP/QUIkTgwVOoX1zBZD5WGWBaz3/m4SRPv33xF6ceZg
         Y/0HTis4GpXAoC+PzX8eIVc8n3RZPSPH/dlldtJ0VfXpBkajBTB6XrmrUlFr5fmq2UAI
         jTbw==
X-Forwarded-Encrypted: i=1; AFNElJ8wOc3k6QCmtZaRavS4xCKvLr/jlmCZkrkiANS7SkS+jH8SVXuv3sTP3/sPCn6L2roQvi916G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNaecz3Ul0jWy92QFVUJy5yPGN58mOy4do3RtcZ4E+U+rcp1n
	JBEMWiE3OzAciy7Y46enJxOEqu854AD5wN0xLxgwaP7RFxkITFGzVXloHvuBQ2veS+4=
X-Gm-Gg: Acq92OE3ZtHclnFJEbcYMIzyJiwLgX/FeWynAHRvKfdUWKzf4MPiQ0Rebo/nbHsUC+z
	lY2ofU+pQYS8GlFFWzA8pL+gNXmqfLtTxgc8e7t6JOqtLyXvV6Z9X5uiIc313fxMC1CpDoSXDEd
	dLunUQj4Inq0Wq3FRSTXQDdB9tB81GqOIXWTh/EY9TdHhihxV79gh7PZnr0U02vETz0zvQ8/25L
	jSAz0SHSa1FeUtuKF235H4PmbceElnBz0bkWSlvZ8HdJBUmMebH++PI5/lCiUHYGicEPS9fQbGs
	A17pheADHOVUMKQ2cV08E8/MQMywRgTO7fqUDFFljUnOikJsALM7rsEOAlQis96BJ/kPFf/fial
	+96BBOPnzu+XOeQ6rFfusF0qnf5UIJnzPt4wFzuki8BezQzHM4O7VIveHGkX/Q4eoyOeGRo/ZDa
	OP+P9hsfzjMXRgbbwzHBBbHio082ZHhBWqmwr+Myh2Q4xERb1wKeNHWyxIiGvwxcBGadF7i/CRc
	+7ASCt8EOs4vbPgfIupuOCQZaLFW8qLXFAmoaBu4wjLHImRJeN5hZk=
X-Received: by 2002:a05:6a20:7495:b0:38b:d9b5:5de2 with SMTP id adf61e73a8af0-3af83e4433bmr7439055637.50.1778747102141;
        Thu, 14 May 2026 01:25:02 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:01 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:31 +0530
Subject: [PATCH 02/14] fbdev: broadsheetfb: fix potential memory leak in
 broadsheetfb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-2-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 2D33853F3FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247140-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,redhat.com,suse.de,kernel.crashing.org,linux-foundation.org,linutronix.de,rainbow-software.org,gmail.com,linux-sh.org,wp.pl,ti.com,gentoo.org,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,iitm.ac.in:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The memory allocated for pagerefs in fb_deferred_io_init() is not freed
on the error path. Fix it by calling fb_deferred_io_cleanup().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/broadsheetfb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index c8ba098a8c42..582f1ee4c9b6 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1072,12 +1072,14 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &broadsheetfb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_vfree;
 
 	retval = fb_alloc_cmap(&info->cmap, 16, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_vfree;
+		goto err_fbdefio;
 	}
 
 	/* set cmap */
@@ -1121,6 +1123,8 @@ static int broadsheetfb_probe(struct platform_device *dev)
 	board->cleanup(par);
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+err_fbdefio:
+	fb_deferred_io_cleanup(info);
 err_vfree:
 	vfree(videomemory);
 err_fb_rel:

-- 
2.43.0


