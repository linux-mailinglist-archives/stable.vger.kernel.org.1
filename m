Return-Path: <stable+bounces-219132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJs6IXhdnmmIUwQAu9opvQ
	(envelope-from <stable+bounces-219132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:24:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE463190DEB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B0EB301DA74
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAD227FD72;
	Wed, 25 Feb 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwH1ZiFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6C27CB02
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986290; cv=none; b=X8BadkixzTxBkAwpy+Q384QaiS6EcHxlDBkBdijP9DqYVFVX/vrWeK+t5ADwrqNtqeJa7dg/YbZfSNAV7u9Gh4clCrwajFwkAmIDlgkZGgDQjrdVwm2blIktqurot9sFbZE24vBFdciGvaYPXfj2CXcJ3JOh+gCpx6uP7gSfiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986290; c=relaxed/simple;
	bh=pu5WB2e6YKau+rXgQDZJmpAQErRQYl9SOHUoIEJHR+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG/FyFHus6FPOJtv1BRvTr1Fc0BmFjl+On9U2zDDwot6EsvJUx8l2jc1xLDhBQeTtF8MR2idzctQxxmM+Ao78Q9rk/2YuiuHdSx6lODGYBe54QTf4zOZiBM2PrppADu7WxD2veTMkR/E20sTPK8lZE3XqxlDBr+KTZOYWj2Atkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwH1ZiFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A812C19423;
	Wed, 25 Feb 2026 02:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986289;
	bh=pu5WB2e6YKau+rXgQDZJmpAQErRQYl9SOHUoIEJHR+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwH1ZiFM/bxN2ZfqKpX5+HrKvYcFZ/iwO17nJ0FK93jcQg8xV3xFU9lxbjYG217zu
	 GXQ4cXEl3S2H816fYcy5ttylqo73wo7FEhlzhjQ3W0tlaxK3UAIU1UDqTQP/d+H0wG
	 Tsos0scL74Nsp1KE3UVJZ9l6+Pv3vB+Nr5ZCCo0K6wq2YeBPRYYo/nAjg4js+0NTzq
	 Vcg8tgWSPnxyXMqU1RxlKsjhKuUHtsO9Jo4TsuoaarrVl7GaI9EnN1v3GzmOMje7NT
	 omFjsaG3gpeomVc+AwRio2gvfIlkzNfDWbwffVyl7A8KUW6PqM6LSgGDOHDFC/YY8Z
	 CHOFZ66ClOwSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: call ksmbd_vfs_kern_path_end_removing() on some error paths
Date: Tue, 24 Feb 2026 21:24:47 -0500
Message-ID: <20260225022447.3806589-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022443-armchair-sleep-6f1f@gregkh>
References: <2026022443-armchair-sleep-6f1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219132-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE463190DEB
X-Rspamd-Action: no action

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit a09dc10d1353f0e92c21eae2a79af1c2b1ddcde8 ]

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
[ ksmbd_vfs_kern_path_end_removing() call -> ksmbd_vfs_kern_path_unlock() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2b16bd4882499..dfcc0cce8c407 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5693,14 +5693,14 @@ static int smb2_create_link(struct ksmbd_work *work,
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
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
+		if (rc)
+			goto out;
 	}
 	rc = ksmbd_vfs_link(work, target_name, link_name);
 	if (rc)
-- 
2.51.0


