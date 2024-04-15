Return-Path: <stable+bounces-39507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C888A51EC
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F7BB2603E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84878C69;
	Mon, 15 Apr 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmSyxsRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377D78C6A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188328; cv=none; b=HfD7bWJ4yXVLzOX/Zj02QzvjYV+VcHRKAG8CZBnQDLrxSaeUOHocnXBKDwOpo1lPCLNN0KRVGOBaOfP68URgJ+oQsCQpQqgMPVv1TJ1k2PRZlHOvBUT5Pet6vXPS0MYN6GTMLVlZpOBuci5IAzjb7fbRPpy4kXiUcO/6cUUUD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188328; c=relaxed/simple;
	bh=wHmX9l66KPhKj22H0uMZQDz1q5ZJdtE0zrrhmnQinhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L83Jci5qCsqMN7Q2GkuXFlKhXfppKtF9MxxpsgGqh43hUBbUoXEBQV0pMeXLq5X8WLfcQWZOwwD5mDlbkhUwo9YzXAvwPBzHUk7ArmMAZ2tBHw6P84yHcDvBn/R2q+qZNHJlY1Dge03gUmjvAa9oKbGa6CRfsnX8//J7gtlWudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmSyxsRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9721C3277B;
	Mon, 15 Apr 2024 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188328;
	bh=wHmX9l66KPhKj22H0uMZQDz1q5ZJdtE0zrrhmnQinhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmSyxsRlfHpHfNNwdi3fE/RgZv2HKAdkWciGH99x+N6qyFiTe/ntLrDr8bYQfMI6O
	 vSpxZ3rch1SVrblRM/5bF6faHL4Cwwz1mfY+NNipIggQNA09Xen+QMv9QYVdPxlWzX
	 w03FLo3f5b/H1UCLanCQTPX++VxZgxIIoDji/jQwRD2eEjT66lNXVzYoboUP2X/zja
	 bPG7hfahW3FArXM1P1CrpUyui9jz6+IUfR20dEdwsEU7VNc9UZ27HKuh9wKuBYWt+x
	 vQVQmqYFCZBFGcg7I33uIMvGrC5EXSa/MVhtqYhKeQ5cJJOOTY2kouJ9OgoiClYlxX
	 E6a4LgaFKYs6g==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	j51569436@gmail.com,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 029/190] smb: client: fix OOB in smbCalcSize()
Date: Mon, 15 Apr 2024 06:49:19 -0400
Message-ID: <20240415105208.3137874-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit b35858b3786ddbb56e1c35138ba25d6adf8d0bef ]

Validate @smb->WordCount to avoid reading off the end of @smb and thus
causing the following KASAN splat:

  BUG: KASAN: slab-out-of-bounds in smbCalcSize+0x32/0x40 [cifs]
  Read of size 2 at addr ffff88801c024ec5 by task cifsd/1328

  CPU: 1 PID: 1328 Comm: cifsd Not tainted 6.7.0-rc5 #9
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4a/0x80
   print_report+0xcf/0x650
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __phys_addr+0x46/0x90
   kasan_report+0xd8/0x110
   ? smbCalcSize+0x32/0x40 [cifs]
   ? smbCalcSize+0x32/0x40 [cifs]
   kasan_check_range+0x105/0x1b0
   smbCalcSize+0x32/0x40 [cifs]
   checkSMB+0x162/0x370 [cifs]
   ? __pfx_checkSMB+0x10/0x10 [cifs]
   cifs_handle_standard+0xbc/0x2f0 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   cifs_demultiplex_thread+0xed1/0x1360 [cifs]
   ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? lockdep_hardirqs_on_prepare+0x136/0x210
   ? __pfx_lock_release+0x10/0x10
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? mark_held_locks+0x1a/0x90
   ? lockdep_hardirqs_on_prepare+0x136/0x210
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __kthread_parkme+0xce/0xf0
   ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
   kthread+0x18d/0x1d0
   ? kthread+0xdb/0x1d0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x34/0x60
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1b/0x30
   </TASK>

This fixes CVE-2023-6606.

Reported-by: j51569436@gmail.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218218
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index d0e024856c0d4..d22454f4cf841 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -334,6 +334,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 			cifs_dbg(VFS, "Length less than smb header size\n");
 		}
 		return -EIO;
+	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
+		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
+			 __func__, smb->WordCount);
+		return -EIO;
 	}
 
 	/* otherwise, there is enough to get to the BCC */
-- 
2.43.0


