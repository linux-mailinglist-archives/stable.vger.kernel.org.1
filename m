Return-Path: <stable+bounces-233346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eITaD5QR02kQdwcAu9opvQ
	(envelope-from <stable+bounces-233346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 03:51:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1563A10CE
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 03:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E071A30086E5
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA462F069D;
	Mon,  6 Apr 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm42Y1cq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76D2628D
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440243; cv=none; b=ERHwwfZN6SCSxcMQR6BpERKinH3UMOiDdAhQw7PsFaP7AVkSSWiesQ8vm0t1scr2Q5uNX+q5ydZidXe12721SV5XOOsXBrP2hmzWhy5/S+ws3+WesNkCltstxyc6mhexcKjbmedI7Nd+8pFqOd4zQ76QOlPU/Dbfz/NqLc/keE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440243; c=relaxed/simple;
	bh=PEkiLmZOewX0MIHOsijuvpO9eg9fkKX5XYFhJLGYXMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oi5U1CJKt5RCBHgpsbF06lVEwlfdCqe/Dl3SVz+vHVxe24rjOhoUcXW1UTvNL0yO57WLWWvDnZRCpUbrfRKG4gs78fUoshJmBuafdRHLsB/7Byo/9gAO2ocLTPIjFmmXND3GJt1vFXWlpSfaFOt/euMqDaOSN9ZFJfevyQujKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm42Y1cq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82ce49785a0so1384111b3a.2
        for <stable@vger.kernel.org>; Sun, 05 Apr 2026 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775440241; x=1776045041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhFGF4zefhHHaaw6dTIqLiXehYgo8vGHmaNux7TXW6Q=;
        b=Tm42Y1cqb1irFPa5q2WTsX/qhHC0m8OZntoI+orCT0Qz7KWCFBp02Aw0/BRQ/KIrQ9
         bFFpx6cvHtSsaUC/3PWYh9Rgaa7UgB5xJ7LeVcGqW5jjgcHE29ztIG2T8MVF+VdVAZEd
         LXwbSqP89e/SGsApym+AsxLbcu2sxvwiXXsRWi4X525oQPp5pABLtnDOxQ9TCWMEJGEM
         R8P/KEkSfJnJRWtfzOudxCc3eKUyG87BxjHvT5otoT7w6mQHm18vMDUq1NEv2HCloJNE
         xaG0We3equAYzkWIsyVbkQJarxMYKu6o9p1jDYp2ZLIx0RKZbIKcg7LHoI+4fUaHlco0
         vblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775440241; x=1776045041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhFGF4zefhHHaaw6dTIqLiXehYgo8vGHmaNux7TXW6Q=;
        b=gXAMDrZLF8g7+78jAxlC54A1UhRpdHViKjeqZ/W9+Om9JwIf9n7upjqQJgjvN0mr7y
         +iQTIj+R05LvMlkamGQV6qxbkZtrcNTccQDTeVdvs2XLA3HiiDv5wZB6jW6GF7lRPc1X
         rYlTyUpfFWlPfQ8zEocuf7oHA/Qd1uJqiRwXJ1VKjvX3tlikZTYoFVuc9GnMSGFqfUJ0
         Ra3MpwH+lQoanNSUHqo9Mfqc6249cL4NdidgGfnYGebkWiqk7bULRwRN3dTDdCe385Jd
         r0pgvEPsf5wrbQgHF9V4n+PQMkW6Dq1B8dIAilbWfA3n2cScI4B9RmkqwMf1fUmkxvQH
         S4Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVB934YJcIuy7SuHxQskdxZK3Age55cNjjgEAdu/e1OzvUExNVe/3F5ERUscAq9CrH5R0GpYxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63N8D2qhmpS9FtArAV7M0nevqmjSW3abAEzw58QsH/iGtoKov
	jj1xKr6TYP2l9LN+0z2vr1fB4GeIg6zN7f4lQbQluIari/M44jRbeQs+
X-Gm-Gg: AeBDievd+agSdjE7ahi0ytlKRBBpIu575AwsWtPunG5VmrRF+k2Goknz0pMDf6hKZ0M
	QGYlW9V6vq7e7hSPGQ6XW+3Oef2wXTAaIWK+RVakYhhbNXXBI+W1LZr9rniZcFDf9ww2L4Reg/b
	9cwLzpXiSCBYS5E8VPYQfCIB2qKoTibvR602BAHKM5IHxbHFQE3DQlJMUVUHv4z6fxJDJk/QkE0
	N+Oj/yMcnuamUkTpYAcMVEL4FG6CjQqDIJ8MsuE/m1GZJIgjmR6Aa1qWVTcZsMtMosxsXluqYpM
	ju28cGtRsgixm5nVjG+d/yUzAW8zw56qIckwobBpr75JtBD7Z9u01OfRGoLu5ASLsxb06JbHEzi
	J4+1/xhFSFrJKkPXdRTwYidnCHq6p1H51ASRQTGM1iQy75jSYATBgN+TR2l0m+U7hoXo7e1R5JJ
	9x0W9SS/ICuNP8MQNOkJmeLicfb5W65Xi3OGTPVQ==
X-Received: by 2002:a05:6a00:2d02:b0:82c:6cbe:7935 with SMTP id d2e1a72fcca58-82d0db53ea7mr10421920b3a.28.1775440241313;
        Sun, 05 Apr 2026 18:50:41 -0700 (PDT)
Received: from localhost.localdomain ([119.204.109.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm14914068b3a.58.2026.04.05.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 18:50:40 -0700 (PDT)
From: James Kim <james010kim@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH] rapidio: mport_cdev: fix sequential UAF in dma_req_free()
Date: Mon,  6 Apr 2026 10:49:59 +0900
Message-Id: <20260406014959.186669-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.crashing.org,gmail.com,vger.kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-233346-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F1563A10CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_req_free() drops the mapping reference under buf_mutex and then
dereferences req->map again to unlock the mutex.

If kref_put() drops the last reference, mport_release_mapping() frees
the mapping, and the subsequent mutex_unlock() dereferences a freed
object. This is a sequential (non-racy) use-after-free.

Fix this by caching map and md before kref_put() and using the cached
md for mutex unlocking.

Fixes: 4b0986a36 ("rapidio: add mport character device support")
Cc: stable@vger.kernel.org
Signed-off-by: James Kim <james010kim@gmail.com>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Resending this patch as it might have been missed due to the merge window.

No changes since the previous submission.

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 7df466e22282..5fb6ec439028 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -582,9 +582,14 @@ static void dma_req_free(struct kref *ref)
 	}
 
 	if (req->map) {
-		mutex_lock(&req->map->md->buf_mutex);
-		kref_put(&req->map->ref, mport_release_mapping);
-		mutex_unlock(&req->map->md->buf_mutex);
+		struct rio_mport_mapping *map = req->map;
+		struct mport_dev *md = map->md;
+
+		mutex_lock(&md->buf_mutex);
+		kref_put(&map->ref, mport_release_mapping);
+		mutex_unlock(&md->buf_mutex);
+
+		req->map = NULL;
 	}
 
 	kref_put(&priv->dma_ref, mport_release_dma);
-- 
2.25.1


