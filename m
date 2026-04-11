Return-Path: <stable+bounces-235736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONB2NXRh2mk+1QgAu9opvQ
	(envelope-from <stable+bounces-235736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:57:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 304353E075C
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8CD530179EE
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625F387591;
	Sat, 11 Apr 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxOOdkdv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DB3845D0
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775919469; cv=none; b=gPGQrWV3eBIkV56+o5Q1fRECMrz3UqDQksjm/0LIo0I0ZymlRByzAL44bDwQRULSzY0zJDsw8rzKVK+N3VhIx9DJl3PDbFf++OOGpYeqDIat132t62D6Belq2rMAft3uuaNb7xhcUfOzx+NboMnPleE/YnLnJYNLOtwKrYYNsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775919469; c=relaxed/simple;
	bh=KZhRFKvZZu8iovP22IupFjT2Gu6PJku17dMapEr38Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmw8bQXPnK9x+gEs/7XVms6ziwIeVvpRmJRB9trerOM/WjL3QoznCSYuR6x+i1rzpLnxhbOETeBi7jnJ7x5sat/ejdciFpTQ7A9C21gHELzCWD3SmU7nm+ANgu1CyS1W/N1cQjhafe0TzBzR/fLlHldhqsb1T0LoSBWtV9EWrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxOOdkdv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f206f2b54so141784b3a.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775919466; x=1776524266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scV4iKj0YWAH3OkdMKrFOu3wLw5+cHFeHwRQSwEoBmA=;
        b=FxOOdkdve58Tby+e8jYdTl6X4UzhHSMJdvMfc+j7NiNGA7tc0Ok1E4yCg+GQoqwDVb
         j38i5WvtCpcFE5KAxKZo2sKBeMtjINJWI0CumWC1PLWcdDhwYYy1OsIKlPNDuihER32P
         7YQ9WVdjwJv+rEtCAj6gXuAnmZpQjXv2sjRzVSIdBd5fvRN5OGGL0NGZj9Q+9KGIULGz
         qTBEEue+p4h5/IEukpdnKmzngBw8H5yp40puDPKAH48fqRG/4XmfAJ5ykVaQwENfydJL
         8CVAnRHLYPPe0UtOoZXGulKyNihKScf464x1NujLvg6MXYTwReK3B7ewTxYbC+kXumsv
         3LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775919466; x=1776524266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scV4iKj0YWAH3OkdMKrFOu3wLw5+cHFeHwRQSwEoBmA=;
        b=kKbfVG02GAUPiDVYKj+fWaboN3nDswTo4w3pC1SVjVmzKdys7p8yrO3fYe4p68clsA
         sXyQMdjGgoWoWD6s/ISP72zabaFvZOdUzVqGxlk8I7+JuBtqaOlgPvWmgKu0rurIwLJ0
         GpxzoXY93Laic6xqS2Kalayl8OstxTFmg4kMLA91e/cp3kZhmKkZwCHVUmVRMFRtQca4
         wD50/T8qTgzSsdCbclr28hegZYOGCVrIUHoKG39Cb5sdEr/yEr5uJEJtm3JeIZMPzPo0
         JuNXQiNEokLl6dEQ++KPQnW1G76EGPNXlCsO+LZX5B4FcMloGfjKj/qIHW27sRnPhk8C
         rfRA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ykSq/cIftQzgGJImve0RqlE0g9AAWiPxPGO8OBDdCVGdqqOIhwYgq6HsJ4zmbYafjPGE2Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OqLT2zkv9uPuBC2EfIFrw9SM5hBc2SEvsiadBeEDWppPmFKK
	qodnQpY7xXqrjHDrAqaYGBDFL3655DW0grMJwa3yXBE+uUrOb2klaBDh
X-Gm-Gg: AeBDievLrxXhOGh+OUkxhhIITSmfVOEG/zh7l1FsNDw5gkH5YjGhLGUFwmMclzPCuyQ
	gKNLq4faR1GBnj+yfvwog5PPWk/BPrwwxL0s0KkBG/Woqi0c1lGiqnOM4QdD5GY8Mvv8IzitLBb
	ru4j0ZQeVO42XGjneer3xvOaUf12hy7oHPnGzOTbsG70N/f3F3JiEeFrYjx0TuQbJY7D+umBHjT
	TJqjiUgNfoehcEeL1q9FwA7Ys0ngpeU6iKoru3ffvWUrpEGl7ymJm1nTGAtu8Aj8KLm8cP8ZO4z
	XtcT8XwgwiuKX526/SnIBCuahe2Wp+AY8Tg9K0EvP/I5Boogw9qy0Ez969KKxFxJ1aUtx8ifeh2
	0Ru6RnY0gkAoBbByD6a0gdOBOXtBweU8vVY9sBxHNIbagXeqm4oYURhkrEMh6HG8WNgv2++EQ9Q
	46x3vwspQW0OO2S2s=
X-Received: by 2002:a05:6a00:6702:b0:82f:1a0b:eb30 with SMTP id d2e1a72fcca58-82f1a0bf063mr3058573b3a.11.1775919466368;
        Sat, 11 Apr 2026 07:57:46 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b17fcsm5949399b3a.33.2026.04.11.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:57:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] device-dax: Fix refcount leak in __devm_create_dev_dax() error path
Date: Sat, 11 Apr 2026 22:57:26 +0800
Message-ID: <20260411145726.2299438-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235736-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 304353E075C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In __devm_create_dev_dax(), several failure paths after
device_initialize() free dev_dax directly instead of releasing the
device reference with put_device(). This bypasses the normal device
lifetime rules and may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

Fix this by assigning dev->type before device_initialize(), so the
release callback is available for put_device(), and use put_device() in
the post-initialization error paths. Keep dev_dax range cleanup explicit
in the error path.

Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dax/bus.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..8753115cd371 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1453,6 +1453,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	}
 
 	dev = &dev_dax->dev;
+	dev->type = &dev_dax_type;
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
@@ -1499,7 +1500,6 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	dev->devt = inode->i_rdev;
 	dev->bus = &dax_bus_type;
 	dev->parent = parent;
-	dev->type = &dev_dax_type;
 
 	rc = device_add(dev);
 	if (rc) {
@@ -1523,14 +1523,21 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 
 err_alloc_dax:
 	kfree(dev_dax->pgmap);
+	dev_dax->pgmap = NULL;
+
 err_pgmap:
 	free_dev_dax_ranges(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
+
 err_range:
-	free_dev_dax_id(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
+
 err_id:
 	kfree(dev_dax);
-
 	return ERR_PTR(rc);
+
 }
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
-- 
2.43.0


