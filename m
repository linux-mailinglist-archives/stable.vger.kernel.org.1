Return-Path: <stable+bounces-236155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NoqAqMR3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:54:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B133EE363
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D36302A2E1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2649C3DFC86;
	Mon, 13 Apr 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK48yKlM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038303B583D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095268; cv=none; b=Ftt6aML8ytJ95Mvs7BzGyMDWmI4nFa9oyp2Yj1Gz4MaOwos2qIc5Wz38Rm1lufdi/pM9vJhBoIc/NAE5hsbEzDRt8FvSF8rVhcNW/ZgDponchcOzu/08Uxu5k5qVUcjYsDdtxdDZsUth1PClc8N9XY7CAWki0/jJ8w0eka1YrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095268; c=relaxed/simple;
	bh=m32e0BfF2n/Y3VoUao/TEjPR9SWy1+CRfNSxFuYq/LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGsJBXiyWjyPZ8/NzwbjEiI79/chxCmMhJ/5cDw3oaoqnLZv72UEcJ5qKpoo32D0n2geUejPSw+9Cdeju4VwWDB9G+tDFsVUO8cRotLz+wW8c5LvE3QbdwrX0HF+tLhNJpGxsNZgE2T4Hpj9g5kHzYxSJtdT8wblZQesmIauYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK48yKlM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35fbca04006so461440a91.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095265; x=1776700065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1OPjx6EVJFqbaOhHASpBQer7/3sJPyccCGPM9+uBgBU=;
        b=BK48yKlM0iqpj1otkrYBi9qjUboIGTW9LAW0oNIyMLjfYB8e+6nYVVZilA2T5hFAXP
         Il3vSl8TyU2FPt5CXDHcoiZje7iSAJBm8zLK8O3MRjVopl9VA3S+ZTzZR+9wJnNW6WE4
         +MNI5GCKve7rzZzzBx6+8z3N7d+QEmNepkFgwq5/vxFo3kn3wy1o4B+XvsffdcTO901n
         /UDR4jVuO1IG1O6MqL9taEiMcLt0mi2hsZLKGKMhEEXDNVqotw0eqU2sjyVdhy3ZXZW+
         SSTzj40F1xk7eZHeSDZhxyct1+4DyiV4mNdayyttCwxwdZrfy/Qxd6nMieVvjdLxcX1k
         sKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095265; x=1776700065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OPjx6EVJFqbaOhHASpBQer7/3sJPyccCGPM9+uBgBU=;
        b=HZnlScy2lf0e0ivJNUYmK5tqj7MoZaF8pgWwWmvuTX2hgDK4GPqjfWkebZGeMUfFNZ
         uSPxxL7GY7qY6roj4KKxSsBuBrB5rxCgA8AOqaWCJOkbcQKluWcFwElxSQBQxqyKg0IE
         uBV+puGCPrLkbwKJu/qbDXXVanotmZKwOgqGrIuoqvgfIaE5a9KFh2YInNrwLGeb8frx
         YvH8oatGXVUMHI8W39/pVBGJcT6OELUObYbFnpZHhd26ZWla82Q4zbxbHfSEODd8/j+o
         jSyNfBI2Mo12atBj5YEBLSe4uRR+WzJPGJeHiYMleoSIhBDtW60ykcHV5g1NW9L612KX
         8flA==
X-Forwarded-Encrypted: i=1; AFNElJ9HSYwOCGIpofKrvF9ajdYs43CCTCK/EA708XYb3X7EAEyTuJaqRFoy8kFrSdQY0YPLbylmOME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXj2FivvQko7R8fKTeccJt06d72RmHTc8B5uV9BzKhTUMwKaY
	W/wjjrUQCBtEi23mVg+dqNGYl9nYNdF7xOVsLZ6XBh7CresC1FlhV0lPoq3aLIsNJl8=
X-Gm-Gg: AeBDiesLrz+cAlwLuzhvn3Yt/DLJmv/0pX00tfCyaVfS8lk2sC6t4McX0Ig6FsvH4bi
	P3e8oviblwp7S+cH1pTZsowkU/pHTKYxN7ORf9ITQyhhxiE6hnac1EG2TLNWnSdunbwlu4CbXJ8
	A9xx3iTdUwZFMjwfJz/s2S7ZbR011eKcTOFpCgL5pallVUm6i8//7hp5YJ6I1ESfrfxqRQp6X8Y
	rj+z6YUAA1afE96i3ahSU8QUOIX5RZGh42rqT+U5Ut4+jZjqfJ7vnVuzBSncGgO2VmQbiGXulOC
	gxjv3X6p+WYz5opPIBhZsFf7cElhbkvXF/gV+jpWuAzk0XYsAaNLZo6d8BbOjwPVxwy1RKH8LWW
	XWLGXl0lufHMmcSyXi5sj/tZD4/rRPpfqyhShF2tTfSyNgE2v260Clunrmh770QhQfxLnoxX4JY
	hxqOH+q+aOwaL4YNf99DrSvWVf3BZOmC0=
X-Received: by 2002:a17:90b:3c48:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-35e42849e8cmr14289796a91.25.1776095265313;
        Mon, 13 Apr 2026 08:47:45 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:edd0:8593:d07a:ab64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a20100sm10228887a12.29.2026.04.13.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:47:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: ixp4xx: fix reference leak on platform_device_register() failure
Date: Mon, 13 Apr 2026 23:47:27 +0800
Message-ID: <20260413154727.3051321-1-lgs201920130244@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236155-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81B133EE363
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ixp4xx_timer_probe() directly returns the result of
platform_device_register(&ixp4xx_watchdog_device). When registration
fails, the embedded struct device in ixp4xx_watchdog_device has already
been initialized by device_initialize(), but the failure path does not
drop the device reference, leading to a reference leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review. Fix this by calling platform_device_put()
when platform_device_register() fails.

Fixes: 21a0a29d16c67 ("watchdog: ixp4xx: Rewrite driver to use core")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/clocksource/timer-ixp4xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index 720ed70a2964..924dbd58c4da 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -239,11 +239,16 @@ static struct platform_device ixp4xx_watchdog_device = {
 static int ixp4xx_timer_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	/* Pass the base address as platform data and nothing else */
 	ixp4xx_watchdog_device.dev.platform_data = local_ixp4xx_timer->base;
 	ixp4xx_watchdog_device.dev.parent = dev;
-	return platform_device_register(&ixp4xx_watchdog_device);
+	ret = platform_device_register(&ixp4xx_watchdog_device);
+	if (ret)
+		platform_device_put(&ixp4xx_watchdog_device);
+
+	return ret;
 }
 
 static const struct of_device_id ixp4xx_timer_dt_id[] = {
-- 
2.43.0


