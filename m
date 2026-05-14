Return-Path: <stable+bounces-247150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB4cHb6HBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC1153F566
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE8F303FFE6
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEC3DA5DB;
	Thu, 14 May 2026 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="N4djrP1e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912163D8120
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747183; cv=none; b=JQUhnWAJBcPDW9LC0XmnyWDClEEiwTBcifb2n0AEUmHDAQc9jLQKnT1+4mm12/wKfvb2KYw0lO7IqpLJeuyAaMmEr/Xc3af5EwhhB0bBvqzzXaBaAOSsBRt0HMyC1tZol/P/L5Ids26zzjdTGa2g4x3seoKWy0xGV1tiCpOwNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747183; c=relaxed/simple;
	bh=IYxpemUzApEKYrRLdtgG2hm2hB0JVowGXr41xfSQwNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErqLVszOOJBRWZNFz5/o04tNjEjUa5UyOcx8L4xLGBdCneOQANMbLCkSVCJT+w3CMU/2PWOzhHboZ9nIf4rilyV3C305MLkrUW3ufmz1/szx/+C7QMfEUVVL5SDJYkONy7bHTNVzyxeCxRj0UxNwF4tq18pD7WKahvZ2QWmGDj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=N4djrP1e; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8027e876fcso3257247a12.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747179; x=1779351979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bcm+FEfphE7RWlNG6KH2TrNjmFAxIKcw/vHzKLgiSIA=;
        b=N4djrP1e2EnGfPPSSWpRwc2m+ldSTOCQCL1Ub+kM78RtnJUjpiWxERDjGJGP9iS1G2
         fGsO8xXuYbbTU3xjzMprNuTfOXJOfm83B+tP5x+8jMnED+xQSQdzAS1lRq5Kc0CuCs7q
         h3VEkcrldyXHjgL0uSI6PFIwYLsoyODK6s0vc5yS2lGzwSWc4IZ1qc+azLXMyj2TWnb3
         EI+zcL/WigcJub6646lqlZgHkUXkH5PrGEYgCr9HxmbC80XOvGmD6R0fjcMYj2ZZ1bkn
         U1YNfcgmVwKUGP4oKHsrv/IVAUfdSvfj72ZR7PaXypXO6Kfv7DxDoPfnVwhtHYklDMfW
         JgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747179; x=1779351979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bcm+FEfphE7RWlNG6KH2TrNjmFAxIKcw/vHzKLgiSIA=;
        b=ZQytT91iCM9xTx6kTNeOi73EfVXEGqhRfghN3csEQos2SIoDnhImS0GoOSf2UtrXVm
         I0WVl8uKZbHxWclH2OhrdkPX/4Hf2ZYhjAVmZRcn+0PBVEWQqb7LA713F4KkfTTwQIPj
         Sh5f8/XTboTnLCC70asmZyUTyF5ds6UjOXahAtotfuHOeL+wZMAHRHDwYMI/Hu2z/GUH
         kWgOZFnA8kUHd20+pJuOpn0u3jDVA+dHZ+6R33Oll3AFBWYrnrNbvwJsqFhylAy3vx0b
         WwCyDswSUzlxbpJKvO6xcUxwIHl4Ps1oaeuCJkpbP96EX616ZWH7L2Ougs/iQ5eU/YK2
         BKqg==
X-Forwarded-Encrypted: i=1; AFNElJ9X7JrneqELVIPylin9OjeD1sZwSlCvMMW/fYOAj8+2WCqAHW+t+49IVscE0B2d1gc7ecLbH8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ixb5ZUD2cpC6/Tg2RV675s3rLkZzAkj7qmhrKgYC+yRcQnLQ
	sb/1qRP+NJnhQlOYBI3nBFMWP9nPU/E5WPyHf2kT7BiAFJ6SWyJhztbLaKCmUBAkMN8=
X-Gm-Gg: Acq92OELbOOnqH4oEJpKnBxaXzXGJ8XyUeVHrKtgDMDnrMM19raybGRPtcnFMBjQBUa
	HBBpfiEkx8zipePB2jeTvgHSb0nfvzxnO3zb+IxCnWaQXf22OzbXy8zBfJSI3I+ivXVx2lPMWaJ
	fJlorsoMwabFOdUX4xuXxd6gggBgueQr7ftgUyjSf5aXOenzfPKdCJbrbbSV2+oZuLwlnMHqQIr
	11X71nPnWFQoiaMqj99zgJuV1jsXi/JEXMhERbc8JkBzx55y1t6OMRcqCRxWoYB+BKf6LHE+uwq
	MDYUp53GaJP2Jeui3c4CGL92oqsQLC8PaPADYQiZsLa0NiHfd9IUdmp4TWCsBvlhNat2OynxbPc
	yh1V4h2G4nc7KtmOONrpMjpYq+VevdF4o3+3jXBRR1QUVX4uc/69wWbXlxDYOLTaOnYwis12mtF
	FMXxuZHDAPPusanKWZzaLPNFI2wdY9OVwJmXlYa5/Sdz76A+rKAEML/PDyc/rOOS/U+2Dx3Aus/
	TL+y0htJlw/bLwObMMGQIY/Lv5kJJDoe//H3q5wQJkv
X-Received: by 2002:a05:6a21:998e:b0:3ab:13f4:c721 with SMTP id adf61e73a8af0-3afaf522ea5mr6800186637.18.1778747178988;
        Thu, 14 May 2026 01:26:18 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:18 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:41 +0530
Subject: [PATCH 12/14] fbdev: efifb: fix memory leak in efifb_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-12-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: 0AC1153F566
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247150-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iitm.ac.in:email,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller, but the string is not freed in
efifb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/efifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 47ebc0107209..ad8dec7807c3 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -377,6 +377,7 @@ static int efifb_probe(struct platform_device *dev)
 	if (fb_get_options("efifb", &option))
 		return -ENODEV;
 	efifb_setup(si, option);
+	kfree(option);
 
 	/* We don't get linelength from UGA Draw Protocol, only from
 	 * EFI Graphics Protocol.  So if it's not in DMI, and it's not

-- 
2.43.0


