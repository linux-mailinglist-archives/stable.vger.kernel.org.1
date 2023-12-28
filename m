Return-Path: <stable+bounces-8661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459EA81F816
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 13:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B61B238C1
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648957475;
	Thu, 28 Dec 2023 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJ+PScdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E437461
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 12:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5402C433C7;
	Thu, 28 Dec 2023 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703765412;
	bh=umBX6RMH+VHlhr68+zK2S3PbQsLSoJ3fFGtNKD2RwxY=;
	h=Subject:To:Cc:From:Date:From;
	b=mJ+PScdjQ3HNIs/MjLvFQHymlyhG5f6qvmMzMAOsqfPo0Q6o+HpbPimWbVvqpZWUA
	 L1k2rAvjFDm3PO1URMVUafhb0gxvMaRFVrWBm6kYeNVLJaeLIZgdk9+oEvkQmBXba9
	 KVagAIcjCOYq7NYSPaoYuELnz74BuwlWHB9UvEVo=
Subject: FAILED: patch "[PATCH] smb: client: fix potential OOB in cifs_dump_detail()" failed to apply to 4.19-stable tree
To: pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 12:10:05 +0000
Message-ID: <2023122805-dullness-armless-eea7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b50492b05fd02887b46aef079592207fb5c97a4c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122805-dullness-armless-eea7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

b50492b05fd0 ("smb: client: fix potential OOB in cifs_dump_detail()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
68ed14496b03 ("cifs: remove unused server parameter from calc_smb_size()")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b50492b05fd02887b46aef079592207fb5c97a4c Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Sat, 16 Dec 2023 01:10:04 -0300
Subject: [PATCH] smb: client: fix potential OOB in cifs_dump_detail()

Validate SMB message with ->check_message() before calling
->calc_smb_size().

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 5596c9f30ccb..60027f5aebe8 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -40,11 +40,13 @@ void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 #ifdef CONFIG_CIFS_DEBUG2
 	struct smb_hdr *smb = buf;
 
-	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d\n",
-		 smb->Command, smb->Status.CifsError,
-		 smb->Flags, smb->Flags2, smb->Mid, smb->Pid);
-	cifs_dbg(VFS, "smb buf %p len %u\n", smb,
-		 server->ops->calc_smb_size(smb));
+	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d Wct: %d\n",
+		 smb->Command, smb->Status.CifsError, smb->Flags,
+		 smb->Flags2, smb->Mid, smb->Pid, smb->WordCount);
+	if (!server->ops->check_message(buf, server->total_read, server)) {
+		cifs_dbg(VFS, "smb buf %p len %u\n", smb,
+			 server->ops->calc_smb_size(smb));
+	}
 #endif /* CONFIG_CIFS_DEBUG2 */
 }
 


