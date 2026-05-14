Return-Path: <stable+bounces-247138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHScFfOGBWpOYAIAu9opvQ
	(envelope-from <stable+bounces-247138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:25:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFD53F3F7
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B3B3035A9B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516B3D891A;
	Thu, 14 May 2026 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Rmq8yOMq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA83D7D64
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747090; cv=none; b=gzwWfMizfMlGELnmW3q0F9otj4ADqrIboDTPY4XmwhfcJKnaiSEJOkK1NU5/5tYFJhNtSr3wVH2PxKYYn03CT3p6DDAv/Vk+FLvsOnpy8HYMu2zsrSpebyis1grpm7R7qQCrHqs/G6A6+jL4K9JGkRAksVTTWBtIpd7g85wdg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747090; c=relaxed/simple;
	bh=pQaCeYC0L+OsOx7Di+u7X+3Jw59KU+5kmLZBiKVWt2s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JYQdjnNicYGesUzA7bUDFPf3ZCLo6JY8UPuqYspJyb1Zze9eO8DXlR2SIZi9ytGdy+BqVFFzEYLZH5onbhG198XHZxFTdOX+uV2xZGWujbJAEGjbQSEiCarmEgF0QxMKf+QySgzoFw4E1MBkfnll7TVwCtcinV7teAHflphljUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Rmq8yOMq; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso3208098a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747086; x=1779351886; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mgvCm8MfJh47lqaqPNfqzc/xfynw7OZOiaI/rFvWqY=;
        b=Rmq8yOMqZYztneBTFB08g0ydIO+lue4teTAjYKrx0C4xgLcEBTWDD57MTSzVwdOWZ0
         MlbldvkvlF7j/mSvsQKQwJpyWQhamjbFMTZqi0WNJkxXqEfHRQQ9RIEew36JmwTqiag3
         Q3sPCIuD/OSyEit+HBnZiYDJK6GMymxdT3DrWoj0+kNG+dGvGG6TIeJADb+FNpqa/kAW
         vYp128wG1OP4QGEQKWF/ixHwiKChMf5slEOzMlEm5XkxkgGb+QKMhuadWh+BKv18nIOR
         bKwxHAinDKuPFXpQZsVuyODdcgevIOg42e4iBwr/haeHR6OsZUH4XatUmhGGO75D8DS8
         NSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747086; x=1779351886;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mgvCm8MfJh47lqaqPNfqzc/xfynw7OZOiaI/rFvWqY=;
        b=JRHA8+H46AVlMkpBDgIssHssDBkQI6woay6Q3wNb1Nc9NxbVv3Cb12RzOW5oXml3J/
         ChZ/tLsk11YS7bXV47z8FW267PqTXxQmh1SzlMFRmjpLBt9ySMbjAu3YKgJuouRdjac2
         Efb2TA5WjN3IazGkVT6u1zZSSpYpj+fxinD+ZUiQMfueY8wqxzDKftl2kcAiY4hQ9S8H
         rALICTaQBYUf/LQazSYdfxDeHZMPk42u63q2jRDAQHbb4OWzdbZs+VrgEn8dlyZbp7pD
         B2kmtuG3Ua++2b2AS3YfQOmENWLtIfrzXPxR/GtXoEmWzE6TMnkXYl69763ZAdV7gvz8
         7VkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Kl2n9rzvo7aED2FT/huYVklQ1SaOZadHW9CM+1XzBym7xGmeLuZSRxOl9h+TnRma+IcFAgZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuvfrmVUvoA++GYD45hywarZQW05uG3VLJkfuWPy0lxSqssfAn
	S9EzJLo1OLW4ucWstI2jGghKtJ3QM+aTEf3Oeta0y3yZFWNgCA1wp576yX+iSDkNF70=
X-Gm-Gg: Acq92OHeQ6e1ulli7xpZrO7nzlUIfs5P5/p4qcxz+6mggYR6jYV1XRsxGj4xW2O0eWN
	eleSW+5uwfGfbFusoZwhHgfSO0P2L2BP7Qszr7AQUGYCiEzx1Y0WdKGKlcBTzSL2ZmeS7PPp8Vv
	UEAf0LH8Ne6/0nCIumNO+qViu0wk/BRmEXIFh8dk/k9EK91Rc15SFhaLTqUiVpKgNaOP59QAIp7
	nzvVBKYiRTeQm+5gi1R8twWHlr+J+95sk5NSwZ3LqQUjkM29rYrngVgXQJWRdWhuhm24qWExIUa
	pLTj7UckVNLRcmW6vtD/GM7NAOZ91th+jsbvvMUFYbW5i11ImAg60wLZD1aI5k2Y/NKeA+nvY26
	qesvBUR5FTi3UT0KvId4Ec4BLJDMPIvabRlgyFRVAYnCGnUixORt68rrhieV/vTjAwFIfxj+2ar
	A0huKMZkEPQGJOkNzagy1az/EQbDPiqTqqeZS664+HLWISUN68f4yOMXRMdp9PRYf3XzJrdcVJK
	zjCbTOA13RPICcklDwGbScQQjxoooNfz0zbS8g+9EGxDt4ae7vP1z0=
X-Received: by 2002:a05:6300:218d:b0:395:ce56:4448 with SMTP id adf61e73a8af0-3af7f97ae44mr7226883637.25.1778747085948;
        Thu, 14 May 2026 01:24:45 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:24:45 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Subject: [PATCH 00/14] fbdev: fix various memory leaks
Date: Thu, 14 May 2026 13:54:29 +0530
Message-Id: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2GBWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0Nj3bSklNQyXUvLRFPjlGQDc1OTNCWg2oKi1LTMCrA50bG1tQBF/GH
 kVwAAAA==
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
X-Rspamd-Queue-Id: 98FFD53F3F7
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
	TAGGED_FROM(0.00)[bounces-247138-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,iitm.ac.in:email]
X-Rspamd-Action: no action

This patchset fixes some memory leak issues present in fbdev drivers.

Since commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
fb_deferred_io_init() allocated memory for pagerefs and returned an
error code, but the existing drivers which call fb_deferred_io_init()
were not updated to do cleanup. The first three commits address this.
- fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
- fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
- fbdev: metronomefb: fix potential memory leak in metronomefb_probe()

Probe functions that call fb_add_videomode() or fb_videomode_to_modelist() 
sometimes did not call fb_destry_modelist() to free the allocated
memory. The following patches address this issue.
- fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
- fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
- fbdev: i740fb: fix potential memory leak in i740fb_probe()
- fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
- fbdev: s3fb: fix potential memory leak in s3_pci_probe()
- fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
- fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
- fbdev: uvesafb: fix potential memory leak in uvesafb_probe()

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
the fb_get_options() function transfers ownership of the memory
allocated for options, and so the caller is expected to free it. The
following two patches address this issue.
- fbdev: efifb: fix memory leak in efifb_probe()
- fbdev: vesafb: fix memory leak in vesafb_probe()

The following commit fixes a simple memory leak.
- fbdev: sm501fb: fix potential memory leak in sm501fb_probe()

All the patches were only compile tested.
The issues were found using static analysis.

Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Abdun Nihaal (14):
      fbdev: hecubafb: fix potential memory leak in hecubafb_probe()
      fbdev: broadsheetfb: fix potential memory leak in broadsheetfb_probe()
      fbdev: metronomefb: fix potential memory leak in metronomefb_probe()
      fbdev: radeon: fix potential memory leak in radeonfb_pci_register()
      fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()
      fbdev: i740fb: fix potential memory leak in i740fb_probe()
      fbdev: nvidia: fix potential memory leak in nvidiafb_probe()
      fbdev: s3fb: fix potential memory leak in s3_pci_probe()
      fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()
      fbdev: tridentfb: fix potential memory leak in trident_pci_probe()
      fbdev: uvesafb: fix potential memory leak in uvesafb_probe()
      fbdev: efifb: fix memory leak in efifb_probe()
      fbdev: vesafb: fix memory leak in vesafb_probe()
      fbdev: sm501fb: fix potential memory leak in sm501fb_probe()

 drivers/video/fbdev/aty/radeon_base.c | 1 +
 drivers/video/fbdev/broadsheetfb.c    | 8 ++++++--
 drivers/video/fbdev/carminefb.c       | 1 +
 drivers/video/fbdev/efifb.c           | 1 +
 drivers/video/fbdev/hecubafb.c        | 6 +++++-
 drivers/video/fbdev/i740fb.c          | 1 +
 drivers/video/fbdev/metronomefb.c     | 8 ++++++--
 drivers/video/fbdev/nvidia/nvidia.c   | 1 +
 drivers/video/fbdev/s3fb.c            | 1 +
 drivers/video/fbdev/sm501fb.c         | 3 +++
 drivers/video/fbdev/tdfxfb.c          | 1 +
 drivers/video/fbdev/tridentfb.c       | 1 +
 drivers/video/fbdev/uvesafb.c         | 4 ++--
 drivers/video/fbdev/vesafb.c          | 1 +
 14 files changed, 31 insertions(+), 7 deletions(-)
---
base-commit: ba2e787b4814ebf9ab5f6a84181678b67eb3677b
change-id: 20260513-fbdev-99a53dc0754f

Best regards,
-- 
Abdun Nihaal <nihaal@cse.iitm.ac.in>


