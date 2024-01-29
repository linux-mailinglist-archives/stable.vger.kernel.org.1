Return-Path: <stable+bounces-17133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C2C840FF6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD362842EA
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE157373A;
	Mon, 29 Jan 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MN0fLxEI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3DC73722;
	Mon, 29 Jan 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548535; cv=none; b=KcAtqziNmcfhfLhmaJ8hozRuuvt0A0SYrl/E5Tly0uNXncM6WcwYJfTVYbmsHh/vyJad7JVgc29p1iuyiazetL3HdD57rZe2vC+dZQAl5i40//pIexsbFTA4iIIlMmFhG2Zkl9w3WH4C8o323uH8wcZkrwfPQOSdUEw+FrDZiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548535; c=relaxed/simple;
	bh=EI0HpUdBF3PsnXJZFtOKP0A8P3Z2BRM5MRQMEjvAzJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3X4vPdVAnFkB37b78LhyPMIxbqKO+VjVF8k/zEMTnHnDOVSnCWS9RmFaORW/sktAX1h1nDxRH89NRK+I66w/4Vd51QgXeezZ9CwsDfg3dT8U7iUsvafywn1SnLpkHeJTAWIjy8eu1g4hadSi52qyogdeX/YDG5KfOXOGMAwNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MN0fLxEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F46C433F1;
	Mon, 29 Jan 2024 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548535;
	bh=EI0HpUdBF3PsnXJZFtOKP0A8P3Z2BRM5MRQMEjvAzJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MN0fLxEIqG910JLPf+gOIc56MBcbgxJ+/oVeRpsSgpLWi5mgh01RqTA4bVgkpb1QX
	 G+kHAc8BhwLAGYVFoQnAVPeEW7E5jL2yRVqMUB3UXavRyIhE7dFJdbaff2uJoqyTxz
	 Y6FWToBtYJ4AP9CyAh9xr+IRV99AX8fO/sd4aX0w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 165/331] cifs: fix a pending undercount of srv_count
Date: Mon, 29 Jan 2024 09:03:49 -0800
Message-ID: <20240129170019.752153622@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit f30bbc38704e279c06d073ecb18fea376791ecab upstream.

The following commit reverted the changes to ref count
the server struct while scheduling a reconnect work:
823342524868 Revert "cifs: reconnect work should have reference on server struct"

However, a following change also introduced scheduling
of reconnect work, and assumed ref counting. This change
fixes that as well.

Fixes umount problems like:

[73496.157838] CPU: 5 PID: 1321389 Comm: umount Tainted: G        W  OE      6.7.0-060700rc6-generic #202312172332
[73496.157841] Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS N2CET67W (1.50 ) 12/15/2022
[73496.157843] RIP: 0010:cifs_put_tcp_session+0x17d/0x190 [cifs]
[73496.157906] Code: 5d 31 c0 31 d2 31 f6 31 ff c3 cc cc cc cc e8 4a 6e 14 e6 e9 f6 fe ff ff be 03 00 00 00 48 89 d7 e8 78 26 b3 e5 e9 e4 fe ff ff <0f> 0b e9 b1 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90
[73496.157908] RSP: 0018:ffffc90003bcbcb8 EFLAGS: 00010286
[73496.157911] RAX: 00000000ffffffff RBX: ffff8885830fa800 RCX: 0000000000000000
[73496.157913] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[73496.157915] RBP: ffffc90003bcbcc8 R08: 0000000000000000 R09: 0000000000000000
[73496.157917] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[73496.157918] R13: ffff8887d56ba800 R14: 00000000ffffffff R15: ffff8885830fa800
[73496.157920] FS:  00007f1ff0e33800(0000) GS:ffff88887ba80000(0000) knlGS:0000000000000000
[73496.157922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[73496.157924] CR2: 0000115f002e2010 CR3: 00000003d1e24005 CR4: 00000000003706f0
[73496.157926] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[73496.157928] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[73496.157929] Call Trace:
[73496.157931]  <TASK>
[73496.157933]  ? show_regs+0x6d/0x80
[73496.157936]  ? __warn+0x89/0x160
[73496.157939]  ? cifs_put_tcp_session+0x17d/0x190 [cifs]
[73496.157976]  ? report_bug+0x17e/0x1b0
[73496.157980]  ? handle_bug+0x51/0xa0
[73496.157983]  ? exc_invalid_op+0x18/0x80
[73496.157985]  ? asm_exc_invalid_op+0x1b/0x20
[73496.157989]  ? cifs_put_tcp_session+0x17d/0x190 [cifs]
[73496.158023]  ? cifs_put_tcp_session+0x1e/0x190 [cifs]
[73496.158057]  __cifs_put_smb_ses+0x2b5/0x540 [cifs]
[73496.158090]  ? tconInfoFree+0xc2/0x120 [cifs]
[73496.158130]  cifs_put_tcon.part.0+0x108/0x2b0 [cifs]
[73496.158173]  cifs_put_tlink+0x49/0x90 [cifs]
[73496.158220]  cifs_umount+0x56/0xb0 [cifs]
[73496.158258]  cifs_kill_sb+0x52/0x60 [cifs]
[73496.158306]  deactivate_locked_super+0x32/0xc0
[73496.158309]  deactivate_super+0x46/0x60
[73496.158311]  cleanup_mnt+0xc3/0x170
[73496.158314]  __cleanup_mnt+0x12/0x20
[73496.158330]  task_work_run+0x5e/0xa0
[73496.158333]  exit_to_user_mode_loop+0x105/0x130
[73496.158336]  exit_to_user_mode_prepare+0xa5/0xb0
[73496.158338]  syscall_exit_to_user_mode+0x29/0x60
[73496.158341]  do_syscall_64+0x6c/0xf0
[73496.158344]  ? syscall_exit_to_user_mode+0x37/0x60
[73496.158346]  ? do_syscall_64+0x6c/0xf0
[73496.158349]  ? exit_to_user_mode_prepare+0x30/0xb0
[73496.158353]  ? syscall_exit_to_user_mode+0x37/0x60
[73496.158355]  ? do_syscall_64+0x6c/0xf0

Reported-by: Robert Morris <rtm@csail.mit.edu>
Fixes: 705fc522fe9d ("cifs: handle when server starts supporting multichannel")
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2pdu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -440,8 +440,7 @@ skip_sess_setup:
 skip_add_channels:
 
 	if (smb2_command != SMB2_INTERNAL_CMD)
-		if (mod_delayed_work(cifsiod_wq, &server->reconnect, 0))
-			cifs_put_tcp_session(server, false);
+		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
 
 	atomic_inc(&tconInfoReconnectCount);
 out:



