Return-Path: <stable+bounces-238198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJrlKA7i32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 682CF407486
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A80DD3030D62
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E63845D8;
	Wed, 15 Apr 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNkTn3fB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B634DCE3
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280071; cv=none; b=MxOaLBNmHpjqOT61OMhXZSYbFkqf25es2MFBBW9hGdgiKPJNylIXku14Z8h1sohafWfeLTlEXiODYnnzrM3DRL3h2iS5d2ynupIgy9XSE3Dfn1z56opt9gEmljIeDeEPF8Dt8Gy/fuTqcFN8QYqgZ5rKUlXHPTDLG1T4igmYE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280071; c=relaxed/simple;
	bh=MQ/sUqpism27LsU0EGoWQQpbieUlKUv3I6sun9A9TAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYtyqfI2ysd/DyEpijMUZkKegYYhecCKIMfNgLr6AFnTmAhzuJS2tmzH8qVF3Ak5B3NVMt4mW2LLJcWfugxY/0qSRzRhZzGhlodbkiY32HLcNkELnlCKXgeRu9IezRs/tkTeVqV5IzY3IKPmx3dHUztjVGWeuG73XOHBhuJDAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNkTn3fB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2ea1b3962so24985125ad.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280069; x=1776884869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDtRvz4EVThH1+OkwbQhx5LhEh7Xl5HdhpT/91cyYas=;
        b=LNkTn3fBV9tYuTD6LWYr8LE0O+pvQT+z1WDCZURwKg1pcCaQFebJ7k2uNVTwIUGUmg
         E3PkHHftn48OGQ7q/zuzuJaV+ZJWKXHkNSERRGP2sfkkvToepOiCJLyPQgq7d8+YshEu
         9MLKZ/oNTZn9uwMVUiWIfpF7Pn3Mp+biJ3+sEQWz61hKBqQ2u+OXR50fobUxwjNzjtps
         nbN3ri4N7Q7e75MZFNmC+H3i3Dky13tfCfl8lyBe9Q25ECnJTafcT3XO0mTn7DD/kEuR
         GCxY0+PibliVZRSqh7p01n/o7/yCmhJXJpwXlexzef8xgtLsOy7SFSgLlIJiIb9ZJ8d3
         6sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280069; x=1776884869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDtRvz4EVThH1+OkwbQhx5LhEh7Xl5HdhpT/91cyYas=;
        b=isLc3nVZQITr0071JyRFq4AK78hUZ0qEZkjpOktKcAVxhiUtBwdJMtloiRKrTPQ0GB
         Bb6JZQeQiLlV8U4QGy5Ycbjw3wpGUuyRPNXtKmpmoLFb/GnUXwuJ90UwspSY8CKFZOwJ
         KkSiL3P2uP2HNl4QUwx1DcC6AYmGg7xYL4/kHZ0XfDHKPDfvZrYLvJnkJZTUqr3tMLMt
         FQqkXTmNVIuEvFZXunGkhcyb3I52T4WsdnndsLZI9Pjb98hKSDBHEOyTJqEXZNlXsu/C
         I8XOrAlsRi/uAtosHW5f+lfi71soaTmCkHYRbblwnU1V5cL2sfDJGTXkxWlTupDfSUPJ
         qE7g==
X-Gm-Message-State: AOJu0Yz/c9a6l2Dc5X5XTb/hjbIUOLi+++JWcHzSTEj7t4MhTg7iKmbF
	NJad4yDfTcWVffvkrB/DRkRcTBLyCqAiUIIfhcEnEBhMX1zzUKrc7+5e
X-Gm-Gg: AeBDieugROy1pIKS0RQSXbkYj4XQf6IowPEDIEX7MeZVbP6cM+hUzTwYY5Kvi6ApPFz
	TeRaeh2L5xYkYChHloyEVXsCFGILOPvIJpDS4sh/BPa8CvJX7SuZM3pbLkMmLkXvPSV1WBr22sQ
	X2I4YYLreHRAF+7H9h0oVKSjljsBlkJpEiF06c00aTChL1xyXn13yJakwUaGQnBspMeeqnfbybF
	7CzOeAGyILBEVT4cwR8yT0vzmXXhNrTomB59VRAfgaXHM6ebviaRNSo0KgRnYgTvC7+ZaS1hDTZ
	OCDDUdDNKNbA74fEqdzITT9o5KLd3nS9Su4CbZ8IYFbrYWl4rsTDLKyGRkXQxG03s8JLUjt6PFf
	oOe2iYDuQTEdNoZFfY9zTUPlTsFI//n3L6XtDv81AqfEUbIA8hqBwLeymyvY+mGLvxXxGn4o8o3
	4IbrIwhunGciEgZiRmGQ7+jQB/aEvG9nzwcbU=
X-Received: by 2002:a17:902:9341:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2b2d5a45a0bmr183001445ad.21.1776280068622;
        Wed, 15 Apr 2026 12:07:48 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782b53e2sm41305185ad.74.2026.04.15.12.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:07:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: dnfb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:07:38 +0800
Message-ID: <20260415190738.3821974-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238198-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 682CF407486
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in dnfb_init(), the embedded
struct device in dnfb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  dnfb_init()
    -> platform_device_register(&dnfb_device)
       -> device_initialize(&dnfb_device.dev)
       -> setup_pdev_dma_masks(&dnfb_device)
       -> platform_device_add(&dnfb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/dnfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
index c4d24540d9ef..72a9c47418f8 100644
--- a/drivers/video/fbdev/dnfb.c
+++ b/drivers/video/fbdev/dnfb.c
@@ -296,8 +296,10 @@ static int __init dnfb_init(void)
 
 	if (!ret) {
 		ret = platform_device_register(&dnfb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&dnfb_device);
 			platform_driver_unregister(&dnfb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0


