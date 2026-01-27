Return-Path: <stable+bounces-211731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIrfIUJveGmjpwEAu9opvQ
	(envelope-from <stable+bounces-211731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 08:54:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958490DB7
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 08:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8AC6303B94D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55A30FC35;
	Tue, 27 Jan 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="XU0uhBkJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6831E520A
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500459; cv=none; b=MPyLySgm+CZRty9Y/Vfe3fnIMdAD5HflZmay0GJy8G7oRcI/Vb5JffXBvqdjuZ7HrtHYIPlBeWwZuCsRrNEbuy05hc+5POKozDjPmlb0cOPXYh62l3+CGuLHcLtPf2ryc9KR0zkH4mfKWTH7WU17aCQp/Gu209hu/JkuVJsCH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500459; c=relaxed/simple;
	bh=IDj2ME1e/uh0EgNsFknFveieSdaJ1+0AC0j413GLNDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wn6KBCoJQcVvPAhTnwAIbkALSX4DjCIOdjHCLKoq5ERvPk9vdjowTqYywxwDHOGKig9vekRVQslHEKmiqAB+wLbNO1uoJ/19vWoxzjOnZbScIhTNpFJ3yLAy8yWlXMHsQP2VmSAsYHUt5IDCkN52G1XZW1Tm0nI6gN0uva4BK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=XU0uhBkJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so4601598e87.1
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 23:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1769500455; x=1770105255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/TOyUI3EBD5eIFhAEg5gbtYZU0ZFmEHg7GNAgWzwgE=;
        b=XU0uhBkJzHGqIRZyFlrhhQcdztsht6LD/jPRdOvgvBv4jBDvdDx5ms4Vkk5MA/6m2S
         C+fzchbpkrn50tagtA2H5XG9F4cEdPrgwSvgtbRy7rwtpGT/xrVZ0MDzXcpgfgu7C0u/
         rSJlYZHPY7cZ/SGhI7u2GcgBwaReRQYoVh2L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769500455; x=1770105255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/TOyUI3EBD5eIFhAEg5gbtYZU0ZFmEHg7GNAgWzwgE=;
        b=WRXvFOZ4jWKMisj0o9nzP3n8xYo5H6Emq/7BQGt0zvuy1c5EUhF0qULTtudIyDeM/o
         7p35OEvmnNZokBMHoIZkFV6T7G8dCJ5mhmn5SFgHrOCCvxj1pEE4pFso9hDdeghsYKHz
         f5QGRQmly8LHbJLJ2TyjHBtURBt8T2Y40Hxg4hAACPdqolj1zt9+ZRGMUtMCxzKVwX4n
         wFXp9ZxNjFtomSDY7VHFcI9Jc3v2tf0ovkq7ARqrkoRxiap3HZ2xDbjgPQEHp6Kyi2nT
         1NHQmqtb0rudXtWl+HeHSVSp1tzKCPV69Lg0/klCZYiBZnNjQwiVKQoRpnLcwtY3OXSP
         XVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrN6x1B3BhigFp/cW3jJ6JbgeiqOyXACFlXV13Bh/x2xrAhLgS4jXr66ILFzwC4U+jF0AfMEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaktS2Bv/0ULU7XeI3NLkTZh33DEGLhESkwMin9vzpDRiFHz1
	65gPzegDLn0yNHoTFsYkhlkuxg4TYd08me9M5DEJ2XHXGBNqKl0Als9wIWm8C3w44QHjidmGduI
	2zbD4
X-Gm-Gg: AZuq6aLuThas1nYCJc1cUWB9eFoyN4pxgW3zEJTmGlr+1cPeCZVI+I0TktDsxo4of90
	Kz11mNIF7uiFt4rILxWPDmpTZ1laTBC1kAFGD66bxfrn4AR0ytzIJcMGX6e/tIl1mtjkRz188Nr
	FdKIDRnC5QociKZUPBOzfYQPl5gAX3rrhDLx7gqvYglND/RYDZumVRHa5nD2Qdzh6PjtXd1j1i6
	gxskKmRBra08zLazVbNoL4a0fKDoqpvXzNop5LIshh7iEC6RN80Mc5y6R8AQI1KmsVd98l8lT5X
	JW7bObzYKQgsn7QU9UwjKKKqdtT8lHNa497lVe7M1lu58ytj/6YUBxIFfRqSpI1jv2rFiud62SH
	HOTTUrUgCe6923aaWnrtzayCh9NqI6d2GoBKFkidbFNEYjC8qgi/A1j5smkr6T8RoR3JJUKrXik
	sTHiwkNIuVl9A1YtQGzgbo+gvtciozz3r6tCn6swWrR2QsGfuuBwOgLtw9V1T/WBjb/rabQpjER
	Pq8GjE+DEHY79F0WY1QvqsJYXT7DBZh5dLJ38z9ERe0pMUItSHG2qu87mXkd3p/rRXd3cSzKSQ+
	JCPFY0xWuRQhtT0DhzRkU5RaBMzjeIJXU/gLtwLv46IDEKQUy24f0Ggwwgk89VeECd0=
X-Received: by 2002:a05:6512:2311:b0:59c:bdd8:9d7e with SMTP id 2adb3069b0e04-59e040334admr396059e87.45.1769500455344;
        Mon, 26 Jan 2026 23:54:15 -0800 (PST)
Received: from m5compiler07.. ([141.112.46.27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48df6d3sm3266771e87.1.2026.01.26.23.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:54:14 -0800 (PST)
From: Daniel J Blueman <daniel@quora.org>
To: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Daniel J Blueman <daniel@quora.org>,
	Scott Hamilton <scott.hamilton@eviden.com>,
	stable@vger.kernel.org
Subject: [PATCH] idxd: Fix Intel Data Streaming Accelerator double-free on error path
Date: Tue, 27 Jan 2026 07:52:07 +0000
Message-ID: <20260127075210.3584849-1-daniel@quora.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quora.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211731-lists,stable=lfdr.de];
	DMARC_NA(0.00)[quora.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quora.org:email,quora.org:dkim,quora.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4958490DB7
X-Rspamd-Action: no action

During IDXD driver probe unwind from an earlier resource allocation
failure, multiple use-after-free codepaths are taken leading to attempted
double-free of ID allocator entries and memory allocations, eg:

ida_free called for id=64 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x1af/0x1f4, CPU#900: kworker/900:1/11863
...
Call Trace:
<TASK>
? ida_destroy+0x258/0x258
idxd_pci_probe_alloc+0x342e/0x348c
? multi_u64_to_bmap+0xc9/0xc9
? queued_read_unlock+0x1e/0x1e
? __schedule+0x2e43/0x2ee6
? idxd_reset_done+0x12ca/0x12ca
idxd_pci_probe+0x15/0x17
...

Fix this by releasing these allocations only after use and once.

Validated on 8 socket and 16 socket (XNC node controller) Intel Saphire
Rapids XCC systems with no KASAN, Kmemleak or lockdep reports.

Signed-off-by: Daniel J Blueman <daniel@quora.org>
Cc: stable@vger.kernel.org

---
 drivers/dma/idxd/init.c  | 21 +--------------------
 drivers/dma/idxd/sysfs.c |  1 -
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2acc34b3daff..5d2b869df745 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -167,13 +167,9 @@ static void idxd_clean_wqs(struct idxd_device *idxd)
 		wq = idxd->wqs[i];
 		if (idxd->hw.wq_cap.op_config)
 			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
-		kfree(wq);
 	}
-	bitmap_free(idxd->wq_enable_map);
-	kfree(idxd->wqs);
 }
 
 static int idxd_setup_wqs(struct idxd_device *idxd)
@@ -277,9 +273,7 @@ static void idxd_clean_engines(struct idxd_device *idxd)
 		engine = idxd->engines[i];
 		conf_dev = engine_confdev(engine);
 		put_device(conf_dev);
-		kfree(engine);
 	}
-	kfree(idxd->engines);
 }
 
 static int idxd_setup_engines(struct idxd_device *idxd)
@@ -341,9 +335,7 @@ static void idxd_clean_groups(struct idxd_device *idxd)
 	for (i = 0; i < idxd->max_groups; i++) {
 		group = idxd->groups[i];
 		put_device(group_confdev(group));
-		kfree(group);
 	}
-	kfree(idxd->groups);
 }
 
 static int idxd_setup_groups(struct idxd_device *idxd)
@@ -590,17 +582,6 @@ static void idxd_read_caps(struct idxd_device *idxd)
 		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
 }
 
-static void idxd_free(struct idxd_device *idxd)
-{
-	if (!idxd)
-		return;
-
-	put_device(idxd_confdev(idxd));
-	bitmap_free(idxd->opcap_bmap);
-	ida_free(&idxd_ida, idxd->id);
-	kfree(idxd);
-}
-
 static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
 {
 	struct device *dev = &pdev->dev;
@@ -1239,7 +1220,7 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
  err:
 	pci_iounmap(pdev, idxd->reg_base);
  err_iomap:
-	idxd_free(idxd);
+	put_device(idxd_confdev(idxd));
  err_idxd_alloc:
 	pci_disable_device(pdev);
 	return rc;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 9f0701021af0..819f2024ba0b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1818,7 +1818,6 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->engines);
 	kfree(idxd->evl);
 	kmem_cache_destroy(idxd->evl_cache);
-	ida_free(&idxd_ida, idxd->id);
 	bitmap_free(idxd->opcap_bmap);
 	kfree(idxd);
 }
-- 
2.43.0


