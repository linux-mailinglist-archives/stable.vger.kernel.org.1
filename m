Return-Path: <stable+bounces-236005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJNIA7Ta3GlwXgkAu9opvQ
	(envelope-from <stable+bounces-236005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:59:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 659173EBA5A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51AF5302494C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E053C141F;
	Mon, 13 Apr 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuoeL84/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D937C914
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081431; cv=none; b=PdkQBigyMzWH/+OPtE8OvV7CScmEw8lgtbyED1vo4fgNBYIhlLHdId3OqbXDk9Lounr8+rZSHWTjT8S0OP0DTx7/UTSFLDUpZVhSL63QELitcbzMaJIOLT4/ByCIApZ1aOFYuQHk1quYf3qMmF/zdAfwqv/i4xYwIEWV5x5ObRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081431; c=relaxed/simple;
	bh=0bBqSUvIxzOrINLgMycPclzNqzsWJ/9kPBc7hSL1BtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuIPjox8OgtHxdRp/KM6goO1EoNUxxJGV4Z/3UG8QnDHh+e7Yq3cvCsY7ThyrJJXH4J9ZHDJW1mZITXvK9cTEb8YDXA5ISJRDdCbQV4YmE1egoF5zAoxjSdrC1YwHspYZKyqJtdXXIJD4HSzRaVj/6Jt8q+NlkJ9al0Wfb2AKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuoeL84/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2d3a9e149so11258055ad.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776081428; x=1776686228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RTEfxdc1l3m8peU3ZVlNLuiK9i3AY5YcO1a6Vk2UrX8=;
        b=PuoeL84/WerVXeYRkwEUsRk/IoBvJdXDLo3e+SnjKjjSuAwtA+C0BXhhonkwwlEo3W
         nt7pUXWOGex9Ikkuu0ZDlan7zx2lD/zv8mLOitWomcxutDo54+bqxkDLNWQ9ZJdZhVsW
         NilK3dj/uA2JaQx5jh7OGUUFHp0FT5ubYki3kfdbvq9brKtVEkxPB1dE6fd1uXd48CKn
         oY+OLfMBMRXZG92qY+8xq7rpejGFQwg+zkDokTtvifZQi4xr+ji0VEF46QUsbX026+Hm
         mUTq9YwK9KV1OmNoc/biVDHB1TxouEVwgIWuMswihAIJg0LC127r5Mz2cyZqVwQk6+im
         08qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081428; x=1776686228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTEfxdc1l3m8peU3ZVlNLuiK9i3AY5YcO1a6Vk2UrX8=;
        b=rDEkI5U8aARjGNwAWb8mhfWjl+UUGg+d1wxGzDOFJSPX9r6MiKDIZ6nExZJc77ELnx
         PTaQTw0gLMuXO3q43p6wDG/6oLEIbWQ7E8/dWFtEp9MMz/X75WicbqMRsK9aR8ByIaCv
         tx4SzHKBm6LCHU2TyTv1TxxZWZeOMR9Yg2asXEQ5nHJss3ErFYR3lxgH9qjJG3kutZkd
         kOuZpMGIxjCwECki6od/euaKjgWU17nwvQZsBk0ZpTj8OIF7B6Z2ztBqaxvp/3BD5Hel
         BYKmvBUg+Cd+QFXZeuceCslyeGMZFEOld0KBQQcE6q0CUdI7klPIxhOzc0S93buRSomu
         oLUw==
X-Forwarded-Encrypted: i=1; AFNElJ/7dLzyezaWunxz53KFk+PlcY+HcEqRyGtp4ELaSntaCrQXHuXJ5I8sC0JulUvpgkuZP3u7cXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4l/iCKDTkGu6QCYMgUVYQ8xpBwURVfIPIbxPb4fQ7GVWkebB7
	K1zyv5gqXX1KWpUUiHxFi80eEdXKvjhO0PwGkLUR6TTnGkyqWJY9pX9I
X-Gm-Gg: AeBDievStG/KH4KDDk4pWK5YHsT+nFdtNXgPRBFxgM9OEcwqGPam4GyOy3mlGVcbVz7
	RBH3RGKwddy9P9Z0Bpm4gg6+XuERH5afX5umpVzC8DXRDxho/HN1paFVaKxAc9oPFjZtWbFTpQa
	U2YAUrb9vt+GgTc/Z/P9zWBbq8qgtPaihBj4u1vy5iqtxnC2RX9WQcpc/zn6dQglcghxKeu+tt9
	K/jY5bjpRBA8kdnfE2aNnFu6eD/spy6CK96XXsltAiLJZWGAPDwmgnUH8KcltEDXbZvYE5S5VKz
	SQ6hMVj/eWNigL2E4gSbDE3xf9VTkC3w61p9oadZUWB4hui51bQdD4KugPC36hDdLfhuvLSq56J
	lUvy6amv6z1Z6NA5PuHk3SMcTeQ4i34likxlLKmbABuG+l7oyF90AyAW4qg77pAmY8Q4y2esu9z
	sB6UmZ6QRmNSCIHpd3wij8z5Efe/4HvEA=
X-Received: by 2002:a17:903:249:b0:2ae:47b0:dc80 with SMTP id d9443c01a7336-2b2c727c6b2mr151783215ad.11.1776081428501;
        Mon, 13 Apr 2026 04:57:08 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:db27:7a46:955d:48f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2771esm109736585ad.63.2026.04.13.04.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:57:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: trigger: Fix refcount leak in viio_trigger_alloc() error path
Date: Mon, 13 Apr 2026 19:56:56 +0800
Message-ID: <20260413115656.2789049-1-lgs201920130244@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236005-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,analog.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 659173EBA5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
the error path frees trig directly with kfree() rather than releasing
the device reference with put_device(). This bypasses the normal device
lifetime rules and may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device(&trig->dev) in the failure path and let
iio_trig_release() handle the final cleanup. Also update the subirq_base
check in iio_trig_release() to test for >= 0, so that a negative error
code from irq_alloc_descs() is not treated as a valid IRQ descriptor
base during cleanup.

Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/iio/industrialio-trigger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..ab544976018f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -509,7 +509,7 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
-	if (trig->subirq_base) {
+	if (trig->subirq_base >= 0) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
 					  IRQ_NOAUTOEN,
@@ -572,11 +572,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
 					    0);
 	if (trig->subirq_base < 0)
-		goto free_trig;
+		goto err_put;
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto err_put;
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-free_trig:
-	kfree(trig);
+err_put:
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0


