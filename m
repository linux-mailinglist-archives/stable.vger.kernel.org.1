Return-Path: <stable+bounces-236286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAjdOVQX3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE13EE960
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7256A31445EE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C160283CBF;
	Mon, 13 Apr 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt+fmGNp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E1280035
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096521; cv=none; b=pSOugAheiJn1pMtFZdeg6GyfRKsLEEuXQpuNq6sEwn7FvO1mEaY6wr6XIX5WpsNEfGUyihdof6kJzf6+BaySwQJFWPTWESemO8jKhopM6pqVFTPKzHlvmfZYkt/qdF5qy5t6zNgw7bD4Z79FdzzeyIRa9z5qZEQPs4KCCXni25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096521; c=relaxed/simple;
	bh=i0LSOgsQKGdynyiwg2vfAGjEbqP1yPutN9vD5tSugdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sf+nGe1YNi3GNKcMxIvZU3YH3Kxj6fir5gyQ0t7PtvuREax9mAYd1ycsI4TqiMnPh8NaJ5tqYEqqRfCQLaU88VikPsuWBMmgpJavnmKKbqEiai2h+Z+XpMsoVt6FSFIJsn/C9v2KedLs+s11LZHokYlXWqQfcJytT8meUR2lB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt+fmGNp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso2611113a91.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776096519; x=1776701319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7gUt840lhpSP9dZOUr3XTpDxlvgtE9AKADPLBm/S/0=;
        b=Lt+fmGNpCDm+H1MxN0/se2Q5x+EsMymOBsB95Cg+3jYlYD9hCMDNWwdrZAPI5JE6NP
         JHVCG2D/qR22jDDvFucTfQOZNE2MgrSdvwhXteABo96udJNOPML+G5FYypr+gM8hzBUu
         BhhN379gwfPXRdkrDy+CYQ+3C9PbRFBZUQU3n+bDxHoG/4wqPOfmPSRUROXL9u1oBAH0
         9eHsbO00ckGVw+4G3F2qy3Rpuv+Q2B3SDEo5ucw8HhOJ9MNqTrScg+YvbxMdzIV6a7+G
         XmsoLyyGSQ7skQYbfRnUX1adkGbmcebhwv59VWOTEFNp0MlyEPn+cbi4IS0+wUxdv3wO
         R7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096519; x=1776701319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7gUt840lhpSP9dZOUr3XTpDxlvgtE9AKADPLBm/S/0=;
        b=gBnbOqRGDT33VoWssnmgu3ecsgbCqXYiqBUk4qr4DQqLvoxcaheMLN0f6k28BZI68y
         PwAP1iVVyrdZluIIR53nQNPkNTvkxwVfEt3sbmqu/s4lLdfjZGxUTGCkwI9qGDfCZ8aV
         XoCBt1Bvm98zj9IdspjtuxMZNsAw9FoHUlG9oXosCClLAa2IsUk8dVd8g2PFoDUG9q9y
         tTjZZst8Aydj5EHWU8C4cHp01G1z0BaBRztF8pgQSSV35GUhCd0816lx7fSARlRXKNB+
         SposRuLu6JAUqRP6lbKGyNMugX0fdCtVgtNN1B5PI/BExLmPGXYFEnLwlkWYeLc6eLiW
         Mjfw==
X-Gm-Message-State: AOJu0YyRZp4PCsfIFtQ6HGs4OxExdhJVdOCRhrZ6e+0SrsmUpdzU6+8T
	ojgXV6CIZqs4xr0UXbGA1MGqsAhB9VVC0WidswG1nM4G4j5z7Skd3t7qnsdNHSmrY/0=
X-Gm-Gg: AeBDievX+OyUxDduRu9OV2TVQI6KgOc98S1Cw1spQ+FX2w59bwkKlGAey9ChM07D8FR
	0fQSZbR+yUrMC86mZ6vfOo31RoVp1oAbwUzmsvt03uRxUbbBELCtdgW74ntEXROM4nY1pRjzCxL
	oVJLnEcIPT7yXlUaXHvrhd1IoANCeH6T3xLDEcmp+4DNYesi8Afh5kD3vizuLs5j+71Hc4PqpQX
	9WWLeIHRcO6tDyKQ4s1qVmjVRxXmNCA/23qF2OCPsLvb9aOneqTywgPnMpeHXQ4ooWulvOyPI5N
	tPy4/CNHTwDAlYe/uJxWpDFJ2ICL/XVtheL/K+nO+wQ9vYH2+Co7oPvh6byNjXUt5szrYni7GZg
	sTFsYGyT0pSnwS1gU1o8h3ba/JV8FCdyaDvKWY9MfAHDD7MvnNGMlCUBJBOznn1Dyvlez9IGY0f
	UlPdV3SorDfSK+MfKnvjSn5ToyU/faTjUq3kvFiSsIRQ==
X-Received: by 2002:a17:90b:390f:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35e42749271mr14031698a91.12.1776096519207;
        Mon, 13 Apr 2026 09:08:39 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:edd0:8593:d07a:ab64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fbc72ffe0sm2814476a91.2.2026.04.13.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:08:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] gpio: omap: fix reference leak on platform_device_register() failure
Date: Tue, 14 Apr 2026 00:08:29 +0800
Message-ID: <20260413160829.3072589-1-lgs201920130244@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236286-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92CE13EE960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

omap_mpuio_init() ignores the return value of
platform_device_register(&omap_mpuio_device).

The call flow is:

  omap_mpuio_init()
    -> platform_device_register(&omap_mpuio_device)
         -> device_initialize(&omap_mpuio_device.dev)
         -> platform_device_add(&omap_mpuio_device)

If platform_device_add() fails, omap_mpuio_init() continues without
dropping the device reference acquired by device_initialize(), leading
to a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling platform_device_put()
when platform_device_register() fails.

Fixes: 730e5ebff40c8 ("gpio: omap: do not register driver in probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpio/gpio-omap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e39723b5901b..841bef431c22 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -800,11 +800,15 @@ static struct platform_device omap_mpuio_device = {
 static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
 	static bool registered;
+	int ret;
 
 	platform_set_drvdata(&omap_mpuio_device, bank);
 	if (!registered) {
-		(void)platform_device_register(&omap_mpuio_device);
-		registered = true;
+		ret = platform_device_register(&omap_mpuio_device);
+		if (ret)
+			platform_device_put(&omap_mpuio_device);
+		else
+			registered = true;
 	}
 }
 
-- 
2.43.0


