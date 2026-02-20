Return-Path: <stable+bounces-217533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FlgOkzel2mo9gIAu9opvQ
	(envelope-from <stable+bounces-217533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:08:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 433781647B8
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D3C301D041
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266382EA73D;
	Fri, 20 Feb 2026 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVmm7e5E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA018C03E
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560519; cv=none; b=AzYnrZ4pO+6KkRs1P4+6dvtd+IxeIVRZiNG5XR456a7s86pktq+txzZSTDkSgpvtq8N1FufvePx9wUs5gpivWr8x9BZ7z0zEPr/wx5OGrdTKbJeRmQfuKvqZGo1tRRQobgITbWnrwDMHBPMUSfXwSul4WwMR66h49aei/cU+sPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560519; c=relaxed/simple;
	bh=X9nyxuKKNdw/f2Cr0gglwQVAdwQkdbyMaqw0ma20qqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFluKFkh5/BbsA8eyc3CIVS4gPVpQ5+5n9CEe4XVrm6YiRL6MIHtZ1QpQI0vUJScj7pZOQt7K76v4/KBzgE1N+vFi8tY+CjVXtJI/Ehp7wEGwGIpDnmAOY1xlR/z+rxFPD9EDzXEu5oKRIyuT+MfLNcjdqiVutDlFb2INm8HeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVmm7e5E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aad1bb5058so17111715ad.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 20:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771560518; x=1772165318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLPEN8v/3SiiZJuSZOW+zFOJFkwusotrMcDYEPJXEGE=;
        b=kVmm7e5EzcBKE7c5vddoIYdOsd3ZZcZoa0i0a+pgR51oLQe0ljSlHPEmB4DqKZzpYC
         AHwCFVESCll38sYlg7FAtscIvj69yOdXI5Qd4tBKySWQ8rgbTLnP/NfJZ+YYz0LGwmnx
         SQFDjZzr5rpsnUuv1QyPHHl7VkzN3/8iwHyYr5T7TO53U0Fpu/8IpnitdkGhTb5LO4LG
         8KatONmFFmqsYQPa/B8QNA9bqphe8UiI7ve0f8+/f2/8/oMl8VKQGgZfZDLxTz11nzFx
         KTmcdS2Y2OgxQccd0XNO/O0huiS9vSYA/N2tDXUm/Rv6DlIT0qkhXGUH0k4y/nQFpXtd
         upzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771560518; x=1772165318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLPEN8v/3SiiZJuSZOW+zFOJFkwusotrMcDYEPJXEGE=;
        b=HsbpZnc73xi+p6Mal3ozq1Xu/W10sTV2smZzTDJwILe4S+Kl3r3sxMmXhTeCUUNeoF
         ja9o9yar1NbSx00OcAiwKPqG31O78aXXuS7EAde085jG+Ht+bKIHgWkkn3u+f5qk4aXX
         AFRsXMcxWOnkjvN8b8YW8KVEXjD+csuwp4KNCqQZlor6qOkk3bLuozK4osRyUHfutuSU
         bIC0kw0nbOk1e7Ik8ctOK0Ixr5Q+vA1+AOdXj5Kp7Fbh3kQf29tkFVS48RGJzlvZDzIT
         MHM9UYZqJS0nRpZ5VcF0T1czfKoEZIgUNjwBxMi4mqJXye/dNiDKWJxOjbFGeK6mfttQ
         ZVgg==
X-Forwarded-Encrypted: i=1; AJvYcCW97qBbJHKHJRTMpRW5EPdEuI8GP2OLYDzYEH9cU3liGLn3eq0IsD+6U7HwifbC8WosiZFTrOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4CFBGYQhxRPQtbOMmSjngKYP7YhfmWZNLPdABmOWaDo7DDuZ
	dKxrpjlbkdUp+Hz8JxMkVGlyKx1Sebs3Nk7eq0jOfZW3mjGcCpsOvZuE
X-Gm-Gg: AZuq6aI8nf0sgBYi3gNrrSVNpmm2EuTmTmgcNF7DeznCDu8YEP+aDjod825zKgHSKVL
	OSJGSx9QGc65eFB6dqGUfmqATf4djK4oa5CYSVdjRP5SIh2Cqo+Vu5u4GMuEkJ6GBppmWdkVWUL
	F4waCEPiEWaryr6sc2xCRQbH2t5+72+ouQOs08YGgFGWTjZOd4pHPrWFQruvWIDj2DUisrwIyWo
	0j1dox1NPcYJidYsRxWhXfukfXhV0yB9o1z8+OvkyXWkppQrGPgmrWajYGh16kOoCY7BwejlobZ
	QhMCKI7jmveRd4SlPxEJ63VohoGV/Ot3BkjXlYWLMx3wR2yZdeGSqwhyk/828JctfjVESO32Ohy
	IAg5kNiFuzEBsghWVnUfwrCkz4cmTN77g9RWP1ue6gCXQD/Kd9rdLJ8vTNNlpVPptmeHq3GwRkB
	fHaRAKkhvNzxqfpUTf+XM0DUqqk5/dc00T5cHmJA==
X-Received: by 2002:a17:903:1248:b0:2a9:db7:446d with SMTP id d9443c01a7336-2ad50ebb1abmr74415515ad.22.1771560518094;
        Thu, 19 Feb 2026 20:08:38 -0800 (PST)
Received: from localhost.localdomain ([119.204.109.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bbcsm179223655ad.56.2026.02.19.20.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 20:08:37 -0800 (PST)
From: James Kim <james010kim@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	James Kim <james010kim@gmail.com>
Subject: [PATCH] rapidio: mport_cdev: fix sequential UAF in dma_req_free()
Date: Fri, 20 Feb 2026 13:08:22 +0900
Message-Id: <20260220040821.3511683-1-james010kim@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-217533-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 433781647B8
X-Rspamd-Action: no action

Hi,

Resending this patch to the proper list(s). No changes since the original submission.

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


