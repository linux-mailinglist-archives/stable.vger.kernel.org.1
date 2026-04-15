Return-Path: <stable+bounces-238145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMF6CmOu32lCXwAAu9opvQ
	(envelope-from <stable+bounces-238145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:27:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9E405E98
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1B133105F1F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6973DA7C9;
	Wed, 15 Apr 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3TBPJCp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4203DA5A0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266641; cv=none; b=ZwAgT8lVQfJJhGk9F+HentWOae3BMWf5G+5fEFoomlbTxFWqsB/80gfk4BpDnRm1kfdHnwlyL9ay2jpykaYBvKcI34R3qMQJGX942LrrULNfLrC+zP2YnxHpRPTTnNxSOK4gMxfzHoDa7Uqn4wy0JpPBdQ+Fc8HIZ7tOO+Z3CUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266641; c=relaxed/simple;
	bh=zWofefXAMoBIMWD0yGiB+cnjkunx6Q6U1CvnfYTDYNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUrwB8OaT3mi3KxBDukpOX10l6g0LdqFcxK3b3auaIEFmC5kaq1Oh9fz0etJ3v+4vlt2B+irdi6c/wNSF5JfCclD7HXx03WCmjJkEQSSgqbCjmjCJzoN7sBeXF5CVOgyFfG5Ue641Ok1TsKmD6M/eTShDydcMM30QNJRsT8YW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3TBPJCp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c796163fac5so214278a12.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266639; x=1776871439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZxxH/dKWsV+bGW+MZF3EUGH4YsLgoDpr4lfqL5yS18=;
        b=L3TBPJCpp/Tri7IHqe7wXCwNlJ916xtl+IkLVFM3pwoHYGtIM4TU2GTE/VjRHbl3NC
         lu7LZPtqKEPJX2HLao3vJfGXpsFCAB1mn/8FjopnF83yXrV0/RT+XaiidawAvlKJC5bP
         i2WuOan9R4ZT0C2yOPB0PTyJUb2sF6ZVZloqWF1a7zFq+cw6xeBYDadCp/T6ZSHi50u/
         2iEXNmuaEs5hcbhOvQgOqHuXVjhVWqXYEOiX/Zfj5i4oAQEEIBYzAZrrSCNk+GSNDN6d
         4gm0BsyaXOyV1T6flOw/f1IgPRTMN7G4uF6Xb5kKRIavC12VuUYRdc2GShE4f38Q9NxB
         c4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266639; x=1776871439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZxxH/dKWsV+bGW+MZF3EUGH4YsLgoDpr4lfqL5yS18=;
        b=MRr7Hao91a5061Yw98a/K/uEOvYK3YueY6hGuKv+4AkD1y/iajluCWD0DnU4AOkgXB
         3k7S2HAS3JxgsWEA/Qmy21a/K898F5x854bmNXHyOiRkdsu92V+Mq9YTLm44by3mlGjl
         ySPhuOZiGGEeAZwjcQwb8lMuGTu8PhPZZYPr3rOPxHlq66njNNb11VccDkoQtVnVMSiO
         nwYoF5ss5FE7/Kz6Rd4YtHah3hHw6If5JUC6w5a1Dy7/aAc0Zvr8VXQJyOQaUXK6wqao
         zSWspiFwS31ousdPIzQ6BKFVO0Xp3qdXfq0ilJT9HKRFSLKRTMuNvVthf3HYj2piAtE3
         Bygg==
X-Forwarded-Encrypted: i=1; AFNElJ89pEfAeCog26ENI/VKO4ucgfvAHXk1v70X+qx9pN4bSUYhnCGmlkrF0Y/mXTSjv/EvbXHL5J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGvuUr6hSzBaXdGvp20FNzj20XC5kCIdBOelO9eBKDtjoDTy1Y
	rZKk6Cu3zW6SDi9K26iNePTBPCWX8roCQ0wNfRkEC/YqaqqBLmOeRot9
X-Gm-Gg: AeBDieuVX2NZEX4bLXVV+Y+SiFmjkR52Pmz5TDuttSQizjeZK6kuzD2VfOvVChnZ28d
	V3+H9bTcdgathXj5ZFJbuizcvsoGK5DOaYGxBE6hUO4tXOZ6GNJJIR0QaYmX3AGM80ypKih8ZEh
	OvYA1MwHoWu5XzEFNBEK9FifkLEgFN2ALoqiDQ+gzej9xbXcKr8xB8KEoYlUuGpVxb62j4SsegL
	gMNBmYJTtx4Q+CXvTu0aZijzg8hgkVxyQ8Ro5+OtLyyTDSoWf0ficUWQtJh7un/0lhfu72WyMt5
	Q4HpEuevhE3HhFAdTN03eSMEr+ditKabVF7nONz6H9SKs8o9XGoCnt+dIP/41y5xtulR1wesVZU
	QJbL55D2te666rKPNEv8VBxZlQDO5TYR8KPfqDAyoGwNrEuj1vptIeU0fbnmmwZH1xdiYgCP3rF
	/4yHB0luEy0hzCaIS4qKkIpS6b07ICfB9tIqR/XQHghw==
X-Received: by 2002:a05:6a20:7d9b:b0:398:b16f:7045 with SMTP id adf61e73a8af0-39fe3f5d036mr23819827637.29.1776266639449;
        Wed, 15 Apr 2026 08:23:59 -0700 (PDT)
Received: from lgs.. ([2409:893d:1179:9a96:408e:b322:d944:7204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744c923sm2433719b3a.52.2026.04.15.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:23:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Keiichi Watanabe <keiichiw@chromium.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: vicodec: fix reference leak on failed device registration
Date: Wed, 15 Apr 2026 23:23:43 +0800
Message-ID: <20260415152343.3398025-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238145-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EE9E405E98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in vicodec_init(), the embedded
struct device in vicodec_pdev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  vicodec_init()
    -> platform_device_register(&vicodec_pdev)
       -> device_initialize(&vicodec_pdev.dev)
       -> setup_pdev_dma_masks(&vicodec_pdev)
       -> platform_device_add(&vicodec_pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 256bf813ba39f ("media: vicodec: add the virtual codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 318e8330f16a..bf9a75feee93 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -2238,8 +2238,10 @@ static int __init vicodec_init(void)
 	int ret;
 
 	ret = platform_device_register(&vicodec_pdev);
-	if (ret)
+	if (ret) {
+		platform_device_put(&vicodec_pdev);
 		return ret;
+	}
 
 	ret = platform_driver_register(&vicodec_pdrv);
 	if (ret)
-- 
2.43.0


