Return-Path: <stable+bounces-211663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOlLAMyld2lrjwEAu9opvQ
	(envelope-from <stable+bounces-211663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:35:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 450848B893
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E917302A6DF
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DCE34D4C4;
	Mon, 26 Jan 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSqsKrRu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7534A3D0
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448898; cv=none; b=EnjJiyF/bebd6wA5ClhdXoSFuuY3D3OhcyNXpTfnT094kxZkw1h1IJ7nx351bGSPhmtGa4MMeLRnTYLuyTAvu4XQw0A2gSU8IwiCiELOVBHxDx2msizxvq+LuXwJK55hNcyldm8ZgXqkvtfn6h++w/WePneKbHNHVW3OjUZhlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448898; c=relaxed/simple;
	bh=PNor2469iVyJ9E5GzWNKwYiSKbnwSOWVXKoUrfRLdA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWa0aaWinkFNgMkAQAX8nuxF8/bFEdNO8uRstIRe4ktn/MlbyIto+PmmON9QvOUeTgdZOa7FqbXnHHtxc3++gfekUO9exW4V5MRzDAX3CiIytdLgdYSfgdetE4qMhHHkfl5sfaH1/HJNidSNFqTaVMF+xWR9WMW7YutaEDw4qxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSqsKrRu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso1534096a12.3
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769448897; x=1770053697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4fUE/bC1heMXrAjT4WoTxQp9kyXS3H0Fld9NNdSCyI=;
        b=gSqsKrRu9/mQ4Zn2QsF55wMgHIuEFeSL3xgYx7T1wbyCiux8Eybb6HILJsy2RiB8kI
         5PCfHXeWcSLVVEtwNXqDjjJEVF/zJQ+YrV3lgIRIs8jwif/kh5HC7qXOny+RUrdhQbru
         d8CA6DwngzrV4ArdLfritbEF2w81CFxuxkOuNp5f0aWoJEdGRfRpR8JYCVtJb8nW3eSt
         gGs/8bx/EyEWbrGIUWths+cA5x8jOIT6+hzm7l0GahyUFq1a2K5SGb69QBY1roG263pq
         F05zxL7Pqi6bQ9k3s1SoGdmATgP+n72acE6/KXUUPWVbZ5ru4E0YuJRQyZB3y8MrF/bL
         NkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448897; x=1770053697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4fUE/bC1heMXrAjT4WoTxQp9kyXS3H0Fld9NNdSCyI=;
        b=OWdlgCyR3uzlLNgVn+Z3JDQc0M1bpZ/J/tqX24WrA9GTFB5gZnLxVyDx9mcveoxM0u
         KcNKQgnIQwMk283va5CESj9znMDutcAXGhq66lWO8+xwCv4ytjGmMiL/QaryQiJGI6/9
         mLLQyfpnqeLNhjO2JapzyTuDqj9pwgwS3qYwMCijRURoJWSWbQTsR/Fx8i1dr38bO5VJ
         OYtpI3DvNxVKQeFBA5PGVj52iohpanh9y9ji9YguuTRkH5X3RF2wMowYEFXc4PJfEykZ
         U+RROLNHY1JqLlsW6UCCboo1xNennREirDWQCZO00axGgDSNNrFbkYEWctehSv7aQNT4
         xpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpEHOdR4PeYFfja/1mD84g/S7H9NgGVMT93Vyov/ROgPROWNe8bC4i6+rFPu06/vp/eJ0ce9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjaQb8IFHF3VU4FnS2n1pqasMHc6cfPQ7NkJ1KByKYY2VCXmTz
	3ZGTzUQsrJJMhopNTYNm6pjJk5coE7E9I/Q/jZ5sY/N6EnJYadaiRN8d
X-Gm-Gg: AZuq6aIP7YK0WcB1n3ig3/yprz8XyWNYvjZouPldXb1aZ5+FLZoWpLLvrFoQ61D0Odc
	0ZPxDN002JSBaXH/qcJEaPrEYtQG2k+gwDUk7E1V5FZR2UY2cvQYgNL3oW4e7EAn3fozxAEZi+V
	MPNxz0mOfNsZJ+C0zH6wO2adJCKthSToCbujD0RQHgQ1yyRJRkGHDdoa7HV69ridN5moNzDZLEe
	N9BwF/Bg6CcKtse55ntqrONd4UpGamKtgFNk8vyJdXV4VK+kZ7VjtgBCxSa3J7em2i/GgCwMGmL
	VuHZvbOQNncCczjckCsCYVx/N1LGKPC+CGPT5435R0WQi6uih30LnkwJdAvEqHSoq6Z0vstgdoX
	y7qvjUo/gIZbjh8pxMxvDU240vwRBXcPvISuwKm6L6MePmCZi3KVkN7d9xEZHM6/X0kqCjIleEB
	7P/KVKOFPANYp1q5CQEKchtUhlBQSUhhm0Kg4s
X-Received: by 2002:a17:90b:4f8c:b0:352:e27e:79c5 with SMTP id 98e67ed59e1d1-353c4182e4cmr3920580a91.31.1769448896787;
        Mon, 26 Jan 2026 09:34:56 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:e23f:af76:8280:9d84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61292bdsm86787a91.6.2026.01.26.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:34:56 -0800 (PST)
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
Subject: [PATCH v3 1/3] media: i2c: ov02c10: Fix use-after-free in remove function
Date: Mon, 26 Jan 2026 23:04:42 +0530
Message-ID: <20260126173444.10228-2-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126173444.10228-1-bjsaikiran@gmail.com>
References: <20260126173444.10228-1-bjsaikiran@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-211663-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 450848B893
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


