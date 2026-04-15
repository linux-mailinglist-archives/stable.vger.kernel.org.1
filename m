Return-Path: <stable+bounces-238175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOK3Dg7Q32m4ZAAAu9opvQ
	(envelope-from <stable+bounces-238175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:51:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5882406E93
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BC72302802D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725F3D649D;
	Wed, 15 Apr 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV3x9tcA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E803DEAD8
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275459; cv=none; b=QcHo8LvrGrINS4dvxxs0jZ8pECKVS+MudjdQARRRxhop4AvdDDLpA+4cYb1LVuRF1XTENtIKcMg4bJ9b2HToep0TzODPuRGrsPzedSfsAB5/G4RtWgKCXRahSLsyWezpSVDT6E6EqnPeNZnFCitNokj2xxWJrXGqZeMnRhPIn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275459; c=relaxed/simple;
	bh=q9TGLRe1UVqxWGYdLDq7YnNCc4SCxzhTB9OScxICR6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7jX+x7ZmD6h1+kkZ9+dW16jrp35X0uFZ3DWzitbinFOTp5/PTg3usv9XZHM+l9X5vuMRkevvRPRz2bBGNlUomsAb5mYa8e7UgHP5s8vrz8mPdn7D3fpbvT98tqTiiAErBPLNOykTRmA9Sn6PCLpM/2NnjzywqTAy9cHtNpu1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV3x9tcA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso42447435ad.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776275456; x=1776880256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjx41/oJzSzCxjCOcBWOIoSBA7KLlVfstVe2P4xKOAc=;
        b=jV3x9tcACRpUKRbQdmJbBUqji3OcwLPq6G7gLJUxOjgQFslkRgeLvJHk6LxMI6E3nr
         DHBW8hf3ZtnNs7LQARdF2Nvpi2x2koOnwO/zQnZU2SQDVM17i+yu5xoC/ROtIlzNh/Rm
         A522ppbngH9ENS88kgAAtDXSv/MAzpwMUbFseTNJi7ks+hvCeIEK7MLvVOyXVfLOMddW
         kXeuNaMhJkdK8Dp3+Ujv6+r8nK/5EmjmWHSmQ/M+IAMZ6eXWdAbuby5lIZ75umDeFzKh
         Lp8O5m/6rs6qDfaZIVUnJ7bcKoJswqv+ePfZCl+4bCQ3MNtcRKAANcG1XoKVEePXOoAM
         /PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275456; x=1776880256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjx41/oJzSzCxjCOcBWOIoSBA7KLlVfstVe2P4xKOAc=;
        b=N5/xAnIwb0gNe5vhjOHAlyrwa6hPog5Tx7+b/I4QZFDO1xgjCqIPiv+LZYNQEEvgbL
         hKM2GRWVN/0CfombIaadhoXLKSA9UlAUD+gOcZgLPB//Cah3Yg/TKhkn59JJfFtwGMxf
         cZgmWBax6ktqUyKrosh+G1nJ13gDj3Zz3aprrR0IWIkOA6dMBURgA+xqPfTIvr7koPvN
         OobpbeaEbu1c52P2tam4n9cuLvA0ueJRHpclMGQcgAkkjnJE02B8iGPLN1CgKcpjFujP
         x563nDvklZLkIX9z/8yQL0M2y8w1NzVAjF0qQ0qWceglmmVYtXK7o9kT14QHZAi9lm9A
         p9wQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ll2a9XtOCJnpZ98h3abgjZyzhW87JmQ51TvtAGmt/N8VuI9M8e8/IZYj/DiNuynz0QOY+h3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Q81OWk7sPv3RNpj0aBHdwIMRIoff7vt+J1ugVOAiDmzvVvTH
	xCh8xo9FJwaq8Xcwa4FwN78bbEvlaw1H5htnh/81dI92Z/TB9uYijBJM
X-Gm-Gg: AeBDiesAB5kZSIELxvhM7E0m2ieQQ8jWx2Gr2d1CpTbF48Tac7l/xNIQU//lFyMD8kt
	JVYVaSd5v2JFWhMvLRUsq89j0O6wwxFIkj/BaKLlxe48AHLWDtH8y6uDcwskeF1/9cwmGKtVz8D
	vmktHBFKVrwT7yPeNmNDVIbdmBprMvEh2jVBff+3FDNlCe+viXV78pFzu65F11bUM7OyLmwsY4J
	7ynwuFTgzM6v92rsfNIGZeCY7ikB1AZvzh/KvcAx5rBg2V37oozrezyJvkqXQuZlpi9WoXiOS3p
	0ESLvLVWLlbZ4nuUrlMBfGh+bS0TW/v7ID6oLI5UmHAyRFNQSxINC8NeiXcnnWdgD0Q1/R/sUdX
	V8d9/vQNNyPubqcrJBVwHJYJ6qFvN8ngzS0/V1vRDWJ71nJ2jvutWHwhZGBQQRFoUv9LgBBHlF4
	irFsJx8bq9nMDrQATGwtYHCfjXaGHfnuegAvvu
X-Received: by 2002:a17:903:3c6d:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2b5eab05edamr3733145ad.20.1776275456476;
        Wed, 15 Apr 2026 10:50:56 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e248sm26728185ad.47.2026.04.15.10.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:50:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 01:50:38 +0800
Message-ID: <20260415175038.3633384-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238175-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5882406E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in chromeos_pstore_init(), the
embedded struct device in chromeos_ramoops has already been initialized
by device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  chromeos_pstore_init()
    -> platform_device_register(&chromeos_ramoops)
       -> device_initialize(&chromeos_ramoops.dev)
       -> setup_pdev_dma_masks(&chromeos_ramoops)
       -> platform_device_add(&chromeos_ramoops)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 9742e127cd0dd ("platform/chrome: Add pstore platform_device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/platform/chrome/chromeos_pstore.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index a6eed99507d4..9e6d14dbb1c2 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -127,8 +127,13 @@ static int __init chromeos_pstore_init(void)
 	/* First check ACPI for non-hardcoded values from firmware. */
 	acpi_dev_found = chromeos_check_acpi();
 
-	if (acpi_dev_found || dmi_check_system(chromeos_pstore_dmi_table))
-		return platform_device_register(&chromeos_ramoops);
+	if (acpi_dev_found || dmi_check_system(chromeos_pstore_dmi_table)) {
+		ret = platform_device_register(&chromeos_ramoops);
+		if (ret)
+			platform_device_put(&chromeos_ramoops);
+
+		return ret;
+	}
 
 	return -ENODEV;
 }
-- 
2.43.0


