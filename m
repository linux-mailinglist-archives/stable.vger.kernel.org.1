Return-Path: <stable+bounces-236003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAOaNpzZ3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-236003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:55:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C13EB9A2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254E63039834
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8AF362125;
	Mon, 13 Apr 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSwjEYDJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E622424C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081149; cv=none; b=MNyuYgRz0eGGcGvNxlBMcuX0pPbCduIe/zQvpyHdKTiEshntx6ERNO49ajqmqLTFqOVzo1CfWk9O+0ha/2ZR/kP40HnYMsPt3pd22vtcS0Ze5c37QLLTupzHw2yggU2put241o8+Qxl4IEOyhqBoxmZ/fkM5g4SVs8TOyabZtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081149; c=relaxed/simple;
	bh=cmDKEDrj3j0+aRKmq47EjxqYLMX/XMHXJ7KKwL7jLZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nngHr7C2EUnSI8nn6a2ypfr+dxPRbvt7zv7NA2y4qIGXwmcihPERu8RloFPEgq4RNiKSrg7xPgK3wyJoMur/HTslrgx4o1AyKccWTK39AyPVm7Ggu1NI2HB/uG4Nkmx9M3Kg/c3gbvmSqRGdzsoW9lJbbBOgmO7/XbWYfAyDLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSwjEYDJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f2766905fso673937b3a.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776081147; x=1776685947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPDCJKxAcXMt3zuchNniT/tk14qXxePsxp4RuDFr95g=;
        b=FSwjEYDJ8Uu/9Wy2grrcnkfCrW2jVU4IABCan67P3UeJz9VZRB2R8cRgf44NPdw5jq
         pJF371Mp/bsjPTps8X+W6IZwvryUjxcro5wohukSK1gi5tXgrMmfWkKlfLMCTlqyowre
         aH2ooSP9N178Svt4mWpap/sfWO3VX35ZNEamfOKaY+jUuYQe8Cpreun5r4WkSkkiFXH/
         QoZx8wrvHRSzSt4ZgGJakkxwlU3K68g3mpA7XwDYBfONz24TOBgst7GLCOhNDsK/GnqU
         ArL3CTGfTr38QmsVbylagWxVA3mhuZhugRHUgSIGYCOP0hPmutc+WkJLJxArnVv26i/F
         1Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776081147; x=1776685947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPDCJKxAcXMt3zuchNniT/tk14qXxePsxp4RuDFr95g=;
        b=pZy19tS6xIBVualVFTV58tn4K9nMD9F79KiQWfap2am804B6ts7WgDrUssTNHE3MZC
         umzqvrnIgW4ecF/caHHhgW+hHtKayJ3JQq/fMDEOv7uhqwgHDkIlCEkfDLMPk0SKXqWe
         7kRNkgmjt91Zw2vcoUrGuJSbbZGGUXrsPQyhYeOgP85+5I2K23TbKpAuXzIxPrJ5WqHF
         zS6yzoPuan0ElFx4kg2hTJEh24QAr1r5KTiT64rk1LJexllyCjALrW1VehnS4Csmf8p/
         BCF0s7ficzwlJtVkcXJtjlXCoZZ3ABYI3+EP9TE9KGAR4X8Hfl7O8b51skEL55n/CYzc
         4ZMA==
X-Forwarded-Encrypted: i=1; AFNElJ9DpapWsQtfrBQ4aL4OBQVPrlFsm8EApGINSRlRe2z4vl5qnfIKCyhs+xMDo3Ev/LDzP2dBRQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxswugdj94x4aTWY8OpBWnnC6oDB6Prjwv1gwa7xQA6uDKAlS48
	042ODj3reJjVZ1bWTd/0LTDkVWKHPRIkvMixD9yjC9Z1VcplwVZnrgcg
X-Gm-Gg: AeBDieueH0FSGTDb6oChVV/N6YDrpYvx2YDsd2vyLluR+L3Nj4Bvh4Pi56fpMQNQU0F
	z7BLVauhAdd+4i4UypQMbjV3r+bEw1NNYEDEUm2pBVm//aDtJypZwHxcukaLt9t9vw7w1+kIU11
	gznmmXcpt0BcdoRCdMloP20Wplqi3cUzVF4hgyUKt0s9IVMPF3YQ9ymWsj+V74bcFzsNm8iyDyH
	OeuJQOz8jg79eKc7gDlNTeiyynBQ8N1iA/WrTUIe02kKxxPlr7y9beRyKrCTwuDwyAX6n1X3DAz
	ZuiAXts+kCa/9raigVluM/lSe4ls9sIyFMyYWVGwFjQX+/UCoPjthwK86RjKEHXjsEUdnLX9kwR
	OZWJHbQtzKWv4XB7GlUCNhhZbl+u1a1sLwtxHbJZQE81N+XWcA+2Y6hp/wqi7XV5F1RzQJvsu71
	lleJHZam4Td96UpbepehvBm5+IjWStVlxr
X-Received: by 2002:a05:6a00:8c2:b0:82c:9897:70ef with SMTP id d2e1a72fcca58-82f0c302abbmr14245589b3a.27.1776081147564;
        Mon, 13 Apr 2026 04:52:27 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:db27:7a46:955d:48f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30f5c3sm11077943b3a.3.2026.04.13.04.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:52:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fsi: Fix refcount leak in slave init error path
Date: Mon, 13 Apr 2026 19:52:15 +0800
Message-ID: <20260413115215.2772502-1-lgs201920130244@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-236003-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 480C13EB9A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of slave is expected to be
managed through the device core reference counting. In the
cdev_device_add() failure path, slave and its associated resources are
freed directly, rather than releasing the device reference with
put_device(). This may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

A possible fix would be to use put_device() in the failure path and let
fsi_slave_release() handle the final cleanup.

Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/fsi/fsi-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c6c115993ebc..f447dd53db62 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1084,7 +1084,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	rc = cdev_device_add(&slave->cdev, &slave->dev);
 	if (rc) {
 		dev_err(&slave->dev, "Error %d creating slave device\n", rc);
-		goto err_free_ida;
+		goto err_put_dev;
 	}
 
 	/* Now that we have the cdev registered with the core, any fatal
@@ -1110,8 +1110,9 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	return 0;
 
-err_free_ida:
-	fsi_free_minor(slave->dev.devt);
+err_put_dev:
+	put_device(&slave->dev);
+	return rc;
 err_free:
 	of_node_put(slave->dev.of_node);
 	kfree(slave);
-- 
2.43.0


