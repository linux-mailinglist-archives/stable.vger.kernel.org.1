Return-Path: <stable+bounces-247148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FUQNWqHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3400E53F4EB
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B060F301C142
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7563D8138;
	Thu, 14 May 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="oYtY3QWB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0663D905F
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747167; cv=none; b=nscsunMmEqIdZvGU46uQSwUUDHjHhH2xSqiAv0I9gM3KPUJ1+eTEdyE1Qwl2oJ8kio/LA2QW3RgIhYHl64B6IF+7TaIiKcwZ6076W8WrM1Dc+fWARnQTQIfGiDU16Cx3MwYmHJin5y2uDc+gs+ZqbVsgjCRznN7nAqgXYEcmJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747167; c=relaxed/simple;
	bh=aaNOXqVJslECMUlTkP9KNemoHAJsvHiIdYYefjAnxgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwPRiXa6w5WSYy9UOYZWzDFBkMDA5jroNXlt5FJoMeFTxvx5ws3Z6AbwcmGR9l0PVkx7xaICuLATHhZjFSNA5xGzTt0PbGzfVr1rb0ODv0w9iFOXVEyWvnKd8Ho4cG8+wItQQ5M6aDI95nXIypJSczk2GKZTbVQS3two4DkRDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=oYtY3QWB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8025aecc40so3837695a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747164; x=1779351964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r44B3WqzqqOS4+0yZVm7MlIZp2ZYEB2HNnv71bMuBw=;
        b=oYtY3QWBvWnNQfJ9iYtDy34uwIjcmPjJydL+pdKMozvPw8EXoaF0jhg0qxPlVx6Ht2
         9CgxPXKyzTXRfr0maeLaORztubY+XdQcOmw9vaW7grigWVWmUxTYebElnZxj+/7WiHGY
         moIgj/RLJwJMtexdStRWBCK3mmVkVroZqq9IBTklTZ+GpVodRn6zfosNmy40OQnF97pc
         r7gRdLlLAQXnsUl8ntiVPThYIcWFVtO0/YjJgn5pUo7LTqhiG6yQRs2AJFp0rRHZPQbq
         mzbs92fueIkPtwhF8ZeT9Yf0X0P5POzzkIXszBGmuLsds19ck/oAFKGw/XGq0Hwhnfwa
         tlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747164; x=1779351964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4r44B3WqzqqOS4+0yZVm7MlIZp2ZYEB2HNnv71bMuBw=;
        b=o8NUlBo+CXofvBljSB6IaeurpvYzpgv3nBbXIdBXxYMLU7cCofJCRDkjp/Ei8x/4Rr
         EufIbT5kM2D8G4KGAmkjV8nQsHOZksyourBEDFghD3KpBmwTWW47SnURMT+cLCZBfTiV
         V+VSJ3lDGeYOHiAbVXuPHPJC0zQW6lUue1qVTZG78OX468Cy+iE2lO8pfyNLLEqv2EFp
         DALcE1skxUrOOi2e3PGBfa5EG2n5QmuItSLQOIACz7zwaNa0KGLmrDXfqDI0Pa8n1zRE
         HngfAIARWc4uwos8mLPyEBf/J1nYrCJO8HVr9wDJCClK+WuwWLBEwURfbhRnuijM9NdO
         faWg==
X-Forwarded-Encrypted: i=1; AFNElJ/CgrQy+2ju3b7jzBjtcFRz6qTpxm0M183gqgWJD+cym1gi3NFIGBszmd45b4gJ/srGBtI4R/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGgjExRFxMjFS5x/a9S81ZaeKyDB4sSiPq5Nf+bx+LS3INhHB
	K0WDr8v9JMPPVi+Ayh/MK4mZogAPPfr96rV9fTXB8AgJlf2yA8+8R8A4Cb+qPPvFaMM=
X-Gm-Gg: Acq92OHA6ddYLwUvXmBvzdIbj9wnrfGpGvg7P6174QUpj6vyWK8UWKpj6RnvzEwqiqs
	VcOx4HVuaqHAIQ6NwVVVey3yvXiMc0vCIzHMaJRDoaKZWkZUQ20p+QK+IMns86baiCNM4Az1ruv
	rHU3JRL5WclDGT9CLk7YpfZILS5RSnE+QCw+ELa+SvBnCWed8XZX4MOEgAz/heCCwxwu4h7zcbq
	jnRfaQ5JqQi24mZ6s3sDyvM5bkiZgsVi1F/lLDH/ptnGbxi3kSc8XBg4i1kBqDloakSjPuwkZIz
	mygjhgJgJDmwRkPrZ1lGiQeuEN/IQghct2n6ScJQVeQcMiaanQICD0Q4Lxyg5WV+OSJPQbs7yGi
	TEp11lTqBKqIMAnoR/5BZH2gRA7e7QRYYan+PB5UlAeWHlEfii3jczB284IbNY88Ycmsxc8NmnK
	4+XcTfIq4Qp++s6bPMPcGneEsiDVToNiySoI2HouODuFbEZPb1mK3mUS3983oofAOtc/ii8bA5N
	z30FzCNoqMpmoVxvQmvaMX4Q16RejgZXUOKvMKXt8vr
X-Received: by 2002:a05:6a20:ba07:b0:39f:c93e:c7f7 with SMTP id adf61e73a8af0-3b0bacce1e9mr2039565637.0.1778747164402;
        Thu, 14 May 2026 01:26:04 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:03 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:39 +0530
Subject: [PATCH 10/14] fbdev: tridentfb: fix potential memory leak in
 trident_pci_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-10-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 3400E53F4EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247148-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

In trident_pci_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() is not freed in subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 6a5e3bd0c8bc ("tridentfb: Add DDC support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/tridentfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index a8fdbae83a80..9f055ba776c8 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -1706,6 +1706,7 @@ static int trident_pci_probe(struct pci_dev *dev,
 	return 0;
 
 out_unmap2:
+	fb_destroy_modelist(&info->modelist);
 	if (default_par->ddc_registered)
 		i2c_del_adapter(&default_par->ddc_adapter);
 	kfree(info->pixmap.addr);

-- 
2.43.0


