Return-Path: <stable+bounces-247144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO2rOkuHBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:26:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DB53F4C3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66A20303D568
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0F3D904D;
	Thu, 14 May 2026 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Urk6FJW6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D793D7D8C
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747134; cv=none; b=hgBiGLSj+tL8BsMH2GDxeZU+td6qmkDT+nB5Kh1KV7aV4JUtp5YR379NaTa3UBvB6hSglD53x9ASulRW+i/ufrTazjbMOGartg+Ndr1d5YaW/93sbElg8N236DGb96/0npChAFyW4lwsORdpgRWIHjo0LeyhN9w9FhwFk2f+F84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747134; c=relaxed/simple;
	bh=a4HnHFU8o2kxX+J6Wttn0saLGTcslMCpY1ZCbGRD12g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fuMnKgVsPGglajCZoOL3/G9w1nMStkv/2ZgkT04uJIC4K0FT5Bg99CBSmlMxDT3eHEMle6DP35mKEHpGeRb6ejTJz5TX3RJqqwcvArt8Kfa2R8Sz1+QcfVipvgzbaSA2a6FiS9nbNtPCKSX3GcYZ3IPWek3OdUYaODcULPypnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Urk6FJW6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c795f441ff7so5654093a12.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747133; x=1779351933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4vRiLxRbLX8JHWNngfg2YrhJ/NxLEtrCOUYTYRBYTo=;
        b=Urk6FJW6aH5V9Dty9NJ+vau80V/ApfYI4bJMFOt34c4ldm3wPf+ugPoO+d4NBdjb9o
         JjeTXEkHFinmg4/m61jsPabF209ldP1+kLd9vYfLOR3rHbXqIwkbhFptINmmWGnzx1w6
         VkfZDMwMfpzTXA6Jw1z2ebfFkFgOO4OTEky8/G9CYQjXQgtqo6dC7H6/dbFU56ZKLx+N
         XG5SJ9VYpQ2QwT30ABD80dL3BwLiy64XYiqrJGJOwToBvjfNqiHhwu4WkZfBLWmNCdfG
         0iJj4vF+5yuNYlv5iskFB6FouiR+GaDC9CQl4VbZFRgIHrkdGSQ8xEUKhLVijfTfyLNj
         paMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747133; x=1779351933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V4vRiLxRbLX8JHWNngfg2YrhJ/NxLEtrCOUYTYRBYTo=;
        b=YzZkrsUFrhS1JhTRjZA5Ro1bK/4SQNRoIPZTQhIQOAdOfx0oY74+0cowX8HQM320Ba
         sm9CaRUQPl5ja8FUZKwwxIqS1ot6T8tzKXuvVCb1/r1x3QaBnW+hnVBW9rYUUjqh5LMF
         bwwbq+9DZvAlqfCqhc8RgDkfZ91bSVCPov4iIMwqQX6bCWPkwMTElAusrb1COzu2/bAD
         k3eSaXNjFgV4BuRZKQnNz4bQx53bxcs3yfNwezM7VL7tJ4PH0lkxunQgGPwzgqJeK44u
         qmg1VF6Pnz5WCqugXN2XlZZ1g8ON7eMaoR0EsR6Llvr3geqmfS4BL2bulZoBlxE3oV6E
         /uIg==
X-Forwarded-Encrypted: i=1; AFNElJ8AyuQBLFuWV6jK4DxydyM74j0sm5QD+UQV9q2i0dgKsBYYkKnerhKOgSdMXImFBLujiddEcr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmFJu6rm3oixcirZQAjZfRCg5iCP4MPMQpB3i4K9UJjStA440
	DdNSvzXGvDuoqhC3iXbRWnw7nlj8dkJIQCS6oPEm+jqTCuCz1t9YiAamiPgXU4K6Izw=
X-Gm-Gg: Acq92OGSF4U/5+2XhImojTXvEO1KAh4XA3X/krKKqODRgyNjX4NmLVy1nvVPs52/T0Q
	63TuAXbecGxLnyTW+/Hk8wugehGgf/hG3ZJZcylukMu+L4Y0EA7eWXUnvPgoyl0v4NeWZnPZcZk
	VY7MyLQzUV+4B9vsBmBt23j5xsWWRMwAiBCEfnKpoNtQLYHA+THvF7mZoR+kgsLb1kjofV5q7N9
	1jtS4dj87ezfDQk+WvNsL0LyI9mqlWcI7fCgPbbYssblnuhyY1n/lst2S3K4EuQVeSMRhbXTQTW
	3zaNrPnGFvptwOAQ892GCJ5VzeFMI8f9imn4vru/wJbyPSrp/aWltSQb/gMM3xyCbCCTG+Dqpww
	gxE+WEuhF6Eogu1Xhqgb7HsW3MJEnJYqdlkMGB5mQvPJrEASYJ3BcU9htBWJarZEVS8UMov0Tjl
	Z7Sw9CANEESuPE6Cz/r68Hgre57ZogvCWERUOmvkC7Zna9eRlE23itTdtg8t2BaAMELy2ws3pKt
	NV5FMPRQXVAfnsewGiGhgoxg2ksjWtDBXfeHsRQcDUj
X-Received: by 2002:a05:6a21:999d:b0:39b:ba95:b127 with SMTP id adf61e73a8af0-3afacd2054dmr7947534637.4.1778747132838;
        Thu, 14 May 2026 01:25:32 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:32 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:35 +0530
Subject: [PATCH 06/14] fbdev: i740fb: fix potential memory leak in
 i740fb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-6-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: A22DB53F4C3
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
	TAGGED_FROM(0.00)[bounces-247144-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

In i740fb_probe(), the memory allocated in fb_videomode_to_modelist()
for modelist is not freed in the error paths. Fix that by calling
fb_destroy_modelist().

Fixes: 5350c65f4f15 ("Resurrect Intel740 driver: i740fb")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/i740fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 9b74dae71472..c14a19382769 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -1152,6 +1152,7 @@ static int i740fb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 	fb_dealloc_cmap(&info->cmap);
 err_alloc_cmap:
 err_find_mode:
+	fb_destroy_modelist(&info->modelist);
 	if (par->ddc_registered)
 		i2c_del_adapter(&par->ddc_adapter);
 	pci_iounmap(dev, par->regs);

-- 
2.43.0


