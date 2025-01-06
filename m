Return-Path: <stable+bounces-107121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E313BA02A52
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3551886A05
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA491662EF;
	Mon,  6 Jan 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aX+4pLdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498B1DED4C;
	Mon,  6 Jan 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177520; cv=none; b=F51S6XU1nR5K1EEW/oSdhEDCdc4Whp9jmGEeUWM8Vc8AKn/RULGfuzlMcJ0bJ+08yWIpYdsyqqFDhR6qk/v13s5nVEuV8Yvwgd87F4zO+y5C7yiZoGJXi0BlCjGtQckXw4o8dwEEdjHof89sdSVrA4g90JlTzEpNeBvfi27vjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177520; c=relaxed/simple;
	bh=ZGXkf6IDVK4Ghgd78ytghRtP5lZF+lftA1O2e+Udot4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8wtRUT3+wGkaxMTHR7WrX6SJO3l3gfx8WT6/3X1RbWr96z1zQwm5dQn2pxqU+Xy5rTmSwxn8/shzT95UCmH6kVCdrcMVltnIr8cLzR863irQOQHeOL7RP0B5VECrcEKmR4Ez7sP0zbGibtMv9GA+o2j6jEI+0rNRAA5j/y2qKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aX+4pLdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AC6C4CEE3;
	Mon,  6 Jan 2025 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177519;
	bh=ZGXkf6IDVK4Ghgd78ytghRtP5lZF+lftA1O2e+Udot4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aX+4pLdqxPNZGLWT+2w58sX7IcUebZ4F2TT1Lgg14XYXm9135qSqDDM9KHZ0aIe2l
	 GZ04QVRngTNr/ZhdgeWsGGC0sDJ32lzJaZbbRLQqMwC76mxv8kRTa0au/7JtMVy1TN
	 9zV1dinVU4AHIys+Agz3RBYeZcVlMgEWodzbi6y0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Disseldorp <ddiss@suse.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 188/222] ksmbd: set ATTR_CTIME flags when setting mtime
Date: Mon,  6 Jan 2025 16:16:32 +0100
Message-ID: <20250106151157.880138098@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 21e46a79bbe6c4e1aa73b3ed998130f2ff07b128 ]

David reported that the new warning from setattr_copy_mgtime is coming
like the following.

[  113.215316] ------------[ cut here ]------------
[  113.215974] WARNING: CPU: 1 PID: 31 at fs/attr.c:300 setattr_copy+0x1ee/0x200
[  113.219192] CPU: 1 UID: 0 PID: 31 Comm: kworker/1:1 Not tainted 6.13.0-rc1+ #234
[  113.220127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[  113.221530] Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
[  113.222220] RIP: 0010:setattr_copy+0x1ee/0x200
[  113.222833] Code: 24 28 49 8b 44 24 30 48 89 53 58 89 43 6c 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48 89 df e8 77 d6 ff ff e9 cd fe ff ff <0f> 0b e9 be fe ff ff 66 0
[  113.225110] RSP: 0018:ffffaf218010fb68 EFLAGS: 00010202
[  113.225765] RAX: 0000000000000120 RBX: ffffa446815f8568 RCX: 0000000000000003
[  113.226667] RDX: ffffaf218010fd38 RSI: ffffa446815f8568 RDI: ffffffff94eb03a0
[  113.227531] RBP: ffffaf218010fb90 R08: 0000001a251e217d R09: 00000000675259fa
[  113.228426] R10: 0000000002ba8a6d R11: ffffa4468196c7a8 R12: ffffaf218010fd38
[  113.229304] R13: 0000000000000120 R14: ffffffff94eb03a0 R15: 0000000000000000
[  113.230210] FS:  0000000000000000(0000) GS:ffffa44739d00000(0000) knlGS:0000000000000000
[  113.231215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.232055] CR2: 00007efe0053d27e CR3: 000000000331a000 CR4: 00000000000006b0
[  113.232926] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  113.233812] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  113.234797] Call Trace:
[  113.235116]  <TASK>
[  113.235393]  ? __warn+0x73/0xd0
[  113.235802]  ? setattr_copy+0x1ee/0x200
[  113.236299]  ? report_bug+0xf3/0x1e0
[  113.236757]  ? handle_bug+0x4d/0x90
[  113.237202]  ? exc_invalid_op+0x13/0x60
[  113.237689]  ? asm_exc_invalid_op+0x16/0x20
[  113.238185]  ? setattr_copy+0x1ee/0x200
[  113.238692]  btrfs_setattr+0x80/0x820 [btrfs]
[  113.239285]  ? get_stack_info_noinstr+0x12/0xf0
[  113.239857]  ? __module_address+0x22/0xa0
[  113.240368]  ? handle_ksmbd_work+0x6e/0x460 [ksmbd]
[  113.240993]  ? __module_text_address+0x9/0x50
[  113.241545]  ? __module_address+0x22/0xa0
[  113.242033]  ? unwind_next_frame+0x10e/0x920
[  113.242600]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  113.243268]  notify_change+0x2c2/0x4e0
[  113.243746]  ? stack_depot_save_flags+0x27/0x730
[  113.244339]  ? set_file_basic_info+0x130/0x2b0 [ksmbd]
[  113.244993]  set_file_basic_info+0x130/0x2b0 [ksmbd]
[  113.245613]  ? process_scheduled_works+0xbe/0x310
[  113.246181]  ? worker_thread+0x100/0x240
[  113.246696]  ? kthread+0xc8/0x100
[  113.247126]  ? ret_from_fork+0x2b/0x40
[  113.247606]  ? ret_from_fork_asm+0x1a/0x30
[  113.248132]  smb2_set_info+0x63f/0xa70 [ksmbd]

ksmbd is trying to set the atime and mtime via notify_change without also
setting the ctime. so This patch add ATTR_CTIME flags when setting mtime
to avoid a warning.

Reported-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7216e2cc498b..2884ebdc0eda 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6017,15 +6017,13 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		attrs.ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
 	}
 
-	attrs.ia_valid |= ATTR_CTIME;
 	if (file_info->ChangeTime)
-		attrs.ia_ctime = ksmbd_NTtimeToUnix(file_info->ChangeTime);
-	else
-		attrs.ia_ctime = inode_get_ctime(inode);
+		inode_set_ctime_to_ts(inode,
+				ksmbd_NTtimeToUnix(file_info->ChangeTime));
 
 	if (file_info->LastWriteTime) {
 		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
-		attrs.ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
+		attrs.ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET | ATTR_CTIME);
 	}
 
 	if (file_info->Attributes) {
@@ -6067,8 +6065,6 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 			return -EACCES;
 
 		inode_lock(inode);
-		inode_set_ctime_to_ts(inode, attrs.ia_ctime);
-		attrs.ia_valid &= ~ATTR_CTIME;
 		rc = notify_change(idmap, dentry, &attrs, NULL);
 		inode_unlock(inode);
 	}
-- 
2.39.5




