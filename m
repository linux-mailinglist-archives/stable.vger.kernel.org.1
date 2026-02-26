Return-Path: <stable+bounces-219751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILwoGZjUn2nZeAQAu9opvQ
	(envelope-from <stable+bounces-219751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:05:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF01A0F77
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94E543076487
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F222C028C;
	Thu, 26 Feb 2026 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kksHbjBD"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585A45C0B;
	Thu, 26 Feb 2026 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082322; cv=none; b=GNtPzA3lMvk3J+WELgFvk+YrSonmzEEEoqqLP1YWoPSomk1Uko8qJkaHfGkrismmX6vMMgNa9P9ir8z5FCEAII91n5T6Mym5ByOttLk+MqN6vo4SFmDXwjlO76mwUDZ2IR8ZbbZcW5jPxPJ4D7DtGMsZECAIAXLfBAB/JNHEoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082322; c=relaxed/simple;
	bh=kwBh37NANwcXhc2TtJ61Oo+5M4kdUfSb+k5fFH9upZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9sOys7pzRWjvlt2PMlglGE5RkcuHJXhMiQGrk+51Y21l3ClzCK9OKfbuYgoTszADzZqIitDAgg/6cSQ/epdWquSauczY5fnEo9TGqK2kou+eQ+nrCsQCZXHz8RzWsWcTMhKOFlCh7vURTRjYu0g3A4x5tDhXTuDOklgLz0KMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kksHbjBD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nE
	E27e8uG76RjHLoTbC/alv3uxT1YhabsN0M0uUxzNI=; b=kksHbjBDFwp/dEfPs9
	bckbLd4DJZYBQXyzQNQpi3RubpAGxToPN5tftWvp7nrlNwPjQotfpHuDb51xYmAP
	LVcn/hyHLXBnqH7WVGGqkwg74SJCQUSznEJlo3y0cM7276II+g+EhOwlAXZwBw1o
	nHfVZz3BgdDqK4sbHDzDvwwSU=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBXrNBV1J9pvRs+Pg--.2127S2;
	Thu, 26 Feb 2026 13:04:23 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] dm-verity: disable recursive forward error correction
Date: Thu, 26 Feb 2026 13:04:18 +0800
Message-Id: <20260226050418.159241-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBXrNBV1J9pvRs+Pg--.2127S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWfKw1DtrW8uF1rZF18Zrb_yoW5GFW8pF
	Z09a4fCr1rJF4xGryUJ3WUZa45u3srt393GFW3u3Z29a4Fyry8WryUtFW3ZF48Xr97GryY
	vF4qkFW5Zas5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNhFcUUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3heMJmmf1FdMgAAA3a
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219751-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,google.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CECF01A0F77
X-Rspamd-Action: no action

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit d9f3e47d3fae0c101d9094bc956ed24e7a0ee801 ]

There are two problems with the recursive correction:

1. It may cause denial-of-service. In fec_read_bufs, there is a loop that
has 253 iterations. For each iteration, we may call verity_hash_for_block
recursively. There is a limit of 4 nested recursions - that means that
there may be at most 253^4 (4 billion) iterations. Red Hat QE team
actually created an image that pushes dm-verity to this limit - and this
image just makes the udev-worker process get stuck in the 'D' state.

2. It doesn't work. In fec_read_bufs we store data into the variable
"fio->bufs", but fio bufs is shared between recursive invocations, if
"verity_hash_for_block" invoked correction recursively, it would
overwrite partially filled fio->bufs.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
[ The context change is due to the commit bdf253d580d7
("dm-verity: remove support for asynchronous hashes")
in v6.18 and the commit 9356fcfe0ac4
("dm verity: set DM_TARGET_SINGLETON feature flag") in v6.9
which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/md/dm-verity-fec.c | 4 +---
 drivers/md/dm-verity-fec.h | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 4474352ad3d1..eda646a0d237 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -439,10 +439,8 @@ int verity_fec_decode(struct dm_verity *v, struct dm_verity_io *io,
 	if (!verity_fec_is_enabled(v))
 		return -EOPNOTSUPP;
 
-	if (fio->level >= DM_VERITY_FEC_MAX_RECURSION) {
-		DMWARN_LIMIT("%s: FEC: recursion too deep", v->data_dev->name);
+	if (fio->level)
 		return -EIO;
-	}
 
 	fio->level++;
 
diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 8454070d2824..7a73866f727d 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -23,9 +23,6 @@
 #define DM_VERITY_FEC_BUF_MAX \
 	(1 << (PAGE_SHIFT - DM_VERITY_FEC_BUF_RS_BITS))
 
-/* maximum recursion level for verity_fec_decode */
-#define DM_VERITY_FEC_MAX_RECURSION	4
-
 #define DM_VERITY_OPT_FEC_DEV		"use_fec_from_device"
 #define DM_VERITY_OPT_FEC_BLOCKS	"fec_blocks"
 #define DM_VERITY_OPT_FEC_START		"fec_start"
-- 
2.34.1


