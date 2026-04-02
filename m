Return-Path: <stable+bounces-232891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMbuMevUzWmWiAYAu9opvQ
	(envelope-from <stable+bounces-232891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 04:31:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F268382AC2
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D29A6303766F
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F2317160;
	Thu,  2 Apr 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PIVM6dvo"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31C27816C;
	Thu,  2 Apr 2026 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097057; cv=none; b=bkwf2NyogAfz2oz/FecwlxouiC/eBTtyG1Yp1jJvEKjx9DKkkO5VMNyMvJelD/4abqix5xTIh4UxZsZAClYQYCM74CTQpB4AoHSa2COFr3CMvKbK5nuwAv5VVmHQuvG2KYE1+kgYey4/RnsF8NWcXgSwOp9Mun4VmP81J9C6KNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097057; c=relaxed/simple;
	bh=cL9d/g5H2eGaA46MZsWELROvX2hIzGq8tdljfeI/WX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRLdkUUxzjXTq+GatgLjEXstSVtg6Wq3esY/YZy6dy71vAnaAJB466eAAxdyoDFr+4nh7g5u/BoECiJwmO0GDFKhciWbMmETidfLB/P6ibzIEDcLmTidXnoUU76gRC9U66xCVP/kgsP7cjrYu5NleYzUclfxtT/vRHE45XeJ6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PIVM6dvo; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VL
	vZ5+J9fhHIVHd/lJM225n+FUEh9xIZfi616T/QPE4=; b=PIVM6dvoRsMpdsCQ+P
	kUZsAqgOp2PP/HrJU2K3VtJRBiBDbKLfPuP2YowEZQITG8JEhc+b7DQmF8tPwT2L
	ALqD/Kqd5ZbYYjVXKp7h+intPqJh3AWfr/F+jtXoy8x0u6NYgGPTMccxjScVHDvk
	BQHK5y6ioXMJcMGwUJ8A4RttQ=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3313K1M1pZPYoCw--.606S2;
	Thu, 02 Apr 2026 10:30:35 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Zheng Qixing <zhengqixing@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Robert Garcia <rob_garcia@163.com>,
	Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai3@huawei.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] block: fix resource leak in blk_register_queue() error path
Date: Thu,  2 Apr 2026 10:30:34 +0800
Message-Id: <20260402023034.3027538-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3313K1M1pZPYoCw--.606S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fuw1kXrW3ZFyxJF4ktFb_yoW8Gw13pr
	43Ca1UWryvgr48Wr4DCa17Ga47Ga1DKr4xurWfJ34avFZFkryjkr4v93y7Wr18A397CFWS
	qFs8Ar4rKa4UCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_ID7rUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5Qs1oGnN1MtmIQAA3H
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232891-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.dk,163.com,lst.de,huawei.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 7F268382AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zheng Qixing <zhengqixing@huawei.com>

[ Upstream commit 40f2eb9b531475dd01b683fdaf61ca3cfd03a51e ]

When registering a queue fails after blk_mq_sysfs_register() is
successful but the function later encounters an error, we need
to clean up the blk_mq_sysfs resources.

Add the missing blk_mq_sysfs_unregister() call in the error path
to properly clean up these resources and prevent a memory leak.

Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250412092554.475218-1-zhengqixing@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Minor context change fixed. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 block/blk-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c74e8273511a..c2418e9fb45a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -867,6 +867,8 @@ int blk_register_queue(struct gendisk *disk)
 	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
+	if (queue_is_mq(q))
+		blk_mq_sysfs_unregister(disk);
 	mutex_unlock(&q->sysfs_dir_lock);
 	kobject_del(&q->kobj);
 
-- 
2.34.1


