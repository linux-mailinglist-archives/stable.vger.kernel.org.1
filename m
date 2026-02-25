Return-Path: <stable+bounces-219136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOfsD/VfnmmaUwQAu9opvQ
	(envelope-from <stable+bounces-219136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:35:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E515190F14
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734BF303FAC5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC329285066;
	Wed, 25 Feb 2026 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLRrtQb0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A252882DE
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986908; cv=none; b=ILb/oEARJwbGe/MsEe8tipE+rjRRdBQbTTe30t5exzEANWZ3IfkKjQ2kaqQohG0sHhZ/TaTtI21CyNh6BYZn/PUOVud6eMPmLgpO1XuYTjnZuwxW29eag676DFHvxT6rrRfHP71VqLPX6Hspu1Jvvf7TchcPNhBtTS1TUcYxh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986908; c=relaxed/simple;
	bh=wvuiYRA1NlJdK4dG2dQNUWhw45VMpO/4lhpuj53Prms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqWGKNVDmivFqChWEqhkIo0a9XSk+UoMjJA6x34vgZqGlpI1735REf04dCslIIYBFAfPfrRLsjieNrycNw4U1Iod5GFOSNZ4RPEyeLJG9pngG2KXkQLMwNLqL/uj9XQVI7ykXYafOJdsBVpkmQFuISbv+4Ee53KYbr/R1IB8/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLRrtQb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923B1C116D0;
	Wed, 25 Feb 2026 02:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771986908;
	bh=wvuiYRA1NlJdK4dG2dQNUWhw45VMpO/4lhpuj53Prms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLRrtQb0l8s0txthqCppGqEsqCsD01GdtfQjr/8r95G6BrrybSeFsp6oo1851nQb/
	 WsvmrtXCmNJRVlN+2wx+ncXHx9k4Uf52cw4YEUMPiJQvFcRc79t/UZjvXlshuoyVeq
	 htDTIfn7MuMrqTQxz5sPklP04RYUTZTzJhAOvWHGRksbBKRpCKlp52qDNkhGcVAfdx
	 6TAjTaASiyFmqi2UgwsGoXeW4zhZy1Zh0oF2Dw0aERFWguRGr2tiq4SV594TjbqDH8
	 L0w5em80V5PKaVQyDTR2Z0hAlIkrGCbhaf4QbLjX097oZ9Mcg+mGkViKJSZq/djCdF
	 y7ezzY7TsHkQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: call ksmbd_vfs_kern_path_end_removing() on some error paths
Date: Tue, 24 Feb 2026 21:35:05 -0500
Message-ID: <20260225023506.3815115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026022444-probiotic-subdivide-696f@gregkh>
References: <2026022444-probiotic-subdivide-696f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219136-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8E515190F14
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
 fs/ksmbd/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b5ff4c855f9cb..9e1d2095b1474 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5652,14 +5652,14 @@ static int smb2_create_link(struct ksmbd_work *work,
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


