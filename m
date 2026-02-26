Return-Path: <stable+bounces-219754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDUFMcDdn2keegQAu9opvQ
	(envelope-from <stable+bounces-219754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:44:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2411A1171
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0A96304FF95
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0067E38A732;
	Thu, 26 Feb 2026 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Go5eo2ML"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625228507B;
	Thu, 26 Feb 2026 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084665; cv=none; b=gzNgcoSbJhBYxR5IxiZ1xlg2OQnO6Q3IIUZmYklD/4TfLljLkFxAbvb7Jv+ll6utGydnIZbEaMMPfZTfGbZCwkV/E1cdnNZ2ddJ1wCnaUdVZW1ci4Zd8Uv67vK51IVzHrA1hoKPW4SDM0jsEFNWp7K75vCjDvW6qbDhuUjfn+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084665; c=relaxed/simple;
	bh=HJc7nvkLbfMemmCKgahknzd8ZvitN718cGdKwJMAPVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noPhM/n56fwc0K9Mj5TNpwPgZsiI5iOUxpg/2iQMAoWZg4siTZL05hRPfH/2qPaN70w6Qrh0PbPTfn8TmQ9XaRg6J3co/VKywVz2vLuPw/DLUMVMbN2wkpbwI/9xiLgYy7gNMvNHdSwPzNcH6e76kcZF3eLENqwotBW3gpxLOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Go5eo2ML; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MJ
	k0lIo/EBkTI//0tZRrIwd5lphVDWntbKTMM6tu4r0=; b=Go5eo2ML4VDVqLD2/t
	fBcN3hWN/mBjeCuCcmB1w5E9wp9v9SmpUiMPO1y+EfxKYrLYn9Ms6zmoblBO8RBO
	PFGhBPr3eFgY1xWzUBHKgBE5eSL5y03kYOmdH3c0OrSe6vezm3mMFZhj+KX9R97r
	Y6k2qxM+UlQeh/fA5fULVFxus=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHl7yT3Z9pd6VBPg--.35212S2;
	Thu, 26 Feb 2026 13:43:49 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y] dm-verity: disable recursive forward error correction
Date: Thu, 26 Feb 2026 13:43:31 +0800
Message-Id: <20260226054331.945438-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHl7yT3Z9pd6VBPg--.35212S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWfKw1DtrW8uF1rZF18Zrb_yoW5GFW8pF
	Z09a43Cr1rJF4xGryUJa1UZa4ru34Dt393GFW3u3Z29a4Fyry8WryUtFW3ZFW8Xr97WFyY
	vF4qkFW5Zas5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNhFcUUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hXeeGmf3ZW72AAA3U
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219754-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C2411A1171
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
index 1119211a9e78..64ff03ae189e 100644
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


