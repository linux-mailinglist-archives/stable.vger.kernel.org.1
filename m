Return-Path: <stable+bounces-223164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGJ2JxznqGl+ygAAu9opvQ
	(envelope-from <stable+bounces-223164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 03:14:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E010220A1F6
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 03:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D1E305E9A9
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 02:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E524DCE2;
	Thu,  5 Mar 2026 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b+N4O5jQ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57016218EB1;
	Thu,  5 Mar 2026 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676886; cv=none; b=R289jYQuLdpY3MUpRZpd+VevMVDQKT94b3/GCbuZ5d0j2cnU3JkI7h8zsV861uXdIIwN+mLZ0bxEj3jW1JoADwoHNuM6lsVTmRhhmH6FuikXFa/5zJxq50DRrs0nbvgh0nendzm2Y1v19/2GcMgaqYn7H3wPtrOqAFr1HCe9QIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676886; c=relaxed/simple;
	bh=s1ocLErcAjuwF4nelrw6ep/ytdRjDP+3h0fLK/z0sK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=csBDpnnCWSBJNppAHGoCsEDR6vW6Siux8gpvmh/26FNkuhB/Ra7C678KTNNJ/+cSxzoKeXU6v9vnm8tnJ3UAH6qYys+E6IBK4Wt5G+XRGc9iyNojirP5lLM/NZ8XQ+f5tOlvP4J5GWdyyHtWHZ6zOyQeOk/D7yXuR29ybiZvdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b+N4O5jQ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bv
	FMvfmFv/PpBCw8PUJrWR0vV7noWZJWs5tu0GeSyo4=; b=b+N4O5jQpww41uCtpZ
	LvZ1hvffy9PXFzt5SU7qsAY7ndxmnf9Ovelep/izpOUIA2KilhlRmtqAicTyK6KM
	l3fha32Wf84YAdOfKUgfz2YFyPOVPlN3Dj8YzoM2k8vCogNxZ8nMVZ1hpXDizeuz
	Kx28VGtohcSu7QE5TVmpduzhw=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3d6X65qhpi1O9QQ--.39033S2;
	Thu, 05 Mar 2026 10:14:19 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y] ntfs: set dummy blocksize to read boot_block when mounting
Date: Thu,  5 Mar 2026 10:14:17 +0800
Message-Id: <20260305021417.3956903-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d6X65qhpi1O9QQ--.39033S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1UKr1UAr18tw1UtFyUGFg_yoW8Kr4Upa
	4rAF1fCrWvgryUZasFgrWrXwn5W3yvka4DtrW7Xr17ZryxK3WftFn7tryfXrWqvrW3XrZa
	qFn8ZFWxtryUuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zuXdYAUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC3Rt8Fmmo5vt+YwAA3t
X-Rspamd-Queue-Id: E010220A1F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com,paragon-software.com,163.com];
	TAGGED_FROM(0.00)[bounces-223164-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,f4f84b57a01d6b8364ad];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,paragon-software.com:email]
X-Rspamd-Action: no action

From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

[ Upstream commit d1693a7d5a38acf6424235a6070bcf5b186a360d ]

When mounting, sb->s_blocksize is used to read the boot_block without
being defined or validated. Set a dummy blocksize before attempting to
read the boot_block.

The issue can be triggered with the following syz reproducer:

  mkdirat(0xffffffffffffff9c, &(0x7f0000000080)='./file1\x00', 0x0)
  r4 = openat$nullb(0xffffffffffffff9c, &(0x7f0000000040), 0x121403, 0x0)
  ioctl$FS_IOC_SETFLAGS(r4, 0x40081271, &(0x7f0000000980)=0x4000)
  mount(&(0x7f0000000140)=@nullb, &(0x7f0000000040)='./cgroup\x00',
        &(0x7f0000000000)='ntfs3\x00', 0x2208004, 0x0)
  syz_clone(0x88200200, 0x0, 0x0, 0x0, 0x0, 0x0)

Here, the ioctl sets the bdev block size to 16384. During mount,
get_tree_bdev_flags() calls sb_set_blocksize(sb, block_size(bdev)),
but since block_size(bdev) > PAGE_SIZE, sb_set_blocksize() leaves
sb->s_blocksize at zero.

Later, ntfs_init_from_boot() attempts to read the boot_block while
sb->s_blocksize is still zero, which triggers the bug.

Reported-by: syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
[almaz.alexandrovich@paragon-software.com: changed comment style, added
return value handling]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
[ The context change is due to the commit c39de951282d
("fs/ntfs3: Improve alternative boot processing")
in v6.8 which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 fs/ntfs3/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 674a16c0c66b..7cf52b70987b 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -693,6 +693,11 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 
 	sbi->volume.blocks = dev_size >> PAGE_SHIFT;
 
+	/* Set dummy blocksize to read boot_block. */
+	if (!sb_min_blocksize(sb, PAGE_SIZE)) {
+		return -EINVAL;
+	}
+
 	bh = ntfs_bread(sb, 0);
 	if (!bh)
 		return -EIO;
-- 
2.34.1


