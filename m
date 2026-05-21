Return-Path: <stable+bounces-253467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bu6Chy6DmrBBgYAu9opvQ
	(envelope-from <stable+bounces-253467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:54:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FCA5A06F6
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E87307FB17
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AB34A3D9;
	Thu, 21 May 2026 07:49:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60E32F748;
	Thu, 21 May 2026 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349796; cv=none; b=WdwvdbMo9WYFi7rc99Z616EXO/CiOavSrKm9SnWMHgBV53zxwisXpRTbiONiMdKNJiQrV69Rh0eEsbzjN5Uq341PEwTQZtE1vUnA2/sRJf6Izz/gKy9fWzbWUBUeLzvC+5/du4SDi80JLmf9hLG1olfqJ4xHXwLPJDDgssE7vS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349796; c=relaxed/simple;
	bh=PicYSaJ/qBBNG0nwnN5yBf7cuvcJTD9f+P4T2OeYfPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2CKEkr7UQmb9b8rkf8tAWjxuG8iHb/vQBC7Il/E4ygVpVawUdhwlIZVDGYD0WMkYrl9rWCOte055MNdGhQvvPd/B2yzrmllZDmMImsX6jSQobEtwq/0jXYmkZ71gFlZDZfkiCPNq4kBlGnGY8o2/BFdC6CU0SWUVKsty5iwUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9e46e66254e911f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c49ba0f4-8279-482d-b201-1e1a9eab771c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:95a0b5a71b1439e7c2a113c3a87243ee,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9e46e66254e911f1aa26b74ffac11d73-20260521
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1010667280; Thu, 21 May 2026 15:49:38 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	thomas.weissschuh@linutronix.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fs: Fix lock leak in replace_fd()
Date: Thu, 21 May 2026 15:49:34 +0800
Message-Id: <20260521074934.49256-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-253467-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 80FCA5A06F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In replace_fd(), the function acquires files->file_lock but then has
two return paths that don't release the lock:
- When do_dup2() fails (returns negative error)
- When do_dup2() succeeds (returns 0)

Both of these paths return directly without unlocking files->file_lock,
causing a lock leak and potential deadlock.

Fix this by making both error and success paths go through the
out_unlock label to ensure the lock is always released.

Fixes: 708c04a5c2b7 ("fs: always return zero on success from replace_fd()")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 2c81c0b162d0..d0f019fb0568 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1361,8 +1361,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 		goto out_unlock;
 	err = do_dup2(files, file, fd, flags);
 	if (err < 0)
-		return err;
-	return 0;
+		goto out_unlock;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
-- 
2.25.1


