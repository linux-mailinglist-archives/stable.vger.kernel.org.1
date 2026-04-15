Return-Path: <stable+bounces-238144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCAmGX6r32mOXgAAu9opvQ
	(envelope-from <stable+bounces-238144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:15:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00693405C1A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD10300D350
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C53A7837;
	Wed, 15 Apr 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="por+2Kl7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A32C0F84
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266107; cv=none; b=fTFTEpa0qpUcysSXedDYLBQcLYu3n3bTfC7IDW2unIXjYlyrG7ANVn6G/HSYczVfETRMapvMxU/rWO+VsI19woUhwQZCAfaM+dcagcL0nn+pfD71XD4pVgUBXLPoHMsfO1AtcdZdrh+RiZjgty2ec38B7tvqW0J73AALMC8NZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266107; c=relaxed/simple;
	bh=bVYuDe6E8/tQa9JSwBETMmxVEyh0dqCHzU/TdSwyWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh5dS2qGk7ztiz98RlK78eWOBtDJjdkl7D0ihmPSXzEabTXHB7/EQ+EkBGWhZAIu+/FI2/vGL464d4wEnotU6ylqzUpeOAF8A1T+fQXjpqHfGeli2C8THRmmtOhF6zOQ3lDBJ8QI1rZHURPQC2KtP8x2tzw2+yPUSrdbLFE8ZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=por+2Kl7; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d95017a68so4334836a91.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266105; x=1776870905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOR7w0F+ZPAedOetlmUBsNvlbtBWh+W8kyjE1x6Q9SU=;
        b=por+2Kl7llU4kio3dEoK9ylcoOw47w4SoJc/mkcF+qSuIN1HgpHLWR+pzey9BuH9sP
         d12oHw+KZEm3ngwzX9euD5yPN6/2v3ufQko6jKNxGfwnXSQm1XVpi9jLFTRhxmm+csD3
         MyHA+FbgHghnJz6lGP3ax4LQvIScYo9d1eZlkWArhn/QemiLTcfn5jbRU4T2HU2Cn4cC
         20nOMcqFHM90A4DTUrhsJWfdqIEN6OUtDQXkfIeuiTYYilKwI/Q3wdrGCtdUteXRjZ2H
         fKV/mLTYdyx4JU1wcrO3ntNJpHCFSAYqoTbl2Usc6tJkM3nkbxIHXG4ZdQPfuxtfcP/c
         0dzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266105; x=1776870905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOR7w0F+ZPAedOetlmUBsNvlbtBWh+W8kyjE1x6Q9SU=;
        b=X+KdWJmnsKfzC9vZS/QK0oVVyUDrHrASlU25zsW00munolT0CajmoCi+V5acvN2/EL
         BcQDwCLwRqQcJeaU26oeAnlB0I5oXxCYt/qCt//gr52fgwsGzSSLd/6vwsW7Oljc6Yg2
         55NoeePXYcyyAM1gJ5JhauqesuIhW96cY8Xf3moQamsV5fBDDo99Mg3eViOKgcUjytoc
         69/cjyQkkG5NO0UWf1Sol7021+YA5hi3UvQE3ngNCKQAPOR69k/bmIbHfcL9lmrtPCVT
         +hhw7QghGnihX38otWD7peex/pXhdyD35dNezAUyKHCl+9rdGd/lSYgQV7RcFMDzUS7L
         30qg==
X-Forwarded-Encrypted: i=1; AFNElJ8USn1GMogYeazhZOlSRZ6Bx3E6HvqoUHYAzhF3mTctEh4lP4ndxxBkLCZmg8PqgHGXnBuScCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaJbK306DN4AvTYx3FR9O5apxk/1fN9HJHTD3OKavZwLJeBmM
	6SN23wen1UOMSgJRiAP4XXzV+0Yeomh+fV1vlfr3iN6w286y/KLaWGk1
X-Gm-Gg: AeBDievcg28a/7kjpIFLNBisikKP3sZv3hOns/akFuUyLS+nMcQRMPnLKdTFmTtGzhD
	loSbIRCGg8jmXQbNHVAed2S8Ox08I+yvPdeZM8XBJOVjWRRQNBcjEogZ9p+be+OLSPC0zHFgmyt
	6sY1jBVuf3LdbKwxs7ZiNHOvtJLL8ECfG85CQjTZtM6M7Jey/6WqNFBY2q670WYWWg846iPqqHi
	Qq0d6zp0r4pQ2qI8U0y8dO6fFAt5SSrZgcCMdyLLDN74DFwPhCOrtZ/IabWdooy2YGdW9hJRIUK
	DNr6u0Osr6tW0eFZ0OJ0eC2uuNgGODWtjj8IMOKIQsapN//MpxD3ryV0vV8mucWgKhFHjFUF0SP
	ufgR/KS7qDAGpGoQEYt3nhlFJlchagh9btav3Cg7xy99dmLWYXeoggYozYBGWl03fHYC/WXSaGg
	9xJQhe/WvuoXEI2OyUyxlrLILfAD4dCdm+sJF2ByNvJg==
X-Received: by 2002:a17:90a:741:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-35e5723894dmr10328629a91.9.1776266105215;
        Wed, 15 Apr 2026 08:15:05 -0700 (PDT)
Received: from lgs.. ([2409:893d:1179:9a96:408e:b322:d944:7204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd20d0c3bsm2458832a91.9.2026.04.15.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:15:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Matthew Majewski <mattwmajewski@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: vim2m: fix reference leak on failed device registration
Date: Wed, 15 Apr 2026 23:14:49 +0800
Message-ID: <20260415151449.3387235-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,ideasonboard.com,gmail.com,pengutronix.de,linux.intel.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238144-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00693405C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in vim2m_init(), the embedded
struct device in vim2m_pdev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  vim2m_init()
    -> platform_device_register(&vim2m_pdev)
       -> device_initialize(&vim2m_pdev.dev)
       -> setup_pdev_dma_masks(&vim2m_pdev)
       -> platform_device_add(&vim2m_pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 1f923a42033ad ("[media] mem2mem_testdev: rename to vim2m")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/test-drivers/vim2m.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-drivers/vim2m.c
index bb2dd11eef0e..80dc7edcbb5e 100644
--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1601,8 +1601,10 @@ static int __init vim2m_init(void)
 	int ret;
 
 	ret = platform_device_register(&vim2m_pdev);
-	if (ret)
+	if (ret) {
+		platform_device_put(&vim2m_pdev);
 		return ret;
+	}
 
 	ret = platform_driver_register(&vim2m_pdrv);
 	if (ret)
-- 
2.43.0


