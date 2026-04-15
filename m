Return-Path: <stable+bounces-238199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLGzH5ni32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:10:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C04074BA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5149301A089
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3E385534;
	Wed, 15 Apr 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUMTIqyD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394863845D8
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280215; cv=none; b=D0Hx5o898BbOc8Tgxq+2ZPzglhX5wTNdPlOrKvqHvLZzz/IqBeBASonXNDIFqARygV9tJ62nFpyXgFSflcMBEhZtSHtveX7k+p2cKK1reLjV4dKLGfbU+kAhOMeybq9Dnd95e354voAIm8tIvuK9IKB+eSLq7ilq7NnswfRHXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280215; c=relaxed/simple;
	bh=EHnhESO1Tx/OJNq6G8Y2HbREZZHJK7I6MopoJjS56d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rDykc3sXOE/vh8zDy1lfuzD3sCZ32WBf/Goq+rgDVqfgcqRR1yTqS+zQmpHg48culiHqDW7oOoPyJ29WwzOPJfOiM7m8nP7TF9Eg/eJpBLLVs5ik+IP+HJl+kK415OnjORPAOdeb/V9JJTkbCl4bE8qyKycjzOrkYhoG8nZPrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUMTIqyD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso5283087a91.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280213; x=1776885013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTqrfv4BEcpMmcd4d3ppiH5KBkdSGHZGeXMM12mQixA=;
        b=JUMTIqyDIATG+tzvtLpOSPwhRZiFGvkUy8gz8vZyTZlLt9Qm4ur8sogteyfRf4ZmNh
         D02DMhvdBf1KOgVLrSLLZA2gMvLfyil4zia2vkqnO+r2obc/Y66iFJHomlrVKBkpSfG0
         Qp7sCWBIbG0odU0DtYiwa2LplwsZuMnoRkt4C9+NJTTIO7mKJbeVfPeMdtlHUdVs6OYE
         SWkvbY8Z0q+lWpLX9kYlknPCZNJo4YYMGTcmDUtuCsEqLlqC6C+duhyBy1zOSVAwnS+5
         rndF0m3KhIklbqbp5vyVzTB4FKkLWWuoX8m1l/ScYzKzP65EqSXQG4dQVnn6pS+gfJKe
         GAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280213; x=1776885013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTqrfv4BEcpMmcd4d3ppiH5KBkdSGHZGeXMM12mQixA=;
        b=jubAOfwQgaiAkCWVSPBVAQ7Qsek5BC6PIdm/IyYkASaXvZGUqhIKzXuk+RTDbrv263
         wF7HzHi02KUJrWD7WwJQZGc6yvrNz8scqqUVP16roqFr66rR8qqfj9UYbsV4ORwBYVpX
         hNxTn/gftagiqYgcTOmYpCHbxpkg2feUaNmOfb7lyAo5GO2HreO8DNOisN0IkPvFYHeX
         nfdFbG/DtxI4vehvA9f0nl+tv26buLitvubY0CfTbAoL7PmsT95nq9oZcEHeYWvJKNfq
         If8jCXRNva+d8QIFO05C98IR7RiSg1ATWtmC5WvHGYphYhhW910n2tjmsqh/53q/H/lK
         u9RA==
X-Gm-Message-State: AOJu0YwOXlSJ6mzl1n3kpkJvSn2cTUJmXs2PaYHTEJdGHPsL5Ksa/abB
	KNBdHhpc62mqZ/GaAhKd2DwlxYfb+OEMgGsbTcelpyhOALBqnAUXygBd
X-Gm-Gg: AeBDiev9XggPtqWS8lWq/hP+LYtJUTxo4Horg2/I4lkhtuD7lCJWWwI9CgPLHb45tIt
	GHaPiY06fpafK7M2iX6V07w1HUZhsfk+PJIYHFIwkjLLj5wn31SKRIvg6TaeAwKWZlYEJ51lmVa
	jYt6EF6eOKbwrG9eiDhJ7BP9xIA8EImn+f+kw3ycx3GlqhzUqjpKgShNGQXwdT14Sj4DuZ51LtI
	DucSPLljNRbWB4a4IoPtYSM9opzPM5K/VdJZ4+AMjV67N3aNNDkHehahXR8wCtJkG7ng1kdLMuq
	QRImdYIm36+3shID2zlwJFp6d4+34S/ISplRBhP5AqjSYNnWjcympxRYlEuNWK5E/3CrHCoCnXD
	e1mpyICqPOnd82P+DWNv1oMwJUbqcimLiwkopTLq3YBKIMl7nWJl1RgvsvMGeP2Q/oZJKghSAlN
	f6hlWTPDhgPb7NYs6keEGxjDCXWJGDSXnjvis7yCQGPsw1sg==
X-Received: by 2002:a17:90b:350b:b0:35d:a2d3:5c44 with SMTP id 98e67ed59e1d1-35e428581f9mr22426248a91.28.1776280213582;
        Wed, 15 Apr 2026 12:10:13 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd3074758sm2759890a91.1.2026.04.15.12.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:10:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andriy Skulysh <askulysh@gmail.com>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: hitfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:10:03 +0800
Message-ID: <20260415191003.3829558-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238199-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,linux-sh.org,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 428C04074BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in hitfb_init(), the embedded
struct device in hitfb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  hitfb_init()
    -> platform_device_register(&hitfb_device)
       -> device_initialize(&hitfb_device.dev)
       -> setup_pdev_dma_masks(&hitfb_device)
       -> platform_device_add(&hitfb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 048839dc548a5 ("video: hitfb suspend/resume and updates.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/hitfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index 97db325df2b4..29708c2d506d 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -495,8 +495,10 @@ static int __init hitfb_init(void)
 	ret = platform_driver_register(&hitfb_driver);
 	if (!ret) {
 		ret = platform_device_register(&hitfb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&hitfb_device);
 			platform_driver_unregister(&hitfb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0


