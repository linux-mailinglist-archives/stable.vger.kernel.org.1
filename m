Return-Path: <stable+bounces-238190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HxGLKXf32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:57:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66F4073A2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4395301547D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70468246BD5;
	Wed, 15 Apr 2026 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9os1uoC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B4382289
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279235; cv=none; b=H3Af+E5bdEeLqH/+nO50xhQA5xmcgFMCOvNJK7xJP1PIC1M1jz3WUNEmdOVt1sqzkBJe+7NJoKQj/4Hd0mt22W3DuzBEvGQKDePz+FdyGbvp1AR7hRT315ib2D/98Udi9D45wRo7qnO9zx5jgtLECVByQjY94OV2fGLvSizQuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279235; c=relaxed/simple;
	bh=wXf+CtXMOHb6XNnOuHfGJXshs49io3F3XFjW0t392rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHKP/byULg53k9N2jyBGP4fxPawiD9dIbyHctiiFT/PNEFeL96r2ZYje5ikXWkngSMxpWlCMxOCONzX5xqE7TqbLGZhqlNu2N9wGDDk4IXMWwitSDh4r/8NOZ6f5ux6ugZbV9Y1T9c+Ocu89uW6vw68ubbvkr6AdthIsemY/TLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9os1uoC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so4460610a91.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279232; x=1776884032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ic39KQsDtjbejfoaSX2BWNXeNHAHmD9Tq1YFCoyddVU=;
        b=P9os1uoC8LhzUgsGqx/OygwsJXPSu5+qwOUuCMn4qLBdcGfVEBVzG6yTM6CJO2ODMe
         jGXDJnt+koJmimMxyoJ36qw/2uO0Uwttt5+uTq5HnCiRemCeqtymQfpCdsqpGwHDCOd1
         gp4C5pNHzaFfwRVhr6bte/YS9oXjLhC91X8m5kPYfdt1vg/tLS5mrCrweW5a4IkpKZne
         95L92krvHDe9jisjuGQxFRG1ZLOkfDASqySuGfgRS8+Zti5E7uiZj8Pv/hLJ5cTxy21c
         +s9UKYNkAELvsmNshYLrLhJz33LSOKpzTDLYDxIjG9pyOUzuq1hTM9UlidYyTa9Yy5i4
         1OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279232; x=1776884032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ic39KQsDtjbejfoaSX2BWNXeNHAHmD9Tq1YFCoyddVU=;
        b=EMCvNkDeb0t2AwRE6w4pNS8FYA/yPQk2ybTCf/9YZ6R2WrsfOcWkCh/6gGH1BCwVq/
         w+5gP2Sk8hDDQ9ZAKGzIZQ77Ie9jmy1mQZkQ+kzo8yRv/NYl8/CN/TaXPUL+7jFnVSxK
         VN8eUkiLNjwRJly3STQ6D595jBXmwDm3+mdFg1kd/dqukVSZTZ+cl7MhAUFrNVA8cD5K
         6SE9euSKu1M4sCLMtayEgwLshgrlGDvY9YLUmiLz+h4iYJ6xZT/zthIH4l1t+mDGVAeo
         9J3dYBcrR/mnf/n8Kn86QuGSS7KNLZcDzmWZgnYk5VtRknknc/Nsm0N/G+8r4G80JKBe
         sjUQ==
X-Gm-Message-State: AOJu0YxM/795RA98p1TJ1R8Wr0uzP/NsxhmMrh99FFLPeTFG9JhLdeMt
	EFKP787X11A7/Qi2e8OyndrE3CYO/8KblvYg02Y/eCcgQnUODi/xYKuM
X-Gm-Gg: AeBDievmpuyBSoTjrIHFOXGp4LVd8AFD8TsGZbK4AH+nApYD48dSIf00EM3h2iuJPLz
	pSXpl8VIQBESdfzDJH5xZgdNBvxycGgYxbcpaGlbqlWHZ8W/IVonSzdE8vESGE+PMN1SI+ob3Sx
	OWhc2/kGPOEzWBq+CPfH/D3QOGzwt0Y0u9HXR3LQeVYoYLjTEWBk+rCwoV2aD1MxXG4JTXhDyOs
	CWSbIgHSVK+EfZiyqxlkfuHdF4KvT8lqoFaDOOjozdVbt7VzFDuuQjdochFO5tXPh2FHw+rJ1TV
	OCfVjcVq2eCUbpoPnW8oF9T1Kcthnq4AyQCoXzSmgiyNxXEUmqVb1QpCS8eL6crzyHrbR5BgVQ1
	zzttB4ptrRZCHqmfLQi5z0Po0eaUwJcmUAFUAmKURnX65hyIzRMJv5Gu7IotGzo0xesGih3Jfft
	jpnrsZPcfKSssiMTmHAyTIoy930VNrWs19Zps=
X-Received: by 2002:a17:90b:3b52:b0:35f:c1cc:feee with SMTP id 98e67ed59e1d1-35fc1cd0410mr9788933a91.3.1776279232224;
        Wed, 15 Apr 2026 11:53:52 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd20d0c3bsm2834619a91.9.2026.04.15.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:53:51 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Russell King <rmk@dyn-67.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] serial: 8250_hub6: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 02:53:39 +0800
Message-ID: <20260415185339.3804023-1-lgs201920130244@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-238190-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 4A66F4073A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in hub6_init(), the embedded
struct device in hub6_device has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  hub6_init()
    -> platform_device_register(&hub6_device)
       -> device_initialize(&hub6_device.dev)
       -> setup_pdev_dma_masks(&hub6_device)
       -> platform_device_add(&hub6_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: ec9f47cd6a14c ("[PATCH] Serial: Split 8250 port table")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/tty/serial/8250/8250_hub6.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_hub6.c b/drivers/tty/serial/8250/8250_hub6.c
index 273f59b9bca5..005dd6bec3da 100644
--- a/drivers/tty/serial/8250/8250_hub6.c
+++ b/drivers/tty/serial/8250/8250_hub6.c
@@ -43,9 +43,14 @@ static struct platform_device hub6_device = {
 
 static int __init hub6_init(void)
 {
-	return platform_device_register(&hub6_device);
-}
+	int ret;
+
+	ret = platform_device_register(&hub6_device);
+	if (ret)
+		platform_device_put(&hub6_device);
 
+	return ret;
+}
 module_init(hub6_init);
 
 MODULE_AUTHOR("Russell King");
-- 
2.43.0


