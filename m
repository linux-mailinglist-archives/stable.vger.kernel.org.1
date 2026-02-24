Return-Path: <stable+bounces-217955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMOnGUEbnmntTQQAu9opvQ
	(envelope-from <stable+bounces-217955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:42:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93B18CD77
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25901304F238
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49133E346;
	Tue, 24 Feb 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gEOHEXhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143C33EAE7
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969314; cv=none; b=eDEGgz+DjyYvH1KtINdG3cx7oM1V/BCtLyGMFGtG/jjJFBOl2IZ9i5TSsANa5/H51YN9NZr9ZW8uttrzpk4f/Tsvcbg/FEaB0pOoq3MSX/2ji8yegX0LNAxCn6QA4ZNS5rx4DirPN/DX9whSxLF/YgBKrjcH5vJ19KwYYX+EQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969314; c=relaxed/simple;
	bh=HqwlgO6dieM5aCT/x+pkAIQsTxTMhLPfdEUtermNTRI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c5ojaua/y2H5UQtcIth8xTC3t0uiltERZjsWqI9nVARCB87N8PgMcmIs2oq7xdZhuzUQ9PwQo2vKVem2dh63xPu+Oqk0FFc+0GaeMH+BQHXPeGPhU0t7v7vD1y6pFLML9X/Vqpqgi5/QY+f0LGqf6+qZ+Iu1aNOYhLgL/V1TMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gEOHEXhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3FFC19425;
	Tue, 24 Feb 2026 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969314;
	bh=HqwlgO6dieM5aCT/x+pkAIQsTxTMhLPfdEUtermNTRI=;
	h=Subject:To:Cc:From:Date:From;
	b=gEOHEXhVnHWu1PZEZhk+LuM+3R33564bt82y3fflujcxWk3+khDl3/VHMRdC6gPSn
	 QmZUMjPxVKBUM0H6v/BhL8SZo0NtuL2eVYlxZngNgytNXAYZU50IWiB4dI4Zrplm/H
	 xcRz9kF+4S8HHKVdTy1P4FR5IhUljF1FlH+6wP5I=
Subject: FAILED: patch "[PATCH] ksmbd: call ksmbd_vfs_kern_path_end_removing() on some error" failed to apply to 5.10-stable tree
To: pchelkin@ispras.ru,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:41:45 -0800
Message-ID: <2026022444-cornball-unsubtle-6c8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217955-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxtesting.org:url,gregkh:email,ispras.ru:email]
X-Rspamd-Queue-Id: BD93B18CD77
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a09dc10d1353f0e92c21eae2a79af1c2b1ddcde8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022444-cornball-unsubtle-6c8c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a09dc10d1353f0e92c21eae2a79af1c2b1ddcde8 Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Sat, 14 Feb 2026 18:45:14 +0300
Subject: [PATCH] ksmbd: call ksmbd_vfs_kern_path_end_removing() on some error
 paths

There are two places where ksmbd_vfs_kern_path_end_removing() needs to be
called in order to balance what the corresponding successful call to
ksmbd_vfs_kern_path_start_removing() has done, i.e. drop inode locks and
put the taken references.  Otherwise there might be potential deadlocks
and unbalanced locks which are caught like:

BUG: workqueue leaked lock or atomic: kworker/5:21/0x00000000/7596
     last function: handle_ksmbd_work
2 locks held by kworker/5:21/7596:
 #0: ffff8881051ae448 (sb_writers#3){.+.+}-{0:0}, at: ksmbd_vfs_kern_path_locked+0x142/0x660
 #1: ffff888130e966c0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: ksmbd_vfs_kern_path_locked+0x17d/0x660
CPU: 5 PID: 7596 Comm: kworker/5:21 Not tainted 6.1.162-00456-gc29b353f383b #138
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Workqueue: ksmbd-io handle_ksmbd_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x44/0x5b
 process_one_work.cold+0x57/0x5c
 worker_thread+0x82/0x600
 kthread+0x153/0x190
 ret_from_fork+0x22/0x30
 </TASK>

Found by Linux Verification Center (linuxtesting.org).

Fixes: d5fc1400a34b ("smb/server: avoid deadlock when linking with ReplaceIfExists")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index cbb31efdbaa2..2782eea214d0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6115,14 +6115,14 @@ static int smb2_create_link(struct ksmbd_work *work,
 				rc = -EINVAL;
 				ksmbd_debug(SMB, "cannot delete %s\n",
 					    link_name);
-				goto out;
 			}
 		} else {
 			rc = -EEXIST;
 			ksmbd_debug(SMB, "link already exists\n");
-			goto out;
 		}
 		ksmbd_vfs_kern_path_end_removing(&path);
+		if (rc)
+			goto out;
 	}
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)


