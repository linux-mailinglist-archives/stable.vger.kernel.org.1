Return-Path: <stable+bounces-238178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJWzG63S32kNZQAAu9opvQ
	(envelope-from <stable+bounces-238178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:02:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1398406F9B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AC81307A35E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDF3ED5B2;
	Wed, 15 Apr 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO0yCdmb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECE33123B
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276059; cv=none; b=mVCLDmUNJ/GOR4RAhJRJKFlin0/GlXt/e7oxAyYRkg/EB0njQn54k+NxYTCT6HszsyLfOfntF/eNay3q2GJ+vTYn/jwX1AdAjNRKsxuGezUHDRC6lWh7F0czsxCvZoAlXU49uEJPxdw/PBWmSaalGnN6uRw/Nb4009nkpxkQBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276059; c=relaxed/simple;
	bh=qO55L3YjS8zCKFEzzaa6hbU1AVUHdvMDaL6ZPKdxjCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTglDG+vVPNOAyK/qtyX0tiQB9WMpsW1gYuDXyL4JYUVjEaKZtRGmuuNPRb8sAF0R/LALKh2qkXOChAVP7dk+2zCqj1KpixD1oA5YPZTaTj9F4TTpjqd4JpZ1LcYhIaCntnaM9OA5VwiajnmpInP/QCiynEN2osQzfARL2z7mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO0yCdmb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so2934924a12.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776276057; x=1776880857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BkycsCrJmhofL1VSAGHsLVaCLza7QJmmTEvp4Vq/cIY=;
        b=VO0yCdmbqr7hLOzBkxBHTIDKpESCCKjJIJNkmPcOLT0X4rU/0fHG3T+M556dUw7Hzu
         2XeRZyA9UMa6+7m9QX7vKm1H6jDu0M9vitA4C/FXU3Gt7jPuTLgqeISw72lGhhG9ikBp
         /lxYtssOHoBXTDyNOwT8/qROr1K7YN1rZQNAViim5hgP/bUQ8VEU+CgMM/OGOZdDFgc0
         6Renzo5HbFFPnAtwHylexHva1Fmm4OTGm6peTg6MjgrgzRUjrWzATeKi2PGWPt5B64PX
         wHYEbX6PdJ7y5h5Y0o8Bkn5UFxYDi1T1OS/xzdEPgJ8slZp++Frk1DLR3zjdr4QnVpm1
         4Qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776276057; x=1776880857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkycsCrJmhofL1VSAGHsLVaCLza7QJmmTEvp4Vq/cIY=;
        b=RnZwL27X8bJy4m9pSQhCwaEOk2H7saqbn+42HdbV9/8QicDAjT2zC4Vr5YWppnhPpp
         uev5ARUe4emS49hat5iIERPEndGbvS5BqrQ/GijAMOpcn5x59XdIruwAXcFgetWTFdtT
         3BEy9VyvZjcREkSZT768QnlaWivIs3T60x8Yu6hi3ey3KR11tR99PA84iPRPMgm4Jkos
         skKkQYWmyqh5cg2hsOxgDvqrs4a1+HOjSRl81DW63kRdwh7+u2/++D9zywV13suQDDsd
         m+dd4+5jfwH2b3+MKl9ljQElrvdPdSDaZpYB4xzZKH+UN9AGQfvbw8DYJMd0Y7tU6mLi
         PSbw==
X-Forwarded-Encrypted: i=1; AFNElJ/iTPMCCcrNISPAGvDD6ZVQqLUZhX5n+yTrlxQMLgBN7yjeNlMCS6b4/dy1Wr+1pP7G9eLe8zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF47AloBKfnLFncHlt8V9rvyRay8+rUhkwyfJXLCuGn5QVqdxa
	brsMpGQ7mnHN6bwYoWo1tNN+QPvzKzZo8Nxj4Hq4lXWsRDxOk5t3JgJx
X-Gm-Gg: AeBDieu5jqpV+/UPpA9OsY1FkmT44qDv4W1Xd5b6IhOPeAQB5yU/dVTq+u3uBn4b7K4
	pXMBTFubIczHk3aaCe6P/rlOdjZ2ZKDV8vSpLEkmURMP7vvpSl6coNozSd/BVHL97WaE3HskB+T
	I9wKFRPVjCit7MLdKvVFXEvoMgPpmUQGULKDE2pRI3lxFXuJWcC1tUvNxs1IT7TCbS4K1m7EcBu
	naIvmn/D/pWa1zOogIiDG2oDMdS13INA8PzbFIDSpvpiGXuD+FZNL3BG+lGPMponfcotxzaHYe3
	i7+MWmUuN9/rCou64BiMcnOWSsOYr9eyKdYXLhXkIgtUc9t7tXiTfMTOxamEp6tcwyThhdSsYHq
	afIiJd6XRmAjB9Tbt3pei3NFHBUO7FA6GSskKDRY0cdPw/u8Y/KvdI59Ms/PvhhQQ0HMYyxGxvp
	SmTrh6Pz2cyo189XocDz2fetaFg/Xm7hJBfQ9GVGtMseTQ5X8=
X-Received: by 2002:a05:6a20:4312:b0:39b:c9ff:e3eb with SMTP id adf61e73a8af0-39fe3c64cb1mr23482146637.4.1776276057180;
        Wed, 15 Apr 2026 11:00:57 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581bad89sm2057644a12.25.2026.04.15.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:00:56 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: intel_scu_wdt: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:00:42 +0800
Message-ID: <20260415180042.3648360-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238178-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1398406F9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in register_mid_wdt(), the
embedded struct device in wdt_dev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  register_mid_wdt()
    -> platform_device_register(&wdt_dev)
       -> device_initialize(&wdt_dev.dev)
       -> setup_pdev_dma_masks(&wdt_dev)
       -> platform_device_add(&wdt_dev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 55627c70db6ad ("platform/x86: intel_scu_wdt: Drop SCU notification")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/platform/x86/intel_scu_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
index 746d47d33406..bc120d57cadd 100644
--- a/drivers/platform/x86/intel_scu_wdt.c
+++ b/drivers/platform/x86/intel_scu_wdt.c
@@ -58,13 +58,18 @@ static const struct x86_cpu_id intel_mid_cpu_ids[] = {
 static int __init register_mid_wdt(void)
 {
 	const struct x86_cpu_id *id;
+	int ret;
 
 	id = x86_match_cpu(intel_mid_cpu_ids);
 	if (!id)
 		return -ENODEV;
 
 	wdt_dev.dev.platform_data = (struct intel_mid_wdt_pdata *)id->driver_data;
-	return platform_device_register(&wdt_dev);
+	ret = platform_device_register(&wdt_dev);
+	if (ret)
+		platform_device_put(&wdt_dev);
+
+	return ret;
 }
 arch_initcall(register_mid_wdt);
 
-- 
2.43.0


