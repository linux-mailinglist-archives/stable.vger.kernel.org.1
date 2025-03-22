Return-Path: <stable+bounces-125806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A9BA6CA98
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7A23B1E68
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA71FBEAC;
	Sat, 22 Mar 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="SzR1RtOK"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A21C84D6
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654071; cv=none; b=ZMyYER55YAQG32Vo7NPWJi1gnyzDiCu3ZgG7ik7JHtYJygL19C7prU088Y6uOmOxeMgZkHriMvgxgHpynCrc55HjnVCxMU8jibGBl0vfw6cpfnLgxRoJkDgh6JIKG6I2Goju+Tcd71EVYIytVg5LsdF7soZddHQ3OPEV7HHhTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654071; c=relaxed/simple;
	bh=SmKH4Iui3GNrlbZEM+M9rKkOyuM4nDYorzdGFJnV2eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2NIFGX03mwV6Pu5T8qZenT4KTumDSObIjmqdge2LHx1j0oOJFNJVa2GZxozvscDMGPIWq1CzEqU/8wnYfS2P/gW7jLFiwn7Uksp4fAgtHSM41Y3bw/6u6ySIkbD3ND+UrxCucIcu3qIiqUL/wZWoXPj1G2vGKD8OvHBloTXYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=SzR1RtOK; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id EB0614076164;
	Sat, 22 Mar 2025 14:34:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EB0614076164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1742654067;
	bh=FWOWQlkK/YJBLVOrm5ImfQBFTsyN/MM+f/rPIk0NTio=;
	h=From:To:Cc:Subject:Date:From;
	b=SzR1RtOKPBLjO0i8oUK+/CstRpIfpiaXI5tZCNIygZdTusxXDbik7hUwjhoq/ZfVZ
	 772ICqtpwrhcGy54XnJxhMAkJKV+WlfLJ4ISFyBxsWljvPqpeaDCHeHQ2WkO0VH7np
	 QEaeKcH9bF3UI33szcgL0KHfHRVgj5QpIw7XkTXg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	stable@vger.kernel.org,
	xfs-stable@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Date: Sat, 22 Mar 2025 17:34:11 +0300
Message-ID: <20250322143418.216654-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incomplete backport of series "xfs: log intent item recovery should
reconstruct defer work state" [1] leads to a kernel crash during the
xfs/235 test execution on top of 6.6.y stable.

Tested (briefly) with my local xfstests setup. Additional testing would
be much appreciated.

[1]: https://lore.kernel.org/linux-xfs/170191741007.1195961.10092536809136830257.stg-ugh@frogsfrogsfrogs/

 XFS (loop1): Corruption of in-memory data (0x8) detected at xfs_trans_cancel+0x4d9/0x610 (fs/xfs/xfs_trans.c:1097).  Shutting down filesystem.
 XFS (loop1): Please unmount the filesystem and rectify the problem(s)
 general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
 CPU: 1 PID: 2011 Comm: mount Not tainted 6.6.84-rc2+ #12
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
 RIP: 0010:xlog_recover_cancel_intents+0xad/0x1b0
 Call Trace:
  <TASK>
  xlog_recover_finish+0x7f6/0x9a0
  xfs_log_mount_finish+0x386/0x650
  xfs_mountfs+0x1405/0x1fb0
  xfs_fs_fill_super+0x11d6/0x1ca0
  get_tree_bdev+0x3b4/0x650
  vfs_get_tree+0x92/0x370
  path_mount+0x13b9/0x1f10
  __x64_sys_mount+0x286/0x310
  do_syscall_64+0x39/0x90
  entry_SYSCALL_64_after_hwframe+0x78/0xe2
  </TASK>
 Modules linked in:
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:xlog_recover_cancel_intents+0xad/0x1b0


Link to the original bug report [2].

[2]: https://lore.kernel.org/stable/6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg/

Found by Linux Verification Center (linuxtesting.org).

Darrick J. Wong (4):
  xfs: recreate work items when recovering intent items
  xfs: dump the recovered xattri log item if corruption happens
  xfs: use xfs_defer_finish_one to finish recovered work items
  xfs: move ->iop_recover to xfs_defer_op_type

 fs/xfs/libxfs/xfs_defer.c       |  22 ++++-
 fs/xfs/libxfs/xfs_defer.h       |  14 +++
 fs/xfs/libxfs/xfs_log_recover.h |   4 +-
 fs/xfs/xfs_attr_item.c          | 115 ++++++++++++------------
 fs/xfs/xfs_bmap_item.c          |  92 ++++++++++---------
 fs/xfs/xfs_extfree_item.c       | 117 +++++++++++--------------
 fs/xfs/xfs_log_recover.c        |  37 ++++----
 fs/xfs/xfs_refcount_item.c      | 127 +++++++++------------------
 fs/xfs/xfs_rmap_item.c          | 151 ++++++++++++++++----------------
 fs/xfs/xfs_trans.h              |   4 -
 10 files changed, 326 insertions(+), 357 deletions(-)

-- 
2.49.0


