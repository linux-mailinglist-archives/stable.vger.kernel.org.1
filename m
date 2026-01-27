Return-Path: <stable+bounces-211868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBFuDCfteGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:51:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C319397FCF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D354E3040FBC
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AB3624B0;
	Tue, 27 Jan 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA07n2sU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68F34A3CC
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532653; cv=none; b=MUv5dvmNuToVoIIp96pbRqfSwGW6rTtzd5W8uKiOy8ba17G/JrItCYNIrPotDDTLNbLww2Baf3rFLyE+LaINI5kU6Sxu9nyYS2F3ZGoeTSXS/MBCnKA6T9qeObEpXKbLzzGUVPmvlBVsudkkHUwZlOV7biGrwss7knrBvooCfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532653; c=relaxed/simple;
	bh=1WGgjypg0PBheHfuaGYLd6B4hrFTtvJOaY0+TNgie7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvYvuOHmJfJFsVAsEKCOQT9gFctkCbTkxQ+BAytRzGTY3Lqfo/7XDmFCSnbygJ1SDor0lC4RSNITWguIqWIJC2XzpXZnqGt8CU4B4IsPa7gvPRzvvznJSl2d4wuLP0fLT/zI/l9wgH5DdAS6VXTvjgGX0SPEfsF5uxAkt17yRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jA07n2sU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d67f1877so38698325ad.2
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769532650; x=1770137450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5SO64hlGAGZzQm96wir8vkRTu1HntqB7h3c84mXcwA=;
        b=jA07n2sUpZ0A7Mu07qloDPg5IdeecHj5rR0x9Wn84SPctyrtnPsRBCHOljfmQYIo0K
         ZIZgiYzeUeBLXASvJlqvnMi5jFftxxSzuwIk8kFEDvv5TbkPG/6q8SIG7B2PiglgKgH+
         cRa9ZM1Fn+xVBefpkcnLv/A33yvJ/OYDjgeHNuZziq4Sn94OVoTTF8jo5NsPNVHJSFVn
         9AUL7I38YTXoa9CUnFYAspAUq70hwaFH+5XBKfgYUNyjBKQ05KCCBlG1aCJpgDH0UISk
         4TR9mbNiCiLDPe/WxX3yccvmcsmOivDqm+Ap/3WIv60gVL+SELiqSqydfMl8fJreigcw
         esyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532650; x=1770137450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5SO64hlGAGZzQm96wir8vkRTu1HntqB7h3c84mXcwA=;
        b=vFzOdqT6qWwUukVKE6jmUu0yBbFE594+tnSXBjUud1ClwmbC4+ZttAE4PXJBuMIpOV
         tkshbqMPeBULQKwDSjkPWvA1sSwJg0xGFl1nD1zC2a/tikf6crcWmVOZ8Ky76eWZGEAu
         fas+ydI0hbOiCWo4ZRbgoOjNXov1SO0ENFWMuB9GX5dyVIC+Nzn2rvoF9Ifybp/Iv4SE
         SaIo3i/YparhoJlNEDDJBrpiIeUyFWy3u37Q8W8MYVYCQRLZiEA0t4XvYI16M6LjB2ln
         AEfNc6zGC5Yfk5aGkETYZ2JSTO8kMGuNRyu4UnCGzEXjsc5ZyZdzTgbMvqBVdoC7U2nH
         wtqg==
X-Forwarded-Encrypted: i=1; AJvYcCVRt+zwr2D01MUC2wQDvBTvyV5BRrIFFWbQTQjO9QsMpOqDrUsSVGpc72TACWRWj2tDYcKQtt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysL8XIsClbHT/tYJWsyKHrK6NAF5WaqCFLp2W7vDxcL1E6YiLB
	z8ANTQ1+Al8R1IYUXaQnRjroVHxePGuBYvIaB8HJF7MyOL2UTnwQ9AEA
X-Gm-Gg: AZuq6aK0MhZcRR3PzEr4nrv85KYQhh34wGuLlCr5a64UEmzKbEG0YnLM0wQYnO7Ftzj
	MH3KsFz+1IdkpMnBFLd0msgMVUP+M4zspLGT4dl8t/GiuE9zCTGyY3Ye09gtHno0qsmsuMoh4Dj
	7ccF+vSo5+7+A+zwVXUwP6yix1KP4eAD3wSgz/OjH0NXmf6hKo224Y3i3UuwLPvffLE5tpCtxUo
	BStKHEkWZ3aAuqCw4ifOgwRLwhPKi3YBG/7Mgqus+w2mVSVGdtBK/L0wYfsmOJikmxDjJRdDLeh
	UA223MrUG0aoLAtVK6xp/1rEpAZiqFCA0k7sGknD4SCXI4Pf18iF6hw86VBF4LXbUtWogH/EB9Z
	lABKobAffHGpUijkV3eQpS8RZGhYBjRuEfAZb/FVGk08jto3iUkJoXmObsoH0tea6aOgywSqsH8
	uLEO+8zxIBcEji1iyPm+1SIATTiyBjTRqu5Mc=
X-Received: by 2002:a17:903:4b07:b0:2a0:993b:d72a with SMTP id d9443c01a7336-2a870da13fcmr16826975ad.4.1769532650395;
        Tue, 27 Jan 2026 08:50:50 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:d29a:ea37:2567:751])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa46fsm120318675ad.21.2026.01.27.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:50:50 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	stable@vger.kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH v4 1/2] media: i2c: ov02c10: Fix use-after-free in remove function
Date: Tue, 27 Jan 2026 22:20:23 +0530
Message-ID: <20260127165024.46156-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127165024.46156-1-bjsaikiran@gmail.com>
References: <20260127165024.46156-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-211868-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C319397FCF
X-Rspamd-Action: no action

The ov02c10_remove() function has a race condition where v4l2_ctrl_handler
and media_entity resources are freed before the device is powered off.
If userspace (e.g., PipeWire/WirePlumber) accesses the device during
removal, this causes a use-after-free leading to kernel oops with
"Execute from non-executable memory" errors.

The issue occurs because:
1. v4l2_ctrl_handler_free() is called first
2. Userspace may still have the device open
3. Control access triggers use-after-free
4. Device is powered off afterwards (too late)

Fix by reordering cleanup to disable runtime PM and power off the device
BEFORE freeing v4l2_ctrl_handler and media_entity resources. This ensures
the device is in a safe state before any resources are freed.

Call sequence after fix:
1. v4l2_async_unregister_subdev() - unregister from V4L2
2. pm_runtime_disable() - disable runtime PM
3. ov02c10_power_off() - power off device if needed
4. v4l2_subdev_cleanup() - clean up subdev
5. media_entity_cleanup() - clean up media entity
6. v4l2_ctrl_handler_free() - free control handler (safe now)

Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
Fixes: 44f8901 ("media: i2c: add OmniVision OV02C10 sensor driver")
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/media/i2c/ov02c10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
index cf93d36032e1..fa7cc48b769a 100644
--- a/drivers/media/i2c/ov02c10.c
+++ b/drivers/media/i2c/ov02c10.c
@@ -864,14 +864,14 @@ static void ov02c10_remove(struct i2c_client *client)
 	struct ov02c10 *ov02c10 = to_ov02c10(sd);
 
 	v4l2_async_unregister_subdev(sd);
-	v4l2_subdev_cleanup(sd);
-	media_entity_cleanup(&sd->entity);
-	v4l2_ctrl_handler_free(sd->ctrl_handler);
 	pm_runtime_disable(ov02c10->dev);
 	if (!pm_runtime_status_suspended(ov02c10->dev)) {
 		ov02c10_power_off(ov02c10->dev);
 		pm_runtime_set_suspended(ov02c10->dev);
 	}
+	v4l2_subdev_cleanup(sd);
+	media_entity_cleanup(&sd->entity);
+	v4l2_ctrl_handler_free(sd->ctrl_handler);
 }
 
 static int ov02c10_probe(struct i2c_client *client)
-- 
2.51.0


