Return-Path: <stable+bounces-217547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOwxIcsemGnhAgMAu9opvQ
	(envelope-from <stable+bounces-217547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:43:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31D165D76
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98153015713
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81083328ED;
	Fri, 20 Feb 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHSavYwB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79F2C1788
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771577023; cv=none; b=JBx9QvMX/T84FXnIYQKUT3IemhIaTJGxDNROcle3zWJJwkzk290p6lzsYpLDIHtedZ0Vf2ZdsdLVYkjOm/HddFEG4XQhtlEVULUwDYJWaM2nC9GDT3sBsS5lKuxDsKe8xd3twHSFJ8GS7jsoii9nrLfB0lPp9l4qR8lQf2fh8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771577023; c=relaxed/simple;
	bh=uibJCDU21LOfe74/m1+PQf1uDx4pPIW7eQn+SHK5qSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agw2qYLZ788x/eoB0j6psQP5o/D34h9cGzNMZpNCyqXpb9zUq1u+9sjO7uBk1ZZ1drmpSNWD35cbVexHB+uzepbjin+Lrsrdhm9ZqbnRVsV3Mwg8HKGcMWE5CikTgYLDA/CGpTmOX6gU7qwxMB+VdfYcs8e+PRelk+aWf6z8W90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHSavYwB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a871c8b171so11436785ad.3
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 00:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771577021; x=1772181821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qO2PxxzQfOEeSvBvTUAwrdOV1cPvLc1kKprU8EjanXk=;
        b=GHSavYwBPgNIew7c0/qa1Dq6xd8SVLXGh6C20UQ5P8zwU7vg8FQdvr0LASVCx313k0
         7W+KduWY7e8PSbFQ+uORfpcxFfLQCEoxDEzZRNH6EWnRBp3WrGx6h1IxT+kNEd4/K1Zy
         cohqXs1FXGErQxwqU93auNUWhPmEdChRlW1EDHjALHiodWQh9eEL4FbiR/WXwQ7TG66/
         bDQy9c6z42FAQ8p4YRVeCRKOpq4a8mL9hLes5BuARL+KLVI/d7nEaVJ07FdhgIAZA2Tr
         9JZCRU603aJTs4pyYs4usvEb4wTipGuLjRTLEyCI1a8gTZ2zZ5jjnu0wSfFDRz7FEJqZ
         akuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771577021; x=1772181821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO2PxxzQfOEeSvBvTUAwrdOV1cPvLc1kKprU8EjanXk=;
        b=FC1TZ/YlJ5LFpw6VojIQmSRzgrZfYwvUWpJn6dCbl3P/IoLeZ/SjGKriRPS+EdAdHQ
         AwYTHFSOkBto4gAKBofQGFT7E/D+8Vb8nu0Xgx7/TRnl1MYM5mbROYDAOPR6C9QMtg7+
         pSAh+FfNVSHD1vSrGrBvSd7Cu1NsaZGcPLvBwAKSWfaRYNMvf0xueDVJVta492APaqxg
         NyILmFg31nFLH13JdXpLRKZ/mWTs6CDhxnxKRxOYnDPg/gJiCNDKbhTYUmemWyMvgY8E
         Cx6JSCdEw/ibg/9/iKeHaJH3XgiaaKTmzsrZ4ErS0pguYBKQhT6+tXAspeNjGqsoIIfQ
         hZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVCYCLg46UsQGAtDkD58iv9FBCi6smMFBPQaVj9eG7jBAJFN5GRhxia+rkw18IgwpoqhuYIbi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWx4uxMPOy0G9UuLtjZwZxPG7NLD5ButAMGEqCMGJ3flmGU4b
	xFRGtXY9OenvCc6Vg64S48607NqgXuAUOduVVQdJWRZjYdGDgrNSLgsmdb7WEuSq
X-Gm-Gg: AZuq6aIZd/g23UfejP8cCie06irvTfe8yoE0ycJ3WGyYcIBHjWW8h7mS6gHEK1l2SHJ
	QyB05/BrbFoWob9Uc4BBGIvwdKQJ24HDBRRDffabT+Rj+M2u2TUhftgMZ6U3hCgma5X51hVfP4y
	AY8Wo3PR7zL1kMOpfhKVpyW0g2XAi1vLuyPRE93JREbCY2mEk7VAVC+MvzNkDudV+xRAQ6Te7op
	LSt3RSHrc7n8YxxUDbqMvRdvA8hIVawXGQq1A6xpZecvimBcWCn05NeInk8Z6D+jHNmGSHDjme5
	iZOCPi99hp4tGy/STWyHsnFi87oSBbu/V6czutCw9c2KrEzNtqkYSXuZQ54dcXTZrqjqi/mVZZi
	hmQqd1o/v2jI+rxH88aDz2A+39JVryXSWLOk3t/POL/0YECvdijZSrWXy4lXe5T4TxJGTuRsOqi
	JQ4DBnuejY5tnm3HhFcns8z1NNAVe+sHAhy6UBdw==
X-Received: by 2002:a17:902:f683:b0:2aa:ea3d:a37b with SMTP id d9443c01a7336-2ad50e763b1mr67775945ad.2.1771577020921;
        Fri, 20 Feb 2026 00:43:40 -0800 (PST)
Received: from localhost.localdomain ([119.204.109.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d624esm185489455ad.49.2026.02.20.00.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:43:40 -0800 (PST)
From: James Kim <james010kim@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH] rapidio: mport_cdev: fix sequential UAF in dma_req_free()
Date: Fri, 20 Feb 2026 17:36:22 +0900
Message-Id: <20260220083621.3512086-1-james010kim@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.crashing.org,gmail.com,vger.kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217547-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B31D165D76
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

Resending to the proper list(s), no changes since the original submission.

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


