Return-Path: <stable+bounces-223307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN1vKalgqmmxQQEAu9opvQ
	(envelope-from <stable+bounces-223307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:05:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0018021B9EC
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 06:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192013028B2B
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 05:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2D366815;
	Fri,  6 Mar 2026 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WfMiDJSU"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B81D5141;
	Fri,  6 Mar 2026 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772773540; cv=none; b=lGR5rM6wsWPoJpkrugmkOaOjLTavAtRLo8HT5YEJOW0E7pRVS8vgTl57+/T8mfLHRMehP6stYAgXqaOdZW78v+gZXQ4bC69B2fprMMc/lzGqKatkjdK85z9OuCjKgn2RQujoH1QDgn+lNv1fspCx10xrnJE1wKh3m6c75uRNdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772773540; c=relaxed/simple;
	bh=MXdCqykNBi++6JAkj/eEXsUiF4er8/fECzYm7564Kcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OlEbldsKgMfLxVFZ6qiUEQD3zf9p9l8KZdfQpnEmz9wwL5g1qrZFM8+8MWYudcOHok72hYJlbGAQ46ky67LrOnpf1Ie+kp2VF/xJJOmNIfs0C9sO4XRpG68h9tNrNIPBMbgXUnqHWOtEdTbTndkh0naWu5TTCnmoze7rnVgwYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WfMiDJSU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zC
	9l8baCUS7gCT7xvhPz649icmxJifRfM6Va5tEJ970=; b=WfMiDJSUtKNp9YKWM6
	wm+aose9FSFHFrcC8qgtVlvUs1m1rgetOpzME6NtxdKCFVWb6oq+th6g01yCfFCZ
	g1Cqh9/0I2DWmZ2H0Vryodgk6C1UDAyq0Jf8m6KtKCMU+0GXkAUaFwd5XkBDjG2H
	GL3lb9/59gAfclM7lC3QM03aU=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXP2uBYKppaWxBPg--.56238S2;
	Fri, 06 Mar 2026 13:05:06 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.15.y] f2fs: fix to trigger foreground gc during f2fs_map_blocks() in lfs mode
Date: Fri,  6 Mar 2026 13:05:04 +0800
Message-Id: <20260306050504.1395421-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXP2uBYKppaWxBPg--.56238S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF1fCw4UZr1xXr47Xw17trb_yoW8uw18pr
	9xG3WfGr15ur1rWa1vga18uryFkayqga1UJa97uw1Fv3srZw1fWw1vvFyfWayUtrZrJr4r
	XF90kryrt3Z8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEdb17UUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3QI91mmqYIJtYwAA3b
X-Rspamd-Queue-Id: 0018021B9EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223307-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,163.com];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chao Yu <chao@kernel.org>

[ Upstream commit 1005a3ca28e90c7a64fa43023f866b960a60f791 ]

w/ "mode=lfs" mount option, generic/299 will cause system panic as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2835!
Call Trace:
 <TASK>
 f2fs_allocate_data_block+0x6f4/0xc50
 f2fs_map_blocks+0x970/0x1550
 f2fs_iomap_begin+0xb2/0x1e0
 iomap_iter+0x1d6/0x430
 __iomap_dio_rw+0x208/0x9a0
 f2fs_file_write_iter+0x6b3/0xfa0
 aio_write+0x15d/0x2e0
 io_submit_one+0x55e/0xab0
 __x64_sys_io_submit+0xa5/0x230
 do_syscall_64+0x84/0x2f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0010:new_curseg+0x70f/0x720

The root cause of we run out-of-space is: in f2fs_map_blocks(), f2fs may
trigger foreground gc only if it allocates any physical block, it will be
a little bit later when there is multiple threads writing data w/
aio/dio/bufio method in parallel, since we always use OPU in lfs mode, so
f2fs_map_blocks() does block allocations aggressively.

In order to fix this issue, let's give a chance to trigger foreground
gc in prior to block allocation in f2fs_map_blocks().

Fixes: 36abef4e796d ("f2fs: introduce mode=lfs mount option")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ The context change is due to the commit 2f51ade9524c
("f2fs: f2fs_do_map_lock") in v6.3 which is irrelevant to
the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 887e286d2c32..04e278b50da8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1523,8 +1523,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	}
 
 next_dnode:
-	if (map->m_may_create)
+	if (map->m_may_create) {
+		if (f2fs_lfs_mode(sbi))
+			f2fs_balance_fs(sbi, true);
 		f2fs_do_map_lock(sbi, flag, true);
+	}
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-- 
2.34.1


