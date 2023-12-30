Return-Path: <stable+bounces-8861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69230820534
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B15C1C20F53
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2BB79DE;
	Sat, 30 Dec 2023 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GRJEcyGn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047C8473;
	Sat, 30 Dec 2023 12:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1729EC433C7;
	Sat, 30 Dec 2023 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937953;
	bh=5n9QbdvScBMT/m/k7x8JFoIFCoZRwqZUP/KacC1FnV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRJEcyGnLyTw+QVXW3j9C5bBHW34pthX6Lk5gcn8Qc4X5gTuJxXbHF6pbqK20WlwY
	 /4mmzbpnwUdgsYxfBP8G3MOM57LwUfVNkFuZHYyfKKj+gcMki/AIiE0zH+D0ccVjuh
	 F7Zkqz0doFTBEaKBqpEMwl/Me8SGJnx+faXmPI5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 126/156] smb: client: fix potential OOB in cifs_dump_detail()
Date: Sat, 30 Dec 2023 11:59:40 +0000
Message-ID: <20231230115816.489946074@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

commit b50492b05fd02887b46aef079592207fb5c97a4c upstream.

Validate SMB message with ->check_message() before calling
->calc_smb_size().

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_debug.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -40,11 +40,13 @@ void cifs_dump_detail(void *buf, struct
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
 



