Return-Path: <stable+bounces-238179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NqfCH3V32mYZQAAu9opvQ
	(envelope-from <stable+bounces-238179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:14:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2340702C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE76313C497
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A83ED5D4;
	Wed, 15 Apr 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDULXuSg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBB2F6910
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276761; cv=none; b=phaFGlFvs/ondergDfaC55mtRGI855F4sfSJ6vnACGaxBVrXTsxoZhFWZpHZoYiWF+vqpHtmQHs9I7mM9ptXYao4t/+Yc9KOx7bjwmoeSjNDIeDSCpDbo24x/7HgOZlWDZMxTXMZbRu7SxqKMfo6zg9xr0APfBtV+u36Q75TXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276761; c=relaxed/simple;
	bh=3hGJztvEX6cDexQ5dQY8hER05fHJ7iOxNtn3+4h9WJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tV3i/ZbT8Y1gSpLISSEPFhZiR1jDo7xs4NVJ03snDMni/0vX9s7lay1OGjaOehCLP5OIzg5eWLb5bkVg19gUhFx5x8+MjBUTVKuZk2clG0GWe6GxdojIx6Bq28VKjx+jTrq/mxz0JUL/hojXm39H2/xDveBqym/jJiqFrmbujO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDULXuSg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2addb31945aso43249835ad.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776276758; x=1776881558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DyeTgqiUQeF6qpYSovoboUuQhhyXduArgsMgN+IugZI=;
        b=VDULXuSgoDfBImc3XG1eOFxeF0cj/aoIBTHIQd5WcnNAW9qlwz0HTmfBkEej3WlzA1
         9bNNPEHbsOyMS2OZLrz/F2LavlyjmbizcjX94WfSxNhgKzCGaS7wz4+lMIAbmZ8IFeIG
         4AZXS3O4OY3E/91XOxYf5uJ/PIl4Nb/zE1WyilYtEEPj5HuBt1MYLrYnRo0Pj5+sM1eD
         EuDFbUEqKtYF0JMHTeAv6rcxlMhGCDMa3WOgOJtX3dNOTlAFVSnZ3100ahcEmqxaJEIN
         6Jei4Q0BXoMMT8znP2tir708eH2hSnMJICIRSESjG6rO52OiqoqgMz7FwrD8mk3LItKm
         1Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276758; x=1776881558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyeTgqiUQeF6qpYSovoboUuQhhyXduArgsMgN+IugZI=;
        b=B76J79K5egsUC8D2ee3zoEdlsK5U7+BJk8pKfPU204yuLR48tX50oRQuUV47Qb/BcW
         0NUS7D/p6wLBqfGurJlLfpvx4KrJfBThRa2gwxXe8UU1j9nNYr1950dhF1D2DWd+5J9/
         2r2s6oxvQt9YvxsRksehmyR1EaGU1aj7z1keEN94y5R3IHHhFXGn/PIY1BtkP77YqjGo
         brdIWs/k5JPndcG+ZQndOM+dliBnMF3RoEdLqCWkNH7VLNfQnOhASEvyr16sMx+IXnYT
         GRthDGHikL9xbuJce5buxgQc9BeOM2zEeTDu4DE8CyuYEC7xHQgGn1jsYrjUzKFIV4Mz
         s9kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9No+HluqhxBHekz7hMoNCCIhEDdXI08W/6l8H20nk/uY5iYEZ2toNlWMkPem8shq0NmohBDAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KRY/8/YXvGNJ+iae0gPvglDwV5fy4/BjSktfJIOTIxhOd/yx
	BY14AqKVpag394WfUfjCrE8/ZgONtTZSLXYFdT3gv0ZeONbiaENv9Czx
X-Gm-Gg: AeBDietMkWTQwJEY7mXjcRLa7NhqzNBSP2SM8IR0/ViYxnHlYVEqV9WEiMlXQVhCQcu
	dThzbYxz5qQsyGYuZbpjFbCoAy8SfmPQev7NsYxIVsyepFzD/nfUzbQR6PpXdgu4VZMM4IHndtU
	aXHqVhoicvdgXbpu71tiFG9fYWWCkYXdmiOBbCFX2B3Cov6+R1dkvXWC9U3Ck5PNFiO2phFXq92
	VFg7FFO8qLn78s8O3UH/prXCCtZuGGp3ZAljU6V4T/JcpKy2w+Jo4Kp6ptk88ELlZrhZsmvq+Hf
	08ny0P6OvEZy5vctKCgUrb7ARk9b9+D7JlE3CiKkPbbDAMLxLJ55/BKGT/+aTuBoHLrIHxebcdl
	RNx/Cpqq8WDF2r52mmuz0CAnONH3YUJZpS0c6GHvQL8+vnAnBUVBjZbms4HuXMluUk1J4ZKS3Kl
	BQsEvJZBVbLtaqR1ApaKhQTrAlXfDS4MuS1tD7tagL5uawJQ==
X-Received: by 2002:a17:903:3c4c:b0:2b2:489a:f46a with SMTP id d9443c01a7336-2b2d5a69ae7mr218001135ad.36.1776276758111;
        Wed, 15 Apr 2026 11:12:38 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:3140:373:572a:dbb0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e922sm30845855ad.53.2026.04.15.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:12:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: wm8400: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:12:28 +0800
Message-ID: <20260415181228.3691185-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238179-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,opensource.cirrus.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83D2340702C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in wm8400_register_regulator(),
the embedded struct device in wm8400->regulators[reg] has already been
initialized by device_initialize(), but the failure path returns the
error without dropping the device reference for the current platform
device:

  wm8400_register_regulator()
    -> platform_device_register(&wm8400->regulators[reg])
       -> device_initialize(&wm8400->regulators[reg].dev)
       -> setup_pdev_dma_masks(&wm8400->regulators[reg])
       -> platform_device_add(&wm8400->regulators[reg])

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 42fad570b6662 ("regulator: Add WM8400 regulator support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/regulator/wm8400-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index fb3ca7956d00..5849bb051d2a 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -243,6 +243,7 @@ int wm8400_register_regulator(struct device *dev, int reg,
 			      struct regulator_init_data *initdata)
 {
 	struct wm8400 *wm8400 = dev_get_drvdata(dev);
+	int ret;
 
 	if (wm8400->regulators[reg].name)
 		return -EBUSY;
@@ -254,7 +255,12 @@ int wm8400_register_regulator(struct device *dev, int reg,
 	wm8400->regulators[reg].dev.parent = dev;
 	wm8400->regulators[reg].dev.platform_data = initdata;
 
-	return platform_device_register(&wm8400->regulators[reg]);
+	ret = platform_device_register(&wm8400->regulators[reg]);
+	if (ret)
+		platform_device_put(&wm8400->regulators[reg]);
+
+	return ret;
+
 }
 EXPORT_SYMBOL_GPL(wm8400_register_regulator);
 
-- 
2.43.0


