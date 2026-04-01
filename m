Return-Path: <stable+bounces-232744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKe9KWTpzGk/XwYAu9opvQ
	(envelope-from <stable+bounces-232744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:46:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036F377ED4
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C782305B344
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3F3D16E5;
	Wed,  1 Apr 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss2mXuD4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D753AC0ED
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036465; cv=none; b=q4x6Pj/eIW0kvtpEixlDJpjwhzxJirue2ewxDMOlFyqTjiESQ2edz/AMXrisVT68ZFgpLY2XjwMAvoZCJv1Sd6f7dvirGIMlpkks3wo9CPJduXQ8+mFZUhEEGa4ilxpFGJmEoaNJeHwzujg/S0sYEoYLHTkjjzUfVoy7YPuNBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036465; c=relaxed/simple;
	bh=OYYUWkgCxAQGpQCSIvAQ1bkD3r6IuE5Qn3pidaElBqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOO1JU7CktJYYE1beMM6qSKOBzk0M7P2Nc1b/VjvoRkgxo5QWjObP99WOIWtBBKf6GxP3KOcVmOBA9DLHJs9YoO8KILlg4BebmMtFdHBK95EFfif5UugA0jYp189a6qyP4OhrcPImvTPiGkytZe1WXHCoBHocDvrYZtHm035QD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss2mXuD4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1342385a91.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775036461; x=1775641261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RO4ZhYSZqYOFn/guHJmRqbXOWS6aNnS9NZJLkKz5OII=;
        b=Ss2mXuD4qD61P+GugJKl1FNimk0k84zHilguKNwscc0FoGm+EOH6VFaKhQSibXg4wC
         ZXf1B7oDno1nvem7exL0sJ7N6YW7GO2nd/HdpOB/Ks5sx/rbcgqoS5j7qfwcrMAg9PsD
         dBxRLQwAfZM9KMB8f3JuxE7QHZyhHEsbBRnf4UhgU24rV+chWFhZPVeaMo8to4z/ny0E
         NP4VPUgX4fCuHHwjGdaoYrJCxi61aTZnJ4+vCgVB4cMUEBrXI914UWybIHpqDoFbVvTA
         zun2hy/eYeGtStOTnmdinAvHeCiHmzOsp32zflyAiuBOPkTciwbTI/wtR1hF7frtqBBk
         TrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775036461; x=1775641261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO4ZhYSZqYOFn/guHJmRqbXOWS6aNnS9NZJLkKz5OII=;
        b=PiO8PlTWiit69Z8ZBM7etqyVs+rTLTyC9BLIR6SdKeEFRNVD6qs60OfMigDrRHoIfM
         hB2nvuzXpEaKuD5woPCZbOhsNI/X43VJpUvuhy4Be7dW329X2gxZtOLNbwaaMtmHDaiC
         yzwAzfaxAIBuhmxYUbbB9mglKEsNDJeIKh9DKt317M7H9eSwxgKKOyMuGog3n3maN4Sz
         hUfokSBeLsfeonJz+l9hvuXF587qdzctA2DqW4dlnfJ1uTsYpRFOFBgP7Zk9h8dYErfW
         1q2TZPPcHNjK0ocUkJp9pk2enY6jtF/cKRRz8vUBMzZFmxHKlEhTy0Y5DvdhzxQz7n0Y
         rHuw==
X-Forwarded-Encrypted: i=1; AJvYcCWM9FHm7v/41RrDggAoHdEFOYmDvZlumiwrxMiibzAZuxeeJ/5/7S+nJptLkRD3pC7OVNI4qYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtt+hJ7M/q/IrDaQ4ZepgySgkFLMeoVvPM7F8o7S/mgpEwpBTT
	FOs4TiT5QuvYS6ltWUACBXzvcYz2aXUokyT8OkxtUnNU8g640TjaSc1M6zbBHm3nuVo=
X-Gm-Gg: ATEYQzza8bapPGVEN0rlF4aWPliB7bjr78RXWi7PjYZgbZJOF6XKtfXbBHrFkL042I6
	X5JPDZzwsQP1g0sLMtIbnQ5becKnMicZyEHPgeP6wQAIeG925AOepkeB0ECRRKxVE/JE2zjA5v1
	1wD95jceUGcO7weVC0Tn4bwfvewYyexqKF3lBAFx54VJ7HaEGbB4xhm/epTUz5R4jdjofwy/3WU
	TeFKojk6r+GNfojhVpDUfpOZNME9KHeHrLkUNNH0WU25aJJWf+DZkWK0rCEEl4X+JIbiDb8u+0B
	P9zxFj56q8GrBSRuALpcoyfWvVshkfh2kqN13kmmnCBDuIvfa0ghMSIJtOQwfve6Rut4d9Fdg6z
	2OmvKq7JuAQIfusFQKZyKg6jZb/56QyGTsq+WPryOQmuclrB0wpKyR9CUoSq/6FQa9ZXS6waKq9
	CDWuJLS7MaVKWvb7J8IfJ4
X-Received: by 2002:a17:902:7610:b0:2b0:6365:21a9 with SMTP id d9443c01a7336-2b269c3f058mr21308135ad.31.1775036461375;
        Wed, 01 Apr 2026 02:41:01 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642913sm140147225ad.10.2026.04.01.02.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:41:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix double free in idxd_alloc() error path
Date: Wed,  1 Apr 2026 17:40:03 +0800
Message-ID: <20260401094003.1482794-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232744-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2036F377ED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When dev_set_name() fails after device_initialize(), idxd_alloc()
calls put_device(conf_dev).

For these devices, conf_dev->type is set from idxd->data->dev_type,
which resolves to dsa_device_type or iax_device_type, and both use
idxd_conf_device_release() as their release callback.

That release callback frees idxd, idxd->opcap_bmap, and releases
idxd->id, but the current error path then frees those resources again
directly, causing a double free.

Keep the cleanup in idxd_conf_device_release() after put_device() and
avoid freeing idxd-managed resources again in idxd_alloc().

Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/idxd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 4eff74182225..94ce52565e7a 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -635,7 +635,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 err_name:
 	put_device(conf_dev);
-	bitmap_free(idxd->opcap_bmap);
+	return NULL;
 err_opcap:
 	ida_free(&idxd_ida, idxd->id);
 err_ida:
-- 
2.43.0


