Return-Path: <stable+bounces-227819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGSgHl2dv2ky6wMAu9opvQ
	(envelope-from <stable+bounces-227819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 08:42:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4342E8883
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 08:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69644300FEEC
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511D3195F5;
	Sun, 22 Mar 2026 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrVh6UH3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B10421D00A
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774165337; cv=none; b=hoNLfoUAX9qe9UmjG3M7gwSag8K6sxtIw0gt6wIRkr7/8T05s6SCHSvdpmeEsarApAQEvi058secj9Qe92Fhdb/OHNIZB8VMPtN6i14BiT+qICV2WrS5k8RqYjIEhFQJE3zKD4BT3uRm3U6K/7RVBuR5HTWzCyhAL1h9EePspcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774165337; c=relaxed/simple;
	bh=v5RkR4GWFbiro/iChqZK9upkZLemhscU1rQeqe+R85Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTvDBxG3MMR99YihvR7cAckMCChY4P0s6AiInW0PggiRJcrS77c2dMnYYki40ljB8bN+knlxIEgJv+0CXjzaHg8NVoyVuQusAMN7b7r/Y/V0TrfMqONwErsi7b5IpcZP6pIRM/Qx0C6QASRj21gRAOMkFM0SR7dLKzl3XBUcsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrVh6UH3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aae4816912so12096315ad.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774165336; x=1774770136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9LErbosuoksV5lU780U3bAHDdZ81QQelsqNoxIkru8=;
        b=LrVh6UH3Jxrmnpz4IuB061kNsldG1ZgabU72IZ91b1VDa5ET6nwIW4/Nb2Kb3jc8E+
         bMHMPB3rN4wSTF9ffver/OfAovgJBBzpOTci0nbhFc+MJZVZ/KJpQV1bwCLzhVZ+aXaO
         UJHCXhodpXhMdQXqZmmQnuYVplFF3/eDT797fIeuVhwVqpecquFOg4pvrK03IaqGn4GQ
         fzaJcGAnOgdXfb0YuVCrs7uUDjkTSrPIUi6v6G9RWbGlX3gydCII6JNp705CbFHvizAo
         kSsiPvqsWlB8i7BMCZDnrxuDmQpwY1EHFP9N7NJpUueReFypgcVmM3RhBtMSq3fdjBKM
         ev5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774165336; x=1774770136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9LErbosuoksV5lU780U3bAHDdZ81QQelsqNoxIkru8=;
        b=r5lx7+IZ9nIXXGHmcjaaCqcrIYwBMejR8TVjTepVovui1/6ZMG9CD2bRr+SafKe4YA
         eHsLnGSiR1iro6+dhB3lN3y+Z1bAg2L73wWSsPPembXvMzhbMCtNGyFVveJ6+1chLL1H
         WIfgTFufzORVb7QH93EbY7ZfwktdRtVyipUN4A2ck2WQeeATqjDDf+mW/DWmHd1PZrQ1
         p2ee4p1an+cwCElepzWZs4qv+GKOi58YPVP0exXCKEmU7wb/i01GFEJO8ncLmMIpNp9D
         QB7u0T9UZNpaJYTA5HRxAqZA92MCd3xmsQCpsM6rgThqvCVUZz3SNqTiGrWcxUGqrSr8
         trWw==
X-Forwarded-Encrypted: i=1; AJvYcCVq5tRE6pIERntPC3HFTDvzcQisuLGXq/zjr5KyoOyGu1p/5BFqGuWaQMBRJeOsAfuRDNc68IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLaccwvO1Kid7SpdhJWU8rFycYk7e0kRklchKaYkSv/jhDQ4l
	jgeCyjtHgOfDojLXng3mpnn6WFuX11rjNZabAIo6elvmdGCusPpHTJ3bcb+Yniz9
X-Gm-Gg: ATEYQzxbR2cl2lsSMbJwQv2UhI74PuDsXQrhxHQSj0nlnt8pRKqIplRGLA4BnkNT16q
	IxtZM0jEmk41jJWPShalLRpc3qD7IfIrc2LgOOuPV6Yf6FY0vrBMEi0pwhObjmKuRDqfTKnD36o
	FIgac7Z8Oa0glOv+hUJ9eKdhl+aYi87KvwHNlDXx9jvMga24HAr+VaVCC6aUZ/MpjZNLhB3T/Lq
	tm8076aLG6lecvExvZ5/xh1Xrk15KqQ4S5wdNeN3DIo2f7B/r1NrNjE6Ev4ZTh+N0SFf25I8PRh
	bTOcQnxV3mDR4hwle8rNtZB2DuYQEacfDvNTZRfyHo2kBCjxh+aEOnotTL91tc1gCadsJCAlXHI
	7njk4HX2oTYwtRmMz3wmOGaPmb46RKxvHNHWr6pzEMm5RyjwAlMnxNQfp+YHT+3iwsI9oJYeDXU
	VeOsxrufpPLRYvjeHJ7cAZm/gFsA==
X-Received: by 2002:a17:903:191:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b0826feb3dmr84864075ad.15.1774165335773;
        Sun, 22 Mar 2026 00:42:15 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083690346sm70042915ad.70.2026.03.22.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 00:42:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: 
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: Fix refcount leak in slave init error path
Date: Sun, 22 Mar 2026 15:42:09 +0800
Message-ID: <20260322074209.861513-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227819-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF4342E8883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of slave is expected to be
managed through the device core reference counting. In the
cdev_device_add() failure path, slave and its associated resources are
freed directly, rather than releasing the device reference with
put_device(). This may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

A possible fix would be to use put_device() in the failure path and let
fsi_slave_release() handle the final cleanup.

Fixes: d1dcd6782576 ("fsi: Add cfam char devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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


