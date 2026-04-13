Return-Path: <stable+bounces-235993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BosOgbT3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:27:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD733EB470
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5829E3026592
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5B3C0636;
	Mon, 13 Apr 2026 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3QAOFnm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66033AF667
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079510; cv=none; b=ptnGKC3u+4VS7GtAQN9DMmcwvLQAnOCVIv9FOgFoXR2ReEhCd7C/sS1V0bXgHmQqNWTq3P/Ie63p9vKdVQ4UE+Le1TZb6mwOUmTn8odqfcf6KGcMD+4XyuhoZG1CSZgb5H4nl4EeE7HUlO4bVHz4g2ZQOv9RpybYtKmklT7x0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079510; c=relaxed/simple;
	bh=NqsU/qOPao42EcOBG6Z9z8WyLUb6yYc5fT28oF/v9TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srWhcmKKP5mCzzMBgxQQdb9pI2FHFx9eVWmV304KqmU6kFNEFcHxQl8yT30tyfsETR1phQiNhi1kI5HwMNgGOv7LmzGAZVvlicrdKv4j97RppnTwScmDYq2X5a2Dsbwj22mavqLZAv83GB3ovfxJtSLS+hUS0mx9Zb//VacQDbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3QAOFnm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2780884a91.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776079509; x=1776684309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFsci77/A4yDoiebbXujv7ZKG9pgAsn7mtVW3rLgh+0=;
        b=L3QAOFnmA9+GBSsZKXL4ZL4Pz25YhK60yfIER7hy1uFhj1drVRt5F7Jfx9IsEndQyO
         IpxZ1KqLonLYhsL/9l3dalp0rGPeMAw69iUCLLveBq1Bcet5bU6UnnMIYsrO7Hz8b3aH
         gqb9kgg6mmPPtgbVuAFWdr5ic5qFkozeEw+EkhwJxKjkEg7n3hi2EnxGARX85d8hS4Ko
         HoMmrSDMnS6YT1+Xu1ruESNyJwNr2whUeb9x+tPmQLBIbCizpLbpmSoogcAXGinpE9TG
         ZjYHGgEhl0hA78YG6J7b1vOZGveC9UTggB6G6Rsy0ekvFgAxSw+n4OtKaiyOLxQfRQwr
         7MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079509; x=1776684309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFsci77/A4yDoiebbXujv7ZKG9pgAsn7mtVW3rLgh+0=;
        b=db6Es8ykxPEY368oi05LcW2eIpkER1CGdhq/68nWC2CBcnrCuSYqa5pnBKedMkow9+
         hTc5d+C7FacElwFWlOjZpnAAH6rNc93//uV3vMHn87vkjKrac9iPNnLgponO3aQa8BDy
         NMGuxw1Mmyh1lzSF4JAkrNZjdQxo48wLfZASNjFKaWTQmMZ/zNw66U0Ny8gLX9NBQcdX
         WbmFke/RJOxHAGQ8209CFE1o0/28o281zab4byfvhLbbbRoRn1N1zGt0CDzZrcR7GnOt
         w/ux2ELhgtV6Wgp2RrnXuvt2leUILXbAEX3wNe0XfFsbBr4+BK9qfbh2rW08tV/+hCes
         uCCA==
X-Forwarded-Encrypted: i=1; AFNElJ+U+5/Cgpd4nvNc102GKcTmHzjlMHvTLu06chItpZ01wCq+t5+fP8DB8q2EQBiey4C8heMGdnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9cxcLnJb/gDUG+OUzn9uekHnY2Pn208tYQRTriBNXVWpbZRX
	XUWVG5M6UaTICsh69fvxkvanNrb3E0Tn6lZV4uKbMTkPKN7if4ARkT6p
X-Gm-Gg: AeBDieuqPZVPGUrIrdymUCj9Vok+p3K+xlbLltiqcaKYv5MV0yWDeWzAt6GIB4G3YBK
	2IUU3plWiRhlrESzjqWIPssuEocImjTIzslG6aSnHwwY+froCCmgbtBVlc2DeHcsfEYRC5+gzE/
	CzwAbRUGO0QvkGCPUXskC/YPg9BmdoBUIM28RToTwJ3G/6Fsgkrs21MOTtvsKSWweGkjl7Kb6sL
	CTiirkElZ2lpyc0DiEzNwStKAiK85l42GNNN9FV5o4CDefOxuGbuKeZroReRZlQhfu6+1QCN8gP
	K0sJsg2tYX3KCmJRG+kJtqlCTWidTazUi3wUKg75EEJPgbjgpJxovhwD/d5O0y4+FS/gcsUn9qR
	nfdofVX3V2sbd/fneUYQUAeGMnDA2g0/v5/k5/qkpieRelKLFtyYj2/Twh+KL2JpqnT3441bk0y
	tLEk2o3sBf3oT9USU=
X-Received: by 2002:a17:902:b490:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2b2d59661ddmr101026165ad.18.1776079509075;
        Mon, 13 Apr 2026 04:25:09 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm116157525ad.64.2026.04.13.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:25:08 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dmaengine: idxd: fix double free in idxd_setup_wqs() error path
Date: Mon, 13 Apr 2026 19:24:57 +0800
Message-ID: <20260413112457.2705114-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235993-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CD733EB470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an error happens after device_initialize(), idxd_setup_wqs()
calls put_device(conf_dev).

The device release callback idxd_conf_wq_release() frees wq,
wq->wqcfg, and wq->opcap_bmap, but the current error paths then free
them again directly, causing a double free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Keep the cleanup in idxd_conf_wq_release() after put_device() and
avoid freeing those objects again in idxd_setup_wqs().

Fixes: 39aaa337449e7 ("dmaengine: idxd: Fix double free in idxd_setup_wqs()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/dma/idxd/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 2acc34b3daff..f1bd9812c90d 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -212,7 +212,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
 		if (rc < 0) {
 			put_device(conf_dev);
-			kfree(wq);
 			goto err_unwind;
 		}
 
@@ -226,7 +225,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
 		if (!wq->wqcfg) {
 			put_device(conf_dev);
-			kfree(wq);
 			rc = -ENOMEM;
 			goto err_unwind;
 		}
@@ -234,9 +232,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 		if (idxd->hw.wq_cap.op_config) {
 			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
 			if (!wq->opcap_bmap) {
-				kfree(wq->wqcfg);
 				put_device(conf_dev);
-				kfree(wq);
 				rc = -ENOMEM;
 				goto err_unwind;
 			}
@@ -252,12 +248,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 err_unwind:
 	while (--i >= 0) {
 		wq = idxd->wqs[i];
-		if (idxd->hw.wq_cap.op_config)
-			bitmap_free(wq->opcap_bmap);
-		kfree(wq->wqcfg);
 		conf_dev = wq_confdev(wq);
 		put_device(conf_dev);
-		kfree(wq);
 	}
 	bitmap_free(idxd->wq_enable_map);
 
-- 
2.43.0


