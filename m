Return-Path: <stable+bounces-227409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCcABDCqvGmk1wIAu9opvQ
	(envelope-from <stable+bounces-227409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:00:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D3E2D4F67
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD49230328B8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70C3128BE;
	Fri, 20 Mar 2026 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KQFdPjaJ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D41DB95E;
	Fri, 20 Mar 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773971943; cv=none; b=VathG3PZyBFua4QEYftZPefSLkAW7Jd9qkrTj0je/xWofEugfDHuq5kcg8g5pfyH1uwj7Ry5vWeakxZxCtzLf5GlqkD/+/sB9A6dtF+Mfgf1qgy8gXPKIq6iUnhyExJHv2aSdTAGWsjK/wvbl9adXCsMar2I05dcwlW7iH2pWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773971943; c=relaxed/simple;
	bh=q7BIV0f9uh9UO6U+lPe/81tyE64RSWoZSgt8NXkumSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwqRjSxQU4t+/wwPi3Q8QJ40QWdwktTI8vDkftcKB5aq8RhzOZk2RBqDL4C01hDAS9dVThlMeBxsEKb5lD0/fwLs7vtMTNSxo2u4nN7imLVH6EabcmK0hHlgtUE+yY/M7Bo5oIjXYJ7BOkoNYETufPdeFcJlLc0BCBoNswvMaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KQFdPjaJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fU
	3gFdWhksndp8ua90z3+ckJW7q7uK0NJ919E6T35Yk=; b=KQFdPjaJoN0MR8rTEi
	VmZGT0GlnG5z+LMorwPSmvOSqZFGh0GJkNUt0sDReI79KmZonqsJxAiy2P63x5WB
	bFRnidW5guK7/g2hVAzr9SXZNiNjiFMkxAHOAF17dMjg8HbTi5YQDgKFi8/kQPOV
	j75ChbX46etRrrGm1uTMlu2y8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD333G6qbxpkTUqAQ--.53736S2;
	Fri, 20 Mar 2026 09:58:20 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Yang Xiuwei <yangxiuwei@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: sd: fix missing put_disk() in sd_probe() error path
Date: Fri, 20 Mar 2026 09:58:17 +0800
Message-Id: <20260320015817.4080359-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD333G6qbxpkTUqAQ--.53736S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyktw15CF1ruF18Gw4kWFg_yoW3urg_Cw
	4jv3s7Xr4jyFn3twn3ur4avryv9rnFgrZYkrsYqF9ay39xXr90gFy5uFnYya18WrsIyr18
	X3Z0qwnYyw4DtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1-txJUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6Rwjs2m8qbwjpAAA3i
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: C9D3E2D4F67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Call put_disk(gd) when device_add(&sdkp->disk_dev) fails in sd_probe()
to keep error-path cleanup balanced.

The issue was found while studying the code.

Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
v2: Update commit message (add Fixes, Cc stable, and how the issue was found).

 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 628a1d0a74ba..aba22060fcd5 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4018,6 +4018,7 @@ static int sd_probe(struct scsi_device *sdp)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		put_disk(gd);
 		goto out;
 	}
 
-- 
2.25.1


