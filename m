Return-Path: <stable+bounces-236106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ERdFSj73GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:18:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C93ED373
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25002300B9CD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C923D6CB5;
	Mon, 13 Apr 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWkJp4jQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EA3D9DCD
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089893; cv=none; b=c+ZKtHDSMkt4SlnZPyDDcI71jb+f9zYzlcwbQppUWDZ5/kZp7Kn86uM7TYCqmxfsEeMnO+E9GTqIkgdMZC3PgtBC+XGnazxlJ6T2tPu5Wr5ILTC8u/sjnDd9iuqy9J826mDdl4kLz3nbdJT+oSKzA9H5J6YUux9IApd79oAoLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089893; c=relaxed/simple;
	bh=52DKUzSfxH+6to29E7Q2NvM2A03f/yaUTaPX88jYODY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G92FDhq+kVL3p7Bg+aP3b6FgK0FhZvvoEmdV+zTGCFwixfGWZrMV49E8NPuKKGEcdivlmEcWMGUcaqgRj+QxdCrr+hHrDCSzDodbEnAmCx8UckSVBPs54hBVc5XcYcRo/8cOHrfJA2M6q3aFtFbGyt4XLFyAd88b9/UkzkUYelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWkJp4jQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a655cfab5so3791721b3a.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089891; x=1776694691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfCfEoCQ1xm5a/h4AZyKBHqio5jzH+2E+QVtjsmZ74I=;
        b=WWkJp4jQSPraWUxImI3DQxRZZvH5Ll/waxg5q30om+fk2RR+qVSGqqANLLcPXZ4pCd
         wmfFPw7qqi1J42IeXz71VlekiEU0h97v02gEqjaB1z3OxlH/GNzITnkzJBM/ocCsaPhf
         +YN6q7Wpvcqw/ZEITXtD6VCdBB4y8M7i046QYdff5Ewu41hsdGKm3SqkDobWizNLJMTU
         6TyT+Cl6U1jZ7Ko9FcIntsTPSTRr8ykVlBTaKanWc2o/sxBBmJjjpKSOj73FNdlUlN0h
         /GFYCzPLmtLgI46Ywf0S6gmO0/P6eUyw/9qOtbS5VwzB1tGUczdCfIhM4+VdrEL8OqpZ
         zF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089891; x=1776694691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfCfEoCQ1xm5a/h4AZyKBHqio5jzH+2E+QVtjsmZ74I=;
        b=G7OPcGaYhOrnHS4s1l4lghGYfrXbouoPmMKS7MWc+aAlOMRqiwHTAKspMJdZVIkCAm
         CQbaZo7F0NFyGqbT0NcGMwMkFW+AeXAo5dOZ+wCy34UH/b2pHwH7DkENmXOCQdxnRZF3
         TnoJ+hIBW/ROHPKWPc4o5y0fqc9Y6vk+Fwq3yMFA4KqSoxUMZJLzYmFshPDyLLbixY6r
         by41wUBOaDrgfDf5MUzj5k/Fo9yGD976G/glAckp3FE1znYoP1wEiBsP6a7eAD1+q0xN
         +zL7RcHSpLNeCWFkST7yUinQxQrwndw+v3WpGwqgt3xxWcN4ruKcvQ6Ay+NDNQM0QSSO
         iUEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5qwER3ZjPWIzCP8dQ3VIGhad12we1ykZPB+k6fdxZmh+FO6/P9/HVRaXw2xp1HLiEbhbaVBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpDmDmapAX/Jm2R1GkZqp90RAksm9yuZngxbzDK97eD0vK+6F
	UZPAaXrQ/SuhVQ37jWg8H8GCP2gdS3ImaOcQbfW22JcFhCrOh0mt4nzn
X-Gm-Gg: AeBDiet2v1x2aKl6D3D9J9R37h43ds6w+tV5P1yGHf1tJ5pFLt3DG38quc/Kx4Wue9n
	SOmO/LcGZOguhL/1nKtQi3cKkokT2ycEbUORAG0RSTKxuwF0OvlGeOL2PxcD3zvI++K95wasg0E
	vJfavkP0JTALC1lBmzgkXSWtvyGiMhLJAGuALxN1wm1XqY6LvGwyO4kLEUqem44K+rnkNZQLN/H
	H/UC1pPwC4bfwNm6HjpONf5RmzWqjU5yFwYwIJPidmLIA3rXMY4AjZvI3rJNCzWHwfpaBbr05Qk
	nb8BjNxyAb11oZd87QAsUDumD7NEmYOLa+B90TiRrwqmTF14QwpMYUu5Zo3nOXGEY+kQWu7r7pe
	YAHxC6xnCbPxD8r9zqmri05n2F07rswm+YHbeHaxXqICFM/PMIZNROrgFoRp2TEPobcto6yKq7X
	uqSYAhPEC9QkW62MipBGfjV5uaT8F4cEI=
X-Received: by 2002:a05:6a00:a116:b0:82c:e0d7:2682 with SMTP id d2e1a72fcca58-82f0c2a72dcmr15538886b3a.25.1776089891310;
        Mon, 13 Apr 2026 07:18:11 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c377318sm10978531b3a.26.2026.04.13.07.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:18:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] md: fix kobject reference leak in md_import_device()
Date: Mon, 13 Apr 2026 22:17:59 +0800
Message-ID: <20260413141759.2970973-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236106-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F22C93ED373
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

md_import_device() initializes rdev->kobj with kobject_init() before
checking the device size and loading the superblock.

When one of the later checks fails, the error path still frees rdev
directly with kfree(). This bypasses the kobject release path and leaves
the kobject reference unbalanced.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

After kobject_init(), release rdev through kobject_put() instead of
kfree().

Fixes: f9cb074bff8e ("Kobject: rename kobject_init_ng() to kobject_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/md/md.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6d73f6e196a9..4ce7512dc834 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3871,6 +3871,9 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 
 out_blkdev_put:
 	fput(rdev->bdev_file);
+	md_rdev_clear(rdev);
+	kobject_put(&rdev->kobj);
+	return ERR_PTR(err);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
-- 
2.43.0


