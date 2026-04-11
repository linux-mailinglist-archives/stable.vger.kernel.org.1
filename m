Return-Path: <stable+bounces-235737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VCC/HTNq2mlT2QgAu9opvQ
	(envelope-from <stable+bounces-235737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:35:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DEF3E0AED
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D26EB300EB7C
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4B39280A;
	Sat, 11 Apr 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf8nywKx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818D36F40C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775921705; cv=none; b=OCnXcx4e6KQ5nakGNQnbTmU90PzMAeXoftrcqEyjtNBgU5VJ4sVOFejtc1lM2No+SnELzvXvFBfQ/mqFXKS2fypwjwPYRqhELOv/xVuMEWDo5bar3p/poBWnJq9XThBpahbSWXP1ZpFLozPdDVzV1jWOspD/nvAfORNAv4hcpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775921705; c=relaxed/simple;
	bh=9gn7wIBOcFYMsLzD9sSx+XVudwVdXhut3Y3kl4QYXSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+lsfOoxqXBT4/wYBVGQGtyxf4GXQTD1PvEChQ7xzmilAkERvIz6JD6cOJ9ZJuU0ilIFXub+RlUq2Erx3pkFuKuxMNDprtk2uS/Lm7ty000B4TSrf5uSBArp9r3CpIaN5b+QAOytFO8TLXtLPWGW//bc0tr8oF5HHQfvpgMTO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf8nywKx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b24fede2acso17435155ad.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775921703; x=1776526503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6G9c1hswwZhFnlkchy0rcgR6pUj1NyepQxxTFJFOZMg=;
        b=Wf8nywKxx9RdjYLM9EBkvT5pBlrPXzWwig5/SCk1uPhrDmIrS8SiI4bNzrsaAcuDh/
         xOzktxK3dxQHNG1wBxQQ/SOEXnClMdb74d9NwBqsgemaXk1Pl4J8zReniBlBDt02lcCT
         S9dpK9Sja8MgzqvZ0dFitMX4ZOpM29r00QBaDcgn1xn8EpJZojjHsT8pkq7arlJaVKq/
         ZCVlkIKMHUQKLDf1yYrJFrJmfy58ebfmXMbRQAJXtqfjD9kRH6vzC1X+8uRFatz+LhjW
         tF2XaP6Xy70xOEgzLqmQo8+/fpiZvuTILONNEEP0+PirC3lWfSsjWL0d4IMzhZJ4hNYZ
         o3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775921703; x=1776526503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G9c1hswwZhFnlkchy0rcgR6pUj1NyepQxxTFJFOZMg=;
        b=Nf9pFiqQiZNzUMC/weUMiGsKuhdfxHV30w/01PaLJ33Fi7oaNuha0uDvh7UqPikj5u
         4T3m3tAOaJYyrR23N4Dek6r8Q13V3BY0nmGoskWX3WwjE8+nqA+VyLQ7zklYe8QGZDy+
         aQXjTFA0eQmuM5FXx41bJn7LcKMV42FeJ7WUqYd2rah3+qtgoRFQyOXvTunF86XJOoIh
         xId+z5GmMARPv9UiWQUxtkYzj3oaJQYTgrKlvMFYF6aHZMGAbKs1/N0KZn/zBYcyBBA5
         pggCGlvG7pQzOIbFJ6R4q/PmZLTRrtMvxFGjhYRspUCW6SlKyAOyc4SknORgG1pWZtZM
         B24w==
X-Forwarded-Encrypted: i=1; AFNElJ9h/PpjYOu0+kzkfyE9hzgx6cgBjWSD/F/3nhm+sRqQ401dzMdkSPlVtt/I8CklC9WDdAcAen4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YNcOZAQniW1mE0GR2/1EFKyGj4vh9fSvBzIUz44kmySMY7+Z
	kg/OQqjcQwhEa8hBjSon6O5ZlQBm9seEbKIvV0ZtVNMKquXG78uh3OFO
X-Gm-Gg: AeBDies4fEWESDjP2bpXnhl0/vxbio6XXqfg71zEtx04I5FeuUXBz0pDswjXMdko7cs
	T0LcaNNgaiusk8oIRmyGVFoSRRBCpSGY3FBd5YnHONRQ4jbEsXKnv03IhsNNp0x1qqoJ5qXMt8a
	pVustt/jGc3BTNImRUt7MGeTXbaHO7V52jQ+3e0QVp98/B1gDTIsveDeff62xUraMF0WI5cDVxC
	l/WSKmaI6BgdPFP88huoZnPwfGDFXyeS2L+s2tzzwCu3CXvcJ3VgSaqt0LG0d41dNrz0sQfGOVx
	Ozr27zsVxp9937Uy7j/5Mg0JXwy5v+3qc5KkAiYEYGb6pTX37CTFkTyrAuamBd1c2GdeuIUAoip
	ENWAnjxtdUJ4FZBfwUhLodma7mVjtuGBMXBdllWxbXgLbjysBGqET4hN2iknuoQq/K6IufsQUaO
	IuBoXHlKhtOWsO8WSxYHc8zg==
X-Received: by 2002:a17:902:f785:b0:2b0:7b57:830f with SMTP id d9443c01a7336-2b2d5a5b511mr81392905ad.33.1775921703022;
        Sat, 11 Apr 2026 08:35:03 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d83190ccsm55363005ad.38.2026.04.11.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:35:02 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_cdev_open() error path
Date: Sat, 11 Apr 2026 23:34:45 +0800
Message-ID: <20260411153445.2324473-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235737-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67DEF3E0AED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dev_set_name() or device_add() fails, the call chain is:

idxd_cdev_open()
-> device_initialize(fdev)
-> dev_set_name() / device_add()
-> failure
-> put_device(fdev)
-> idxd_file_dev_release()
-> kfree(ctx)

Then control returns to idxd_cdev_open(), where the error path continues
with:

failed:
-> kfree(ctx)

Thus, ctx is freed twice.

In addition, idxd_file_dev_release() also calls ida_free() and
idxd_wq_put(), but in the current code ctx->id is allocated and the wq
reference is taken only after device_add() succeeds. If put_device(fdev)
runs the release callback before that point, the cleanup is not balanced.

Allocate the file ida and take the wq reference before
device_initialize(), so the device release callback can own the cleanup
after put_device(). For the dev_set_name() and device_add() failure path,
let put_device() and the release callback handle resource teardown.

Fixes: e6fd6d7e5f0fe ("dmaengine: idxd: add a device to represent the file opened")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/cdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f92773..524146b0000c 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -225,6 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
+	bool wq_ref = false;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -280,12 +281,16 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		}
 	}
 
-	idxd_cdev = wq->idxd_cdev;
 	ctx->id = ida_alloc(&file_ida, GFP_KERNEL);
 	if (ctx->id < 0) {
 		dev_warn(dev, "ida alloc failure\n");
 		goto failed_ida;
 	}
+
+	idxd_wq_get(wq);
+	wq_ref = true;
+
+	idxd_cdev = wq->idxd_cdev;
 	ctx->idxd_dev.type  = IDXD_DEV_CDEV_FILE;
 	fdev = user_ctx_dev(ctx);
 	device_initialize(fdev);
@@ -305,20 +310,23 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 		goto failed_dev_add;
 	}
 
-	idxd_wq_get(wq);
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
 failed_dev_add:
 failed_dev_name:
 	put_device(fdev);
-failed_ida:
+	mutex_unlock(&wq->wq_lock);
+	return rc;
 failed_set_pasid:
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
 failed_get_pasid:
 	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
 		iommu_sva_unbind_device(sva);
+failed_ida:
+	if (wq_ref)
+		idxd_wq_put(wq);
 failed:
 	mutex_unlock(&wq->wq_lock);
 	kfree(ctx);
-- 
2.43.0


