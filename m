Return-Path: <stable+bounces-247146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAcmFn6HBWr5XwIAu9opvQ
	(envelope-from <stable+bounces-247146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF61453F516
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A53D03076513
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC33D904D;
	Thu, 14 May 2026 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="z1Lt5KaP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AB3D8138
	for <stable@vger.kernel.org>; Thu, 14 May 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747150; cv=none; b=jbJvx1iPJVwy+/eT3Uqnb/9HEEaPOiWGJnkupm2mueJC+UyUCoBivl40mA4ydth5PLxNW2Uk92obNv+bddFHXbSePmLgf2Be7IuW1epkDGuu0cWZveoBJyoSXieFIVDob3LykqU/HEBk4lwggIa/4kCHZ5IlbI0pqBYn7+LgqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747150; c=relaxed/simple;
	bh=Dkx3pVUGwjaUQXWa+bptzHOFLaaIn6XK7Bp6IDRBSVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oa+/oiA5QC/2A/bC+7VWlpbQ3qvK5uKa0EAHIOm6DHZLPXcmTBXru1i7CedJiotap1EWZpYu780gPnL2xCrX/Hb13Djf1O7G3tYsYKWtNeBovdXDKvVuoMgw9v42GJf0efrhpRRbSVv+gdjGqHlby4nqRRNex6xTb7yDgpUAywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=z1Lt5KaP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so4566876a91.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747148; x=1779351948; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8JuFCRwwrvf2GMkTB19c8/MiJ4FqDOCW/ASwDDZNHk=;
        b=z1Lt5KaP747LvCfDiP91KFSqqQKP4kQ1y3sXy0FLgUW340f22HXKEamlJ/Syk/avuE
         kouavYUB0Z/kzfBCo+LJnpLRV5VzB3cRu5mmN13MWRd4HvtvusFo9tQbGt6Gh8wOUXF0
         q810a0rZk6c1wjiwsVznxQRlLBvp0UnWtLkmIQjb/3VGS5pCPf+zQB9OSxGvwsCbI/Kz
         o8vyZIF9RdiaLQmKMdVHlx4aqlldtx7F64Bi3FbS12VFLb9O6VkVNlvrNg0A0SdLinOF
         kGnLVhpTs+WOdPCOOvLEGaxeKdHcbcz6keUL33ol4kn+nz6hC0IDgHl0YbRk7qoo5WQl
         009w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747148; x=1779351948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8JuFCRwwrvf2GMkTB19c8/MiJ4FqDOCW/ASwDDZNHk=;
        b=fAzASRBWlV9vYsJMXnd2fMRxodeieWOwrceFcB0UwpnL2LrdnxZdrpLeu1xSStIwlE
         27gmPTASvWaD34uxN7iugv2pec0HyYNZoQt7efZaHFcPLmne6mCkN2GoMANIPerU+ngb
         cymD3o1eG9V9ommZ7ZyFENfPL5qMy2GxaiS19MoMN9O2cWe+18qwYYM3U+JSMr8/HdKC
         38PZ0l6oMgPeSgas7Xpg3Lu5KPRqnqPhP1byzW9M3krBNO73h9r0Nnv8v1stx3KaTgmz
         X1q27if9+jcNqe1AQM9JmBt/ix1Wpqxz7yYlAbG+ZoUYygstALj74QhR1C3aCJfai3hv
         5Eag==
X-Forwarded-Encrypted: i=1; AFNElJ8soE8kRdRjL4YipOixB3RNCEFjBgVkPnA6jjs6u+UJhJ6zLt5fbRxLLshlDMIc+UzHJZJec2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/W0qQQ12prxjnFkzz6c2uccl8Sd+3z0cTptHvID3hN2anTPL
	c5KrjdZ3HGAt09WnJYGbOM4SIowyjRlFdafcnXpbjqqkMeB+nrjuIWTinTw8CXo1oaI=
X-Gm-Gg: Acq92OEDsvI4diC6wj5diZFIPCsY1aZbZ+fN3Pg4syGd/KBYSvI3zlpf/LvwkxPTHiy
	YLxYx1620psXRcbFPxMR68fyI2aW83ReaxDEhIJHfAiPxs2867LgD3BSBazjzuVFESJFDXTU1ss
	D+x0wyGDIGRSMCKySTh6MBXhG6fDpDQDD0chCnLy6VNUGrVOWtqVcdoOXAYo+XVRxLp8k0Mtlhy
	sdFWYIsmjG8x+RWtiVqDoNHBjEbn7si5n/61Nvc8Uwc0yLA7RlHh+1kAxBXEt64/vjJn0jDtiku
	bO3Sqwfiv3ZW+aIAkzH82CICtLbtzPtyxduS/38BDZNIMDvLSOYXOX+Rf2VsH+mcuJjNP74IDMf
	OMm5GBg15C4uTxWcZ1VJO0y+Ef/gBm2rT7JKzNkbF1UOoi/iyCSo4nh/FSuoW3gkLDTOk8k33ca
	c/HDquIH7cKGE/OGjthgBobYcgvf2xPxswycfih8EtDhQOF7w6GRkIBvBqC+fkT79GRagg21CNN
	g4yc2S/zRR4StJq594dFvI8+rpZXHm7ezj5L2lBukndUQgZK1ntwq0=
X-Received: by 2002:a17:90a:fc44:b0:368:4cb2:17b8 with SMTP id 98e67ed59e1d1-368f40835b7mr7602543a91.21.1778747148094;
        Thu, 14 May 2026 01:25:48 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:47 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:37 +0530
Subject: [PATCH 08/14] fbdev: s3fb: fix potential memory leak in
 s3_pci_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-8-b3a2474fa720@cse.iitm.ac.in>
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
X-Rspamd-Queue-Id: BF61453F516
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
	TAGGED_FROM(0.00)[bounces-247146-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

In s3_pci_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() is not freed in subsequent error paths.
Fix that by calling fb_destroy_modelist()

Fixes: 86c0f043a737 ("s3fb: add DDC support")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/s3fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 831e9e6861b1..dc1f9b627185 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1446,6 +1446,7 @@ static int s3_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 err_alloc_cmap:
 err_find_mode:
 #ifdef CONFIG_FB_S3_DDC
+	fb_destroy_modelist(&info->modelist);
 	if (par->ddc_registered)
 		i2c_del_adapter(&par->ddc_adapter);
 	if (par->mmio)

-- 
2.43.0


