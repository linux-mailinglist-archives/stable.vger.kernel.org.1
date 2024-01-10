Return-Path: <stable+bounces-9457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB0A823275
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EA21F24D3D
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E91BDFC;
	Wed,  3 Jan 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QwxHGy+q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1731C28A;
	Wed,  3 Jan 2024 17:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EF3C433C8;
	Wed,  3 Jan 2024 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301644;
	bh=3p0KGGvRzV4j7hx3WfA8Kjnt6cR06Ge0Yj5JrBN7zVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwxHGy+qtkg/bp65oLqAuj3IOZFzvTYj1+Bq+vw5cBtMRgDO6lB7Nyog4aAL4OajK
	 Fr1ryG8dhbp2x9aNclKlAiPj9oNI8lSwTvthn2dovrch8mp+RiSmxX3wsjlB9Wlx1P
	 xjmU2449m6JfIzBD0hiHxms9Q19R4JPhaIptJdJk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	j51569436@gmail.com,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 84/95] smb: client: fix OOB in smbCalcSize()
Date: Wed,  3 Jan 2024 17:55:32 +0100
Message-ID: <20240103164906.653078164@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5e4dab5dfb7a3..33328eae03d7a 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -340,6 +340,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
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




