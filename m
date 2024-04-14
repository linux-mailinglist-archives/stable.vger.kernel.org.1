Return-Path: <stable+bounces-36352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EE89BCE3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFEB1C21228
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1152F83;
	Mon,  8 Apr 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsaeOmS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D654645
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571576; cv=none; b=VYNwsnpwNpckH79Y4NNl9+P0LmrjJ+ysp6MoqJaM5gCD17x3TXx1ng93GeSIwl1RQ/3GK9jdw7KjDXidRWfpkXJ+hLtFG7uJiDd4LonQyRHc2FUDGyrp2jtHWevFdoSAOYX8YdLA/R0cTtSxZWCILOAK28I8I/LUJnWue/q6kuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571576; c=relaxed/simple;
	bh=K5EqlIiuxybQgAfOAHkA/09sU5cUx+6ZHU8v4g0HqDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HGC/DIYbA+2OTufw7xwOtyMlucDIatIvLjq46MEnm8G8Zd60fSjjdnD6+s7ntKGt8ODbNKftFe4gHK4ome7jDhEaCM4GpbcOp1LU6RIE8E2Aqzrt5vp358G2iodfLHH18DiXXZhsjNrOebs0rISx08Aazn44uGvmpmIKngc+gbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsaeOmS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D30C433F1;
	Mon,  8 Apr 2024 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571575;
	bh=K5EqlIiuxybQgAfOAHkA/09sU5cUx+6ZHU8v4g0HqDE=;
	h=Subject:To:Cc:From:Date:From;
	b=zsaeOmS2/Aamf8gcQuGvAVBI+j5Pfwl19+HS9p7nRAG5pOQWzIKa+12hwciuhuELx
	 dwptcJUz5nN8sQafcnUwye9Zqnm97SniMgvdgElxctyjiKs60moTnduTDjRgejdByR
	 foapYQ0t9ZCKaxsPvk9E6fKOt4HbTazc7H9cMQaQ=
Subject: FAILED: patch "[PATCH] smb: client: fix UAF in smb2_reconnect_server()" failed to apply to 6.6-stable tree
To: pc@manguebit.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:19:32 +0200
Message-ID: <2024040832-episode-phrasing-9e1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 24a9799aa8efecd0eb55a75e35f9d8e6400063aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040832-episode-phrasing-9e1a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

24a9799aa8ef ("smb: client: fix UAF in smb2_reconnect_server()")
7257bcf3bdc7 ("cifs: cifs_chan_is_iface_active should be called with chan_lock held")
27e1fd343f80 ("cifs: after disabling multichannel, mark tcon for reconnect")
fa1d0508bdd4 ("cifs: account for primary channel in the interface list")
a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
c37ed2d7d098 ("smb: client: remove extra @chan_count check in __cifs_put_smb_ses()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24a9799aa8efecd0eb55a75e35f9d8e6400063aa Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.com>
Date: Mon, 1 Apr 2024 14:13:10 -0300
Subject: [PATCH] smb: client: fix UAF in smb2_reconnect_server()

The UAF bug is due to smb2_reconnect_server() accessing a session that
is already being teared down by another thread that is executing
__cifs_put_smb_ses().  This can happen when (a) the client has
connection to the server but no session or (b) another thread ends up
setting @ses->ses_status again to something different than
SES_EXITING.

To fix this, we need to make sure to unconditionally set
@ses->ses_status to SES_EXITING and prevent any other threads from
setting a new status while we're still tearing it down.

The following can be reproduced by adding some delay to right after
the ipc is freed in __cifs_put_smb_ses() - which will give
smb2_reconnect_server() worker a chance to run and then accessing
@ses->ipc:

kinit ...
mount.cifs //srv/share /mnt/1 -o sec=krb5,nohandlecache,echo_interval=10
[disconnect srv]
ls /mnt/1 &>/dev/null
sleep 30
kdestroy
[reconnect srv]
sleep 10
umount /mnt/1
...
CIFS: VFS: Verify user has a krb5 ticket and keyutils is installed
CIFS: VFS: \\srv Send error in SessSetup = -126
CIFS: VFS: Verify user has a krb5 ticket and keyutils is installed
CIFS: VFS: \\srv Send error in SessSetup = -126
general protection fault, probably for non-canonical address
0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 50 Comm: kworker/3:1 Not tainted 6.9.0-rc2 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
04/01/2014
Workqueue: cifsiod smb2_reconnect_server [cifs]
RIP: 0010:__list_del_entry_valid_or_report+0x33/0xf0
Code: 4f 08 48 85 d2 74 42 48 85 c9 74 59 48 b8 00 01 00 00 00 00 ad
de 48 39 c2 74 61 48 b8 22 01 00 00 00 00 74 69 <48> 8b 01 48 39 f8 75
7b 48 8b 72 08 48 39 c6 0f 85 88 00 00 00 b8
RSP: 0018:ffffc900001bfd70 EFLAGS: 00010a83
RAX: dead000000000122 RBX: ffff88810da53838 RCX: 6b6b6b6b6b6b6b6b
RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc02f6878 RDI: ffff88810da53800
RBP: ffff88810da53800 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88810c064000
R13: 0000000000000001 R14: ffff88810c064000 R15: ffff8881039cc000
FS: 0000000000000000(0000) GS:ffff888157c00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3728b1000 CR3: 000000010caa4000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? die_addr+0x36/0x90
 ? exc_general_protection+0x1c1/0x3f0
 ? asm_exc_general_protection+0x26/0x30
 ? __list_del_entry_valid_or_report+0x33/0xf0
 __cifs_put_smb_ses+0x1ae/0x500 [cifs]
 smb2_reconnect_server+0x4ed/0x710 [cifs]
 process_one_work+0x205/0x6b0
 worker_thread+0x191/0x360
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe2/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9b85b5341822..ee29bc57300c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -232,7 +232,13 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
-		/* check if iface is still active */
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
+		spin_unlock(&ses->ses_lock);
+
 		spin_lock(&ses->chan_lock);
 		if (cifs_ses_get_chan_index(ses, server) ==
 		    CIFS_INVAL_CHAN_INDEX) {
@@ -1963,31 +1969,6 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	return rc;
 }
 
-/**
- * cifs_free_ipc - helper to release the session IPC tcon
- * @ses: smb session to unmount the IPC from
- *
- * Needs to be called everytime a session is destroyed.
- *
- * On session close, the IPC is closed and the server must release all tcons of the session.
- * No need to send a tree disconnect here.
- *
- * Besides, it will make the server to not close durable and resilient files on session close, as
- * specified in MS-SMB2 3.3.5.6 Receiving an SMB2 LOGOFF Request.
- */
-static int
-cifs_free_ipc(struct cifs_ses *ses)
-{
-	struct cifs_tcon *tcon = ses->tcon_ipc;
-
-	if (tcon == NULL)
-		return 0;
-
-	tconInfoFree(tcon);
-	ses->tcon_ipc = NULL;
-	return 0;
-}
-
 static struct cifs_ses *
 cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
@@ -2019,48 +2000,52 @@ cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 void __cifs_put_smb_ses(struct cifs_ses *ses)
 {
 	struct TCP_Server_Info *server = ses->server;
+	struct cifs_tcon *tcon;
 	unsigned int xid;
 	size_t i;
+	bool do_logoff;
 	int rc;
 
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_EXITING) {
-		spin_unlock(&ses->ses_lock);
-		return;
-	}
-	spin_unlock(&ses->ses_lock);
-
-	cifs_dbg(FYI, "%s: ses_count=%d\n", __func__, ses->ses_count);
-	cifs_dbg(FYI,
-		 "%s: ses ipc: %s\n", __func__, ses->tcon_ipc ? ses->tcon_ipc->tree_name : "NONE");
-
 	spin_lock(&cifs_tcp_ses_lock);
-	if (--ses->ses_count > 0) {
+	spin_lock(&ses->ses_lock);
+	cifs_dbg(FYI, "%s: id=0x%llx ses_count=%d ses_status=%u ipc=%s\n",
+		 __func__, ses->Suid, ses->ses_count, ses->ses_status,
+		 ses->tcon_ipc ? ses->tcon_ipc->tree_name : "none");
+	if (ses->ses_status == SES_EXITING || --ses->ses_count > 0) {
+		spin_unlock(&ses->ses_lock);
 		spin_unlock(&cifs_tcp_ses_lock);
 		return;
 	}
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_GOOD)
-		ses->ses_status = SES_EXITING;
-	spin_unlock(&ses->ses_lock);
-	spin_unlock(&cifs_tcp_ses_lock);
-
 	/* ses_count can never go negative */
 	WARN_ON(ses->ses_count < 0);
 
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_EXITING && server->ops->logoff) {
-		spin_unlock(&ses->ses_lock);
-		cifs_free_ipc(ses);
+	spin_lock(&ses->chan_lock);
+	cifs_chan_clear_need_reconnect(ses, server);
+	spin_unlock(&ses->chan_lock);
+
+	do_logoff = ses->ses_status == SES_GOOD && server->ops->logoff;
+	ses->ses_status = SES_EXITING;
+	tcon = ses->tcon_ipc;
+	ses->tcon_ipc = NULL;
+	spin_unlock(&ses->ses_lock);
+	spin_unlock(&cifs_tcp_ses_lock);
+
+	/*
+	 * On session close, the IPC is closed and the server must release all
+	 * tcons of the session.  No need to send a tree disconnect here.
+	 *
+	 * Besides, it will make the server to not close durable and resilient
+	 * files on session close, as specified in MS-SMB2 3.3.5.6 Receiving an
+	 * SMB2 LOGOFF Request.
+	 */
+	tconInfoFree(tcon);
+	if (do_logoff) {
 		xid = get_xid();
 		rc = server->ops->logoff(xid, ses);
 		if (rc)
 			cifs_server_dbg(VFS, "%s: Session Logoff failure rc=%d\n",
 				__func__, rc);
 		_free_xid(xid);
-	} else {
-		spin_unlock(&ses->ses_lock);
-		cifs_free_ipc(ses);
 	}
 
 	spin_lock(&cifs_tcp_ses_lock);


