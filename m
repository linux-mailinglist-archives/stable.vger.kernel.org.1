Return-Path: <stable+bounces-8677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20181F828
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2436B23881
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA447477;
	Thu, 28 Dec 2023 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6vDNJ5y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B46FA3
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B26C433C8;
	Thu, 28 Dec 2023 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765487;
	bh=sSA5JGxY5zY3kNAWSs+XQhTcjH4nVWERCmu6jx7qceo=;
	h=Subject:To:Cc:From:Date:From;
	b=H6vDNJ5ysIrIiWvf0v3JwHMeS8hUxFx5CdRMTXHdEmsETAQ71YRZBwlKpz8GixMLa
	 VdZKR8T57ny42fgseYHy3Asm9yrJmbFspmEOSe3nYbyxnzAe2NZXNIn2/bOgxj5wik
	 FJY71KSppnWZLC+62J2zOknNj+00mWZXi2JFJLQI=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB in smbCalcSize()" failed to apply to 4.14-stable tree
To: pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:11:19 +0000
Message-ID: <2023122818-unroll-herself-4816@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x b35858b3786ddbb56e1c35138ba25d6adf8d0bef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122818-unroll-herself-4816@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

b35858b3786d ("smb: client: fix OOB in smbCalcSize()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b35858b3786ddbb56e1c35138ba25d6adf8d0bef Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Fri, 15 Dec 2023 19:59:14 -0300
Subject: [PATCH] smb: client: fix OOB in smbCalcSize()

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

diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 35b176457bbe..c2137ea3c253 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -363,6 +363,10 @@ checkSMB(char *buf, unsigned int total_read, struct TCP_Server_Info *server)
 			cifs_dbg(VFS, "Length less than smb header size\n");
 		}
 		return -EIO;
+	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
+		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
+			 __func__, smb->WordCount);
+		return -EIO;
 	}
 
 	/* otherwise, there is enough to get to the BCC */


