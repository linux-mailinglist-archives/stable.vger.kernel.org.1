Return-Path: <stable+bounces-235729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NwcoFShO2mkf0AgAu9opvQ
	(envelope-from <stable+bounces-235729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 970EF3E01E6
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA9A3013A42
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A02269B1C;
	Sat, 11 Apr 2026 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4GZP5k3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3725B30D
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775914531; cv=none; b=gSjhA0bnv6+2TorZwMANG8raveeHnQOB5+rM9gFqM6EcTznzg1IADh72hoO034YlxIEA/Di50t/YSbG3bD5NphtTUMrgKbmvXIGFrngUkS5YxixRMCWyQO7w9xXATgzAo0iKfZdsZZ1scPKGUusNpPGeGHzlrQ0jtqcy6UcYKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775914531; c=relaxed/simple;
	bh=OtSFvIvNO2UsQhwYhpaoeFLi0Y5BtoWJurPvxz8r300=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXUrGJngXZLGXGLvhbBLx5p0yYJ096OCD+mKR13cdmXDyf54QittZhsA053xj/xl5yXsmic0X45YAFoclEhebINOA9IctHhrYE1daJVfXNkeszTM9NbjhTvn/jYer5+tk9D17A/8Y1PtNlnWm73Yyu7vNJV1QlV3faDf0A3l62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4GZP5k3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35c238f1063so2103633a91.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775914529; x=1776519329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d0Or23BS7mDFDSkUDM2f976vD3FVKjgJPHCZRQcp6vA=;
        b=R4GZP5k3LAAU99ggcXw+Wc2U+v9ARuD/zhbCXFfF0kFgK9WtrjuBNbELhSrxf+xo8v
         oNmOQRrlxY42ILDrJQBkhwF2HXYCRYFBDifzYjf/p7FdHJf4Mo/KlTIsk7mUegx9SJ2P
         RipYTnLJIk1iWSDFneKS+FgznfQpPEhd/KaIJO/KmsMRcEtVpSSWOtC9zAjsWKA7J67K
         FH2OtWHyHDU4ssvZ+iA+geguULjEySVfwenE0b2HoHjdrruc7hV9dkMs0+I2kQXMivXl
         FYYI0tDcfojCMnhFSvgcuQlwoSwqDuGk4aQBhjAZCs7Y0gPjvUjczXBHZvhN5Xg3x2Mk
         0Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775914529; x=1776519329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0Or23BS7mDFDSkUDM2f976vD3FVKjgJPHCZRQcp6vA=;
        b=r5TmIJRNasJrjHcnWHS2OL8mxl9RDVV2opWzyqcb1Fq+HliSWOwPxc7V5DH2SMBLBA
         e5aKXnV4SPTUnCt1YO/YkMBlA95zW/iKb+WmlUKf4hYEV4cUa7wjGO1OgQzGqOldVMMr
         cw8HSeFGpnaQQaWSBBt4/jGEddUfcbPyRpcuiTTKNr4tFFQiqdOLnM1kdVDr+sjdIUXq
         lt8Ysok4612raQiHbMZUJqC4791xmXQyM75S+vyn0CHCyV5PyaZFrAIpcFOvbf3kifM9
         ISz+I/U+ks3Lk7M+hh2UAl2DjDEHcrtbpJ5E5T6xj616gtStUYZei4uj6C9r22ra6uTO
         kbkA==
X-Forwarded-Encrypted: i=1; AJvYcCWQsa57ji0AfCPw9FFkj6dHV/zZ9MzkYj0cB4xe2OmvmhAfL2+wluSzV5D5myHg9QBSfoD1pHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6i/YgYDsPsi03+Nn5/WXvPrF0rXs1sp7+HYGJ3MYzRlaiGwc
	W47CAt7VaK5DKY9qCc3relF1yXjFco7cGtlj9hwiXIle/0kXuYTjM55I
X-Gm-Gg: AeBDiesJc6j4a6nA0ORKY90DQrurcPB+0IzQtiXS9F2U+uXHpKhCNL+gEJ8ng8k+InC
	2B8BMp/3yi29Zgm/YmtjIB7J/IuwpwON6UR3QHykaWQ3JT7uv6ghl1S+IO6/hgzjm0deuIDIwT5
	D8mSi9r13AflWuZRx7KXPrMknQPJ6syE5ddBD3f8VO0+j/g2Dzlxsg1ezTfwTtAGrrlMCFIUTg/
	OMNg4V++dxf9WwHckO7FP4KviDSVILTK1/rHBIKGnMLqqlAeO9uPZgGk2tmY8uGN8P44BsS4Pbe
	tjyd8gAUwyB9GiBl9hyLvB8iTpFKwAUpWDZDPUswgu30UnEywY1xFb+yKy3ROdfQMs13rKeBpxp
	jme2InoSG4I/3DG5fIFAsBIrhWMtSywS2xUqFn14YvZmu5LHj4LcLNXMPf6j0rrNj024ajGWAiU
	CMxe+nRm0jemkSHeYuYTZ74g==
X-Received: by 2002:a17:90a:741:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-35e5723894dmr364580a91.9.1775914529394;
        Sat, 11 Apr 2026 06:35:29 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34e959bcsm10056720a91.0.2026.04.11.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:35:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] counter: Fix refcount leak in counter_alloc() error path
Date: Sat, 11 Apr 2026 21:35:11 +0800
Message-ID: <20260411133511.2214024-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235729-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 970EF3E01E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In counter_alloc(), if dev_set_name() fails after device_initialize(),
the error path removes the chrdev, frees the ID, and frees the backing
allocation directly instead of releasing the device reference with
put_device(). This bypasses the normal device lifetime rules and may
leave the reference count of the embedded struct device unbalanced,
resulting in a refcount leak and potentially leading to a use-after-free.

Fix this by using put_device() in the dev_set_name() failure path and
let counter_device_release() handle the final cleanup.

Fixes: 4da08477ea1f ("counter: Set counter device name")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/counter/counter-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 50bd30ba3d03..12dc18c78672 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -123,10 +123,10 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 	return counter;
 
 err_dev_set_name:
+	put_device(dev);
+	return NULL;
 
-	counter_chrdev_remove(counter);
 err_chrdev_add:
-
 	ida_free(&counter_ida, dev->id);
 err_ida_alloc:
 
-- 
2.43.0


