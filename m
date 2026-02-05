Return-Path: <stable+bounces-214404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJspCpRGhGk/2QMAu9opvQ
	(envelope-from <stable+bounces-214404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:28:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851CEF6B1
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F3E300F5C9
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D035CB66;
	Thu,  5 Feb 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrJOAgGm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F535C1BE
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276497; cv=none; b=dISLYMFpL7KjYAgu8F8Q/71xJL1rFLqP5jVFf76+tZz+iy86eEC7trfp80b8RNvdrN9Ra3aK9Agt3sHvx0EjgZr/8zjOhqYbOnmyC9Fklk9chfpIM6iickrh2cdza78kzvJwRD2YGiideSMONcvsxLP/A/0/o/X5WPbHCFmg5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276497; c=relaxed/simple;
	bh=nBWTlLRpovucR5n9qdE4ohF8B8r8nH86ErV4xZp1QvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PcbJtR0ZltVkP9qpBUThnVA7cvmPN+xsoAdWIpZ0CBlDUrCYAa/eis81uu5vwnGJHi7mRL1+rVJyw9cl7jtuqkxFZuZkB99kdAaKuaqvCpr3+jhJcwSinFiOW9I48ytcMpxZLIZKjMhS6RUrr2cmlEozgWimFd5w22x2IR2FAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrJOAgGm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a947d01939so949115ad.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770276496; x=1770881296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niJZqEjbqtJ5TvXSUsWFtbCn8etz6FeqYsyIqQwjnjY=;
        b=FrJOAgGm0m86SFRDuJPOi3QGgglkcU9ysWU/BWkm+GjkB3n1Os26AeLp7Vr6rGg21e
         bkrbgZQm7fprpwxBL7S9FtNme3Ee5gv5SoABkb3l2GenfZzQaL9xl0e8ty4Fe1DQRm+g
         BxiR4577Dgt0BDNtp5VlnKDi84AmEWj04nUej7Dn4le4MeZv007+651y1yodI3GOT41O
         MKYxcZHSMl4qI70O/eBzsOmK3/iodsuTgy0FyV95I2uPMXq/IomLYZFySa4cVGbFFokA
         zVQQ4FPHqc47/rNYIP137LvjOHzS5e9721cNOSaP66mctvYaSydz6ml4pF5zwF95fiSW
         OnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770276496; x=1770881296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niJZqEjbqtJ5TvXSUsWFtbCn8etz6FeqYsyIqQwjnjY=;
        b=DIACPdMT7R1weOMUOEOffAkDJHAh7JXHAz097dgQEG50d5EhwZx7LE9qsPTIgf0cDL
         33p7bmwoZ2bUITvA16B5XjHrP+Y2m444hz7v89w6XgIGCynQaHN9dPRnJYCucSfEguDy
         CeIk6Z3mVtWyNRFY4bJCxAxnznVF6Qt5eekItqoL6dEhR5a+BGrkt3Dhb/lqko7zp1R/
         oJgBT7M8YvyBjNYS3vywSTIjZfHFk7Nr20qSEW87RSI+c1PdeFs2OEEhzBFS/PlTThOX
         USYixh3lU/ECcwP5UMTcol6P01JwP3+XfuPaB+B/phe39m/pF2nBRWhVPxPCX8lIqIVy
         tw2w==
X-Forwarded-Encrypted: i=1; AJvYcCWCG7Sc6FGqSkO3l/s+v1It5W5IfLVs3locjGZqwKpnGEBM/2P3ZvrmTXKXCZgX8NS665Ke2D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAP/7h5VbgjX/wzqWfmnfDbTxBzG2Mj8fnzbrfd1PrYnnkKQ1
	jcjSER2y3qwz453YbJmZqXePwoXcBW+eMBiqsva+hs2/LkjTYSZqNhcs
X-Gm-Gg: AZuq6aKFFlM+qAgj5ICTlxZP4YPzvGLBpEJLKRnHmyYyjmzFtWHhA+CIsCwf32ei0Y4
	kmsvA+XbuRu+3xZ3GwZ862tpI0PaoYPfcKqcVcrlubuCe6gLqs7bDg0LHD6Q/o6s62eMVqBh35W
	I/oydboYmK/pO/Bn2BNqo1vpeQijhdWGFjU7+juH6hwSPEQbNfZTg4RnKF2Dxtjz7xqE4RozTTX
	nS/XoqzYqjTtgY/UZCIXyZu9bIpnwcbGhzXPnlExbBALunW0xI2KTjVe6FHytbY1odUEYU3FdEE
	zi8ltb1IpNUmb4etj8smyKK75+3BUkxF96ohJixcax/aSJu6AxVYlY6vmwoyFL5IyBWQTtA+JH7
	YKBkyti3vaQ1A+EkTirelX9A3iUXKNFoyQ+6tNyF8bK2dFWgs/9TVwRy/lq/r8y+g2jXXZ6u94y
	pi9BvNLkCIgClyZMZwYwTraoLtJA==
X-Received: by 2002:a17:902:e88d:b0:2a0:b02b:210c with SMTP id d9443c01a7336-2a933bca77emr65582155ad.1.1770276496431;
        Wed, 04 Feb 2026 23:28:16 -0800 (PST)
Received: from localhost.localdomain ([119.204.109.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93396747esm41646545ad.80.2026.02.04.23.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:28:15 -0800 (PST)
From: James Kim <james010kim@gmail.com>
To: gregkh@linuxfoundation.org
Cc: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	James Kim <james010kim@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rapidio: mport_cdev: fix sequential UAF in dma_req_free()
Date: Thu,  5 Feb 2026 16:27:24 +0900
Message-Id: <20260205072724.3347647-1-james010kim@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.crashing.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214404-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
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
X-Rspamd-Queue-Id: 7851CEF6B1
X-Rspamd-Action: no action

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


