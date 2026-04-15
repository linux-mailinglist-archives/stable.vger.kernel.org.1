Return-Path: <stable+bounces-238189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN2RLHje32kaZwAAu9opvQ
	(envelope-from <stable+bounces-238189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:52:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D90407367
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84293301224C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E53367F54;
	Wed, 15 Apr 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU5MAMEb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A1346E64
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278930; cv=none; b=omt/h+wbsqhGClv5ZzFLcaKRmZ+kTMUObWRiTBAFjCHrNVQpDcwKVs8LKiA6OFOl7roGtAz9GBJ5TPiWNJxW+pDayBKgVwceaSM/XU5lQCQTAy/xx3mBzZk4zOwtMolp+qIFiAX9DyZZZuE+WAGou31kLnk2PJGKg07weR/u0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278930; c=relaxed/simple;
	bh=8jS45grgwD9AuchmvvovcOD11olnelHkn7VzLhgRL/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5RK5ZhpAgHqVDwPdckbIWNJcbNpvbMWQ0zBAToeK605fmEHpeBRGlnBNyYNxw8uYOA3qDYdynOH8y2727PWccVq60sUhrZRIFQOEGFQ5LSwZgYTGkhdOl13b935c8iGqQkivQBUcMzsyWx2BkSe1DTJCLQE6bAYkawlXK/wqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU5MAMEb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c796163fac5so365497a12.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278929; x=1776883729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpeiV1qmh0y7e3ItJrqeH+Ewf1lI+cym8OkHjOuiZhs=;
        b=MU5MAMEbkCnG5CbixzwSyXZpxsGZ/JYwOLnDO2lTMzGMHQbkkqVPaZkfYLITraDSjo
         HDDIAT/OASrXQKALtTksXY8fIdffwf9xQdPT/B1pNF8QvgPYMNcetnPSN7yzoL/g/Nhd
         EZHdwYazAK96BsXerbtk/UeG2le2KLZXLBFFZm8dZqSDpNEFYIZu8FHW1ga49CjZMVlc
         3wVf1a+dNSi1As49qW2Ipfw/E9xZXw2lpzED8gnNZFW0rV84vnVa7+etRKqR+JMLeFv9
         44kHHZEKYho43addMMiVJcUaK0L94pZZ+IsLuSErLqeOWG8Q6Fo5tIN58TP580b4sv7r
         DKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278929; x=1776883729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpeiV1qmh0y7e3ItJrqeH+Ewf1lI+cym8OkHjOuiZhs=;
        b=n7JGKt/oFwY/jYHrYHp6VN+EN5/qnki5BznzQl7Y8e+XSjqf1KnRq1E7gGIV0xrSz3
         0/MFZyi7rO4LOuboMrLwVW/32aFKTaOBrfs4lFA0HmUHVhtTK1DbfzGk2fRskFwPwBO4
         w9Gqr+MgGtevkQMnNnRo8VGY5x6jkJDxTx0n19cSuBEevr5vvqBU5rQoQROjEH8FJsG7
         eNPiG6FC95zFVOb/FxNs6q1tx8UHy+LWTvC4qNjtXEQTH+3LhtudMpsYxjS3Xc7N2Gpa
         cOoKvpIBpxdPciB9o2Ucw50Su1v2KZsX9yHajpBApy9YM4KdeYZ4uJkqY1XTii/xguXD
         38gA==
X-Gm-Message-State: AOJu0Yzqyx7/6kSPENuG0wHSTQ33HmMZ4uSZlW/U4m+eVh/1cYrKtlvp
	u0JwYhtlxXB7ChNg4izE3/dB8t2DmEpnSNRgh2N6Gu3NuwWlVG3ILQVx
X-Gm-Gg: AeBDieuCMtu+mBz/uOck7P+jls6J9BLIeULoO4GEAMLdaOaLx+4H28uV0dBwZQADb7s
	+U8jRswtUjs324pXmQAuSQ6wx4oi577cYvCZXMaLwYFFRmeFykBNYJxITx2oU2+74vSVxhAUddC
	KF5xypJ1yJvuItWEcGzIVYUV/xO2woS1UBQTxQW1MFbW2yJnwh3IY3r/kheoQEXPMMshXAqsY26
	BK5Unxkxjx13dZzxp8R+2Pv5Llxg2cFXqHqSOarsiurJvKGSwf1PpROhnv8lcP5lWC/spq+mlWZ
	lFrP5kuVHXsBMoEFnigjyKZFH7ScOuOaJCgdM/6DXuhvGjHH6Gf6/bKTkjlmzDSNXX6CnJiEoQ7
	veE3chbTFqX6+FrECffLD2HRLGS/ZfmybcUS/5m/XB6uH8djn4O+Mzxznl/UOhdLJIWHX5h4lxi
	hLGJG+zRq95mfF4c4HP1gjG4f1+r2en0jfwPE=
X-Received: by 2002:a17:903:b0e:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2b45ceaf83emr141942895ad.4.1776278928666;
        Wed, 15 Apr 2026 11:48:48 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478109a4dsm29936525ad.18.2026.04.15.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:48:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_fourport: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:48:39 +0800
Message-ID: <20260415184839.3796326-1-lgs201920130244@gmail.com>
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
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238189-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,dyn-67.arm.linux.org.uk,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14D90407367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in fourport_init(), the embedded
struct device in fourport_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  fourport_init()
    -> platform_device_register(&fourport_device)
       -> device_initialize(&fourport_device.dev)
       -> setup_pdev_dma_masks(&fourport_device)
       -> platform_device_add(&fourport_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_fourport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fourport.c b/drivers/tty/serial/8250/8250_fourport.c
index 3215b9b7afde..a65bc7316655 100644
--- a/drivers/tty/serial/8250/8250_fourport.c
+++ b/drivers/tty/serial/8250/8250_fourport.c
@@ -34,7 +34,13 @@ static struct platform_device fourport_device = {
 
 static int __init fourport_init(void)
 {
-	return platform_device_register(&fourport_device);
+	int ret;
+
+	ret = platform_device_register(&fourport_device);
+	if (ret)
+		platform_device_put(&fourport_device);
+
+	return ret;
 }
 
 module_init(fourport_init);
-- 
2.43.0


