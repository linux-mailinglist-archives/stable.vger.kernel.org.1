Return-Path: <stable+bounces-148321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F9AC95A5
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 20:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001D31BC4244
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404D278E5D;
	Fri, 30 May 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="kuVmiOB5"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F021CA04;
	Fri, 30 May 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629917; cv=none; b=nKfHUs17wLQUUBcQ6W5OQYh4Z/w1bmvjyAIFwHnp9W49+hZ6R58v4dHvNd20A1rzGwXa4k1y2TJXm1hP92pIkVZLpxDYkuugmugi1+yUpZhPT8osPth5b9Wu8CnM3e9UdziG5spvaY2g0CGYXvkmZNauKX/WAXBgt3cclUXvJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629917; c=relaxed/simple;
	bh=aPPH3O+CHv4ajmf3ZwJW7f8/l7rxbLeOS5vAZZuDKco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9blkTCMc4N2dqB9ZX+xz3+yA5qowsj+ivw5X1oWNVHZ1T6sjpMrFjD1HjwBgu67cDWFHJwxWAOn7c7DdY/PeKYdoKNyp/UL1IqHV5ANjM4TnpNZfxnitHtxtwPmIAQZ3pvOYCOqxQdGQ+1VVC/3hOj/veUtSNC10jfFUeoedBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=kuVmiOB5; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.16])
	by mail.ispras.ru (Postfix) with ESMTPSA id E7E3C40755EE;
	Fri, 30 May 2025 18:31:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E7E3C40755EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748629913;
	bh=bERoEa5XKHntoKi9+ZBgubnw2CNe9D2SUrhr9k4FjiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kuVmiOB5FZ2uXvywY+EeN9pG2hB8B4yLt6lOJARSXYcEuZJ921izS0OtO89F7VnT2
	 ojJRlvdPAb/h9jZbq1r/6fw0+qa/dT/iivWkEoHg6IE1eMJ2PJbbsRD3/9GSY2UKBf
	 i3W1foWChMxbo+2MNMRuiQGEcPODrVLILtoypliI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Richard Weinberger <richard@nod.at>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Lu Zhongjun <lu.zhongjun@zte.com.cn>,
	Yang Tao <yang.tao172@zte.com.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH resend 2/2] jffs2: initialize inocache earlier
Date: Fri, 30 May 2025 21:31:39 +0300
Message-ID: <20250530183141.222155-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530183141.222155-1-pchelkin@ispras.ru>
References: <20250530183141.222155-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inside jffs2_new_inode() there is a small gap when jffs2_init_acl_pre() or
jffs2_do_new_inode() may fail e.g. due to a memory allocation error while
uninit inocache field is touched upon subsequent inode eviction.

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 10592 Comm: syz-executor.1 Not tainted 5.10.209-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:jffs2_xattr_delete_inode+0x35/0x130 fs/jffs2/xattr.c:602
Call Trace:
 jffs2_do_clear_inode+0x4c/0x570 fs/jffs2/readinode.c:1418
 evict+0x281/0x6b0 fs/inode.c:577
 iput_final fs/inode.c:1697 [inline]
 iput.part.0+0x4df/0x6d0 fs/inode.c:1723
 iput+0x58/0x80 fs/inode.c:1713
 jffs2_new_inode+0xb12/0xdb0 fs/jffs2/fs.c:469
 jffs2_create+0x90/0x400 fs/jffs2/dir.c:177
 lookup_open.isra.0+0xead/0x1260 fs/namei.c:3169
 open_last_lookups fs/namei.c:3239 [inline]
 path_openat+0x96c/0x2670 fs/namei.c:3428
 do_filp_open+0x1a4/0x3f0 fs/namei.c:3458
 do_sys_openat2+0x171/0x420 fs/open.c:1186
 do_sys_open fs/open.c:1202 [inline]
 __do_sys_openat fs/open.c:1218 [inline]
 __se_sys_openat fs/open.c:1213 [inline]
 __x64_sys_openat+0x13c/0x1f0 fs/open.c:1213
 do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46

Initialize the inocache pointer to a NULL value while preparing an inode
in jffs2_init_inode_info(). jffs2_xattr_delete_inode() will handle it
later just fine.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jffs2/os-linux.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 86ab014a349c..39b6565f10c9 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -55,6 +55,7 @@ static inline void jffs2_init_inode_info(struct jffs2_inode_info *f)
 	f->metadata = NULL;
 	f->dents = NULL;
 	f->target = NULL;
+	f->inocache = NULL;
 	f->flags = 0;
 	f->usercompr = 0;
 }
-- 
2.49.0


