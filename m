Return-Path: <stable+bounces-247141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIG0NRWHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:25:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D153F43C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C877030523C0
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CE3D9024;
	Thu, 14 May 2026 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="bpD81+ur"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A23D8138
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747112; cv=none; b=dfZwqTr0VOL0YFda5pygFJcjEzvch1vLVhZtpKJzO1RbOphaz1dE+rpq5mmDvuIXRSCC4jzQKAFDXZWdkWgOkp3U8vkQazhLsOWsCRm/o5A6tzRDQ6G1PZCR06RlMjdOS9dw5URG//Er/8/iQhAqzWgiIU1D7NDqyoK9Eq2Sr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747112; c=relaxed/simple;
	bh=dZgpmxfLNwwdiD2CNYqlBA39ykctJlwlXlveZmO+QuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfywQ/lCAORw08aocEjs4vDR0yYKpWdlLzP9NaQhjQUReezQDvHlKkiMi4qMnIH6mySiy6eSAuypqvew4DH9HLOsPn6RMAE1T8TlU5KI/b3KEQMPGphzQtIeO4y3OTxuj5+XDHT6jWLe5UEfAuLxy1CFCfTtBaArGKbAMlQQ8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bpD81+ur; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c822652f82aso5571720a12.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747110; x=1779351910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cETLUD+cFYpJj1ZB4GUnM/Wn7jURn1pWYkE3ZLuZekk=;
        b=bpD81+urT8tGzlWXOLkwEyRjzcJDmonJiyLuddpCUYmRUbh/Ahg3UmGKUho1sh0A+4
         eqB8g1aDp5xAZcKkgF9RBAvYDJoTyy8nDjBNE2WAIlOA2fiB0n0nupwUr3jlYdy/beHZ
         Ax6tms5oK+XorZvCST8na+ycm/LELSDAcqhrX7KJaxYmQF1exF76x6RVZKHaioA+JFg+
         2L8SsxpUjK2wmvOi9l+T0P49L3P6WEVnoszJU2cK07UXpPWIkFn7gatX70b0P1by4eOT
         N6BoQNUXbpzfRvIgivOaxgCPcsxc5j6KkHOYRIVPoYbXuUB/urMZtejpqOH+V4cYSj1K
         C40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747110; x=1779351910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cETLUD+cFYpJj1ZB4GUnM/Wn7jURn1pWYkE3ZLuZekk=;
        b=EshC4c8eKAAdxI3yJIzMDyDCeTn0oLRPZcSd5tySnx4oOfIu8Nu72wI6hhMOa+MMEq
         S0rOGI6j/mn+vCKvfH18B9FpuCVSHkkQqb4fGwobpRkM1ERMj0arGjIYsUpv8Yhf3TPs
         NWZa5Gf0RO2hh9z3SNUBKKYKnrX9wf2gwpaHucjW54jXDjdDRIaZ3nMhS21v376H2p+a
         U3g2+aAlXqrJZQg5+JlWN2TOmUAYvezwMTpwQdv+AZ+H1PcIPrHYukM5g2utr3fUX0wy
         RiLvtcvpqSJ23/jfoOC9XkoLVE90UmbTXy8Vc6FaSd93XmbAUlCrW8FLBQHWBXCBXspp
         Rtdw==
X-Forwarded-Encrypted: i=1; AFNElJ98zQrTWNsEigqvyTYvcX9/9l0W91dnGJgl+6OcuREDgifXR6JX4NmaKDSNpNbrdP/D7aCr6tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjKRUFVJQ/Yrtb0ACN3RHoXdRtbhnDRmCvIYJY5wvPPA+GNnh
	xI1Kk1iG2LDyvNwZ2tsKmuTrhkklSYorQ00igvfMi1brb8QIoPI1sumHwrwmAGC10cA=
X-Gm-Gg: Acq92OFSNAjNSTVE8NHEA2L+SANygcioPnF+IFAvL64kUL9hkWKcZOhuX/2pjv+5iA8
	wrukeSzCRqifPxvSyCMGUYg8yVKpC0xemhfiFiCGyMOqqz88ODYZe1RiKoRdniPIy1atHiqVm/8
	elhIS7U2TQKOftewZyFi6WZ1wkQUFkH+chAA5rPGrExf1Ba/tF0W+YyjLY2hPNK9aQwchP9ALGi
	2zzLwa2msC/c/pCOWzRisfATLh7mdhPTWcpbzD27BEosSiI8dwIMuopoTFWCpYbJYxFBzzKdz6l
	k8O7HEzDwRTJJmBOXzgF3STqZcwNLYkVCS++79Y2ebs9bKUcHi0Ug0nPGLE+wJ+eK6fWv2DI9F3
	QoZvdfqOn1htBywTh7apG2lZE/t3M2I5l6mUQ+Wcr1QhDnYTOsVAWTk+TxYjzHAQOJqvAkkosUJ
	sl8Z2wfAxrzbMveNXVBo6BnIh4DomUJ25lW/rWI437lLIvvSdtXM5DGZefe7dvBsIX/Fgm1bNRZ
	sPZkjmQIWzrfXy3Fd4bhO99BKiDFBJ5DyHMgbdc+DLM
X-Received: by 2002:a05:6a21:4ec4:20b0:3b1:8cf6:8f79 with SMTP id adf61e73a8af0-3b18cf6979cmr603100637.44.1778747109771;
        Thu, 14 May 2026 01:25:09 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:09 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:32 +0530
Subject: [PATCH 03/14] fbdev: metronomefb: fix potential memory leak in
 metronomefb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-3-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 564D153F43C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247141-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
 drivers/video/fbdev/metronomefb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 6f0942c6e5f1..83c614963a0a 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -645,12 +645,14 @@ static int metronomefb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &metronomefb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_free_irq;
 
 	retval = fb_alloc_cmap(&info->cmap, 8, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_free_irq;
+		goto err_fbdefio;
 	}
 
 	/* set cmap */
@@ -673,6 +675,8 @@ static int metronomefb_probe(struct platform_device *dev)
 
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+err_fbdefio:
+	fb_deferred_io_cleanup(info);
 err_free_irq:
 	board->cleanup(par);
 err_csum_table:

-- 
2.43.0


