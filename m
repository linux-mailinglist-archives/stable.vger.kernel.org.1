Return-Path: <stable+bounces-238180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJRIIvLW32mYZQAAu9opvQ
	(envelope-from <stable+bounces-238180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:20:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E14070B5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E460031747D7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D0346ACE;
	Wed, 15 Apr 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKGqc8QD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5C3EDAA5
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277011; cv=none; b=Hd+jpc9ZOCgfbvQ+uJQm2smZiHsZyOc4nSzaY0LaAWcJEZnkMYWn9vzgdlbCDxKJeMTgJpZBoExprBrJ53fRTXq40qqU5g0NktAvlu+bboSm2iDgrQmGYuS9SKGDWK2GfO1TFoq0skteciysLq3A90Ki1kbxT0ZUpAt1iRIvVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277011; c=relaxed/simple;
	bh=IxFWJtxRv8Mb1+aNXHRQ1gqmj1hf8SCvhG9tk0JJCtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0HBjrCazrqKNaYbg/mh9AzcnOlRB/rCWxn2OKLVdBHeguxYhx19PftColXnyTr2NIbV46G+MUutZSl344hKtY08f31rgBf1YDjL0BAGcW6LKVu0FNOL0sRx0x+1YZwkACmdxkYxJVzIXdizAsXHVGodsdYSNECoLCGW42eTyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKGqc8QD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso4248405b3a.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277009; x=1776881809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkSMnGatsFIe6PvZFudhYv/NcAOEkU0FsMM0HKaHQTQ=;
        b=fKGqc8QDrR9ctjyjYgh7a0jFE1uggRjU2JtWpGTug9VodR49QQ7Ey3m4VfIIwN8KsR
         RTUkhWGpXVUGqNQFJ/7B3jluuzkDz/iTfAT3SM6FuMdwmjHx2oOdB/RpqrWaDjtVgvay
         rKnAd1NAmNllZg7z2mcAJ4ML9LNkIkS/pA/T0qgG6AuReL7qQzKPlO0Zu5F9449PVlY5
         LpRAEBa6ECpuSA6iBr5TV+cuVK7xOdOE6Ve2onx6Nwcz8MwUtrZ4LKO6Kc5+HhdxllLU
         M2vIiW/sSJAq3D3hqR5uPDis1AW8OKzSUA1BKiIjtdVCKyxPNRZbttSLMPfuCJiaFL2w
         6S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277009; x=1776881809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkSMnGatsFIe6PvZFudhYv/NcAOEkU0FsMM0HKaHQTQ=;
        b=jLtfr0ngX1IFOBfbq225LDu9pdLVBE+pAbwqpT7xzzrLZy+je0UU6RNtRAKt05ZPFZ
         ragEJPJjJowGquCDjGp/3CWMk32NP5hEB04ExJjPVS6dPgXx2RSIroJzDXEW0R3PcpVc
         6UofT52/XKl9/mOaC52bToDw80lReR6g3+cbw5aqBYGrRsVRTFEGHkNSKDK1uMDc2qVI
         c0vaMCLIDEdMLBG3QM0vimxC4H1Ubb+F7rQnTIREh+sY8N/Pu/4RT3iLzjl77Pq4kQUG
         fX+EQuTKrcfKZcz6QeGaHa8vWW7c0FWJAM1PzMFGCbxKxXRfJkqtZmlgh+27/0FxRNe3
         TbEw==
X-Forwarded-Encrypted: i=1; AFNElJ+ipG3IcpbsHeJ0EVFH95n48b/Lb/Sl1qeG+AohVhpVnttCxBfI52VPB0OZDbbzP5A1Z76YgfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77kh7k9FtEOUlQQPtq5HNJ+hPYGxgaN+3IwBIVrdQ8w+9c57s
	RTZdbt8HH8tTWx/jrhpyYVZqGCjFp+JZBMW1FxKGVsC6JC9puYXI6Lrg0aduLoB7skZeaQ==
X-Gm-Gg: AeBDietS4Y4Ijf/fP32S5p5QiFfJ4bFNF2GO0JyX8EDkWvfOhEhp7EuCxqieKCEXRoT
	KoDXj53gBhxTspx7FAAUB9h7ojnWDac6AeWcDStsq620lEOT6zGkysCGOAdJexygeDGoAfFzhUa
	G3VasOorbzDdhNS4lAdnqQ69Sdo9oqUYW+Urgy7EZa7ub0uxAOvu970Ao+75SKGNs3qCFy7ZIel
	o3ipjz4QsKUNeqvwWY2QQRJyldjjhaXu3NptH0s0fkhPIB/lGEigkb0b4/oPE9km+mtb44/wfdL
	eFeU/uAm4TVjAjL4vhp6JcYbd1u9dTYT7NmrFTCSMyprfLy/1kpTBMegKxjMO9hGQA2KGEiPXzj
	YW9Gk7a2zyKl5KVofeuHjQ495za5QtTfDeag8/oVWpJK4bmb39b6Rn4NthhMm8Fv0sp62ejhWCY
	8iowmwK3z/9xD8dIGl5LR6hxGqkq2rHXlAf/c1lE1tgaudbw==
X-Received: by 2002:a05:6a00:2e17:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-82f0c30f5d1mr23365240b3a.29.1776277008784;
        Wed, 15 Apr 2026 11:16:48 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:3140:373:572a:dbb0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6f52d45asm1658333b3a.38.2026.04.15.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:16:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: microchip: mpfs-sys-controller: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:16:35 +0800
Message-ID: <20260415181635.3699592-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238180-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D51E14070B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in mpfs_sys_controller_probe(),
the embedded struct device in subdevs[i] has already been initialized by
device_initialize(), but the failure path only reports the error and
does not drop the device reference for the current platform device:

  mpfs_sys_controller_probe()
    -> platform_device_register(&subdevs[i])
       -> device_initialize(&subdevs[i].dev)
       -> setup_pdev_dma_masks(&subdevs[i])
       -> platform_device_add(&subdevs[i])

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() after reporting the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: d0054a470c339 ("soc: add microchip polarfire soc system controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 10b2fc39da66..404c31daf459 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -168,8 +168,10 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(subdevs); i++) {
 		subdevs[i].dev.parent = dev;
-		if (platform_device_register(&subdevs[i]))
+		if (platform_device_register(&subdevs[i])) {
 			dev_warn(dev, "Error registering sub device %s\n", subdevs[i].name);
+			platform_device_put(&subdevs[i]);
+		}
 	}
 
 	dev_info(&pdev->dev, "Registered MPFS system controller\n");
-- 
2.43.0


